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
-- INSERT INTO triggerfields VALUES (216,647,0,'triggerfield.homeland');
-- INSERT INTO triggerfields VALUES (216,648,0,'triggerfield.homeland');

-- INSERT INTO triggerfields VALUES (478,249,0,'triggerfield.homeland');
-- INSERT INTO triggerfields VALUES (478,250,0,'triggerfield.homeland');

-- INSERT INTO triggerfields VALUES (888,646,0,'triggerfield.homeland');
-- INSERT INTO triggerfields VALUES (889,646,0,'triggerfield.homeland');

-- INSERT INTO triggerfields VALUES (784,690,0,'triggerfield.homeland');
-- INSERT INTO triggerfields VALUES (785,690,0,'triggerfield.homeland');

-- INSERT INTO triggerfields VALUES (161,748,0,'triggerfield.homeland');
-- INSERT INTO triggerfields VALUES (162,748,0,'triggerfield.homeland');

local common = require("base.common")

local M = {}

function M.MoveToField(char)
    if char:getType() ~= Character.player then
        return
    end

    local questvalue = {}
    questvalue[1] = 166 --Cadomyr
    questvalue[2] = 167 --Galmair
    questvalue[3] = 168 --Runewick
    questvalue[4] = 169 --Runewick second bridge set
    questvalue[5] = 172 --Runewick second bridge set

    local location = {}
    location[1] = position(216, 647, 0) --Cadomyr
    location[2] = position(216, 648, 0) --Cadomyr
    location[3] = position(478, 249, 0) --Galmair
    location[4] = position(478, 250, 0) --Galmair
    location[5] = position(888, 646, 0) --Runewick
    location[6] = position(889, 646, 0) --Runewick
    location[7] = position(784, 690, 0) --Runewick
    location[8] = position(785, 690, 0) --Runewick
    location[9] = position(161, 748, 0) --Cadomyr
    location[10] = position(162, 748, 0) --Cadomyr

    local factionString
    if (char:getQuestProgress(questvalue[1]) == 0) and (char:getFaceTo() == 1 or char:getFaceTo() == 2 or char:getFaceTo() == 3) and (char.pos == location[1] or char.pos == location[2]) then --Didn't visit the triggerfield yet
        char:setQuestProgress(questvalue[1], 1) --player was here
        factionString = "Cadomyr"
    elseif (char:getQuestProgress(questvalue[2]) == 0) and (char:getFaceTo() == 1 or char:getFaceTo() == 2 or char:getFaceTo() == 3) and (char.pos == location[3] or char.pos == location[4]) then --Didn't visit the triggerfield yet
        char:setQuestProgress(questvalue[2], 1) --player was here
        factionString = "Galmair"
    elseif (char:getQuestProgress(questvalue[3]) == 0) and (char:getFaceTo() == 7 or char:getFaceTo() == 0 or char:getFaceTo() == 1) and (char.pos == location[5] or char.pos == location[6]) then --Didn't visit the triggerfield yet
        char:setQuestProgress(questvalue[3], 1) --player was here
        factionString = "Runewick"
    elseif (char:getQuestProgress(questvalue[4]) == 0) and (char:getFaceTo() == 7 or char:getFaceTo() == 0 or char:getFaceTo() == 1) and (char.pos == location[7] or char.pos == location[8]) then --Didn't visit the triggerfield yet
        char:setQuestProgress(questvalue[4], 1) --player was here
        factionString = "Runewick"
    elseif (char:getQuestProgress(questvalue[5]) == 0) and (char:getFaceTo() == 3 or char:getFaceTo() == 4 or char:getFaceTo() == 5) and (char.pos == location[9] or char.pos == location[10]) then --Didn't visit the triggerfield yet
        char:setQuestProgress(questvalue[5], 1) --player was here
        factionString = "Cadomyr"
    else
        return --bailing out
    end

    local callbackHomeland = function(empty) end --empty callback
    local dialogHomeland
    if char:getPlayerLanguage() == 0 then
        dialogHomeland = MessageDialog("Heimatland", "Du verl�sst nun das vergleichsweise sichere Heimatland von "..factionString..". Hinter diesem Punkt wirst du wahrscheinlich feindseligen Monstern begegnen. Sei auf der Hut!", callbackHomeland)
    else
        dialogHomeland = MessageDialog("Homeland", "You are leaving the comparable safe homeland of "..factionString..". Beyond this point, you will most likely encounter hostile monsters. Be on your guard!", callbackHomeland)
    end
    char:requestMessageDialog(dialogHomeland)
end

return M
