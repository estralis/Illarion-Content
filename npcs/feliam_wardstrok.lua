--Name:        Feliam Wardstrok
--Race:        Halfling
--Town:        Trolls Bane
--Function:    Public trader
--Position:    x=-60 y=-82 z=0
--Facing:      South
--Last Update: 04/16/2006
--Update by:   Nitram

dofile("npc_trader_functions.lua")
require("npcs.base.functions")

function useNPC(user,counter,param)
    -- logToFile("start useNPC (faliam)");
    local value = useNPC_debug(user,counter,param)
    -- logToFile("end useNPC (faliam)");
    return value;
end

function useNPC_debug(user,counter,param)
    local lang=user:getPlayerLanguage();
    thisNPC:increaseSkill(1,"common language",100);
    if (lang==0) then thisNPC:talk(CCharacter.say, "Finger weg!") end
    if (lang==1) then thisNPC:talk(CCharacter.say, "Don't you touch me!") end
end

function initializeNpc()
    npcs.base.functions.InitTalkLists()
    InitItemLists()

    thisNPC:increaseSkill(1,"common language",100);
    --------------------------------------------- *** EDIT BELOW HERE ***--------------------------------------
    --            EPr ,ID  ,Am  ,SPr,SA  ,Qual ,Dura   ,Data,Catagory
    AddTraderItem(20  ,49  ,500 ,3  ,300 ,{3}  ,{33}   ,0   ,0       ); -- bread
    AddTraderItem(0   ,191 ,500 ,1  ,300 ,{3}  ,{33}   ,0   ,0       ); -- roll
    AddTraderItem(10  ,306 ,500 ,2  ,300 ,{3}  ,{33}   ,0   ,0       ); -- ham
    AddTraderItem(10  ,73  ,500 ,1  ,300 ,{3}  ,{33}   ,0   ,0       ); -- fish
    AddTraderItem(15  ,355 ,500 ,1  ,300 ,{3}  ,{33}   ,0   ,0       ); -- trout
    AddTraderItem(40  ,258 ,60  ,0  ,60  ,{5}  ,{88}   ,0   ,0       ); -- flail
    AddTraderItem(40  ,271 ,70  ,0  ,70  ,{5}  ,{88}   ,0   ,0       ); -- scythe
    AddTraderItem(40  ,126 ,30  ,0  ,30  ,{5}  ,{88}   ,0   ,0       ); -- sickle
    AddTraderItem(40  ,72  ,50  ,0  ,50  ,{5}  ,{88}   ,0   ,0       ); -- fishing rod
    AddTraderItem(3   ,259 ,100 ,0  ,500 ,{3}  ,{33}   ,0   ,0       ); -- grain
    AddTraderItem(3   ,534 ,100 ,0  ,500 ,{3}  ,{33}   ,0   ,0       ); -- onion seeds
    AddItemTrigger("onion");
    AddItemTrigger("zwiebel");
    AddTraderItem(3   ,291 ,100 ,0  ,500 ,{3}  ,{33}   ,0   ,0       ); -- cabbage
    AddItemTrigger("cabbage");
    AddItemTrigger("Kohl");

    npcs.base.functions.AddTraderTrigger("[Gg]reet","Hiho. Who are you?");
    npcs.base.functions.AddAdditionalTrigger("[Hh]ello");
    npcs.base.functions.AddAdditionalTrigger("[Hh]i");
    npcs.base.functions.AddAdditionalText("Hiho. How i can help you?");
    npcs.base.functions.AddTraderTrigger("[Hh]allo","Hiho! Wer bist du?");
    npcs.base.functions.AddAdditionalTrigger("[Gg]r[u�][s�]*");
    npcs.base.functions.AddAdditionalText("Hiho! Wie kann ich dir helfen?");
    npcs.base.functions.AddTraderTrigger("[Yy]ou.+[Tt]rader","Yes, I am a trader. What do you want?");
    npcs.base.functions.AddTraderTrigger("[DdIi][uh]r*.+[Hh]�ndler","Jap, ich bin H�ndler. Was brauchst du?");
    npcs.base.functions.AddTraderTrigger("[Ww]hat.+sell","I sell tools, food and seeds.");
    npcs.base.functions.AddTraderTrigger("[Ww]as.+verkauf","Ich verkauf' Werkzeug, Nahrung und Samen.");
    npcs.base.functions.AddTraderTrigger("[Ww]hat.+[Ff]ood","I sell bread and ham. Fish and trout.");
    npcs.base.functions.AddTraderTrigger("[Ww]as.+[Nn]ahrung","Ich verkauf' Brot und Schinken. Fische und Forellen");
    npcs.base.functions.AddTraderTrigger("[Ww]hat.+[Ss]eed","I sell grain and cabbage seeds.");
    npcs.base.functions.AddTraderTrigger("[Ww]as.+[Ss]amen","Ich verkauf' Getreide und Kohlsamen");
    npcs.base.functions.AddTraderTrigger("[Ww]hat.+[Tt]ool","I have flails, scythe, sickles, fishing rod.");
    npcs.base.functions.AddTraderTrigger("[Ww]as.+[Ww]erkzeug","Ich habe Dreschflegel, Sensen, Sicheln und Angeln. Interessiert?");
    npcs.base.functions.AddTraderTrigger("[Gg]oodbye","Have a good day. You are welcomed to come back.");
    npcs.base.functions.AddTraderTrigger("[Aa]uf.+[Bb]ald","Sch�nen Tag noch! Bis bald!");
    npcs.base.functions.AddAdditionalTrigger("[Bb]is.+[Bb]ald");
    npcs.base.functions.AddAdditionalText("Bis Bald! Ushara mit dir!");
    npcs.base.functions.AddTraderTrigger("[Bb]ye","Farewell.");
    npcs.base.functions.AddAdditionalTrigger("[Ff]arewell");
    npcs.base.functions.AddAdditionalText("Farewell. Ushara may be with you.");
    npcs.base.functions.AddTraderTrigger("[Ww]ho.+you?","I am "..thisNPC.name..", a farmer.");
    npcs.base.functions.AddTraderTrigger("[Ww]er.+[DdIi][uh]r*","Ich bin "..thisNPC.name..", Bauer.");
    npcs.base.functions.AddTraderTrigger("[hH]elp","'List your wares', 'I want to buy <number> <wares>', 'I want to buy a <ware>', 'I want to sell <number|a> <wares>', 'Price of ...','What do you pay for ...', 'What wares do you buy?'");
    npcs.base.functions.AddTraderTrigger("[Hh]ilfe","'Welche Waren verkauft ihr', 'Ich m�chte <Anzahl> <Ware> kaufen', 'Ich m�chte <Ware> kaufen', 'Ich m�chte <Anzahl> <Ware> verkaufen', 'Was ist der Preis von <Ware>','Was zahlt ihr f�r <Ware>', 'Was kauft ihr?'");

    TraderLang={"Gold","gold","Silber", "silver","Kupfer","copper","st�cke","pieces"};
    TraderMonths={"Elos","Tanos","Zhas","Ushos","Siros","Ronas","Bras","Eldas","Irmas","Malas","Findos","Olos","Adras","Naras","Chos","Mas"};

    RefreshTime={10000,40000};

    TraderCopper = 3000;


    TradSpeakLang={0,6};
    TradStdLang=0;
    --common language=0
    --human language=1
    --dwarf language=2
    --elf language=3
    --lizard language=4
    --orc language=5
    --halfling language=6
    --fairy language=7
    --gnome language=8
    --goblin language=9
    --ancient language=10

end

--------------------------------------------- *** DON'T EDIT BELOW HERE ***--------------------------------------

function nextCycle()  -- ~10 times per second
    -- logToFile("start nextCycle (feliam)");
    local value = nextCycle_debug()
    -- logToFile("end nextCycle (feliam)");
    return value;
end

function nextCycle_debug()
    if (TraderFirst == nil) then
        initializeNpc();
        npcs.base.functions.increaseLangSkill(TradSpeakLang)
        TraderStdCopper=TraderCopper;
        thisNPC.activeLanguage=TradStdLang;
    end
    TraderCycle();
    npcs.base.functions.SpeakerCycle();
end

function receiveText(texttype, message, originator)
    -- logToFile("start receiveText (maris)");
    local value = receiveText_debug(texttype, message, originator)
    -- logToFile("end receiveText (maris)");
    return value;
end

function receiveText_debug(texttype, message, originator)
    if npcs.base.functions.BasicNPCChecks(originator,2) then
        if (npcs.base.functions.LangOK(originator,TradSpeakLang)==true) then
            thisNPC.activeLanguage=originator.activeLanguage;
            Status,Values=SayPriceSell(originator, message)
            if (Status==0) then Status,Values=SayPriceBuy(originator, message) end
            if (Status==0) then Status,Values=ShowItemList(originator, message) end
            if (Status==0) then Status,Values=Selling(originator, message) end
            if (Status==0) then Status,Values=Buying(originator, message) end
            if (Status==0) then Status,Values=npcs.base.functions.TellDate(originator, message, TraderMonths) end
            if (Status==0) then npcs.base.functions.TellSmallTalk(message) end

            ----------------------------EDIT BELOW HERE-----------------------------------
            if (Status==1) then -- Verkauf von mehreren Items erfolgreich // Selling of multible items succeed
                gText="Ihr m�chtet "..Values[1].." "..world:getItemName(Values[2],0).." kaufen? Bitte sehr, macht dann"..MoneyText(0,Values[3],Values[4],Values[5],TraderLang)..".";
                eText="You want "..Values[1].." "..world:getItemName(Values[2],1).."? Here you are, that makes"..MoneyText(1,Values[3],Values[4],Values[5],TraderLang)..".";
            elseif (Status==2) then -- Item kann wegen Platzmangel nicht erstellt werden // Item can't created, cause of lag of space
                gText="Tut mir leid, aber Ihr habt nicht genug Platz in Eurem Inventar.";
                eText="Sorry, you do not have enough space in your inventory.";
            elseif (Status==3) then -- Nicht genug Geld um das Item zu bezahlen // not enough money to buy the item
                gText="Kommt wieder wenn ihr genug Geld habt!";
                eText="Come back when you have enough money!";
            elseif (Status==4) then -- Item ausverkauft // item out of stock
                gText="Tut mir leid. Ich habe das im Moment nicht. Kommt doch bitte sp�ter wieder.";
                eText="I am sorry, I don't have this currently. Come back later.";
            elseif (Status==5) then -- Item wird nicht verkauft // item
                gText="Tut mir Leid. Ich verkaufe das nicht.";
                eText="Sorry, I do not sell that item.";
            elseif (Status==6) then -- Verkauf eines einzelnen Items erfolgreich // Selling of a single item succeed
                gText=npcs.base.functions.GenusSel(Values[2],"Ein","Eine","Ein").." "..world:getItemName(Values[2],0).." ist es, was ihr kaufen wollt? Bitte sehr, das macht"..MoneyText(0,Values[3],Values[4],Values[5],TraderLang)..".";
                eText="You want a "..world:getItemName(Values[2],1).."? Here you are, that makes"..MoneyText(1,Values[3],Values[4],Values[5],TraderLang)..".";
            elseif (Status==7) then -- Verkaufspreis Ansage f�r ein Item // selling price announcement for an item
                gText=npcs.base.functions.GenusSel(Values[1],"Ein","Eine","Ein").." "..world:getItemName(Values[1],0).." kostet"..MoneyText(0,Values[2],Values[3],Values[4],TraderLang)..".";
                eText="The "..world:getItemName(Values[1],1).." costs"..MoneyText(1,Values[2],Values[3],Values[4],TraderLang)..".";
            elseif (Status==8) then -- Einkaufspreis Ansage f�r ein Item // buying price announcement for an item
                gText=npcs.base.functions.GenusSel(Values[2],"Ein","Eine","Ein").." "..world:getItemName(Values[2],0).." w�re mir"..MoneyText(0,Values[3],Values[4],Values[5],TraderLang).." wert.";
                eText="I would pay"..MoneyText(1,Values[3],Values[4],Values[5],TraderLang).." for "..Values[1]..world:getItemName(Values[2],1);
            elseif (Status==9) then -- Einkauf von mehreren Items erfolgreich // Buying of multible items succeed
                gText="Ihr wollt "..Values[1].." "..world:getItemName(Values[2],0).." verkaufen? Ich gebe euch"..MoneyText(0,Values[3],Values[4],Values[5],TraderLang)..".";
                eText="You want to sell "..Values[1].." "..world:getItemName(Values[2],1).."? I give you"..MoneyText(1,Values[3],Values[4],Values[5],TraderLang)..".";
            elseif (Status==10) then -- Item das gekauft werden soll nicht vorhanden // item that should be buyed is not aviable
                gText="Kommt wieder wenn ihr das habt!";
                eText="Come back when you have that!";
            elseif (Status==11) then -- H�ndler hat nicht genug Geld // trader don't have enough money
                gText="Tut mir leid. Ich kann das nicht kaufen. Ich habe nicht genug Geld.";
                eText="Sorry, I cannot buy that. I do not have enough money.";
            elseif (Status==12) then -- H�ndler kauft das Item nicht // trader didn't buy the item
                gText="So etwas kaufe ich nicht. Tut mir leid.";
                eText="Sorry, I do not buy that item.";
            elseif (Status==13) then -- Einkauf eines einzelnen Items erfolgreich // Buying of a single item succeed
                gText=npcs.base.functions.GenusSel(Values[2],"Ein","Eine","Ein").." "..world:getItemName(Values[2],0).." ist es, was ihr verkaufen m�chtet? Ich gebe euch"..MoneyText(0,Values[3],Values[4],Values[5],TraderLang)..".";
                eText="You want to sell a "..world:getItemName(Values[2],1).."? I give you"..MoneyText(1,Values[3],Values[4],Values[5],TraderLang)..".";
            elseif (Status==14) then -- Liste der Waren die der NPC verkauft ist nicht leer // List of the wares the NPC sells, is not empty
                gText="Ich verkaufe Werkzeug, Nahrung und Samen.";
                eText="I sell tools, food and seeds.";
            elseif (Status==15) then -- Liste der Waren die der NPC verkauft ist leer // List of the wares the NPC sells, is empty
                gText="Ich verkaufe nichts.";
                eText="I sell nothing.";
            elseif (Status==16) then -- Liste der Waren die der NPC kauft ist nicht leer // List of the wares the NPC buys, is not empty
                gText="Ich kaufe Nahrung und Samen.";
                eText="I buy food and seeds.";
            elseif (Status==17) then -- Liste der Waren die der NPC kauft ist leer // List of the wares the NPC buys, is empty
                gText="Ich kaufe nichts.";
                eText="I buy nothing.";
            elseif (Status==18) then
                gText="Es ist der "..Values[1]..". Tag des Monates "..Values[2].." im Jahre "..Values[3]..".";
                local seleced=math.random(1,2)
                if (seleced==1) then
                    eText="It's day "..Values[1].." of "..Values[2].." of the year "..Values[3]..".";
                elseif (seleced==2) then
                    eText="It's the "..npcs.base.functions.EnglDigit(Values[1]).." of "..Values[2].." of the year "..Values[3]..".";
                end
            end

            if (Status~=0) then
                outText=npcs.base.functions.GetNLS(originator,gText,eText);
                thisNPC:talk(CCharacter.say,outText);
            end

            ---------------------------------- DON'T EDIT BELOW HERE ------------------------------
            if (string.find(message,"[sS]tatus")~=nil and originator:isAdmin()==true) then
                thisNPC:talk(CCharacter.say,"Copper="..TraderCopper ..", next delivery: "..nextDelivery.."cycCount:"..cycCount);
                statusString="Wares: ";
                for itnCnt=1,table.getn(TraderItemId) do
                    if string.len(statusString)+string.len(world:getItemName(TraderItemId[itnCnt],1))>240 then    -- line too long
                        originator:inform(statusString);                     -- say everything until here
                        statusString="";
                    end
                    statusString=statusString..world:getItemName(TraderItemId[itnCnt],1).."="..TraderItemNumber[itnCnt]..", ";
                end
                originator:inform(statusString);
            end
            if (string.find(message,"[Rr]efill")~=nil and originator:isAdmin()==true) then
                for itnCnt=1,table.getn(TraderItemId) do
                    refill(itnCnt);
                    if (TraderCopper<TraderStdCopper) then TraderCopper=TraderStdCopper end
                end
            end -- string find buy/sell/list...
            thisNPC.activeLanguage=TradStdLang;
        else
            if (verwirrt==false) then
                gText="#me sieht dich leicht verwirrt an";
                eText="#me looks at you a little confused";
                outText=npcs.base.functions.GetNLS(originator,gText,eText);
                thisNPC:talk(CCharacter.say,outText);
                verwirrt=true;
            end
        end
    end
end--function

function lookAtNpc(Char, mode)
    if initLook==nil then
        output={};
        output[0]="Ein kleiner Mann, kleiner als ein Zwerg, mit gewaltigem Strohhut, der ihn vor der Sonne sch�tzt. Aus einer Tasche auf seinem R�cken schauen einige Bauernswerkzeuge hervor. Er macht wohl grad Pause.";
        output[1]="A small man, smaller than a dwarf but with a giant hat protecting him of the sun. Peeking out of a bag around his shoulder you can see some farming tools. He seems to be taking a break.";
        initLook=1;
    end
    lang=Char:getPlayerLanguage();
    Char:sendCharDescription( thisNPC.id , output[lang] );
end
