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
-- INSERT INTO triggerfields VALUES (37,40,100,'triggerfield.noobia_groknar');
-- INSERT INTO triggerfields VALUES (38,40,100,'triggerfield.noobia_groknar');
-- INSERT INTO triggerfields VALUES (39,40,100,'triggerfield.noobia_groknar');
-- INSERT INTO triggerfields VALUES (40,40,100,'triggerfield.noobia_groknar');
-- INSERT INTO triggerfields VALUES (41,40,100,'triggerfield.noobia_groknar');
-- INSERT INTO triggerfields VALUES (42,40,100,'triggerfield.noobia_groknar');

local common = require("base.common")

local M = {}

function M.MoveToField(Character)

    -- for Noobia: the char has to walk to a field (this triggerfield); he gets a message and we change a queststatus so that we remember he was at the field
    local find = Character.effects:find(13) --Noob effect
    if find then --Is this even a noob?
        local value = Character:getQuestProgress(311)
        if (value == 0) then --Didn't visit the triggerfield yet
            Character:setQuestProgress(311, 1) --player passed the first station

            local callbackNewbie = function() end --empty callback
            local dialogText = common.GetNLS(Character,
                "Diese Station lehrt dich, wie man k�mpft. Groknar, der Lehrmeister, ist ein stolzer und m�chtiger Orkkrieger. Stell dich ihm vor - vorsichtig.\n\nMonster und auch andere Spielercharaktere (PvP) kannst du mit einem Rechtsklick angreifen.\n\nDr�cke 'Q', um eine Liste deiner Aufgaben und ihren Status einzusehen.",
                "At the next station, you will learn how to fight. Groknar, the instructor, is a proud and mighty Orc warrior. Just speak up to him - carefully.\n\nTo attack monsters and also other player characters (PvP), click on them once with the right mouse button.\n\nHit 'Q' to review your current quests and their status.")
            local dialogNewbie = MessageDialog("Tutorial", dialogText, callbackNewbie)
            Character:requestMessageDialog(dialogNewbie)
        end
    end
end

return M
