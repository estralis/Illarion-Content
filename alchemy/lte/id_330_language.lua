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
-- LTE f�r das Druidensystem
-- by Falk
-- reworked by Merung

local common = require("base.common")

local M = {}

-- INSERT INTO longtimeeffects VALUES (330, 'alchemy_language', 'alchemy.lte.id_330_language');

local ListLanguages={Character.commonLanguage,Character.humanLanguage,Character.dwarfLanguage,Character.elfLanguage,Character.lizardLanguage,Character.orcLanguage,Character.halflingLanguage,Character.ancientLanguage}

function M.addEffect(Effect, User)                               
--Nur beim ersten Aufruf
--User:inform("debug func addEffect")     
end

function M.callEffect(Effect,User)                              
    common.InformNLS( User, "Du f�hlst, dass der Sprachtrank seine Wirkung verliert.", "You feel that the language potion loses its effect.")
    return false
end

function M.removeEffect(Effect,User)
    --[[
    local find,languageId = Effect:findValue("languageId")
    local skillName = ListLanguages[languageId]
    local find,oldSkill = Effect:findValue( "oldSkill")          
    local find,newSkill = Effect:findValue( "newSkill")

    --original skill level
    User:increaseSkill(skillName,(-(newSkill-oldSkill))) ]]
end

function M.loadEffect(Effect,User)                              

end

return M

