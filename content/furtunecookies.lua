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
local M = {}

function M.cookie(User)
    local luck=math.random(1,43);
    local germText;
    local englText;
    if (luck==1) then
       germText="Nutze dein Gehirn bevor es verk�mmert.";
        englText="You will have good luck and overcome many hardships.";
    elseif (luck==2) then
        germText="Man soll sein Licht nicht unter den Scheffel stellen.";
        englText="Your greatest fortune is your friends and family.";
    elseif (luck==3) then
        germText="Was kommen soll, das kommt nur dann, wenn man es nicht verhindern kann.";
        englText="Romance will come into your life this year in unexpected ways.";
    elseif (luck==4) then
        germText="Jetzt ist die Zeit gekommen den Verstand zu benutzen.";
        englText="Find beauty in ordinary things, and blessed you will be.";
    elseif (luck==5) then
        germText="Strebe nicht an, was du meinst erreichen zu k�nnen, sondern was du wirklich willst!";
        englText="Anything worth doing can be done.";
    elseif (luck==6) then
        germText="Erfolg hat nur, wer etwas tut, w�hrend er auf den Erfolg wartet.";
        englText="Love is like paint, it makes things beautiful when you spread it, but it will dry up if you don't use it.";
    elseif (luck==7) then
        germText="Das Schicksal meint es gut mit dir.";
        englText="Your fortune is as sweet as you.";
    elseif (luck==8) then
        germText="Der Anfang ist die H�lfte des Ganzen.";
        englText="Pursue that thought in the back of your mind.";
    elseif (luck==9) then
        germText="Sei dir selbst dein bester Freund.";
        englText="Be your own best friend.";
    elseif (luck==10) then
        germText="Ehre die Vergangenheit, aber lebe f�r den Augenblick.";
        englText="Do not be overly judgmental of your loved one's intentions or actions.";
    elseif (luck==11) then
       germText="Wichtige Dinge nur halb zu tun ist wertlos; denn meistens ist es die andere H�lfte die z�hlt.";
       englText="He who hurries can not walk with dignity.";
    elseif (luck==12) then
        germText="Es geh�rt mehr Mut dazu, seine Meinung zu �ndern, als ihr treu zu bleiben.";
        englText="The smart thing to do is to start trusting your intuition.";
    elseif (luck==13) then
        germText="Es ist schwer versch�ttetes Wasser wieder zu sammeln.";
        englText="The shortest distance between two people is a smile.";
    elseif (luck==14) then
        germText="Die Ruhe ist die nat�rliche Stimmung eines wohlgeregelten, mit sich einigen Geistes.";
        englText="You can't have everything. Where would you put it?";
    elseif (luck==15) then
        germText="Wor�ber du im Zweifel bist, das tue nicht.";
        englText="Be ashamed to die until you have achieved some victory for humanity.";
    elseif (luck==16) then
        germText="Sage niemals nie, denn du wei�t nie was auf Dich zukommt.";
        englText="Paradise is a belief not a place.";
    elseif (luck==17) then
        germText="Der gl�cklichste Mensch ist der, der Tr�ume verwirklichen kann.";
        englText="Ideas are funny little things. They won't work unless you do.";
    elseif (luck==18) then
        germText="Wer einen Fehler gemacht hat und ihn nicht korrigiert, begeht einen zweiten.";
        englText="Answers without evidence are useless.";
    elseif (luck==19) then
        germText="Bist du heute der, der du einmal sein wolltest, als du noch jung warst?";
        englText="Follow the dreams you had as a child.";
    elseif (luck==20) then
        germText="Besiege deine �ngste oder sie werden dich besiegen.";
        englText="Conquer your fears or they will conquer you.";
    elseif (luck==21) then
        germText="Sie k�nnen herausholen, was in Ihnen steckt.";
        englText="The chief danger in life is taking too many precautions.";
    elseif (luck==22) then
        germText="Tu' nichts, woran deine Seele Schaden erleiden k�nnte, auch wenn du die Welt gewinnen k�nntest.";
        englText="If you don't care where you are, then you ain't lost.";
    elseif (luck==23) then
        germText="Wenn du die Nacht erwartest, wird auch ein n�chster morgen kommen.";
        englText="You cannot achieve the impossible without attempting the absurd.";
    elseif (luck==24) then
        germText="Eindeutige Zweideutigkeit ist nicht immer zweideutig gemeint, sondern oft nur eindeutig.";
        englText="It is very difficult to prophesy, especially when it pertains to the future.";
    elseif (luck==25) then
        germText="Wer keine Zeit hat wird nicht reif.";
        englText="We all have habits, and habits can be broken.";
    elseif (luck==26) then
        germText="Was geschehen ist, ist vorbei und der Weise hat genug mit der Gegenwart und der Zukunft zu tun.";
        englText="Your opinions may have changed, but not the fact that you are right.";
    elseif (luck==27) then
        germText="Jede Gabe sei begr��t, doch vor allen Dingen: Das, worum man sich bem�ht, m�ge gelingen.";
        englText="An authority is a person who can tell you more about something than you really care to know.";
    elseif (luck==28) then
       germText="Wandel und Wechsel liebt, wer lebt.";
        englText="Expect nothing; be prepared for anything.";
    elseif (luck==29) then
       germText="Wer mit dem Finger auf andere zeigt, sollte nicht vergessen, dass dabei immer drei Finger seiner Hand auf ihn selbst gerichtet sind.";
        englText="Bees are not as busy as we think they are. They just can't buzz any slower.";
    elseif (luck==30) then
       germText="An kleinen Dingen mu� man sich nicht sto�en, wenn man zu gro�en Dingen auf dem Weg ist.";
        englText="Nothing is as easy as it looks.";
    elseif (luck==31) then
       germText="Es steht eine Herausforderung ins Haus. Wappne dich!";
        englText="Remember, even if you win the rat race, you're still a rat.";
    elseif (luck==32) then
       germText="Suche nicht nach einer L�sung, wenn sie schon andere gefunden haben.";
        englText="You can't teach people to be lazy - either they have it, or they don't.";
    elseif (luck==33) then
       germText="Die beim Irrtum verharren, das sind die Narren.";
        englText="What looks like an appealing offer may not be.";
    elseif (luck==34) then
       germText="Die Liebe allein versteht das Geheimnis, andere zu beschenken und dabei selbst reich zu werden.";
        englText="You are only young once. After that you have to think up some other excuse.";
    elseif (luck==35) then
       germText="Solange du selber nicht im Reinen bist, darfst du niemanden verurteilen.";
        englText="Don't take life too seriously.";
    elseif (luck==36) then
       germText="Den T�chtigen belohnt das Gl�ck.";
        englText="Common sense is not so common.";
    elseif (luck==37) then
       germText="Es ist besser, ein kleines Licht zu entz�nden, als �ber gro�e Dunkelheit zu fluchen.";
        englText="If this fortune didn't exist, somebody would have invented it.";
    elseif (luck==38) then
       germText="Gut ist der Vorsatz, hingegen die Erf�llung schwer.";
        englText="Furious activity is no substitute for understanding.";
    elseif (luck==39) then
       germText="Ein Wort wird eine Br�cke bauen.";
        englText="If you don't stand for something, you'll fall for everything.";
    elseif (luck==40) then
       germText="Dein Sinn f�r Humor ist dein bester Begleiter, verliere ihn nicht.";
        englText="Stand up to be seen, speak up to be heard, and shut up to be appreciated.";
    elseif (luck==41) then
       germText="Hilfe! Ich bin in einer Gl�ckskeksb�ckerei eingesperrt!";
        englText="Help! I am a prisoner in a fortune cookie bakery!";
    elseif (luck==42) then
       germText="F�ttere den Troll nicht.";
        englText="Don't feed the troll.";
    elseif (luck==43) then
       germText="Erfahrung ist die Summe aller Misserfolge.";
        englText="Experience is the sum of all mistakes.";
    end

    return germText,englText;
end

return M
