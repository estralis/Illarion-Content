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
-- Long Time Effect Script: Newbie Island
-- Effect ID: 13
-- Values: newbiePosX, newbiePosY, newbiePosZ, itemid_1, itemnumber_1, itemdata_1, itemquality_1 (1-18)

local M = {}

function M.addEffect(newbieEffect, Character)
end

function M.callEffect(newbieEffect,Character)

    if (Character.pos.z ~= 100) and (Character.pos.z ~= 101) then
        return false --removing the effect
    end

    local foundRoundCount, roundCount = newbieEffect:findValue("roundCount")

    if foundRoundCount then

        roundCount = roundCount + 1 --Counting

    else
        roundCount = 1
    end

    newbieEffect:addValue("roundCount",roundCount)
    newbieEffect.nextCalled=600 --One minute
    return true --bailing out in any case

end

function M.removeEffect(newbieEffect, Character)
end

return M
