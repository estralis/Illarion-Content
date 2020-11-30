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
local common = require("base.common")
local M = {}

M.createPlayerItem = class(function(creplitem, ply, ID, qual, amnt)
    creplitem.player=ply;
    creplitem.itemId=ID;
    creplitem.quality=qual;
    creplitem.amount=amnt;
end);

function M.createPlayerItem:execute()
    local person = self.player
    common.CreateItem(person, self.itemId, self.amount, self.quality, nil)
end

return M
