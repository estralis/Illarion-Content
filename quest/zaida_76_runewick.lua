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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (76, 'quest.zaida_76_runewick');

local common = require("base.common")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Die Schw�tzerin von Runewick"
Title[ENGLISH] = "Runewick's Gossiper"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Besorge einen Glas mit Wein und bringe es Zaida. Du kannst ein Glas mit Wein vom H�ndler kaufen oder f�lle Wein aus einer Flasche in ein leeres Glas. Wein kann man mit einen Kochl�ffel am Weinfass herstellen."
Description[ENGLISH][1] = "Get a glass of wine and take it to Zaida. You can buy a glass of wine from a merchant or pour wine from a bottle into a glass. You can make wine using a cooking spoon at a wine barrel."
Description[GERMAN][2] = "Rede mit Zaida, sie kann dir einiges Erz�hlen."
Description[ENGLISH][2] = "Talk to Zaida, she can tell you a lot."

-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {907, 822, 0}

-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
QuestTarget[1] = {position(907, 822, 0), position(919, 823, 0), position (920, 821, 0)} -- H�ndler, Weinfass
QuestTarget[2] = {position(907, 822, 0)}


-- Insert the quest status which is reached at the end of the quest
local FINAL_QUEST_STATUS = 2


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
