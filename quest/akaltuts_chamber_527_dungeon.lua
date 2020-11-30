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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (527, 'quest.Akaltuts_Chamber_527_dungeon');

local common = require("base.common")
local monsterQuests = require("monster.base.quests")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Die Kammer von Akaltut III"
Title[ENGLISH] = "Akaltut's Chamber III"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Sammle ein Drowr�stung und bringe sie zum Defensor Affligo."
Description[ENGLISH][1] = "Collect one drow armour for Defensor Affligo."
Description[GERMAN][2] = "Der Defensor Profligo hat vielleicht eine Aufgabe f�r dich."
Description[ENGLISH][2] = "The Defensor Profligo may have a task for you."

Description[GERMAN][3] = "T�te Drow f�r den Defensor Profligo. Du ben�tigst noch zw�lf."
Description[ENGLISH][3] = "Kill drow for Defensor Profligo.  You still need twelve."
Description[GERMAN][4] = "T�te Drow f�r den Defensor Profligo. Du ben�tigst noch Elfen."
Description[ENGLISH][4] = "Kill drow for Defensor Profligo.  You still need eleven."
Description[GERMAN][5] = "T�te Drow f�r den Defensor Profligo. Du ben�tigst noch zehn."
Description[ENGLISH][5] = "Kill drow for Defensor Profligo.  You still need ten."
Description[GERMAN][6] = "T�te Drow f�r den Defensor Profligo. Du ben�tigst noch neun."
Description[ENGLISH][6] = "Kill drow for Defensor Profligo.  You still need nine."
Description[GERMAN][7] = "T�te Drow f�r den Defensor Profligo. Du ben�tigst noch acht."
Description[ENGLISH][7] = "Kill drow for Defensor Profligo.  You still need eight."
Description[GERMAN][8] = "T�te Drow f�r den Defensor Profligo. Du ben�tigst noch sieben."
Description[ENGLISH][8] = "Kill drow for Defensor Profligo.  You still need seven."
Description[GERMAN][9] = "T�te Drow f�r den Defensor Profligo. Du ben�tigst noch sechs."
Description[ENGLISH][9] = "Kill drow for Defensor Profligo.  You still need six."
Description[GERMAN][10] = "T�te Drow f�r den Defensor Profligo. Du ben�tigst noch f�nf."
Description[ENGLISH][10] = "Kill drow for Defensor Profligo.  You still need five."
Description[GERMAN][11] = "T�te Drow f�r den Defensor Profligo. Du ben�tigst noch vier."
Description[ENGLISH][11] = "Kill drow for Defensor Profligo.  You still need four."
Description[GERMAN][12] = "T�te Drow f�r den Defensor Profligo. Du ben�tigst noch drei."
Description[ENGLISH][12] = "Kill drow for Defensor Profligo.  You still need three."
Description[GERMAN][13] = "T�te Drow f�r den Defensor Profligo. Du ben�tigst noch zwei."
Description[ENGLISH][13] = "Kill drow for Defensor Profligo.  You still need two."
Description[GERMAN][14] = "T�te Drow f�r den Defensor Profligo. Du ben�tigst noch einen."
Description[ENGLISH][14] = "Kill drow for Defensor Profligo.  You still need one."
Description[GERMAN][15] = "Kehre zur�ck zum Defensor Profligo. Du hast seinen Test bestanden."
Description[ENGLISH][15] = "Report back to Defensor Profligo, you have finished his test."

Description[GERMAN][16] = "Der Defensor Depello hat vielleicht eine Aufgabe f�r dich."
Description[ENGLISH][16] = "The Defensor Depello may have a task for you."

Description[GERMAN][17] = "Sammle f�nf Elfenregenbogenschwerter und bringe sie zum Defensor Depello."
Description[ENGLISH][17] = "Collect five elven rainbow swords for Defensor Depello."
Description[GERMAN][18] = "Der Defensor Venenatus hat vielleicht eine Aufgabe f�r dich."
Description[ENGLISH][18] = "The Defensor Venenatus may have a task for you."

Description[GERMAN][19] = "Sammle vier Drowhelme und bringe sie zum Defensor Venenatus."
Description[ENGLISH][19] = "Collect four drow helmets for Defensor Venenatus."
Description[GERMAN][20] = "Der Defensor Torrens hat vielleicht eine Aufgabe f�r dich."
Description[ENGLISH][20] = "The Defensor Torrens may have a task for you."

Description[GERMAN][21] = "Du hast den dritten Teil der Pr�fung bestanden."
Description[ENGLISH][21] = "You have finished part three of the testing."

-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {}

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 21

-- Register the monster kill parts of the quest.
monsterQuests.addQuest{
    questId = 527,
    location = {position = position(470, 802, -9), radius = 100},
    queststatus = {from = 3, to = 15},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Dunkelelfen", english = "drows"},
    npcName = "Defensor Profligo",
    monsterGroupIds = {6} -- all drows
}

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
    return Player.questAvailable
end

return M
