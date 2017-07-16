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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (650, 'quest.wulfgorda_650');

local common = require("base.common")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Sibanac f�r Wulfgorda bei dem Gasthof zur Hanfschlinge (Spinnenmaul)"
Title[ENGLISH] = "Sibanac for Wulfgorda at the Hemp Necktie Inn (Spider's Mouth)"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Finde Wulfgorda beim Gasthof zur Hanfschlinge und bringe ihr die Sibanacbl�tter, um deine Belohnung zur erhalten."
Description[ENGLISH][1] = "Try to find Wulfgorda at the Hemp Necktie Inn and take her the sibanac leaves to get your reward."
Description[GERMAN][2] = "Du hast Wulfgorda gefunden. Wenn du m�chtest, kannst du nun mit ihr sprechen. Frage sie nach 'Hilfe' wenn du nicht wei�t, wonach du fragen sollst!\nSie kann dir einiges �ber die nord�stliche Karte von Illarion verraten."
Description[ENGLISH][2] = "You have found Wulfgorda. If you like, you can talk with her now. Ask for 'help' if you do not know what to say!\nShe can provide you with information about the north-eastern part of Illarion."

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
QuestTarget[1] = {position(685, 315, 0)} -- Wulfgorda

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 2


function M.QuestTitle(user)
    return common.GetNLS(user, Title[GERMAN], Title[ENGLISH])
end

function M.QuestDescription(user, status)
    local german = Description[GERMAN][status] or ""
    local english = Description[ENGLISH][status] or ""

    return common.GetNLS(user, german, english)
end

function M.QuestTargets(user, status)
    return QuestTarget[status]
end

function M.QuestFinalStatus()
    return FINAL_QUEST_STATUS
end

return M
