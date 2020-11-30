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

-- UPDATE items SET itm_script='item.skull' WHERE itm_id = 2038;
-- UPDATE items SET itm_script='item.skull' WHERE itm_id = 2039;

local M = {}

local function BlowOutFlames(User, flame)

    for xx = 986, 998 do
        for yy = 211, 235 do
            local positionFlame = position(xx, yy, 0)
            local checkFlame = world:getItemOnField(positionFlame)
            if checkFlame.id == flame then
                world:erase(checkFlame, checkFlame.number)
                world:makeSound(13, User.pos)
                if User:getQuestProgress(668) ~= 1 then
                    User:setQuestProgress(668, 1)
                end
            end
        end
    end
end

local function SpawnSpider(User, skullItem)

    -- skip if already tripped in the last 5 minutes
    local serverTime = world:getTime("unix")
    local trippingTime = skullItem:getData("tripping_time")

    if (trippingTime ~= "" and ((tonumber(trippingTime) + 300) > serverTime)) then
        User:inform("Du findest nichts in diesem Totensch�del.",
            "You find nothing inside this skull.")
        return
    end
    -- safe tripping time
    skullItem:setData("tripping_time", serverTime)
    world:changeItem(skullItem)

    local monList = {191, 192, 193, 211, 222} -- Dread Spider, Pit Servant, Tarantula, Fire Spider, Juvenile Gynk Spider
    local monID = monList[math.random(1, #monList)]
    for i = 1, math.random(1, 2) do -- random count
    local monPos = common.getFreePos(skullItem.pos, 2) -- radius 2 around skull
    world:createMonster(monID, monPos, -20)
    world:gfx(41, monPos) -- swirly
    end
    User:inform("Schlechte Wahl, Abenteuerer! Etwas springt aus dem Totensch�del heraus und greift dich an.",
        "Wrong choice traveller! Something hops out of the skull and attacks you.")
end

function M.UseItem(User, SourceItem)

    local advantureslist = {}

    -- Evilrock skulls
    local skullSourceItemPos = {position(989, 247, 0), position(990, 241, 0), position(997, 226, 0)}
    local typoOfFlame={359, 360, 372}

    local adventurers = world:getPlayersInRangeOf(User.pos, 25)
    advantureslist[User.name] = adventurers
    for i,player in ipairs(advantureslist[User.name]) do
        player:setQuestProgress(689,0)
    end

    for i = 1, #skullSourceItemPos do
        if (SourceItem.pos == skullSourceItemPos[i]) then
            local flame = typoOfFlame[i]
            BlowOutFlames(User, flame)
            if User:getQuestProgress(668) ~= 1 then
                User:inform("Nichts passiert als du die Finger in die Augenh�hlen des Sch�dels reinsteckst.", "Nothing happens as you put your fingers into the eye holes of the skull.")
            end
            User:setQuestProgress(668, 0)
        end
    end

    -- Spidercave skulls, scavenger hunt
    local questStep = User:getQuestProgress(521)

    if questStep == 0 and SourceItem.pos == position(905, 515, -6) then
        User:inform("Du h�rst eine Stimme in deinen Gedanken 'Suche und finde mein Zauberauge der Pein! Der n�chste Sch�del auf dem Pfade mit einem Hinweis ist nahe der b�sen Witwe Gorgophone zu finden!'",
                    "You hear a voice in your head 'Seek and ye shall find, my Magical Torturous Eye! The next skull on the path with a clue is found near the evil widow, Gorgophone!'")
        User:setQuestProgress(521, 1)

    elseif questStep == 1 and SourceItem.pos == position(849, 498, -6) then
        User:inform("Du h�rst eine Stimme in deinen Gedanken 'Das Zauberauge der Pein ist weggekullert und wurde von einer spinne mitgenommen. Alles was ich h�rte ist, dass es in einem Sch�del weit von hier versteckt wurde, nahe eines roten Brutb�ndels im Nordosten der H�hle.'",
                    "You hear a voice in your head 'The Magical Torturous Eye rolled away from me and was stolen by a spider. Last I heard it was being secreted away in a skull far away from here, near a red egg sac all alone in the North East somewhere.'")
        User:setQuestProgress(521, 2)

    elseif questStep == 2 and SourceItem.pos == position(923, 451, -6) then
        User:inform("Du h�rst eine Stimme in deinen Gedanken 'Ich war im Besitz des Zauberauges der Pein f�r eine kurze Zeit. Die Spinne r�umt es immer wieder um. Sie trug es in den S�dwesten zu einem gro�en T�mpel, das habe ich gesehen.'",
                    "You hear a voice in your head 'I did have the Magical Torturous Eye for but a short time. The spider keeps moving it around and around. It headed Southwest last I saw to a large lake.'")
        User:setQuestProgress(521, 3)

    elseif questStep == 3 and SourceItem.pos == position(837, 524, -6) then
        User:talk(Character.say, "#me wird davon �berrascht, dass bei Ber�hrung mehrere Rubine aus dem Totensch�del kullern, leider ist keiner davon das gesuchte Zauberauge der Pein.",
                                "#me becomes surprised, looking into the eyes of the skull several rubies come tumbling out, but, sadly, none is the Magical Torturous Eye.")
        common.CreateItem(User, 46, 25, 333, nil) -- 25 rubies
        User:inform("Ein Pfeil ist in die Seite des Sch�dels geritzt der nach Osten zeigt. Darunter ist eine gro�e Pf�tze und viele Totensch�del abgebildet.",
                    "An arrow can be seen scratched into the side of the skull, pointing east of here. Underneath is a large puddle of water or mud and many skulls on the drawing.")
        User:setQuestProgress(521, 4)

    elseif questStep == 4 and SourceItem.pos == position(928, 536, -6) then
        User:inform("Du h�rst eine Stimme in deinen Gedanken 'Es war hier aber jetzt nicht mehr. Schau dort wo du hereingkommen bist, hofentlich ist es immer noch dort.'",
                    "You hear a voice in your head 'It's gone. It was here, but no longer. Look back where you came in, hopefully it is still there.'")
        User:setQuestProgress(521, 5)

    elseif questStep == 5 and SourceItem.pos == position(925, 521, -6) then
        User:inform("Jemand hat einen Pfeil in den Sch�del geritzt, der nach Norden zeigt. Auch das Bild eines Totenkopfs wurde eingeritzt, der im Wasser liegt.",
                    "An arrow has been carved by someone on the side of the skull, pointing to the north. There is a picture of a skull sitting in water.")
        User:setQuestProgress(521, 6)

    elseif questStep == 6 and SourceItem.pos == position(899, 503, -6) then
        User:inform("Als du den Sch�del ber�hrst beginnen dessen Augen gr�n zu gl�hen und eine Giftwolke steigt auf. Eine k�rperlose Stimme spricht 'Ein Tarantel hat es mitgenommen und im Nordwesten versteckt. In einem Sch�del nahe eines Warnschildes.'",
                    "As you touch the skull, the eyes glow green and poison rises from them. A disembodied voice says 'A tarantula has taken it somewhere off in the Northwest. The skull lays near an evil sign.'")
        local cloud = world:createItemFromId(372, 1, SourceItem.pos, true, 700, nil) -- poison cloud
        cloud.wear = 1
        world:changeItem(cloud)
        User:setQuestProgress(521, 7)

    elseif questStep == 7 and SourceItem.pos == position(839, 455, -6) then
        User:inform("Du h�rst eine Stimme in deinen Gedanken 'Ich sah eine Spinne etwas wegtragen, sie kann nicht weit sein! Sie muss in der N�he sein. Halte Ausschau nach Schlamm, da ihre Beine bedeckt davon waren.'",
                    "You hear a voice in your head 'I saw a spider scrabble off with something, it can't have gotten far! Must be near here somewhere. Look where there is mud as its feet were covered in the stuff.'")
        User:setQuestProgress(521, 8)

    elseif questStep == 8 and SourceItem.pos == position(845, 464, -6) then
        User:inform("Eine Spinne huscht aus dem Sch�del heraus und greift dich an, nachdem sie einen gro�en, rot gl�nzenden Stein in dem Totensch�del versteckt.",
                    "A spider scurries out of the skull and attacks you after pushing a bright stone that flashes red back into the skull for safekeeping.")
        local monPos = common.getFreePos(SourceItem.pos, 3 ); -- radius 3 around skull
        world:createMonster(262, monPos, -40) -- Soulpain
        world:gfx(41, monPos) -- swirly
        User:setQuestProgress(521, 9)

    elseif questStep == 9 and SourceItem.pos == position(845, 464, -6) then
        User:inform("Du holst einen gro�en roten Edelstein aus dem Totensch�del hervor. Es ist das Zauberauge der Pein!",
                    "You retrieve a large red gem from the skull. It is the Torturous Eye!")
        common.CreateItem(User, 3521, 1, 333, {["gemLevel"] = 1}) -- 1 latent ruby
        User:setQuestProgress(521, 10)

    elseif questStep == 10 and SourceItem.pos == position(905, 515, -6) then
        User:inform("Du h�rst eine Stimme in deinen Gedanken 'Mein Zauberauge der Pein, du hast es gefunden! Behalte und beh�te es, ich hab ja noch ein anderes f�r mich selbst.'",
                    "You hear a voice in your head 'My Magical Torturous Eye, you found it! Keep it though, after all I have another one left for myself.'")
        User:setQuestProgress(521, 11)

    end

    -- Spidercave skulls, scavenger hunt
    -- as long as the quest is in progress, spawns some spiders when wrong skull is chosen
    if questStep > 0 and questStep < 10 then
        local skullPos = {
            position(844, 495, -6),
            position(856, 505, -6),
            position(919, 457, -6),
            position(842, 534, -6),
            position(923, 539, -6),
            position(925, 542, -6),
            position(923, 543, -6),
            position(927, 544, -6),
            position(892, 506, -6),
            position(862,451,-6)
        }
        for i = 1, #skullPos do
            if (SourceItem.pos == skullPos[i]) then
                SpawnSpider(User, SourceItem)
                return
            end
        end
    end

    -- Akaltut Dungeon / drow dungeon
    if SourceItem.pos == position(482, 840, -9) then
        User:inform("Du hast weise gew�hlt. Dir wird Zugang zu Akaltuts Reich gew�hrt.",
                    "You have chosen wisely and have earned passage into Akaltut's realm.")
        world:gfx(41, User.pos)
        User:warp(position(477, 849, -9)) -- right location
        world:gfx(41, User.pos)

    elseif SourceItem.pos == position(482, 837, -9) then
        User:inform("Du hast schlecht gew�hlt und ein Schlag trifft deine Hand. Du f�hlst dich sch�chlich und wird auf magischem Weg aus dem Dungeon katapultiert.",
                    "You have chosen poorly and feel a jolt hit your hand, making you feel poorly and sending you magically outside the dungeon.")
        User:increaseAttrib("hitpoints", -(User:increaseAttrib("hitpoints", 0) / 3)) -- lose 1/3 HP
        world:gfx(41, User.pos)
        User:warp(position(454, 770, 0)) -- throw character out
        world:gfx(41, User.pos)

    elseif SourceItem.pos == position(478, 834, -9) then
        User:inform("Du hast schlecht gew�hlt und ein fauliger Gestank wogt dir aus dem Sch�del entgegen.",
                    "You have chosen poorly and a putrid stench billows out of the skull towards you.")
        world:gfx(8, SourceItem.pos) -- poison ball gfx
        local cloud = world:createItemFromId(372, 1, User.pos, true, 700, nil) -- poison cloud
        cloud.wear = 1
        world:changeItem(cloud)

    elseif SourceItem.pos == position(477, 834, -9) then
        User:inform("Du hast schlecht gew�hlt und ein Paar Dolche schiessen pl�tzlich aus den Augenh�hlen des Sch�dels und landen schmerzhaft in deiner Brust.",
                    "You have chosen poorly and a pair of daggers is suddenly launched from the eye sockets of the skull, landing painfully in your chest.")
        world:gfx(20, SourceItem.pos) -- dagger gfx
        User:increaseAttrib("hitpoints", -1000) -- tbd: start an lte to deal out two hits instead

    elseif SourceItem.pos == position(479, 834, -9) then
        User:inform("Du hast schlecht gew�hlt und als die Kiefer auf und zuklappen kannst du gerade noch ausweichen, bevor giftige Pfeile herausschie�en. Sie landen harmlos auf den Boden.",
                    "You have chosen poorly and as the jaw starts clicking up and down you scurry away just in time as poisonous darts shoots out, harmlessly landing on the floor.")
        world:gfx(15, SourceItem.pos) -- distance gfx
        -- nothing happens

    elseif SourceItem.pos == position(480, 834, -9) then
        User:inform("Du hast schlecht gew�hlt und der Sch�del erhebt sich in die Luft und beginnt sich schnell zu drehen. Er schiesst Funken und Flammen ind den Raum und jeder erleidet Verbrennungen.",
                    "You have chosen poorly and the skull floats off the table and starts spinning very fast, shooting out sparks and flames. Everyone in the room is burned.")
        world:erase(world:getItemOnField(position(480, 834, -9)), 1) --remove skull, scheduled/mapitemreset will clean up
        for xx = 474, 482 do --set room on fire
            for yy = 834, 844 do
                local positionFlame = position(xx, yy, -9)
                world:createItemFromId(359, 1, positionFlame, true, 500, nil)
            end
        end

    elseif SourceItem.pos == position(482, 838, -9) then
        User:inform("Du hast schlecht gew�hlt und der Totensch�del explodiert. Splitter fliegen durch den Raum und verwunden alle Anwesenden.",
                    "You have chosen poorly and the skull suddenly explodes, sending sharp projectiles everywhere in the room, causing great harm to everyone.")
        world:gfx(44, position(482, 838, -9)); -- fireflame gfx
        world:erase(world:getItemOnField(position(482, 838, -9)), 1) --remove skull, scheduled/mapitemreset will clean up
        for xx = 474, 482 do --hit everyone in room
            for yy = 834, 844 do
                if world:isCharacterOnField(position(xx, yy, -9)) then
                    local char = world:getCharacterOnField(position(xx, yy, -9));
                    if char:getType() == Character.player then
                        char:increaseAttrib("hitpoints", -1000)
                        char:inform("Du wirst von Knochensplittern getroffen",
                                    "You are hit by bone splinters.")
                    end
                end
            end
        end

    elseif SourceItem.pos == position(482, 839, -9) then
        User:inform("Du hast schlecht gew�hlt und grelles Licht strahlt pl�tzlich aus jeder �ffnung des Totensch�dels. Du bist zeitweise geblendet.",
                    "You have chosen poorly and a bright light suddenly flashes from every hole in the skull, blinding you temporarily.")
        world:gfx(31, SourceItem.pos) -- bright star gfx
        local foundEffect, myEffect = User.effects:find(100); -- perception debuff
        if foundEffect then
            myEffect.nextCalled = 5 * 600;
        else
            local myEffect = LongTimeEffect(100, 5 * 600) --5min
            User.effects:addEffect(myEffect)
        end

    elseif SourceItem.pos == position(482, 841, -9) then
        User:inform("Du hast schlecht gew�hlt und wirst pl�tzlich in eine dunkle Wolke geh�llt. Als sich diese endlich aufl�st, f�hlst du dich geschw�cht. Hoffentlich legt sich das bald.",
                    "You have chosen poorly and are suddenly enshrouded in a dark cloud. When it finally dissipates, you can feel a loss in stamina and hope to recover quickly.")
        world:gfx(32, SourceItem.pos) -- red stuff falls gfx
        local foundEffect, myEffect = User.effects:find(101); -- constitution debuff
        if foundEffect then
            myEffect.nextCalled = 8 * 600;
        else
            local myEffect = LongTimeEffect(101, 8 * 600) --8min
            User.effects:addEffect(myEffect)
        end
    end
end

return M

