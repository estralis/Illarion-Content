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
-- INSERT INTO triggerfields VALUES (36,95,100,'triggerfield.noobia_viola');

local common = require("base.common")

local M = {}

function M.MoveToField(Character)

    -- for Noobia: the char has to walk to a field (this triggerfield); he gets a message and we change a queststatus so that we remember he was at the field
    local find = Character.effects:find(13) --Noob effect
    if find then --Is this even a noob?
        local value = Character:getQuestProgress(314);
        if (value == 0) then --Didn't visit the triggerfield yet
            Character:setQuestProgress(314, 1) --player passed the triggerfield

            local callbackNewbie = function() end --empty callback
            local dialogText = common.GetNLS(Character,
                "Dies ist nun die letzte Station des Tutorials. W�hle ein Reich aus, welchem dein Charakter zuk�nftig angeh�ren wird - Cadomyr, Galmair oder Runewick? Gehe hierzu durch eines der Portale auf den kleinen Inseln.\n\nDu kannst diese Entscheidung sp�ter im Spiel jederzeit revidieren. Viola Baywillow kann dir einiges �ber die drei Reiche erz�hlen, frage sie einfach nach 'Hilfe'.\n\nUnd nebenbei - hast du den Markierungsstein gesehen?",
                "This is the final station of the tutorial. Please choose which realm you desire to be the home for your character by stepping through the corresponding portal on the three islands - Cadomyr, Galmair or Runewick?\n\nYou can reconsider this decision at any time once you have joined the game. Viola Baywillow will provide you with more information on the three available realms, just ask her for 'help'.\n\nBy the way - did you notice the marker stone?")
            local dialogNewbie = MessageDialog("Tutorial", dialogText, callbackNewbie)
            Character:requestMessageDialog(dialogNewbie)
        end
    end
end

return M
