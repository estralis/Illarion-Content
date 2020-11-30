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
-- INSERT INTO triggerfields VALUES (990,253,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (989,253,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (988,253,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (987,253,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (986,253,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (985,253,0,'triggerfield.evilrock');

-- INSERT INTO triggerfields VALUES (990,253,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (989,252,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (988,252,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (987,252,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (986,252,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (985,252,0,'triggerfield.evilrock');

-- INSERT INTO triggerfields VALUES (995,228,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (994,228,0,'triggerfield.evilrock');

-- INSERT INTO triggerfields VALUES (990,201,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (990,202,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (990,203,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (990,204,0,'triggerfield.evilrock');

-- INSERT INTO triggerfields VALUES (952,206,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (952,207,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (963,177,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (962,177,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (920,200,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (921,200,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (912,250,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (912,251,0,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (963,203,1,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (964,203,1,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (966,209,1,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (966,210,1,'triggerfield.evilrock');

-- INSERT INTO triggerfields VALUES (977,173,-6,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (952,173,-6,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (964,172,-6,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (964,173,-6,'triggerfield.evilrock');
-- INSERT INTO triggerfields VALUES (964,174,-6,'triggerfield.evilrock');

-- INSERT INTO triggerfields VALUES (970,171,2,'triggerfield.evilrock');
local lookat = require("base.lookat")
local common = require("base.common")
local class = require("base.class")
local character = require("base.character")
local areas = require("content.areas")
--local vision = require("content.vision") !!!
local M = {}

-- IMPORTANT
-- I commented lines out which cause trouble due to circular requiring. Search for !!! to find those files.
-- content.vision requires triggerfield.evilrock and vice vera.

local triggerFlameFire={position(990,252,0),position(989,253,0),position(988,252,0),position(987,253,0),position(986,252,0),position(985,253,0)}
local triggerFlameIce={position(990,253,0),position(989,252,0),position(988,253,0),position(987,252,0),position(986,253,0),position(985,252,0)}
local triggerFlamePoison={position(994,228,0),position(995,228,0)}
local triggerEntranceTrap={position(990,201,0),position(990,202,0),position(990,203,0),position(990,204,0)}

local triggerVision={position(952,206,0),position(952,207,0),position(963,177,0),position(962,177,0),position(920,200,0),position(921,200,0),position(912,250,0),position(912,251,0),position(963,203,1),position(964,203,1),position(966,209,1),position(966,210,1),position(964,172,-6),position(964,173,-6),position(964,174,-6)}
local VisionStory={1,1,2,2,3,3,4,4,5,5,5,5,6,6,6}
local EvilRockAreaNames={"evilrock1","evilrock2","evilrock3","evilrock4","evilrock5","evilrock6"}

local attendants={}
local attendants2={}
local advantureslist={}


local function StartVision(char,AmountStory,TypeStory)
    local find = char.effects:find(83)
    if find then
        return
    end
    local myEffect = LongTimeEffect(83,50)
    myEffect:addValue("AmountStory",AmountStory)
    myEffect:addValue("TypeStory",TypeStory)
    char.effects:addEffect(myEffect)
end
local function CheckPortalLeverRiddle1(char)
    if world:getItemOnField(position(966,169,2)).id == 436 and world:getItemOnField(position(967,169,2)).id == 436 and world:getItemOnField(position(968,169,2)).id ~= 436 and world:getItemOnField(position(969,169,2)).id ~= 436 and world:getItemOnField(position(970,169,2)).id ~= 436 and world:getItemOnField(position(971,169,2)).id ~= 436 and world:getItemOnField(position(972,169,2)).id ~= 436 and world:getItemOnField(position(973,169,2)).id ~= 436 and world:getItemOnField(position(974,169,2)).id == 436 then
        return true
    else
        return false
    end
end


local function CheckPortalLeverRiddle2(char)
    if world:getItemOnField(position(966,169,2)).id == 436 and world:getItemOnField(position(967,169,2)).id ~= 436 and world:getItemOnField(position(968,169,2)).id == 436 and world:getItemOnField(position(969,169,2)).id ~= 436 and world:getItemOnField(position(970,169,2)).id ~= 436 and world:getItemOnField(position(971,169,2)).id == 436 and world:getItemOnField(position(972,169,2)).id ~= 436 and world:getItemOnField(position(973,169,2)).id ~= 436 and world:getItemOnField(position(974,169,2)).id ~= 436 then
        return true
    else
        return false
    end
end


local function CheckPortalLeverRiddle3(char)
    if world:getItemOnField(position(966,169,2)).id == 436 and world:getItemOnField(position(967,169,2)).id ~= 436 and world:getItemOnField(position(968,169,2)).id ~= 436 and world:getItemOnField(position(969,169,2)).id == 436 and world:getItemOnField(position(970,169,2)).id ~= 436 and world:getItemOnField(position(971,169,2)).id ~= 436 and world:getItemOnField(position(972,169,2)).id ~= 436 and world:getItemOnField(position(973,169,2)).id == 436 and world:getItemOnField(position(974,169,2)).id ~= 436 then
        return true
    else
        return false
    end
end


local function CheckPortalLeverRiddle4(char)
    if world:getItemOnField(position(966,169,2)).id == 436 and world:getItemOnField(position(967,169,2)).id ~= 436 and world:getItemOnField(position(968,169,2)).id ~= 436 and world:getItemOnField(position(969,169,2)).id == 436 and world:getItemOnField(position(970,169,2)).id ~= 436 and world:getItemOnField(position(971,169,2)).id ~= 436 and world:getItemOnField(position(972,169,2)).id == 436 and world:getItemOnField(position(973,169,2)).id ~= 436 and world:getItemOnField(position(974,169,2)).id ~= 436 then
        return true
    else
        return false
    end
end

function M.PortalLeverRiddle(char)
    world:makeSound(22,position(970,171,2))
    if CheckPortalLeverRiddle1(char) == true or CheckPortalLeverRiddle2(char) == true or CheckPortalLeverRiddle3(char) == true or CheckPortalLeverRiddle4(char) == true then
        world:gfx(32,position(970,171,2))
        world:makeSound(4,position(970,171,2))
        world:createItemFromId(798,1,position(970,171,2),true,666,nil)
    else
        local checkRedPortal = world:getItemOnField(position(970,171,2))
        if checkRedPortal.id == 798 then
            world:erase(checkRedPortal,checkRedPortal.number)
            world:makeSound(4,position(970,171,2))
            world:gfx(5,position(970,171,2))
        end
    end
end

local stoneChamberAttendants={}

local function StoneChamberQuestProgressCheck(char)
    stoneChamberAttendants[char.name] = world:getPlayersInRangeOf(position(952,173,-6), 50)
    for m,player in ipairs(stoneChamberAttendants[char.name]) do
        if player:getQuestProgress(680) ~= 0 and player:getQuestProgress(681) ~= 0 then
            return true
        end
    end
end


local function StoneChamberQuestProgress(char)
    stoneChamberAttendants[char.name] = world:getPlayersInRangeOf(position(952,173,-6), 50)
    for m,player in ipairs(stoneChamberAttendants[char.name]) do
        player:setQuestProgress(680,math.random(400,600))
        player:setQuestProgress(681,1)
    end
end
local stoneChamberStonePosition={position(957,170,-6),position(953,167,-6),position(948,168,-6),position(946,173,-6),position(948,178,-6),position(953,179,-6),position(957,176,-6)}
local stoneChamberStoneKind={3524,3519,3521,3520,3523,3525,3522}

local playerWithWrongWeight={}
local playerWithRightWeight={}
local clicksAmountDe={"einmaliges","dreimaliges","zweimaliges"}
local clicksAmountEn={"a click","three clicks","two clicks"}
local playerHasCorrectWeight

local function RightWeight(char,clicksAmountVar)
    playerWithRightWeight[char.name] = world:getPlayersInRangeOf(position(960,173,-6), 50)
    local AmountStoneChamberStones = #stoneChamberStonePosition
    local ChanceForGemsToday = math.random(1,100)
    local noLuckForGemsToday
    if ChanceForGemsToday <= 10 or char:getQuestProgress(681) == 0 then
        noLuckForGemsToday = true
    else
        noLuckForGemsToday = false
    end
    for m,player in ipairs(playerWithRightWeight[char.name]) do
        if (areas.PointInArea(player.pos,"evilrockstonechamber")) then
            common.InformNLS(player,"Der Thron sinkt ein wenig ein und du h�rst ein "..clicksAmountDe[clicksAmountVar].." Klicken.","The throne sinks down slightly and you hear "..clicksAmountEn[clicksAmountVar].." .")
        end
    end

    if not StoneChamberQuestProgressCheck(char) then
        if noLuckForGemsToday == true then
            for i = 1,AmountStoneChamberStones do
                world:makeSound(27,stoneChamberStonePosition[i])
                world:gfx(46,stoneChamberStonePosition[i])
                world:createItemFromId(stoneChamberStoneKind[i],1,stoneChamberStonePosition[i],true,999,{["gemLevel"]="1"})
            end
        else
            for m,player in ipairs(playerWithRightWeight[char.name]) do
                world:makeSound(27,player.pos)
                common.InformNLS(player,"Zus�tzlich siehst du noch ein kurzes Aufleuchten einer Lichtquelle, welches aber sogleich abstirbt. Hier scheint heute nichts zu funktionieren.","Furthermore, you see a light blinking for a second but nothing happens. It does not seem as though anything is working today.")
            end
        end
    else
        for m,player in ipairs(playerWithRightWeight[char.name]) do
            world:makeSound(27,player.pos)
            common.InformNLS(player,"Zus�tzlich siehst du noch ein kurzes Aufleuchten einer Lichtquelle, welches aber sogleich abstirbt. Hier scheint heute nichts zu funktionieren.","Furthermore, you see a light blinking, which immediately disappears. It does not seem as though anything is working today.")
        end
    end

    world:createItemFromId(467,1,position(952,173,-6),true,333,nil)
    playerHasCorrectWeight = true
end


local function WrongWeight(char,clicksAmountVar)
    playerWithWrongWeight[char.name] = world:getPlayersInRangeOf(position(960,173,-6), 50)
    for m,player in ipairs(playerWithWrongWeight[char.name]) do
        if (areas.PointInArea(player.pos,"evilrockstonechamber")) then
            common.InformNLS(player,"Du h�rst ein "..clicksAmountDe[clicksAmountVar].." Klicken w�hrend der Thron leicht einsinkt und eine Stimme ruft: 'Narr, du bist nicht ich! Hinweg mit dir!' Anschlie�end f�llt sich der Raum mit Flammen.","You hear "..clicksAmountEn[clicksAmountVar].." during which the throne sinks down slightly and a voice shouts: 'Fool, you are not me! Leave!' The room fills itself with flames afterwards.")
            world:makeSound(25,player.pos);
        end
    end
    for xx=943,960 do
        for yy=164,182 do
            local positionFlame = position(xx,yy,-6)
            world:createItemFromId(360,1,positionFlame,true,666,nil)
        end
    end
    playerHasCorrectWeight = false
end

function M.MoveToField(char)
    if char:getType() ~= Character.player then --Monsters will be ingored
        return
    end

    local find
    local AmountFlameFire = #triggerFlameFire
    for i = 1,AmountFlameFire do
        if char.pos == triggerFlameFire[i] then
            if char:getQuestProgress(689) == 0 and find == false then
                -- character.CreateAfterTime (char,100,120,359,nil,1,1,988,998,225,235,0,0,600,600,1,1,nil,4,1,3,nil,nil,1)
                local adventurers = world:getPlayersInRangeOf(char.pos, 15)
                            advantureslist[char.name] = adventurers
                for i,player in ipairs(advantureslist[char.name]) do
                    player:setQuestProgress(689,1)
                end
            end
        end
    end

    local AmountFlameIce = #triggerFlameIce
    for i = 1,AmountFlameIce do
        if char.pos == triggerFlameIce[i] then
            if char:getQuestProgress(689) == 0 and find == false then
                -- character.CreateAfterTime (char,100,120,360,nil,1,1,988,998,225,235,0,0,600,600,1,1,nil,5,1,3,nil,nil,1)
                local adventurers = world:getPlayersInRangeOf(char.pos, 15)
                            advantureslist[char.name] = adventurers
                for i,player in ipairs(advantureslist[char.name]) do
                    player:setQuestProgress(689,1)
                end
            end
        end
    end

    local AmountFlamePoison = #triggerFlamePoison
    for i = 1,AmountFlamePoison do
        if char.pos == triggerFlamePoison[i] then
            if char:getQuestProgress(689) == 0 and find == false then
                -- character.CreateAfterTime (char,100,120,372,nil,1,1,986,998,211,223,0,0,600,600,1,1,nil,13,1,3,nil,nil,1)
                local adventurers = world:getPlayersInRangeOf(char.pos, 15)
                            advantureslist[char.name] = adventurers
                for i,player in ipairs(advantureslist[char.name]) do
                    player:setQuestProgress(689,1)
                end
            end
        end
    end

    local AmountEntranceTrap = #triggerEntranceTrap
    for i = 1,AmountEntranceTrap do
        if char.pos == triggerEntranceTrap[i] then
            for xx=992,996 do
                world:createItemFromId( 3097, 1, position(xx,195,0), false, 333, nil)
                world:makeSound(4,char.pos)
                world:makeSound(5,char.pos)
            end
            local CheckBucket = world:getItemOnField(position(997,199,2))
            if CheckBucket.id == 51 then
            else
                world:erase(CheckBucket,CheckBucket.number)
                world:createItemFromId(51, 1, position(997,199,2), true, 333, nil)
                local CreateBucket = world:getItemOnField(position(997,199,2))
                CreateBucket.wear=255
                lookat.SetSpecialDescription(CreateBucket,"Wie viel Wasser wohl in diesen Eimer passt?","How much water might fit into this bucket?")
                world:changeItem(CreateBucket)
            end
        end
    end

    local AmountVision = #triggerVision
    for i = 1,AmountVision do
        if (char.pos == triggerVision[i]) and math.random(1,100)< 81 then
            --local AmountStory = #vision.VisionTextDE[VisionStory[i]]
            local TypeStory = VisionStory[i]
            attendants[char.name] = world:getPlayersInRangeOf(position(940,200,0), 90)
            for k,player in ipairs(attendants[char.name]) do
--                if (content.areas.PointInArea(player.pos,EvilRockAreaNames[VisionStory[i]])) and player:getQuestProgress(664) >= 2 then
                if player:getQuestProgress(665) == 0 then
                    player:setQuestProgress(665,2)
                else
                    return
                end

            end
            attendants2[char.name] = world:getPlayersInRangeOf(position(940,200,-6), 90)
            for k,player in ipairs(attendants2[char.name]) do
--                if (content.areas.PointInArea(player.pos,EvilRockAreaNames[VisionStory[i]])) and player:getQuestProgress(664) >= 2 then
                if player:getQuestProgress(665) == 0 then
                    player:setQuestProgress(665,2)
                else
                    return
                end

            end
            char:setQuestProgress(664,1)
--            StartVision(char,AmountStory,TypeStory) AmountStory is nil
            StartVision(char,nil,TypeStory)
        end
    end
    if char.pos == position(977,173,-6) and world:getItemOnField(position(977,173,-6)).id == 10 then
        local checkRedPortal = world:getItemOnField(position(970,171,2))
        if checkRedPortal.id == 798 then
            world:erase(checkRedPortal,checkRedPortal.number)
        end
        if char:getFaceTo() == 1 or char:getFaceTo() == 2 or char:getFaceTo() == 3 then
            world:gfx(41,char.pos);
            world:makeSound(13,char.pos);
            char:warp(position(929,187,1))
            world:gfx(41,char.pos);
            world:makeSound(13,char.pos);
        elseif char:getFaceTo() == 5 or char:getFaceTo() == 6 or char:getFaceTo() == 7 then
            world:gfx(41,char.pos);
            world:makeSound(13,char.pos);
            char:warp(position(966,171,2))
            world:gfx(41,char.pos);
            world:makeSound(13,char.pos);
        end
    end
    if char.pos == position(970,171,2) and world:getItemOnField(position(970,171,2)).id == 798 then
        if CheckPortalLeverRiddle1(char) == true then
            world:gfx(41,char.pos);
            world:makeSound(13,char.pos);
            char:warp(position(836,813,0))
            world:gfx(41,char.pos);
            world:makeSound(13,char.pos);
        elseif CheckPortalLeverRiddle2(char) == true then
            world:gfx(41,char.pos);
            world:makeSound(13,char.pos);
            char:warp(position(127,647,0))
            world:gfx(41,char.pos);
            world:makeSound(13,char.pos);
        elseif CheckPortalLeverRiddle3(char) == true then
            world:gfx(41,char.pos);
            world:makeSound(13,char.pos);
            char:warp(position(684,307,0))
            world:gfx(41,char.pos);
            world:makeSound(13,char.pos);
        elseif CheckPortalLeverRiddle4(char) == true then
            world:gfx(41,char.pos);
            world:makeSound(13,char.pos);
            char:warp(position(424,245,0))
            world:gfx(41,char.pos);
            world:makeSound(13,char.pos);
        end
    end
    if char.pos == position(952,173,-6) then
        local weightOfPlayer = char:increaseAttrib("weight",0)
--debug("weightOfPlayer: "..weightOfPlayer)
        local heightOfPlayer = char:increaseAttrib("body_height",0)
--debug("heightOfPlayer: "..heightOfPlayer)
        local strengthOfPlayer = char:increaseAttrib("strength",0)
--debug("strengthOfPlayer: "..strengthOfPlayer)
        local ageOfPlayer = char:increaseAttrib("age",0)
--debug("ageOfPlayer: "..ageOfPlayer)


        local ItemsInBackPack = char:getBackPack()
        local weightofItemsInBackPack = ItemsInBackPack:weight()

        local ItemsOnBodyBelt = 0
        local itemsOnChar = {};
        local itemPosOnChar = {};
        for i=17,0,-1 do
            local item = char:getItemAt(i);
            if (item.id > 0) then
                table.insert(itemsOnChar, item);
            end
        end
        local language = char:getPlayerLanguage();

        for i,item in ipairs(itemsOnChar) do
            local statsofItemsOnChar = world:getItemStatsFromId(item.id)
            local statsofItemsOnCharWeight = statsofItemsOnChar.Weight
            local numberofItemsOnChar
            if item.itempos >= 11 and item.itempos <= 18 then
                numberofItemsOnChar = char:countItemAt("belt",item.id)
            else
                numberofItemsOnChar = char:countItemAt("body",item.id)
            end
            local weightofItemsOnChar = numberofItemsOnChar * statsofItemsOnCharWeight
            ItemsOnBodyBelt = ItemsOnBodyBelt + weightofItemsOnChar
        end

--debug("weightOfPlayer: "..weightOfPlayer)
--debug("weightofItemsInBackPack: "..weightofItemsInBackPack)
--debug("ItemsOnBodyBelt: "..ItemsOnBodyBelt)
        local weightOfPlayerPlusItemsPlusBag = weightOfPlayer+weightofItemsInBackPack+ItemsOnBodyBelt
--debug("weightOfPlayerPlusItemsPlusBag: "..weightOfPlayerPlusItemsPlusBag)

        if weightOfPlayerPlusItemsPlusBag == nil  then
            local clicksAmountVar = 1
            WrongWeight(char,clicksAmountVar)
        elseif weightOfPlayerPlusItemsPlusBag <= 12400 then
            local clicksAmountVar = 1
            WrongWeight(char,clicksAmountVar)
        elseif weightOfPlayerPlusItemsPlusBag >= 13500 then
            local clicksAmountVar = 2
            WrongWeight(char,clicksAmountVar)
        else
            local clicksAmountVar = 3
            RightWeight(char,clicksAmountVar)
        end
    end

end

function M.MoveFromField(char)
   if char:getType() ~= Character.player then
    return
   else
    for xx=943,960 do
        for yy=164,182 do
            local positionStoneChamber = position(xx,yy,-6)
            local checkStoneChamber = world:getItemOnField(positionStoneChamber)
            if checkStoneChamber.id == 360 then
                world:erase(checkStoneChamber,checkStoneChamber.number)
                world:makeSound(13,char.pos)
            end
        end
    end
    local checkStoneChamber = world:getItemOnField(position(952,173,-6))
    if checkStoneChamber.id == 467 then
        world:erase(checkStoneChamber,checkStoneChamber.number)
        world:makeSound(13,position(952,173,-6))
    end
    local AmountStoneChamberStones = #stoneChamberStonePosition
    for i = 1,AmountStoneChamberStones do
        local checkStoneChamber = world:getItemOnField(stoneChamberStonePosition[i])
        if checkStoneChamber.id == stoneChamberStoneKind[i] then
            world:erase(checkStoneChamber,checkStoneChamber.number)
            world:makeSound(13,stoneChamberStonePosition[i])
            world:gfx(5,stoneChamberStonePosition[i])
        elseif playerHasCorrectWeight == true then
            StoneChamberQuestProgress(char)
        end
    end
   end
end


M.executePortalLeverRiddle = class(function(leverriddle, posi)
    leverriddle.pos=posi
end)


function M.executePortalLeverRiddle:execute()
    local char=self.player
    M.PortalLeverRiddle(char)
end

return M
