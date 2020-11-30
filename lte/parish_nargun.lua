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
-- ID 29
-- Effects for parish of Nargun

local common = require("base.common")
local M = {}

local cycleCounter = {};
local PN_FriendlyRaces = {18,24,37,38};
local PN_Waypoints = {position(-80,-207,0), position(-222,-196,0), position(-200,-270,0), position(-384,-206,0)};

local function PN_GetEffectType(Effect)

    local foundEffectType, effectType = Effect:findValue("effectType");
    if not foundEffectType then
        effectType = 0
    end
    return effectType;
end

local function PN_LeadToPoint( Char, effectType )
    if (cycleCounter[Char.id]==nil) then
        cycleCounter[Char.id]=40;
    end

    local thepos = PN_Waypoints[effectType];
    local distance=Char:distanceMetricToPosition(thepos);

    if (distance <= 5) or (cycleCounter[Char.id]>=40) then
        if (Char.pos.z>=0 and Char.pos.z<=3) then

            local dir = common.GetDirection( Char.pos, thepos );
            local dirText;

            if (dir == 0) then dirText = common.GetNLS( Char, "NORDEN", "NORTH" )
            elseif (dir == 1) then dirText = common.GetNLS( Char, "NORDOSTEN", "NORTHEAST" )
            elseif (dir == 2) then dirText = common.GetNLS( Char, "OSTEN", "EAST" )
            elseif (dir == 3) then dirText = common.GetNLS( Char, "S�DOSTEN", "SOUTHEAST" )
            elseif (dir == 4) then dirText = common.GetNLS( Char, "S�DEN", "SOUTH" )
            elseif (dir == 5) then dirText = common.GetNLS( Char, "S�DWESTEN", "SOUTHWEST" )
            elseif (dir == 6) then dirText = common.GetNLS( Char, "WESTEN", "WEST" )
            elseif (dir == 7) then dirText = common.GetNLS( Char, "NORDWESTEN", "NORTHWEST" )
            else return true
            end;

            if ( distance <= 5 ) then
                common.InformNLS(Char,
                    "Genau hier solltest du hin. Du f�hlst wie eine Last von dir genommen wird.",
                    "This is where you was to go. You feel a burden is taken off you.");
                return false;
            elseif ( distance <= 30 ) then
                common.InformNLS( Char,
                    "Dein Ziel ist ganz in der N�he. Gehe weiter nach "..dirText,
                    "You are close to your destination. Keep going "..dirText);
                cycleCounter[Char.id]=30;
            else
                common.InformNLS( Char,
                    "Eine seltsame Macht zieht dich nach "..dirText,
                    "A strange power leads you "..dirText);
                cycleCounter[Char.id]=20;
            end;
        else
            common.InformNLS( Char,
                "Irgendetwas sagt dir, dass es eine gute Idee w�re wieder zur Erdoberfl�che zu gelangen.",
                "Something tells you it would be a good idea to get back to the surface.");
            cycleCounter[Char.id]=1;
        end
    else
        cycleCounter[Char.id]=cycleCounter[Char.id]+1;
    end
    return true;
end

function M.addEffect(Effect, Char)

    local effectType = PN_GetEffectType(Effect);

    if effectType >= 1 and effectType <= 4 then
        Effect:addValue("saveRace", Char:getRace() );
        Char:setRace(PN_FriendlyRaces[math.random(1,#PN_FriendlyRaces)]);
        world:gfx(31,Char.pos);
        common.InformNLS(Char,
            "Du f�hlst dich auf einmal so seltsam distanziert von deinem K�rper.",
            "You suddenly feel strangely dissociated from your body.");
        cycleCounter[Char.id] = 40;
    end
end

function M.callEffect(Effect, Char)
    local effectType = PN_GetEffectType(Effect);
    Effect.nextCalled = 10;
    if effectType >= 1 and effectType <= 4 then
        return PN_LeadToPoint(Char, effectType);
    end
    return false;
end

function M.removeEffect(Effect, Char)
    local effectType = PN_GetEffectType(Effect);
    if effectType >= 1 and effectType <= 4 then
        local foundSaveRace, saveRace = Effect:findValue("saveRace");
        if not foundSaveRace then
            saveRace = 0;
        end
        Char:setRace(saveRace);
        world:gfx(31,Char.pos);
        local gText, eText = "", "";
        if effectType == 1 then
            gText = "Irgendwie bekommst du Lust auf ein paar saftige Fr�chte.";
            eText = "Somehow you have appetite for some juicy fruits.";
        elseif effectType == 2 then
            gText = "Pl�tzlich steigt f�rchterliche Wut in dir hoch und du willst auf ein Tier einschlagen, ihm das Fleisch herausrei�en.";
            eText = "Suddenly you feel tremendous anger arising and you want to smash on an animal, rip out its meat."
        elseif effectType == 3 then
            gText = "Deine Kehle schn�rt sich zu, eine einzelne Tr�ne rinnt dir �ber die Wange, als du voller Mitleid an die armen Tiere denkst.";
            eText = "With a lump in your throat, a single tear runs down your cheek as you think of those pity animals.";
        elseif effectType == 4 then
            gText = "Ein wohliges Gef�hl �berkommt dich, als ob du hier hingeh�rst.";
            eText = "A cosy feeling comes over you, as if you belong here.";
        end
        common.InformNLS(Char,gText,eText);
    end
end

function M.loadEffect(Effect, Char)
    local effectType = PN_GetEffectType(Effect);
    if effectType >= 1 and effectType <= 4 then
        Char.effects:removeEffect(29);
    end
end

return M

