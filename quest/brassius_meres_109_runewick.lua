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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (109, 'quest.brassius_meres_109_runewick');

local common = require("base.common")
local factions = require("base.factions")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Versorgung der Runewicker Wache"
Title[ENGLISH] = "Support for the Runewick Guard"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Besorge f�nf �pfel und bringe sie zu Brassius Meres."
Description[ENGLISH][1] = "Obtain five apples and take them back to Brassius Meres."
Description[GERMAN][2] = "Geh zu Brassius Meres, der sich an der Br�cke zu Runewick aufh�lt. Er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][2] = "Go back to Brassius Meres at the bridge to Runewick, he will certainly have another task for you."
Description[GERMAN][3] = "Besorge zehn Pfeile und bringe sie Brassius Meres."
Description[ENGLISH][3] = "Obtain ten arrows and take them back to Brassius Meres."
Description[GERMAN][4] = "Geh zu Brassius Meres, der sich an der Br�cke zu Runewick aufh�lt. Er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][4] = "Go back to Brassius Meres at the bridge to Runewick, he will certainly have another task for you."
Description[GERMAN][5] = "Besorge zehn Felle und bringe sie Brassius Meres."
Description[ENGLISH][5] = "Obtain ten furs and take them back to Brassius Meres."
Description[GERMAN][6] = "Du hast alle Aufgaben von Brassius Meres erf�llt. "
Description[ENGLISH][6] = "You have fulfilled all the tasks for Brassius Meres."

-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {865, 814, 0}


-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
QuestTarget[1] = {position(865, 814, 0)}
QuestTarget[2] = {position(865, 814, 0)}
QuestTarget[3] = {position(865, 814, 0)}
QuestTarget[4] = {position(865, 814, 0)}
QuestTarget[5] = {position(865, 814, 0)}
QuestTarget[6] = {position(865, 814, 0)}

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 6


function M.QuestTitle(user)
    return common.GetNLS(user, Title[GERMAN], Title[ENGLISH])
end

function M.QuestDescription(user, status)
    local german = Description[GERMAN][status] or ""
    local english = Description[ENGLISH][status] or ""

    return common.GetNLS(user, german, english)
end

function M.QuestStart()
    return Start
end

function M.QuestTargets(user, status)
    return QuestTarget[status]
end

function M.QuestFinalStatus()
    return FINAL_QUEST_STATUS
end

function M.QuestAvailability(user, status)
    if factions.isRunewickCitizen(user) and status == 0 then
        return Player.questAvailable
    else
        return Player.questNotAvailable
    end
end

return M
