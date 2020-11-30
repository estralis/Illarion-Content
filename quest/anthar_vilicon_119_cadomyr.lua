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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (119, 'quest.anthar_vilicon_119_cadomyr');

local common = require("base.common")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Jeden Tag eine gute Tat f�r Cadomyr"
Title[ENGLISH] = "Do a good turn daily for Cadomyr"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Eure heutige Mission: Die K�nigin verlang nach s��en Fr�chten und ich werde sie nicht entt�uschen. Bringt mir f�nf Erdbeeren und ich werde euren Namen ihr gegen�ber lobend erw�hnen."
Description[ENGLISH][1] = "Your mission today: The Queen desires sweet fruit and I will not disappoint her. Bring me five strawberries as fast as possible and I'll mention your name in front of her."

Description[GERMAN][2] = "Cadomyrs Wirtschaft ist auf Sand gebaut. Sehr witzig, ich wei� - aber wenn ihr einen Blick in die Schatzkammer werfen d�rftet, w�rde euch das Lachen vergehen. Einer Lieferung Quartzsand ins Ausland fehlen noch zwanzig Haufen. Beschafft sie bitte m�glichst bald."
Description[ENGLISH][2] = "Cadomyr's economy is based on sand. Very funny, I know - but take a look at the treasury and you won't laugh anymore. A shipment of quartz sand abroad lacks twenty piles. Please provide them sometime soon."

Description[GERMAN][3] = "Ich habe eine besondere Aufgabe f�r euch. K�nigin Rosaline m�chte ein Diadem als Geschenk an ihre Gro�tante in Albar senden. F�r dieses Diadem werden noch drei geschliffene Rubine ben�tigt. Ihr werdet derjenige sein, der sie besorgt!"
Description[ENGLISH][3] = "I have a special assignement for you. Queen Rosaline wants to send a diadem to her grand aunt in Albar as present. For that diadem, three cut rubies are needed. You are the one who will get them!"

Description[GERMAN][4] = "Als Verwalter des Palastes muss ich mich sogar um L�cher in der Decke k�mmern, habt ihr jenes gesehen? Die Artisanen brauchen zehn Kirschholzbretter, um es auszubessern. Bitte besorgt diese und der Dank der K�nigin ist euch gewiss."
Description[ENGLISH][4] = "As administrator of the palace, I even have to take care of leaks in the ceiling. Did you see that hole? To fix it, the artisans need ten cherry wood boards. Please provide them and the Queen will be grateful."

Description[GERMAN][5] = "Eine neue Zofe steht seit kurzem im Dienste ihrer Majest�t. Um sie geb�hrend einzukleiden wird ein wei�es Wappenkleid ben�tigt. Los, lauft zu einem Schneider und besorgt eines."
Description[ENGLISH][5] = "A new maidservant recently started working for her Majesty. To dress her properly, a white heraldic dress is needed. Quick, run to one of the tailors and obtain one."

Description[GERMAN][6] = "Die heutige Mission ist etwas wichtiger: Die Stadtmauer Cadomyrs muss st�ndig in Schuss gehalten werden. In der S�dmauer ist ein kleiner Schaden, nichts schlimmes, aber dennoch werden zwanzig Ziegelsteine ben�tigt, um sie auszubessern."
Description[ENGLISH][6] = "Today's mission is a little more important: The town wall of Cadomyr is in need of constant repair. There is a small amount of damage to the southern wall, nothing serious, but still, twenty bricks are needed to fix it."

Description[GERMAN][7] = "Ihr da! Ich habe gerade die Waffenkammer �berpr�ft und festgestellt, dass ein Langschwert fehlt. Bitte untersucht diesen Diebstahl - entweder, ihr bringt mir den Kopf des Diebes oder ein neues Langschwert als Ersatz."
Description[ENGLISH][7] = "You! I just checked the armoury and found a long sword missing! Please investigate this theft - either, bring me the head of the thief or a newly crafted long sword as replacement."

Description[GERMAN][8] = "Wi�t ihr, was einen Palast erst so richtig prunkvoll macht? Dekoration. Die K�nigin liebt Firnisbl�ten �ber alles und sie mag sie in Massen. Bringt bitte f�nfzehn Bl�ten, so dass ich ihre Kammer ausschm�cken kann."
Description[ENGLISH][8] = "You know what makes a glorious palace? Decoration. The Queen likes firnis blossoms and she likes many of them. Bring me fifteen of them so I can decorate her chamber."

Description[GERMAN][9] = "Die Kavallerie der Ritter Cadomyrs wurde schon immer von unseren Feinden gef�rchtet. Heute lernt ihr, dass zu einer Kavallerie mehr geh�rt als Lanzen; die Pferde m�ssen jeden Tag gef�ttert werden. Eure Aufgabe ist es, zehn Karotten f�r das k�nigliche Gest�t herzubringen."
Description[ENGLISH][9] = "The cavalary of Cadomyr's knights has always been feared by our enemies. Today, you'll learn that a cavalary needs more than a lance; the horses need to be fed every day. It is your job to bring ten carrots for the royal horses."

Description[GERMAN][10] = "Verwaltung kann manchmal ganz sch�n anstrengend sein. Manchmal arbeite ich bis tief in die Nacht. Daf�r brauche ich immer eine Menge Kerzen. Bringt mir doch bitte eine Kerzenziehform."
Description[ENGLISH][10] = "Administration can be quite exhausting. Sometimes, I even work during the night. For that, I need a constant supply of candles. Please bring me a candle mould."

Description[GERMAN][11] = "Ah, ein ergebender Diener ihrer Majest�t, sehr gut. Ich plane ein Bankett zu Ehren der k�niglichen Familie. Es wird eine schmackhafte Spargelcremesuppe gereicht werden, aber es mangelt an Suppensch�sseln. Bitte besorgt zwanzig Sch�sseln feinster Machart und bringt sie zu mir."
Description[ENGLISH][11] = "Ah, a loyal servant of her Majesty, very good. I plan a banquet to honour the royal family. We'll serve a delicious asparagus cream soup, but soup bowls aren't available in sufficient amounts. Please obtain twenty soup bowls of highest quality and bring them to me."

Description[GERMAN][12] = "Ein Notfall ist eingetreten, das K�nigreich ist in ernsthafter Gefahr. K�nigin Rosaline hat ihren Spiegel zerbrochen - ihr wisst, wie aufbrausend sie sein kann und wie viel Wert sie auf ihre Sch�nheit legt. Um �berst�rztheiten ihrerseits zuvorzukommen, besorgt sofort einen neuen Spiegel. Gehorcht!"
Description[ENGLISH][12] = "An emergency has occured, the kingdom is seriously endangered. Queen Rosaline broke her mirror - you know how irascible she is and what beauty means to her. To prevent possible misjudgements by her, get a new mirror at once. Obey!"

Description[GERMAN][13] = "Ich habe einen wichtigen Auftrag: K�nigin Rosaline empf�ngt demn�chste eine Delegation aus Siebenbergen, ein Zwergenreich. Sie m�chte diese b�rtigen Wichte mit einem besonderen Geschenk beeindrucken: Ein Kamm f�r ihre zotteligen B�rte. Es ist an euch, einen geeigneten Kamm auszusuchen und mir zu bringen."
Description[ENGLISH][13] = "I have an important order: Queen Rosaline will welcome a delegation from Sevenhill, a dwarven kingdom. She wants to impress those bearded wretches with a special present: A comb for their shaggy beards. It is your duty to select a proper comb and bring it to me."

Description[GERMAN][14] = "Ich bin auch f�r die Waffenkammer Cadomyrs verantwortlich. Neulich trat Horatio Milenus, eine der Stadtwachen, an mich heran und bat um die Anschaffung eines Langbogens um das Getier der W�ste fernzuhalten. Ich befehle nun euch, einen Langbogen zu beschaffen."
Description[ENGLISH][14] = "I am responsible for the armoury of Cadomyr. Recently, Horatio Milenus, one of the town guards, approached me and suggested the purchase of a long bow to repel the beasts of the desert. Now I command you to provide a long bow."

Description[GERMAN][15] = "Neulich erdreiste sich eine Banditenbande, Rekruten Cadomyrs aufzulauern. Ich brauche nicht betonen, dass die Banditen mit unz�hligen Armbrustbolzen niedergestreckt wurden. Besorgt bitte Nachschub an einhundert Bolzen."
Description[ENGLISH][15] = "Recently, a bunch of bandits dared to ambush a host of recruits of Cadomyr. Needless to say the bandits perished. During the skirmish, many crossbow bolts were shot into their chests. Please bring me a supply of a hundred bolts to replace them."

Description[GERMAN][16] = "Die K�nigin hat befohlen, dass sie ein Festessen mit ihren Adligen abhalten wird. Ich koordiniere die Vorbereitungen, f�r den Hauptgang ist ein Wildgericht vorgesehen. Euer Befehl: Besorgt f�nf Gerichte oder sp�rt meinen Zorn."
Description[ENGLISH][16] = "The Queen commanded that she'll have a feast with her nobles and I am the one who coordinates the preparations. For the main course, venison dishes are planned. Your order is to obtain five dishes or you'll feel my wrath."

Description[GERMAN][17] = "Neue Befehle der K�nigin: Morgen m�chte sie die W�ste bereisen und sie braucht noch passende Kleidung. Ihr Geschmack ist manchmal etwas ausgefallen. Sie verlangt nach einem rot-wei�em Rock. Besorgt einen und bringt ihn her."
Description[ENGLISH][17] = "New orders from the Queen: Tomorrow, she wants to visit the desert but lacks a proper outfit. Her taste is sometimes... special. She demands a red and white skirt, get it and bring it to me."

Description[GERMAN][18] = "Verwaltung, Verwaltung, Verwaltung... um es kurz zu machen, auch wenn Cadomyr ein W�stenreich ist, kann es verdammt kalt in der Nacht werden. Die Kohlevorr�te sind ersch�pft und K�nigin Rosaline soll doch nicht frieren. Bringt mir bitte f�nfzehn Klumpen Kohle, um sie zu w�rmen."
Description[ENGLISH][18] = "Administration, administration, administration... to cut a long story short, even though Cadomyr is a desert realm, it can be pretty cold at night. The stocks of coal are depleted and I don't want to see the Queen freeze. Get fifteen lumps of coal to warm her."

Description[GERMAN][19] = "Ger�chten zufolge planen Baron Hastings M�nner einen Anschlag. Alle Wachen sind bestens vorbereitet und ausger�stet, es fehlt lediglich ein Helm f�r einen neuen Rekruten. Gehorcht und liefert einen Topfhelm zu meinen H�nden."
Description[ENGLISH][19] = "I got word of planned sabotage by Baron Hastings' men. All our guards are well equipped and prepared, except for a missing helmet for one recruit. Obey and deliver a pot helmet to my hands."

Description[GERMAN][20] = "Heute habe ich keinen Befehl f�r euch sondern eine pers�nliche Bitte. K�nntet ihr mir bitte einen Goldbarren bringen - ich m�chte der K�nigin ein besonderes Geschenk, einen Armreif, schmieden um ihr meine Ergebenheit zu beweisen."
Description[ENGLISH][20] = "Today, I have a personal request rather than an order. Could you please bring me a gold ingot - I want to forge a special gift, a bracelet, for my Queen to prove my loyalty."

-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {117, 528, 0}

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
QuestTarget[1] = {position(117, 528, 0)} 
QuestTarget[2] = {position(117, 528, 0)} 
QuestTarget[3] = {position(117, 528, 0)} 
QuestTarget[4] = {position(117, 528, 0)} 
QuestTarget[5] = {position(117, 528, 0)} 
QuestTarget[6] = {position(117, 528, 0)} 
QuestTarget[7] = {position(117, 528, 0)} 
QuestTarget[8] = {position(117, 528, 0)} 
QuestTarget[9] = {position(117, 528, 0)} 
QuestTarget[10] = {position(117, 528, 0)} 
QuestTarget[11] = {position(117, 528, 0)} 
QuestTarget[12] = {position(117, 528, 0)} 
QuestTarget[13] = {position(117, 528, 0)} 
QuestTarget[14] = {position(117, 528, 0)} 
QuestTarget[15] = {position(117, 528, 0)} 
QuestTarget[16] = {position(117, 528, 0)} 
QuestTarget[17] = {position(117, 528, 0)} 
QuestTarget[18] = {position(117, 528, 0)} 
QuestTarget[19] = {position(117, 528, 0)} 
QuestTarget[20] = {position(117, 528, 0)} 

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
