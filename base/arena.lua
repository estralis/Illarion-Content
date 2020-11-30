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
--[[
Script for the arena managers. Purpose: money sink, fame and glory

Players can buy monsters to fight against. Depending on the monster strength, the price rises.
For every defeated monster the player gets points (corresponding to the monsters strength).
Monsters drop no loot. It is all only for the sake of fame and glory.

The arena manager holds a list of the top ten players. Players from other factions can fight too, to
piss the other faction off.

author: Lillian

]]
local money = require("base.money")
local ranklist = require("base.ranklist")
local common = require("base.common")

local M = {}

--[[
Level 1: Annoying monsters award 1 point
Level 2: Very easy monsters for noobs award 2 points
Level 3: Easy monsters award 3 points
Level 4: Semistrong monsters award 4 points
Level 5: Strong monster award 6 points
Level 6: Really strong monsters award 8 points
Level 7: Monsters for really, really good fighters 'heroes' award 13 points
Level 8: Monsters for group fights award 18 points
Level 9: Unbelieavable strong monsters for 'groups' award 21 points
]]
M.monsterIDsByLevel = {
    {monsters = {982, 271, 1051, 582, 623}, points = 1, price=4000},
    {monsters = {101, 196, 273, 602, 881}, points = 2, price= 7800},
    {monsters = {394, 551, 882, 984}, points = 3, price=11000},
    {monsters = {141, 515, 552, 791, 872}, points = 4, price=14000},
    {monsters = {191, 514, 531, 402, 851}, points = 6, price=19200},
    {monsters = {121, 201, 513, 525, 852}, points = 8, price=23200},
    {monsters = {534, 124, 562, 634, 853}, points = 13, price=35100},
    {monsters = {125, 564, 262, 637}, points = 18, price=43200},
    {monsters = {302, 632, 563}, points = 23, price=46000}
}

M.arenaInformation = {{playerPos=nil, monsterPos=position(255,668,0), newPlayerPos=nil, npcName="Dale Daeon", town="Cadomyr", quest=801},
                    {playerPos=nil, monsterPos=position(995,784,-3), newPlayerPos=nil, npcName="Manuel Salan", town="Runewick", quest=802},
                    {playerPos=nil, monsterPos=position(338,193,-7), newPlayerPos=nil, npcName="Angelo Rothman", town="Galmair", quest=803}}

--Sorts a table deceanding by the value of every second entry
local function sortTable(inputTable)
    local numberTable = {}
    local sortedTable = {}
    for i=2, #(inputTable), 2 do
        table.insert(numberTable, inputTable[i])
    end
    table.sort(numberTable)
    for i= 1, #(numberTable) do
        for j=2, #(inputTable), 2 do
            if inputTable[j] == numberTable[i] then
                table.insert(sortedTable, 1, inputTable[j])
                table.insert(sortedTable, 1, inputTable[j-1])
            end
        end
    end
    return sortedTable
end

local function checkLte(User,NPC)

    local foundEffect = User.effects:find(18)
    if foundEffect then
        NPC:talk(Character.say,"Besiegt erstmal die erste Kreatur, bevor ihr eine zweite verlangt!","Finish the first creature before you demand a second one!")
        return false
    end
    return true
end

local function payforMonster(User, MonsterLevel, NPC)
    local priceInCP = M.monsterIDsByLevel[MonsterLevel].price
    local germanMoney, englishMoney = money.MoneyToString(priceInCP)

    if not money.CharHasMoney(User,priceInCP) then --not enough money!
    local outText = common.GetNLS(User, "Du hast nicht genug Geld dabei! Du ben�tigst "..germanMoney..".", "You don't have enough money with you! You'll need "..englishMoney..".")
    NPC:talk(Character.say, outText)
    return false
    end
    money.TakeMoneyFromChar(User,priceInCP) --take money
    User:inform("Du hast dir ein Monster f�r "..germanMoney.." gekauft. Viel Erfolg!", "You bought a monster at the price of "..englishMoney..". Good luck!")
    return true
end

local function getRandomMonster(level)
    local randomNumber = math.random(1, #M.monsterIDsByLevel[level].monsters)
    return M.monsterIDsByLevel[level].monsters[randomNumber]
end

local function isUserInList(User, ranklist)
    for i=1, #(ranklist), 2 do
        if ranklist[i] == User.name then
            return true, i
        end
    end
    return false, 0
end

function M.requestMonster(User, NPC)
    local cbChooseLevel = function(dialog)
        if (not dialog:getSuccess()) then
            return
        end

        local index = dialog:getSelectedIndex() + 1
        local arena = M.getArena(User, NPC)
        local paid = payforMonster(User, index, NPC)

        if paid then
            if M.arenaInformation[arena].playerPos ~= nil then
                User:warp(M.arenaInformation[arena].playerPos)
            end
            --add the effect to keep track of the monster
            local arenaEffect = LongTimeEffect(18,1)
            arenaEffect:addValue("arenaID",arena)
            arenaEffect:addValue("level",index)
            if isValidChar(User) then
                User.effects:addEffect(arenaEffect)
            end
        else
            return
        end
    end

    if not checkLte(User,NPC) then
        return
    end

    local dialogCaption = common.GetNLS(User, "Monsterst�rke", "Monster strength")
    local dialogText = common.GetNLS(User, "W�hle wie stark das Monster sein soll, gegen das du k�mpfen m�chtet:", "Please choose how strong the monster you wish to fight against should be:")

    local sdMonster = SelectionDialog(dialogCaption, dialogText, cbChooseLevel)
    sdMonster:setCloseOnMove()
    for i = 1, #(M.monsterIDsByLevel) do
        local priceInCP = M.monsterIDsByLevel[i].price
        local germanMoney, englishMoney = money.MoneyToString(priceInCP)
        local option = common.GetNLS(User, "St�rke "..i.." Monster ("..M.monsterIDsByLevel[i].points.." Punkte)\n Preis: "..germanMoney, "Level "..i.." Monster ("..M.monsterIDsByLevel[i].points.." points)\n Price: "..englishMoney)
        sdMonster:addOption(61, option)
    end
    User:requestSelectionDialog(sdMonster)
end

local arenaMonster = {}
local arenaMonsterByMonsterId = {}

function M.spawnMonster(User, MonsterLevel, arena)
    if not arenaMonster[User.id] then
        arenaMonster[User.id] = {}
    end

    local monster
    world:gfx(31,M.arenaInformation[arena].monsterPos)
    monster = world:createMonster(getRandomMonster(MonsterLevel),M.arenaInformation[arena].monsterPos,0)
    if isValidChar(monster) then
        table.insert( arenaMonster[User.id], monster )

        if not arenaMonsterByMonsterId[monster.id] then
            arenaMonsterByMonsterId[monster.id] = {}
        end
        table.insert( arenaMonsterByMonsterId[monster.id], true )
    end
end

function M.isArenaMonster(monster)
    if arenaMonsterByMonsterId[monster.id] ~= nil then
        return arenaMonsterByMonsterId[monster.id][1]
    end
    return nil
end

function M.checkMonster(User)
    if not arenaMonster[User.id] then
        return true
    end

    for i,monster in pairs(arenaMonster[User.id]) do
        if isValidChar(monster) then
            if monster:increaseAttrib("hitpoints",0) > 0 then
                return false
            end
        end
    end
    arenaMonster[User.id] = nil
    return true
end

function M.killMonster(User)
    if not arenaMonster[User.id] then
        return true
    end

    for i,monster in pairs(arenaMonster[User.id]) do
        if isValidChar(monster) then
            if monster:increaseAttrib("hitpoints",0) > 0 then
                monster:increaseAttrib("hitpoints",-10000)
            end
        end
    end
    arenaMonster[User.id] = nil

    return true
end

function M.getArena(User, NPC)
    for i=1, #(M.arenaInformation) do
        if M.arenaInformation[i].npcName == NPC.name then
            return i
        end
    end
    return ""
end

-- Returns the points of a present arena, which the player has earned so far
function M.getArenastats(User, NPC)
    local arena = M.getArena(User, NPC)
    local quest = M.arenaInformation[arena].quest
    local points = User:getQuestProgress(quest)

    local outText=common.GetNLS(User, "Du hast bereits "..points.." gesammelt. Weiter so!", "You have already earnt "..points.." points. Keep it up!")
    NPC:talk(Character.say, outText)
end

function M.setArenastats(User, arena, points)
    local quest = M.arenaInformation[arena].quest
    local oldPoints = User:getQuestProgress(quest)

    points = points + oldPoints
    User:setQuestProgress(quest, points)
end

-- reward[x] = {y,z} - x = reward points required, y = item id , z= amount of y
local reward = {
    {61,15}, -- gold coins
    {446,69}, -- sapphire powder
    {447,103}, -- ruby powder
    {448,52}, -- emerald powder
    {449,69}, -- obsidan powder
    {450,103}, -- amethyst powder
    {451,52}, -- topaz powder
    {452,42}, -- diamond powder
    {2551,1}, -- pure air
    {2552,1}, -- pure earth
    {2553,1}, -- pure fire
    {2554,1}, -- pure water
    {3607,1}, -- pure spirit
}

local function rewardDialog(User, points)
    local title = common.GetNLS(User,"Arena Belohnung","Arena reward")
    local text = common.GetNLS(User,"Du hast "..points.." Punkte gesammelt, daher kannst du dir nun eine Belohnung aussuchen.", "You earned "..points.." points, therefore you can pick a reward.")

    local callback = function(dialog)
        local success = dialog:getSuccess()
        if success then
            local selected = dialog:getSelectedIndex()+1
            common.CreateItem(User, reward[selected][1],reward[selected][2], 800, nil)
        end
    end

    local dialog = SelectionDialog(title, text, callback)

    local itemName
    local language = User:getPlayerLanguage()
    for i=1, #(reward) do
        itemName = world:getItemName(reward[i][1],language)
        dialog:addOption(reward[i][1], reward[i][2].." "..itemName)
    end

    User:requestSelectionDialog(dialog)
end

function M.getReward(User, quest)
    local numberOfRewards = User:getQuestProgress(quest+2)
    local currentPoints = User:getQuestProgress(quest)
    local pointsNeededForNewReward = 50

    -- give a reward at 50, 150, 350, 750, 1550, ..
    if  currentPoints >= pointsNeededForNewReward*((2^(numberOfRewards+1))-1) then
        User:setQuestProgress(quest+2, numberOfRewards+1)
        rewardDialog(User, currentPoints)
    end
end

return M
