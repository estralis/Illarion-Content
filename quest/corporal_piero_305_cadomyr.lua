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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (305, 'quest.corporal_piero_305_cadomyr');

local common = require("base.common")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Spionage bei den Piraten"
Title[ENGLISH] = "Spy the pirates"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Finde Tobis Vunu. Es versteckt sich irgendwo in der Piratenbucht. Frage ihn nach Informationen f�r Corporal Piero."
Description[ENGLISH][1] = "Find Tobis Vunu. He hides somewhere in the pirate bay. Ask him about information for Corporal Piero."
Description[GERMAN][2] = "Finde das Tabakfeld der Piraten und brenn es mit einer Fackel nieder. Tobis Vuno gab die einige Hemden und einen Schlapphut aus Best�nden der Piraten. Vielleicht solltest du dich wie ein Pirat um die Wache zu t�uschen?"
Description[ENGLISH][2] = "Find the tobacco field of the pirates and burn it down with a torch. You obtained some shirts and a hat from Tobis Vuno that pirates usually wear. Maybe you should dress up to cheat the guards?"
Description[GERMAN][3] = "Gehe zur�ck zu Tobis Vuno und berichte."
Description[ENGLISH][3] = "Go back to Tobis Vuno and report."
Description[GERMAN][4] = "Frage Tobis Vuno noch nach den Informationen f�r Corporal Piero."
Description[ENGLISH][4] = "Ask Tobis Vuno about the information for Corporal Piero."
Description[GERMAN][5] = "Gehe zur�ck zu Corporal Piero und berichte."
Description[ENGLISH][5] = "Go back to Corporal Piero and report."


-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {39, 649, 0}

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
QuestTarget[1] = {position(42, 517, 0)}  -- Tobis Vunu
QuestTarget[2] = {position(6, 567, 0)}   -- Tobaco field
QuestTarget[3] = {position(42, 517, 0)}  -- Tobis Vunu
QuestTarget[4] = {position(42, 517, 0)}  -- Tobis Vunu
QuestTarget[5] = {position(39, 649, 0)}  -- Corporal Piero
--QuestTarget[1] = {position(x, y, 100), position(x, y, 100)}

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
return M
