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

-- UPDATE items SET itm_script='item.id_51_emptybucket' WHERE itm_id IN (51);

local common = require("base.common")
local alchemy = require("alchemy.base.alchemy")

-- fill bucket from ...
-- cauldron
-- well
-- water tiles

local M = {}

local FillFromCauldron
local GetWaterTilePosition
local GetCauldron

function M.UseItem(User, SourceItem, ltstate)
    -- check for cauldron
    local TargetItem = GetCauldron(User)
    if (TargetItem ~= nil) then
        common.TurnTo( User, TargetItem.pos ) -- turn if necessary
        FillFromCauldron(User, SourceItem, TargetItem, ltstate)
        return
    end

    if User:countItem(51) <= 0 then
        return
    end

    -- waterscooping
    local itemData
    local isDragoncaveSpring
    local foundSource = false

    -- check for well or fountain
    TargetItem = common.GetItemInArea(User.pos, 2207)
    if (TargetItem == nil) then
        TargetItem = common.GetItemInArea(User.pos, 631)
        if (TargetItem == nil) then
            TargetItem = common.GetItemInArea(User.pos, 2079)
        end
        if (TargetItem == nil) then
            TargetItem = common.GetItemInArea(User.pos, 1097)
        end
    end
    if (TargetItem ~= nil) then
        common.TurnTo(User, TargetItem.pos) -- turn if necessary
        foundSource = true

        -- check if we found a quest fountain in dragon cave
        isDragoncaveSpring = (TargetItem:getData("dragoncaveSpring") == "true")
        if (isDragoncaveSpring) then
            itemData = {dragoncaveBucket = "true", descriptionDe = "Vulkanisches Quellwasser", descriptionEn = "Vulcanic Springwater"}
        end
    end

    -- check for water tile
    local targetPos = GetWaterTilePosition(User)
    if (targetPos ~= nil) then
        common.TurnTo(User, targetPos) -- turn if necessary
        foundSource = true
    end

    if not foundSource then
        -- nothing found to fill the bucket.
        common.InformNLS(User,
            "Du kannst den Eimer an einem Brunnen oder an einem Gew�sser f�llen.",
            "You can fill the bucket at a well or at some waters.")
        return
    end

    if ( ltstate == Action.abort ) then
        common.InformNLS(User, "Du brichst deine Arbeit ab.", "You abort your work.")
        return
    end

    if ( ltstate == Action.none ) then
        User:startAction( 20, 21, 5, 10, 25)
        User:talk(Character.say, "#me beginnt Eimer zu bef�llen.", "#me starts to fill buckets.")
        return
    end

    if isDragoncaveSpring then
        common.InformNLS(User,
            "Als du einen Eimer voll klaren, k�hlen Wassers aus dem Becken herausgezogen hast, siehst du dich nach Verwendungsm�glichkeiten f�r das Wasser um.",
            "As you pull a bucket of water from the clear cool waters of the pool, you look around to see what uses can be had with the water.")
    end

    local created =  common.CreateItem(User, 52, 1, 333, itemData)
    if not created then -- too many items -> character can't carry anymore
        world:erase(SourceItem,1)
        return
    else -- character can still carry something
        if SourceItem.number == 1 then
            world:erase(SourceItem,1)
            return
        else
            world:erase(SourceItem,1)
            SourceItem.number = SourceItem.number-1
            world:changeItem(SourceItem)
            if isDragoncaveSpring then
                return
            end
            User:changeSource(SourceItem)
            User:startAction( 20, 21, 5, 10, 25)
        end
    end
end

function FillFromCauldron(User,SourceItem,TargetItem,ltstate)

    if ( ltstate == Action.abort ) then
        common.InformNLS(User, "Du brichst deine Arbeit ab.", "You abort your work.")
        return
    end

    -- is the char an alchemist?
    local anAlchemist = alchemy.CheckIfAlchemist(User)
    if not anAlchemist then
        User:inform("Auf dem Schriftst�ck steht nur dir unverst�ndliches Alchemistengeschwafel.","For you the document only appears to contain unintelligible alchemical gibberish.")
        return
    end

    if ( ltstate == Action.none ) then
        User:startAction( 20, 21, 5, 0, 0)
        return
    end

    common.InformNLS(User,
        "Du f�llst den Eimer mit dem Wasser im Kessel.",
        "You fill the bucket with the water in the cauldron.")

    world:makeSound(10,TargetItem.pos)
    TargetItem.id = 1008
    TargetItem:setData("filledWith","")
    world:changeItem(TargetItem)

    if SourceItem.number > 1 then
        world:erase(SourceItem, 1)
        common.CreateItem(User, 52, 1, 333, nil)
    else
        SourceItem.id = 52
        SourceItem.quality = 333
        world:changeItem(SourceItem)
    end
end

-- returns a cauldron filled with water if one is found next to the user.
function GetCauldron(User)
    -- first check in front
    local frontPos = common.GetFrontPosition(User)
    if (world:isItemOnField(frontPos)) then
        local item = world:getItemOnField(frontPos)
        if (item.id == 1010 and item:getData("filledWith") == "water") then
            return item
        end
    end
    local Radius = 1
    for x=-Radius,Radius do
        for y=-Radius,Radius do
            local targetPos = position(User.pos.x + x, User.pos.y + y, User.pos.z)
            if (world:isItemOnField(targetPos)) then
                local item = world:getItemOnField(targetPos)
                if (item.id == 1010 and item:getData("filledWith") == "water") then
                    return item
                end
            end
        end
    end
    return nil
end

function GetWaterTilePosition(User)
    local targetPos = common.GetFrontPosition(User)
    if (common.GetGroundType(world:getField(targetPos):tile()) == common.GroundType.water) then
        return targetPos
    end

    local Radius = 1
    for x=-Radius,Radius do
        for y=-Radius,Radius do
            targetPos = position(User.pos.x + x, User.pos.y + y, User.pos.z)
            if (common.GetGroundType(world:getField(targetPos):tile()) == common.GroundType.water) then
                return targetPos
            end
        end
    end
    return nil
end

return M

