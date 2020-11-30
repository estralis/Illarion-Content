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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (310, 'quest.aldania_elthewan_310_noobia');

local common = require("base.common")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Einf�hrung - Ausr�sten und Benutzen"
Title[ENGLISH] = "Tutorial - Equipping and using"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "An dieser Station wird dir die Elfe Aldania erkl�re, wie man Gegenst�nde anlegt und sie benutzt. Begr��e sie einfach so, wie du es von Henry Cunnigan gelernt hast! Aktiviere deine Chatbox mit 'Return' und schreibe 'Hallo'. Um das Inventar zu �ffnen, dr�cke 'I', 'B' �ffnet deine Tasche. Gegenst�nde k�nnen mit der Maus in Inventarfelder gezogen werden und durch einen Doppelklick benutzt werden."
Description[ENGLISH][1] = "At this station, the elfess Aldania will explain to you how to equip and use items. Greet her as you learned from Henry Cunnigan! Activate your chatbox with 'return' and type 'Hello'.\n\nTo open the inventory, hit 'I', 'B' opens the backpack. Items can be dragged with the mouse to inventory slots and used with a double click."
Description[GERMAN][2] = "Lasst uns mit dem Wichtigsten anfangen: dem Ausr�sten. �berpr�fe, ob die Chatbox deaktiviert ist und dr�cke anschlie�end 'I', um das Inventar und 'B', um die Tasche zu �ffnen. Zieht einen Gegenstand aus einem Handfeld in die Tasche und zieht danach deine Fackel mit gedr�ckter linker Maustaste in das leere Handfeld im Inventar."
Description[ENGLISH][2] = "Let us start with the basics, equipping. Make sure that your chatbox is deactivated and press 'I' to open your inventory and 'B' to open your backpack. Drag an item from a hand slot to your backpack and then drag your torch to the empty hand slot in your inventory by holding the left mouse button."
Description[GERMAN][3] = "Sehr gut, nun wei�t du, wie man mit Ausr�stung umgeht. Helme, Schuhe und �hnliches werden genauso angelegt. In der n�chsten Lektion wirst du lernen, wie man Gegenst�nde benutzt. Entz�nde die Fackel mit einem Doppelklick."
Description[ENGLISH][3] = "Very good, you know how to properly handle your equipment now. Helmets, shoes and the like are equipped in the same way. The next lesson will allow you to use your items. Ignite the torch with a double click."
Description[GERMAN][4] = "Du hast die Einf�hrung �ber das Ausr�sten und Benutzen abgeschlossen."
Description[ENGLISH][4] = "You finished the tutorial on equipping and using."

-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {52, 24, 100}

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
--QuestTarget[1] = {position(x, y, 100), position(x, y, 100)}

-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 4


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
