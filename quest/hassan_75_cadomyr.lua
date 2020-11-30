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
-- INSERT INTO "quests" ("qst_id", "qst_script") VALUES (75, 'quest.hassan_75_cadomyr');

local common = require("base.common")
local M = {}

local GERMAN = Player.german
local ENGLISH = Player.english

-- Insert the quest title here, in both languages
local Title = {}
Title[GERMAN] = "Der Schw�tzer von Cadomyr"
Title[ENGLISH] = "Cadomyr's Gossiper"

-- Insert an extensive description of each status here, in both languages
-- Make sure that the player knows exactly where to go and what to do
local Description = {}
Description[GERMAN] = {}
Description[ENGLISH] = {}
Description[GERMAN][1] = "Besorge ein Glas mit Wein und bringe es Hassan. Du kannst ein Glas mit Wein vom H�ndler kaufen oder f�lle Wein aus einer Flasche in ein leeres Glas."
Description[ENGLISH][1] = "Produce a glass with wine and bring it to Hassan. You can buy a 'glass with wine' from a merchant or fill wine from a bottle into a 'glass'."
Description[GERMAN][2] = "Rede mit Hassan. Er kann dir einiges erz�hlen."
Description[ENGLISH][2] = "Talk to Hassan, he can tell you a lot."


-- Insert the position of the quest start here (probably the position of an NPC or item)
local Start = {110, 574, 0}


-- For each status insert a list of positions where the quest will continue, i.e. a new status can be reached there
local QuestTarget = {}
QuestTarget[1] = {position(110, 574, 0), position(113, 574, 0)} -- H�ndler
QuestTarget[2] = {position(110, 574, 0)} 


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
