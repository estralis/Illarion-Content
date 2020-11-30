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
local doors = require("base.doors")
local lookat = require("base.lookat")

local M = {}

-- UPDATE items SET itm_script='item.doors' WHERE itm_id IN (86, 87,927,317,476,477,478,479,499,900,901,902,484,485,924,923,668,669,660,661,684,685,664,665,670,666,671,667,662,686,663,687,715,714,712,713,497,922,925,926,480,481,482,483,903,904,905,906,486,487,496,920,656,657,648,649,652,653,644,645,658,654,659,655,650,646,651,647,711,710,708,709,3754,3755,3756,3757,3758,3759,3760,3761,3790,3791,3792,3793,3794,3795,3796,3797,3798,3799,3800,3801,3802,3803,3804,3805,3806,3807,3808,3809,3846,3850,3847,3851,3848,3852,3849,3853);

function M.UseItem(User, SourceItem)

    if common.isOnNoobia(User.pos) then --On Noobia: Doors must not be closed.

        common.InformNLS(User,"Die T�r klemmt und kann nicht geschlossen werden.","The door is jammed and won't close.");
        return; --bailing out
        
    end --Noobia end

    if doors.CloseDoor(SourceItem) then

        common.InformNLS(User,"Du schlie�t die T�r.","You close the door.");

    else

         local OpenDoor,OpenOK=doors.OpenDoor(SourceItem);

        if OpenOK then

            common.InformNLS(User,"Du �ffnest die T�r.","You open the door.");

        elseif OpenDoor then

            common.InformNLS(User,"Du versuchst die T�r zu �ffnen, doch sie ist verschlossen.","You try to open the door, but the door is locked.");

        end

    end

end

function M.LookAtItem(User,Item)
    return lookat.GenerateLookAt(User, Item, lookat.NONE)
end

return M

