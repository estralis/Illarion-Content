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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (70, 'quest.nana_winterbutter_70_runewick');
     
local common = require("base.common")
local M = {}
     
local GERMAN = Player.german
local ENGLISH = Player.english
     
     
-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Eibenthal"
Title[ENGLISH] = "Yewdale"
     
-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Baue Getreide an und bringe Nana zehn Getreideb�ndel. S�he daf�r Getreide auf dem Feld an und ernte das fertige Getreide mit einer Sense."
Description[ENGLISH][1] = "Produce ten bundles of grain and bring them back to Nana. You can seed grain on the fields and harvest the ripe grain with a scythe."
Description[GERMAN][2] = "Kehre zur�ck zu Nana Winterbutter und frage, ob sie noch eine Aufgabe f�r dich hat."
Description[ENGLISH][2] = "Go back to Nana Winterbutter, she is sure to have another task for you." 
Description[GERMAN][3] = "Besorge zwanzig Tomaten und bringe sie Nana. Tomaten kann man am Feld anpflanzen und mit der Sichel ernten."
Description[ENGLISH][3] = "Produce twenty tomatoes and bring them back to Nana. You can plant tomato seeds on the fields and harvest the ripe plants with a sickle." 
Description[GERMAN][4] = "Kehre zur�ck zu Nana Winterbutter und frage, ob sie noch eine Aufgabe f�r dich hat."
Description[ENGLISH][4] = "Go back to Nana Winterbutter, she is sure to have another task for you."  
Description[GERMAN][5] = "Besorge f�nf Zwiebeln und bringe sie Nana. Zwiebeln kann man am Feld anpflanzen und mit der Sichel ernten."
Description[ENGLISH][5] = "Produce five onions and bring them back to Nana. You can plant onion seeds on the fields and harvest the ripe plants with a sickle."  
Description[GERMAN][6] = "Kehre zur�ck zu Nana Winterbutter und frage, ob sie noch eine Aufgabe f�r dich hat."
Description[ENGLISH][6] = "Go back to Nana Winterbutter, she is sure to have another task for you." 
Description[GERMAN][7] = "Besorge zehn Fische und bringe sie Nana. Stelle dich vor einem Fischschwarm im Wasser und benutze die Angel um Fische zu fangen."
Description[ENGLISH][7] = "Obtain ten fish and bring them back to Nana. To fish, place yourself next to a shoal in the water and use a fishing rod."
Description[GERMAN][8] = "Du hast alle Aufgaben von Nana Winterbutter erf�llt."
Description[ENGLISH][8] = "You have fulfilled all the tasks for Nana Winterbutter." 


-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {791, 798, 0}
 
-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
QuestTarget[1] = {position(847, 828, 0), position (791, 798, 0)} -- Feld
QuestTarget[2] = {position(791, 798, 0)}
QuestTarget[3] = {position(847, 828, 0), position (791, 798, 0)} -- Feld
QuestTarget[4] = {position(791, 798, 0)} 
QuestTarget[5] = {position(847, 828, 0), position (791, 798, 0)} -- Feld
QuestTarget[6] = {position(791, 798, 0)} 
QuestTarget[7] = {position(765, 805, 0), position(791, 798, 0)} -- Angelpunkt
QuestTarget[8] = {position(791, 798, 0)}
     
-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 8
     
     
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
