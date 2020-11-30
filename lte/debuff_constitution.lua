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

-- Long time effect (101)
local M = {}


function M.addEffect(theEffect, User)

    User:increaseAttrib("constitution", -2);

end

function M.callEffect(theEffect, User)

    return false;
end

function M.loadEffect(theEffect, User)

    User:increaseAttrib("constitution", -2);

end

function M.removeEffect (theEffect, User)

    common.InformNLS( User, "Deine Ausdauer kehrt zur�ck.", "Your constitution is back to normal.")
    User:increaseAttrib("constitution", 2);

end

return M

