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
-- UPDATE items SET itm_script='item.id_2620_language_book' WHERE itm_id = 2620;

local common = require("base.common")
local lookat = require("base.lookat")
local id_266_bookshelf = require("item.id_266_bookshelf")

local M = {}

local function Learning(User,Value,Skillname)
    local MC=User:getMentalCapacity();
    if (MC>100) then
        return false
    else
        User:setMentalCapacity(2100);
        local Skill=User:getSkill(Skillname);
        User:increaseSkill(Skillname,Value-Skill);
        return true
    end
end

local function GetSkillName(code)
    if (code==0) then return Character.ancientLanguage;
    elseif (code==1) then return Character.commonLanguage;
    elseif (code==2) then return Character.humanLanguage;
    elseif (code==3) then return Character.dwarfLanguage;
    elseif (code==4) then return Character.elfLanguage;
    elseif (code==5) then return Character.orcLanguage;
    elseif (code==6) then return Character.halflingLanguage;
    elseif (code==7) then return Character.lizardLanguage;
    end
end

local function GetLanguage(code,engl)
    if (code==0) then return ( engl and "ancient language" or "Altert�mlichen Sprache" );
    elseif (code==1) then return ( engl and "common language" or "Gemeinsammen Sprache" );
    elseif (code==2) then return ( engl and "human language" or "Sprache der Menschen" );
    elseif (code==3) then return ( engl and "dwarf language" or "Sprache der Zwerge" );
    elseif (code==4) then return ( engl and "elf language" or "Sprache der Elfen" );
    elseif (code==5) then return ( engl and "orc language" or "Sprache der Orks" );
    elseif (code==6) then return ( engl and "halfling language" or "Sprache der Halblinge" );
    elseif (code==7) then return ( engl and "lizard language" or "Sprache der Echsen" );
    elseif (code==8) then return ( engl and "goblin language" or "Sprache der Goblins" );
    elseif (code==9) then return ( engl and "fairy language" or "Sprache der Feen" );
    elseif (code==10) then return ( engl and "gnome language" or "Sprache der Gnome" );
    end
end

local function GetDifficulty(code)
    if (code==0) then return 13;
    elseif (code==1) then return 2;
    elseif (code==2) then return 5;
    elseif (code==3) then return 5;
    elseif (code==4) then return 8;
    elseif (code==5) then return 2;
    elseif (code==6) then return 6;
    elseif (code==7) then return 10;
    elseif (code==8) then return 5;
    elseif (code==9) then return 7;
    elseif (code==10) then return 5;
    end
end

function M.UseItem(User, SourceItem, ltstate)
    if SourceItem:getData("langcode") == "" then
        SourceItem:setData("langcode", 11)
    end

    local book = SourceItem:getData("book")
    if book ~= "" then
        if id_266_bookshelf.bookList[book] ~= nil then
            User:sendBook(id_266_bookshelf.bookList[book].bookId)
        end
    end

    local langcode = math.floor(tonumber(SourceItem:getData("langcode"))/10);
    local modecode = tonumber(SourceItem:getData("langcode")) - (langcode * 10);

    if (modecode == 2) then
        if (User:getSkill(Character.ancientLanguage) < 60) then return end
        if ( ltstate == nil or ltstate == Action.success ) then
            --User:warp(position(-243,-340,-3));
        elseif ( ltstate == Action.none ) then
            User:startAction( 100,53, 4, 0, 0);
            User:talk(Character.say, "#me beginnt in einem Buch zu lesen.", "#me starts reading in a book.")
        elseif ( ltstate == Action.abort ) then
            User:talk(Character.say, "#me h�rt auf in dem Buch zu lesen.", "#me stops reading in the book.")
        end
        return
    end

    local Skillname = GetSkillName(langcode,true);

    local Skill=User:getSkill(Skillname);
    if (Skill==0 and modecode==1) then
        User:increaseSkill(Skillname,1);
        SourceItem:setData("langcode", tonumber(SourceItem:getData("langcode"))-1);
        world:changeItem(SourceItem);
    end

    if (User:increaseAttrib("intelligence",0) < GetDifficulty(langcode)) then
        common.InformNLS(User,"Du verstehst nichts von dem, was hier steht","You understand nothing from the things, written in this book");
    end

    if (Skill<1) then
        common.InformNLS(User,"Du verstehst nichts von dem, was hier steht","You understand nothing from the things, written in this book");
    elseif (Skill>59) then
        common.InformNLS(User,"Du findest nichts was du noch nicht weist, in diesem Buch","You find nothing new in this book");
    --[[ Broken before 2010....
    else
        if (Counter ==1) then
            if (Skill<15) then
                if Learning(User,15,Skillname) then
                    common.InformNLS(User,"Du lernst erste Grundlagen der "..GetLanguage(langcode,false),"You learn first basics of the "..Skillname);
                else
                    common.InformNLS(User,"Du kannst dich nicht auf dieses schwere Thema konzentrieren","You can't concentrate on this topic");
                end
            else
                common.InformNLS(User,"Das was hier steht kannst du schon","The things written here, you know allready");
            end
        elseif (Counter==2) then
            if (Skill<30) then
                if (Skill>14) then
                    if Learning(User,30,Skillname) then
                        common.InformNLS(User,"Du lernst die Grundlegenden Vokabeln der Sprache","You learn the basic words of the language");
                    else
                        common.InformNLS(User,"Du kannst dich nicht auf dieses schwere Thema konzentrieren","You can't concentrate on this topic");
                    end
                else
                    common.InformNLS(User,"Was hier steht, verstehst du noch nicht","You don't understand the things written down on this page");
                end
            else
                common.InformNLS(User,"Das was hier steht kannst du schon","The things written here, you know allready");
            end
        elseif (Counter==3) then
            if (Skill<45) then
                if (Skill>29) then
                    if Learning(User,45,Skillname) then
                        common.InformNLS(User,"Du lernst die Grammatik der Sprache.","You learn the grammatics of the "..Skillname..".");
                    else
                        common.InformNLS(User,"Du kannst dich nicht auf dieses schwere Thema konzentrieren","You can't concentrate on this topic");
                    end
                else
                    common.InformNLS(User,"Was hier steht, verstehst du noch nicht","You don't understand the things written down on this page");
                end
            else
                common.InformNLS(User,"Das was hier steht kannst du schon","The things written here, you know allready");
            end
        elseif (Counter==4) then
            if (Skill>30) then
                if Learning(User,60,Skillname) then
                    common.InformNLS(User,"Du lernst die letzten Feinheiten der Sprache.","You learn the last intricacies of the "..Skillname..".");
                else
                    common.InformNLS(User,"Du kannst dich nicht auf dieses schwere Thema konzentrieren","You can't concentrate on this topic");
                end
            else
                common.InformNLS(User,"Was hier steht, verstehst du noch nicht","You don't understand the things written down on this page");
            end
        end
    ]]
    end

    local frontItem = common.GetFrontItem(User);

    if frontItem and ((frontItem.id == 266) or (frontItem.id == 267)) then
        world:erase(SourceItem,1)
        return;
    end
end

function M.LookAtItem(User,Item)
    if Item:getData("langcode") == "" then
        Item:setData("langcode", 11)
    end

    local langcode = math.floor(tonumber(Item:getData("langcode"))/10);
    local modecode = tonumber(Item:getData("langcode")) - (langcode * 10);
    if (modecode == 2) then
        lookat.SetSpecialName(Item, "Buch des Ephraim","Book of Ephraim");
    else
        lookat.SetSpecialName(Item, "Lehrbuch der "..GetLanguage(langcode,false),"Textbook of the "..GetLanguage(langcode,true));
    end

    local book = Item:getData("book")
    if book ~= "" then
        if book ~= nil then
            if id_266_bookshelf.bookList[book] ~= nil then
            lookat.SetSpecialName(Item,id_266_bookshelf.bookList[book].german,id_266_bookshelf.bookList[book].english)
            end
        end
    end
    return lookat.GenerateLookAt(User, Item, lookat.NONE)
end

return M
