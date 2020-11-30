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
-- Quest: A Question of Honour (111)/(116)
local common = require("base.common")

local M = {}

local waypoint = {} --a list with positions
waypoint[1] = position(470, 795, 0) --1: Eastern border
waypoint[2] = position(261, 679, 0) --2: Arena Circle of Blood
waypoint[3] = position(135, 696, 0) --3: Mine Cornerstone of Candour
waypoint[4] = position(236, 440, 0) --4: Bridge over the Kantabi River (ambush!)
local messageG = {}
messageG[1] = "[Queststatus] Du erblickst einen betenden komischen Kauz, als du dich der Ostgrenze n�herst."
messageG[2] = "[Queststatus] Den Blutkreis, der Arena des Landes, scheint es nach frischem Blut zu d�rsten."
messageG[3] = "[Queststatus] Der Grundstein der Aufrichtigkeit steht wie ein Fels in der Brandung der D�nen."
messageG[4] = "[Queststatus] Du �berquerst den Kantabifluss. Banditen haben dir wohl aufgelauert, ein Hinterhalt!"
local messageE = {}
messageE[1] = "[Quest status] You spot a strange fellow chanting prayers as you approach the eastern border."
messageE[2] = "[Quest status] The Circle of Blood thirsts for fresh blood but all looks clear."
messageE[3] = "[Quest status] The Cornerstone of Candour vigilantly resists against the encroaching sand dunes."
messageE[4] = "[Quest status] As you cross the Kantabi River you hear an uproar of voices, and a band of cloaked men charge you. Ambush!"

function M.MoveToField(User)
    if (User:getQuestProgress(111) == 9) then --OK, the player does the quest
        local queststatus = User:getQuestProgress(116) --here, we save which fields were visited
        local queststatuslist = {}
        queststatuslist = common.Split_number(queststatus, 4) --reading the digits of the queststatus as table

        for i = 1, 4 do
            if User:isInRangeToPosition(waypoint[i], 2) and queststatuslist[i] == 0 then
                queststatuslist[i] = 1 --found it!
                common.InformNLS(User, messageG[i], messageE[i])
                User:setQuestProgress(116, queststatuslist[1] * 1000 + queststatuslist[2] * 100 + queststatuslist[3] * 10 + queststatuslist[4] * 1) --saving the new queststatus
                queststatus = User:getQuestProgress(116) --and reading it again

                if i == 4 then --ambush!
                    world:gfx(41, position(239, 435, 0))
                    world:createMonster(5, position(239, 435, 0), 40) --bandit
                    world:gfx(41, position(234, 430, 0))
                    world:createMonster(5, position(234, 430, 0), 40) --bandit
                    world:gfx(41, position(239, 446, 0))
                    world:createMonster(1, position(239, 446, 0), 40) --human
                    world:gfx(41, position(230, 441, 0))
                    world:createMonster(3, position(230, 441, 0), 40) --mage
                end

                if queststatus == 1111 then --found all waypoints
                    User:setQuestProgress(111, 10) --Quest solved!
                    common.InformNLS(User, "[Queststatus] Du hast deine Patroullie erfolgreich abgeschlossen.", "[Quest status] You completed your patrol successfully.")
                    return --more than solving isn't possible, bailing out
                end
            end
        end
    end
end

return M
