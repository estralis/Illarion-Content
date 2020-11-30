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
msgs:addMessage("#mes Augen fixieren dich ehe ein lautes Br�llen seiner Kehle entweicht.", "#me's eyes focus on you just before a loud roar erupts from�its throat.")
msgs:addMessage("#me st�tzt sich auf die Hinterl�ufe. Er schl�gt mit den Fl�geln, so dass dir st�rmische B�en entgegenschlagen.", "#me leans back on its hind feet, flapping its wings, causing air currents to flow violently all around.")
msgs:addMessage("#me schaut dich mit hungrigen Augen an, als er sich n�hert.", "#me looks to you with hungry eyes as it approaches.")
msgs:addMessage("#me bringt mit dem Stampfen seiner F��e den Untergrund zum erzittern. Er hinterl�sst den Geruch des Todes auf seinem Pfad.", "#me causes the ground to shake as it stomps its feet, leaving the smell of death�behind in its path.")
msgs:addMessage("#me l�sst ein Br�llen h�ren, dass das Blut gefrieren l�sst.", "#me lets out a blood curdling roar, which can be heard reverberating off the surroundings.")
msgs:addMessage("#me hebt den Kopf in die H�he. Er schn�ffelt und schnuppert als ob etwas seine Aufmerksamkeit erregt.", "#me lifts its head up into the air, sniffing and smelling at something that caught its attention.")
msgs:addMessage("#mes Stacheln an Nacken und R�ckrat stehen steil in die H�he als er sich umsieht.", "#me's spines stand straight up on its neck and back as it looks around.")
msgs:addMessage("#me sch�ttelt sich, so dass Windb�en von seinen Fl�geln ausgehen. Seine Wehrstacheln schlagen dabei gegeneinander, so dass ein schauerliches Rasseln zu h�ren ist.", "#me shakes, as it does a breeze can be felt from its wings as�its spines clash together, rattling�can be heard.")
msgs:addMessage("#mes Schuppen funkeln im Licht, ein ehrfurchtgebietender Anblick.", "#me's scales glisten in the light, making it an awe inspiring sight.")
msgs:addMessage("#me peitscht seinen Schwanz auf den Erdboden, so dass Tr�mmer umherfliegen.", "#me smacks its tail on the ground, causing debris to billow up.")

local M = {}

function M.generateCallbacks()
    return base.generateCallbacks(msgs)
end

return M
