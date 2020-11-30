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
msgs:addMessage("#me bleibt steifbeinig und aufgerichtet stehen.", "#me stands stiff legged and tall.")
msgs:addMessage("#me duckt sich, bereit anzugreifen.", "#me crouches, ready to strike.")
msgs:addMessage("#me hat Schaum vor dem Maul.", "#me foams at the mouth.")
msgs:addMessage("#me hebt seinen Kopf und heult.", "#me raises its head and howls.")
msgs:addMessage("#me kl�fft laut.", "#me barks loudly.")
msgs:addMessage("#me knirscht mit den Z�hnen.", "#me gnashes its teeth.")
msgs:addMessage("#me knurrt, das Ger�usch ist kaum h�rbar.", "#me growls, the noise barely audible.")
msgs:addMessage("#me kr�mmt seinen R�cken.", "#me arches its back.")
msgs:addMessage("#me l�sst ein b�ses Knurren h�ren.", "#me lets out a vicious snarl.")
msgs:addMessage("#me stellt seine Ohren auf.", "#me's ears perk up.")
msgs:addMessage("#me bleckt die Z�hne.", "#me bares its teeth.")
msgs:addMessage("#mes Fell str�ubt sich.", "#me's fur bristles")
msgs:addMessage("#mes Schwanz streckt sich hinter seinem K�rper gerade aus.", "#me's tail extends straight out from its body.")

local M = {}

function M.generateCallbacks()
    return base.generateCallbacks(msgs)
end

return M