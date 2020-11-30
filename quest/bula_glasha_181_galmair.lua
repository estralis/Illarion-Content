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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (181, 'quest.bula_glasha_181_galmair');

local common = require("base.common")
local monsterQuests = require("monster.base.quests")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Spitzel Informant"
Title[ENGLISH] = "Spy Informant"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}

Description[GERMAN][1] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Wespen. Die Belohnung ist eine Silberm�nze."
Description[GERMAN][2] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Wespen. Die Belohnung ist eine Silberm�nze."
Description[GERMAN][3] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Wespen. Die Belohnung ist eine Silberm�nze."
Description[GERMAN][4] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Wespen. Die Belohnung ist eine Silberm�nze."
Description[GERMAN][5] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][6] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Wespen. Die Belohnung ist zwei Silberm�nzen."
Description[GERMAN][7] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Wespen. Die Belohnung ist zwei Silberm�nzen."
Description[GERMAN][8] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Wespen. Die Belohnung ist zwei Silberm�nzen."
Description[GERMAN][9] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Wespen. Die Belohnung ist zwei Silberm�nzen."
Description[GERMAN][10] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Wespen. Die Belohnung ist zwei Silberm�nzen."
Description[GERMAN][11] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Wespen. Die Belohnung ist zwei Silberm�nzen."
Description[GERMAN][12] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Wespen. Die Belohnung ist zwei Silberm�nzen."
Description[GERMAN][13] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Wespen. Die Belohnung ist zwei Silberm�nzen."
Description[GERMAN][14] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][15] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Wespen. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][16] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Wespen. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][17] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Wespen. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][18] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Wespen. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][19] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Wespen. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][20] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Wespen. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][21] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Wespen. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][22] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Wespen. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][23] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Wespen. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][24] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Wespen. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][25] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Wespen. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][26] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Wespen. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][27] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][28] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Schleime. Die Belohnung ist zwei Silberm�nzen."
Description[GERMAN][29] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Schleime. Die Belohnung ist zwei Silberm�nzen."
Description[GERMAN][30] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Schleime. Die Belohnung ist zwei Silberm�nzen."
Description[GERMAN][31] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Schleime. Die Belohnung ist zwei Silberm�nzen."
Description[GERMAN][32] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][33] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Schleime. Die Belohnung ist vier Silberm�nzen."
Description[GERMAN][34] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Schleime. Die Belohnung ist vier Silberm�nzen."
Description[GERMAN][35] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Schleime. Die Belohnung ist vier Silberm�nzen."
Description[GERMAN][36] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Schleime. Die Belohnung ist vier Silberm�nzen."
Description[GERMAN][37] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Schleime. Die Belohnung ist vier Silberm�nzen."
Description[GERMAN][38] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Schleime. Die Belohnung ist vier Silberm�nzen."
Description[GERMAN][39] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Schleime. Die Belohnung ist vier Silberm�nzen."
Description[GERMAN][40] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Schleime. Die Belohnung ist vier Silberm�nzen."
Description[GERMAN][41] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][42] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Schleime. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][43] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Schleime. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][44] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Schleime. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][45] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Schleime. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][46] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Schleime. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][47] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Schleime. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][48] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Schleime. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][49] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Schleime. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][50] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Schleime. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][51] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Schleime. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][52] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Schleime. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][53] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Schleime. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][54] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][55] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Hunde. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][56] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Hunde. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][57] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Hunde. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][58] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Hunde. Die Belohnung ist drei Silberm�nzen."
Description[GERMAN][59] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][60] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Hunde. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][61] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Hunde. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][62] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Hunde. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][63] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Hunde. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][64] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Hunde. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][65] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Hunde. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][66] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Hunde. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][67] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Hunde. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][68] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][69] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Hunde. Die Belohnung ist neun Silberm�nzen."
Description[GERMAN][70] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Hunde. Die Belohnung ist neun Silberm�nzen."
Description[GERMAN][71] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Hunde. Die Belohnung ist neun Silberm�nzen."
Description[GERMAN][72] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Hunde. Die Belohnung ist neun Silberm�nzen."
Description[GERMAN][73] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Hunde. Die Belohnung ist neun Silberm�nzen."
Description[GERMAN][74] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Hunde. Die Belohnung ist neun Silberm�nzen."
Description[GERMAN][75] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Hunde. Die Belohnung ist neun Silberm�nzen."
Description[GERMAN][76] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Hunde. Die Belohnung ist neun Silberm�nzen."
Description[GERMAN][77] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Hunde. Die Belohnung ist neun Silberm�nzen."
Description[GERMAN][78] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Hunde. Die Belohnung ist neun Silberm�nzen."
Description[GERMAN][79] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Hunde. Die Belohnung ist neun Silberm�nzen."
Description[GERMAN][80] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Hunde. Die Belohnung ist neun Silberm�nzen."
Description[GERMAN][81] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][82] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier F�chse. Die Belohnung ist vier Silberm�nzen."
Description[GERMAN][83] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier F�chse. Die Belohnung ist vier Silberm�nzen."
Description[GERMAN][84] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier F�chse. Die Belohnung ist vier Silberm�nzen."
Description[GERMAN][85] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier F�chse. Die Belohnung ist vier Silberm�nzen."
Description[GERMAN][86] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][87] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht F�chse. Die Belohnung ist acht Silberm�nzen."
Description[GERMAN][88] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht F�chse. Die Belohnung ist acht Silberm�nzen."
Description[GERMAN][89] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht F�chse. Die Belohnung ist acht Silberm�nzen."
Description[GERMAN][90] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht F�chse. Die Belohnung ist acht Silberm�nzen."
Description[GERMAN][91] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht F�chse. Die Belohnung ist acht Silberm�nzen."
Description[GERMAN][92] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht F�chse. Die Belohnung ist acht Silberm�nzen."
Description[GERMAN][93] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht F�chse. Die Belohnung ist acht Silberm�nzen."
Description[GERMAN][94] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht F�chse. Die Belohnung ist acht Silberm�nzen."
Description[GERMAN][95] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][96] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf F�chse. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][97] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf F�chse. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][98] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf F�chse. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][99] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf F�chse. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][100] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf F�chse. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][101] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf F�chse. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][102] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf F�chse. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][103] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf F�chse. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][104] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf F�chse. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][105] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf F�chse. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][106] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf F�chse. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][107] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf F�chse. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][108] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][109] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Rattenmenschen. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][110] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Rattenmenschen. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][111] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Rattenmenschen. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][112] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Rattenmenschen. Die Belohnung ist sechs Silberm�nzen."
Description[GERMAN][113] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][114] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Rattenmenschen. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][115] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Rattenmenschen. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][116] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Rattenmenschen. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][117] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Rattenmenschen. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][118] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Rattenmenschen. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][119] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Rattenmenschen. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][120] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Rattenmenschen. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][121] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Rattenmenschen. Die Belohnung ist zw�lf Silberm�nzen."
Description[GERMAN][122] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][123] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Rattenmenschen. Die Belohnung ist achtzehn Silberm�nzen."
Description[GERMAN][124] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Rattenmenschen. Die Belohnung ist achtzehn Silberm�nzen."
Description[GERMAN][125] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Rattenmenschen. Die Belohnung ist achtzehn Silberm�nzen."
Description[GERMAN][126] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Rattenmenschen. Die Belohnung ist achtzehn Silberm�nzen."
Description[GERMAN][127] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Rattenmenschen. Die Belohnung ist achtzehn Silberm�nzen."
Description[GERMAN][128] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Rattenmenschen. Die Belohnung ist achtzehn Silberm�nzen."
Description[GERMAN][129] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Rattenmenschen. Die Belohnung ist achtzehn Silberm�nzen."
Description[GERMAN][130] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Rattenmenschen. Die Belohnung ist achtzehn Silberm�nzen."
Description[GERMAN][131] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Rattenmenschen. Die Belohnung ist achtzehn Silberm�nzen."
Description[GERMAN][132] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Rattenmenschen. Die Belohnung ist achtzehn Silberm�nzen."
Description[GERMAN][133] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Rattenmenschen. Die Belohnung ist achtzehn Silberm�nzen."
Description[GERMAN][134] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Rattenmenschen. Die Belohnung ist achtzehn Silberm�nzen."
Description[GERMAN][135] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][136] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier B�ren. Die Belohnung ist acht Silberm�nzen."
Description[GERMAN][137] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier B�ren. Die Belohnung ist acht Silberm�nzen."
Description[GERMAN][138] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier B�ren. Die Belohnung ist acht Silberm�nzen."
Description[GERMAN][139] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier B�ren. Die Belohnung ist acht Silberm�nzen."
Description[GERMAN][140] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][141] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht B�ren. Die Belohnung ist sechzehn Silberm�nzen."
Description[GERMAN][142] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht B�ren. Die Belohnung ist sechzehn Silberm�nzen."
Description[GERMAN][143] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht B�ren. Die Belohnung ist sechzehn Silberm�nzen."
Description[GERMAN][144] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht B�ren. Die Belohnung ist sechzehn Silberm�nzen."
Description[GERMAN][145] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht B�ren. Die Belohnung ist sechzehn Silberm�nzen."
Description[GERMAN][146] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht B�ren. Die Belohnung ist sechzehn Silberm�nzen."
Description[GERMAN][147] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht B�ren. Die Belohnung ist sechzehn Silberm�nzen."
Description[GERMAN][148] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht B�ren. Die Belohnung ist sechzehn Silberm�nzen."
Description[GERMAN][149] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][150] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf B�ren. Die Belohnung ist vierundzwanzig Silberm�nzen."
Description[GERMAN][151] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf B�ren. Die Belohnung ist vierundzwanzig Silberm�nzen."
Description[GERMAN][152] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf B�ren. Die Belohnung ist vierundzwanzig Silberm�nzen."
Description[GERMAN][153] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf B�ren. Die Belohnung ist vierundzwanzig Silberm�nzen."
Description[GERMAN][154] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf B�ren. Die Belohnung ist vierundzwanzig Silberm�nzen."
Description[GERMAN][155] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf B�ren. Die Belohnung ist vierundzwanzig Silberm�nzen."
Description[GERMAN][156] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf B�ren. Die Belohnung ist vierundzwanzig Silberm�nzen."
Description[GERMAN][157] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf B�ren. Die Belohnung ist vierundzwanzig Silberm�nzen."
Description[GERMAN][158] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf B�ren. Die Belohnung ist vierundzwanzig Silberm�nzen."
Description[GERMAN][159] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf B�ren. Die Belohnung ist vierundzwanzig Silberm�nzen."
Description[GERMAN][160] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf B�ren. Die Belohnung ist vierundzwanzig Silberm�nzen."
Description[GERMAN][161] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf B�ren. Die Belohnung ist vierundzwanzig Silberm�nzen."
Description[GERMAN][162] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][163] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Trolle. Die Belohnung ist zehn Silberm�nzen."
Description[GERMAN][164] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Trolle. Die Belohnung ist zehn Silberm�nzen."
Description[GERMAN][165] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Trolle. Die Belohnung ist zehn Silberm�nzen."
Description[GERMAN][166] = "Der Don ben�tigt Information. Erkunde die Umgebung der Stadt nach Informationen und t�te vier Trolle. Die Belohnung ist zehn Silberm�nzen."
Description[GERMAN][167] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][168] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Trolle. Die Belohnung ist zwanzig Silberm�nzen."
Description[GERMAN][169] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Trolle. Die Belohnung ist zwanzig Silberm�nzen."
Description[GERMAN][170] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Trolle. Die Belohnung ist zwanzig Silberm�nzen."
Description[GERMAN][171] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Trolle. Die Belohnung ist zwanzig Silberm�nzen."
Description[GERMAN][172] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Trolle. Die Belohnung ist zwanzig Silberm�nzen."
Description[GERMAN][173] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Trolle. Die Belohnung ist zwanzig Silberm�nzen."
Description[GERMAN][174] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Trolle. Die Belohnung ist zwanzig Silberm�nzen."
Description[GERMAN][175] = "Die Gegend um Galmair wird stetig gef�hrlicher und das gef�hrdet die Einnahmen des Dons. Erkunde die Umgebung der Stadt nach Informationen und t�te acht Trolle. Die Belohnung ist zwanzig Silberm�nzen."
Description[GERMAN][176] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."
Description[GERMAN][177] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Trolle. Die Belohnung ist drei�ig Silberm�nzen."
Description[GERMAN][178] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Trolle. Die Belohnung ist drei�ig Silberm�nzen."
Description[GERMAN][179] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Trolle. Die Belohnung ist drei�ig Silberm�nzen."
Description[GERMAN][180] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Trolle. Die Belohnung ist drei�ig Silberm�nzen."
Description[GERMAN][181] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Trolle. Die Belohnung ist drei�ig Silberm�nzen."
Description[GERMAN][182] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Trolle. Die Belohnung ist drei�ig Silberm�nzen."
Description[GERMAN][183] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Trolle. Die Belohnung ist drei�ig Silberm�nzen."
Description[GERMAN][184] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Trolle. Die Belohnung ist drei�ig Silberm�nzen."
Description[GERMAN][185] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Trolle. Die Belohnung ist drei�ig Silberm�nzen."
Description[GERMAN][186] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Trolle. Die Belohnung ist drei�ig Silberm�nzen."
Description[GERMAN][187] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Trolle. Die Belohnung ist drei�ig Silberm�nzen."
Description[GERMAN][188] = "Auskunfsberichte werden gebraucht um Galmair's Sicherheit zu gew�hren. Erkunde die Umgebung der Stadt nach Informationen und t�te zw�lf Trolle. Die Belohnung ist drei�ig Silberm�nzen."
Description[GERMAN][189] = "Kehre zu Bula Glasha zur�ck um deine Belohnung zu erhalten."

Description[ENGLISH][1] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four wasps, your reward is one silver coin."
Description[ENGLISH][2] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four wasps, your reward is one silver coin."
Description[ENGLISH][3] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four wasps, your reward is one silver coin."
Description[ENGLISH][4] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four wasps, your reward is one silver coin."
Description[ENGLISH][5] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][6] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight wasps, your reward is two silver coins."
Description[ENGLISH][7] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight wasps, your reward is two silver coins."
Description[ENGLISH][8] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight wasps, your reward is two silver coins."
Description[ENGLISH][9] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight wasps, your reward is two silver coins."
Description[ENGLISH][10] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight wasps, your reward is two silver coins."
Description[ENGLISH][11] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight wasps, your reward is two silver coins."
Description[ENGLISH][12] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight wasps, your reward is two silver coins."
Description[ENGLISH][13] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight wasps, your reward is two silver coins."
Description[ENGLISH][14] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][15] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve wasps, your reward is three silver coins."
Description[ENGLISH][16] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve wasps, your reward is three silver coins."
Description[ENGLISH][17] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve wasps, your reward is three silver coins."
Description[ENGLISH][18] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve wasps, your reward is three silver coins."
Description[ENGLISH][19] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve wasps, your reward is three silver coins."
Description[ENGLISH][20] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve wasps, your reward is three silver coins."
Description[ENGLISH][21] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve wasps, your reward is three silver coins."
Description[ENGLISH][22] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve wasps, your reward is three silver coins."
Description[ENGLISH][23] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve wasps, your reward is three silver coins."
Description[ENGLISH][24] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve wasps, your reward is three silver coins."
Description[ENGLISH][25] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve wasps, your reward is three silver coins."
Description[ENGLISH][26] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve wasps, your reward is three silver coins."
Description[ENGLISH][27] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][28] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four slimes your reward is two silver coins."
Description[ENGLISH][29] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four slimes your reward is two silver coins."
Description[ENGLISH][30] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four slimes your reward is two silver coins."
Description[ENGLISH][31] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four slimes your reward is two silver coins."
Description[ENGLISH][32] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][33] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight slimes, your reward is four silver coins."
Description[ENGLISH][34] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight slimes, your reward is four silver coins."
Description[ENGLISH][35] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight slimes, your reward is four silver coins."
Description[ENGLISH][36] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight slimes, your reward is four silver coins."
Description[ENGLISH][37] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight slimes, your reward is four silver coins."
Description[ENGLISH][38] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight slimes, your reward is four silver coins."
Description[ENGLISH][39] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight slimes, your reward is four silver coins."
Description[ENGLISH][40] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight slimes, your reward is four silver coins."
Description[ENGLISH][41] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][42] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve slimes, your reward is six silver coins."
Description[ENGLISH][43] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve slimes, your reward is six silver coins."
Description[ENGLISH][44] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve slimes, your reward is six silver coins."
Description[ENGLISH][45] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve slimes, your reward is six silver coins."
Description[ENGLISH][46] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve slimes, your reward is six silver coins."
Description[ENGLISH][47] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve slimes, your reward is six silver coins."
Description[ENGLISH][48] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve slimes, your reward is six silver coins."
Description[ENGLISH][49] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve slimes, your reward is six silver coins."
Description[ENGLISH][50] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve slimes, your reward is six silver coins."
Description[ENGLISH][51] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve slimes, your reward is six silver coins."
Description[ENGLISH][52] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve slimes, your reward is six silver coins."
Description[ENGLISH][53] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve slimes, your reward is six silver coins."
Description[ENGLISH][54] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][55] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four dogs your reward is three silver coins."
Description[ENGLISH][56] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four dogs your reward is three silver coins."
Description[ENGLISH][57] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four dogs your reward is three silver coins."
Description[ENGLISH][58] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four dogs your reward is three silver coins."
Description[ENGLISH][59] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][60] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight dogs, your reward is six silver coins."
Description[ENGLISH][61] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight dogs, your reward is six silver coins."
Description[ENGLISH][62] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight dogs, your reward is six silver coins."
Description[ENGLISH][63] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight dogs, your reward is six silver coins."
Description[ENGLISH][64] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight dogs, your reward is six silver coins."
Description[ENGLISH][65] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight dogs, your reward is six silver coins."
Description[ENGLISH][66] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight dogs, your reward is six silver coins."
Description[ENGLISH][67] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight dogs, your reward is six silver coins."
Description[ENGLISH][68] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][69] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve dogs, your reward is nine silver coins."
Description[ENGLISH][70] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve dogs, your reward is nine silver coins."
Description[ENGLISH][71] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve dogs, your reward is nine silver coins."
Description[ENGLISH][72] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve dogs, your reward is nine silver coins."
Description[ENGLISH][73] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve dogs, your reward is nine silver coins."
Description[ENGLISH][74] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve dogs, your reward is nine silver coins."
Description[ENGLISH][75] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve dogs, your reward is nine silver coins."
Description[ENGLISH][76] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve dogs, your reward is nine silver coins."
Description[ENGLISH][77] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve dogs, your reward is nine silver coins."
Description[ENGLISH][78] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve dogs, your reward is nine silver coins."
Description[ENGLISH][79] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve dogs, your reward is nine silver coins."
Description[ENGLISH][80] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve dogs, your reward is nine silver coins."
Description[ENGLISH][81] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][82] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four foxes your reward is four silver coins."
Description[ENGLISH][83] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four foxes your reward is four silver coins."
Description[ENGLISH][84] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four foxes your reward is four silver coins."
Description[ENGLISH][85] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four foxes your reward is four silver coins."
Description[ENGLISH][86] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][87] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight foxes, your reward is eight silver coins."
Description[ENGLISH][88] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight foxes, your reward is eight silver coins."
Description[ENGLISH][89] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight foxes, your reward is eight silver coins."
Description[ENGLISH][90] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight foxes, your reward is eight silver coins."
Description[ENGLISH][91] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight foxes, your reward is eight silver coins."
Description[ENGLISH][92] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight foxes, your reward is eight silver coins."
Description[ENGLISH][93] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight foxes, your reward is eight silver coins."
Description[ENGLISH][94] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight foxes, your reward is eight silver coins."
Description[ENGLISH][95] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][96] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve foxes, your reward is twelve silver coins."
Description[ENGLISH][97] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve foxes, your reward is twelve silver coins."
Description[ENGLISH][98] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve foxes, your reward is twelve silver coins."
Description[ENGLISH][99] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve foxes, your reward is twelve silver coins."
Description[ENGLISH][100] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve foxes, your reward is twelve silver coins."
Description[ENGLISH][101] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve foxes, your reward is twelve silver coins."
Description[ENGLISH][102] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve foxes, your reward is twelve silver coins."
Description[ENGLISH][103] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve foxes, your reward is twelve silver coins."
Description[ENGLISH][104] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve foxes, your reward is twelve silver coins."
Description[ENGLISH][105] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve foxes, your reward is twelve silver coins."
Description[ENGLISH][106] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve foxes, your reward is twelve silver coins."
Description[ENGLISH][107] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve foxes, your reward is twelve silver coins."
Description[ENGLISH][108] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][109] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four ratmen your reward is six silver coins."
Description[ENGLISH][110] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four ratmen your reward is six silver coins."
Description[ENGLISH][111] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four ratmen your reward is six silver coins."
Description[ENGLISH][112] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four ratmen your reward is six silver coins."
Description[ENGLISH][113] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][114] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight ratmen, your reward is twelve silver coins."
Description[ENGLISH][115] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight ratmen, your reward is twelve silver coins."
Description[ENGLISH][116] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight ratmen, your reward is twelve silver coins."
Description[ENGLISH][117] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight ratmen, your reward is twelve silver coins."
Description[ENGLISH][118] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight ratmen, your reward is twelve silver coins."
Description[ENGLISH][119] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight ratmen, your reward is twelve silver coins."
Description[ENGLISH][120] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight ratmen, your reward is twelve silver coins."
Description[ENGLISH][121] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight ratmen, your reward is twelve silver coins."
Description[ENGLISH][122] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][123] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve ratmen, your reward is eighteen silver coins."
Description[ENGLISH][124] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve ratmen, your reward is eighteen silver coins."
Description[ENGLISH][125] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve ratmen, your reward is eighteen silver coins."
Description[ENGLISH][126] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve ratmen, your reward is eighteen silver coins."
Description[ENGLISH][127] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve ratmen, your reward is eighteen silver coins."
Description[ENGLISH][128] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve ratmen, your reward is eighteen silver coins."
Description[ENGLISH][129] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve ratmen, your reward is eighteen silver coins."
Description[ENGLISH][130] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve ratmen, your reward is eighteen silver coins."
Description[ENGLISH][131] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve ratmen, your reward is eighteen silver coins."
Description[ENGLISH][132] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve ratmen, your reward is eighteen silver coins."
Description[ENGLISH][133] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve ratmen, your reward is eighteen silver coins."
Description[ENGLISH][134] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve ratmen, your reward is eighteen silver coins."
Description[ENGLISH][135] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][136] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four bears your reward is eight silver coins."
Description[ENGLISH][137] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four bears your reward is eight silver coins."
Description[ENGLISH][138] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four bears your reward is eight silver coins."
Description[ENGLISH][139] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four bears your reward is eight silver coins."
Description[ENGLISH][140] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][141] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight bears, your reward is sixteen silver coins."
Description[ENGLISH][142] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight bears, your reward is sixteen silver coins."
Description[ENGLISH][143] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight bears, your reward is sixteen silver coins."
Description[ENGLISH][144] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight bears, your reward is sixteen silver coins."
Description[ENGLISH][145] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight bears, your reward is sixteen silver coins."
Description[ENGLISH][146] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight bears, your reward is sixteen silver coins."
Description[ENGLISH][147] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight bears, your reward is sixteen silver coins."
Description[ENGLISH][148] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight bears, your reward is sixteen silver coins."
Description[ENGLISH][149] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][150] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve bears, your reward is twenty four silver coins."
Description[ENGLISH][151] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve bears, your reward is twenty four silver coins."
Description[ENGLISH][152] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve bears, your reward is twenty four silver coins."
Description[ENGLISH][153] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve bears, your reward is twenty four silver coins."
Description[ENGLISH][154] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve bears, your reward is twenty four silver coins."
Description[ENGLISH][155] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve bears, your reward is twenty four silver coins."
Description[ENGLISH][156] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve bears, your reward is twenty four silver coins."
Description[ENGLISH][157] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve bears, your reward is twenty four silver coins."
Description[ENGLISH][158] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve bears, your reward is twenty four silver coins."
Description[ENGLISH][159] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve bears, your reward is twenty four silver coins."
Description[ENGLISH][160] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve bears, your reward is twenty four silver coins."
Description[ENGLISH][161] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve bears, your reward is twenty four silver coins."
Description[ENGLISH][162] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][163] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four trolls your reward is ten silver coins."
Description[ENGLISH][164] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four trolls your reward is ten silver coins."
Description[ENGLISH][165] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four trolls your reward is ten silver coins."
Description[ENGLISH][166] = "There is information to be gathered for the Don. Scout the area outside of town for information and kill four trolls your reward is ten silver coins."
Description[ENGLISH][167] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][168] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight trolls, your reward is twenty silver coins."
Description[ENGLISH][169] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight trolls, your reward is twenty silver coins."
Description[ENGLISH][170] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight trolls, your reward is twenty silver coins."
Description[ENGLISH][171] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight trolls, your reward is twenty silver coins."
Description[ENGLISH][172] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight trolls, your reward is twenty silver coins."
Description[ENGLISH][173] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight trolls, your reward is twenty silver coins."
Description[ENGLISH][174] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight trolls, your reward is twenty silver coins."
Description[ENGLISH][175] = "The area around Galmair has become increasing violent and this is hindering the Don's profits.  Scout the area outside of town for information and kill eight trolls, your reward is twenty silver coins."
Description[ENGLISH][176] = "Return to Bula Glasha to claim your reward."
Description[ENGLISH][177] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve trolls, your reward is thirty silver coins."
Description[ENGLISH][178] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve trolls, your reward is thirty silver coins."
Description[ENGLISH][179] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve trolls, your reward is thirty silver coins."
Description[ENGLISH][180] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve trolls, your reward is thirty silver coins."
Description[ENGLISH][181] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve trolls, your reward is thirty silver coins."
Description[ENGLISH][182] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve trolls, your reward is thirty silver coins."
Description[ENGLISH][183] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve trolls, your reward is thirty silver coins."
Description[ENGLISH][184] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve trolls, your reward is thirty silver coins."
Description[ENGLISH][185] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve trolls, your reward is thirty silver coins."
Description[ENGLISH][186] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve trolls, your reward is thirty silver coins."
Description[ENGLISH][187] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve trolls, your reward is thirty silver coins."
Description[ENGLISH][188] = "Intelligence reports are needed for the safety of Galmair.  Scout the area outside of town for information and kill twelve trolls, your reward is thirty silver coins."
Description[ENGLISH][189] = "Return to Bula Glasha to claim your reward."


-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {407, 232, 0}

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
QuestTarget[1] = {position(407, 232, 0)} -- Bula
QuestTarget[2] = {position(407, 232, 0)} -- Bula
QuestTarget[3] = {position(407, 232, 0)} -- Bula
QuestTarget[4] = {position(407, 232, 0)} -- Bula
QuestTarget[5] = {position(407, 232, 0)} -- Bula
QuestTarget[6] = {position(407, 232, 0)} -- Bula
QuestTarget[7] = {position(407, 232, 0)} -- Bula
QuestTarget[8] = {position(407, 232, 0)} -- Bula
QuestTarget[9] = {position(407, 232, 0)} -- Bula
QuestTarget[10] = {position(407, 232, 0)} -- Bula
QuestTarget[11] = {position(407, 232, 0)} -- Bula
QuestTarget[12] = {position(407, 232, 0)} -- Bula
QuestTarget[13] = {position(407, 232, 0)} -- Bula
QuestTarget[14] = {position(407, 232, 0)} -- Bula
QuestTarget[15] = {position(407, 232, 0)} -- Bula
QuestTarget[16] = {position(407, 232, 0)} -- Bula
QuestTarget[17] = {position(407, 232, 0)} -- Bula
QuestTarget[18] = {position(407, 232, 0)} -- Bula
QuestTarget[19] = {position(407, 232, 0)} -- Bula
QuestTarget[20] = {position(407, 232, 0)} -- Bula
QuestTarget[21] = {position(407, 232, 0)} -- Bula
QuestTarget[22] = {position(407, 232, 0)} -- Bula
QuestTarget[23] = {position(407, 232, 0)} -- Bula
QuestTarget[24] = {position(407, 232, 0)} -- Bula
QuestTarget[25] = {position(407, 232, 0)} -- Bula
QuestTarget[26] = {position(407, 232, 0)} -- Bula
QuestTarget[27] = {position(407, 232, 0)} -- Bula
QuestTarget[28] = {position(407, 232, 0)} -- Bula
QuestTarget[29] = {position(407, 232, 0)} -- Bula
QuestTarget[30] = {position(407, 232, 0)} -- Bula
QuestTarget[31] = {position(407, 232, 0)} -- Bula
QuestTarget[32] = {position(407, 232, 0)} -- Bula
QuestTarget[33] = {position(407, 232, 0)} -- Bula
QuestTarget[34] = {position(407, 232, 0)} -- Bula
QuestTarget[35] = {position(407, 232, 0)} -- Bula
QuestTarget[36] = {position(407, 232, 0)} -- Bula
QuestTarget[37] = {position(407, 232, 0)} -- Bula
QuestTarget[38] = {position(407, 232, 0)} -- Bula
QuestTarget[39] = {position(407, 232, 0)} -- Bula
QuestTarget[40] = {position(407, 232, 0)} -- Bula
QuestTarget[41] = {position(407, 232, 0)} -- Bula
QuestTarget[42] = {position(407, 232, 0)} -- Bula
QuestTarget[43] = {position(407, 232, 0)} -- Bula
QuestTarget[44] = {position(407, 232, 0)} -- Bula
QuestTarget[45] = {position(407, 232, 0)} -- Bula
QuestTarget[46] = {position(407, 232, 0)} -- Bula
QuestTarget[47] = {position(407, 232, 0)} -- Bula
QuestTarget[48] = {position(407, 232, 0)} -- Bula
QuestTarget[49] = {position(407, 232, 0)} -- Bula
QuestTarget[50] = {position(407, 232, 0)} -- Bula
QuestTarget[51] = {position(407, 232, 0)} -- Bula
QuestTarget[52] = {position(407, 232, 0)} -- Bula
QuestTarget[53] = {position(407, 232, 0)} -- Bula
QuestTarget[54] = {position(407, 232, 0)} -- Bula
QuestTarget[55] = {position(407, 232, 0)} -- Bula
QuestTarget[56] = {position(407, 232, 0)} -- Bula
QuestTarget[57] = {position(407, 232, 0)} -- Bula
QuestTarget[58] = {position(407, 232, 0)} -- Bula
QuestTarget[59] = {position(407, 232, 0)} -- Bula
QuestTarget[60] = {position(407, 232, 0)} -- Bula
QuestTarget[61] = {position(407, 232, 0)} -- Bula
QuestTarget[62] = {position(407, 232, 0)} -- Bula
QuestTarget[63] = {position(407, 232, 0)} -- Bula
QuestTarget[64] = {position(407, 232, 0)} -- Bula
QuestTarget[65] = {position(407, 232, 0)} -- Bula
QuestTarget[66] = {position(407, 232, 0)} -- Bula
QuestTarget[67] = {position(407, 232, 0)} -- Bula
QuestTarget[68] = {position(407, 232, 0)} -- Bula
QuestTarget[69] = {position(407, 232, 0)} -- Bula
QuestTarget[70] = {position(407, 232, 0)} -- Bula
QuestTarget[71] = {position(407, 232, 0)} -- Bula
QuestTarget[72] = {position(407, 232, 0)} -- Bula
QuestTarget[73] = {position(407, 232, 0)} -- Bula
QuestTarget[74] = {position(407, 232, 0)} -- Bula
QuestTarget[75] = {position(407, 232, 0)} -- Bula
QuestTarget[76] = {position(407, 232, 0)} -- Bula
QuestTarget[77] = {position(407, 232, 0)} -- Bula
QuestTarget[78] = {position(407, 232, 0)} -- Bula
QuestTarget[79] = {position(407, 232, 0)} -- Bula
QuestTarget[80] = {position(407, 232, 0)} -- Bula
QuestTarget[81] = {position(407, 232, 0)} -- Bula
QuestTarget[82] = {position(407, 232, 0)} -- Bula
QuestTarget[83] = {position(407, 232, 0)} -- Bula
QuestTarget[84] = {position(407, 232, 0)} -- Bula
QuestTarget[85] = {position(407, 232, 0)} -- Bula
QuestTarget[86] = {position(407, 232, 0)} -- Bula
QuestTarget[87] = {position(407, 232, 0)} -- Bula
QuestTarget[88] = {position(407, 232, 0)} -- Bula
QuestTarget[89] = {position(407, 232, 0)} -- Bula
QuestTarget[90] = {position(407, 232, 0)} -- Bula
QuestTarget[91] = {position(407, 232, 0)} -- Bula
QuestTarget[92] = {position(407, 232, 0)} -- Bula
QuestTarget[93] = {position(407, 232, 0)} -- Bula
QuestTarget[94] = {position(407, 232, 0)} -- Bula
QuestTarget[95] = {position(407, 232, 0)} -- Bula
QuestTarget[96] = {position(407, 232, 0)} -- Bula
QuestTarget[97] = {position(407, 232, 0)} -- Bula
QuestTarget[98] = {position(407, 232, 0)} -- Bula
QuestTarget[99] = {position(407, 232, 0)} -- Bula
QuestTarget[100] = {position(407, 232, 0)} -- Bula
QuestTarget[101] = {position(407, 232, 0)} -- Bula
QuestTarget[102] = {position(407, 232, 0)} -- Bula
QuestTarget[103] = {position(407, 232, 0)} -- Bula
QuestTarget[104] = {position(407, 232, 0)} -- Bula
QuestTarget[105] = {position(407, 232, 0)} -- Bula
QuestTarget[106] = {position(407, 232, 0)} -- Bula
QuestTarget[107] = {position(407, 232, 0)} -- Bula
QuestTarget[108] = {position(407, 232, 0)} -- Bula
QuestTarget[109] = {position(407, 232, 0)} -- Bula
QuestTarget[110] = {position(407, 232, 0)} -- Bula
QuestTarget[111] = {position(407, 232, 0)} -- Bula
QuestTarget[112] = {position(407, 232, 0)} -- Bula
QuestTarget[113] = {position(407, 232, 0)} -- Bula
QuestTarget[114] = {position(407, 232, 0)} -- Bula
QuestTarget[115] = {position(407, 232, 0)} -- Bula
QuestTarget[116] = {position(407, 232, 0)} -- Bula
QuestTarget[117] = {position(407, 232, 0)} -- Bula
QuestTarget[118] = {position(407, 232, 0)} -- Bula
QuestTarget[119] = {position(407, 232, 0)} -- Bula
QuestTarget[120] = {position(407, 232, 0)} -- Bula
QuestTarget[121] = {position(407, 232, 0)} -- Bula
QuestTarget[122] = {position(407, 232, 0)} -- Bula
QuestTarget[123] = {position(407, 232, 0)} -- Bula
QuestTarget[124] = {position(407, 232, 0)} -- Bula
QuestTarget[125] = {position(407, 232, 0)} -- Bula
QuestTarget[126] = {position(407, 232, 0)} -- Bula
QuestTarget[127] = {position(407, 232, 0)} -- Bula
QuestTarget[128] = {position(407, 232, 0)} -- Bula
QuestTarget[129] = {position(407, 232, 0)} -- Bula
QuestTarget[130] = {position(407, 232, 0)} -- Bula
QuestTarget[131] = {position(407, 232, 0)} -- Bula
QuestTarget[132] = {position(407, 232, 0)} -- Bula
QuestTarget[133] = {position(407, 232, 0)} -- Bula
QuestTarget[134] = {position(407, 232, 0)} -- Bula
QuestTarget[135] = {position(407, 232, 0)} -- Bula
QuestTarget[136] = {position(407, 232, 0)} -- Bula
QuestTarget[137] = {position(407, 232, 0)} -- Bula
QuestTarget[138] = {position(407, 232, 0)} -- Bula
QuestTarget[139] = {position(407, 232, 0)} -- Bula
QuestTarget[140] = {position(407, 232, 0)} -- Bula
QuestTarget[141] = {position(407, 232, 0)} -- Bula
QuestTarget[142] = {position(407, 232, 0)} -- Bula
QuestTarget[143] = {position(407, 232, 0)} -- Bula
QuestTarget[144] = {position(407, 232, 0)} -- Bula
QuestTarget[145] = {position(407, 232, 0)} -- Bula
QuestTarget[146] = {position(407, 232, 0)} -- Bula
QuestTarget[147] = {position(407, 232, 0)} -- Bula
QuestTarget[148] = {position(407, 232, 0)} -- Bula
QuestTarget[149] = {position(407, 232, 0)} -- Bula
QuestTarget[150] = {position(407, 232, 0)} -- Bula
QuestTarget[151] = {position(407, 232, 0)} -- Bula
QuestTarget[152] = {position(407, 232, 0)} -- Bula
QuestTarget[153] = {position(407, 232, 0)} -- Bula
QuestTarget[154] = {position(407, 232, 0)} -- Bula
QuestTarget[155] = {position(407, 232, 0)} -- Bula
QuestTarget[156] = {position(407, 232, 0)} -- Bula
QuestTarget[157] = {position(407, 232, 0)} -- Bula
QuestTarget[158] = {position(407, 232, 0)} -- Bula
QuestTarget[159] = {position(407, 232, 0)} -- Bula
QuestTarget[160] = {position(407, 232, 0)} -- Bula
QuestTarget[161] = {position(407, 232, 0)} -- Bula
QuestTarget[162] = {position(407, 232, 0)} -- Bula
QuestTarget[163] = {position(407, 232, 0)} -- Bula
QuestTarget[164] = {position(407, 232, 0)} -- Bula
QuestTarget[165] = {position(407, 232, 0)} -- Bula
QuestTarget[166] = {position(407, 232, 0)} -- Bula
QuestTarget[167] = {position(407, 232, 0)} -- Bula
QuestTarget[168] = {position(407, 232, 0)} -- Bula
QuestTarget[169] = {position(407, 232, 0)} -- Bula
QuestTarget[170] = {position(407, 232, 0)} -- Bula
QuestTarget[171] = {position(407, 232, 0)} -- Bula
QuestTarget[172] = {position(407, 232, 0)} -- Bula
QuestTarget[173] = {position(407, 232, 0)} -- Bula
QuestTarget[174] = {position(407, 232, 0)} -- Bula
QuestTarget[175] = {position(407, 232, 0)} -- Bula
QuestTarget[176] = {position(407, 232, 0)} -- Bula
QuestTarget[177] = {position(407, 232, 0)} -- Bula
QuestTarget[178] = {position(407, 232, 0)} -- Bula
QuestTarget[179] = {position(407, 232, 0)} -- Bula
QuestTarget[180] = {position(407, 232, 0)} -- Bula
QuestTarget[181] = {position(407, 232, 0)} -- Bula
QuestTarget[182] = {position(407, 232, 0)} -- Bula
QuestTarget[183] = {position(407, 232, 0)} -- Bula
QuestTarget[184] = {position(407, 232, 0)} -- Bula
QuestTarget[185] = {position(407, 232, 0)} -- Bula
QuestTarget[186] = {position(407, 232, 0)} -- Bula
QuestTarget[187] = {position(407, 232, 0)} -- Bula
QuestTarget[188] = {position(407, 232, 0)} -- Bula
QuestTarget[189] = {position(407, 232, 0)} -- Bula

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 0

-- Register the monster kill parts of the quest.
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 1, to = 5},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Wespen", english = "wasps"},
    npcName = "Bula Glasha",
    raceIds = {27} -- all wasps
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 6, to = 14},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Wespen", english = "wasps"},
    npcName = "Bula Glasha",
    raceIds = {27} -- all wasps
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 15, to = 27},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Wespen", english = "wasps"},
    npcName = "Bula Glasha",
    raceIds = {27} -- all wasps
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 28, to = 32},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Schleime", english = "slimes"},
    npcName = "Bula Glasha",
    raceIds = {61} -- all slimes
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 33, to = 41},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Schleime", english = "slimes"},
    npcName = "Bula Glasha",
    raceIds = {61} -- all slimes
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 42, to = 54},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Schleime", english = "slimes"},
    npcName = "Bula Glasha",
    raceIds = {61} -- all slimes
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 55, to = 59},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Hunde", english = "dogs"},
    npcName = "Bula Glasha",
    raceIds = {58} -- all dogs
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 60, to = 68},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Hunde", english = "dogs"},
    npcName = "Bula Glasha",
    raceIds = {58} -- all dogs
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 69, to = 81},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Hunde", english = "dogs"},
    npcName = "Bula Glasha",
    raceIds = {58} -- all dogs
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 82, to = 86},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "F�chse", english = "foxes"},
    npcName = "Bula Glasha",
    raceIds = {60} -- all foxes
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 87, to = 95},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "F�chse", english = "foxes"},
    npcName = "Bula Glasha",
    raceIds = {60} -- all foxes
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 96, to = 108},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "F�chse", english = "foxes"},
    npcName = "Bula Glasha",
    raceIds = {60} -- all foxes
}
monsterQuests.addQuest{
    questId = 181,
    locations = {
        {position = position(564, 178, 0), radius = 450},
        {position = position(576, 192, -3), radius = 100}
    },
    queststatus = {from = 109, to = 113},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Rattenmenschen", english = "ratmen"},
    npcName = "Bula Glasha",
    raceIds = {57} -- all ratmen
}
monsterQuests.addQuest{
    questId = 181,
    locations = {
        {position = position(564, 178, 0), radius = 450},
        {position = position(576, 192, -3), radius = 100}
    },
    queststatus = {from = 114, to = 122},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Rattenmenschen", english = "ratmen"},
    npcName = "Bula Glasha",
    raceIds = {57} -- all ratmen
}
monsterQuests.addQuest{
    questId = 181,
    locations = {
        {position = position(564, 178, 0), radius = 450},
        {position = position(576, 192, -3), radius = 100}
    },
    queststatus = {from = 123, to = 135},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Rattenmenschen", english = "ratmen"},
    npcName = "Bula Glasha",
    raceIds = {57} -- all ratmen
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 136, to = 140},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "B�ren", english = "bears"},
    npcName = "Bula Glasha",
    raceIds = {51} -- all bears
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 141, to = 149},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "B�ren", english = "bears"},
    npcName = "Bula Glasha",
    raceIds = {51} -- all bears
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 150, to = 162},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "B�ren", english = "bears"},
    npcName = "Bula Glasha",
    raceIds = {51} -- all bears
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 163, to = 167},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Trolle", english = "trolls"},
    npcName = "Bula Glasha",
    raceIds = {9} -- all trolls
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 168, to = 176},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Trolle", english = "trolls"},
    npcName = "Bula Glasha",
    raceIds = {9} -- all trolls
}
monsterQuests.addQuest{
    questId = 181,
    location = {position = position(564, 178, 0), radius = 450},
    queststatus = {from = 177, to = 189},
    questTitle = {german = "Spitzel Informant", english = "Spy Informant"},
    monsterName = {german = "Trolle", english = "trolls"},
    npcName = "Bula Glasha",
    raceIds = {9} -- all trolls
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
    if status == 0 and user:getQuestProgress(183) == 0 then
        return Player.questAvailable
    else
        return Player.questNotAvailable
    end
end

return M
