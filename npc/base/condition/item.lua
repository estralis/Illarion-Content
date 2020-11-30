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
local class = require("base.class")
local condition = require("npc.base.condition.condition")
local tools = require("npc.base.tools")

local _item_helper_equal
local _item_helper_notequal
local _item_helper_lesserequal
local _item_helper_greaterequal
local _item_helper_greater
local _item_helper_lesser
local _item_helper_equal_data
local _item_helper_notequal_data
local _item_helper_lesserequal_data
local _item_helper_greaterequal_data
local _item_helper_greater_data
local _item_helper_lesser_data

local item = class(condition,
function(self, itemId, itemLoc, comp, value, data)
    condition:init(self)
    self["item"] = itemId
    if (itemLoc == "all" or itemLoc == "belt" or itemLoc == "body"
        or itemLoc == "backpack") then
        self["location"] = itemLoc
    else
        self["location"] = "all"
    end
    self["value"], self["valuetype"] = tools.set_value(value)
    
    if (data == nil) then
        if (comp == "=") then
            self["check"] = _item_helper_equal
        elseif (comp == "<>" or comp == "!=" or comp == "~=") then
            self["check"] = _item_helper_notequal
        elseif (comp == "<=" or comp == "=<") then
            self["check"] = _item_helper_lesserequal
        elseif (comp == ">=" or comp == "=>") then
            self["check"] = _item_helper_greaterequal
        elseif (comp == ">") then
            self["check"] = _item_helper_greater
        elseif (comp == "<") then
            self["check"] = _item_helper_lesser
        else
            -- unkonwn comparator
        end
    else
        self["data"] = data
        if (comp == "=") then
            self["check"] = _item_helper_equal_data
        elseif (comp == "<>" or comp == "!=" or comp == "~=") then
            self["check"] = _item_helper_notequal_data
        elseif (comp == "<=" or comp == "=<") then
            self["check"] = _item_helper_lesserequal_data
        elseif (comp == ">=" or comp == "=>") then
            self["check"] = _item_helper_greaterequal_data
        elseif (comp == ">") then
            self["check"] = _item_helper_greater_data
        elseif (comp == "<") then
            self["check"] = _item_helper_lesser_data
        else
            -- unkonwn comparator
        end
    end
end)

function _item_helper_equal(self, npcChar, texttype, player)
    local value = tools.get_value(self.npc, self.value, self.valuetype)
    return player:countItemAt(self.location, self.item) == value
end

function _item_helper_notequal(self, npcChar, texttype, player)
    local value = tools.get_value(self.npc, self.value, self.valuetype)
    return player:countItemAt(self.location, self.item) ~= value
end

function _item_helper_lesserequal(self, npcChar, texttype, player)
    local value = tools.get_value(self.npc, self.value, self.valuetype)
    return player:countItemAt(self.location, self.item) <= value
end

function _item_helper_greaterequal(self, npcChar, texttype, player)
    local value = tools.get_value(self.npc, self.value, self.valuetype)
    return player:countItemAt(self.location, self.item) >= value
end

function _item_helper_lesser(self, npcChar, texttype, player)
    local value = tools.get_value(self.npc, self.value, self.valuetype)
    return player:countItemAt(self.location, self.item) < value
end

function _item_helper_greater(self, npcChar, texttype, player)
    local value = tools.get_value(self.npc, self.value, self.valuetype)
    return player:countItemAt(self.location, self.item) > value
end

function _item_helper_equal_data(self, npcChar, texttype, player)
    local value = tools.get_value(self.npc, self.value, self.valuetype)
    return player:countItemAt(self.location, self.item, self.data) == value
end

function _item_helper_notequal_data(self, npcChar, texttype, player)
    local value = tools.get_value(self.npc, self.value, self.valuetype)
    return player:countItemAt(self.location, self.item, self.data) ~= value
end

function _item_helper_lesserequal_data(self, npcChar, texttype, player)
    local value = tools.get_value(self.npc, self.value, self.valuetype)
    return player:countItemAt(self.location, self.item, self.data) <= value
end

function _item_helper_greaterequal_data(self, npcChar, texttype, player)
    local value = tools.get_value(self.npc, self.value, self.valuetype)
    return player:countItemAt(self.location, self.item, self.data) >= value
end

function _item_helper_lesser_data(self, npcChar, texttype, player)
    local value = tools.get_value(self.npc, self.value, self.valuetype)
    return player:countItemAt(self.location, self.item, self.data) < value
end

function _item_helper_greater_data(self, npcChar, texttype, player)
    local value = tools.get_value(self.npc, self.value, self.valuetype)
    return player:countItemAt(self.location, self.item, self.data) > value
end

return item