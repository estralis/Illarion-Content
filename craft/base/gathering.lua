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
local treasure = require("item.base.treasure")

local M = {}

local RandomItem = {
    ID = 0,
    Quantity = 1,
    Quality = 333,
    Data = {},
    Probability = 0,
    MessageDE = nil,
    MessageEN = nil,
};

local GatheringCraft = {
    RandomItems = { },
    Monsters = { },
    LeadSkill = 0,
    SavedWorkTime = { },
    Treasure = 0,
    TreasureMsg = { },
    FastActionFactor = 1,
    LearnLimit = 20
};

local Monster = {
    MonsterID = 0,
    Probability = 100,
    MessageDE = "",
    MessageEN = "",
    Sound = nil,
    GFX = nil
};

function GatheringCraft:new(gc)
    gc = gc or {};
    setmetatable(gc, self);
    self.__index = self;
    gc.RandomItems = {};
    gc.InterruptMsg = {};
    gc.Monsters = {};
    gc.TreasureMsg = {};
    return gc;
end

function RandomItem:new(item)
    item = item or {};
    setmetatable(item, self);
    self.__index = self;
    return item;
end

function Monster:new(m)
    m = m or {};
    setmetatable(m, self);
    self.__index = self;
    return m;
end

function GatheringCraft:SetTreasureMap(User,Probability, MessageDE, MessageEN)
    local skill  = common.Limit(User:getSkill(self.LeadSkill), 0, 100);
    if skill >= 60 then
        self.Treasure = Probability;
        self.TreasureMsg[1] = MessageDE;
        self.TreasureMsg[2] = MessageEN;
    end
end

function GatheringCraft:AddMonster(User,MonsterID, Probability, MessageDE, MessageEN, Sound, GFX)
    if not User:isNewPlayer() then
        table.insert(self.Monsters, Monster:new{["MonsterID"] = MonsterID, ["Probability"] = Probability, ["MessageDE"] = MessageDE, ["MessageEN"] = MessageEN, ["Sound"] = Sound, ["GFX"] = GFX});
    end
end

function GatheringCraft:AddRandomItem(ItemID, Quantity, Quality, Data, Probability, MessageDE, MessageEN)
    table.insert(self.RandomItems, RandomItem:new{["ID"] = ItemID, ["Quantity"] = Quantity, ["Quality"] = Quality, ["Data"] = Data, ["Probability"] = Probability, ["MessageDE"] = MessageDE, ["MessageEN"] = MessageEN});
end

function GatheringCraft:AddRandomPureElement(User,Probability)
    local skill  = common.Limit(User:getSkill(self.LeadSkill), 0, 100);
    if skill >= 80 then
        table.insert(self.RandomItems, RandomItem:new{["ID"] = 2551, ["Quantity"] = 1, ["Quality"] = 333, ["Data"] = {}, ["Probability"] = tonumber(Probability), ["MessageDE"] = "F�r deine harte und ehrliche Arbeit belohnt dich Findari, die G�ttin der Luft, mit einem Kleinod aus Reiner Luft.", ["MessageEN"] = "For your hard and honest labour Findari, the Godess of Air, rewards you with a treasure of Pure Air."}); -- Pure Air
        table.insert(self.RandomItems, RandomItem:new{["ID"] = 2553, ["Quantity"] = 1, ["Quality"] = 333, ["Data"] = {}, ["Probability"] = tonumber(Probability), ["MessageDE"] = "F�r deine harte und ehrliche Arbeit belohnt dich Bragon, der Gott des Feuers, mit einem Kleinod aus Reinem Feuer.", ["MessageEN"] = "For your hard and honest labour Bragon, the god of fire, rewards you with a treasure of Pure Fire."}); -- Pure Fire
        table.insert(self.RandomItems, RandomItem:new{["ID"] = 2554, ["Quantity"] = 1, ["Quality"] = 333, ["Data"] = {}, ["Probability"] = tonumber(Probability), ["MessageDE"] = "F�r deine harte und ehrliche Arbeit belohnt dich Tanora, die G�ttin des Wassers, mit einem Kleinod aus Reinem Wasser.", ["MessageEN"] = "For your hard and honest labour Tanora, the Godess of Water, rewards you with a treasure of Pure Water."}); -- Pure Water
        table.insert(self.RandomItems, RandomItem:new{["ID"] = 2552, ["Quantity"] = 1, ["Quality"] = 333, ["Data"] = {}, ["Probability"] = tonumber(Probability), ["MessageDE"] = "F�r deine harte und ehrliche Arbeit belohnt dich Ushara, die G�ttin der Erde, mit einem Kleinod aus Reiner Erde.", ["MessageEN"] = "For your hard and honest labour Ushara, the Godess of Earth, rewards you with a treasure of Pure Earth."}); -- Pure Earth
        table.insert(self.RandomItems, RandomItem:new{["ID"] = 3607, ["Quantity"] = 1, ["Quality"] = 333, ["Data"] = {}, ["Probability"] = tonumber(Probability), ["MessageDE"] = "F�r deine harte und ehrliche Arbeit belohnt dich Eldan, der Gott des Geistes, mit einem Kleinod aus Reinem Geist.", ["MessageEN"] = "For your hard and honest labour Eldan, the God of Spirit, rewards you with a treasure of Pure Spirit."}); -- Pure Spirit
    end
end

function GatheringCraft:FindRandomItem(User)

  -- FindRandomItem is called when the User is currently working. If there was
  -- a reload, the working time will be nil. Check for this case.
  if (self.SavedWorkTime[User.id] == nil) then
    -- Just generate the work time again. Does not matter really if this is not
    -- exactly the original value.
    self.SavedWorkTime[User.id] = self:GenWorkTime(User);
  end

    common.GetHungry(User, self.SavedWorkTime[User.id]*4);

    -- check for Noobia
    if (common.isOnNoobia(User.pos)) then
        return false;
    end

    -- check for Prison Mine
    if (common.isInPrison(User.pos)) then
       return false
    end

    if (self.Treasure > 0) then
        local rand = math.random();
        if(rand < self.Treasure*self.FastActionFactor) and treasure.createMap(User) then
            common.InformNLS(User, self.TreasureMsg[1], self.TreasureMsg[2]);
            return true;
        end
    end

    if (#self.Monsters > 0) then
        local ra = math.random(#self.Monsters);
        local pa = math.random();
        if (pa < self.Monsters[ra].Probability*self.FastActionFactor) then
            local TargetPos = common.GetFreePositions(User.pos, 1, true, true)()
            if TargetPos == nil then
                return false
            end
            world:createMonster(self.Monsters[ra].MonsterID, TargetPos, 20);
            if ( self.Monsters[ra].GFX ~= nil ) then
                world:gfx(self.Monsters[ra].GFX, TargetPos);
            end
            if(self.Monsters[ra].Sound ~= nil) then
                world:makeSound(self.Monsters[ra].Sound, TargetPos);
            end
            common.InformNLS(User, self.Monsters[ra].MessageDE, self.Monsters[ra].MessageEN);
            return true;
        end
    end

    if(#self.RandomItems > 0) then

        -- check all items with same random number and choose any possible item again randomly

        local itemIndexList = {};

        -- list all items that are possible
        for it = 1, #self.RandomItems, 1 do
            local rand = math.random();

            if (rand <= self.RandomItems[it].Probability*self.FastActionFactor) then

                table.insert(itemIndexList, it);

            end
        end
        if ( #itemIndexList > 0 ) then -- For the unlikely case that two items were found at once, we just give one to the player
            local ind = itemIndexList[math.random(1,#itemIndexList)];
            common.InformNLS(User, self.RandomItems[ind].MessageDE, self.RandomItems[ind].MessageEN);
            common.CreateItem(User, self.RandomItems[ind].ID, self.RandomItems[ind].Quantity, self.RandomItems[ind].Quality, self.RandomItems[ind].Data)
            return true;
        end

    end
    return false;
end

-- Generate working time for gathering actions
function GatheringCraft:GenWorkTime(User)

  local minTime = 15; --Minimum time for skill 100
  local maxTime = 45; --Maximum time for skill 0

  local skill  = common.Limit(User:getSkill(self.LeadSkill), 0, 100);
  local workTime = common.Scale(maxTime, minTime, skill); --scaling with the skill

  workTime = math.ceil(workTime*self.FastActionFactor); --for fast actions.

  return workTime;
end

M.GatheringCraft = GatheringCraft

M.prob_frequently = 0.0005; --0.05% (1/2000)
M.prob_occasionally = 0.00025; --0.025% (1/4000)
M.prob_rarely = 0.000025; --0.0025% (1/40000)
M.prob_monster = 0.0001; --0.01% (1/10000)
M.prob_element = 0.0001; --0.01% (1/10000) - Chance for one specific element, there are five elements in total
M.prob_map = 0.0005; --0.05% (1/2000)

return M
