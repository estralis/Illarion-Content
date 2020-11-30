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
-- triggerfields for better atmosphere

--[[ SQL Statements:
INSERT INTO triggerfields VALUES (X,Y,Z,'triggerfield.akaltutschamber_ambient');

]]

local common = require("base.common")
local ambient_base = require("triggerfield.base.ambient")

local M = {}

--[[
position: coordinates
direction: array with directions, 0=North,2=East,4=South,6=West. Set nil for always
german/english: text
hours: array with hours when text shall be shown, in range of 0 to 23. Set to nil for always.
months: array with months when text shall be shown, in range of 1 to 16. Set to nil for always.
chance: Chance that this triggerfield is triggered in percent (integer)

for script:
mtLetmaList.add( position(x,y,z), {0,1,7}, "german", "english", {0,1,23}, {1,2,16}, chance );

for db:
INSERT INTO triggerfields VALUES (x,y,z,'triggerfield.mtletma_ambient');
]]


local mtLetmaList = ambient_base()

-- Mt Letma triggers using Ambient.lua as a guide
mtLetmaList.add( position(228,769,0),nil,"Das Ger�usch von etwas, das an den Steinen kratzt erreicht dein Ohr. K�nnten es K�fer sein, oder etwas weit bedrohlicheres.","The sound of something scraping against the rocks reaches your ears. Could it be beetles or something far more menacing?",nil,nil,50);
mtLetmaList.add( position(233,812,0),nil,"Tiefe Krater liegen auf dem Weg vor dir. Etwas riesiges, schweres ist hier entlanggekommen.","Large craters are in the path ahead. Something large and heavy has been walking in here.",nil,nil,50); 
mtLetmaList.add( position(277,788,0),nil,"Der Boden ist �bers�t mit Steinen, welche von den W�llen abgebrochen zu sein scheinen.","The ground is littered with stones that appear to have been broken from the walls.",nil,nil,40); 
mtLetmaList.add( position(267,772,1),nil,"Die Luft auf dem Gipfel des Berges ist trocken und hei�, aber es fehlt der Sand aus der W�ste.","The air on top of the mountain is hot and dry but the sand from the desert is absent.",nil,nil,40);
mtLetmaList.add( position(271,802,1),nil,"Der Blick nach S�den und Osten zeigt nur klares Wasser, welches gegen den Sand schl�gt.","The view to the south and east is nothing but clear waters that lap against the sand.",nil,nil,40); 
mtLetmaList.add( position(251,768,0),nil,"Die Luft wird k�hler, je tiefer du in den Berg eindringst.","The air gets cooler the deeper into the mountain you go.",nil,nil,40);
mtLetmaList.add( position(250,760,-3),nil,"Der Geruch von Verwesung und ungewaschenen K�rpern dringt dir in die Nase.","The scent of decay and unwashed bodies assaults your nose.",nil,nil,40); 
mtLetmaList.add( position(293,759,-3),nil,"Die Mauer vor dir ist scheint mit groben Strichfigurenbildern �bers�t.","The wall in front of you appears to be covered in crude stick figure drawings.",nil,nil,40);
mtLetmaList.add( position(289,805,-3),nil,"Aus der Esse zur rechten dringt ein permanenter Schein. Die Hitze von dort w�rmt dich.","The forge to the right gives off an ever present glow. The heat coming from it warms you.",nil,nil,40); 
mtLetmaList.add( position(290,805,-3),nil,"Aus der Esse zur rechten dringt ein permanenter Schein. Die Hitze von dort w�rmt dich.","The forge to the right gives off an ever present glow. The heat coming from it warms you.",nil,nil,40); 
mtLetmaList.add( position(291,805,-3),nil,"Aus der Esse zur rechten dringt ein permanenter Schein. Die Hitze von dort w�rmt dich.","The forge to the right gives off an ever present glow. The heat coming from it warms you.",nil,nil,40); 
mtLetmaList.add( position(234,794,-6),nil,"Eine Stimme wird, wie ein Echo von der Wand zur�ckgeworfen: 'Ich sehe Dich.'","A voice echoes off the walls, 'I see you.'",nil,nil,40); 
mtLetmaList.add( position(223,810,-8),nil,"Das Ger�usch von Biestern, welche Fleisch auseinanderrei�en, erreicht deine Ohren.","The sounds of beasts ripping appart flesh reaches your ears.",nil,nil,40); 

function M.MoveToField(Char)
    local this = mtLetmaList.get(Char)
    if this then
        common.InformNLS(Char, this.german, this.english)
    end
end

return M
