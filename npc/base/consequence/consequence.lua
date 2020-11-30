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

local _consequence_helper_empty

--- Basic class for all consequences. Its never needed to create a instance of
--  this class. Its just a collection of methods the specific consequences
--  share.
local consequence = class(function(self)
    self["perform"] = _consequence_helper_empty
end)

function consequence:setNPC(npc)
    self["npc"] = npc
end

function _consequence_helper_empty(self, npcChar, player)
    -- by default nothing is done
end

return consequence