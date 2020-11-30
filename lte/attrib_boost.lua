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

local AttribToBoost = "perception"
local boostSteps = 6
local boostValue = 1
local reboostValue = -1


function M.addEffect(addPerc, User)    -- Wird nur beim Start des Effektes aufgerufen (-> Perc+1)
    User:inform("function M.addEffect erreicht")
    common.InformNLS(User, "Deine Sinne werden merkbar sensibler.", "Your senses grow noticably.")
    User:increaseAttrib(AttribToBoost,boostValue)    -- (erste Steigerung)
end

-- Wird regelmaessig aufgerufen (das erste mal nach einer Minute)
function M.callEffect(percBoost, User)                    -- Effect wird ausgef�hrt
    percBoost.nextCalled = 60                          -- Erneut in einer Minute aufrufen
    local found,addPerc = percBoost:findValue("addPerc")     -- Wieviel wurde bisher "geboostet"?
    if found then                                       -- sicherheitshalber: wenn ueberhaupt geboostet wurde
        if percBoost.numberCalled < boostSteps then
            User:increaseAttrib(AttribToBoost,boostValue)
            percBoost:addValue("addPerc",addPerc+1)    -- Buchhaltung: Um eins hinaufzaehlen
            return true                                -- "true" zurueckliefern (=noch einmal aufrufen)
        else
            User:increaseAttrib(AttribToBoost,reboostValue)
            percBoost:addValue("addPerc",addPerc-1)   -- Buchhaltung: um 1 runter zaehlen
            if addPerc==1 then                          -- wir sind am Ende angekommen: Effekt aufheben.
                return false                           -- "false" zurueckgeben: Effekt wird aufgehoben.
            end
            return true                                -- "true" -> wird wieder aufgerufen
        end
    else
        return false                                   -- Nicht mehr aufrufen
    end
end

function M.removeEffect(percBoost, User)
    -- do nothing
end

function M.loadEffect(percBoost, User)                  -- wenn der Charakter einloggt...
    local found,addPerc = percBoost:findValue("addPerc")
    if found then
        User:increaseAttrib(AttribToBoost,addPerc)     -- Buchhaltung: Auslesen der aktuellen "steigerung" und steigern
        percBoost.nextCalled = 600                     -- in einer Minute wieder aufrufen
    end
end

return M
