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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (501, 'quest.ssalva_501_wilderness');

local common = require("base.common")
local factions = require("base.factions")
local monsterQuests = require("monster.base.quests")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Zzarn'K'Ska von Zelphia"
Title[ENGLISH] = "Zzarn'K'Ska of Zelphia"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Finde den Eingang zur H�hle des Sees des Lebens und berichte Salva davon."
Description[ENGLISH][1] = "Find the entrance to the Lake of Life Dungeon and tell Ssalva of it."
Description[GERMAN][2] = "Kehre zu Ssalva zur�ck. Du hast ihre Aufgabe erledigt."
Description[ENGLISH][2] = "Return to Ssalva, you have finished her task."

Description[GERMAN][3] = "Rede mit Ssalva, sie hat vielleicht eine weitere Aufgabe f�r dich."
Description[ENGLISH][3] = "Check with Ssalva, she may have another task for you."

Description[GERMAN][4] = "Erforsche die H�hle des Sees des Lebens und finde die zweite gro�e Insel, bevor du zu Salva zur�ckkehrst, um zu berichten."
Description[ENGLISH][4] = "Explore the Lake of Life Dungeon and find the second major island before reporting back to Ssalva."
Description[GERMAN][5] = "Kehre zu Ssalva zur�ck. Du hast ihre Aufgabe erledigt."
Description[ENGLISH][5] = "Return to Ssalva, you have finished her task."

Description[GERMAN][6] = "Rede mit Ssalva, sie hat vielleicht eine weitere Aufgabe f�r dich."
Description[ENGLISH][6] = "Check with Ssalva, she may have another task for you."

Description[GERMAN][7] = "T�te die friedlichen Untoten am See des Lebens f�r Ssalva. Du musst noch f�nf t�ten."
Description[ENGLISH][7] = "Kill the peaceful undead at the Lake of Life for Ssalva. You still need five."
Description[GERMAN][8] = "T�te die friedlichen Untoten am See des Lebens f�r Ssalva. Du musst noch vier t�ten."
Description[ENGLISH][8] = "Kill the peaceful undead at the Lake of Life for Ssalva. You still need four."
Description[GERMAN][9] = "T�te die friedlichen Untoten am See des Lebens f�r Ssalva. Du musst noch drei t�ten."
Description[ENGLISH][9] = "Kill the peaceful undead at the Lake of Life for Ssalva. You still need three."
Description[GERMAN][10] = "T�te die friedlichen Untoten am See des Lebens f�r Ssalva. Du musst noch zwei t�ten."
Description[ENGLISH][10] = "Kill the peaceful undead at the Lake of Life for Ssalva. You still need two."
Description[GERMAN][11] = "T�te die friedlichen Untoten am See des Lebens f�r Ssalva. Du musst noch einen t�ten."
Description[ENGLISH][11] = "Kill the peaceful undead at the Lake of Life for Ssalva. You still need one."
Description[GERMAN][12] = "Kehre zu Ssalva zur�ck. Du hast ihre Aufgabe erledigt."
Description[ENGLISH][12] = "Return to Ssalva, you have finished her task."

Description[GERMAN][13] = "Rede mit Ssalva, sie hat vielleicht eine weitere Aufgabe f�r dich."
Description[ENGLISH][13] = "Check with Ssalva, she may have another task for you."

Description[GERMAN][14] = "Finde die Opferstelle im See des Lebens und opfere Tanora dort eine Wasserbl�te. *Lege den Gegenstand auf die Opferplatte im Verlies.* Danach kehre zu Salva zur�ck, um weitere Anweisungen zu erhalten."
Description[ENGLISH][14] = "Find the offering plate in the Lake of Life and leave an offering of one waterblossom for Tanora. *Place the item on the offering plate inside the dungeon.* After doing so, report back to Ssalva for further instructions."
Description[GERMAN][15] = "Kehre zu Ssalva zur�ck. Du hast ihre Aufgabe erledigt."
Description[ENGLISH][15] = "Return to Ssalva, you have finished her task."

Description[GERMAN][16] = "Rede mit Ssalva, sie hat vielleicht eine weitere Aufgabe f�r dich."
Description[ENGLISH][16] = "Check with Ssalva, she may have another task for you."

Description[GERMAN][17] = "Beschaffe f�nf Fische jeder Art (Lachs, Forelle, Stachelmakrele und Rotbarsch), zwanzig Eier, eine Eiercremetorte und zwei Fischsuppen. Finde Zenia und tausche die Gegenst�nde gegen Informationen und berichte diese an Salva."
Description[ENGLISH][17] = "Gather five of each fish (trout, salmon, horse mackerel, and rose fish), 20 eggs, one custard pie, two fish soups. Find Zenia and exchange the items for some information and report back to Ssalva."
Description[GERMAN][18] = "Kehre zu Ssalva zur�ck. Du hast ihre Aufgabe erledigt."
Description[ENGLISH][18] = "Return to Ssalva, you have finished her task."

Description[GERMAN][19] = "Rede mit Ssalva, sie hat vielleicht eine weitere Aufgabe f�r dich."
Description[ENGLISH][19] = "Check with Ssalva, she may have another task for you."

Description[GERMAN][20] = "T�te die Renegaten f�r Ssalva. Du musst noch f�nfzehn erledigen."
Description[ENGLISH][20] = "Kill renegades for Ssalva. You still need fifteen."
Description[GERMAN][21] = "T�te die Renegaten f�r Ssalva. Du musst noch vierzehn erledigen."
Description[ENGLISH][21] = "Kill renegades for Ssalva. You still need fourteen."
Description[GERMAN][22] = "T�te die Renegaten f�r Ssalva. Du musst noch dreizehn erledigen."
Description[ENGLISH][22] = "Kill renegades for Ssalva. You still need thirteen."
Description[GERMAN][23] = "T�te die Renegaten f�r Ssalva. Du musst noch zw�lf erledigen."
Description[ENGLISH][23] = "Kill renegades for Ssalva. You still need twelve."
Description[GERMAN][24] = "T�te die Renegaten f�r Ssalva. Du musst noch elf erledigen."
Description[ENGLISH][24] = "Kill renegades for Ssalva. You still need eleven."
Description[GERMAN][25] = "T�te die Renegaten f�r Ssalva. Du musst noch zehn erledigen."
Description[ENGLISH][25] = "Kill renegades for Ssalva. You still need ten."
Description[GERMAN][26] = "T�te die Renegaten f�r Ssalva. Du musst noch neun erledigen."
Description[ENGLISH][26] = "Kill renegades for Ssalva. You still need nine."
Description[GERMAN][27] = "T�te die Renegaten f�r Ssalva. Du musst noch acht erledigen."
Description[ENGLISH][27] = "Kill renegades for Ssalva. You still need eight."
Description[GERMAN][28] = "T�te die Renegaten f�r Ssalva. Du musst noch sieben erledigen."
Description[ENGLISH][28] = "Kill renegades for Ssalva. You still need seven."
Description[GERMAN][29] = "T�te die Renegaten f�r Ssalva. Du musst noch sechs erledigen."
Description[ENGLISH][29] = "Kill renegades for Ssalva. You still need six."
Description[GERMAN][30] = "T�te die Renegaten f�r Ssalva. Du musst noch f�nf erledigen."
Description[ENGLISH][30] = "Kill renegades for Ssalva. You still need five."
Description[GERMAN][31] = "T�te die Renegaten f�r Ssalva. Du musst noch vier erledigen."
Description[ENGLISH][31] = "Kill renegades for Ssalva. You still need four."
Description[GERMAN][32] = "T�te die Renegaten f�r Ssalva. Du musst noch drei erledigen."
Description[ENGLISH][32] = "Kill renegades for Ssalva. You still need three."
Description[GERMAN][33] = "T�te die Renegaten f�r Ssalva. Du musst noch zwei erledigen."
Description[ENGLISH][33] = "Kill renegades for Ssalva. You still need two."
Description[GERMAN][34] = "T�te die Renegaten f�r Ssalva. Du musst noch einen erledigen."
Description[ENGLISH][34] = "Kill renegades for Ssalva. You still need one."
Description[GERMAN][35] = "Kehre zu Ssalva zur�ck. Du hast ihre Aufgabe erledigt."
Description[ENGLISH][35] = "Return to Ssalva, you have finished her task."

Description[GERMAN][36] = "Rede mit Ssalva, sie hat vielleicht eine weitere Aufgabe f�r dich."
Description[ENGLISH][36] = "Check with Ssalva, she may have another task for you."

Description[GERMAN][37] = "T�te den Anf�hrer der Echsen-Tempelgarde und brich die Moral der Extremistengruppe."
Description[ENGLISH][37] = "Kill the lizard temple warrior leader and break the morale of the extremist group."

Description[GERMAN][38] = "Kehre zu Ssalva zur�ck. Du hast ihre Aufgabe erledigt."
Description[ENGLISH][38] = "Return to Ssalva, you have finished her task."

Description[GERMAN][39] = "Du hast alle Aufgaben f�r Ssalva erledigt."
Description[ENGLISH][39] = "You have completed all tasks of Ssalva."

local npcPos = position(567, 230, -0);

-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = npcPos;

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
for i = 1, 39 do
  QuestTarget[i] = {npcPos};
end

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 39

-- Register the monster kill parts of the quest.
monsterQuests.addQuest{
    questId = 501,
    location = {position = position(716, 200, -9), radius = 100},
    queststatus = {from = 7, to = 12},
    questTitle = {german = "Zzarn'K'Ska von Zelphia", english = "Zzarn'K'Ska of Zelphia"},
    monsterName = {german = "friedlichen Untoten", english = "peaceful undead"},
    npcName = "Ssalva",
    monsterIds = {116,106} -- worker mummies and friendly skeletons
}    
    
monsterQuests.addQuest{
    questId = 501,
    locations = {
        {position = position(748, 245, -9), radius = 150},
        {position = position(557, 263, 0), radius = 25}
    },
    queststatus = {from = 20, to = 35},
    questTitle = {german = "Zzarn'K'Ska von Zelphia", english = "Zzarn'K'Ska of Zelphia"},
    monsterName = {german = "Echsenmenschen", english = "Lizards"},
    npcName = "Ssalva",
    monsterIds = {51,52,53,54,55} -- all lizards
}
monsterQuests.addQuest{
    questId = 501,
    location = {position =  position(557, 263, 0), radius = 25},
    queststatus = {from = 37, to = 38},
    questTitle = {german = "Zzarn'K'Ska von Zelphia", english = "Zzarn'K'Ska of Zelphia"},
    monsterName = {german = "Echsen-Tempelkrieger", english = "Lizard Templar Warrior"},
    npcName = "Ssalva",
    monsterIds = {52} -- Lizard Templar Warrior
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
