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
-- Basiscript f�r die Kreuze

local common = require("base.common")
local petBase = require("petsystem.base")

local M = {}

local function LangSkillName(Race)
    if (Race == 0) then return Character.humanLanguage;
    elseif (Race == 1) then return Character.dwarfLanguage
    elseif (Race == 2) then return Character.halflingLanguage
    elseif (Race == 3) then return Character.elfLanguage
    elseif (Race == 4) then return Character.orcLanguage
    elseif (Race == 5) then return Character.lizardLanguage
    end
end

local function CreateCircle(GFXid,CenterPos,Radius)
    local irad = math.ceil(Radius);
    local dim = 2*(irad+1);
    local x;
    local y;
    local map = {} ;
    for x = -irad-1, irad do
        map[x] = {};
        for y = -irad-1, irad do
            map[x][y] = (x+0.5)*(x+0.5)+(y+0.5)*(y+0.5)-irad*irad > 0
        end;
    end;

    for x = -irad, irad do
        for y = -irad, irad do
            if not( map[x][y] and  map[x-1][y] and map[x][y-1] and map[x-1][y-1] )
                    and( map[x][y] or   map[x-1][y] or  map[x][y-1] or  map[x-1][y-1] ) then
                world:gfx(GFXid,position( CenterPos.x + x, CenterPos.y + y, CenterPos.z ));
            end
        end
    end
end

local function CalcNewPos(StartPosi,TargetPosi,MoveRange)
    if not (StartPosi == TargetPosi) then
        local XAbweich=StartPosi.x-TargetPosi.x;
        local YAbweich=StartPosi.y-TargetPosi.y;
        local GAbweich=math.sqrt(math.pow(XAbweich,2)+math.pow(YAbweich,2));
        local XPart=XAbweich/GAbweich;
        local YPart=YAbweich/GAbweich;
        return position(math.floor(TargetPosi.x-(MoveRange*XPart)),math.floor(TargetPosi.y-(MoveRange*YPart)),TargetPosi.z)
    else
        return StartPosi
    end
end

local function CreateLineofFlight(StartPos,TargetPos,GFXID)
    local XDiff=StartPos.x-TargetPos.x;
    local YDiff=StartPos.y-TargetPos.y;
    local  XDiff2=math.max(StartPos.x,TargetPos.x)-math.min(StartPos.x,TargetPos.x);
    local YDiff2=math.max(StartPos.y,TargetPos.y)-math.min(StartPos.y,TargetPos.y);
    local PriDiff=math.max(XDiff2,YDiff2);
    local SecDiff=math.min(YDiff2,XDiff2);
    for i=1,PriDiff do
        local XMod=1;
        local YMod=1;
        if (XDiff<0) then XMod=-1 end
        if (YDiff<0) then YMod=-1 end
        local PathPos
        if (PriDiff==XDiff2) then
            PathPos=position(StartPos.x-XMod*i,StartPos.y-YMod*math.floor(i/PriDiff*SecDiff),StartPos.z)
        elseif (PriDiff==YDiff2) then
            PathPos=position(StartPos.x-XMod*math.floor(i/PriDiff*SecDiff),StartPos.y-YMod*i,StartPos.z)
        end
        world:gfx(GFXID,PathPos);
    end
end

function M.nextCycle(thisNPC)

    local EffectArea = 5;

    -- Suche nach Monstern
    local monsters = world:getMonstersInRangeOf(thisNPC.pos,EffectArea+2) -- Suche Nach Monstern zum Wegschleudern
    for posi,monst in pairs(monsters) do
        local owner = petBase.getOwner(monst)
        if monst:getMonsterType()==2000 or owner then
            table.remove(monsters,posi);
        end
    end

    if (#monsters>0) then -- Monster gefunden
        CreateCircle(46,thisNPC.pos,EffectArea+2); -- Lustiger Leuchtkreis
        for i, monster in pairs(monsters) do
            local newPos = CalcNewPos(thisNPC.pos,monster.pos,EffectArea+2); -- Ziel des Abflugs
            world:gfx(37,monster.pos); -- Effekt am Anfang
            monster:warp(newPos); -- guten Flug!
            monster.movepoints=monster.movepoints - 20; -- Monster festhalten
            CreateLineofFlight(thisNPC.pos,monster.pos,1); -- Fluglinie Zeichnen
            monster:setOnRoute(false); -- Cancels waypoints so it doesn't keep walking back to the cross if it's an archer.
        end
    end
    -- Monster Fertig

    -- Suche nach Spielern
    local players = world:getPlayersInRangeOf(thisNPC.pos,EffectArea); -- Suche nach Spielern

    if (#players>0) then -- Spieler gefunden
        for i, player in pairs(players) do
            if (player:increaseAttrib("hitpoints",0) == 0) then -- Der Char ist tot, beleben wir ihn
                player:increaseAttrib("hitpoints",1); -- Da lebt er wieder
                if (player:increaseAttrib("foodlevel",0) < 10000) then
                    player:increaseAttrib("foodlevel",-(player:increaseAttrib("foodlevel",0)-10000))
                end
                player:setPoisonValue(0);
                local langSkill = player:getSkill(Character.commonLanguage);
                if ((langSkill > 0) and (langSkill < 100 )) then
                    player:increaseSkill(Character.commonLanguage,100-langSkill);
                end
                local SkillName = LangSkillName(player:getRace());
                langSkill = player:getSkill(SkillName);
                if ((langSkill > 0) and (langSkill < 100 )) then
                    player:increaseSkill(SkillName,100-langSkill);
                end
                world:gfx(53,player.pos)
                world:gfx(53,thisNPC.pos);
                CreateCircle(52,thisNPC.pos,thisNPC:distanceMetric(player)+1); -- Lustiger Leuchtkreis
                -- WORKAROUND for Mantis issue #451: doubleEffect from lte_resurrected.lua, as all values are deleted upon double-adding effect
                local foundRes, resEffect = player.effects:find(400);
                if foundRes then
                    M.doubleEffect(resEffect,player);
                else
                    player.effects:addEffect( LongTimeEffect(400,math.random(600,1800)) );
                end
            end
        end
    end
    -- Spieler fertig
end

function M.doubleEffect( rebirthEffect, Reborn )
    if Reborn:isAdmin() then
      return false;
    end

    common.InformNLS( Reborn,
        "[Wiederbelebung] Du f�hlst dich noch sehr schwach.",
        "[Respawn] You feel very weak." );
    local maxChange = 0;
    local changeBy = 0;
    local foundChange = false;
    local attribs = {"strength","dexterity","constitution","agility","intelligence","perception","willpower","essence"}
    for _,attrib in pairs(attribs) do
        foundChange, changeBy = rebirthEffect:findValue( attrib );
        if not foundChange then
            changeBy = 0;
        end
        changeBy = changeBy + Reborn:increaseAttrib( attrib, 0 ) - 1;
        rebirthEffect:addValue( attrib, changeBy );
        maxChange = math.max( maxChange, changeBy );
        Reborn:increaseAttrib( attrib, 1 - Reborn:increaseAttrib( attrib, 0 ) );
    end;
    local foundRegen, regEffect = Reborn.effects:find(2);
    if foundRegen then
        regEffect:addValue( "maxHP", math.floor( 10000 / ( maxChange + 1 ) ) );
        rebirthEffect:addValue( "maxChange", maxChange );
    end;
    local foundMulti, multi = rebirthEffect:findValue("multiRes");
    if not foundMulti then
        multi = 1;
    end
    multi = multi +1;
    rebirthEffect:addValue("multiRes",multi);
    Reborn:setQuestProgress(20,common.GetCurrentTimestamp());
    return true;
end

return M
