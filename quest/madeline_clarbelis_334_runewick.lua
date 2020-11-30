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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (334, 'quest.madeline_clarbelis_334_runewick');

local common = require("base.common")
local M = {}
    
    
local GERMAN = Player.german
local ENGLISH = Player.english
     
    
-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Der faule Lehrling"
Title[ENGLISH] = "The Lazy Apprentice"
     
-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[ENGLISH][1] =  "Pick four foot leaves from ferns in the grass and two firnis blossoms from the flowering plants in the woods."
Description[GERMAN][1] = "Besorge vier Fussblatt und zwei Firnisbl�ten. Fussblatt findest du im Farn der auf Gras w�chst und Firnisbl�ten�in Blumen die im Wald wachsen. "
Description[GERMAN][2] = "Du hast die Aufgabe von Madeline Clarbelis erf�llt."
Description[ENGLISH][2] = "You have fulfilled the task for Madeline Clarbelis."


-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {903, 757, 0}
 
-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
QuestTarget[1] = {position(903, 757, 0), position (857, 821, 0), position (851, 826, 0)} -- NPC Ausgangspunkt
QuestTarget[2] = {position(903, 757, 0)} --NPC Questabgabe

     
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

function M.QuestStart()
    return Start
end
     
function M.QuestTargets(user, status)
    return QuestTarget[status]
end
     
function M.QuestFinalStatus()
    return FINAL_QUEST_STATUS
end

return M
