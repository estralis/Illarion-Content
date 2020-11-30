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
-- Quest: A Question of Honour (111)/(117)
local common = require("base.common")

local M = {}

local waypoint = {} --a list with positions
waypoint[1] = position(697, 314, 0) --1: Hemp Necktie Inn
waypoint[2] = position(348, 229, 0) --2: Galmair
waypoint[3] = position(995, 815, 0) --3: Runewick
local messageG = {}
messageG[1] = "[Queststatus] Du betrittst den Gasthof zur Hanfschlinge. Was f�r ein dreckiger, unehrenhafter Ort!"
messageG[2] = "[Queststatus] Der 'Palast' des Dons - Du solltest die Ohren aufsperren, aber nicht deine Geldb�rse."
messageG[3] = "[Queststatus] Unertr�gliches Gew�sch kommt aus dem Mund des Erzmagiers. Diesen Unsinn willst du gar nicht erst daheim vermelden."
local messageE = {}
messageE[1] = "[Quest status] You enter the Hemp Necktie Inn. What a filthy and dishonourable place, it doesn't take too long to figure out there is nothing of worth in this place!"
messageE[2] = "[Quest status] The Don's 'palace' - you should drop an ear here but not your purse."
messageE[3] = "[Quest status] Unbearable babbling comes out of the mouth of the Archmage. You don't want to report this nonsense at home..."

function M.triggerEvent(User)
    if (User:getQuestProgress(111) == 12) then --OK, the player does the quest
        local queststatus = User:getQuestProgress(117) --here, we save which fields were visited
        local queststatuslist = {}
        queststatuslist = common.Split_number(queststatus, 3) --reading the digits of the queststatus as table

        for i = 1, 3 do
            if User:isInRangeToPosition(waypoint[i], 2) and queststatuslist[i] == 0 then
                queststatuslist[i] = 1 --found it!
                common.InformNLS(User,messageG[i],messageE[i])
                User:setQuestProgress(117, queststatuslist[1] * 100 + queststatuslist[2] * 10 + queststatuslist[3] * 1) --saving the new queststatus
                queststatus = User:getQuestProgress(117) --and reading it again
                if queststatus == 111 then --found all waypoints
                    User:setQuestProgress(111, 13) --Quest solved!
                    common.InformNLS(User, "[Queststatus] Du hast deine Patroullie erfolgreich abgeschlossen.", "[Quest status] You completed your patrol successfully.")
                    return --more than solving isn't possible, bailing out
                end
            end
        end
    end
end

return M
