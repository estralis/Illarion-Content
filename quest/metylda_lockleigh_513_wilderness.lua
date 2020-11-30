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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (513, 'quest.metylda_lockleigh_513_wilderness');

local common = require("base.common")
local factions = require("base.factions")
local monsterQuests = require("monster.base.quests")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Die Eroberung Letmas"
Title[ENGLISH] = "Conquering Letma"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Metylda Lockleigh braucht f�nf Laibe Kartoffelbrot. Sie hat dir f�r die Lieferung eine Belohnung versprochen. "
Description[ENGLISH][1] = "Metylda Lockleigh needs five loaves of potato bread. She has promised to reward you for the delivery."
Description[GERMAN][2] = "Geh zu Metylda. Sie hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][2] = "Go back to Metylda, she certainly has another task for you."

Description[GERMAN][3] = "Metylda Lockleigh m�chte, dass du deine F�higkeiten unter Beweis stellst indem du f�nf D�monenskelette t�test, du musst noch f�nf t�ten. "
Description[ENGLISH][3] = "Metylda Lockleigh wishes you to prove your prowess by killing five demon skeleton servants, you still need to kill five."
Description[GERMAN][4] = "Metylda Lockleigh m�chte, dass du deine F�higkeiten unter Beweis stellst indem du f�nf D�monenskelette t�test, du musst noch vier t�ten. "
Description[ENGLISH][4] = "Metylda Lockleigh wishes you to prove your prowess by killing five demon skeleton servants, you still need to kill four."
Description[GERMAN][5] = "Metylda Lockleigh m�chte, dass du deine F�higkeiten unter Beweis stellst indem du f�nf D�monenskelette t�test, du musst noch drei t�ten. "
Description[ENGLISH][5] = "Metylda Lockleigh wishes you to prove your prowess by killing five demon skeleton servants, you still need to kill three."
Description[GERMAN][6] = "Metylda Lockleigh m�chte, dass du deine F�higkeiten unter Beweis stellst indem du f�nf D�monenskelette t�test, du musst noch zwei t�ten. "
Description[ENGLISH][6] = "Metylda Lockleigh wishes you to prove your prowess by killing five demon skeleton servants, you still need to kill two."
Description[GERMAN][7] = "Metylda Lockleigh m�chte, dass du deine F�higkeiten unter Beweis stellst indem du f�nf D�monenskelette t�test, du musst noch eines t�ten. "
Description[ENGLISH][7] = "Metylda Lockleigh wishes you to prove your prowess by killing five demon skeleton servants, you still need to kill one."
Description[GERMAN][8] = "Gehe zu Metylda zur�ck und teile ihr mit, dass du ihre Aufgabe erledigt hast."
Description[ENGLISH][8] = "Report back to Metylda that you have finished her task."
Description[GERMAN][9] = "Geh zu Metylda. Sie hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][9] = "Go back to Metylda, she certainly has another task for you."

Description[GERMAN][10] = "Metylda m�chte, dass du f�nf Betrachter im Bereich unter dem Berg t�test, du brauchst noch f�nf."
Description[ENGLISH][10] = "Metylda wants you to kill five beholders in the area under the mountain, you still need five."
Description[GERMAN][11] = "Metylda m�chte, dass du f�nf Betrachter im Bereich unter dem Berg t�test, du brauchst noch vier."
Description[ENGLISH][11] = "Metylda wants you to kill five beholders in the area under the mountain, you still need four."
Description[GERMAN][12] = "Metylda m�chte, dass du f�nf Betrachter im Bereich unter dem Berg t�test, du brauchst noch drei."
Description[ENGLISH][12] = "Metylda wants you to kill five beholders in the area under the mountain, you still need three."
Description[GERMAN][13] = "Metylda m�chte, dass du f�nf Betrachter im Bereich unter dem Berg t�test, du brauchst noch zwei."
Description[ENGLISH][13] = "Metylda wants you to kill five beholders in the area under the mountain, you still need two."
Description[GERMAN][14] = "Metylda m�chte, dass du f�nf Betrachter im Bereich unter dem Berg t�test, du brauchst noch einen."
Description[ENGLISH][14] = "Metylda wants you to kill five beholders in the area under the mountain, you still need one."
Description[GERMAN][15] = "Gehe zu Metylda zur�ck und teile ihr mit, dass du ihre Aufgabe erledigt hast."
Description[ENGLISH][15] = "Report back to Metylda that you have finished her task."
Description[GERMAN][16] = "Geh zu Metylda. Sie hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][16] = "Go back to Metylda, she certainly has another task for you."

Description[GERMAN][17] = "�be Rache f�r Metylda und t�te den Goldgolem unter dem Berg."
Description[ENGLISH][17] = "Seek revenge for Metylda, and kill the gold golem below."
Description[GERMAN][18] = "Gehe zu Metylda zur�ck und teile ihr mit, dass du ihre Aufgabe erledigt hast."
Description[ENGLISH][18] = "Report back to Metylda that you have finished her task."
Description[GERMAN][19] = "Geh zu Metylda. Sie hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][19] = "Go back to Metylda, she certainly has another task for you."


Description[GERMAN][20] = "Du suchst f�r Metylda Lockleigh nach der L�sung f�r das R�tzel der S�ulen."
Description[ENGLISH][20] = "You search out the answer to the riddle of the columns below for Metylda Lockleigh."
Description[GERMAN][21] = "Du suchst f�r Metylda Lockleigh nach der L�sung f�r das R�tzel der S�ulen. Bisher hast du 'P'."
Description[ENGLISH][21] = "You search out the answer to the riddle of the columns below for Metylda Lockleigh, so far you have 'P'."
Description[GERMAN][22] = "Du suchst f�r Metylda Lockleigh nach der L�sung f�r das R�tzel der S�ulen. Bisher hast du 'PR'."
Description[ENGLISH][22] = "You search out the answer to the riddle of the columns below for Metylda Lockleigh, so far you have 'PR'."
Description[GERMAN][23] = "Du suchst f�r Metylda Lockleigh nach der L�sung f�r das R�tzel der S�ulen. Bisher hast du 'PRE'."
Description[ENGLISH][23] = "You search out the answer to the riddle of the columns below for Metylda Lockleigh, so far you have 'PRE'."
Description[GERMAN][24] = "Du suchst f�r Metylda Lockleigh nach der L�sung f�r das R�tzel der S�ulen. Bisher hast du 'PREA'."
Description[ENGLISH][24] = "You search out the answer to the riddle of the columns below for Metylda Lockleigh, so far you have 'PREA'."
Description[GERMAN][25] = "Du suchst f�r Metylda Lockleigh nach der L�sung f�r das R�tzel der S�ulen. Bisher hast du 'PREAC'."
Description[ENGLISH][25] = "You search out the answer to the riddle of the columns below for Metylda Lockleigh, so far you have 'PREAC'."
Description[GERMAN][26] = "Du suchst f�r Metylda Lockleigh nach der L�sung f�r das R�tzel der S�ulen. Bisher hast du 'PREACE'."
Description[ENGLISH][26] = "You search out the answer to the riddle of the columns below for Metylda Lockleigh, so far you have 'PREACE'."
Description[GERMAN][27] = "Du suchst f�r Metylda Lockleigh nach der L�sung f�r das R�tzel der S�ulen. Bisher hast du 'PREACER'."
Description[ENGLISH][27] = "You search out the answer to the riddle of the columns below for Metylda Lockleigh, so far you have 'PREACER'."
Description[GERMAN][28] = "Du suchst f�r Metylda Lockleigh nach der L�sung f�r das R�tzel der S�ulen. Bisher hast du 'PREACERD'."
Description[ENGLISH][28] = "You search out the answer to the riddle of the columns below for Metylda Lockleigh, so far you have 'PREACERD'."
Description[GERMAN][29] = "Du suchst f�r Metylda Lockleigh nach der L�sung f�r das R�tzel der S�ulen. Bisher hast du 'PREACERDH'."
Description[ENGLISH][29] = "You search out the answer to the riddle of the columns below for Metylda Lockleigh, so far you have 'PREACERDH'."
Description[GERMAN][30] = "Du suchst f�r Metylda Lockleigh nach der L�sung f�r das R�tzel der S�ulen. Bisher hast du 'PREACERDHA'."
Description[ENGLISH][30] = "You search out the answer to the riddle of the columns below for Metylda Lockleigh, so far you have 'PREACERDHA'."
Description[GERMAN][31] = "Du suchst f�r Metylda Lockleigh nach der L�sung f�r das R�tzel der S�ulen. Bisher hast du 'PREACERDHAL'. Gehe zu Metylda zur�ck und teile ihr mit, dass du ihre Aufgabe erledigt hast."
Description[ENGLISH][31] = "You search out the answer to the riddle of the columns below for Metylda Lockleigh, so far you have 'PREACERDHAL'. Report back to Metylda that you have finished her task."


Description[GERMAN][32] = "Du hast alle Aufgaben f�r Metylda Lockleigh erledigt."
Description[ENGLISH][32] = "You have finished all tasks for Metylda Lockleigh."

-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {249, 809, 1}

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
QuestTarget[1] = {position(249, 809, 1)}
QuestTarget[2] = {position(249, 809, 1)}
QuestTarget[3] = {position(249, 809, 1)}
QuestTarget[4] = {position(249, 809, 1)}
QuestTarget[5] = {position(249, 809, 1)}
QuestTarget[6] = {position(249, 809, 1)}
QuestTarget[7] = {position(249, 809, 1)}
QuestTarget[8] = {position(249, 809, 1)}
QuestTarget[9] = {position(249, 809, 1)}
QuestTarget[10] = {position(249, 809, 1)}
QuestTarget[11] = {position(249, 809, 1)}
QuestTarget[12] = {position(249, 809, 1)}
QuestTarget[13] = {position(249, 809, 1)}
QuestTarget[14] = {position(249, 809, 1)}
QuestTarget[15] = {position(249, 809, 1)}
QuestTarget[16] = {position(249, 809, 1)}
QuestTarget[17] = {position(249, 809, 1)}
QuestTarget[18] = {position(249, 809, 1)}
QuestTarget[19] = {position(249, 809, 1)}
QuestTarget[20] = {position(249, 809, 1)}
QuestTarget[21] = {position(249, 809, 1)}
QuestTarget[22] = {position(249, 809, 1)}
QuestTarget[23] = {position(249, 809, 1)}
QuestTarget[24] = {position(249, 809, 1)}
QuestTarget[25] = {position(249, 809, 1)}
QuestTarget[26] = {position(249, 809, 1)}
QuestTarget[27] = {position(249, 809, 1)}
QuestTarget[28] = {position(249, 809, 1)}
QuestTarget[29] = {position(249, 809, 1)}
QuestTarget[30] = {position(249, 809, 1)}
QuestTarget[31] = {position(249, 809, 1)}
QuestTarget[32] = {position(249, 809, 1)}


-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 32

-- Register the monster kill parts of the quest.
monsterQuests.addQuest{
    questId = 513,
    location = {position = position(268, 785, -3), radius = 65},
    queststatus = {from = 3, to = 8},
    questTitle = {german = "Die Eroberung Letmas II", english = "Conquering Letma II"},
    monsterName = {german = "D�monenskelett Diener", english = "Demon Skeleton Servant"},
    npcName = "Metylda Lockleigh",
    monsterIds = {206} -- demon skeleton servants
}

monsterQuests.addQuest{
    questId = 513,
    location = {position = position(220, 812, -6), radius = 65},
    queststatus = {from = 10, to = 15},
    questTitle = {german = "Die Eroberung Letmas III", english = "Conquering Letma III"},
    monsterName = {german = "Betrachter", english = "Beholders"},
    npcName = "Metylda Lockleigh",
    monsterGroupIds = {12,13,14} -- all Beholders
}

monsterQuests.addQuest{
    questId = 513,
    location = {position = position(228, 799, -8), radius = 65},
    queststatus = {from = 17, to = 18},
    questTitle = {german = "Die Eroberung Letmas IV", english = "Conquering Letma IV"},
    monsterName = {german = "Goldgolem", english = "Gold Golem"},
    npcName = "Metylda Lockleigh",
    monsterIds = {564} -- Gold Golem
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
    if status == 0 then
        return Player.questAvailable
    else
        return Player.questNotAvailable
    end
end

return M
