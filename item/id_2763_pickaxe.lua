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
-- mining mit Spitzhacke

-- UPDATE items SET itm_script='item.id_2763_pickaxe' WHERE itm_id=2763;

-- UPDATE items SET com_agingspeed = 255, com_objectafterrot = 1246 WHERE itm_id = 1246;
-- UPDATE items SET com_agingspeed =  10, com_objectafterrot = 1246 WHERE itm_id = 915;

-- UPDATE items SET com_agingspeed = 255, com_objectafterrot = 1245 WHERE itm_id = 1245;
-- UPDATE items SET com_agingspeed =  10, com_objectafterrot = 1245 WHERE itm_id = 1254;

-- UPDATE items SET com_agingspeed = 255, com_objectafterrot = 232  WHERE itm_id = 232;
-- UPDATE items SET com_agingspeed =  10, com_objectafterrot = 232  WHERE itm_id = 233;

-- UPDATE items SET com_agingspeed = 255, com_objectafterrot = 914  WHERE itm_id = 914;
-- UPDATE items SET com_agingspeed =  10, com_objectafterrot = 914  WHERE itm_id = 1265;

-- UPDATE items SET com_agingspeed = 255, com_objectafterrot = 1273 WHERE itm_id = 1273;
-- UPDATE items SET com_agingspeed =  10, com_objectafterrot = 1273 WHERE itm_id = 1257;

-- UPDATE items SET com_agingspeed = 255, com_objectafterrot = 1276 WHERE itm_id = 1276;
-- UPDATE items SET com_agingspeed =  10, com_objectafterrot = 1276 WHERE itm_id = 1278;

-- UPDATE items SET com_agingspeed = 255, com_objectafterrot = 1250 WHERE itm_id = 1250;
-- UPDATE items SET com_agingspeed =  10, com_objectafterrot = 1250 WHERE itm_id = 1251;

local common = require("base.common")
local shared = require("craft.base.shared")
local treasure = require("item.base.treasure")
local mining = require("craft.gathering.mining")
local metal = require("item.general.metal")
local transformation_dog = require("alchemy.teaching.transformation_dog")
local glyphmagic = require("magic.glyphmagic")

local M = {}

M.LookAtItem = metal.LookAtItem

-- @return  True if found a treasure.
local function DigForTreasure(User)
    local TargetPos = common.GetFrontPosition(User);
    local groundTile = world:getField(TargetPos):tile();
    local groundType = common.GetGroundType(groundTile);

    if groundType == common.GroundType.rocks then
        return treasure.performDiggingForTreasure(User, TargetPos, {
            maximalLevel = (User:getSkill(Character.mining) / 10) + 1,
            msgDiggingOut = {
                de = "Du schwingst deine Spitzhacke gegen den steinigen Boden und st��t auf etwas das noch " ..
                        "h�rter ist als der Boden. Das muss er sein! Der Schatz. Noch einmal graben und der " ..
                        "grenzenlose Reichtum ist dein!",
                en = "You swing your pick-axe against the stony ground and hit something that is even harder " ..
                        "then the ground. That must it be! The treasure! Another swing and it is yours!"
            }}
        )
    end
    return false;
end

function M.UseItem(User, SourceItem, ltstate)

    if common.isBroken(SourceItem) then
        common.HighInformNLS(User,"Deine Spitzhacke ist kaputt.","Your pick-axe is broken.")
        return
    end
    
    if shared.hasTool(User, 2763) == false then
        common.HighInformNLS(User,"Du musst die Spitzhacke in der Hand halten.","You need to hold the pick-axe in your hand.")
        return
    end

    if glyphmagic.removeGlyphForge(User) then
        return
    end

    if not common.FitForWork( User ) then -- check minimal food points
        return
    end

    -- check for alchemy scroll
    if transformation_dog.DigForTeachingScroll(User) then
        return
    end

    if DigForTreasure(User) then
        return;
    end

    local areaId = mining.GetAreaId(User.pos);
    if (areaId == nil) then
        common.HighInformNLS(User,
        "Die Gegend sieht nicht so aus, als k�nnte man hier etwas finden.",
        "The area doesn't look like a good place to mine.");
        return;
    end

    local rock = mining.getRock(User, areaId);
    if (rock == nil) then
        common.HighInformNLS(User,
        "Du musst neben einem Felsen stehen um Bergbau zu betreiben.",
        "You have to stand next to a rock to mine.");
        return
    end

    mining.StartGathering(User, rock, ltstate);
end

return M

