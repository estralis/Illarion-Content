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
-- UPDATE items SET itm_script='item.id_2760_rope' WHERE itm_id=2760;

local common = require("base.common")
local climbing = require("content.climbing")
local cloth = require("item.general.cloth")
local tying_capturer = require("lte.tying_capturer")

local M = {}

M.LookAtItem = cloth.LookAtItem

-- Language=0 for German, otherwise English
local function GetRaceGenderText( Language, Character )

    local articleGerman={"den","die"};
    local descriptionGerman={"Mensch","Zwerg","Halbling","Elf","Ork","Echsenmensch","Menschendame","Zwergenmaid","Halblingsdame","Elfendame","Orkfrau","Echse"};
    local descriptionEnglish={"human","dwarf","halfling","elf","orc","lizard","human lady","dwarven maid","halfling lady","elven lady","orcess","female lizard"};


    local race=Character:getRace();
    local gender=Character:increaseAttrib("sex",0);

    local outText
    if Language == 0 then
        if race > 5 or gender > 1 then
            outText = "das Wesen"
        else
            outText = articleGerman[gender+1].." "..descriptionGerman[race+1+6*gender];
        end
    else
        if race > 5 or gender > 1 then
            outText = "the creature"
        else
            outText = "the "..descriptionEnglish[race+1+6*gender];
        end
    end

    return outText;
end

local function UseRopeWithCharacter( User, SourceItem, Target, ltstate )

    -- check if rope is in hands
    if SourceItem:getType() ~= 4 then
        common.InformNLS(User,
            "Du musst das Seil in die Hand nehmen, wenn du jemanden fesseln willst.",
            "You have to take the rope in your hand if you want to tie up someone.")
        return;
    end

    -- check for abort
    if (ltstate == Action.abort) then
        local gText = GetRaceGenderText(0,Target);
        local eText = GetRaceGenderText(1,Target);
        common.InformNLS ( User,
            "Dir gelingt es nicht "..gText.." zu fesseln.",
            "You don't succeed in tying up "..eText..".");
        return;
    end

    -- check viewing direction
    if not common.IsLookingAt(User, Target.pos) then
        common.InformNLS( User,
            "Du solltest dort hinschauen, wo dein Gefangener ist.",
            "You should look in your captive's direction.");
        return;
    end

    if User.effects:find(26) then
        common.InformNLS(User,
            "Du hast schon einen Gefangenen.",
            "You already have a captive.");
        return;
    end

    -- tie up only PCs without admin rights
    if Target:getType()~=0 or ( Target:isAdmin() and not User:isAdmin() ) then
        common.InformNLS(User,
            "Dieses Wesen kannst du nicht fesseln.",
            "You can't tie this creature up.");
        return;
    end

    -- tie up only PCs who are alive
    if (Target:increaseAttrib("hitpoints",0) == 0) then
        common.InformNLS(User,
            "Du kannst keinen Geist fesseln.",
            "You can't tie up a ghost.");
        return;
    end

    if User.id==Target.id then
        common.InformNLS(User,
            "Du solltest dich nicht selbst fesseln.",
            "You shouldn't tie up yourself.");
        return;
    end

    -- Check if User is in attackmode
    if User.attackmode then
        common.InformNLS ( User,
            "Du kannst niemanden fesseln, w�hrend du k�mpfst.",
            "You can't tie someone up while you are fighting." );
        return;
    end

    if tying_capturer.HasEnoughCapturers(Target) then
        common.InformNLS(User,
            "Der Gefangene ist nun schon ausreichend gefesselt.",
            "The captive is now sufficiently tied up already.");
        return;
    end

    if User.effects:find(24) then
        common.InformNLS(User,
            "Dir sind leider die H�nde gebunden.",
            "Unfortunately your hands are tied.");
        return;
    end
    local TargetPosList = {};
    local foundEffectTarget = Target.effects:find(24);
    -- Check ltstate, 5 sec for first, 2 sec for another capturer or freezed target
    if (ltstate == Action.none) then
        local Time = 50;
        -- set tying time
        if foundEffectTarget or common.IsCharacterParalysed(Target) then
            -- reduced time for another captor or freezed target
            Time = 20;
        else
            -- calculate tying time depending on target's and user's hp
            Time = 50 + math.floor( Target:increaseAttrib("hitpoints",0)/333 ) - math.floor( User:increaseAttrib("hitpoints",0)/333 );
            if Target.attackmode then
                -- time bonus if target is attacking
                Time = Time + 30;
            end
        end

        User:startAction(Time,0,0,0,0);

        local gText = GetRaceGenderText(0,Target);
        local eText = GetRaceGenderText(1,Target);
        User:talk(Character.say, "#me versucht "..gText.." zu fesseln.", "#me tries to tie up "..eText..".")

        common.InformNLS(Target,
            "Jemand versucht dich zu fesseln!",
            "Someone tries to tie you up!");

        -- save target's position

        TargetPosList[Target.id] = common.CopyPosition( Target.pos );

        local logText = common.GetRealDateTimeString()..": "..User.name.." tries to capture "..Target.name
        local coldLog = io.open("/home/nitram/logs/tying_log.txt","a");
        if (coldLog~=nil) then
            coldLog:write(logText.."\n");
            coldLog:close();
        end
        return;
    end
    -- check if target has moved
    if TargetPosList and not ( TargetPosList[Target.id] == Target.pos ) then
        common.InformNLS( User,
            "Dein Gefangener sollte still halten, damit du ihn fesseln kannst.",
            "Your captive should hold still so you can tie him up.");
        return;
    end

    -- tie up!
    local logText = common.GetRealDateTimeString()..": "..User.name.." has captured "..Target.name
    local coldLog = io.open("/home/nitram/logs/tying_log.txt","a");
    if (coldLog~=nil) then
        coldLog:write(logText.."\n");
        coldLog:close();
    end
    SourceItem:setData("tyingStatus", "tied");
    world:changeItem(SourceItem);
    if not foundEffectTarget then
        local Tying = LongTimeEffect(24,1);
        Target.effects:addEffect(Tying);
        Tying:addValue("Capturer",User.id);
--[[
        -- check left, right tool
        local item;
        for i=5,6 do
            item = Target:getItemAt(i);
            if item.id > 0 and item.id ~= 228 then
                world:createItemFromItem(item,Target.pos,true);
                common.InformNLS(Target,
                    "Du kannst nichts mehr in den H�nden halten.",
                    "You can't carry anything any more in your hands.");
            end
            item.id = 228;
            world:changeItem(item);
        end
]]
    end

    local foundTying, Tying = User.effects:find(26);
    if not foundTying then
        Tying = LongTimeEffect(26,1);
        User.effects:addEffect(Tying);
    end
    Tying:addValue("Captive",Target.id);

    local gText, eText
    if not foundEffectTarget then
        gText = "#me hat ein festes Seil um die H�nde.";
        eText = "#me has a tight rope around the hands.";
        common.InformNLS(User,
            "Der Gefangene folgt nun dir.",
            "Now the captive follows you.");
    else
        gText = "#me ist nun mit einem weiteren Seil gefesselt.";
        eText = "#me is now tied up with another rope.";
    end
    Target:talk(Character.say, gText, eText)
    if Target.effects:find(26) then
        common.InformNLS(Target,
            "Du kannst deinen Gefangenen nicht mehr halten und l�sst ihn frei.",
            "You can't hold your captive any more. You release him.");
        Target.effects:removeEffect(26);
    end
end

-- @return true if something was done
local function StrengthenKnot(User, Rope, TargetItem)
    local foundEffect, Tying = User.effects:find(26);
    if not foundEffect then
        Rope:setData("tyingStatus", "untied");
        return false;
    end

    if TargetItem then
        if TargetItem.id == 2760 then
            if TargetItem:getData("tyingStatus") == "tied" and Rope:getData("tyingStatus") == "untied" then
                local _, Captive = Tying:findValue("Captive");
                local Target = tying_capturer.IsCharidInRangeOf(Captive,User.pos,5);
                if Target then
                    local AttribOffset = tying_capturer.GetBestAttribOffset(User,Target,{"strength","dexterity"});
                    local Quality = math.min(600,120+math.random(25,35)*AttribOffset);
                    TargetItem.quality = math.min(2500,TargetItem.quality+(Quality*2));
                    world:changeItem(TargetItem);
                    common.InformNLS(User,
                        "Du verst�rkst den Knoten mit dem neuen Seil.",
                        "You strengthen the knot with the new rope.");
                    world:erase(Rope,1);
                    return true;
                end
            end
        end
    end
    return false;
end

--- Handles actions with a tying rope (data 1), like tightening, untie or handing the leading rope over
-- @return true if something was done
local function TyingRopeHandler(User, Rope, Target)

    local foundEffect, Tying = User.effects:find(26);
    if not foundEffect then
        Rope:setData("tyingStatus", "untied");
        return false;
    end

    -- check if User has tied up someone
    local foundCaptive, Captive = Tying:findValue("Captive");
    if foundCaptive then
        if Tying:findValue("logout") then
            common.InformNLS(User,
                "Du l�sst deinen Gefangenen frei.",
                "You release your captive.");
            User.effects:removeEffect(26);
            return true;
        end

        if not Target then
            Target = tying_capturer.IsCharidInRangeOf(Captive,User.pos,5);
            if Target then
                foundEffect, Tying = Target.effects:find(24);
                if foundEffect then
                    Tying:removeValue("escape");
                    Tying:removeValue("success");
                end
                User:talk(Character.say, "#me zieht das Seil straff.", "#me tightens the rope.")
                local rope = tying_capturer.GetRope(User);
                if rope then
                    rope.quality = math.max(104,rope.quality-60);
                    world:changeItem(rope);
                end
            end
            return true;
        end

        if Target.id == Captive then
            -- target is captive, so untie him
            local gText = GetRaceGenderText(0,Target);
            local eText = GetRaceGenderText(1,Target);
            User:talk(Character.say, "#me bindet "..gText.." los.", "#me unties "..eText..".")
            foundEffect, Tying = Target.effects:find(24);
            if foundEffect then
                Tying:removeValue("Capturer");
            end
            User.effects:removeEffect(26);
            return true;
        else
            -- other target, try to give him the leading rope
            foundEffect, Tying = Target.effects:find(26);
            if foundEffect then
                local foundValue, CaptiveTarget = Tying:findValue("Captive");
                if foundValue then
                    if Captive == CaptiveTarget then -- Target char has the same captive!
                        local CaptiveChar = tying_capturer.IsCharidInRangeOf(Captive,User.pos,5);
                        if CaptiveChar then
                            foundEffect, Tying = CaptiveChar.effects:find(24);
                            if foundEffect then
                                local foundCapturer, Capturer = Tying:findValue("Capturer");
                                if foundCapturer then
                                    if Capturer == User.id then -- User is leading capturer!
                                        Tying:addValue("Capturer", Target.id);
                                        local gText = GetRaceGenderText(0,Target);
                                        local eText = GetRaceGenderText(1,Target);
                                        User:talk(Character.say, "#me �bergibt das Seil an "..gText..".", "#me hands the rope to "..eText..".")
                                        common.InformNLS(User,
                                            "Der Gefangene folgt dir nun nicht mehr.",
                                            "Now the captive doesn't follow you any more.");
                                        common.InformNLS(Target,
                                            "Der Gefangene folgt nun dir.",
                                            "Now the captive follows you.");
                                        return true;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return false;
end

function M.UseItem(User, SourceItem, ltstate)

    if common.isBroken(SourceItem) then
        common.HighInformNLS(User,"Deine Seil ist kaputt.","Your rope is broken.")
        return
    end

    if SourceItem:getData("tyingStatus") == "tied" then
        -- it's a tying rope!
        local targetChar = common.GetFrontCharacter(User);
        if TyingRopeHandler(User, SourceItem, targetChar) then
            return;
        end
        if targetChar then
            -- actually nothing can happen anyway, mostly just for the error messages
            UseRopeWithCharacter(User, SourceItem, targetChar, ltstate);
            return;
        end
        return;
    end

    -- try to strengthen the knot (if User has tied up someone...)
    if StrengthenKnot(User, SourceItem, common.GetTargetItem(User, SourceItem)) then
        return;
    end

    -- try to tie up the frontChar!
    local frontChar = common.GetFrontCharacter(User);
    if frontChar then
        UseRopeWithCharacter(User, SourceItem, frontChar, ltstate);
        return;
    end

    -- noone infront ... perhaps climb down a well then or perhaps climb down a hole.
    climbing.climbDown(User);
end

function M.MoveItemBeforeMove( User, SourceItem, TargetItem )

    if SourceItem:getData("tyingStatus") == "tied" then

        common.InformNLS(User,
            "Du solltest das Seil fest in der Hand behalten. Damit ist jemand gefesselt.",
            "You should hold the rope tight in your hand. Someone is tied up with it.")
        return false;
    end

    return true;
end

return M

