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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (520, 'quest.gorgophone_520_wilderness');

local common = require("base.common")
local factions = require("base.factions")
local monsterQuests = require("monster.base.quests")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Das Nest der Gorgophone"
Title[ENGLISH] = "Gorgophone's Nest"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 25 erledigen."
Description[ENGLISH][1] = "Kill small spiders for Gorgophone.  You still need 25."
Description[GERMAN][2] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 24 erledigen."
Description[ENGLISH][2] = "Kill small spiders for Gorgophone.  You still need 24."
Description[GERMAN][3] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 23 erledigen."
Description[ENGLISH][3] = "Kill small spiders for Gorgophone.  You still need 23."
Description[GERMAN][4] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 22 erledigen."
Description[ENGLISH][4] = "Kill small spiders for Gorgophone.  You still need 22."
Description[GERMAN][5] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 21 erledigen."
Description[ENGLISH][5] = "Kill small spiders for Gorgophone.  You still need 21."
Description[GERMAN][6] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 20 erledigen."
Description[ENGLISH][6] = "Kill small spiders for Gorgophone.  You still need 20."
Description[GERMAN][7] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 19 erledigen."
Description[ENGLISH][7] = "Kill small spiders for Gorgophone.  You still need 19."
Description[GERMAN][8] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 18 erledigen."
Description[ENGLISH][8] = "Kill small spiders for Gorgophone.  You still need 18."
Description[GERMAN][9] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 17 erledigen."
Description[ENGLISH][9] = "Kill small spiders for Gorgophone.  You still need 17."
Description[GERMAN][10] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 16 erledigen."
Description[ENGLISH][10] = "Kill small spiders for Gorgophone.  You still need 16."
Description[GERMAN][11] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 15 erledigen."
Description[ENGLISH][11] = "Kill small spiders for Gorgophone.  You still need 15."
Description[GERMAN][12] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 14 erledigen."
Description[ENGLISH][12] = "Kill small spiders for Gorgophone.  You still need 14."
Description[GERMAN][13] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 13 erledigen."
Description[ENGLISH][13] = "Kill small spiders for Gorgophone.  You still need 13."
Description[GERMAN][14] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 12 erledigen."
Description[ENGLISH][14] = "Kill small spiders for Gorgophone.  You still need 12."
Description[GERMAN][15] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 11 erledigen."
Description[ENGLISH][15] = "Kill small spiders for Gorgophone.  You still need 11."
Description[GERMAN][16] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 10 erledigen."
Description[ENGLISH][16] = "Kill small spiders for Gorgophone.  You still need 10."
Description[GERMAN][17] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 9 erledigen."
Description[ENGLISH][17] = "Kill small spiders for Gorgophone.  You still need 9."
Description[GERMAN][18] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 8 erledigen."
Description[ENGLISH][18] = "Kill small spiders for Gorgophone.  You still need 8."
Description[GERMAN][19] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 7 erledigen."
Description[ENGLISH][19] = "Kill small spiders for Gorgophone.  You still need 7."
Description[GERMAN][20] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 6 erledigen."
Description[ENGLISH][20] = "Kill small spiders for Gorgophone.  You still need 6."
Description[GERMAN][21] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 5 erledigen."
Description[ENGLISH][21] = "Kill small spiders for Gorgophone.  You still need 5."
Description[GERMAN][22] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 4 erledigen."
Description[ENGLISH][22] = "Kill small spiders for Gorgophone.  You still need 4."
Description[GERMAN][23] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 3 erledigen."
Description[ENGLISH][23] = "Kill small spiders for Gorgophone.  You still need 3."
Description[GERMAN][24] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 2 erledigen."
Description[ENGLISH][24] = "Kill small spiders for Gorgophone.  You still need 2."
Description[GERMAN][25] = "T�te Kleine Spinnen f�r Gorgophone. Du musst noch 1 erledigen."
Description[ENGLISH][25] = "Kill small spiders for Gorgophone.  You still need 1."
Description[GERMAN][26] = "Kehre zu Gorgophone zur�ck, du hast ihre Aufgabe erledigt."
Description[ENGLISH][26] = "Return to Gorgophone, you have finished her task."

Description[GERMAN][27] = "Rede mit Gorgophone, sie hat villeicht eine weitere Aufgabe f�r dich."
Description[ENGLISH][27] = "Check with Gorgophone, she may have another task for you."

Description[GERMAN][28] = "Bring 5 Wasserflaschen zu Gorgophone."
Description[ENGLISH][28] = "Collect five bottles of water for Gorgophone."
Description[GERMAN][29] = "Rede mit Gorgophone, sie hat villeicht eine weitere Aufgabe f�r dich."
Description[ENGLISH][29] = "Check with Gorgophone, she may have another task for you."

Description[GERMAN][30] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 20 erledigen."
Description[ENGLISH][30] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone. You still need 20."
Description[GERMAN][31] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 19 erledigen."
Description[ENGLISH][31] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone. You still need 19."
Description[GERMAN][32] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 18 erledigen."
Description[ENGLISH][32] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone. You still need 18."
Description[GERMAN][33] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 17 erledigen."
Description[ENGLISH][33] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone. You still need 17."
Description[GERMAN][34] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 16 erledigen."
Description[ENGLISH][34] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone. You still need 16."
Description[GERMAN][35] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 15 erledigen."
Description[ENGLISH][35] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone. You still need 15."
Description[GERMAN][36] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 14 erledigen."
Description[ENGLISH][36] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone. You still need 14."
Description[GERMAN][37] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 13 erledigen."
Description[ENGLISH][37] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone. You still need 13."
Description[GERMAN][38] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 12 erledigen."
Description[ENGLISH][38] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone. You still need 12."
Description[GERMAN][39] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 11 erledigen."
Description[ENGLISH][39] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone. You still need 11."
Description[GERMAN][40] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 10 erledigen."
Description[ENGLISH][40] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone. You still need 10."
Description[GERMAN][41] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 9 erledigen."
Description[ENGLISH][41] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone. You still need 9."
Description[GERMAN][42] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 8 erledigen."
Description[ENGLISH][42] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone.  You still need 8."
Description[GERMAN][43] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 7 erledigen."
Description[ENGLISH][43] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone. You still need 7."
Description[GERMAN][44] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 6 erledigen."
Description[ENGLISH][44] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone.  You still need 6."
Description[GERMAN][45] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 5 erledigen."
Description[ENGLISH][45] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone.  You still need 5."
Description[GERMAN][46] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 4 erledigen."
Description[ENGLISH][46] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone. You still need 4."
Description[GERMAN][47] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 3 erledigen."
Description[ENGLISH][47] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone.  You still need 3."
Description[GERMAN][48] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 2 erledigen."
Description[ENGLISH][48] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone.  You still need 2."
Description[GERMAN][49] = "T�te Schreckensspinne, Grubendiener, oder Feuerspinne Spinnen f�r Gorgophone. Du musst noch 1 erledigen."
Description[ENGLISH][49] = "Kill Dread Spider, Pit Servants, or Fire Spiders spiders for Gorgophone.  You still need 1."
Description[GERMAN][50] = "Kehre zu Gorgophone zur�ck, du hast ihre Aufgabe erledigt."
Description[ENGLISH][50] = "Return to Gorgophone, you have finished her task."

Description[GERMAN][51] = "Rede mit Gorgophone, sie hat villeicht eine weitere Aufgabe f�r dich."
Description[ENGLISH][51] = "Check with Gorgophone, she may have another task for you."

Description[GERMAN][52] = "T�te Taranteln f�r Gorgophone. Du musst noch 15 erledigen."
Description[ENGLISH][52] = "Kill tarantulas for Gorgophone.  You still need 15."
Description[GERMAN][53] = "T�te Taranteln f�r Gorgophone. Du musst noch 14 erledigen."
Description[ENGLISH][53] = "Kill tarantulas for Gorgophone.  You still need 14."
Description[GERMAN][54] = "T�te Taranteln f�r Gorgophone. Du musst noch 13 erledigen."
Description[ENGLISH][54] = "Kill tarantulas for Gorgophone.  You still need 13."
Description[GERMAN][55] = "T�te Taranteln f�r Gorgophone. Du musst noch 12 erledigen."
Description[ENGLISH][55] = "Kill tarantulas for Gorgophone.  You still need 12."
Description[GERMAN][56] = "T�te Taranteln f�r Gorgophone. Du musst noch 11 erledigen."
Description[ENGLISH][56] = "Kill tarantulas for Gorgophone.  You still need 11."
Description[GERMAN][57] = "T�te Taranteln f�r Gorgophone. Du musst noch 10 erledigen."
Description[ENGLISH][57] = "Kill tarantulas for Gorgophone.  You still need 10."
Description[GERMAN][58] = "T�te Taranteln f�r Gorgophone. Du musst noch 9 erledigen."
Description[ENGLISH][58] = "Kill tarantulas for Gorgophone.  You still need 9."
Description[GERMAN][59] = "T�te Taranteln f�r Gorgophone. Du musst noch 8 erledigen."
Description[ENGLISH][59] = "Kill tarantulas for Gorgophone.  You still need 8."
Description[GERMAN][60] = "T�te Taranteln f�r Gorgophone. Du musst noch 7 erledigen."
Description[ENGLISH][60] = "Kill tarantulas for Gorgophone.  You still need 7."
Description[GERMAN][61] = "T�te Taranteln f�r Gorgophone. Du musst noch 6 erledigen."
Description[ENGLISH][61] = "Kill tarantulas for Gorgophone.  You still need 6."
Description[GERMAN][62] = "T�te Taranteln f�r Gorgophone. Du musst noch 5 erledigen."
Description[ENGLISH][62] = "Kill tarantulas for Gorgophone.  You still need 5."
Description[GERMAN][63] = "T�te Taranteln f�r Gorgophone. Du musst noch 4 erledigen."
Description[ENGLISH][63] = "Kill tarantulas for Gorgophone.  You still need 4."
Description[GERMAN][64] = "T�te Taranteln f�r Gorgophone. Du musst noch 3 erledigen."
Description[ENGLISH][64] = "Kill tarantulas for Gorgophone.  You still need 3."
Description[GERMAN][65] = "T�te Taranteln f�r Gorgophone. Du musst noch 2 erledigen."
Description[ENGLISH][65] = "Kill tarantulas for Gorgophone.  You still need 2."
Description[GERMAN][66] = "T�te Taranteln f�r Gorgophone. Du musst noch 1 erledigen."
Description[ENGLISH][66] = "Kill tarantulas for Gorgophone.  You still need 1."
Description[GERMAN][67] = "Kehre zu Gorgophone zur�ck, du hast ihre Aufgabe erledigt."
Description[ENGLISH][67] = "Return to Gorgophone, you have finished her task."

Description[GERMAN][68] = "Rede mit Gorgophone, sie hat villeicht eine weitere Aufgabe f�r dich."
Description[ENGLISH][68] = "Check with Gorgophone, she may have another task for you."

Description[GERMAN][69] = "Bringe 60 Getreideb�ndel zu Gorgophone."
Description[ENGLISH][69] = "Collect sixty grain bundles for Gorgophone."
Description[GERMAN][70] = "Rede mit Gorgophone, sie hat villeicht eine weitere Aufgabe f�r dich."
Description[ENGLISH][70] = "Check with Gorgophone she may have another task for you."

Description[GERMAN][71] = "Gorgophone braucht 75 Spindeln Garn von dir."
Description[ENGLISH][71] = "Collect 75 spools of thread for Gorgophone."
Description[GERMAN][72] = "Rede mit Gorgophone, sie hat villeicht eine weitere Aufgabe f�r dich."
Description[ENGLISH][72] = "Check with Gorgophone she may have another task for you."

Description[GERMAN][73] = "Besorge eine mindestens sehr gute heilige Voulge und bring diese zu Gorgophone."
Description[ENGLISH][73] = "Collect a divine voulge spear, of very good quality or better, for Gorgophone."
Description[GERMAN][74] = "Rede mit Gorgophone, sie hat villeicht eine weitere Aufgabe f�r dich."
Description[ENGLISH][74] = "Check with Gorgophone she may have another task for you."

Description[GERMAN][75] = "T�te Spinnenk�niginnen f�r Gorgophone. Du musst noch 5 erledigen."
Description[ENGLISH][75] = "Kill spider queens for Gorgophone. You still need 5."
Description[GERMAN][76] = "T�te Spinnenk�niginnen f�r Gorgophone. Du musst noch 4 erledigen."
Description[ENGLISH][76] = "Kill spider queens for Gorgophone. You still need 4."
Description[GERMAN][77] = "T�te Spinnenk�niginnen f�r Gorgophone. Du musst noch 3 erledigen."
Description[ENGLISH][77] = "Kill spider queens for Gorgophone. You still need 3."
Description[GERMAN][78] = "T�te Spinnenk�niginnen f�r Gorgophone. Du musst noch 2 erledigen."
Description[ENGLISH][78] = "Kill spider queens for Gorgophone. You still need 2."
Description[GERMAN][79] = "T�te Spinnenk�niginnen f�r Gorgophone. Du musst noch 1 erledigen."
Description[ENGLISH][79] = "Kill spider queens for Gorgophone. You still need 1."
Description[GERMAN][80] = "Kehre zu Gorgophone zur�ck, du hast ihre Aufgabe erledigt."
Description[ENGLISH][80] = "Return to Gorgophone, you have finished her task."

Description[GERMAN][81] = "Rede mit Gorgophone, sie hat villeicht eine weitere Aufgabe f�r dich."
Description[ENGLISH][81] = "Check with Gorgophone, she may have another task for you."

Description[GERMAN][82] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 50 erledigen."
Description[ENGLISH][82] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 50."
Description[GERMAN][83] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 49 erledigen."
Description[ENGLISH][83] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 49."
Description[GERMAN][84] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 48 erledigen."
Description[ENGLISH][84] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 48."
Description[GERMAN][85] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 47 erledigen."
Description[ENGLISH][85] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 47."
Description[GERMAN][86] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 46 erledigen."
Description[ENGLISH][86] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 46."
Description[GERMAN][87] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 45 erledigen."
Description[ENGLISH][87] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 45."
Description[GERMAN][88] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 44 erledigen."
Description[ENGLISH][88] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 44."
Description[GERMAN][89] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 43 erledigen."
Description[ENGLISH][89] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 43."
Description[GERMAN][90] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 42 erledigen."
Description[ENGLISH][90] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 42."
Description[GERMAN][91] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 41 erledigen."
Description[ENGLISH][91] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 41."
Description[GERMAN][92] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 40 erledigen."
Description[ENGLISH][92] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 40."
Description[GERMAN][93] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 39 erledigen."
Description[ENGLISH][93] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 39."
Description[GERMAN][94] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 38 erledigen."
Description[ENGLISH][94] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 38."
Description[GERMAN][95] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 37 erledigen."
Description[ENGLISH][95] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 37."
Description[GERMAN][96] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 36 erledigen."
Description[ENGLISH][96] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 36."
Description[GERMAN][97] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 35 erledigen."
Description[ENGLISH][97] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 35."
Description[GERMAN][98] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 34 erledigen."
Description[ENGLISH][98] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 34."
Description[GERMAN][99] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 33 erledigen."
Description[ENGLISH][99] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 33."
Description[GERMAN][100] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 32 erledigen."
Description[ENGLISH][100] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 32."
Description[GERMAN][101] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 31 erledigen."
Description[ENGLISH][101] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 31."
Description[GERMAN][102] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 30 erledigen."
Description[ENGLISH][102] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 30."
Description[GERMAN][103] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 29 erledigen."
Description[ENGLISH][103] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 29."
Description[GERMAN][104] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 28 erledigen."
Description[ENGLISH][104] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 28."
Description[GERMAN][105] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 27 erledigen."
Description[ENGLISH][105] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 27."
Description[GERMAN][106] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 26 erledigen."
Description[ENGLISH][106] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 26."
Description[GERMAN][107] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 25 erledigen."
Description[ENGLISH][107] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 25."
Description[GERMAN][108] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 24 erledigen."
Description[ENGLISH][108] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 24."
Description[GERMAN][109] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 23 erledigen."
Description[ENGLISH][109] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 23."
Description[GERMAN][110] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 22 erledigen."
Description[ENGLISH][110] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 22."
Description[GERMAN][111] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 21 erledigen."
Description[ENGLISH][111] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 21."
Description[GERMAN][112] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 20 erledigen."
Description[ENGLISH][112] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 20."
Description[GERMAN][113] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 19 erledigen."
Description[ENGLISH][113] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 19."
Description[GERMAN][114] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 18 erledigen."
Description[ENGLISH][114] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 18."
Description[GERMAN][115] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 17 erledigen."
Description[ENGLISH][115] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 17."
Description[GERMAN][116] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 16 erledigen."
Description[ENGLISH][116] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 16."
Description[GERMAN][117] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 15 erledigen."
Description[ENGLISH][117] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 15."
Description[GERMAN][118] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 14 erledigen."
Description[ENGLISH][118] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 14."
Description[GERMAN][119] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 13 erledigen."
Description[ENGLISH][119] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 13."
Description[GERMAN][120] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 12 erledigen."
Description[ENGLISH][120] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 12."
Description[GERMAN][121] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 11 erledigen."
Description[ENGLISH][121] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 11."
Description[GERMAN][122] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 10 erledigen."
Description[ENGLISH][122] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 10."
Description[GERMAN][123] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 9 erledigen."
Description[ENGLISH][123] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 9."
Description[GERMAN][124] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 8 erledigen."
Description[ENGLISH][124] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 8."
Description[GERMAN][125] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 7 erledigen."
Description[ENGLISH][125] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 7."
Description[GERMAN][126] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 6 erledigen."
Description[ENGLISH][126] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 6."
Description[GERMAN][127] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 5 erledigen."
Description[ENGLISH][127] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 5."
Description[GERMAN][128] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 4 erledigen."
Description[ENGLISH][128] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 4."
Description[GERMAN][129] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 3 erledigen."
Description[ENGLISH][129] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 3."
Description[GERMAN][130] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 2 erledigen."
Description[ENGLISH][130] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 2."
Description[GERMAN][131] = "T�te Schattenmampfer, Tarantel, Spinnenk�nigin, Ritterfurcht, oder Gynkesische Witwe Spinnen f�r Gorgophone. Du musst noch 1 erledigen."
Description[ENGLISH][131] = "Kill Shadow Muncher,  Tarantula, Spider Queen, Kings Fright, or Gynkese Widow for Gorgophone. You still need 1."
Description[GERMAN][132] = "Kehre zu Gorgophone zur�ck, du hast ihre Aufgabe erledigt."
Description[ENGLISH][132] = "Return to Gorgophone, you have completed her task."
Description[GERMAN][133] = "Du hast alle Aufgaben der Gorgophone erledigt."
Description[ENGLISH][133] = "You have completed all tasks of Gorgophone."

local npcPos = position(852, 497, -6);

-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = npcPos;

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
for i = 1, 132 do
  QuestTarget[i] = {npcPos};
end

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 133

-- Register the monster kill parts of the quest.
monsterQuests.addQuest{
    questId = 520,
    location = {position = npcPos, radius = 200},
    queststatus = {from = 1, to = 26},
    questTitle = {german = "Das Nest der Gorgophone", english = "Gorgophone's Nest"},
    monsterName = {german = "kleine Spinnen", english = "small spiders"},
    npcName = "Gorgophone",
    monsterIds = {196} -- small spider
}
monsterQuests.addQuest{
    questId = 520,
    location = {position = npcPos, radius = 200},
    queststatus = {from = 30, to = 50},
    questTitle = {german = "Das Nest der Gorgophone", english = "Gorgophone's Nest"},
    monsterName = {german = "Schreckensspinne", english = "Dread Spider, Pit Servant and Fire Spider spiders"},
    npcName = "Gorgophone",
    monsterIds = {191, 192, 211} -- Dread Spider, Pit Servant, Fire Spider
}
monsterQuests.addQuest{
    questId = 520,
    location = {position = npcPos, radius = 200},
    queststatus = {from = 52, to = 67},
    questTitle = {german = "Das Nest der Gorgophone", english = "Gorgophone's Nest"},
    monsterName = {german = "Taranteln", english = "tarantulas"},
    npcName = "Gorgophone",
    monsterIds = {193} -- Tarantula
}
monsterQuests.addQuest{
    questId = 520,
    location = {position = npcPos, radius = 200},
    queststatus = {from = 75, to = 80},
    questTitle = {german = "Das Nest der Gorgophone", english = "Gorgophone's Nest"},
    monsterName = {german = "Spinnenk�niginnen", english = "Spider Queens"},
    npcName = "Gorgophone",
    monsterIds = {195} -- Spider queen
}
monsterQuests.addQuest{
    questId = 520,
    location = {position = npcPos, radius = 200},
    queststatus = {from = 82, to = 132},
    questTitle = {german = "Das Nest der Gorgophone", english = "Gorgophone's Nest"},
    monsterName = {german = "Gro� Spinnen", english = "Large spiders"},
    npcName = "Gorgophone",
    monsterIds = {193, 195, 221, 231, 232, 261} -- Tarantula, Spider Queen, Gynkese Widow, Kings Fright, Shadow Muncher,Nightmare spider
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
