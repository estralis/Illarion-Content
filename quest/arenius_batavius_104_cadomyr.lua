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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (104, 'quest.arenius_batavius_104_cadomyr');

local common = require("base.common")
local monsterQuests = require("monster.base.quests")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Der fehlgeleitete Kreuzzug"
Title[ENGLISH] = "The Errant Crusade"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Besorge sechs wei�e Stoffbahnen und bringe sie Arenius. Du kannst sie bei einem H�ndler kaufen oder mit einer Schere in der Hand am Webstuhl herstellen."
Description[ENGLISH][1] = "Produce six bolts of white cloth and bring them to Arenius. You can buy them from a merchant or produce them by using a pair of scissors in your hand, whilst standing in front of a weaving loom."
Description[GERMAN][2] = "Gehe zu Arenius Batavius, der sich am Gasthaus 'Seeufer' in Cadomyr aufh�lt. Er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][2] = "Go back to Arenius Batavius next to the Inn 'Lakeshore' in Cadomyr, he will certainly have another task for you."
Description[GERMAN][3] = "Gehe in den Unterschlupf des Kults der Salavesh und t�te sechs Mumien und bringe Arenius die Eingeweide einer Mumie. Du findest den Unterschlupf in einem Berg voller Untoter nahe dem Gasthaus zur Hanfschlinge."
Description[ENGLISH][3] = "Go into the stronghold of the Cult of Salavesh and kill six mummies. Then bring Arenius the entrails of one mummy. You find the stronghold deep in a mountain full of undeads near the Hemp Necktie Inn."
Description[GERMAN][4] = "T�te noch f�nf Mumien."
Description[ENGLISH][4] = "Kill five mummies."
Description[GERMAN][5] = "T�te noch vier Mumien."
Description[ENGLISH][5] = "Kill four mummies."
Description[GERMAN][6] = "T�te noch drei Mumien."
Description[ENGLISH][6] = "Kill three mummies."
Description[GERMAN][7] = "T�te noch two Mumien."
Description[ENGLISH][7] = "Kill two mummies."
Description[GERMAN][8] = "T�te noch eine Mumie."
Description[ENGLISH][8] = "Kill one mummy."
Description[GERMAN][9] = "Kehre zu Arenius Batavius zur�ck und bringe ihm die Eingeweide einer Mumie."
Description[ENGLISH][9] = "Return to Arenius Batavius and bring him the entrails of one mummy."
Description[GERMAN][10] = "Gehe zu Arenius Batavius, der sich am Gasthaus 'Seeufer' in Cadomyr aufh�lt. Er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][10] = "Go back to Arenius Batavius next to the Inn 'Lakeshore' in Cadomyr, he will certainly have another task for you."
Description[GERMAN][11] = "Gehe in den Unterschlupf des Kults der Salavesh und t�te zw�lf Skelette. Solltest du nicht genug Skelette finden bedenke, dass diese recht bald wieder auferstehen und Nekromanten Skelette rufen."
Description[ENGLISH][11] = "Go into the stronghold of the Cult of Salavesh and kill twelve skeletons. If there aren't enough skelettons please take into consideration the skeletons resurrect quickly and the necromancer summons some."
Description[GERMAN][12] = "T�te noch elf Skelette. Solltest du nicht genug Skelette finden bedenke, dass diese recht bald wieder auferstehen und Nekromanten Skelette rufen."
Description[ENGLISH][12] = "Kill eleven skeletons. If there aren't enough skelettons please take into consideration the skeletons resurrect quickly and the necromancer summons some.."
Description[GERMAN][13] = "T�te noch zehn Skelette. Solltest du nicht genug Skelette finden bedenke, dass diese recht bald wieder auferstehen und Nekromanten Skelette rufen."
Description[ENGLISH][13] = "Kill ten skeletons. If there aren't enough skelettons please take into consideration the skeletons resurrect quickly and the necromancer summons some."
Description[GERMAN][14] = "T�te noch neun Skelette. Solltest du nicht genug Skelette finden bedenke, dass diese recht bald wieder auferstehen und Nekromanten Skelette rufen."
Description[ENGLISH][14] = "Kill nine skeletons. If there aren't enough skelettons please take into consideration the skeletons resurrect quickly and the necromancer summons some."
Description[GERMAN][15] = "T�te noch acht Skelette. Solltest du nicht genug Skelette finden bedenke, dass diese recht bald wieder auferstehen und Nekromanten Skelette rufen."
Description[ENGLISH][15] = "Kill eight skeletons. If there aren't enough skelettons please take into consideration the skeletons resurrect quickly and the necromancer summons some."
Description[GERMAN][16] = "T�te noch sieben Skelette. Solltest du nicht genug Skelette finden bedenke, dass diese recht bald wieder auferstehen und Nekromanten Skelette rufen."
Description[ENGLISH][16] = "Kill seven skeletons. If there aren't enough skelettons please take into consideration the skeletons resurrect quickly and the necromancer summons some."
Description[GERMAN][17] = "T�te noch sechs Skelette. Solltest du nicht genug Skelette finden bedenke, dass diese recht bald wieder auferstehen und Nekromanten Skelette rufen."
Description[ENGLISH][17] = "Kill six skeletons. If there aren't enough skelettons please take into consideration the skeletons resurrect quickly and the necromancer summons some."
Description[GERMAN][18] = "T�te noch f�nf Skelette. Solltest du nicht genug Skelette finden bedenke, dass diese recht bald wieder auferstehen und Nekromanten Skelette rufen."
Description[ENGLISH][18] = "Kill five skeletons. If there aren't enough skelettons please take into consideration the skeletons resurrect quickly and the necromancer summons some."
Description[GERMAN][19] = "T�te noch vier Skelette. Solltest du nicht genug Skelette finden bedenke, dass diese recht bald wieder auferstehen und Nekromanten Skelette rufen."
Description[ENGLISH][19] = "Kill four skeletons. If there aren't enough skelettons please take into consideration the skeletons resurrect quickly and the necromancer summons some."
Description[GERMAN][20] = "T�te noch drei Skelette. Solltest du nicht genug Skelette finden bedenke, dass diese recht bald wieder auferstehen und Nekromanten Skelette rufen."
Description[ENGLISH][20] = "Kill three skeletons. If there aren't enough skelettons please take into consideration the skeletons resurrect quickly and the necromancer summons some."
Description[GERMAN][21] = "T�te noch zwei Skelette. Solltest du nicht genug Skelette finden bedenke, dass diese recht bald wieder auferstehen und Nekromanten Skelette rufen."
Description[ENGLISH][21] = "Kill two skeletons. If there aren't enough skelettons please take into consideration the skeletons resurrect quickly and the necromancer summons some."
Description[GERMAN][22] = "T�te noch ein Skelett. Solltest du nicht genug Skelette finden bedenke, dass diese recht bald wieder auferstehen und Nekromanten Skelette rufen."
Description[ENGLISH][22] = "Kill one skeleton. If there aren't enough skelettons please take into consideration the skeletons resurrect quickly and the necromancer summons some."
Description[GERMAN][23] = "Kehre zu Arenius Batavius zur�ck."
Description[ENGLISH][23] = "Return to Arenius Batavius."
Description[GERMAN][24] = "Kehre zu Arenius Batavius zur�ck."
Description[ENGLISH][24] = "Return to Arenius Batavius."
Description[GERMAN][25] = "Gehe zu Arenius Batavius, der sich am Gasthaus 'Seeufer' in Cadomyr aufh�lt. Er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][25] = "Go back to Arenius Batavius next to the Inn 'Lakeshore' in Cadomyr, he will certainly have another task for you."
Description[GERMAN][26] = "Gehe in den Unterschlupf des Kults der Salavesh und t�te zwei menschliche Nekromanten. Solltest du keinen antreffen w�re es sinnvoll einen Tag sp�ter noch einmal vorbeizuschauen."
Description[ENGLISH][26] = "Go into the stronghold of the Cult of Salavesh and kill two human necromancer. If there is no necromancer to find, you may come back another day and find one."
Description[GERMAN][27] = "T�te noch einen menschlichen Nekromanten. Solltest du keinen antreffen w�re es sinnvoll einen Tag sp�ter noch einmal vorbeizuschauen."
Description[ENGLISH][27] = "Kill one human necromancer. If there is no necromancer to find you may come back another day and find one"
Description[GERMAN][28] = "Kehre zu Arenius Batavius zur�ck."
Description[ENGLISH][28] = "Return to Arenius Batavius."
Description[GERMAN][29] = "Gehe zu Arenius Batavius, der sich am Gasthaus 'Seeufer' in Cadomyr aufh�lt. Er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][29] = "Go back to Arenius Batavius next to the Inn 'Lakeshore' in Cadomyr, he will certainly have another task for you."
Description[GERMAN][30] = "Gehe in den Unterschlupf des Kults der Salavesh und t�te ein D�monenskelett. Vielleicht brauchst du auch die Hilfe deiner Freunde um so ein schreckliches Monster zu t�ten."
Description[ENGLISH][30] = "Go into the stronghold of the Cult of Salavesh and kill a demon skeleton. You might need help from friends to kill such a monster."
Description[GERMAN][31] = "Kehre zu Arenius Batavius zur�ck."
Description[ENGLISH][31] = "Return to Arenius Batavius."
Description[GERMAN][32] = "Gehe zu Arenius Batavius, der sich am Gasthaus 'Seeufer' in Cadomyr aufh�lt. Er hat bestimmt noch eine Aufgabe f�r dich."
Description[ENGLISH][32] = "Go back to Arenius Batavius next to the Inn 'Lakeshore' in Cadomyr, he will certainly have another task for you."
Description[GERMAN][33] = "Gehe in den Unterschlupf des Kults der Salavesh und t�te den Nachtdrachen. Wahrscheinlich solltest du deine Freunde bitten mitzukommen. Ein Nachtdrache ist nicht leicht zu t�ten."
Description[ENGLISH][33] = "Go into the stronghold of the Cult of Salavesh and kill the Night Dragon. It might be better if you ask your friends for support. It's not easy to kill a Night Dragon."
Description[GERMAN][34] = "Kehre zu Arenius Batavius zur�ck."
Description[ENGLISH][34] = "Return to Arenius Batavius."
Description[GERMAN][35] = "Du hast alle Aufgaben von Arenius Batavius erf�llt."
Description[ENGLISH][35] = "You have fulfilled all tasks for Arenius Batavius."

-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {86, 586, 0}

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
QuestTarget[1] = {position(86, 586, 0), position(113, 611, 0), position(141, 576, 0)} 
QuestTarget[2] = {position(86, 586, 0)}
QuestTarget[3] = {position(670, 408, -3)} 
QuestTarget[4] = {position(670, 408, -3)}
QuestTarget[5] = {position(670, 408, -3)} 
QuestTarget[6] = {position(670, 408, -3)}
QuestTarget[7] = {position(670, 408, -3)} 
QuestTarget[8] = {position(670, 408, -3)}
QuestTarget[9] = {position(86, 586, 0)} 
QuestTarget[10] = {position(86, 586, 0)}
QuestTarget[11] = {position(670, 408, -3)} 
QuestTarget[12] = {position(670, 408, -3)}
QuestTarget[13] = {position(670, 408, -3)} 
QuestTarget[14] = {position(670, 408, -3)} 
QuestTarget[15] = {position(670, 408, -3)} 
QuestTarget[16] = {position(670, 408, -3)}
QuestTarget[17] = {position(670, 408, -3)} 
QuestTarget[18] = {position(670, 408, -3)}
QuestTarget[19] = {position(670, 408, -3)} 
QuestTarget[20] = {position(670, 408, -3)} 
QuestTarget[21] = {position(670, 408, -3)} 
QuestTarget[22] = {position(670, 408, -3)} 
QuestTarget[23] = {position(86, 586, 0)}
QuestTarget[24] = {position(86, 586, 0)}
QuestTarget[25] = {position(86, 586, 0)}
QuestTarget[26] = {position(670, 408, -3)} 
QuestTarget[27] = {position(670, 408, -3)} 
QuestTarget[28] = {position(86, 586, 0)}
QuestTarget[29] = {position(86, 586, 0)} 
QuestTarget[30] = {position(670, 408, -3)} 
QuestTarget[31] = {position(86, 586, 0)}
QuestTarget[32] = {position(86, 586, 0)}
QuestTarget[33] = {position(688, 392, -3)} 
QuestTarget[34] = {position(86, 586, 0)}
QuestTarget[35] = {position(86, 586, 0)}

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 35

-- Register the monster kill parts of the quest.
monsterQuests.addQuest{
    questId = 104,
    location = {position = position(705, 410, -3), radius = 75},
    queststatus = {from = 3, to = 9},
    questTitle = {german = "Der fehlgeleitete Kreuzzug II", english = "The Errant Crusade II"},
    monsterName = {german = "Mumien", english = "mummies"},
    npcName = "Arenius Batavius",
    raceIds = {10} -- all mummies
}
monsterQuests.addQuest{
    questId = 104,
    location = {position = position(705, 410, -3), radius = 75},
    queststatus = {from = 11, to = 23},
    questTitle = {german = "Der fehlgeleitete Kreuzzug III", english = "The Errant Crusade III"},
    monsterName = {german = "Skelette", english = "skeletons"},
    npcName = "Arenius Batavius",
    raceIds = {11} -- all skeletons
}
monsterQuests.addQuest{
    questId = 104,
    location = {position = position(705, 410, -3), radius = 75},
    queststatus = {from = 26, to = 28},
    questTitle = {german = "Der fehlgeleitete Kreuzzug IV", english = "The Errant Crusade IV"},
    monsterName = {german = "Blutmagier", english = "blood mages"},
    npcName = "Arenius Batavius",
    monsterIds = {4} -- human mages
}
monsterQuests.addQuest{
    questId = 104,
    location = {position = position(705, 410, -3), radius = 75},
    queststatus = {from = 30, to = 31},
    questTitle = {german = "Der fehlgeleitete Kreuzzug V", english = "The Errant Crusade V"},
    monsterName = {german = "den D�monenskelettkrieger", english = "the demon skeleton warrior"},
    npcName = "Arenius Batavius",
    monsterIds = {201} -- demon skeleton
}
monsterQuests.addQuest{
    questId = 104,
    location = {position = position(705, 410, -3), radius = 75},
    queststatus = {from = 33, to = 34},
    questTitle = {german = "Der fehlgeleitete Kreuzzug VI", english = "The Errant Crusade VI"},
    monsterName = {german = "den Nachtdrache", english = "the Night Dragon"},
    npcName = "Arenius Batavius",
    monsterIds = {1121} -- Night Dragon
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
return M
