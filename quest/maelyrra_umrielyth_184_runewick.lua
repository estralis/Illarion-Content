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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (184, 'quest.maelyrra_umrielyth_184_runewick');

local common = require("base.common")
local monsterQuests = require("monster.base.quests")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Die Forscher"
Title[ENGLISH] = "The Researcher"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}

Description[GERMAN][1] = "T�te vier Schleime, in der Wildnis du brauchst noch vier weitere."
Description[GERMAN][2] = "T�te vier Schleime, in der Wildnis du brauchst noch drei weitere."
Description[GERMAN][3] = "T�te vier Schleime, in der Wildnis du brauchst noch zwei weitere."
Description[GERMAN][4] = "T�te vier Schleime, in der Wildnis du brauchst noch ein weitere."
Description[GERMAN][5] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][6] = "T�te acht Schleime, in der Wildnis du brauchst noch acht weitere."
Description[GERMAN][7] = "T�te acht Schleime, in der Wildnis du brauchst noch sieben weitere."
Description[GERMAN][8] = "T�te acht Schleime, in der Wildnis du brauchst noch sechs weitere."
Description[GERMAN][9] = "T�te acht Schleime, in der Wildnis du brauchst noch f�nf weitere."
Description[GERMAN][10] = "T�te acht Schleime, in der Wildnis du brauchst noch vier weitere."
Description[GERMAN][11] = "T�te acht Schleime, in der Wildnis du brauchst noch drei weitere."
Description[GERMAN][12] = "T�te acht Schleime, in der Wildnis du brauchst noch zwei weitere."
Description[GERMAN][13] = "T�te acht Schleime, in der Wildnisdu brauchst noch ein weitere."
Description[GERMAN][14] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][15] = "T�te zw�lf Schleime, in der Wildnis du brauchst noch zw�lf weitere."
Description[GERMAN][16] = "T�te zw�lf Schleime, in der Wildnis du brauchst noch elf weitere."
Description[GERMAN][17] = "T�te zw�lf Schleime, in der Wildnis du brauchst noch zehn weitere."
Description[GERMAN][18] = "T�te zw�lf Schleime, in der Wildnis du brauchst noch neun weitere."
Description[GERMAN][19] = "T�te zw�lf Schleime, in der Wildnis du brauchst noch acht weitere."
Description[GERMAN][20] = "T�te zw�lf Schleime, in der Wildnis du brauchst noch sieben weitere."
Description[GERMAN][21] = "T�te zw�lf Schleime, in der Wildnis du brauchst noch sechs weitere."
Description[GERMAN][22] = "T�te zw�lf Schleime, in der Wildnis du brauchst noch f�nf weitere."
Description[GERMAN][23] = "T�te zw�lf Schleime, in der Wildnis du brauchst noch vier weitere."
Description[GERMAN][24] = "T�te zw�lf Schleime, in der Wildnis du brauchst noch drei weitere."
Description[GERMAN][25] = "T�te zw�lf Schleime, in der Wildnis du brauchst noch zwei weitere."
Description[GERMAN][26] = "T�te zw�lf Schleime, in der Wildnis du brauchst noch ein weitere."
Description[GERMAN][27] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][28] = "T�te vier Hunde, du brauchst noch vier weitere."
Description[GERMAN][29] = "T�te vier Hunde, du brauchst noch drei weitere."
Description[GERMAN][30] = "T�te vier Hunde, du brauchst noch zwei weitere."
Description[GERMAN][31] = "T�te vier Hunde, du  brauchst noch ein weitere."
Description[GERMAN][32] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][33] = "T�te acht Hunde, du brauchst noch acht weitere."
Description[GERMAN][34] = "T�te acht Hunde, du brauchst noch sieben weitere."
Description[GERMAN][35] = "T�te acht Hunde, du brauchst noch sechs weitere."
Description[GERMAN][36] = "T�te acht Hunde, du brauchst noch f�nf weitere."
Description[GERMAN][37] = "T�te acht Hunde, du brauchst noch vier weitere."
Description[GERMAN][38] = "T�te acht Hunde, du brauchst noch drei weitere."
Description[GERMAN][39] = "T�te acht Hunde, du brauchst noch zwei weitere."
Description[GERMAN][40] = "T�te acht Hunde, du brauchst noch ein weitere."
Description[GERMAN][41] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][42] = "T�te zw�lf Hunde, du brauchst noch zw�lf weitere."
Description[GERMAN][43] = "T�te zw�lf Hunde, du brauchst noch elf weitere."
Description[GERMAN][44] = "T�te zw�lf Hunde, du brauchst noch zehn weitere."
Description[GERMAN][45] = "T�te zw�lf Hunde, du brauchst noch neun weitere."
Description[GERMAN][46] = "T�te zw�lf Hunde, du brauchst noch acht weitere."
Description[GERMAN][47] = "T�te zw�lf Hunde, du brauchst noch sieben weitere."
Description[GERMAN][48] = "T�te zw�lf Hunde, du brauchst noch sechs weitere."
Description[GERMAN][49] = "T�te zw�lf Hunde, du brauchst noch f�nf weitere."
Description[GERMAN][50] = "T�te zw�lf Hunde, du brauchst noch vier weitere."
Description[GERMAN][51] = "T�te zw�lf Hunde, du brauchst noch drei weitere."
Description[GERMAN][52] = "T�te zw�lf Hunde, du brauchst noch zwei weitere."
Description[GERMAN][53] = "T�te zw�lf Hunde, du brauchst noch ein weitere."
Description[GERMAN][54] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][55] = "T�te vier W�lfe, du brauchst noch vier weitere."
Description[GERMAN][56] = "T�te vier W�lfe, du brauchst noch drei weitere."
Description[GERMAN][57] = "T�te vier W�lfe, du brauchst noch zwei weitere."
Description[GERMAN][58] = "T�te vier W�lfe, du brauchst noch ein weitere."
Description[GERMAN][59] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][60] = "T�te acht W�lfe, du brauchst noch acht weitere."
Description[GERMAN][61] = "T�te acht W�lfe, du brauchst noch sieben weitere."
Description[GERMAN][62] = "T�te acht W�lfe, du brauchst noch sechs weitere."
Description[GERMAN][63] = "T�te acht W�lfe, du brauchst noch f�nf weitere."
Description[GERMAN][64] = "T�te acht W�lfe, du brauchst noch vier weitere."
Description[GERMAN][65] = "T�te acht W�lfe, du brauchst noch drei weitere."
Description[GERMAN][66] = "T�te acht W�lfe, du brauchst noch zwei weitere."
Description[GERMAN][67] = "T�te acht W�lfe, du brauchst noch ein weitere."
Description[GERMAN][68] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][69] = "T�te zw�lf W�lfe, du brauchst noch zw�lf weitere."
Description[GERMAN][70] = "T�te zw�lf W�lfe, du brauchst noch elf weitere."
Description[GERMAN][71] = "T�te zw�lf W�lfe, du brauchst noch zehn weitere."
Description[GERMAN][72] = "T�te zw�lf W�lfe, du brauchst noch neun weitere."
Description[GERMAN][73] = "T�te zw�lf W�lfe, du brauchst noch acht weitere."
Description[GERMAN][74] = "T�te zw�lf W�lfe, du brauchst noch sieben weitere."
Description[GERMAN][75] = "T�te zw�lf W�lfe, du brauchst noch sechs weitere."
Description[GERMAN][76] = "T�te zw�lf W�lfe, du brauchst noch f�nf weitere."
Description[GERMAN][77] = "T�te zw�lf W�lfe, du brauchst noch vier weitere."
Description[GERMAN][78] = "T�te zw�lf W�lfe, du brauchst noch drei weitere."
Description[GERMAN][79] = "T�te zw�lf W�lfe, du brauchst noch zwei weitere."
Description[GERMAN][80] = "T�te zw�lf W�lfe, du brauchst noch ein weitere."
Description[GERMAN][81] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][82] = "T�te vier F�chse, du brauchst noch vier weitere."
Description[GERMAN][83] = "T�te vier F�chse, du brauchst noch drei weitere."
Description[GERMAN][84] = "T�te vier F�chse, du brauchst noch zwei weitere."
Description[GERMAN][85] = "T�te vier F�chse, du brauchst noch ein weitere."
Description[GERMAN][86] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][87] = "T�te acht F�chse, du brauchst noch acht weitere."
Description[GERMAN][88] = "T�te acht F�chse, du brauchst noch sieben weitere."
Description[GERMAN][89] = "T�te acht F�chse, du brauchst noch sechs weitere."
Description[GERMAN][90] = "T�te acht F�chse, du brauchst noch f�nf weitere."
Description[GERMAN][91] = "T�te acht F�chse, du brauchst noch vier weitere."
Description[GERMAN][92] = "T�te acht F�chse, du brauchst noch drei weitere."
Description[GERMAN][93] = "T�te acht F�chse, du brauchst noch zwei weitere."
Description[GERMAN][94] = "T�te acht F�chse, du brauchst noch ein weitere."
Description[GERMAN][95] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][96] = "T�te zw�lf F�chse, du brauchst noch zw�lf weitere."
Description[GERMAN][97] = "T�te zw�lf F�chse, du brauchst noch elf weitere."
Description[GERMAN][98] = "T�te zw�lf F�chse, du brauchst noch zehn weitere."
Description[GERMAN][99] = "T�te zw�lf F�chse, du brauchst noch neun weitere."
Description[GERMAN][100] = "T�te zw�lf F�chse, du brauchst noch acht weitere."
Description[GERMAN][101] = "T�te zw�lf F�chse, du brauchst noch sieben weitere."
Description[GERMAN][102] = "T�te zw�lf F�chse, du brauchst noch sechs weitere."
Description[GERMAN][103] = "T�te zw�lf F�chse, du brauchst noch f�nf weitere."
Description[GERMAN][104] = "T�te zw�lf F�chse, du brauchst noch vier weitere."
Description[GERMAN][105] = "T�te zw�lf F�chse, du brauchst noch drei weitere."
Description[GERMAN][106] = "T�te zw�lf F�chse, du brauchst noch zwei weitere."
Description[GERMAN][107] = "T�te zw�lf F�chse, du brauchst noch ein weitere."
Description[GERMAN][108] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][109] = "T�te vier Menschen, du brauchst noch vier weitere."
Description[GERMAN][110] = "T�te vier Menschen, du brauchst noch drei weitere."
Description[GERMAN][111] = "T�te vier Menschen, du brauchst noch zwei weitere."
Description[GERMAN][112] = "T�te vier Menschen, du brauchst noch ein weitere."
Description[GERMAN][113] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][114] = "T�te acht Menschen, du brauchst noch acht weitere."
Description[GERMAN][115] = "T�te acht Menschen, du brauchst noch sieben weitere."
Description[GERMAN][116] = "T�te acht Menschen, du brauchst noch sechs weitere."
Description[GERMAN][117] = "T�te acht Menschen, du brauchst noch f�nf weitere."
Description[GERMAN][118] = "T�te acht Menschen, du brauchst noch vier weitere."
Description[GERMAN][119] = "T�te acht Menschen, du brauchst noch drei weitere."
Description[GERMAN][120] = "T�te acht Menschen, du brauchst noch zwei weitere."
Description[GERMAN][121] = "T�te acht Menschen, du brauchst noch ein weitere."
Description[GERMAN][122] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][123] = "T�te zw�lf Menschen, du brauchst noch zw�lf weitere."
Description[GERMAN][124] = "T�te zw�lf Menschen, du brauchst noch elf weitere."
Description[GERMAN][125] = "T�te zw�lf Menschen, du brauchst noch zehn weitere."
Description[GERMAN][126] = "T�te zw�lf Menschen, du brauchst noch neun weitere."
Description[GERMAN][127] = "T�te zw�lf Menschen, du brauchst noch acht weitere."
Description[GERMAN][128] = "T�te zw�lf Menschen, du brauchst noch sieben weitere."
Description[GERMAN][129] = "T�te zw�lf Menschen, du brauchst noch sechs weitere."
Description[GERMAN][130] = "T�te zw�lf Menschen, du brauchst noch f�nf weitere."
Description[GERMAN][131] = "T�te zw�lf Menschen, du brauchst noch vier weitere."
Description[GERMAN][132] = "T�te zw�lf Menschen, du brauchst noch drei weitere."
Description[GERMAN][133] = "T�te zw�lf Menschen, du brauchst noch zwei weitere."
Description[GERMAN][134] = "T�te zw�lf Menschen, du brauchst noch ein weitere."
Description[GERMAN][135] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][136] = "T�te vier Diebe, du brauchst noch vier weitere."
Description[GERMAN][137] = "T�te vier Diebe, du brauchst noch drei weitere."
Description[GERMAN][138] = "T�te vier Diebe, du brauchst noch zwei weitere."
Description[GERMAN][139] = "T�te vier Diebe, du brauchst noch ein weitere."
Description[GERMAN][140] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][141] = "T�te acht Diebe, du brauchst noch acht weitere."
Description[GERMAN][142] = "T�te acht Diebe, du brauchst noch sieben weitere."
Description[GERMAN][143] = "T�te acht Diebe, du brauchst noch sechs weitere."
Description[GERMAN][144] = "T�te acht Diebe, du brauchst noch f�nf weitere."
Description[GERMAN][145] = "T�te acht Diebe, du brauchst noch vier weitere."
Description[GERMAN][146] = "T�te acht Diebe, du brauchst noch drei weitere."
Description[GERMAN][147] = "T�te acht Diebe, du brauchst noch zwei weitere."
Description[GERMAN][148] = "T�te acht Diebe, du brauchst noch ein weitere."
Description[GERMAN][149] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][150] = "T�te zw�lf Diebe, du brauchst noch zw�lf weitere."
Description[GERMAN][151] = "T�te zw�lf Diebe, du brauchst noch elf weitere."
Description[GERMAN][152] = "T�te zw�lf Diebe, du brauchst noch zehn weitere."
Description[GERMAN][153] = "T�te zw�lf Diebe, du brauchst noch neun weitere."
Description[GERMAN][154] = "T�te zw�lf Diebe, du brauchst noch acht weitere."
Description[GERMAN][155] = "T�te zw�lf Diebe, du brauchst noch sieben weitere."
Description[GERMAN][156] = "T�te zw�lf Diebe, du brauchst noch sechs weitere."
Description[GERMAN][157] = "T�te zw�lf Diebe, du brauchst noch f�nf weitere."
Description[GERMAN][158] = "T�te zw�lf Diebe, du brauchst noch vier weitere."
Description[GERMAN][159] = "T�te zw�lf Diebe, du brauchst noch drei weitere."
Description[GERMAN][160] = "T�te zw�lf Diebe, du brauchst noch zwei weitere."
Description[GERMAN][161] = "T�te zw�lf Diebe, du brauchst noch ein weitere."
Description[GERMAN][162] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][163] = "T�te vier Zombies, du brauchst noch vier weitere."
Description[GERMAN][164] = "T�te vier Zombies, du brauchst noch drei weitere."
Description[GERMAN][165] = "T�te vier Zombies, du brauchst noch zwei weitere."
Description[GERMAN][166] = "T�te vier Zombies, du brauchst noch ein weitere."
Description[GERMAN][167] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][168] = "T�te acht Zombies, du brauchst noch acht weitere."
Description[GERMAN][169] = "T�te acht Zombies, du brauchst noch sieben weitere."
Description[GERMAN][170] = "T�te acht Zombies, du brauchst noch sechs weitere."
Description[GERMAN][171] = "T�te acht Zombies, du brauchst noch f�nf weitere."
Description[GERMAN][172] = "T�te acht Zombies, du brauchst noch vier weitere."
Description[GERMAN][173] = "T�te acht Zombies, du brauchst noch drei weitere."
Description[GERMAN][174] = "T�te acht Zombies, du brauchst noch zwei weitere."
Description[GERMAN][175] = "T�te acht Zombies, du brauchst noch ein weitere."
Description[GERMAN][176] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][177] = "T�te zw�lf Zombies, du brauchst noch zw�lf weitere."
Description[GERMAN][178] = "T�te zw�lf Zombies, du brauchst noch elf weitere."
Description[GERMAN][179] = "T�te zw�lf Zombies, du brauchst noch zehn weitere."
Description[GERMAN][180] = "T�te zw�lf Zombies, du brauchst noch neun weitere."
Description[GERMAN][181] = "T�te zw�lf Zombies, du rauchst noch acht weitere."
Description[GERMAN][182] = "T�te zw�lf Zombies, du brauchst noch sieben weitere."
Description[GERMAN][183] = "T�te zw�lf Zombies, du brauchst noch sechs weitere."
Description[GERMAN][184] = "T�te zw�lf Zombies, du brauchst noch f�nf weitere."
Description[GERMAN][185] = "T�te zw�lf Zombies, du brauchst noch vier weitere."
Description[GERMAN][186] = "T�te zw�lf Zombies, du brauchst noch drei weitere."
Description[GERMAN][187] = "T�te zw�lf Zombies, du brauchst noch zwei weitere."
Description[GERMAN][188] = "T�te zw�lf Zombies, du brauchst noch ein weitere."
Description[GERMAN][189] = "Kehre zu Maelyrra Umrielyth zur�ck, um deine Belohnung zu erhalten."

Description[ENGLISH][1] = "Kill four slimes in the wilderness you still need four."
Description[ENGLISH][2] = "Kill four slimes in the wilderness you still need three."
Description[ENGLISH][3] = "Kill four slimes in the wilderness you still need two."
Description[ENGLISH][4] = "Kill four slimes in the wilderness you still need one."
Description[ENGLISH][5] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][6] = "Kill eight slimes in the wilderness you still need eight."
Description[ENGLISH][7] = "Kill eight slimes in the wilderness you still need seven."
Description[ENGLISH][8] = "Kill eight slimes in the wilderness you still need six."
Description[ENGLISH][9] = "Kill eight slimes in the wilderness you still need five."
Description[ENGLISH][10] = "Kill eight slimes in the wilderness you still need four."
Description[ENGLISH][11] = "Kill eight slimes in the wilderness you still need three."
Description[ENGLISH][12] = "Kill eight slimes in the wilderness you still need two."
Description[ENGLISH][13] = "Kill eight slimes in the wilderness you still need one."
Description[ENGLISH][14] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][15] = "Kill twelve slimes in the wilderness you still need twelve."
Description[ENGLISH][16] = "Kill twelve slimes in the wilderness you still need eleven."
Description[ENGLISH][17] = "Kill twelve slimes in the wilderness you still need ten."
Description[ENGLISH][18] = "Kill twelve slimes in the wilderness you still need nine."
Description[ENGLISH][19] = "Kill twelve slimes in the wilderness you still need eight."
Description[ENGLISH][20] = "Kill twelve slimes in the wilderness you still need seven."
Description[ENGLISH][21] = "Kill twelve slimes in the wilderness you still need six."
Description[ENGLISH][22] = "Kill twelve slimes in the wilderness you still need five."
Description[ENGLISH][23] = "Kill twelve slimes in the wilderness you still need four."
Description[ENGLISH][24] = "Kill twelve slimes in the wilderness you still need three."
Description[ENGLISH][25] = "Kill twelve slimes in the wilderness you still need two."
Description[ENGLISH][26] = "Kill twelve slimes in the wilderness you still need one."
Description[ENGLISH][27] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][28] = "Kill four dogs you still need four."
Description[ENGLISH][29] = "Kill four dogs you still need three."
Description[ENGLISH][30] = "Kill four dogs you still need two."
Description[ENGLISH][31] = "Kill four dogs you still need one."
Description[ENGLISH][32] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][33] = "Kill eight dogs you still need eight."
Description[ENGLISH][34] = "Kill eight dogs you still need seven."
Description[ENGLISH][35] = "Kill eight dogs you still need six."
Description[ENGLISH][36] = "Kill eight dogs you still need five."
Description[ENGLISH][37] = "Kill eight dogs you still need four."
Description[ENGLISH][38] = "Kill eight dogs you still need three."
Description[ENGLISH][39] = "Kill eight dogs you still need two."
Description[ENGLISH][40] = "Kill eight dogs you still need one."
Description[ENGLISH][41] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][42] = "Kill twelve dogs you still need twelve."
Description[ENGLISH][43] = "Kill twelve dogs you still need eleven."
Description[ENGLISH][44] = "Kill twelve dogs you still need ten."
Description[ENGLISH][45] = "Kill twelve dogs you still need nine."
Description[ENGLISH][46] = "Kill twelve dogs you still need eight."
Description[ENGLISH][47] = "Kill twelve dogs you still need seven."
Description[ENGLISH][48] = "Kill twelve dogs you still need six."
Description[ENGLISH][49] = "Kill twelve dogs you still need five."
Description[ENGLISH][50] = "Kill twelve dogs you still need four."
Description[ENGLISH][51] = "Kill twelve dogs you still need three."
Description[ENGLISH][52] = "Kill twelve dogs you still need two."
Description[ENGLISH][53] = "Kill twelve dogs you still need one."
Description[ENGLISH][54] = "Return to  Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][55] = "Kill four wolves you still need four."
Description[ENGLISH][56] = "Kill four wolves you still need three."
Description[ENGLISH][57] = "Kill four wolves you still need two."
Description[ENGLISH][58] = "Kill four wolves you still need one."
Description[ENGLISH][59] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][60] = "Kill eight wolves you still need eight."
Description[ENGLISH][61] = "Kill eight wolves you still need seven."
Description[ENGLISH][62] = "Kill eight wolves you still need six."
Description[ENGLISH][63] = "Kill eight wolves you still need five."
Description[ENGLISH][64] = "Kill eight wolves you still need four."
Description[ENGLISH][65] = "Kill eight wolves you still need three."
Description[ENGLISH][66] = "Kill eight wolves you still need two."
Description[ENGLISH][67] = "Kill eight wolves you still need one."
Description[ENGLISH][68] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][69] = "Kill twelve wolves you still need twelve."
Description[ENGLISH][70] = "Kill twelve wolves you still need eleven."
Description[ENGLISH][71] = "Kill twelve wolves you still need ten."
Description[ENGLISH][72] = "Kill twelve wolves you still need nine."
Description[ENGLISH][73] = "Kill twelve wolves you still need eight."
Description[ENGLISH][74] = "Kill twelve wolves you still need seven."
Description[ENGLISH][75] = "Kill twelve wolves you still need six."
Description[ENGLISH][76] = "Kill twelve wolves you still need five."
Description[ENGLISH][77] = "Kill twelve wolves you still need four."
Description[ENGLISH][78] = "Kill twelve wolves you still need three."
Description[ENGLISH][79] = "Kill twelve wolves you still need two."
Description[ENGLISH][80] = "Kill twelve wolves you still need one."
Description[ENGLISH][81] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][82] = "Kill four foxes you still need four."
Description[ENGLISH][83] = "Kill four foxes you still need three."
Description[ENGLISH][84] = "Kill four foxes you still need two."
Description[ENGLISH][85] = "Kill four foxes you still need one."
Description[ENGLISH][86] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][87] = "Kill eight foxes you still need eight."
Description[ENGLISH][88] = "Kill eight foxes you still need seven."
Description[ENGLISH][89] = "Kill eight foxes you still need six"
Description[ENGLISH][90] = "Kill eight foxes you still need five."
Description[ENGLISH][91] = "Kill eight foxes you still need four."
Description[ENGLISH][92] = "Kill eight foxes you still need three."
Description[ENGLISH][93] = "Kill eight foxes you still need two."
Description[ENGLISH][94] = "Kill eight foxes you still need one."
Description[ENGLISH][95] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][96] = "Kill twelve foxes you still need twelve."
Description[ENGLISH][97] = "Kill twelve foxes you still need eleven."
Description[ENGLISH][98] = "Kill twelve foxes you still need ten."
Description[ENGLISH][99] = "Kill twelve foxes you still need nine."
Description[ENGLISH][100] = "Kill twelve foxes you still need eight."
Description[ENGLISH][101] = "Kill twelve foxes you still need seven."
Description[ENGLISH][102] = "Kill twelve foxes you still need six."
Description[ENGLISH][103] = "Kill twelve foxes you still need five."
Description[ENGLISH][104] = "Kill twelve foxes you still need four."
Description[ENGLISH][105] = "Kill twelve foxes you still need three."
Description[ENGLISH][106] = "Kill twelve foxes you still need two."
Description[ENGLISH][107] = "Kill twelve foxes you still need one."
Description[ENGLISH][108] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][109] = "Kill four humans you still need four."
Description[ENGLISH][110] = "Kill four humans you still need three."
Description[ENGLISH][111] = "Kill four humans you still need two."
Description[ENGLISH][112] = "Kill four humans you still need one."
Description[ENGLISH][113] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][114] = "Kill eight humans you still need eight."
Description[ENGLISH][115] = "Kill eight humans you still need seven."
Description[ENGLISH][116] = "Kill eight humans you still need six."
Description[ENGLISH][117] = "Kill eight humans you still need five."
Description[ENGLISH][118] = "Kill eight humans you still need four."
Description[ENGLISH][119] = "Kill eight humans you still need three."
Description[ENGLISH][120] = "Kill eight humans you still need two."
Description[ENGLISH][121] = "Kill eight humans you still need one."
Description[ENGLISH][122] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][123] = "Kill twelve humans you still need twelve."
Description[ENGLISH][124] = "Kill twelve humans you still need eleven."
Description[ENGLISH][125] = "Kill twelve humans you still need ten."
Description[ENGLISH][126] = "Kill twelve humans you still need nine."
Description[ENGLISH][127] = "Kill twelve humans you still need eight."
Description[ENGLISH][128] = "Kill twelve humans you still need seven."
Description[ENGLISH][129] = "Kill twelve humans you still need six."
Description[ENGLISH][130] = "Kill twelve humans you still need five."
Description[ENGLISH][131] = "Kill twelve humans you still need four."
Description[ENGLISH][132] = "Kill twelve humans you still need three."
Description[ENGLISH][133] = "Kill twelve humans you still need two."
Description[ENGLISH][134] = "Kill twelve humans you still need one."
Description[ENGLISH][135] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][136] = "Kill four thieves you still need four."
Description[ENGLISH][137] = "Kill four thieves you still need three."
Description[ENGLISH][138] = "Kill four thieves you still need two."
Description[ENGLISH][139] = "Kill four thieves you still need one."
Description[ENGLISH][140] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][141] = "Kill eight thieves you still need eight."
Description[ENGLISH][142] = "Kill eight thieves you still need seven."
Description[ENGLISH][143] = "Kill eight thieves you still need six."
Description[ENGLISH][144] = "Kill eight thieves you still need five."
Description[ENGLISH][145] = "Kill eight thieves you still need four."
Description[ENGLISH][146] = "Kill eight thieves you still need three."
Description[ENGLISH][147] = "Kill eight thieves you still need two."
Description[ENGLISH][148] = "Kill eight thieves you still need one."
Description[ENGLISH][149] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][150] = "Kill twelve thieves you still need twelve."
Description[ENGLISH][151] = "Kill twelve thieves you still need eleven."
Description[ENGLISH][152] = "Kill twelve thieves you still need ten."
Description[ENGLISH][153] = "Kill twelve thieves you still need nine."
Description[ENGLISH][154] = "Kill twelve thieves you still need eight."
Description[ENGLISH][155] = "Kill twelve thieves you still need seven."
Description[ENGLISH][156] = "Kill twelve thieves you still need six."
Description[ENGLISH][157] = "Kill twelve thieves you still need five."
Description[ENGLISH][158] = "Kill twelve thieves you still need four."
Description[ENGLISH][159] = "Kill twelve thieves you still need three."
Description[ENGLISH][160] = "Kill twelve thieves you still need two."
Description[ENGLISH][161] = "Kill twelve thieves you still need one."
Description[ENGLISH][162] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][163] = "Kill four zombies you still need four."
Description[ENGLISH][164] = "Kill four zombies you still need three."
Description[ENGLISH][165] = "Kill four zombies you still need two."
Description[ENGLISH][166] = "Kill four zombies you still need one."
Description[ENGLISH][167] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][168] = "Kill eight zombies you still need eight."
Description[ENGLISH][169] = "Kill eight zombies you still need seven."
Description[ENGLISH][170] = "Kill eight zombies you still need six."
Description[ENGLISH][171] = "Kill eight zombies you still need five."
Description[ENGLISH][172] = "Kill eight zombies you still need four."
Description[ENGLISH][173] = "Kill eight zombies you still need three."
Description[ENGLISH][174] = "Kill eight zombies you still need two."
Description[ENGLISH][175] = "Kill eight zombies you still need one."
Description[ENGLISH][176] = "Return to Maelyrra Umrielyth to claim your reward."
Description[ENGLISH][177] = "Kill twelve zombies you still need twelve."
Description[ENGLISH][178] = "Kill twelve zombies you still need eleven."
Description[ENGLISH][179] = "Kill twelve zombies you still need ten."
Description[ENGLISH][180] = "Kill twelve zombies you still need nine."
Description[ENGLISH][181] = "Kill twelve zombies you still need eight."
Description[ENGLISH][182] = "Kill twelve zombies you still need seven."
Description[ENGLISH][183] = "Kill twelve zombies you still need six."
Description[ENGLISH][184] = "Kill twelve zombies you still need five."
Description[ENGLISH][185] = "Kill twelve zombies you still need four."
Description[ENGLISH][186] = "Kill twelve zombies you still need three."
Description[ENGLISH][187] = "Kill twelve zombies you still need two."
Description[ENGLISH][188] = "Kill twelve zombies you still need one."
Description[ENGLISH][189] = "Return to Maelyrra Umrielyth to claim your reward."

-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {861, 809, 0 }

local NPC_POS = position(861, 809, 0)

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
do
    local questTargetContent = {NPC_POS}
    for i = 1, 189 do
        QuestTarget[i] = questTargetContent  -- Maelyrra
    end
end

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 0

local HUNTING_POS = position(811, 735, 0)

-- Register the monster kill parts of the quest.
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 1, to = 5},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Schleime", english = "slimes"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {61} -- all slimes
}
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 6, to = 14},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Schleime", english = "slimes"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {61} -- all slimes
}
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 15, to = 27},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Schleime", english = "slimes"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {61} -- all slimes
}
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 28, to = 32},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Hunde", english = "dogs"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {58} -- all dogs
}
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 33, to = 41},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Hunde", english = "dogs"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {58} -- all dogs
}
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 42, to = 54},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Hunde", english = "dogs"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {58} -- all dogs
}
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 55, to = 59},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "W�lfe", english = "wolves"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {39} -- all wolves
}
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 60, to = 68},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "W�lfe", english = "wolves"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {39} -- all wolves
}
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 69, to = 81},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "W�lfe", english = "wolves"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {39} -- all wolves
}
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 82, to = 86},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "F�chse", english = "foxes"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {60} -- all foxes
}
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 87, to = 95},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "F�chse", english = "foxes"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {60} -- all foxes
}
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 96, to = 108},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "F�chse", english = "foxes"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {60} -- all foxes
}
monsterQuests.addQuest{
    questId = 184,
    locations = {
        {position = HUNTING_POS, radius = 300},
        {position = position(850, 512, -12), radius = 75},
        {position = position(905, 584, -3), radius = 40},
        {position = position(905, 584, -6), radius = 40},
        {position = position(896, 588, -9), radius = 40}
    },
    queststatus = {from = 109, to = 113},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Menschen", english = "humans"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {0} -- all humans
}
monsterQuests.addQuest{
    questId = 184,
    locations = {
        {position = HUNTING_POS, radius = 300},
        {position = position(850, 512, -12), radius = 75},
        {position = position(905, 584, -3), radius = 40},
        {position = position(905, 584, -6), radius = 40},
        {position = position(896, 588, -9), radius = 40}
        },
    queststatus = {from = 114, to = 122},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Menschen", english = "humans"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {0} -- all humans
}
monsterQuests.addQuest{
    questId = 184,
    locations = {
        {position = HUNTING_POS, radius = 300},
        {position = position(850, 512, -12), radius = 75},
        {position = position(905, 584, -3), radius = 40},
        {position = position(905, 584, -6), radius = 40},
        {position = position(896, 588, -9), radius = 40}
    },
    queststatus = {from = 123, to = 135},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Menschen", english = "humans"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {0} -- all humans
}
monsterQuests.addQuest{
    questId = 184,
    locations = {
        {position = HUNTING_POS, radius = 300},
        {position = position(905, 584, -3), radius = 40},
        {position = position(905, 584, -6), radius = 40},
        {position = position(896, 588, -9), radius = 40}
    },
    queststatus = {from = 136, to = 140},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Diebe", english = "thieves"},
    npcName = "Maelyrra Umrielyth",
    monsterIds = {5, 23, 43, 55} -- different thieves
}
monsterQuests.addQuest{
    questId = 184,
    locations = {
        {position = HUNTING_POS, radius = 300},
        {position = position(905, 584, -3), radius = 40},
        {position = position(905, 584, -6), radius = 40},
        {position = position(896, 588, -9), radius = 40}
    },
    queststatus = {from = 141, to = 149},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Diebe", english = "thieves"},
    npcName = "Maelyrra Umrielyth",
    monsterIds = {5, 23, 43, 55} -- different thieves
}
monsterQuests.addQuest{
    questId = 184,
    locations = {
        {position = HUNTING_POS, radius = 300},
        {position = position(905, 584, -3), radius = 40},
        {position = position(905, 584, -6), radius = 40},
        {position = position(896, 588, -9), radius = 40}
    },
    queststatus = {from = 150, to = 162},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Diebe", english = "thieves"},
    npcName = "Maelyrra Umrielyth",
    monsterIds = {5, 23, 43, 55} -- different thieves
}
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 163, to = 167},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Zombies", english = "zombies"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {53} -- all zombies
}
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 168, to = 176},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Zombies", english = "zombies"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {53} -- all zombies
}
monsterQuests.addQuest{
    questId = 184,
    location = {position = HUNTING_POS, radius = 300},
    queststatus = {from = 177, to = 189},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Zombies", english = "zombies"},
    npcName = "Maelyrra Umrielyth",
    raceIds = {53} -- all zombies
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
    -- only available if cooldown
    if status == 0 and user:getQuestProgress(186) == 0 then
        return Player.questAvailable
    else
        return Player.questNotAvailable
    end
end

return M
