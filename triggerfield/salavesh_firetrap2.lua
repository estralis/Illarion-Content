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
local common = require("base.common")

local M = {}

--This script shoots a fireball down the hall in the "Errant Crusade" quest map
--Can be used with various triggerfields, players shall "abuse" this to fight the monsters down there

function M.MoveToField(User)

    if User:getType() ~= Character.player then
        return
    end

    common.InformNLS(User, "Ein Feuerball schie�t aus einem kleinen Loch in der Wand die Halle entlang!", "A fireball is shot from a small hole in the wall down the hallway!")

    local ycord = User.pos.y --The y-coordinate of the triggerfield

    for i = 733, 751 do --replace with proper coordinates
        if world:isCharacterOnField(position(i, ycord, -3)) then --there is someone!
            local target = world:getCharacterOnField(position(i, ycord, -3)) --and who is it?

            if (target:increaseAttrib("hitpoints", 0) > 0) then --ghosts do not get hit
                world:gfx(9, position(i, ycord, -3)) --Fireball!
                world:makeSound(5, position(i, ycord, -3)) --BOOM!
                target:increaseAttrib("hitpoints", math.random(-1000, -500)) --damaging the target
                return --got one, bailing out.
            else --it's a ghost
                world:gfx(10, position(i, ycord, -3)) --Smokecloud!
            end
        else --there is no one
            world:gfx(10, position(i, ycord, -3)) --Smokecloud!
        end
    end --next tile

    --No one got hit! Fireball hits the other wall. VERY unlikely.
    world:gfx(9, position(751, ycord, -3)) --Fireball!
    world:makeSound(5, position(751, ycord, -3)) --BOOM!
end

return M
