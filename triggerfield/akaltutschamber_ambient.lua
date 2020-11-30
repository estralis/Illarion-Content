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
-- triggerfields for better atmosphere

--[[ SQL Statements:
INSERT INTO triggerfields VALUES (X,Y,Z,'triggerfield.akaltutschamber_ambient');

]]

local common = require("base.common")
local ambient_base = require("triggerfield.base.ambient")

local M = {}

--[[
position: coordinates
direction: array with directions, 0=North,2=East,4=South,6=West. Set nil for always
german/english: text
hours: array with hours when text shall be shown, in range of 0 to 23. Set to nil for always.
months: array with months when text shall be shown, in range of 1 to 16. Set to nil for always.
chance: Chance that this triggerfield is triggered in percent (integer)

for script:
Akaltuts_chamberList.add( position(x,y,z), {0,1,7}, "german", "english", {0,1,23}, {1,2,16}, chance );

for db:
INSERT INTO triggerfields VALUES (x,y,z,'triggerfield.akaltutschamber_ambient');
]]


local Akaltuts_chamberList = ambient_base()

-- Akaltuts_Chamber_-3 triggers using Ambient.lua as a guide
Akaltuts_chamberList.add( position(444,766,-3 ),nil,"Der Geruch der W�ste wird von einem s��lichen Verwesungsgestank �berlagert.","The smell of desert air starts growing fainter as the smell of decay takes over.",nil,nil,50); --Akaltuts_Chamber_-3
Akaltuts_chamberList.add( position(449,759,-3 ),nil,"In der Ferne ist ein leises Knacken zu h�ren.","A faint crackling can be heard in the distance.",nil,nil,50); --Akaltuts_Chamber_-3

-- Akaltuts_Chamber_-6 triggers using Ambient.lua as a guide
Akaltuts_chamberList.add( position(462,748,-6),nil,"Die Luft um dich herum ist erstickend hei� und erf�llt von dem Knistern der Flammen.","The air around you is stifling hot and filled with the sound of crackling flames.",nil,nil,50); --Akaltuts_Chamber_-6
Akaltuts_chamberList.add( position(459,769,-6),nil,"Gequ�lte Schreie hallen von den Steinen wieder.","Screaming sounds of torment echo off the stones.",nil,nil,50); --Akaltuts_Chamber_-6
Akaltuts_chamberList.add( position(466,777,-6),nil,"Gequ�lte Schreie hallen von den Steinen wieder.","Screaming sounds of torment echo off the stones.",nil,nil,50); --Akaltuts_Chamber_-6
Akaltuts_chamberList.add( position(531,789,-6),nil,"Gequ�lte Schreie hallen von den Steinen wieder.","Screaming sounds of torment echo off the stones.",nil,nil,50); --Akaltuts_Chamber_-6
Akaltuts_chamberList.add( position(536,754,-6),nil,"Gequ�lte Schreie hallen von den Steinen wieder.","Screaming sounds of torment echo off the stones.",nil,nil,50); --Akaltuts_Chamber_-6
Akaltuts_chamberList.add( position(502,786,-6),nil,"Starke Winde zerren aus allen Richtungen an dir und versuchen, dich umzuwerfen.","Strong winds buffet you from every direction attempting to knock you off your feet.",nil,nil,100); --Akaltuts_Chamber_-6
Akaltuts_chamberList.add( position(544,816,-6),nil,"Von unten erklingt wahnsinniges Gel�chter.","Maniacal laughter is heard below.",nil,nil,50); --Akaltuts_Chamber_-6
Akaltuts_chamberList.add( position(545,815,-6),nil,"Von unten erklingt wahnsinniges Gel�chter.","Maniacal laughter is heard below.",nil,nil,50); --Akaltuts_Chamber_-6

-- Akaltuts_Chamber_-9 triggers using Ambient.lua as a guide
Akaltuts_chamberList.add( position(436,855,-9),nil,"Unten kannst du gro�e H�llenhunde sehen, die Fleisch von Knochen rei�en. Gehe vorsichtig weiter!","Down below, you can see large hellhounds, tearing flesh from bones. Proceed with caution!",nil,nil,100); --Akaltuts_Chamber_-9
Akaltuts_chamberList.add( position(435,855,-9),nil,"Unten kannst du gro�e H�llenhunde sehen, die Fleisch von Knochen rei�en. Gehe vorsichtig weiter!","Down below, you can see large hellhounds, tearing flesh from bones. Proceed with caution!",nil,nil,100); --Akaltuts_Chamber_-9
Akaltuts_chamberList.add( position(431,843,-9),nil,"Das wird unser Biest aber traurig machen, dass du nicht abgest�rzt bist. Vielleicht das n�chste mal. Ein b�sartiges Gel�chter ert�nt.","Our beast will be saddened you didn't fall, perhaps next time. You hear an evil laugh.",nil,nil,50); --Akaltuts_Chamber_-9
Akaltuts_chamberList.add( position(431,844,-9),nil,"Das wird unser Biest aber traurig machen, dass du nicht abgest�rzt bist. Vielleicht das n�chste mal. Ein b�sartiges Gel�chter ert�nt.","Our beast will be saddened you didn't fall, perhaps next time. You hear an evil laugh.",nil,nil,50); --Akaltuts_Chamber_-9
Akaltuts_chamberList.add( position(444,844,-9),nil,"Pl�tzlich h�rst du ein so m�chtiges Gebr�ll, dass der Dreck von der Decke auf dich herab regnet.","You suddenly hear a mighty roar that shakes the walls, causing debris to fall from above and rain down on you.",nil,nil,50); --Akaltuts_Chamber_-9
Akaltuts_chamberList.add( position(440,846,-9),nil,"Ein Gebr�ll, wie du es noch nie zuvor geh�rt hast, erschreckt dich fast zu Tode.","You are startled by another loud roar from a beast the likes of which you've never heard before.",nil,nil,50); --Akaltuts_Chamber_-9
Akaltuts_chamberList.add( position(437,844,-9),nil,"Die S�ule neben dir beginnt auf einmal, zu beben und zu knacken, als das Biest erneut br�llt.","The pillar near you suddenly begins to shake and rattle as you go by as the beast roars once again.",nil,nil,50); --Akaltuts_Chamber_-9
Akaltuts_chamberList.add( position(452,849,-9),nil,"Als du den Raum betrittst ist der Gestank so �berw�ltigend, dass du dich fast �bergibst. Du musst all deinen Mut zusammen nehmen, um weiter voranzuschreiten aber niemand w�rde dich feige nennen, wenn du umkehrtest, um den anderen Weg zu nehmen.","When you walk in, you notice a stench to nearly make you double over and retch. It takes everything you have to move forward into the room, but nobody would blame you if you turned and walked the other way.",nil,nil,100); --Akaltuts_Chamber_-9
Akaltuts_chamberList.add( position(427,839,-9),nil,"Die Reiter auf den Pferdestatuen vor dir scheinen Elfen zu sein, doch wirkt es so, als ob sie dunkle Haut und wei�e Haare haben. Ihre Augen sind aus gl�henden roten Edelsteinen gemacht. Unter den Statuen sind mehrere Dunkelelfenkrieger zu sehen, welche in Gruppen Kampftechniken �ben.","Ahead, the riders of the horse statues all look elven, but appear to have dark coloured skin and the hair has been dyed white. They all have piercing eyes made of a red gemstone, which glows throughout the room. Among the statues, you find more drow warriors, training in groups on battle strategies.",nil,nil,50); --Akaltuts_Chamber_-9
Akaltuts_chamberList.add( position(426,839,-9),nil,"Die Reiter auf den Pferdestatuen vor dir scheinen Elfen zu sein, doch wirkt es so, als ob sie dunkle Haut und wei�e Haare haben. Ihre Augen sind aus gl�henden roten Edelsteinen gemacht. Unter den Statuen sind mehrere Dunkelelfenkrieger zu sehen, welche in Gruppen Kampftechniken �ben.","Ahead, the riders of the horse statues all look elven, but appear to have dark coloured skin and the hair has been dyed white. They all have piercing eyes made of a red gemstone, which glows throughout the room. Among the statues, you find more drow warriors, training in groups on battle strategies.",nil,nil,50); --Akaltuts_Chamber_-9
Akaltuts_chamberList.add( position(425,839,-9),nil,"Die Reiter auf den Pferdestatuen vor dir scheinen Elfen zu sein, doch wirkt es so, als ob sie dunkle Haut und wei�e Haare haben. Ihre Augen sind aus gl�henden roten Edelsteinen gemacht. Unter den Statuen sind mehrere Dunkelelfenkrieger zu sehen, welche in Gruppen Kampftechniken �ben.","Ahead, the riders of the horse statues all look elven, but appear to have dark coloured skin and the hair has been dyed white. They all have piercing eyes made of a red gemstone, which glows throughout the room. Among the statues, you find more drow warriors, training in groups on battle strategies.",nil,nil,50); --Akaltuts_Chamber_-9
Akaltuts_chamberList.add( position(477,839,-9),nil,"Als du dich umsiehst, erkennst du Reihen von Sch�deln an der Wand. Die Sch�del an der n�rdlichen Wand haben rot gl�hende Augen, w�hrend die der im Osten gr�nlich gl�hen. M�glicherweise enth�lt die Schriftrolle auf dem Tisch einen Hinweis zu den Sch�deln?","As you look around, you notice the skulls lining the walls. The ones on the northern wall have red glowing eyes while the eastern skulls' eyes glow green. Perhaps the scroll on the table holds the clue to these skulls?",nil,nil,100); --Akaltuts_Chamber_-9
Akaltuts_chamberList.add( position(480,837,-9),nil,"Als du dich umsiehst, erkennst du Reihen von Sch�deln an der Wand. Die Sch�del an der n�rdlichen Wand haben rot gl�hende Augen, w�hrend die der im Osten gr�nlich gl�hen. M�glicherweise enth�lt die Schriftrolle auf dem Tisch einen Hinweis zu den Sch�deln?","As you look around, you notice the skulls lining the walls. The ones on the northern wall have red glowing eyes while the eastern skulls' eyes glow green. Perhaps the scroll on the table holds the clue to these skulls?",nil,nil,100); --Akaltuts_Chamber_-9

function M.MoveToField(Char)
    local this = Akaltuts_chamberList.get(Char)
    if this then
        common.InformNLS(Char, this.german, this.english)
    end
end

return M
