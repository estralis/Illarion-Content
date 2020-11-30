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
-- UPDATE items SET itm_script='item.id_24_shovel' WHERE itm_id=24;

local common = require("base.common")
local shared = require("craft.base.shared")
local treasure = require("item.base.treasure")
local transformation_dog = require("alchemy.teaching.transformation_dog")
local claydigging = require("craft.gathering.claydigging")
local sanddigging = require("craft.gathering.sanddigging")
local metal = require("item.general.metal")

local M = {}

M.LookAtItem = metal.LookAtItem

-- @return  True if found a treasure.
local function DigForTreasure(User)
    local TargetPos = common.GetFrontPosition(User)
    local groundTile = world:getField(TargetPos):tile()
    local groundType = common.GetGroundType(groundTile)

    if groundType ~= common.GroundType.rocks then
        return treasure.performDiggingForTreasure(User, TargetPos, {
            maximalLevel = (User:getSkill(Character.digging) / 10) + 1,
            msgDiggingOut = {
                de = "Du gr�bst mit deiner Schaufel in den Boden und st��t auf etwas hartes, von dem ein " ..
                        "h�lzerner Klang ausgeht. Noch einmal graben und du h�ltst den Schatz in deinen H�nden.",
                en = "You dig with your shovel into the ground and hit suddenly something hard and wooden " ..
                        "sounding. You only have to dig another time to get the treasure."
            }}
        )
    end
    return false
end

local function DigForNothing(User)
    local TargetPos = common.GetFrontPosition(User)
    local groundTile = world:getField( TargetPos ):tile()
    local groundType = common.GetGroundType( groundTile )

    if ( groundType == common.GroundType.field ) then
        common.HighInformNLS( User,
            "Du gr�bst ein kleines Loch in den Ackerboden, doch findest du hier gar nichts.",
            "You dig a small hole into the farming ground. But you find nothing.")
    elseif ( groundType == common.GroundType.sand ) then
        common.HighInformNLS( User,
            "Du gr�bst ein kleines Loch in den Sand, doch findest du hier gar nichts.",
            "You dig a small hole into the sand. But you find nothing.")
    elseif ( groundType == common.GroundType.dirt ) then
        common.HighInformNLS( User,
            "Du gr�bst ein kleines Loch in den Dreck, doch findest du hier gar nichts.",
            "You dig a small hole into the dirt. But you find nothing.")
    elseif ( groundType == common.GroundType.forest ) then
        common.HighInformNLS( User,
            "Du gr�bst ein kleines Loch in den Waldboden, doch findest du hier gar nichts.",
            "You dig a small hole into the forest ground. But you find nothing.")
    elseif ( groundType == common.GroundType.grass ) then
        common.HighInformNLS( User,
            "Du gr�bst ein kleines Loch in die Wiese, doch findest du hier gar nichts.",
            "You dig a small hole into the grass. But you find nothing.")
    elseif ( groundType == common.GroundType.rocks ) then
        common.HighInformNLS( User,
            "Der Boden besteht hier aus solidem Stein. Mit einer Schaufel hast du eindeutig das falsche Werkzeug.",
            "The ground here is heavy stone. With a shovel you have the wrong tool here for sure.")
    elseif ( groundType == common.GroundType.water ) then
        common.HighInformNLS( User,
            "Im Wasser mit einer Schaufel zu graben geht zwar relativ leicht, doch der Effekt ist recht gering.",
            "To dig with a shovel in the water is pretty easy. But sadly there is no effect in doing this.")
    else
        common.HighInformNLS(User,
            "Du versuchst an dieser Stelle zu graben, findest aber nichts.",
            "You attempt to dig here, but you don't find anything.")
    end

end

local function getPit(User, itemId)
    local pitItem = common.GetFrontItem(User)
    if (pitItem ~= nil and pitItem.id == itemId) then
        return pitItem
    end
    pitItem = common.GetItemInArea(User.pos, itemId)
    return pitItem
end


function M.UseItem(User, SourceItem, ltstate)

    if common.isBroken(SourceItem) then
        common.HighInformNLS(User,"Deine Schaufel ist kaputt.","Your shovel is broken.")
        return
    end
    
    if shared.hasTool(User, 24) == false then
        common.HighInformNLS(User,"Du musst eine Schaufel in der Hand halten.","You need to hold the shovel in your hand.")
        return
    end
    
    if not common.FitForWork( User ) then -- check minimal food points
        return
    end

    -- check for alchemy scroll
    if transformation_dog.DigForTeachingScroll(User) then
        return
    end

    -- check for treasure
    if DigForTreasure(User) then
        return
    end

    local pitItem

    -- check for sand pit
    local SAND_PIT = 1208
    pitItem = getPit(User, SAND_PIT)
    if (pitItem ~= nil) then
        sanddigging.StartGathering(User, pitItem, ltstate)
        return
    end

    -- check for clay pit
    local CLAY_PIT = 1206
    pitItem = getPit(User, CLAY_PIT)
    if (pitItem ~= nil) then
        claydigging.StartGathering(User, pitItem, ltstate)
        return
    end

    -- check for empty pits
    local EMPTY_SAND_PIT = 3632
    pitItem = getPit(User, EMPTY_SAND_PIT)
    if (pitItem ~= nil) then
       common.TurnTo(User, pitItem.pos)
       User:inform( "An dieser Stelle gibt es nicht mehr zu holen.", "There isn't anything left in this pit.", Character.highPriority);
       return
    end
    
    local EMPTY_CLAY_PIT = 3633
    pitItem = getPit(User, EMPTY_CLAY_PIT)
    if (pitItem ~= nil) then
        common.TurnTo(User, pitItem.pos)
        User:inform( "An dieser Stelle gibt es nicht mehr zu holen.", "There isn't anything left in this pit.", Character.highPriority);
        return
    end

    -- inform the user that he digs for nothing
    DigForNothing(User)
end

return M

