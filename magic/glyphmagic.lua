--[[
Illarion Server

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
details.

You should have received a copy of the GNU Affero General Public License along
with this program.  If not, see <http://www.gnu.org/licenses/>.
]]
--- This script contains basics for glyph forging.
--
--  Author: Banduk

local common = require("base.common")
local glyphs = require("base.glyphs")
local magic = require("base.magic")
local shard = require("item.shard")
local globalvar = require("base.globalvar")
local triggerfield = require("triggerfield.base.triggerfield")
local areas = require("content.areas")

local M = {}

local SKILL_MISSING = 1
local SHARD_MISSING = 2
local IS_GLYPHED = 3
local CAN_FORGED = 4
--[[defined working time divided by WORKING_CYCLES_DIV created the number of displayed cycles
WORKING_CYCLE_S is the duration of the displayed cycle]]
local WORKING_CYCLE_S = 8
local WORKING_CYCLES_DIV = 16

local MAX_MANA = 10000

local CHARGE_LOWER_RANGE = 0.5 --relative to nominal charges
local CHARGE_RANGE = 1 --relative to nominal charges

local workingRitual = {}
-- workingCycles, deltaMana, deltaFood, workingForgePos, workingItem, workingResult
local RITUAL_GLYPHING = 1
local RITUAL_ERECT_FORGE = 2
local RITUAL_PREPARE_RITUAL = 3
local RITUAL_BREAK_GLYPH = 4

local ITEM_ID_CANDLES = 43
local ITEM_ID_CANDLEHOLDER = 399
local ITEM_ID_BURNING_CANDLE = 400

local QUEST_ID_EXAMINE_FORGE = 567

local workingGfx = {globalvar.gfxRAIN,globalvar.gfxSCOTTY,globalvar.gfxSPRINKLE,globalvar.gfxSPRINKLE,globalvar.gfxSPRINKLE}

local function endRitualAddGlyph(user, forgePos, item)
    local workingSkill = glyphs.SKILL_GLYPHING
    local workingTime
    local nominalCharges
    local charges
    if shard.removeShardsForItem(user,item) then
        world:gfx(globalvar.gfxSUN,forgePos)
        workingTime = glyphs.getWorkingTime(item)
        user:learn(workingSkill, workingTime, 100)
        nominalCharges = glyphs.getNominalCharges(item)

        local skillFactor = user:getSkill(workingSkill) / 100 * 0.25
        local attributeFactor = (magic.getBestMageAttribute(user) -10) / 10 * 0.25 --10 - 20
        local qualityFactor = (common.getItemQuality(item) -1 )/ 8 * 0.25
        local randomFactor = math.random() * 0.25
        charges = nominalCharges * CHARGE_LOWER_RANGE + nominalCharges * CHARGE_RANGE * (skillFactor + attributeFactor + qualityFactor + randomFactor)
        glyphs.setRemainingGlyphs(item, charges)
        common.InformNLS(user,"Du versiehst " .. common.getItemName(item, Player.german) .. " mit einer Glyphe.",
                              "You add a glyph to " .. common.getItemName(item, Player.english) .. ".")
    else
        common.HighInformNLS(user,"Glaubst du wirklich, du k�nntest die G�tter betr�gen?",
                                  "Do you really think, you can cheat the Gods?")
        --the player gave shards avay after checked if shards are in invertory while dialog was open, cheat, go to Cherga
        user:increaseAttrib("hitpoints",-10000)
    end
end

function M.checkForgeIsReady(forgeItem)
    local timeLimit = common.GetCurrentTimestamp() - glyphs.glyphRitualPrepareExposureTime
    local lastPrepared = tonumber(forgeItem:getData("lastPrepared"))
    if lastPrepared ~= nil and lastPrepared > timeLimit then
        return true
    end
    return false
end

local function endRitualErectForge(user, forgePos, unused)
    local workingSkill = glyphs.SKILL_GLYPHING
    local workingTime = glyphs.glyphForgeErectionTime
    world:gfx(globalvar.gfxSUN,forgePos)
    world:createItemFromId(glyphs.GLYPH_SHRINE_ID,1,forgePos,false,333,{craftedBy=user.name})
    user:learn(workingSkill, workingTime, 100)
end

local function endRitualPrepareRitual(user, forgePos, forgeItem)
    local workingSkill = glyphs.SKILL_GLYPHING
    local workingTime = glyphs.glyphRitualPrepareTime
    local candlePos
    local candleItem
    if not common.userHasItems(user,glyphs.glyphRitualPrepareNecessaryItems) then
        common.InformNLS(user,"Um das Ritual erfolgreich abzuschlie�en ben�tigst du zwei Kerzen und zwei Kerzenhalter.",
                              "To prepare the ritual sucessfully you need two candles and two small candlesticks.")
        world:gfx(globalvar.gfxFIZZLE,forgePos)
        return
    end
    for i=1,2 do
        candlePos = common.getFreePos(forgeItem.pos, 1)
        candleItem = world:createItemFromId(ITEM_ID_BURNING_CANDLE,1,candlePos,false,333,{belongsTo="ritual"})
        candleItem.wear = 2
        world:changeItem(candleItem)
        world:gfx(globalvar.gfxSUN,candlePos)
    end
    user:eraseItem(ITEM_ID_CANDLES,2)
    user:eraseItem(ITEM_ID_CANDLEHOLDER,2)
    forgeItem:setData("lastPrepared", common.GetCurrentTimestamp())
    world:changeItem(forgeItem)

    user:learn(workingSkill, workingTime, 100)
    common.InformNLS(user,"Der Ritualplatz ist vorbereitet. Jetzt k�nnen hier Rituale durchgef�hrt werden.",
                          "The glyph forge is prepared. Now it is possible to perform rituals here.")
end

local function endRitualBreakGlyph(user, forgePos, item)
    local workingSkill = glyphs.SKILL_GLYPHING
    local workingTime
    local materialBonus = 0

    world:gfx(globalvar.gfxSPLASH,forgePos)
    workingTime = glyphs.getWorkingTime(item) / glyphs.glyphRitualBreakTimePortion
    user:learn(workingSkill, workingTime, 100)

    local nominalCharges = glyphs.getNominalCharges(item)
    local maxCharges = nominalCharges * CHARGE_LOWER_RANGE + nominalCharges * CHARGE_RANGE
    local remainingCharges = glyphs.getRemainingGlyphs(item)
    local material = glyphs.getGlyphMaterial(item)
    if material == glyphs.COPPER then
        materialBonus = 2
    elseif material == glyphs.SILVER then
        materialBonus = 1
    end
    local skillBonus = math.max(0, - math.floor(user:getSkill(workingSkill) / 15) + 3)
    local returnedShards = math.random( math.floor(0.5 * remainingCharges / maxCharges * 7), math.floor(0.9 * remainingCharges / maxCharges * 7))
    returnedShards = math.min (7, returnedShards + materialBonus + skillBonus)
    local level = glyphs.getGlyphLevel(item)
    local isRing = glyphs.getGlyphRingOrAmulet(item)
    local shardList = {}
    for i=1,7 do
        if isRing == glyphs.RING then
            table.insert(shardList,level*10+i)
        else
            table.insert(shardList,i*10+level)
        end
    end
    common.Shuffle(shardList)
    if returnedShards > 0 then
        for i=1, returnedShards do
            shard.createShardWithLevelOnUser(user, shardList[i])
        end
        if returnedShards == 1 then
            common.InformNLS(user,"Du brichst die Glyphe aus dem " .. common.getItemName(item, Player.german) .. ". Es zerbricht und dir bleibt ein Glyphensplitter.",
                                  "You break the glyph of the " .. common.getItemName(item, Player.english) .. ". It breaks and one shard remains.")
        else
            common.InformNLS(user,"Du brichst die Glyphe aus dem " .. common.getItemName(item, Player.german) .. ". Es zerbricht und dir bleiben " .. tostring(returnedShards) .. " Glyphensplitter.",
                                  "You break the glyph of the " .. common.getItemName(item, Player.english) .. ". It breaks and " .. tostring(returnedShards) .. " shards remain.")
        end
    else
        common.InformNLS(user,"Du brichst die Glyphe aus dem " .. common.getItemName(item, Player.german) .. ". Es zerbricht und nichts bleibt zur�ck.",
                              "You break the glyph from " .. common.getItemName(item, Player.english) .. ". It breaks and nothing remains.")
    end
    world:erase(item,item.number)
end

local function performRitual(user)
    local workingCycles = workingRitual[user.id][1]
    local deltaMana = workingRitual[user.id][2]
    local deltaFood = workingRitual[user.id][3]
    local workingPlace = workingRitual[user.id][4]
    local ritualId = workingRitual[user.id][5]
    local specialValues = workingRitual[user.id][6]
    user:performAnimation(globalvar.charAnimationSPELL)
    if user:increaseAttrib("mana", deltaMana) < 1 then
        common.InformNLS(user,"Dein Mana reicht nicht aus, um das Ritual abzuschlie�en.","You don't have sufficient mana to finish the ritual.")
        world:gfx(globalvar.gfxFIZZLE,workingPlace)
        workingRitual[user.id]=nil
        return
    end
    common.GetHungry(user,deltaFood)
    magic.wandDegrade(user)
    if workingCycles > 0 then
        local playGfx = workingGfx[math.random(1,#workingGfx)]
        if playGfx ~= 0 then
            world:gfx(playGfx,workingPlace)
        end
        workingCycles = workingCycles - 1
        workingRitual[user.id][1] = workingCycles
        user:startAction(WORKING_CYCLE_S * 10,globalvar.gfxCLAW,20,0,0)
    else
        if ritualId == RITUAL_GLYPHING then
            endRitualAddGlyph(user, workingPlace, specialValues)
        elseif ritualId == RITUAL_ERECT_FORGE then
            endRitualErectForge(user, workingPlace, specialValues)
        elseif ritualId == RITUAL_PREPARE_RITUAL then
            endRitualPrepareRitual(user, workingPlace, specialValues)
        elseif ritualId == RITUAL_BREAK_GLYPH then
            endRitualBreakGlyph(user, workingPlace, specialValues)
        end
        workingRitual[user.id]=nil
    end
end

local function startRitual(user, workingTime, manaConsumption, workingPlace, ritualId, specialValues)
    manaConsumption = magic.getValueWithGemBonus(user, manaConsumption)
    local workingFood = magic.neededFood(user, workingTime)
    if not common.FitForHardWork(user, workingFood) then
        return false
    end
    local workingCycles = math.max(1, math.floor(workingTime/ WORKING_CYCLES_DIV))
    if not magic.hasSufficientMana(user,manaConsumption) then
        common.InformNLS(user,"Dein Mana wird voraussichtlich nicht ausreichen, das Ritual abzuschlie�en. Du wartest lieber noch etwas.",
                              "Most probabely you don't have sufficient mana to finish the ritual sucessfully. Better you wait a moment.")
        return false
    end
    local deltaMana = - math.floor(manaConsumption / workingCycles)
    local deltaFood = math.floor(workingFood / workingCycles)

    workingRitual[user.id]={workingCycles, deltaMana, deltaFood, workingPlace, ritualId, specialValues}

    performRitual(user)
    local timeText
    if workingTime < 45 then
        common.TempInformNLS(user,"Das Ritual wird nicht allzulange dauern.",
                                  "The ritual will take a few moments.")
    elseif workingTime < 100 then
        common.TempInformNLS(user,"Das Ritual wird einige Zeit in Anspruch nehmen.",
                                  "The ritual will take a while.")
    else
        common.TempInformNLS(user,"Das Ritual wird sehr lange deine ungeteilte Aufmerksamkeit beanspruchen.",
                                  "The ritual will take a your attention for a very long time.")
    end
    return true
end

local function startRitualGlyphToItem(user, item)
    local workingTime = glyphs.getWorkingTime(item)
    local manaConsumption = (40 - 20 * glyphs.getGlyphSkillLevel(item) / 100) * MAX_MANA / 100
    local workingPlace = common.GetFrontPosition(user)
    local ritualId = RITUAL_GLYPHING
    local specialValues = item

    if startRitual(user, workingTime, manaConsumption, workingPlace, ritualId, specialValues) then
        common.TempInformNLS(user,"Du beginnst ein Ritual um eine Glyphe in das Schmuckst�ck einzuarbeiten.",
                                  "You start a ritual to work a glyph into the jewelrey.")
    end
end

local function startRitualErectGlyphForge(user)
    local workingTime = glyphs.glyphForgeErectionTime
    local manaConsumption = (20 - 10 * user:getSkill(glyphs.SKILL_GLYPHING) / 100) * MAX_MANA / 100
    local workingPlace = common.GetFrontPosition(user)
    local ritualId = RITUAL_ERECT_FORGE
    local specialValues = nil

    if startRitual(user, workingTime, manaConsumption, workingPlace, ritualId, specialValues) then
        common.TempInformNLS(user,"Du beginnst ein Ritual um einen Glyphen Ritualplatz zu errichten.",
                                  "You start a ritual to erect a glyph ritual place.")
    end
end

local function startRitualPrepareGlyphRitual(user, forgeItem)
    local workingTime = glyphs.glyphRitualPrepareTime
    local manaConsumption = (40 - 20 * user:getSkill(glyphs.SKILL_GLYPHING) / 100) * MAX_MANA / 100
    local workingPlace = forgeItem.pos
    local ritualId = RITUAL_PREPARE_RITUAL
    local specialValues = forgeItem

    if startRitual(user, workingTime, manaConsumption, workingPlace, ritualId, specialValues) then
        common.TempInformNLS(user,"Du bereitest ein Ritual an einem einen Glyphen Ritualplatz vor.",
                                  "You prepare a ritual at a glyph ritual place.")
    end
end

local function startRitualBreakGlyph(user, item)
    local workingTime = glyphs.getWorkingTime(item) * glyphs.glyphRitualBreakManaPortion
    local manaConsumption = (40 - 20 * glyphs.getGlyphSkillLevel(item) / 100) * MAX_MANA / 100 * glyphs.glyphRitualBreakManaPortion
    local workingPlace = common.GetFrontPosition(user)
    local ritualId = RITUAL_BREAK_GLYPH
    local specialValues = item

    if startRitual(user, workingTime, manaConsumption, workingPlace, ritualId, specialValues) then
        common.TempInformNLS(user,"Du beginnst ein Ritual um eine Glyphe aufzubrechen.",
                                  "You start a ritual to break a glyph.")
    end
end

local function countShardOnUser(user,level,ringOrAmulet)
    local shardLevel
    local countShards = 0
    for i=1, 7 do
        if ringOrAmulet == glyphs.RING then
            shardLevel = tonumber(level)*10+i
        else
            shardLevel = i*10+tonumber(level)
        end
        if shard.shardInInvertory(user,shardLevel) ~= nil then
            countShards = countShards + 1
        end
    end
    return countShards
end


local function showShardStateDetail(user,ringOrAmulet,level)
    local shardLevel
    local displayText
    local cbSetMode = function (dialog)
        if (not dialog:getSuccess()) then
            return
        end
        local index = dialog:getSelectedIndex() + 1
        return
        -- return in every case
    end
    local windowText
    if ringOrAmulet == glyphs.RING then
        windowText = common.GetNLS(user,"Verf�gbare Splitter f�r " .. glyphs.orderOfGem[level][1] .. " Ringe:",
                                        "Available shards for " .. glyphs.orderOfGem[level][2] .. " rings:", cbSetMode)
    else
        windowText = common.GetNLS(user,"Verf�gbare Splitter f�r " .. glyphs.orderOfGem[level][1] .. " Amulette:",
                                        "Available shards for " .. glyphs.orderOfGem[level][2] .. " amulets:", cbSetMode)
    end
    local commentText = common.GetNLS(user,"Ringe oder Amulette k�nnen nur dann mit Glyphen versehen werden, wenn alle Splitter vorhanden sind.",
                                           "Rings and amulets can get a glyph if all shards are available.")
    local sd = SelectionDialog(windowText, commentText, cbSetMode)
    for i=1, 7 do
        if ringOrAmulet == glyphs.RING then
            shardLevel = level*10+i
        else
            shardLevel = i*10+level
        end
        if shard.shardInInvertory(user,shardLevel) ~= nil then
            displayText = common.GetNLS(user," (verf�gbar)", " (available)")..tostring(shardLevel)
        else
            displayText = common.GetNLS(user," (fehlt)", " (missing)")..tostring(shardLevel)
        end
        displayText = glyphs.getShardNameFromLevel(shardLevel) .. displayText
        sd:addOption(glyphs.getShardId(shardLevel), displayText )
    end
    sd:setCloseOnMove()
    user:requestSelectionDialog(sd)
end

function M.showShardState(user)
    local countShards
    local shardLevel
    local displayText
    local cbSetMode = function (dialog)
        if (not dialog:getSuccess()) then
            return
        end
        local index = dialog:getSelectedIndex() + 1
        if index <= 7 then
            showShardStateDetail(user,glyphs.RING,index)
        else
            showShardStateDetail(user,glyphs.AMULET,index-7)
        end
    end
    local windowText = common.GetNLS(user,"Verf�gbare Splitter", "Available shards")
    local commentText = ""
    local sd = SelectionDialog(windowText, commentText, cbSetMode)
    for i=1, 7 do
        countShards = countShardOnUser(user,i,glyphs.RING)
        if countShards == 7 then
            displayText = common.GetNLS(user,"Vollst�ndiger Satz!", "Complete set!")
        else
            displayText = tostring(7 - countShards) .. common.GetNLS(user," Splitter fehlen!", " missing shards!")
        end
        displayText = common.GetNLS(user,glyphs.orderOfGem[i][1] .. " Ringe: ",glyphs.orderOfGem[i][2] .. " rings: ") ..
                       tostring(countShards) .. common.GetNLS(user," Splitter (", " shards (") ..
                       displayText .. ")"
        sd:addOption(glyphs.ringAndAmuletDefinition[7 + i][1], displayText )
    end
    for i=1, 7 do
        countShards = countShardOnUser(user,i,glyphs.AMULET)
        if countShards == 7 then
            displayText = common.GetNLS(user,"Vollst�diger Satz!", "Complete set!")
        else
            displayText = tostring(7 - countShards) .. common.GetNLS(user," Splitter fehlen!", " missing shards!")
        end
        displayText = common.GetNLS(user,glyphs.orderOfGem[i][1] .. " Amulette: ",glyphs.orderOfGem[i][2] .. " amulets: ") ..
                       tostring(countShards) .. common.GetNLS(user," Splitter (", " shards (") ..
                       displayText .. ")"
        sd:addOption(glyphs.ringAndAmuletDefinition[7 + i][2], displayText )
    end
    sd:setCloseOnMove()
    user:requestSelectionDialog(sd)
end

local function showForgeSelection(user,userRings,userAmulets)
    local displayText
    local canForged
    local countShards
    local selectionTopics = {}
    local selectionTopicNo = 0

    local cbSetMode = function (dialog)
        if (not dialog:getSuccess()) then
            return
        end
        local index = dialog:getSelectedIndex() + 1
        if selectionTopics[index][1] == SHARD_MISSING then
            showShardStateDetail(user,glyphs.getGlyphRingOrAmulet(selectionTopics[index][2]),glyphs.getGlyphLevel(selectionTopics[index][2]))
        elseif selectionTopics[index][1] == IS_GLYPHED then
            common.InformNLS(user,"Das Item "..common.getItemName(selectionTopics[index][2], Player.german) .. " kann keine zweite Glyphe aufnehmen.",
                                  "The item "..common.getItemName(selectionTopics[index][2], Player.english) .. " cannot take a second glyph.")
        elseif selectionTopics[index][1] == SKILL_MISSING then
            common.InformNLS(user,"Deine F�higkeiten reichen nicht aus um "..common.getItemName(selectionTopics[index][2], Player.german) .. " mit einer Glyphe zu versehen.",
                                  "Your skill is not sufficien to add a glyph to "..common.getItemName(selectionTopics[index][2], Player.english) .. ".")
        else
            startRitualGlyphToItem(user,selectionTopics[index][2])
        end
    end
    local windowText = common.GetNLS(user,"Ringe und Amulette", "Rings and amulets")
    local commentText = common.GetNLS(user,"W�hle ein Item aus, das alle Voraussetzungen erf�llt, um mit einer Glyphe versehen zu werden.",
                                           "Please select an item that should get a glyph.\nAll preconditions must be fulfilled")
    local sd = SelectionDialog(windowText, commentText, cbSetMode)
    if #userRings > 0 then
        for i=1,#userRings do
            countShards = countShardOnUser(user,glyphs.getGlyphLevel(userRings[i]),glyphs.RING)
            if user:getSkill(glyphs.SKILL_GLYPHING) < glyphs.getGlyphSkillLevel(userRings[i]) then
                displayText = common.GetNLS(user," (Skill nicht ausreichend)"," (Skill not sufficient)")
                canForged = SKILL_MISSING
            elseif glyphs.isGlyphed(userRings[i]) then
                displayText = common.GetNLS(user," (Glyphe bereits eingearbeitet)"," (Glyph forged in already)")
                canForged = IS_GLYPHED
            elseif countShards == 6 then
                displayText = common.GetNLS(user," (1 Splitter fehlt)", " (1 shard missing)")
                canForged = SHARD_MISSING
            elseif countShards < 6 then
                displayText = common.GetNLS(user," (" .. tostring(7-countShards) .. " Splitter fehlen)",
                                                 " (" .. tostring(7-countShards) .. " shards missing)")
                canForged = SHARD_MISSING
            else
                displayText = common.GetNLS(user," (Bearbeitbar)"," (Forgeable)")
                canForged = CAN_FORGED
            end
            sd:addOption(userRings[i].id, common.GetNLS(user,common.getItemName(userRings[i], Player.german),common.getItemName(userRings[i], Player.english)) .. displayText )
            selectionTopicNo = selectionTopicNo + 1
            selectionTopics[selectionTopicNo] = {canForged, userRings[i]}
        end
    end
    if #userAmulets > 0 then
        for i=1,#userAmulets do
            countShards = countShardOnUser(user,glyphs.getGlyphLevel(userAmulets[i]),glyphs.AMULET)
            if user:getSkill(glyphs.SKILL_GLYPHING) < glyphs.getGlyphSkillLevel(userAmulets[i]) then
                displayText = common.GetNLS(user," (Skill nicht ausreichend)"," (Skill not sufficient)")
                canForged = SKILL_MISSING
            elseif glyphs.isGlyphed(userAmulets[i]) then
                displayText = common.GetNLS(user," (Glyphe eingearbeitet)"," (Glyph forged in)")
                canForged = IS_GLYPHED
            elseif countShards == 6 then
                displayText = common.GetNLS(user," (1 Splitter fehlt)", " (1 shard missing)")
                canForged = SHARD_MISSING
            elseif countShards < 6 then
                displayText = common.GetNLS(user," (" .. tostring(7-countShards) .. " Splitter fehlen)",
                                                 " (" .. tostring(7-countShards) .. " shards missing)")
                canForged = SHARD_MISSING
            else
                displayText = common.GetNLS(user," (Bearbeitbar)"," (Forgeable)")
                canForged = CAN_FORGED
            end
            sd:addOption(userAmulets[i].id, common.GetNLS(user,common.getItemName(userAmulets[i], Player.german),common.getItemName(userAmulets[i], Player.english)) .. displayText )
            selectionTopicNo = selectionTopicNo + 1
            selectionTopics[selectionTopicNo] = {canForged, userAmulets[i]}
        end
    end
    sd:setCloseOnMove()
    user:requestSelectionDialog(sd)

end

local function showBreakSelection(user,userRings,userAmulets)
    local displayText
    local canBreak
    local selectionTopics = {}
    local selectionTopicNo = 0

    local cbSetMode = function (dialog)
        if (not dialog:getSuccess()) then
            return
        end
        local index = dialog:getSelectedIndex() + 1
        if selectionTopics[index][1] == CAN_FORGED then
            common.InformNLS(user,"Das Item "..common.getItemName(selectionTopics[index][2], Player.german) .. " beinhaltet noch keine Glyphe.",
                                  "The item "..common.getItemName(selectionTopics[index][2], Player.english) .. " doesn't have a glyph.")
        elseif selectionTopics[index][1] == SKILL_MISSING then
            common.InformNLS(user,"Deine F�higkeiten reichen nicht aus um "..common.getItemName(selectionTopics[index][2], Player.german) .. " zu zerst�ren.",
                                  "Your skill is not sufficien to destroy "..common.getItemName(selectionTopics[index][2], Player.english) .. ".")
        else
            startRitualBreakGlyph(user,selectionTopics[index][2])
        end
    end
    local windowText = common.GetNLS(user,"Ringe und Amulette", "Rings and amulets")
    local commentText = common.GetNLS(user,"W�hle ein Item aus, das du zerst�ren willst um einige der Splitter wiederzubekommen.",
                                           "Please select an item that has to be destoyed to get back some of the shards.")
    local sd = SelectionDialog(windowText, commentText, cbSetMode)
    if #userRings > 0 then
        for i=1,#userRings do
            if user:getSkill(glyphs.SKILL_GLYPHING) - glyphs.glyphRitualBreakGlyphSkill < glyphs.getGlyphSkillLevel(userRings[i]) then
                displayText = common.GetNLS(user," (Skill nicht ausreichend)"," (Skill not sufficient)")
                canBreak = SKILL_MISSING
            elseif glyphs.isGlyphed(userRings[i]) then
                displayText = common.GetNLS(user," (Glyphe zerst�rbar)"," (Glyph can be destroyed)")
                canBreak = IS_GLYPHED
            else
                displayText = common.GetNLS(user," (Keine Glyphe eingearbeitet)"," (Contains no glyph)")
                canBreak = CAN_FORGED
            end
            sd:addOption(userRings[i].id, common.GetNLS(user,common.getItemName(userRings[i], Player.german),common.getItemName(userRings[i], Player.english)) .. displayText )
            selectionTopicNo = selectionTopicNo + 1
            selectionTopics[selectionTopicNo] = {canBreak, userRings[i]}
        end
    end
    if #userAmulets > 0 then
        for i=1,#userAmulets do
            if user:getSkill(glyphs.SKILL_GLYPHING) - glyphs.glyphRitualBreakGlyphSkill < glyphs.getGlyphSkillLevel(userAmulets[i]) then
                displayText = common.GetNLS(user," (Skill nicht ausreichend)"," (Skill not sufficient)")
                canBreak = SKILL_MISSING
            elseif glyphs.isGlyphed(userAmulets[i]) then
                displayText = common.GetNLS(user," (Glyphe zerst�rbar)"," (Glyph can be destroyed)")
                canBreak = IS_GLYPHED
            else
                displayText = common.GetNLS(user," (Keine Glyphe eingearbeitet)"," (Contains no glyph)")
                canBreak = CAN_FORGED
            end
            sd:addOption(userAmulets[i].id, common.GetNLS(user,common.getItemName(userAmulets[i], Player.german),common.getItemName(userAmulets[i], Player.english)) .. displayText )
            selectionTopicNo = selectionTopicNo + 1
            selectionTopics[selectionTopicNo] = {canBreak, glyphs.AMULET, userAmulets[i]}
        end
    end
    sd:setCloseOnMove()
    user:requestSelectionDialog(sd)

end

function M.forgeGlyphs(user,glyphForgeItem,ltstate)
    if user:getMagicType() == 0 then --mage
        if ltstate == Action.none then
            if glyphForgeItem.wear < 3 then
                common.TempInformNLS(user,"Dieser Glyphen Ritualplatz zeigt schon deutliche Zeichen eines Verfalls. Vergeude deine Zeit nicht hier.",
                                          "This glyph ritual place is almost decayed. Don't waste your time at this location.")
                return
            end
            if not M.checkForgeIsReady(glyphForgeItem) then
                common.InformNLS(user,"Hier ist noch nichts vorbereitet. Vielleicht solltest du damit beginnen.",
                                      "Nothing is prepared. You should arrange everything for a sucessful ritual.")
                return
            end
            local userRings = glyphs.hasRing(user)
            local userAmulets = glyphs.hasAmulet(user)
            common.TurnTo(user,glyphForgeItem.pos)
            if #userRings == 0 and #userAmulets == 0 then
                common.InformNLS(user,"Du hast keinen Ring und kein Amulett. Nimm das Item, das du glyphen willst in die Hand oder in den G�rtel.",
                                      "You don't have a ring or amulet. The item you want to glyph has to be in your hand or in the belt.")
                M.showShardState(user)
            else
                showForgeSelection(user,userRings,userAmulets)
            end
        elseif ltstate == Action.success then
            performRitual(user)
        elseif ltstate == Action.abort then
            common.InformNLS(user,"Du brichst das Ritual ab.","Your interrupt the ritual.")
            world:gfx(globalvar.gfxFIZZLE,user.pos)
            workingRitual[user.id]=nil
        end
    else
        common.TempInformNLS(user,"Dieser Ritualplatz ist voll mit Symbolen, die dir nichts sagen. Du entschlie�t dich hier nichts zu ver�ndern und z�hlst die Splitter in deiner Tasche.",
                                  "This ritual place is covered in unknown symbols. You decide nothing to do except to count the shards in your bag.")
        M.showShardState(user)
    end
end

function M.breakGlyphs(user,glyphForgeItem,ltstate)
    if ltstate == Action.none then
        if glyphForgeItem.wear < 3 then
            common.TempInformNLS(user,"Dieser Glyphen Ritualplatz zeigt schon deutliche Zeichen eines Verfalls. Vergeude deine Zeit nicht hier.",
                                      "This glyph ritual place is almost decayed. Don't waste your time at this location.")
            return
        end
        if not M.checkForgeIsReady(glyphForgeItem) then
            common.InformNLS(user,"Hier ist noch nichts vorbereitet. Vielleicht solltest du damit beginnen.",
                                  "Nothing is prepared. You should arrange everything for a sucessful ritual.")
            return
        end
        local userRings = glyphs.hasRing(user)
        local userAmulets = glyphs.hasAmulet(user)
        common.TurnTo(user,glyphForgeItem.pos)
        if #userRings == 0 and #userAmulets == 0 then
            common.InformNLS(user,"Du hast keinen Ring und kein Amulett. Nimm das Item, das du zerst�ren willst in die Hand oder in den G�rtel.",
                                  "You don't have a ring or amulet. The item you want to destroy has to be in your hand or in the belt.")
        else
            showBreakSelection(user,userRings,userAmulets)
        end
    elseif ltstate == Action.success then
        performRitual(user)
    elseif ltstate == Action.abort then
        common.InformNLS(user,"Du brichst das Ritual ab.","Your interrupt the ritual.")
        world:gfx(globalvar.gfxFIZZLE,user.pos)
        workingRitual[user.id]=nil
    end
end

local function isPossibleLocation(user, position)
    local permittedTiles = {common.GroundType.forest, common.GroundType.sand, common.GroundType.grass}
    local freeViewAxis = {{2,-2,0},{1,-1,0},{0,0,0},{-1,1,0},{-2,2,0}}
    -- Exclude triggerfields
    if triggerfield.isTriggerfield(position) then
        common.TempInformNLS(user,"Die Magie dieses Ortes verindert das Aufstellen des Ritualplatzes.",
                                  "The magic of this location prevents you from erecting the ritual place.")
        return false
    end

    local theField = world:getField(position)
    if not common.isInList(common.GetGroundType(theField:tile()),permittedTiles) then
        common.TempInformNLS(user,"Dieser Boden eignet sich nicht f�r das Aufstellen des Ritualplatzes.",
                                  "This ground is not good to erect the ritual place.")
        return false
    end

    -- Empty field
    if theField:countItems() > 0 then
        common.TempInformNLS(user,"Hier m�sstest du erst mal was wegr�umen. Das ist mit Arbeit verbunden. Deshalb schaust du dich nach einem besseren Platz um.",
                                  "You have to tide up that place first. Since you had to work for you better look fo a better location.")
        return false
    end

    -- Access and no blocking items in view axis
    if common.getNumberOfPassableFieldsInArea(user.pos, 1) < 9 or common.getNumberOfPassableFieldsFromList(position, freeViewAxis) < #freeViewAxis then
        common.InformNLS(user,"Hier ist es zu eng um sp�ter das Ritual auszuf�hren. Du schaust dich besser nach einem besseren Platz um.",
                              "You don't have enough space around yourself to perform the ritual at this location. You better look for another place.")
        return false
    end

    -- Permission denied
    local deniedAreas = {"Runewick","Cadomyr","Galmair"}
    for i=1, #deniedAreas do
        if areas.PointInArea(user.pos, deniedAreas[i]) then
            common.InformNLS(user,"In den St�dten sind keine Glyphen Ritualpl�tze erw�nscht.",
                                  "No glyph ritual places are desired in the cities.")
            return false
        end
    end

    -- not level 0
    if user.pos.z ~= 0 then
        common.InformNLS(user,"Nur die G�tter wissen was an diesem Platz nicht stimmt. Probier es doch auf der Oberfl�che Illarions.",
                              "Only the Gods know what's wrong here. Better you try on Illarions surface.")
        return false
    end

    return true
end

function M.findGlyphForge(user)
    user:performAnimation(globalvar.charAnimationSPELL)
    local forgeItem, bool = common.GetItemInArea(user.pos, glyphs.GLYPH_SHRINE_ID, 40, true)
    if forgeItem ~= nil then
        world:gfx(globalvar.gfxSUN,forgeItem.pos)
        local directionInfo = common.getDistanceHint(user, forgeItem.pos)
        local textDirection = common.GetNLS(user,"M�glicherweise befindet sich " .. directionInfo.distance.de .. " im " .. directionInfo.direction.de .. " ein Ritualplatz.",
                                                 "There might be " .. directionInfo.distance.en .. " in the " .. directionInfo.direction.en .. " a ritual place.")

        if user:getQuestProgress(562) == 0 and user:getSkill(glyphs.SKILL_GLYPHING) <= glyphs.glyphForgeFindMaxSkill then
            local nextLearn = math.random(1,2)
            user:setQuestProgress(562,nextLearn)
            user:learn(glyphs.SKILL_GLYPHING, glyphs.glyphForgeFindTime, 100)
            common.InformNLS(user,textDirection .. " Seine Magie zieht dich an und doch kannst du dich f�r einen Moment nicht bewegen.",
                                  textDirection .. " It's magic attracts you but you cannot move for a few seconds.")
            common.ParalyseCharacter(user, glyphs.glyphForgeFindTime)
        else
            common.TempInformNLS(user,textDirection .. " Vielleicht kannst du ihn bereits sehen?",
                                      textDirection .. " Maybe you can see it already?")
        end
        return true
    end
    return false
end

function M.examineGlyphForge(user, glyphForge)
    if glyphForge.wear < 3 then
        common.InformNLS(user, "Die Steine br�ckeln. Die Magie des Ortes scheint fast v�llig verschwunden.",
                               "The stones crumble. The magic of the place has almost disappeared.")
    elseif M.checkForgeIsReady(glyphForge) then
        common.InformNLS(user, "Das Ritual ist bereits vorbereitet. You kannst gleich beginnen.",
                               "A ritual is already prepared. You can start right now.")
    else
        local posNumber = common.positionToNumber(glyphForge.pos)
        if posNumber == user:getQuestProgress(QUEST_ID_EXAMINE_FORGE) then
            common.InformNLS(user,"An diesem Glyphen Ritualplatz sich nichts ge�ndert.",
                                  "Nothing changed at this glyph ritual place.")
        else
            user:setQuestProgress(QUEST_ID_EXAMINE_FORGE, posNumber)
            local checkLimit = user:getBaseAttribute("perception") / 30.0 + 0.2
            if checkLimit > math.random() then
                common.InformNLS(user,"Du glaubst zu erkennen, dass dieser Glyphen Ritualplatz von " .. glyphForge:getData("craftedBy") .. " errichtet wurde.",
                                      "You see hints this glyph ritual place might had been errected by " .. glyphForge:getData("craftedBy") .. ".")
            else
                common.InformNLS(user,"Das ist ein Glyphen Ritualplatz wie du schon viele gesehen hast. Wer ihn errichtet hat, erschlie�t sich dir nicht.",
                                      "This is a glyph ritual place as you have already seen many. Who built it, does not open to you.")
            end
        end
    end
end

function M.placeGlyphForge(user, ltstate)
    if ltstate == Action.none then
        if M.findGlyphForge(user) then
            return
        end
        local position = common.GetFrontPosition(user)
        if  user:getSkill(glyphs.SKILL_GLYPHING) < glyphs.glyphForgeErectionMinSkill then
            common.InformNLS(user,"Deine F�higkeiten reichen nicht aus das Ritual durchzuf�hren.",
                                  "Your skills are not sufficient to perform the ritual.")
            return
        end
        if isPossibleLocation(user, position) then
            startRitualErectGlyphForge(user)
        end
    elseif ltstate == Action.success then
        performRitual(user)
    elseif ltstate == Action.abort then
        common.InformNLS(user,"Du brichst das Ritual ab.","You interrupt the ritual.")
        world:gfx(globalvar.gfxFIZZLE,user.pos)
        workingRitual[user.id]=nil
    end
end

function M.prepareGlyphRitual(user, ltstate)
--Banduk
    if ltstate == Action.none then
        local forgeItem, bool = common.GetItemInArea(user.pos, glyphs.GLYPH_SHRINE_ID, 1, true)
        if forgeItem == nil then
            M.findGlyphForge(user)
            return
        end
        common.TurnTo(user, forgeItem.pos )
        if forgeItem.wear < 3 then
            common.TempInformNLS(user,"Dieser Glyphen Ritualplatz zeigt schon deutliche Zeichen eines Verfalls. Vergeude deine Zeit nicht hier.",
                                      "This glyph ritual place is almost decayed. Don't waste your time at this location.")
            return
        end
        if M.checkForgeIsReady(forgeItem) then
            common.InformNLS(user,"Hier ist bereits alles vorbereitet. Du kannst nichts mehr tun.",
                                  "Everything is prepared already. There is nothing left to do.")
            return
        end
        if not common.userHasItems(user,glyphs.glyphRitualPrepareNecessaryItems) then
            common.InformNLS(user,"Um das Ritual vorzubereiten ben�tigst du zwei Kerzen und zwei Kerzenhalter.",
                                  "To prepare the ritual you need two candles and two small candlesticks.")
            return
        end
        local position = common.GetFrontPosition(user)
        if  user:getSkill(glyphs.SKILL_GLYPHING) >= glyphs.glyphRitualPrepareMinSkill then
            startRitualPrepareGlyphRitual(user, forgeItem)
        else
            common.InformNLS(user,"Deine F�higkeiten reichen nicht aus das Ritual durchzuf�hren.",
                                  "Your skills are not sufficient to perform the ritual.")
            return
        end
    elseif ltstate == Action.success then
        performRitual(user)
    elseif ltstate == Action.abort then
        common.InformNLS(user,"Du brichst das Ritual ab.","You interrupt the ritual.")
        world:gfx(globalvar.gfxFIZZLE,user.pos)
        workingRitual[user.id]=nil
    end
end

function M.removeGlyphForge(user)
    -- returns false if no glyph forge
    local position = common.GetFrontPosition(user)
    local forgeItem = common.GetFrontItem(user,user:getFaceTo())
    if forgeItem ~= nil and forgeItem.id == glyphs.GLYPH_SHRINE_ID then
        local userSkill = user:getSkill(Character.mining)
        local limitSkill --wear 3=0, 43=100 max wear=50
        if forgeItem.wear < 3 then
            limitSkill = 0
        else
            limitSkill = math.floor((forgeItem.wear - 3) * 100 / 40)
        end
        if userSkill > limitSkill then
            local playerInSight = world:getPlayersInRangeOf(forgeItem.pos,1)
            if #playerInSight > 1 then
                common.InformNLS(user,"Du h�ltst inne, weil noch jemand neben dem Glyphen Ritualplatz steht.",
                                      "You stop since somebody else stands next to the glyph ritual place.")
            else
                if user:getQuestProgress(562) == 0 then
                    world:gfx(globalvar.gfxFALL,forgeItem.pos)
                    user:setQuestProgress(562, forgeItem.wear)
                    world:erase(forgeItem, 1)
                else
                    common.InformNLS(user,"Kann es sein, dass du erst k�rzlich einen Glyphen Ritualplatz beseitigt hast?",
                                          "Could it be that you destroyed a glyph ritual place alredy recently?")
                    world:gfx(globalvar.gfxFLAMESTRIKE,user.pos)
                end
                if user:increaseAttrib("hitpoints", 0) >2000 then
                    user:increaseAttrib("hitpoints", -300)
                end
            end
        else
            common.InformNLS(user,"Die Magie des Ortes l�sst die Spitzhacke zur�ckspringen. Vielleicht gelingt es dir den Glyphen Ritualplatz zu beseitigen, wenn du noch etwas wartest.",
                                  "Your pickaxe recoils due to the magic of that location. You may have success if you wait some time.")
        end
        return true
    else
        return false
    end
end

return M
