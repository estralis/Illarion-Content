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
local base = require("monster.base.base")
local messages = require("base.messages")

--Random Messages
local msgs = messages.Messages()
msgs:addMessage("#me knurrt.", "#me growls.")
msgs:addMessage("#me quiekt.", "#me squeaks.")
msgs:addMessage("#me ist mit L�usen und anderen Parasiten �bers�t.", "#me is covered with lice and other parasites.")
msgs:addMessage("#me knabbert an Unrat.", "#me gnaws on rubbish.")
msgs:addMessage("#me schaut dich herausfordernd an.", "#me looks at you provokingly.")
msgs:addMessage("#me schn�ffelt und schnuppert an allem.", "#me sniffs and smells at everything.")
msgs:addMessage("#me zeigt seine scharfen Fangz�hne.", "#me bares its sharp fangs.")
msgs:addMessage("#me leckt sich nerv�s die Krallen.", "#me licks nervously at its claws.")
msgs:addMessage("#me peitscht nerv�s mit dem Schwanz.", "#me nervously whips its tail.")
msgs:addMessage("#me faucht aggressiv.", "#me hisses agressively.")

local M = {}

function M.generateCallbacks()
    return base.generateCallbacks(msgs)
end

return M