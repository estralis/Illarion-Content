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
--- Base NPC script for basic NPCs
--
-- This script bundles the functions the most other specific components of the
-- NPC require to work. Its the basic script of the NPC framework and the only
-- one that requires regular from the actual NPC script.
--
-- Author: Martin Karing

local common = require("base.common")
local class = require("base.class")

local mutedNPCs = {}

local langCodeToSkill
local displayLanguageConfusion
local isAdminOnField

--- Constructor for the baseNPC. This does not take any paramters.
--
-- The sole purpose is to prepare all required values in the NPC script.
local baseNPC = class(function(self)
    --- Constant for the state value of the NPC.
    --- If this constant is set the NPC is currently in the normal mode.
    self.stateNormal = 0

    --- Constant for the state value of the NPC.
    --- If this constant is set the NPC is currently busy talking with a specified
    --- character and is not to walk around or anything like this.
    self.stateBusyTalking = 1

    -- The state of the NPC. This value can be used to have the special parts
    -- of the NPC communicating with each other.
    self["state"] = self.stateNormal

    -- The cycle functions are called during the next cycle method of this base
    -- NPC struct. Each special NPC class is able to register functions in this
    -- class.
    self["_cycleFunctions"] = nil

    -- The receive text functions are called during the receive text method of
    -- the NPC. Each special NPC class is able to register functions in this
    -- class.
    self["_receiveTextFunctions"] = nil

    -- The cycle counter counts the calls of the next cycle method in order to
    -- find out when to execute the next time all the next cycle methods. This
    -- is used to reduce the server load caused by this method.
    self["_cycleCounter"] = 0

    -- This variable stores then to call the cycle methods the next time in
    -- order to execute all functions of the NPC properly.
    self["_nextCycleCalls"] = 0

    -- This variable holds a list that stores the constants of the languages
    -- the NPC is able to use.
    self["_npcLanguages"] = {}

    -- This variable holds the amount of languages added to the list of
    -- languages of this NPC.
    self["_npcLanguageCount"] = 0

    -- This variable stores the language the NPC is expected to use by default.
    self["_defaultLanguage"] = 0

    -- This variable stores the german lookAt message of the NPC.
    self["_lookAtMsgDE"] = ""

    -- This variable stores the english lookAt message of the NPC.
    self["_lookAtMsgUS"] = ""

    -- This variable stores the german message that is said by the NPC in case
    -- the player performs a use operation on the NPC.
    self["_useMsgDE"] = ""

    -- This variable stores the english message that is said by the NPC in case
    -- the player performs a use operation on the NPC.
    self["_useMsgUS"] = ""

    -- This variable stores the german message that is shown in case the players
    -- talk to the NPC in a language the NPC does not understand.
    self["_confusedDE"] = ""

    -- This variable stores the english message that is shown in case the
    -- players talk to the NPC in a language the NPC does not understand.
    self["_confusedUS"] = ""

    -- This list is used to store the equipment that shall be set to the NPC at
    -- the first run. Once the equipment is set, the list is destroyed.
    self["_equipmentList"] = {}

    -- The town this NPC is affiliated to.
    self["_affiliation"] = 0
end)

--- This method adds one function to the functions that are called during the
--- next cycles.
--
--  @param receiver the receiver is a object that defines a nextCycle function
--                  that is called in given time intervals. The only paramter
--                  of this function is the time since the last call. The return
--                  value has to be the time when the next call of this function
--                  is expected. Its possible that the function is called ealier
--                  but not later.
function baseNPC:addCycle(receiver)
    if (type(receiver) ~= "table") then
        return
    end

    if (type(receiver.nextCycle) ~= "function") then
        return
    end

    if (self._cycleFunctions == nil) then
        self._cycleFunctions = {}
    end

    table.insert(self._cycleFunctions, receiver)
end

--- This method adds one function to the functions that are called during when
--- a text is received by the NPC.
--
--  @param receiver the receiver is a object that defines a receiveText function
--                  that is called all times the basic npc receives a text. The
--                  receive text function has to take as first paramter the
--                  character who is talking and as second parameter the text
--                  that was spoken. In case the receiveText function returns
--                  true the spoken text is not forwarded to any more possible
--                  receivers.
function baseNPC:addRecvText(receiver)
    if (type(receiver) ~= "table") then
        return
    end

    if (type(receiver.receiveText) ~= "function") then
        return
    end

    if (self._receiveTextFunctions == nil) then
        self._receiveTextFunctions = {}
    end

    table.insert(self._receiveTextFunctions, receiver)
end

--- This method has to be called during each next cycle call of an NPC. It
--- manages and calls the functions registered this NPC. This function will be
--- removed during its first call. Instead the function originally named
--- baseNPC:nextCycle2() will take its place and serve its actual purpose.
--
--  @param npcChar the NPC character
function baseNPC:nextCycle(npcChar)
    if (self.initLanguages ~= nil) then
        self:initLanguages(npcChar)
    end

    if (self._equipmentList ~= nil) then
        local tempList = self._equipmentList
        self["_equipmentList"] = nil

        for _, value in pairs(tempList) do
            npcChar:createAtPos(value[1], value[2], 1)
            local item = npcChar:getItemAt(value[1])
            item.wear = 255
            item.quality = 999
            world:changeItem(item)
        end
    end

    self.nextCycle = self.nextCycle2
    self.nextCycle2 = nil
end

--- This method has to be called during each next cycle call of an NPC. It
--- manages and calls the functions registered this NPC. This function will be
--- copied to baseNPC:nextCycle() once the initialization is done.
--
--  @param npcChar the NPC character
function baseNPC:nextCycle2(npcChar)
    if (self._cycleFunctions == nil) then
        return
    end

    if isAdminOnField(npcChar.pos) then
        return
    end

    if (self._cycleCounter < self._nextCycleCalls) then
        self._cycleCounter = self._cycleCounter + 1
        return
    end

    npcChar.activeLanguage = self._defaultLanguage

    local oldCycle = self._cycleCounter
    self._cycleCounter = 0
    self._nextCycleCalls = 2147483648

    local nextRequestedCall = 0
    for _, value in pairs(self._cycleFunctions) do
        nextRequestedCall = value:nextCycle(npcChar, oldCycle)
        if (nextRequestedCall ~= nil and nextRequestedCall >= 0) then
            self._nextCycleCalls = math.min(self._nextCycleCalls, nextRequestedCall)
        end
    end
end

--- This method should be called at each call of the receive text method. This
--- method will maintain all functions registered to this class and call them
--- properly in case its needed.
--
--  @param npcChar the NPC character
--  @param textType the type that was used to send the text
--  @param speaker the character struct who said some text
--  @param text the text that was spoken
--  @return true in case the text was handled properly by one of the receive text handlers
function baseNPC:receiveText(npcChar, texttype, speaker, text)
    if not npcChar:isInRange(speaker, 2) then
        return false
    end
    
    if speaker:isAdmin() then
        local npcName = npcChar.name
        if string.find(text, "unmute") then
            mutedNPCs[npcChar.id] = nil
            speaker:inform("You unmute " .. npcName)
            return false
        elseif string.find(text, "mute") then
            mutedNPCs[npcChar.id] = true
            speaker:inform("You mute " .. npcName)
            return false
        end
    end
    
    if mutedNPCs[npcChar.id] == true then
        local npcName = npcChar.name
        speaker:inform(npcName .. " scheint heute nicht sehr gespr�chig." , npcName .. " doesn't seem to be in a chatty mood today.")
        return false
    end
    
    
    if (self._receiveTextFunctions == nil) then
        return false
    end

    if isAdminOnField(npcChar.pos) then
      return false
    end

    if not npcChar:isInRange(speaker, 2) then
        return false
    end

    if (speaker.id == npcChar.id) then
        return false
    end

    if (speaker:getType() ~= 0) then
        return false
    end

    if not self:checkLanguageOK(speaker) then
        displayLanguageConfusion(npcChar, self)
        return false
    end
    npcChar.activeLanguage = speaker.activeLanguage
    text = string.lower(text)

    for _, value in pairs(self._receiveTextFunctions) do
        if (value:receiveText(npcChar, texttype, speaker, text)) then
            return true
        end
    end

    return false
end

--- This function checks if the language currently spoken by a character is
--- valid to be used by this NPC.
--
--  @param speak the character who is speaking
--  @return true in case the NPC is able to speak the language of the player
function baseNPC:checkLanguageOK(speaker)
    if (speaker.activeLanguage == self._defaultLanguage) then
        return true
    end

    for i=1, self._npcLanguageCount do
        if (speaker.activeLanguage == self._npcLanguages[i]) then
            return true
        end
    end

    return false
end

--- This function adds a language constant to the list of enabled languages of
--- this NPC.
--
--  @param langCode the code of the language the NPC is supposed to know
function baseNPC:addLanguage(langCode)
    table.insert(self._npcLanguages, langCode)
    self._npcLanguageCount = self._npcLanguageCount + 1
end

--- This function sets the language the NPC is supposed to use by default. The
--- only case it is switching the language is, in case he answeres to a player
--- talking in another language.
--
--  @param langCode the code value of the language to use
function baseNPC:setDefaultLanguage(langCode)
    self._defaultLanguage = langCode
end

--- This function sets the texts that are displayed when someone is looking at
--- the NPC.
--
--  @param german the german message
--  @param english the english message
function baseNPC:setLookat(german, english)
    self._lookAtMsgDE = german
    self._lookAtMsgUS = english
end

--- This function sets the text that are displayed when someone is using the
--- NPC.
--
--  @param german the german message
--  @param english the english message
function baseNPC:setUseMessage(german, english)
    self._useMsgDE = german
    self._useMsgUS = english
end

--- This function sets the text that is displayed in case a player is talking
--- in the wrong language with the NPC.
--
--  @param german the german message
--  @param english the english message
function baseNPC:setConfusedMessage(german, english)
    self._confusedDE = german
    self._confusedUS = english
end

--- This method handles the lookat requests that are send to the NPC. If set
--- properly a message will be returned describing the appearance of the NPC.
--
--  @param npcChar the NPC character
--  @param char the character who is looking at the NPC
--  @param mode the mode used to look at the NPC (no effect)
function baseNPC:lookAt(npcChar, char, mode)
    char:sendCharDescription(npcChar.id, common.GetNLS(char, self._lookAtMsgDE, self._lookAtMsgUS))
end

--- This method handles all use methods that are done to the NPC. When ever a
--- NPC is used by the player this one is called.
--
--  @param npcChar the NPC character
--  @param char the character who is looking at the NPC
--  @param mode the mode used to look at the NPC (no effect)
function baseNPC:use(npcChar, char)

    if char:isAdmin() then
        local lastSpoken = char.lastSpokenText
        if string.find(string.lower(lastSpoken), "teleport") then
            local coords = {}
            for coord in lastSpoken:gmatch("%-?%d+") do 
                table.insert(coords, tonumber(coord)) 
            end
            if coords[1] and coords[2] and coords[3] then
                npcChar:forceWarp(position(coords[1], coords[2], coords[3]))
            end
        end
    end
    
    if mutedNPCs[npcChar.id] == true then
        local npcName = npcChar.name
        char:inform(npcName .. " scheint heute nicht sehr gespr�chig." , npcName .. " doesn't seem to be in a chatty mood today.")
        return
    end

    if isAdminOnField(npcChar.pos) then
        return
    end

    npcChar.activeLanguage = self._defaultLanguage

    local getText = function(deText,enText) return common.GetNLS(char, deText, enText) end

    local callback = function(dialog)
        local success = dialog:getSuccess()
        if success then
            local selected = dialog:getSelectedIndex()
            if selected == 5 then --free input
                local callbackInput = function(dialogInput)
                    if not dialogInput:getSuccess() then
                        return;
                    else
                        local text = dialogInput:getInput()
                        char:talk(Character.say, text, text)
                    end
                end

                local dialogInput
                dialogInput = InputDialog(npcChar.name, getText("�ber welches Thema m�chtest du sprechen?","Select the topic you want to talk about."), false, 255, callbackInput)
                char:requestInputDialog(dialogInput)
            else
                local textDE={}
                local textEN={}
                textDE[0]="Seid gegr��t."
                textEN[0]="Be greeted."
                textDE[1]="Ich ben�tige Hilfe."
                textEN[1]="Please help me."
                textDE[2]="Habt Ihr eine Aufgabe f�r mich?"
                textEN[2]="Do you have a task for me?"
                textDE[3]="Ich m�chte Waren handeln."
                textEN[3]="I'd like to trade some goods."
                textDE[4]="Auf wiedersehen."
                textEN[4]="Farewell."
                char:talk(Character.say, getText(textDE[selected], textEN[selected]))
            end
        end
    end

    local dialog = SelectionDialog(npcChar.name, getText("�ber welches Thema m�chtest du sprechen?","Select the topic you want to talk about."), callback)
    dialog:setCloseOnMove()
    dialog:addOption(0, getText("Begr��en", "Greetings"))
    dialog:addOption(0, getText("Hilfe", "Help"))
    dialog:addOption(0, getText("Quest", "Quest"))
    dialog:addOption(0, getText("Handel", "Trade"))
    dialog:addOption(0, getText("Verabschieden", "Farewell"))
    dialog:addOption(0, getText("(Etwas anderes)", "(Other)"))

    char:requestSelectionDialog(dialog)
end

--- This equipment sets the equipment an NPC gets at first start. This is needed
--- so the NPC looks good with paperdolling.
--
--  @param slot the slot the item is to be placed in
--  @param item the item ID that shall be created
function baseNPC:setEquipment(slot, item)
    table.insert(self["_equipmentList"], {slot, item})
end

--- This function is used to set the affiliation of the NPC.
--
-- @param affiliation the index of the town this NPC is assigned to
function baseNPC:setAffiliation(affiliation)
    self["_affiliation"] = affiliation
end

--- This is a cleanup function that should be called once the initialization of
--- the NPC is done. It will free the memory taken by all the functions that are
--- needed to fill data into the NPC.
function baseNPC:initDone()
    self["addCycle"] = nil
    self["addRecvText"] = nil
    self["addLanguageCode"] = nil
    self["setDefaultLanguage"] = nil
    self["setLookat"] = nil
    self["setUseMessage"] = nil
    self["setConfusedMessage"] = nil
    self["setEquipment"] = nil
    self["initDone"] = nil
end

function baseNPC:setAutoIntroduceMode(autointroduce)
end

--- This function learns the NPC the languages skills needed to work properly.
--- Check if this function is not nil before you call it, because it destructs
--- itself after it was called once.
--
--  @param npcChar the NPC character
function baseNPC:initLanguages(npcChar)
    for _, value in pairs(self._npcLanguages) do
        npcChar:increaseSkill(langCodeToSkill(value), 100)
    end
    self["initLanguages"] = nil
end

--- This function translates a language code value to the skill that belongs to
--- this number. This skill name is needed to set the skill value of the NPC in
--- so the NPC is able to talk in the needed language perfectly.
--
--  @param langCode the language code
--  @return the skill fitting to the language code
function langCodeToSkill(langCode)
    if (langCode == 0) then
        return Character.commonLanguage
    elseif (langCode == 1) then
        return Character.humanLanguage
    elseif (langCode == 2) then
        return Character.dwarfLanguage
    elseif (langCode == 3) then
        return Character.elfLanguage
    elseif (langCode == 4) then
        return Character.lizardLanguage
    elseif (langCode == 5) then
        return Character.orcLanguage
    elseif (langCode == 10) then
        return Character.ancientLanguage
    else
        return Character.commonLanguage
    end
end

--- This function is used to display the message that the NPC is not able to
--- understand the language the player character is speaking. It should be
--- called every time the languageOK check is failing because it has its own
--- protection against spamming.
--
--  @param npcChar the NPC character
--  @param npc the baseNPC instance that is referred to
function displayLanguageConfusion(npcChar, npc)
    if not common.spamProtect(npcChar, 60) then
        npcChar.activeLanguage = npc._defaultLanguage
        npcChar:talk(Character.say, npc._confusedDE, npc._confusedUS)
    end
end

-- check if there is a GM "possessing" the NPC
function isAdminOnField(pos)
    local stackedChar = world:getCharacterOnField(pos)
    if stackedChar:isAdmin() then
        return true
    end
    return false
end

return baseNPC
