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
local class = require("base.class")

local M = {}

M.deleteBridge = class(function(delbrg, posi)
    delbrg.pos=posi;
end);

function M.deleteBridge:execute()
    if (world:isItemOnField(self.pos)==true) then
        local item=world:getItemOnField(self.pos);
        if(item.id==618 or item.id==621 or item.id==614 or item.id==617) then
            local t=0;
            if item:getData("deleteBridgeDir") == "north" then
                local keepGoing=1;
                while keepGoing==1 do
                    local delPos=position(self.pos.x,self.pos.y-t,self.pos.z)
                    if (world:isItemOnField(delPos)==true) then
                        item=world:getItemOnField(delPos);
                        if (item:getData("deleteBridgeDir") == "north" and (item.id==617 or item.id==615 or item.id==614)) then
                            world:erase(item,1);
                            t=t+1;
                        else
                            keepGoing=0;
                        end
                    else
                        keepGoing=0;
                    end
                end
            elseif item:getData("deleteBridgeDir") == "east" then
                local keepGoing=1;
                while keepGoing==1 do
                    local delPos=position(self.pos.x+t,self.pos.y,self.pos.z)
                    if (world:isItemOnField(delPos)==true) then
                        item=world:getItemOnField(delPos);
                        if (item:getData("deleteBridgeDir") == "east" and (item.id==621 or item.id==619 or item.id==618)) then
                            world:erase(item,1);
                            t=t+1;
                        else
                            keepGoing=0;
                        end
                    else
                        keepGoing=0;
                    end
                end
            elseif item:getData("deleteBridgeDir") == "south" then
                local keepGoing=1;
                while keepGoing==1 do
                    local delPos=position(self.pos.x,self.pos.y+t,self.pos.z)
                    if (world:isItemOnField(delPos)==true) then
                        item=world:getItemOnField(delPos);
                        if (item:getData("deleteBridgeDir") == "south" and (item.id==617 or item.id==615 or item.id==614)) then
                            world:erase(item,1);
                            t=t+1;
                        else
                            keepGoing=0;
                        end
                    else
                        keepGoing=0;
                    end
                end
            elseif item:getData("deleteBridgeDir") == "west" then
                local keepGoing=1;
                while keepGoing==1 do
                    local delPos=position(self.pos.x-t,self.pos.y,self.pos.z)
                    if (world:isItemOnField(delPos)==true) then
                        item=world:getItemOnField(delPos);
                        if (item:getData("deleteBridgeDir") == "west" and (item.id==621 or item.id==619 or item.id==618)) then
                            world:erase(item,1);
                            t=t+1;
                        else
                            keepGoing=0;
                        end
                    else
                        keepGoing=0;
                    end
                end
            end
        end
    end
end

return M
