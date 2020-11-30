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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (526, 'quest.Akaltuts_Chamber_526_dungeon');

local common = require("base.common")
local monsterQuests = require("monster.base.quests")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Die Kammer von Akaltut II"
Title[ENGLISH] = "Akaltut's Chamber II"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Sammle sechs Elfenschwert und bringe sie zum Defensor Sancio."
Description[ENGLISH][1] = "Collect six elven swords for Defensor Sancio."
Description[GERMAN][2] = "Der Defensor Mando hat vielleicht eine Aufgabe f�r dich."
Description[ENGLISH][2] = "The Defensor Mando may have a task for you."

Description[GERMAN][3] = "T�te Drow f�r den Defensor Mando. Du ben�tigst noch zehn."
Description[ENGLISH][3] = "Kill drow for Defensor Mando.  You still need ten."
Description[GERMAN][4] = "T�te Drow f�r den Defensor Mando. Du ben�tigst noch neun."
Description[ENGLISH][4] = "Kill drow for Defensor Mando.  You still need nine."
Description[GERMAN][5] = "T�te Drow f�r den Defensor Mando. Du ben�tigst noch acht."
Description[ENGLISH][5] = "Kill drow for Defensor Mando.  You still need eight."
Description[GERMAN][6] = "T�te Drow f�r den Defensor Mando. Du ben�tigst noch sieben."
Description[ENGLISH][6] = "Kill drow for Defensor Mando.  You still need seven."
Description[GERMAN][7] = "T�te Drow f�r den Defensor Mando. Du ben�tigst noch sechs."
Description[ENGLISH][7] = "Kill drow for Defensor Mando.  You still need six."
Description[GERMAN][8] = "T�te Drow f�r den Defensor Mando. Du ben�tigst noch f�nf."
Description[ENGLISH][8] = "Kill drow for Defensor Mando.  You still need five."
Description[GERMAN][9] = "T�te Drow f�r den Defensor Mando. Du ben�tigst noch vier."
Description[ENGLISH][9] = "Kill drow for Defensor Mando.  You still need four."
Description[GERMAN][10] = "T�te Drow f�r den Defensor Mando. Du ben�tigst noch drei."
Description[ENGLISH][10] = "Kill drow for Defensor Mando.  You still need three."
Description[GERMAN][11] = "T�te Drow f�r den Defensor Mando. Du ben�tigst noch zwei."
Description[ENGLISH][11] = "Kill drow for Defensor Mando.  You still need two."
Description[GERMAN][12] = "T�te Drow f�r den Defensor Mando. Du ben�tigst noch ein."
Description[ENGLISH][12] = "Kill drow for Defensor Mando.  You still need one."
Description[GERMAN][13] = "Kehre zur�ck zum Defensor Mando. Du hast seinen Test bestanden."
Description[ENGLISH][13] = "Report back to Defensor Mando, you have finished his test."

Description[GERMAN][14] = "Der Defensor Confirmo hat vielleicht eine Aufgabe f�r dich."
Description[ENGLISH][14] = "The Defensor Confirmo may have a task for you."

Description[GERMAN][15] = "Finde 'Die Herrschaft Akaltuts' in der Bibliothek und lies es f�r Defensor Confirmo."
Description[ENGLISH][15] = "Find the copy of 'The Reign of Akaltut' in the library and read it for Defensor Confirmo."
Description[GERMAN][16] = "Kehre zu Defensor Confirmo zur�ck um deine Belohnung zu erhalten."
Description[ENGLISH][16] = "Return to Defensor Confirmo for your reward."
Description[GERMAN][17] = "Der Defensor Prohibeo hat vielleicht eine Aufgabe f�r dich."
Description[ENGLISH][17] = "The Defensor Prohibeo may have a task for you."

Description[GERMAN][18] = "T�te zehn Drow Krieger f�r den Defensor Prohibeo. Du ben�tigst noch zehn."
Description[ENGLISH][18] = "Kill drow warrior for Defensor Prohibeo. You still need ten."
Description[GERMAN][19] = "T�te zehn Drow Krieger f�r den Defensor Prohibeo. Du ben�tigst noch neun."
Description[ENGLISH][19] = "Kill drow warrior for Defensor Prohibeo. You still need nine."
Description[GERMAN][20] = "T�te zehn Drow Krieger f�r den Defensor Prohibeo. Du ben�tigst noch acht."
Description[ENGLISH][20] = "Kill drow warrior for Defensor Prohibeo. You still need eight."
Description[GERMAN][21] = "T�te zehn Drow Krieger f�r den Defensor Prohibeo. Du ben�tigst noch sieben."
Description[ENGLISH][21] = "Kill drow warrior for Defensor Prohibeo. You still need seven."
Description[GERMAN][22] = "T�te zehn Drow Krieger f�r den Defensor Prohibeo. Du ben�tigst noch sech."
Description[ENGLISH][22] = "Kill drow warrior for Defensor Prohibeo. You still need six."
Description[GERMAN][23] = "T�te zehn Drow Krieger f�r den Defensor Prohibeo. Du ben�tigst noch f�nf."
Description[ENGLISH][23] = "Kill drow warrior for Defensor Prohibeo. You still need five."
Description[GERMAN][24] = "T�te zehn Drow Krieger f�r den Defensor Prohibeo. Du ben�tigst noch vier."
Description[ENGLISH][24] = "Kill drow warrior for Defensor Prohibeo. You still need four."
Description[GERMAN][25] = "T�te zehn Drow Krieger f�r den Defensor Prohibeo. Du ben�tigst noch drei."
Description[ENGLISH][25] = "Kill drow warrior for Defensor Prohibeo. You still need three."
Description[GERMAN][26] = "T�te zehn Drow Krieger f�r den Defensor Prohibeo. Du ben�tigst noch zwei."
Description[ENGLISH][26] = "Kill drow warrior for Defensor Prohibeo You still need two."
Description[GERMAN][27] = "T�te zehn Drow Krieger f�r den Defensor Prohibeo. Du ben�tigst noch einen."
Description[ENGLISH][27] = "Kill drow warrior for Defensor Prohibeo. You still need one."
Description[GERMAN][28] = "Kehre zur�ck zum Defensor Prohibeo. Du hast seinen Test bestanden."
Description[ENGLISH][28] = "Report back to Defensor Prohibeo, you have finished his test."

Description[GERMAN][29] = "Der Defensor Affligo hat vielleicht eine Aufgabe f�r dich."
Description[ENGLISH][29] = "The Defensor Affligo may have a task for you."

Description[GERMAN][30] = "Du hast den zweiten Teil der Pr�fung bestanden."
Description[ENGLISH][30] = "You have finished part two of the testing."

-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {}

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 30

-- Register the monster kill parts of the quest.
monsterQuests.addQuest{
    questId = 526,
    location = {position = position(470, 802, -9), radius = 100},
    queststatus = {from = 3, to = 13},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Dunkelelfen", english = "drows"},
    npcName = "Defensor Mando",
    monsterGroupIds = {6} -- all drows
}
monsterQuests.addQuest{
    questId = 526,
    location = {position = position(470, 802, -9), radius = 100},
    queststatus = {from = 18, to = 28},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Dunkelelfkrieger", english = "drow warriors"},
    npcName = "Defensor Prohibeo",
    monsterIds = {62} -- drow warrior
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
