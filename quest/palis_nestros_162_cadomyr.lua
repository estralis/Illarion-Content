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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (162, 'quest.palis_nestros_162_cadomyr');

local common = require("base.common")
local monsterQuests = require("monster.base.quests")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Ruhmhafte Kopfgeldjagd"
Title[ENGLISH] = "Glorious Bounty"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}

Description[GERMAN][1] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von einem Silberst�ck an denjenigen auszuzahlen, der vier K�fer erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][2] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von einem Silberst�ck an denjenigen auszuzahlen, der vier K�fer erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][3] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von einem Silberst�ck an denjenigen auszuzahlen, der vier K�fer erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][4] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von einem Silberst�ck an denjenigen auszuzahlen, der vier K�fer erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][5] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][6] = "Ihre Majest�t hat ein Kopfgeld auf acht K�fer ausgesetzt. Wenn ihr euch zwei Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][7] = "Ihre Majest�t hat ein Kopfgeld auf acht K�fer ausgesetzt. Wenn ihr euch zwei Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][8] = "Ihre Majest�t hat ein Kopfgeld auf acht K�fer ausgesetzt. Wenn ihr euch zwei Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][9] = "Ihre Majest�t hat ein Kopfgeld auf acht K�fer ausgesetzt. Wenn ihr euch zwei Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][10] = "Ihre Majest�t hat ein Kopfgeld auf acht K�fer ausgesetzt. Wenn ihr euch zwei Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][11] = "Ihre Majest�t hat ein Kopfgeld auf acht K�fer ausgesetzt. Wenn ihr euch zwei Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][12] = "Ihre Majest�t hat ein Kopfgeld auf acht K�fer ausgesetzt. Wenn ihr euch zwei Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][13] = "Ihre Majest�t hat ein Kopfgeld auf acht K�fer ausgesetzt. Wenn ihr euch zwei Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][14] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][15] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf K�fer ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei Silberst�cke werden eure Belohnung sein."
Description[GERMAN][16] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf K�fer ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei Silberst�cke werden eure Belohnung sein."
Description[GERMAN][17] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf K�fer ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei Silberst�cke werden eure Belohnung sein."
Description[GERMAN][18] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf K�fer ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei Silberst�cke werden eure Belohnung sein."
Description[GERMAN][19] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf K�fer ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei Silberst�cke werden eure Belohnung sein."
Description[GERMAN][20] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf K�fer ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei Silberst�cke werden eure Belohnung sein."
Description[GERMAN][21] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf K�fer ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei Silberst�cke werden eure Belohnung sein."
Description[GERMAN][22] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf K�fer ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei Silberst�cke werden eure Belohnung sein."
Description[GERMAN][23] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf K�fer ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei Silberst�cke werden eure Belohnung sein."
Description[GERMAN][24] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf K�fer ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei Silberst�cke werden eure Belohnung sein."
Description[GERMAN][25] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf K�fer ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei Silberst�cke werden eure Belohnung sein."
Description[GERMAN][26] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf K�fer ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei Silberst�cke werden eure Belohnung sein."
Description[GERMAN][27] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][28] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von zwei Silberst�cken an denjenigen auszuzahlen, der vier Wespen erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][29] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von zwei Silberst�cken an denjenigen auszuzahlen, der vier Wespen erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][30] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von zwei Silberst�cken an denjenigen auszuzahlen, der vier Wespen erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][31] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von zwei Silberst�cken an denjenigen auszuzahlen, der vier Wespen erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][32] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][33] = "Ihre Majest�t hat ein Kopfgeld auf acht Wespen ausgesetzt. Wenn ihr euch vier Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][34] = "Ihre Majest�t hat ein Kopfgeld auf acht Wespen ausgesetzt. Wenn ihr euch vier Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][35] = "Ihre Majest�t hat ein Kopfgeld auf acht Wespen ausgesetzt. Wenn ihr euch vier Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][36] = "Ihre Majest�t hat ein Kopfgeld auf acht Wespen ausgesetzt. Wenn ihr euch vier Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][37] = "Ihre Majest�t hat ein Kopfgeld auf acht Wespen ausgesetzt. Wenn ihr euch vier Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][38] = "Ihre Majest�t hat ein Kopfgeld auf acht Wespen ausgesetzt. Wenn ihr euch vier Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][39] = "Ihre Majest�t hat ein Kopfgeld auf acht Wespen ausgesetzt. Wenn ihr euch vier Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][40] = "Ihre Majest�t hat ein Kopfgeld auf acht Wespen ausgesetzt. Wenn ihr euch vier Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][41] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][42] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Wespen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, sechs Silberst�cke werden eure Belohnung sein."
Description[GERMAN][43] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Wespen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, sechs Silberst�cke werden eure Belohnung sein."
Description[GERMAN][44] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Wespen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, sechs Silberst�cke werden eure Belohnung sein."
Description[GERMAN][45] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Wespen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, sechs Silberst�cke werden eure Belohnung sein."
Description[GERMAN][46] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Wespen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, sechs Silberst�cke werden eure Belohnung sein."
Description[GERMAN][47] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Wespen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, sechs Silberst�cke werden eure Belohnung sein."
Description[GERMAN][48] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Wespen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, sechs Silberst�cke werden eure Belohnung sein."
Description[GERMAN][49] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Wespen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, sechs Silberst�cke werden eure Belohnung sein."
Description[GERMAN][50] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Wespen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, sechs Silberst�cke werden eure Belohnung sein."
Description[GERMAN][51] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Wespen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, sechs Silberst�cke werden eure Belohnung sein."
Description[GERMAN][52] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Wespen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, sechs Silberst�cke werden eure Belohnung sein."
Description[GERMAN][53] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Wespen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, sechs Silberst�cke werden eure Belohnung sein."
Description[GERMAN][54] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][55] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von drei Silberst�cken an denjenigen auszuzahlen, der vier Hunde erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][56] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von drei Silberst�cken an denjenigen auszuzahlen, der vier Hunde erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][57] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von drei Silberst�cken an denjenigen auszuzahlen, der vier Hunde erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][58] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von drei Silberst�cken an denjenigen auszuzahlen, der vier Hunde erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][59] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][60] = "Ihre Majest�t hat ein Kopfgeld auf acht Hunde ausgesetzt. Wenn ihr euch sechs Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][61] = "Ihre Majest�t hat ein Kopfgeld auf acht Hunde ausgesetzt. Wenn ihr euch sechs Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][62] = "Ihre Majest�t hat ein Kopfgeld auf acht Hunde ausgesetzt. Wenn ihr euch sechs Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][63] = "Ihre Majest�t hat ein Kopfgeld auf acht Hunde ausgesetzt. Wenn ihr euch sechs Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][64] = "Ihre Majest�t hat ein Kopfgeld auf acht Hunde ausgesetzt. Wenn ihr euch sechs Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][65] = "Ihre Majest�t hat ein Kopfgeld auf acht Hunde ausgesetzt. Wenn ihr euch sechs Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][66] = "Ihre Majest�t hat ein Kopfgeld auf acht Hunde ausgesetzt. Wenn ihr euch sechs Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][67] = "Ihre Majest�t hat ein Kopfgeld auf acht Hunde ausgesetzt. Wenn ihr euch sechs Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][68] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][69] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Hunde ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, neun Silberst�cke werden eure Belohnung sein."
Description[GERMAN][70] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Hunde ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, neun Silberst�cke werden eure Belohnung sein."
Description[GERMAN][71] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Hunde ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, neun Silberst�cke werden eure Belohnung sein."
Description[GERMAN][72] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Hunde ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, neun Silberst�cke werden eure Belohnung sein."
Description[GERMAN][73] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Hunde ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, neun Silberst�cke werden eure Belohnung sein."
Description[GERMAN][74] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Hunde ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, neun Silberst�cke werden eure Belohnung sein."
Description[GERMAN][75] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Hunde ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, neun Silberst�cke werden eure Belohnung sein."
Description[GERMAN][76] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Hunde ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, neun Silberst�cke werden eure Belohnung sein."
Description[GERMAN][77] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Hunde ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, neun Silberst�cke werden eure Belohnung sein."
Description[GERMAN][78] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Hunde ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, neun Silberst�cke werden eure Belohnung sein."
Description[GERMAN][79] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Hunde ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, neun Silberst�cke werden eure Belohnung sein."
Description[GERMAN][80] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Hunde ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, neun Silberst�cke werden eure Belohnung sein."
Description[GERMAN][81] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][82] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von vier Silberst�cken an denjenigen auszuzahlen, der vier F�chse erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][83] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von vier Silberst�cken an denjenigen auszuzahlen, der vier F�chse erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][84] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von vier Silberst�cken an denjenigen auszuzahlen, der vier F�chse erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][85] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von vier Silberst�cken an denjenigen auszuzahlen, der vier F�chse erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][86] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][87] = "Ihre Majest�t hat ein Kopfgeld auf acht F�chse ausgesetzt. Wenn ihr euch acht Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][88] = "Ihre Majest�t hat ein Kopfgeld auf acht F�chse ausgesetzt. Wenn ihr euch acht Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][89] = "Ihre Majest�t hat ein Kopfgeld auf acht F�chse ausgesetzt. Wenn ihr euch acht Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][90] = "Ihre Majest�t hat ein Kopfgeld auf acht F�chse ausgesetzt. Wenn ihr euch acht Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][91] = "Ihre Majest�t hat ein Kopfgeld auf acht F�chse ausgesetzt. Wenn ihr euch acht Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][92] = "Ihre Majest�t hat ein Kopfgeld auf acht F�chse ausgesetzt. Wenn ihr euch acht Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][93] = "Ihre Majest�t hat ein Kopfgeld auf acht F�chse ausgesetzt. Wenn ihr euch acht Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][94] = "Ihre Majest�t hat ein Kopfgeld auf acht F�chse ausgesetzt. Wenn ihr euch acht Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][95] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][96] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf F�chse ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, zw�lf Silberst�cke werden eure Belohnung sein."
Description[GERMAN][97] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf F�chse ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, zw�lf Silberst�cke werden eure Belohnung sein."
Description[GERMAN][98] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf F�chse ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, zw�lf Silberst�cke werden eure Belohnung sein."
Description[GERMAN][99] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf F�chse ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, zw�lf Silberst�cke werden eure Belohnung sein."
Description[GERMAN][100] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf F�chse ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, zw�lf Silberst�cke werden eure Belohnung sein."
Description[GERMAN][101] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf F�chse ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, zw�lf Silberst�cke werden eure Belohnung sein."
Description[GERMAN][102] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf F�chse ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, zw�lf Silberst�cke werden eure Belohnung sein."
Description[GERMAN][103] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf F�chse ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, zw�lf Silberst�cke werden eure Belohnung sein."
Description[GERMAN][104] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf F�chse ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, zw�lf Silberst�cke werden eure Belohnung sein."
Description[GERMAN][105] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf F�chse ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, zw�lf Silberst�cke werden eure Belohnung sein."
Description[GERMAN][106] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf F�chse ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, zw�lf Silberst�cke werden eure Belohnung sein."
Description[GERMAN][107] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf F�chse ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, zw�lf Silberst�cke werden eure Belohnung sein."
Description[GERMAN][108] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][109] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von sechs Silberst�cken an denjenigen auszuzahlen, der vier Menschen erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][110] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von sechs Silberst�cken an denjenigen auszuzahlen, der vier Menschen erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][111] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von sechs Silberst�cken an denjenigen auszuzahlen, der vier Menschen erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][112] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von sechs Silberst�cken an denjenigen auszuzahlen, der vier Menschen erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][113] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][114] = "Ihre Majest�t hat ein Kopfgeld auf acht Menschen ausgesetzt. Wenn ihr euch zw�lf Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][115] = "Ihre Majest�t hat ein Kopfgeld auf acht Menschen ausgesetzt. Wenn ihr euch zw�lf Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][116] = "Ihre Majest�t hat ein Kopfgeld auf acht Menschen ausgesetzt. Wenn ihr euch zw�lf Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][117] = "Ihre Majest�t hat ein Kopfgeld auf acht Menschen ausgesetzt. Wenn ihr euch zw�lf Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][118] = "Ihre Majest�t hat ein Kopfgeld auf acht Menschen ausgesetzt. Wenn ihr euch zw�lf Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][119] = "Ihre Majest�t hat ein Kopfgeld auf acht Menschen ausgesetzt. Wenn ihr euch zw�lf Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][120] = "Ihre Majest�t hat ein Kopfgeld auf acht Menschen ausgesetzt. Wenn ihr euch zw�lf Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][121] = "Ihre Majest�t hat ein Kopfgeld auf acht Menschen ausgesetzt. Wenn ihr euch zw�lf Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][122] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][123] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Menschen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, achtzehn Silberst�cke werden eure Belohnung sein."
Description[GERMAN][124] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Menschen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, achtzehn Silberst�cke werden eure Belohnung sein."
Description[GERMAN][125] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Menschen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, achtzehn Silberst�cke werden eure Belohnung sein."
Description[GERMAN][126] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Menschen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, achtzehn Silberst�cke werden eure Belohnung sein."
Description[GERMAN][127] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Menschen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, achtzehn Silberst�cke werden eure Belohnung sein."
Description[GERMAN][128] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Menschen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, achtzehn Silberst�cke werden eure Belohnung sein."
Description[GERMAN][129] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Menschen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, achtzehn Silberst�cke werden eure Belohnung sein."
Description[GERMAN][130] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Menschen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, achtzehn Silberst�cke werden eure Belohnung sein."
Description[GERMAN][131] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Menschen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, achtzehn Silberst�cke werden eure Belohnung sein."
Description[GERMAN][132] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Menschen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, achtzehn Silberst�cke werden eure Belohnung sein."
Description[GERMAN][133] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Menschen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, achtzehn Silberst�cke werden eure Belohnung sein."
Description[GERMAN][134] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Menschen ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, achtzehn Silberst�cke werden eure Belohnung sein."
Description[GERMAN][135] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][136] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von acht Silberst�cken an denjenigen auszuzahlen, der vier Orks erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][137] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von acht Silberst�cken an denjenigen auszuzahlen, der vier Orks erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][138] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von acht Silberst�cken an denjenigen auszuzahlen, der vier Orks erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][139] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von acht Silberst�cken an denjenigen auszuzahlen, der vier Orks erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][140] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][141] = "Ihre Majest�t hat ein Kopfgeld auf acht Orks ausgesetzt. Wenn ihr euch sechzehn Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][142] = "Ihre Majest�t hat ein Kopfgeld auf acht Orks ausgesetzt. Wenn ihr euch sechzehn Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][143] = "Ihre Majest�t hat ein Kopfgeld auf acht Orks ausgesetzt. Wenn ihr euch sechzehn Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][144] = "Ihre Majest�t hat ein Kopfgeld auf acht Orks ausgesetzt. Wenn ihr euch sechzehn Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][145] = "Ihre Majest�t hat ein Kopfgeld auf acht Orks ausgesetzt. Wenn ihr euch sechzehn Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][146] = "Ihre Majest�t hat ein Kopfgeld auf acht Orks ausgesetzt. Wenn ihr euch sechzehn Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][147] = "Ihre Majest�t hat ein Kopfgeld auf acht Orks ausgesetzt. Wenn ihr euch sechzehn Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][148] = "Ihre Majest�t hat ein Kopfgeld auf acht Orks ausgesetzt. Wenn ihr euch sechzehn Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][149] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][150] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Orks ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, vierundzwanzig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][151] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Orks ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, vierundzwanzig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][152] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Orks ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, vierundzwanzig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][153] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Orks ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, vierundzwanzig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][154] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Orks ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, vierundzwanzig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][155] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Orks ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, vierundzwanzig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][156] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Orks ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, vierundzwanzig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][157] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Orks ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, vierundzwanzig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][158] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Orks ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, vierundzwanzig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][159] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Orks ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, vierundzwanzig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][160] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Orks ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, vierundzwanzig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][161] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Orks ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, vierundzwanzig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][162] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][163] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von zehn Silberst�cken an denjenigen auszuzahlen, der vier Golems erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][164] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von zehn Silberst�cken an denjenigen auszuzahlen, der vier Golems erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][165] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von zehn Silberst�cken an denjenigen auszuzahlen, der vier Golems erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][166] = "Zeit f�r eine Kopfgeldjagd! Ihre Majest�t hat mich erm�chtigt, ein Kopfgeld von zehn Silberst�cken an denjenigen auszuzahlen, der vier Golems erschl�gt. Geht in die Kantabiw�ste und macht sie zu einem besseren Ort."
Description[GERMAN][167] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][168] = "Ihre Majest�t hat ein Kopfgeld auf acht Golems ausgesetzt. Wenn ihr euch zwanzig Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][169] = "Ihre Majest�t hat ein Kopfgeld auf acht Golems ausgesetzt. Wenn ihr euch zwanzig Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][170] = "Ihre Majest�t hat ein Kopfgeld auf acht Golems ausgesetzt. Wenn ihr euch zwanzig Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][171] = "Ihre Majest�t hat ein Kopfgeld auf acht Golems ausgesetzt. Wenn ihr euch zwanzig Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][172] = "Ihre Majest�t hat ein Kopfgeld auf acht Golems ausgesetzt. Wenn ihr euch zwanzig Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][173] = "Ihre Majest�t hat ein Kopfgeld auf acht Golems ausgesetzt. Wenn ihr euch zwanzig Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][174] = "Ihre Majest�t hat ein Kopfgeld auf acht Golems ausgesetzt. Wenn ihr euch zwanzig Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][175] = "Ihre Majest�t hat ein Kopfgeld auf acht Golems ausgesetzt. Wenn ihr euch zwanzig Silberst�cke verdienen m�chtet, beendet ihr Leben in der Kantabiw�ste. Tot oder nicht lebendig!"
Description[GERMAN][176] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."
Description[GERMAN][177] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Golems ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei�ig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][178] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Golems ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei�ig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][179] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Golems ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei�ig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][180] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Golems ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei�ig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][181] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Golems ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei�ig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][182] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Golems ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei�ig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][183] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Golems ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei�ig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][184] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Golems ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei�ig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][185] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Golems ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei�ig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][186] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Golems ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei�ig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][187] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Golems ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei�ig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][188] = "Die Kantabiw�ste ist zu einem gef�hrlichen Ort geworden. Ein Kopfgeld ist auf zw�lf Golems ausgesetzt, um die W�ste wieder friedvoller zu machen. Geht nun und erledigt sie, drei�ig Silberst�cke werden eure Belohnung sein."
Description[GERMAN][189] = "Kehre zu Palis Nestros zur�ck, um deine Belohnung zu erhalten."

Description[ENGLISH][1] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of one silver coin for the heads of four beetles. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][2] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of one silver coin for the heads of four beetles. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][3] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of one silver coin for the heads of four beetles. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][4] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of one silver coin for the heads of four beetles. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][5] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][6] = "Her Majesty put a bounty on the heads of eight beetles. If you want to earn two silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][7] = "Her Majesty put a bounty on the heads of eight beetles. If you want to earn two silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][8] = "Her Majesty put a bounty on the heads of eight beetles. If you want to earn two silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][9] = "Her Majesty put a bounty on the heads of eight beetles. If you want to earn two silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][10] = "Her Majesty put a bounty on the heads of eight beetles. If you want to earn two silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][11] = "Her Majesty put a bounty on the heads of eight beetles. If you want to earn two silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][12] = "Her Majesty put a bounty on the heads of eight beetles. If you want to earn two silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][13] = "Her Majesty put a bounty on the heads of eight beetles. If you want to earn two silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][14] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][15] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve beetles to make the desert peaceful again. Set out and kill them, three silver coins will be your reward."
Description[ENGLISH][16] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve beetles to make the desert peaceful again. Set out and kill them, three silver coins will be your reward."
Description[ENGLISH][17] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve beetles to make the desert peaceful again. Set out and kill them, three silver coins will be your reward."
Description[ENGLISH][18] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve beetles to make the desert peaceful again. Set out and kill them, three silver coins will be your reward."
Description[ENGLISH][19] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve beetles to make the desert peaceful again. Set out and kill them, three silver coins will be your reward."
Description[ENGLISH][20] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve beetles to make the desert peaceful again. Set out and kill them, three silver coins will be your reward."
Description[ENGLISH][21] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve beetles to make the desert peaceful again. Set out and kill them, three silver coins will be your reward."
Description[ENGLISH][22] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve beetles to make the desert peaceful again. Set out and kill them, three silver coins will be your reward."
Description[ENGLISH][23] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve beetles to make the desert peaceful again. Set out and kill them, three silver coins will be your reward."
Description[ENGLISH][24] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve beetles to make the desert peaceful again. Set out and kill them, three silver coins will be your reward."
Description[ENGLISH][25] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve beetles to make the desert peaceful again. Set out and kill them, three silver coins will be your reward."
Description[ENGLISH][26] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve beetles to make the desert peaceful again. Set out and kill them, three silver coins will be your reward."
Description[ENGLISH][27] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][28] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of two silver coins for the heads of four wasps. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][29] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of two silver coins for the heads of four wasps. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][30] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of two silver coins for the heads of four wasps. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][31] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of two silver coins for the heads of four wasps. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][32] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][33] = "Her Majesty put a bounty on the heads of eight wasps. If you want to earn four silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][34] = "Her Majesty put a bounty on the heads of eight wasps. If you want to earn four silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][35] = "Her Majesty put a bounty on the heads of eight wasps. If you want to earn four silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][36] = "Her Majesty put a bounty on the heads of eight wasps. If you want to earn four silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][37] = "Her Majesty put a bounty on the heads of eight wasps. If you want to earn four silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][38] = "Her Majesty put a bounty on the heads of eight wasps. If you want to earn four silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][39] = "Her Majesty put a bounty on the heads of eight wasps. If you want to earn four silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][40] = "Her Majesty put a bounty on the heads of eight wasps. If you want to earn four silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][41] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][42] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve wasps to make the desert peaceful again. Set out and kill them, six silver coins will be your reward."
Description[ENGLISH][43] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve wasps to make the desert peaceful again. Set out and kill them, six silver coins will be your reward."
Description[ENGLISH][44] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve wasps to make the desert peaceful again. Set out and kill them, six silver coins will be your reward."
Description[ENGLISH][45] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve wasps to make the desert peaceful again. Set out and kill them, six silver coins will be your reward."
Description[ENGLISH][46] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve wasps to make the desert peaceful again. Set out and kill them, six silver coins will be your reward."
Description[ENGLISH][47] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve wasps to make the desert peaceful again. Set out and kill them, six silver coins will be your reward."
Description[ENGLISH][48] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve wasps to make the desert peaceful again. Set out and kill them, six silver coins will be your reward."
Description[ENGLISH][49] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve wasps to make the desert peaceful again. Set out and kill them, six silver coins will be your reward."
Description[ENGLISH][50] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve wasps to make the desert peaceful again. Set out and kill them, six silver coins will be your reward."
Description[ENGLISH][51] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve wasps to make the desert peaceful again. Set out and kill them, six silver coins will be your reward."
Description[ENGLISH][52] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve wasps to make the desert peaceful again. Set out and kill them, six silver coins will be your reward."
Description[ENGLISH][53] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve wasps to make the desert peaceful again. Set out and kill them, six silver coins will be your reward."
Description[ENGLISH][54] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][55] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of three silver coins for the heads of four dogs. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][56] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of three silver coins for the heads of four dogs. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][57] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of three silver coins for the heads of four dogs. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][58] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of three silver coins for the heads of four dogs. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][59] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][60] = "Her Majesty put a bounty on the heads of eight dogs. If you want to earn six silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][61] = "Her Majesty put a bounty on the heads of eight dogs. If you want to earn six silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][62] = "Her Majesty put a bounty on the heads of eight dogs. If you want to earn six silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][63] = "Her Majesty put a bounty on the heads of eight dogs. If you want to earn six silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][64] = "Her Majesty put a bounty on the heads of eight dogs. If you want to earn six silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][65] = "Her Majesty put a bounty on the heads of eight dogs. If you want to earn six silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][66] = "Her Majesty put a bounty on the heads of eight dogs. If you want to earn six silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][67] = "Her Majesty put a bounty on the heads of eight dogs. If you want to earn six silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][68] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][69] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve dogs to make the desert peaceful again. Set out and kill them, nine silver coins will be your reward."
Description[ENGLISH][70] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve dogs to make the desert peaceful again. Set out and kill them, nine silver coins will be your reward."
Description[ENGLISH][71] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve dogs to make the desert peaceful again. Set out and kill them, nine silver coins will be your reward."
Description[ENGLISH][72] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve dogs to make the desert peaceful again. Set out and kill them, nine silver coins will be your reward."
Description[ENGLISH][73] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve dogs to make the desert peaceful again. Set out and kill them, nine silver coins will be your reward."
Description[ENGLISH][74] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve dogs to make the desert peaceful again. Set out and kill them, nine silver coins will be your reward."
Description[ENGLISH][75] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve dogs to make the desert peaceful again. Set out and kill them, nine silver coins will be your reward."
Description[ENGLISH][76] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve dogs to make the desert peaceful again. Set out and kill them, nine silver coins will be your reward."
Description[ENGLISH][77] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve dogs to make the desert peaceful again. Set out and kill them, nine silver coins will be your reward."
Description[ENGLISH][78] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve dogs to make the desert peaceful again. Set out and kill them, nine silver coins will be your reward."
Description[ENGLISH][79] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve dogs to make the desert peaceful again. Set out and kill them, nine silver coins will be your reward."
Description[ENGLISH][80] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve dogs to make the desert peaceful again. Set out and kill them, nine silver coins will be your reward."
Description[ENGLISH][81] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][82] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of four silver coins for the heads of four foxes. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][83] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of four silver coins for the heads of four foxes. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][84] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of four silver coins for the heads of four foxes. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][85] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of four silver coins for the heads of four foxes. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][86] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][87] = "Her Majesty put a bounty on the heads of eight foxes. If you want to earn eight silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][88] = "Her Majesty put a bounty on the heads of eight foxes. If you want to earn eight silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][89] = "Her Majesty put a bounty on the heads of eight foxes. If you want to earn eight silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][90] = "Her Majesty put a bounty on the heads of eight foxes. If you want to earn eight silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][91] = "Her Majesty put a bounty on the heads of eight foxes. If you want to earn eight silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][92] = "Her Majesty put a bounty on the heads of eight foxes. If you want to earn eight silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][93] = "Her Majesty put a bounty on the heads of eight foxes. If you want to earn eight silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][94] = "Her Majesty put a bounty on the heads of eight foxes. If you want to earn eight silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][95] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][96] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve foxes to make the desert peaceful again. Set out and kill them, twelve silver coins will be your reward."
Description[ENGLISH][97] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve foxes to make the desert peaceful again. Set out and kill them, twelve silver coins will be your reward."
Description[ENGLISH][98] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve foxes to make the desert peaceful again. Set out and kill them, twelve silver coins will be your reward."
Description[ENGLISH][99] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve foxes to make the desert peaceful again. Set out and kill them, twelve silver coins will be your reward."
Description[ENGLISH][100] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve foxes to make the desert peaceful again. Set out and kill them, twelve silver coins will be your reward."
Description[ENGLISH][101] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve foxes to make the desert peaceful again. Set out and kill them, twelve silver coins will be your reward."
Description[ENGLISH][102] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve foxes to make the desert peaceful again. Set out and kill them, twelve silver coins will be your reward."
Description[ENGLISH][103] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve foxes to make the desert peaceful again. Set out and kill them, twelve silver coins will be your reward."
Description[ENGLISH][104] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve foxes to make the desert peaceful again. Set out and kill them, twelve silver coins will be your reward."
Description[ENGLISH][105] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve foxes to make the desert peaceful again. Set out and kill them, twelve silver coins will be your reward."
Description[ENGLISH][106] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve foxes to make the desert peaceful again. Set out and kill them, twelve silver coins will be your reward."
Description[ENGLISH][107] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve foxes to make the desert peaceful again. Set out and kill them, twelve silver coins will be your reward."
Description[ENGLISH][108] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][109] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of six silver coins for the heads of four humans. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][110] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of six silver coins for the heads of four humans. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][111] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of six silver coins for the heads of four humans. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][112] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of six silver coins for the heads of four humans. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][113] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][114] = "Her Majesty put a bounty on the heads of eight humans. If you want to earn twelve silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][115] = "Her Majesty put a bounty on the heads of eight humans. If you want to earn twelve silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][116] = "Her Majesty put a bounty on the heads of eight humans. If you want to earn twelve silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][117] = "Her Majesty put a bounty on the heads of eight humans. If you want to earn twelve silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][118] = "Her Majesty put a bounty on the heads of eight humans. If you want to earn twelve silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][119] = "Her Majesty put a bounty on the heads of eight humans. If you want to earn twelve silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][120] = "Her Majesty put a bounty on the heads of eight humans. If you want to earn twelve silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][121] = "Her Majesty put a bounty on the heads of eight humans. If you want to earn twelve silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][122] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][123] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve humans to make the desert peaceful again. Set out and kill them, eighteen silver coins will be your reward."
Description[ENGLISH][124] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve humans to make the desert peaceful again. Set out and kill them, eighteen silver coins will be your reward."
Description[ENGLISH][125] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve humans to make the desert peaceful again. Set out and kill them, eighteen silver coins will be your reward."
Description[ENGLISH][126] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve humans to make the desert peaceful again. Set out and kill them, eighteen silver coins will be your reward."
Description[ENGLISH][127] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve humans to make the desert peaceful again. Set out and kill them, eighteen silver coins will be your reward."
Description[ENGLISH][128] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve humans to make the desert peaceful again. Set out and kill them, eighteen silver coins will be your reward."
Description[ENGLISH][129] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve humans to make the desert peaceful again. Set out and kill them, eighteen silver coins will be your reward."
Description[ENGLISH][130] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve humans to make the desert peaceful again. Set out and kill them, eighteen silver coins will be your reward."
Description[ENGLISH][131] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve humans to make the desert peaceful again. Set out and kill them, eighteen silver coins will be your reward."
Description[ENGLISH][132] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve humans to make the desert peaceful again. Set out and kill them, eighteen silver coins will be your reward."
Description[ENGLISH][133] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve humans to make the desert peaceful again. Set out and kill them, eighteen silver coins will be your reward."
Description[ENGLISH][134] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve humans to make the desert peaceful again. Set out and kill them, eighteen silver coins will be your reward."
Description[ENGLISH][135] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][136] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of eight silver coins for the heads of four orcs. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][137] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of eight silver coins for the heads of four orcs. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][138] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of eight silver coins for the heads of four orcs. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][139] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of eight silver coins for the heads of four orcs. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][140] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][141] = "Her Majesty put a bounty on the heads of eight orcs. If you want to earn sixteen silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][142] = "Her Majesty put a bounty on the heads of eight orcs. If you want to earn sixteen silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][143] = "Her Majesty put a bounty on the heads of eight orcs. If you want to earn sixteen silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][144] = "Her Majesty put a bounty on the heads of eight orcs. If you want to earn sixteen silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][145] = "Her Majesty put a bounty on the heads of eight orcs. If you want to earn sixteen silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][146] = "Her Majesty put a bounty on the heads of eight orcs. If you want to earn sixteen silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][147] = "Her Majesty put a bounty on the heads of eight orcs. If you want to earn sixteen silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][148] = "Her Majesty put a bounty on the heads of eight orcs. If you want to earn sixteen silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][149] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][150] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve orcs to make the desert peaceful again. Set out and kill them, twenty four silver coins will be your reward."
Description[ENGLISH][151] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve orcs to make the desert peaceful again. Set out and kill them, twenty four silver coins will be your reward."
Description[ENGLISH][152] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve orcs to make the desert peaceful again. Set out and kill them, twenty four silver coins will be your reward."
Description[ENGLISH][153] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve orcs to make the desert peaceful again. Set out and kill them, twenty four silver coins will be your reward."
Description[ENGLISH][154] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve orcs to make the desert peaceful again. Set out and kill them, twenty four silver coins will be your reward."
Description[ENGLISH][155] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve orcs to make the desert peaceful again. Set out and kill them, twenty four silver coins will be your reward."
Description[ENGLISH][156] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve orcs to make the desert peaceful again. Set out and kill them, twenty four silver coins will be your reward."
Description[ENGLISH][157] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve orcs to make the desert peaceful again. Set out and kill them, twenty four silver coins will be your reward."
Description[ENGLISH][158] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve orcs to make the desert peaceful again. Set out and kill them, twenty four silver coins will be your reward."
Description[ENGLISH][159] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve orcs to make the desert peaceful again. Set out and kill them, twenty four silver coins will be your reward."
Description[ENGLISH][160] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve orcs to make the desert peaceful again. Set out and kill them, twenty four silver coins will be your reward."
Description[ENGLISH][161] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve orcs to make the desert peaceful again. Set out and kill them, twenty four silver coins will be your reward."
Description[ENGLISH][162] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][163] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of ten silver coins for the heads of four golems. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][164] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of ten silver coins for the heads of four golems. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][165] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of ten silver coins for the heads of four golems. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][166] = "Time for a bounty hunt! Her Majesty has authorised me to pay a bounty of ten silver coins for the heads of four golems. Set out to the Kantabi desert and make it a better place."
Description[ENGLISH][167] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][168] = "Her Majesty put a bounty on the heads of eight golems. If you want to earn twenty silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][169] = "Her Majesty put a bounty on the heads of eight golems. If you want to earn twenty silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][170] = "Her Majesty put a bounty on the heads of eight golems. If you want to earn twenty silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][171] = "Her Majesty put a bounty on the heads of eight golems. If you want to earn twenty silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][172] = "Her Majesty put a bounty on the heads of eight golems. If you want to earn twenty silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][173] = "Her Majesty put a bounty on the heads of eight golems. If you want to earn twenty silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][174] = "Her Majesty put a bounty on the heads of eight golems. If you want to earn twenty silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][175] = "Her Majesty put a bounty on the heads of eight golems. If you want to earn twenty silver coins, end their life in the Kantabi desert. Dead or not alive!"
Description[ENGLISH][176] = "Return to Palis Nestros to claim your reward."
Description[ENGLISH][177] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve golems to make the desert peaceful again. Set out and kill them, thirty silver coins will be your reward."
Description[ENGLISH][178] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve golems to make the desert peaceful again. Set out and kill them, thirty silver coins will be your reward."
Description[ENGLISH][179] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve golems to make the desert peaceful again. Set out and kill them, thirty silver coins will be your reward."
Description[ENGLISH][180] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve golems to make the desert peaceful again. Set out and kill them, thirty silver coins will be your reward."
Description[ENGLISH][181] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve golems to make the desert peaceful again. Set out and kill them, thirty silver coins will be your reward."
Description[ENGLISH][182] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve golems to make the desert peaceful again. Set out and kill them, thirty silver coins will be your reward."
Description[ENGLISH][183] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve golems to make the desert peaceful again. Set out and kill them, thirty silver coins will be your reward."
Description[ENGLISH][184] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve golems to make the desert peaceful again. Set out and kill them, thirty silver coins will be your reward."
Description[ENGLISH][185] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve golems to make the desert peaceful again. Set out and kill them, thirty silver coins will be your reward."
Description[ENGLISH][186] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve golems to make the desert peaceful again. Set out and kill them, thirty silver coins will be your reward."
Description[ENGLISH][187] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve golems to make the desert peaceful again. Set out and kill them, thirty silver coins will be your reward."
Description[ENGLISH][188] = "The Kantabi desert has become a dangerous place. There is a bounty put on twelve golems to make the desert peaceful again. Set out and kill them, thirty silver coins will be your reward."
Description[ENGLISH][189] = "Return to Palis Nestros to claim your reward."

local npcLocation = position(115, 549, 0)

-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {npcLocation.x, npcLocation.y, npcLocation.z}

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
for i = 1, 189 do
    QuestTarget[i] = {npcLocation} -- Palis
end

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 0

-- Register the monster kill parts of the quest.
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 1, to = 5},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "K�fer", english = "beetles"},
    npcName = "Palis Nestros",
    raceIds = {59} -- all beetles
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 6, to = 14},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "K�fer", english = "beetles"},
    npcName = "Palis Nestros",
    raceIds = {59} -- all beetles
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 15, to = 27},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "K�fer", english = "beetles"},
    npcName = "Palis Nestros",
    raceIds = {59} -- all beetles
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 28, to = 32},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Wespen", english = "wasps"},
    npcName = "Palis Nestros",
    raceIds = {27} -- all wasps
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 33, to = 41},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Wespen", english = "wasps"},
    npcName = "Palis Nestros",
    raceIds = {27} -- all wasps
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 42, to = 54},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Wespen", english = "wasps"},
    npcName = "Palis Nestros",
    raceIds = {27} -- all wasps
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 55, to = 59},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Hunde", english = "dogs"},
    npcName = "Palis Nestros",
    raceIds = {58} -- all dogs
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 60, to = 68},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Hunde", english = "dogs"},
    npcName = "Palis Nestros",
    raceIds = {58} -- all dogs
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 69, to = 81},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Hunde", english = "dogs"},
    npcName = "Palis Nestros",
    raceIds = {58} -- all dogs
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 82, to = 86},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "F�chse", english = "foxes"},
    npcName = "Palis Nestros",
    raceIds = {60} -- all foxes
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 87, to = 95},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "F�chse", english = "foxes"},
    npcName = "Palis Nestros",
    raceIds = {60} -- all foxes
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 96, to = 108},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "F�chse", english = "foxes"},
    npcName = "Palis Nestros",
    raceIds = {60} -- all foxes
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 109, to = 113},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Menschen", english = "humans"},
    npcName = "Palis Nestros",
    raceIds = {0} -- all humans
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 114, to = 122},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Menschen", english = "humans"},
    npcName = "Palis Nestros",
    raceIds = {0} -- all humans
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 123, to = 135},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Menschen", english = "humans"},
    npcName = "Palis Nestros",
    raceIds = {0} -- all humans
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 136, to = 140},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Orks", english = "orcs"},
    npcName = "Palis Nestros",
    raceIds = {4} -- all orcs
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 141, to = 149},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Orks", english = "orcs"},
    npcName = "Palis Nestros",
    raceIds = {4} -- all orcs
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 150, to = 162},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Orks", english = "orcs"},
    npcName = "Palis Nestros",
    raceIds = {4} -- all orcs
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 163, to = 167},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Golems", english = "golems"},
    npcName = "Palis Nestros",
    raceIds = {30, 56} -- all golems and mech golems
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 168, to = 176},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Golems", english = "golems"},
    npcName = "Palis Nestros",
    raceIds = {30, 56} -- all golems and mech golems
}
monsterQuests.addQuest{
    questId = 162,
    location = {position = position(250, 650, 0), radius = 250},
    queststatus = {from = 177, to = 189},
    questTitle = {german = Title[GERMAN], english = Title[ENGLISH]},
    monsterName = {german = "Golems", english = "golems"},
    npcName = "Palis Nestros",
    raceIds = {30, 56} -- all golems and mech golems
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
