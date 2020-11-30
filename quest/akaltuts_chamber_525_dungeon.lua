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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (525, 'quest.Akaltuts_Chamber_525_dungeon');

local common = require("base.common")
local monsterQuests = require("monster.base.quests")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Die Kammer von Akaltut I"
Title[ENGLISH] = "Akaltut's Chamber I"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Nenne Defensor Animositas den Namen des Abenteurers, der den verstreuten Tagebuchseiten nach als erster starb."
Description[ENGLISH][1] = "Tell Defensor Animositas the name of the first adventurer who died according to the diary pages laying around."
Description[GERMAN][2] = "Der Defensor Iracundia hat vielleicht eine Aufgabe f�r dich."
Description[ENGLISH][2] = "The Defensor Iracundia may have a task for you."

Description[GERMAN][3] = "Defensor Iracundia verlangt, dass du den Altarraum findest und die Pergamentrolle liest."
Description[ENGLISH][3] = "Defensor Iracundia requires you to find the altar room and read the pell by the altar."
Description[GERMAN][4] = "Kehre zu Defensor Iracundia zur�ck um deine Belohnung zu erhalten."
Description[ENGLISH][4] = "Return to Defensor Iracundia for your reward."
Description[GERMAN][5] = "Der Defensor Robur hat vielleicht eine Aufgabe f�r dich."
Description[ENGLISH][5] = "The Defensor Robur may have a task for you."

Description[GERMAN][6] = "T�te Drowsch�tzen f�r den Defensor Robur. Du ben�tigst noch f�nf."
Description[ENGLISH][6] = "Kill drow archers for Defensor Robur. You still need five."
Description[GERMAN][7] = "T�te Drowsch�tzen f�r den Defensor Robur. Du ben�tigst noch vier."
Description[ENGLISH][7] = "Kill drow archers for Defensor Robur. You still need four."
Description[GERMAN][8] = "T�te Drowsch�tzen f�r den Defensor Robur. Du ben�tigst noch drei."
Description[ENGLISH][8] = "Kill drow archers for Defensor Robur. You still need three."
Description[GERMAN][9] = "T�te Drowsch�tzen f�r den Defensor Robur. Du ben�tigst noch zwei."
Description[ENGLISH][9] = "Kill drow archers for Defensor Robur. You still need two."
Description[GERMAN][10] = "T�te Drowsch�tzen f�r den Defensor Robur. Du ben�tigst noch einen."
Description[ENGLISH][10] = "Kill drow archers for Defensor Robur. You still need one."
Description[GERMAN][11] = "Kehre zur�ck zum Defensor Robur. Du hast seinen Test bestanden."
Description[ENGLISH][11] = "Report back to Defensor Robur, you have finished his test."

Description[GERMAN][12] = "Der Defensor Impetus hat vielleicht eine Aufgabe f�r dich."
Description[ENGLISH][12] = "The Defensor Impetus may have a task for you."

Description[GERMAN][13] = "T�te Drow f�r den Defensor Impetus. Du ben�tigst noch acht."
Description[ENGLISH][13] = "Kill drow for Defensor Impetus. You still need eight."
Description[GERMAN][14] = "T�te Drow f�r den Defensor Impetus. Du ben�tigst noch sieben."
Description[ENGLISH][14] = "Kill drow for Defensor Impetus. You still need seven."
Description[GERMAN][15] = "T�te Drow f�r den Defensor Impetus. Du ben�tigst noch sechs."
Description[ENGLISH][15] = "Kill drow for Defensor Impetus. You still need six."
Description[GERMAN][16] = "T�te Drow f�r den Defensor Impetus. Du ben�tigst noch f�nf."
Description[ENGLISH][16] = "Kill drow for Defensor Impetus. You still need five."
Description[GERMAN][17] = "T�te Drow f�r den Defensor Impetus. Du ben�tigst noch vier."
Description[ENGLISH][17] = "Kill drow for Defensor Impetus. You still need four."
Description[GERMAN][18] = "T�te Drow f�r den Defensor Impetus. Du ben�tigst noch drei."
Description[ENGLISH][18] = "Kill drow for Defensor Impetus. You still need three."
Description[GERMAN][19] = "T�te Drow f�r den Defensor Impetus. Du ben�tigst noch zwei."
Description[ENGLISH][19] = "Kill drow for Defensor Impetus. You still need two."
Description[GERMAN][20] = "T�te Drow f�r den Defensor Impetus. Du ben�tigst noch einen."
Description[ENGLISH][20] = "Kill drow for Defensor Impetus. You still need one."
Description[GERMAN][21] = "Kehre zur�ck zum Defensor Impetus. Du hast seinen Test bestanden."
Description[ENGLISH][21] = "Report back to Defensor Impetus, you have finished his test."

Description[GERMAN][22] = "Der Defensor Sancio hat vielleicht eine Aufgabe f�r dich."
Description[ENGLISH][22] = "The Defensor Sancio may have a task for you."

Description[GERMAN][23] = "Du hast den ersten Teil der Pr�fung bestanden."
Description[ENGLISH][23] = "You have finished part one of the testing."

-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {}

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 23

-- Register the monster kill parts of the quest.
monsterQuests.addQuest{
    questId = 525,
    location = {position = position(470, 802, -9), radius = 100},
    queststatus = {from = 6, to = 11},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Dunkelelfbogensch�tzen", english = "drow archers"},
    npcName = "Defensor Robur",
    monsterIds = {61} -- drow archer
}
monsterQuests.addQuest{
    questId = 525,
    location = {position = position(470, 802, -9), radius = 100},
    queststatus = {from = 13, to = 21},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Dunkelelfen", english = "drows"},
    npcName = "Defensor Impetus",
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
