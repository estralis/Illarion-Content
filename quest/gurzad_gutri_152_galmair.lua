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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (152, 'quest.gurzad_gutri_152_galmair');

local common = require("base.common")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Stocke Galmairs Vorr�te auf"
Title[ENGLISH] = "Stock up Galmair's Storage"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Der Don hatte heute Hei�hunger auf Erdbeeren und hat einige aus dem Lager genommen. Wir m�ssen sie ersetzen. Bringt mir f�nf Erdbeeren!"
Description[ENGLISH][1] = "The Don had an appetite and snuck some fruits from the storage! We need to replace them. Bring me five strawberries!"

Description[GERMAN][2] = "Wir haben immer etwas Sand im Lager, falls wir mit Cadomyr verhandeln wollen. Es wurde vor Kurzem etwas Sand verbraucht, also muss er ersetzt werden. Bringt mir 20 Haufen Quarzsand!"
Description[ENGLISH][2] = "We always hold some sand in our storage for bartering deals with Cadomyr. Some of it was used up and we need to replace it. Get twenty piles of quartz sand!"

Description[GERMAN][3] = "Der Don hat sich vor Kurzem drei neue Ringe f�r seine Kollektion machen lassen. Nun m�ssen wir die daf�r verbrauchten Edelsteine wiederbeschaffen. Bringt mir drei geschliffene Rubine!"
Description[ENGLISH][3] = "The Don recently had some new rings made for his personal collection! Now we are short of some gems. I'll be needing ya to get me three cut rubies."

Description[GERMAN][4] = "Ihr kommt grade richtig. Vor Kurzem ist hier eine Schl�gerei ausgebrochen und einige Fenster sind zu Bruch gegangen. Wir mussten einige Glasbarren verwenden, um den Schaden zu beheben und brauchen nun Ersatz. Zehn Glasbarren sollten gen�gen."
Description[ENGLISH][4] = "Oi! You're here just in time, a fight broke out and several windows were shattered. We used up some of our stored glass and now need ten glass ingots to fill the gap."

Description[GERMAN][5] = "Der Don arbeitet an einem Deal mit einigen H�ndlern eines angrenzenden Landes. Sie rauchen gerne, daher haben sie einige Pfeifen aus dem Lager genommen. Sorgt f�r Ersatz und bringt mit f�nf Pfeifen."
Description[ENGLISH][5] = "The Don was working a deal out with some merchants from a neighbouring country. During the deals they broke out some smoking pipes. We'll need five more pipes to replace those the Don used!"

Description[GERMAN][6] = "Wir versuchen unsere Werkstatt auszubauen, aber haben nicht die n�tigen Materialien daf�r. Wir ben�tigen 20 weitere Ziegel f�r die Umbauten."
Description[ENGLISH][6] = "We've been looking to expand our workshop, but the storage is short. We are in need of twenty more bricks for the construction project."

Description[GERMAN][7] = "Eine neue Leibwache des Dons hat sich ein Langschwert aus dem Lager genommen, daf�r brauchen wir nun Ersatz. Bringt mir ein Langschwert!"
Description[ENGLISH][7] = "The Don has recently hired a new bodyguard. He has taken a longsword from the storage in order to arm this new guard. We must replace it! Please bring me one longsword."

Description[GERMAN][8] = "Der Don hat unsere Alchemisten einige Tr�nke brauen lassen. Nun fehlen uns ein paar Kr�uter. Bringt mit 15 Firnisbl�ten."
Description[ENGLISH][8] = "The Don commissioned a number of potions to be made and our alchemists took out a bunch of herbs. We are now short and I need you to get fifteen firnis blossoms for the storage."

Description[GERMAN][9] = "'HEY! Hey du! *hic* Unsere verdammten Kr�ge sind zerbrochen, als wir... *hic* als wir den Don zu einem Trinkwettbewerb herausgefordert haben! Aber das Spiel ist noch nicht aus! Wir... *hic* brauchen neue Kr�ge! Wie viele? Uhm, so viele wie das hier ist!' Er h�lt alle seine Finger hoch."
Description[ENGLISH][9] = "'HEY! Hey you! *hic* Our damn mugs shattered when we.. *hic* challenged the Don to a drinking game. But the game ain't over yet son! We.. *hic* need more mugs! How many? Uh... however this many is! He holds up all of his fingers."

Description[GERMAN][10] = "Eine unserer Kerzenformen ist vor Kurzem bei der Benutzung zu Bruch gegangen. Besorgt mir eine neue Kerzenform!"
Description[ENGLISH][10] = "Recently one of our candle moulds was used and broke as we had an order of candles to fill. The mould that broke was from our storage so we must replace it! Bring me one candle mould."

Description[GERMAN][11] = "Der Don hat ein Gelage f�r einige H�ndler abgehalten und seine Lieblingssuppe servieren lassen, aber keiner der H�ndler hat seine Suppensch�sseln wieder abgegeben! Wir ben�tigen Ersatz. Bringt mir 20 Suppensch�sseln."
Description[ENGLISH][11] = "The Don had a party for some merchants travelling through this land. We served some of our most famous soup but the damn merchants left without returning the bowls! We need to replace them! Bring me twenty soup bowls."

Description[GERMAN][12] = "Der Don hat eine neue R�stung in Auftrag gegeben. Daf�r wurden Materialien aus unserem Lager f�r den Schmied verwendet. Wir haben bereits alles bis auf das Leder ersetzt, da es hier kaum Schweine gibt. Woher ist mir egal, aber besorge zehn getrocknete Lederh�ute."
Description[ENGLISH][12] = "The Don commissioned a new set of armour to be made. For this he took materials from our storage for the smith. We've been able to replace everything except the leather since there are no pigs around. Please venture out and gather us ten pieces of dried leather."

Description[GERMAN][13] = "Der pers�nliche Goldkelch des Dons hat �ber die Jahre an Glanz verloren, daher hat er sich einen neuen aus dem Lager genommen. Ich will, dass Ihr f�r Ersatz sorgt."
Description[ENGLISH][13] = "The Don's personal golden goblet has been tarnished over the years, he's taken a new one from the storage. I'll need ya to go and fetch a new golden goblet for the storage."

Description[GERMAN][14] = "Einer der Leibwachen des Dons hat gestern auf einem Jagdausflug seinen Bogen zerbrochen. Ein neuer Langbogen wurde aus dem Lager genommen, wir m�ssen ihn ersetzen! Bringt mir einen Langbogen."
Description[ENGLISH][14] = "One of the Don's bodyguards was out hunting yesterday and his bow broke. The Don had a longbow taken from the storage, we must replace it! Bring me one longbow."

Description[GERMAN][15] = "Eine unserer Jagdgruppen ist mit viel gutem Fleisch zur�ckgekehrt! Jedoch haben sie dabei eine gr��ere Anzahl an Armbrustbolzen verbraucht. Besorgt mir 100 neue Bolzen."
Description[ENGLISH][15] = "One of our hunting parties went out again and brought back a good stock of meat for us! But they used quite a large amount of crossbow bolts. I need you to get me one hundred crossbow bolts."

Description[GERMAN][16] = "Heute Abend gibt es ein Gelage und das hat unsere Vorr�te sehr belastet. Es kommen so viele G�ste, dass wir nicht genug f�r alle haben! Ich m�chte, dass Ihr mir f�nf fertige Wildgerichte bringt!"
Description[ENGLISH][16] = "We're having a feast tonight and many of our materials were taken from the storage for food. There are so many people that we ran out! I need you to skip the storage part and just bring me five venison dishes for the feast!"

Description[GERMAN][17] = "Unsere Alchemisten arbeiten sehr hart. Sie haben neulich einige Beutel Edelsteinstaub aus dem Lager genommen. Also... m�ssen sie ersetzt werden! Bringt mir f�nf Beutel Saphirstaub!"
Description[ENGLISH][17] = "Our alchemists are hard at work! They've recently taken some of our powders from the storage, therefore.... they must be replaced! Bring me five bags of sapphire powder."

Description[GERMAN][18] = "Einige unserer Schmiede haben sich hier eingeschlichen und etwas Kohle genommen. Ohne Genehmigung h�tte ich sie ihnen nie gegeben! Egal, wir sind nun knapp an Kohle und m�ssen nachbessern. Bringt mit 15 Kohlebrocken."
Description[ENGLISH][18] = "Some of our smiths snuck in and snatched some of our coal. I would've given it to them if they had filled out a requisition order! Nonetheless, we are short and I need you to get me fifteen lumps of coal."

Description[GERMAN][19] = "Der Don hat einen Helm aus dem Lager genommen, um einen der neuen Leibwachen auszur�sten. Er ist der Don, also hatte ich da nichts zu sagen, aber jetzt muss der Helm ersetzt werden! Bringt mir einen neuen Topfhelm."
Description[ENGLISH][19] = "The Don has taken a helmet from our storage to armour one of his new bodyguards. He's the Don so I've no say in the matter, but now we're short! I need you to go and get me one pot helmet."

Description[GERMAN][20] = "Der Don hat einen Ring in Auftrag gegeben und daf�r wurde ein Goldnugget aus dem Lager verwendet. Es ist vielleicht nur ein einziges Nugget, aber es muss dennoch ersetzt werden! Bring mir ein Goldnugget."
Description[ENGLISH][20] = "The Don commissioned a ring to be made and used a gold nugget from the storage. It might only be a single nugget, but it must be replaced! I need you to get me one gold nugget."

-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {369, 236, 0}

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
QuestTarget[1] = {position(369, 236, 0)} 
QuestTarget[2] = {position(369, 236, 0)} 
QuestTarget[3] = {position(369, 236, 0)} 
QuestTarget[4] = {position(369, 236, 0)} 
QuestTarget[5] = {position(369, 236, 0)} 
QuestTarget[6] = {position(369, 236, 0)} 
QuestTarget[7] = {position(369, 236, 0)} 
QuestTarget[8] = {position(369, 236, 0)} 
QuestTarget[9] = {position(369, 236, 0)} 
QuestTarget[10] = {position(369, 236, 0)} 
QuestTarget[11] = {position(369, 236, 0)} 
QuestTarget[12] = {position(369, 236, 0)} 
QuestTarget[13] = {position(369, 236, 0)} 
QuestTarget[14] = {position(369, 236, 0)} 
QuestTarget[15] = {position(369, 236, 0)} 
QuestTarget[16] = {position(369, 236, 0)} 
QuestTarget[17] = {position(369, 236, 0)} 
QuestTarget[18] = {position(369, 236, 0)} 
QuestTarget[19] = {position(369, 236, 0)} 
QuestTarget[20] = {position(369, 236, 0)} 

--QuestTarget[1] = {position(x, y, 100), position(x, y, 100)}

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 0


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
