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
local lookat = require("base.lookat")

-- UPDATE items SET itm_script='item.id_623_rockface' WHERE itm_id IN (623);

local M = {}

function M.UseItem(User, SourceItem, ltstate)

  -- entrance to the cave
  local pos = position(894, 627, 0);
  if (SourceItem.pos ~= pos) then
        return
  end

  -- open on keyword
  local spokenText = User.lastSpokenText;
  if (string.find(spokenText, "[Ff][Oo][Xx]") ~= nil or
      string.find(spokenText, "[Ff][Uu][Cc][Hh][Ss]") ~= nil) then

    world:erase(SourceItem, 1);

    common.InformNLS(User,
      "Die Steinwand verschwindet als du sie ber�hrst!",
      "The rock wall disappears as you touch it!");


    local Characters = world:getPlayersInRangeOf(pos, 5);
    for i, Char in pairs(Characters) do
      if (User.id ~= Char.id) then
        common.InformNLS(Char,
        "Eine Steinwand verschwindet einfach.",
        "A rock wall just disappears.");
      end
    end

  else
    common.InformNLS(User,
      "Nichts passiert als du die Steinwand ber�hrst.",
      "Nothing happens as you touch the rock wall.");
  end
end

function M.LookAtItem(User, Item)
  if (Item.pos == position(894, 627, 0)) then
        lookat.SetSpecialDescription(Item, "Eine merkw�rdige Steinwand.", "A peculiar rock wall.");
  end
  return lookat.GenerateLookAt(User, Item, lookat.NONE)
end

return M

