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

-- Character bekommt einen Perception-boost, der erst ansteigt und dann sinkt --

function M.addEffect(addPerc, User)           -- Wird nur beim Start des Effektes aufgerufen (-> Perc+1)
    common.InformNLS(User, "Deine Sinne werden merkbar sensibler.", "Your senses grow noticably.")
    User:increaseAttrib("perception",1)    -- Perception+1 (erste Steigerung)
end

function M.callEffect(percBoost, User)                    -- Effect wird ausgef�hrt
    percBoost.nextCalled = 60                         -- Erneut in einer Minute aufrufen
    local found,addPerc = percBoost:findValue("addPerc")    -- Wieviel wurde bisher "geboostet"?
    if found then                                       -- sicherheitshalber: wenn ueberhaupt geboostet wurde
        if percBoost.numberCalled<6 then                -- wenn bisher weniger als 6 mal aufgerufen wurde
            User:increaseAttrib("perception",1)        -- Perception um 1 steigern
            percBoost:addValue("addPerc",addPerc+1)   -- Buchhaltung: Um eins hinaufzaehlen
            return true                                -- "true" zurueckliefern (=noch einmal aufrufen)
        else                                            -- wenn schon oefter als 5 mal aufgerufen wurde
            User:increaseAttrib("perception",-1)       -- Perception um 1 verringern
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

function M.removeEffect( Effect, Character )
    -- do nothing
end

function M.loadEffect(Effect, User)                  -- wenn der Charakter einloggt...
    local found,addPerc = Effect:findValue("addPerc")
    if found then
        User:increaseAttrib("perception",addPerc)      -- Buchhaltung: Auslesen der aktuellen "steigerung" und steigern
        Effect.nextCalled = 600                     -- in einer Minute wieder aufrufen
    end
end

return M
