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
-- INSERT INTO scheduledscripts VALUES('scheduled.scheduledFunction', 1, 1, 'onExecute');

-- This is an scheduled script that works to support any other scripts that require to call another function with
-- some delay. It is possible to register functions in that script that will be executed afer a set delay.
local M = {}

-- The list of functions and their counters that are scheduled to be executed
local executionQueue = {}

function M.registerFunction(delay, callFunction)
    table.insert(executionQueue, {counter = delay, exec = callFunction})
end

function M.onExecute()
    if (#executionQueue > 0) then
        local currentQueue = executionQueue
        executionQueue = {}

        for _, data in pairs(currentQueue) do
            data.counter = data.counter - 1
            if data.counter <= 0 then
                data.exec()
            else
                table.insert(executionQueue, data)
            end
        end
    end
end

return M