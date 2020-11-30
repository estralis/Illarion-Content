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
-- Standardskript f�r Instrumente
-- Nitram

local common = require("base.common")

local M = {}

local TalkTexts={[Character.flute] = {}, [Character.lute] = {}, [Character.horn] = {}, [Character.harp] = {}, [Character.panpipe] = {}, [Character.drum] = {}};

function M.addTalkText(eText,gText, Skill)
    table.insert(TalkTexts[Skill],{eText,gText});
end

function M.PlayInstrument(User,Item,Skill)
    local Skl=User:getSkill(Skill);
    local Qual=math.floor(Item.quality/100);
    local PlayVal=common.Limit(math.floor((Skl+(Qual*5))/120*#TalkTexts[Skill]*(math.random(8,13)/10)),1,#TalkTexts[Skill]);
    User:talk(Character.say, TalkTexts[Skill][PlayVal][2], TalkTexts[Skill][PlayVal][1])
    User:learn(Skill,30,100)
    User.movepoints=User.movepoints-30;
end

return M