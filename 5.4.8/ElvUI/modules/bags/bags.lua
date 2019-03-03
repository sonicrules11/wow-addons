﻿local E, L, V, P, G = unpack(select(2, ...))
local B = E:NewModule("Bags", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
local Search = E.Libs.ItemSearch

local _G = _G
local type, ipairs, pairs, unpack, select, assert, pcall = type, ipairs, pairs, unpack, select, assert, pcall
local tinsert, tremove, twipe, tmaxn = table.insert, table.remove, table.wipe, table.maxn
local floor, ceil, abs = math.floor, math.ceil, math.abs
local format, sub, gsub, match = string.format, string.sub, string.gsub, string.match

local BankFrameItemButton_Update = BankFrameItemButton_Update
local BankFrameItemButton_UpdateLocked = BankFrameItemButton_UpdateLocked
local CloseBag, CloseBackpack, CloseBankFrame = CloseBag, CloseBackpack, CloseBankFrame
local CooldownFrame_SetTimer = CooldownFrame_SetTimer
local CreateFrame = CreateFrame
local C_NewItems_IsNewItem = C_NewItems.IsNewItem
local C_NewItems_RemoveNewItem = C_NewItems.RemoveNewItem
local DeleteCursorItem = DeleteCursorItem
local GetBackpackCurrencyInfo = GetBackpackCurrencyInfo
local GetContainerItemCooldown = GetContainerItemCooldown
local GetContainerItemInfo = GetContainerItemInfo
local GetContainerItemLink = GetContainerItemLink
local GetContainerItemQuestInfo = GetContainerItemQuestInfo
local GetContainerNumFreeSlots = GetContainerNumFreeSlots
local GetContainerNumSlots = GetContainerNumSlots
local GetCurrencyLink = GetCurrencyLink
local GetCurrentGuildBankTab = GetCurrentGuildBankTab
local GetGuildBankItemLink = GetGuildBankItemLink
local GetGuildBankTabInfo = GetGuildBankTabInfo
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local GetMoney = GetMoney
local GetNumBankSlots = GetNumBankSlots
local GetScreenWidth, GetScreenHeight = GetScreenWidth, GetScreenHeight
local IsBagOpen, IsOptionFrameOpen = IsBagOpen, IsOptionFrameOpen
local IsModifiedClick = IsModifiedClick
local IsShiftKeyDown, IsControlKeyDown = IsShiftKeyDown, IsControlKeyDown
local PickupContainerItem = PickupContainerItem
local PlaySound = PlaySound
local SetItemButtonCount = SetItemButtonCount
local SetItemButtonDesaturated = SetItemButtonDesaturated
local SetItemButtonTexture = SetItemButtonTexture
local SetItemButtonTextureVertexColor = SetItemButtonTextureVertexColor
local ToggleFrame = ToggleFrame
local UpdateSlot = UpdateSlot
local UseContainerItem = UseContainerItem
local CONTAINER_OFFSET_X, CONTAINER_OFFSET_Y = CONTAINER_OFFSET_X, CONTAINER_OFFSET_Y
local CONTAINER_SCALE = CONTAINER_SCALE
local CONTAINER_SPACING, VISIBLE_CONTAINER_SPACING = CONTAINER_SPACING, VISIBLE_CONTAINER_SPACING
local CONTAINER_WIDTH = CONTAINER_WIDTH
local MAX_CONTAINER_ITEMS = MAX_CONTAINER_ITEMS
local MAX_WATCHED_TOKENS = MAX_WATCHED_TOKENS
local NUM_BAG_FRAMES = NUM_BAG_FRAMES
local NUM_CONTAINER_FRAMES = NUM_CONTAINER_FRAMES
local SEARCH = SEARCH

local SEARCH_STRING = ""

local UpgradeTable = {
	[  0] = {                      ilevel = 0},
	[  1] = {upgrade = 1, max = 1, ilevel = 8},
	[373] = {upgrade = 1, max = 3, ilevel = 4},
	[374] = {upgrade = 2, max = 3, ilevel = 8},
	[375] = {upgrade = 1, max = 3, ilevel = 4},
	[376] = {upgrade = 2, max = 3, ilevel = 4},
	[377] = {upgrade = 3, max = 3, ilevel = 4},
	[378] = {                      ilevel = 7},
	[379] = {upgrade = 1, max = 2, ilevel = 4},
	[380] = {upgrade = 2, max = 2, ilevel = 4},
	[445] = {upgrade = 0, max = 2, ilevel = 0},
	[446] = {upgrade = 1, max = 2, ilevel = 4},
	[447] = {upgrade = 2, max = 2, ilevel = 8},
	[451] = {upgrade = 0, max = 1, ilevel = 0},
	[452] = {upgrade = 1, max = 1, ilevel = 8},
	[453] = {upgrade = 0, max = 2, ilevel = 0},
	[454] = {upgrade = 1, max = 2, ilevel = 4},
	[455] = {upgrade = 2, max = 2, ilevel = 8},
	[456] = {upgrade = 0, max = 1, ilevel = 0},
	[457] = {upgrade = 1, max = 1, ilevel = 8},
	[458] = {upgrade = 0, max = 4, ilevel = 0},
	[459] = {upgrade = 1, max = 4, ilevel = 4},
	[460] = {upgrade = 2, max = 4, ilevel = 8},
	[461] = {upgrade = 3, max = 4, ilevel = 12},
	[462] = {upgrade = 4, max = 4, ilevel = 16},
	[465] = {upgrade = 0, max = 2, ilevel = 0},
	[466] = {upgrade = 1, max = 2, ilevel = 4},
	[467] = {upgrade = 2, max = 2, ilevel = 8},
	[468] = {upgrade = 0, max = 4, ilevel = 0},
	[469] = {upgrade = 1, max = 4, ilevel = 4},
	[470] = {upgrade = 2, max = 4, ilevel = 8},
	[471] = {upgrade = 3, max = 4, ilevel = 12},
	[472] = {upgrade = 4, max = 4, ilevel = 16},
	[491] = {upgrade = 0, max = 4, ilevel = 0},
	[492] = {upgrade = 1, max = 4, ilevel = 4},
	[493] = {upgrade = 2, max = 4, ilevel = 8},
	[494] = {upgrade = 0, max = 6, ilevel = 0},
	[495] = {upgrade = 1, max = 6, ilevel = 4},
	[496] = {upgrade = 2, max = 6, ilevel = 8},
	[497] = {upgrade = 3, max = 6, ilevel = 12},
	[498] = {upgrade = 4, max = 6, ilevel = 16},
	[503] = {upgrade = 3, max = 3, ilevel = 1},
	[504] = {upgrade = 3, max = 4, ilevel = 12},
	[505] = {upgrade = 4, max = 4, ilevel = 16},
	[506] = {upgrade = 5, max = 6, ilevel = 20},
	[507] = {upgrade = 6, max = 6, ilevel = 24},
}

function B:GetContainerFrame(arg)
	if type(arg) == "boolean" and arg == true then
		return self.BankFrame
	elseif type(arg) == "number" then
		if self.BankFrame then
			for _, bagID in ipairs(self.BankFrame.BagIDs) do
				if bagID == arg then
					return self.BankFrame
				end
			end
		end
	end

	return self.BagFrame
end

function B:Tooltip_Show()
	GameTooltip:SetOwner(self)
	GameTooltip:ClearLines()
	GameTooltip:AddLine(self.ttText)

	if self.ttText2 then
		GameTooltip:AddLine(" ")
		GameTooltip:AddDoubleLine(self.ttText2, self.ttText2desc, 1, 1, 1)
	end

	GameTooltip:Show()
end

function B:Tooltip_Hide()
	GameTooltip:Hide()
end

function B:DisableBlizzard()
	BankFrame:UnregisterAllEvents()

	for i = 1, NUM_CONTAINER_FRAMES do
		_G["ContainerFrame"..i]:Kill()
	end
end

function B:SearchReset()
	SEARCH_STRING = ""
end

function B:IsSearching()
	return (SEARCH_STRING ~= "" and SEARCH_STRING ~= SEARCH)
end

function B:UpdateSearch()
	if self.Instructions then self.Instructions:SetShown(self:GetText() == "") end

	local MIN_REPEAT_CHARACTERS = 3
	local searchString = self:GetText()
	local prevSearchString = SEARCH_STRING
	if #searchString > MIN_REPEAT_CHARACTERS then
		local repeatChar = true
		for i = 1, MIN_REPEAT_CHARACTERS, 1 do
			if sub(searchString,(0-i), (0-i)) ~= sub(searchString,(-1 - i),(-1 - i)) then
				repeatChar = false
				break
			end
		end

		if repeatChar then
			B.ResetAndClear(self)
			return
		end
	end

	--Keep active search term when switching between bank and reagent bank
	if searchString == SEARCH and prevSearchString ~= "" then
		searchString = prevSearchString
	elseif searchString == SEARCH then
		searchString = ""
	end

	SEARCH_STRING = searchString

	B:RefreshSearch()
	B:SetGuildBankSearch(SEARCH_STRING)
end

function B:OpenEditbox()
	self.BagFrame.detail:Hide()
	self.BagFrame.editBox:Show()
	self.BagFrame.editBox:SetText(SEARCH)
	self.BagFrame.editBox:HighlightText()
end

function B:ResetAndClear()
	local editbox = self:GetParent().editBox or self
	if editbox then editbox:SetText(SEARCH) end

	self:ClearFocus()
	B:SearchReset()
end

function B:SetSearch(query)
	local empty = #(query:gsub(" ", "")) == 0
	for _, bagFrame in pairs(self.BagFrames) do
		for _, bagID in ipairs(bagFrame.BagIDs) do
			for slotID = 1, GetContainerNumSlots(bagID) do
				local _, _, _, _, _, _, link = GetContainerItemInfo(bagID, slotID)
				local button = bagFrame.Bags[bagID][slotID]
				local success, result = pcall(Search.Matches, Search, link, query)

				if empty or (success and result) then
					SetItemButtonDesaturated(button)
					button.searchOverlay:Hide()
					button:SetAlpha(1)
				else
					SetItemButtonDesaturated(button, 1)
					button.searchOverlay:Show()
					button:SetAlpha(0.5)
				end
			end
		end
	end
end

function B:SetGuildBankSearch(query)
	local empty = #(query:gsub(" ", "")) == 0
	if GuildBankFrame and GuildBankFrame:IsShown() then
		local tab = GetCurrentGuildBankTab()
		local _, _, isViewable = GetGuildBankTabInfo(tab)

		if isViewable then
			for slotID = 1, MAX_GUILDBANK_SLOTS_PER_TAB do
				local link = GetGuildBankItemLink(tab, slotID)
				--A column goes from 1-14, e.g. GuildBankColumn1Button14 (slotID 14) or GuildBankColumn2Button3 (slotID 17)
				local col = ceil(slotID / 14)
				local btn = (slotID % 14)
				if col == 0 then col = 1 end
				if btn == 0 then btn = 14 end
				local button = _G["GuildBankColumn"..col.."Button"..btn]
				local success, result = pcall(Search.Matches, Search, link, query)
				if empty or (success and result) then
					SetItemButtonDesaturated(button)
					button.searchOverlay:Hide()
					button:SetAlpha(1)
				else
					SetItemButtonDesaturated(button, 1)
					button.searchOverlay:Show()
					button:SetAlpha(0.5)
				end
			end
		end
	end
end

function B:UpdateItemLevelDisplay()
	if E.private.bags.enable ~= true then return end

	for _, bagFrame in pairs(self.BagFrames) do
		for _, bagID in ipairs(bagFrame.BagIDs) do
			for slotID = 1, GetContainerNumSlots(bagID) do
				local slot = bagFrame.Bags[bagID][slotID]
				if slot and slot.itemLevel then
					slot.itemLevel:FontTemplate(E.Libs.LSM:Fetch("font", E.db.bags.itemLevelFont), E.db.bags.itemLevelFontSize, E.db.bags.itemLevelFontOutline)
				end
			end
		end

		if bagFrame.UpdateAllSlots then
			bagFrame:UpdateAllSlots()
		end
	end
end

function B:UpdateCountDisplay()
	if E.private.bags.enable ~= true then return end
	local color = E.db.bags.countFontColor

	for _, bagFrame in pairs(self.BagFrames) do
		for _, bagID in ipairs(bagFrame.BagIDs) do
			for slotID = 1, GetContainerNumSlots(bagID) do
				local slot = bagFrame.Bags[bagID][slotID]
				if slot and slot.Count then
					slot.Count:FontTemplate(E.Libs.LSM:Fetch("font", E.db.bags.countFont), E.db.bags.countFontSize, E.db.bags.countFontOutline)
					slot.Count:SetTextColor(color.r, color.g, color.b)
				end
			end
		end

		if bagFrame.UpdateAllSlots then
			bagFrame:UpdateAllSlots()
		end
	end
end

function B:UpdateBagTypes(isBank)
	local f = self:GetContainerFrame(isBank)
	for _, bagID in ipairs(f.BagIDs) do
		if f.Bags[bagID] then
			f.Bags[bagID].type = select(2, GetContainerNumFreeSlots(bagID))
		end
	end
end

function B:UpdateAllBagSlots()
	if E.private.bags.enable ~= true then return end

	for _, bagFrame in pairs(self.BagFrames) do
		if bagFrame.UpdateAllSlots then
			bagFrame:UpdateAllSlots()
		end
	end
end

function B:NewItemGlowSlotSwitch(slot, show)
	if slot and slot.newItemGlow then
		if show and E.db.bags.newItemGlow then
			slot.newItemGlow:Show()
			E:Flash(slot.newItemGlow, 0.5, true)
		else
			slot.newItemGlow:Hide()
			E:StopFlash(slot.newItemGlow)

			-- also clear them on blizzard's side
			if slot.bagID and slot.slotID then
				C_NewItems_RemoveNewItem(slot.bagID, slot.slotID)
			end
		end
	end
end

function B:NewItemGlowBagClear(bagFrame)
	if not (bagFrame and bagFrame.BagIDs) then return end

	for _, bagID in ipairs(bagFrame.BagIDs) do
		for slotID = 1, GetContainerNumSlots(bagID) do
			if bagFrame.Bags[bagID][slotID] then
				B:NewItemGlowSlotSwitch(bagFrame.Bags[bagID][slotID])
			end
		end
	end
end

local function hideNewItemGlow(slot)
	B:NewItemGlowSlotSwitch(slot)
end

function B:UpdateSlot(bagID, slotID)
	if (self.Bags[bagID] and self.Bags[bagID].numSlots ~= GetContainerNumSlots(bagID)) or not self.Bags[bagID] or not self.Bags[bagID][slotID] then return end

	local slot = self.Bags[bagID][slotID]
	local bagType = self.Bags[bagID].type
	local texture, count, locked, _, readable = GetContainerItemInfo(bagID, slotID)
	local clink = GetContainerItemLink(bagID, slotID)

	slot.name, slot.rarity = nil, nil

	slot:Show()
	slot.questIcon:Hide()
	slot.JunkIcon:Hide()
	slot.itemLevel:SetText("")
	slot.bindType:SetText("")

	if B.ProfessionColors[bagType] then
		local r, g, b = unpack(B.ProfessionColors[bagType])
		slot.newItemGlow:SetVertexColor(r, g, b)
		slot:SetBackdropBorderColor(r, g, b)
		slot.ignoreBorderColors = true
	elseif clink then
		local iLvl, itemEquipLoc
		slot.name, _, slot.rarity, iLvl, _, iType, _, _, itemEquipLoc, _, itemPrice = GetItemInfo(clink)

		local isQuestItem, questId, isActiveQuest = GetContainerItemQuestInfo(bagID, slotID)
		local r, g, b

		if slot.rarity then
			r, g, b = GetItemQualityColor(slot.rarity)
		end

		if B.db.showBindType and (slot.rarity and slot.rarity > 1) then
			E.ScanTooltip:SetOwner(self, "ANCHOR_NONE")
			E.ScanTooltip:SetBagItem(bagID, slotID)
			E.ScanTooltip:Show()

			for i = 2, 6 do -- trying line 2 to 6 for the bind texts, don't think they are further down
				local line = _G[E.ScanTooltip:GetName().."TextLeft"..i]:GetText()
				if (not line) or (line == ITEM_SOULBOUND or line == ITEM_ACCOUNTBOUND or line == ITEM_BNETACCOUNTBOUND) then break end

				if line == ITEM_BIND_ON_EQUIP then
					slot.bindType:SetText(L["BoE"])
					slot.bindType:SetVertexColor(r, g, b)
					break
				end
				if line == ITEM_BIND_ON_USE then
					slot.bindType:SetText(L["BoU"])
					slot.bindType:SetVertexColor(r, g, b)
					break
				end
			end

			E.ScanTooltip:Hide()
		end

		-- Item Level
		if iLvl and B.db.itemLevel and (itemEquipLoc ~= nil and itemEquipLoc ~= "" and itemEquipLoc ~= "INVTYPE_BAG" and itemEquipLoc ~= "INVTYPE_QUIVER" and itemEquipLoc ~= "INVTYPE_TABARD") and (slot.rarity and slot.rarity > 1) then
			local upgradeBonus = tonumber(match(clink, ":(%d+)\124h%["))

			local iLvlBonus = UpgradeTable[upgradeBonus] and UpgradeTable[upgradeBonus].ilevel or 0
			iLvl = iLvl + iLvlBonus

			if iLvl >= E.db.bags.itemLevelThreshold then
				slot.itemLevel:SetText(iLvl)
				if B.db.itemLevelCustomColorEnable then
					slot.itemLevel:SetTextColor(B.db.itemLevelCustomColor.r, B.db.itemLevelCustomColor.g, B.db.itemLevelCustomColor.b)
				else
					slot.itemLevel:SetTextColor(r, g, b)
				end
			end
		end

		-- Junk Icon
		if slot.JunkIcon then
			if E.db.bags.junkIcon and (slot.rarity and slot.rarity == 0) and (itemPrice and itemPrice > 0) and (iType and iType ~= "Quest") then
				slot.JunkIcon:Show()
			end
		end

		-- color slot according to item quality
		if questId and not isActiveQuest then
			slot.newItemGlow:SetVertexColor(unpack(B.QuestColors.questStarter))
			slot:SetBackdropBorderColor(unpack(B.QuestColors.questStarter))
			slot.ignoreBorderColors = true
			slot.questIcon:Show()
		elseif questId or isQuestItem then
			slot.newItemGlow:SetVertexColor(unpack(B.QuestColors.questItem))
			slot:SetBackdropBorderColor(unpack(B.QuestColors.questItem))
			slot.ignoreBorderColors = true
		elseif B.db.qualityColors and slot.rarity and slot.rarity > 1 then
			slot.newItemGlow:SetVertexColor(r, g, b)
			slot:SetBackdropBorderColor(r, g, b)
			slot.ignoreBorderColors = true
		else
			slot.newItemGlow:SetVertexColor(1, 1, 1)
			slot:SetBackdropBorderColor(unpack(E.media.bordercolor))
			slot.ignoreBorderColors = nil
		end
	else
		slot.newItemGlow:SetVertexColor(1, 1, 1)
		slot:SetBackdropBorderColor(unpack(E.media.bordercolor))
		slot.ignoreBorderColors = nil
	end

	B:NewItemGlowSlotSwitch(slot, C_NewItems_IsNewItem(bagID, slotID))

	if texture then
		local start, duration, enable = GetContainerItemCooldown(bagID, slotID)
		CooldownFrame_SetTimer(slot.cooldown, start, duration, enable)
		if duration > 0 and enable == 0 then
			SetItemButtonTextureVertexColor(slot, 0.4, 0.4, 0.4)
		else
			SetItemButtonTextureVertexColor(slot, 1, 1, 1)
		end
		slot.hasItem = 1
	else
		slot.cooldown:Hide()
		slot.hasItem = nil
	end

	slot.readable = readable

	SetItemButtonTexture(slot, texture)
	SetItemButtonCount(slot, count)
	SetItemButtonDesaturated(slot, locked)

	if GameTooltip:GetOwner() == slot and not slot.hasItem then
		B:Tooltip_Hide()
	end
end

function B:UpdateBagSlots(bagID)
	for slotID = 1, GetContainerNumSlots(bagID) do
		if self.UpdateSlot then
			self:UpdateSlot(bagID, slotID)
		else
			self:GetParent():GetParent():UpdateSlot(bagID, slotID)
		end
	end
end

function B:RefreshSearch()
	B:SetSearch(SEARCH_STRING)
end

function B:SortingFadeBags(bagFrame)
	if not (bagFrame and bagFrame.BagIDs) then return end

	for _, bagID in ipairs(bagFrame.BagIDs) do
		for slotID = 1, GetContainerNumSlots(bagID) do
			local button = bagFrame.Bags[bagID][slotID]
			SetItemButtonDesaturated(button, 1)
			button.searchOverlay:Show()
			button:SetAlpha(0.5)
		end
	end
end

function B:UpdateCooldowns()
	for _, bagID in ipairs(self.BagIDs) do
		for slotID = 1, GetContainerNumSlots(bagID) do
			local start, duration, enable = GetContainerItemCooldown(bagID, slotID)
			CooldownFrame_SetTimer(self.Bags[bagID][slotID].cooldown, start, duration, enable)
		end
	end
end

function B:UpdateAllSlots()
	for _, bagID in ipairs(self.BagIDs) do
		if self.Bags[bagID] then
			self.Bags[bagID]:UpdateBagSlots(bagID)
		end
	end

	-- Refresh search in case we moved items around
	if (not self.registerUpdate) and B:IsSearching() then
		B:RefreshSearch()
	end
end

function B:SetSlotAlphaForBag(f)
	for _, bagID in ipairs(f.BagIDs) do
		if f.Bags[bagID] then
			local numSlots = GetContainerNumSlots(bagID)
			for slotID = 1, numSlots do
				if f.Bags[bagID][slotID] then
					if bagID == self.id then
						f.Bags[bagID][slotID]:SetAlpha(1)
					else
						f.Bags[bagID][slotID]:SetAlpha(0.1)
					end
				end
			end
		end
	end
end

function B:ResetSlotAlphaForBags(f)
	for _, bagID in ipairs(f.BagIDs) do
		if f.Bags[bagID] then
			local numSlots = GetContainerNumSlots(bagID)
			for slotID = 1, numSlots do
				if f.Bags[bagID][slotID] then
					f.Bags[bagID][slotID]:SetAlpha(1)
				end
			end
		end
	end
end

function B:Layout(isBank)
	if E.private.bags.enable ~= true then return end
	local f = self:GetContainerFrame(isBank)

	if not f then return end
	local buttonSize = isBank and self.db.bankSize or self.db.bagSize
	local buttonSpacing = E.PixelMode and 2 or 4
	local containerWidth = ((isBank and self.db.bankWidth) or self.db.bagWidth)
	local numContainerColumns = floor(containerWidth / (buttonSize + buttonSpacing))
	local holderWidth = ((buttonSize + buttonSpacing) * numContainerColumns) - buttonSpacing
	local numContainerRows = 0
	local numBags = 0
	local numBagSlots = 0
	local bagSpacing = self.db.split.bagSpacing
	local countColor = E.db.bags.countFontColor
	f.holderFrame:Width(holderWidth)

	local isSplit = self.db.split[isBank and "bank" or "player"]

	f.totalSlots = 0
	local lastButton
	local lastRowButton
	local lastContainerButton
	local numContainerSlots = GetNumBankSlots()
	local newBag

	for i, bagID in ipairs(f.BagIDs) do
		if isSplit then
			newBag = (bagID ~= -1 or bagID ~= 0) and self.db.split["bag"..bagID] or false
		end

		--Bag Containers
		if (not isBank and bagID <= 3) or (isBank and bagID ~= -1 and numContainerSlots >= 1 and not (i - 1 > numContainerSlots)) then
			if not f.ContainerHolder[i] then
				if isBank then
					f.ContainerHolder[i] = CreateFrame("CheckButton", "ElvUIBankBag"..bagID - 4, f.ContainerHolder, "BankItemButtonBagTemplate")
					f.ContainerHolder[i]:SetScript("OnClick", function(holder)
						local inventoryID = holder:GetInventorySlot()
						PutItemInBag(inventoryID) --Put bag on empty slot, or drop item in this bag
					end)
				--	f.ContainerHolder[i].id = bagID
				else
					f.ContainerHolder[i] = CreateFrame("CheckButton", "ElvUIMainBag"..bagID.."Slot", f.ContainerHolder, "BagSlotButtonTemplate")
					f.ContainerHolder[i]:SetScript("OnClick", function(holder)
						local id = holder:GetID()
						PutItemInBag(id) --Put bag on empty slot, or drop item in this bag
					end)
				end

				f.ContainerHolder[i]:CreateBackdrop("Default", true)
				f.ContainerHolder[i].backdrop:SetAllPoints()
				f.ContainerHolder[i]:StyleButton()
				f.ContainerHolder[i]:SetNormalTexture("")
				f.ContainerHolder[i]:SetCheckedTexture(nil)
				f.ContainerHolder[i]:SetPushedTexture("")

				f.ContainerHolder[i].id = isBank and bagID or bagID + 1
				f.ContainerHolder[i]:HookScript("OnEnter", function(ch) B.SetSlotAlphaForBag(ch, f) end)
				f.ContainerHolder[i]:HookScript("OnLeave", function(ch) B.ResetSlotAlphaForBags(ch, f) end)

				if isBank then
					f.ContainerHolder[i]:SetID(bagID)
					if not f.ContainerHolder[i].tooltipText then
						f.ContainerHolder[i].tooltipText = ""
					end
				end

				f.ContainerHolder[i].iconTexture = _G[f.ContainerHolder[i]:GetName().."IconTexture"]
				f.ContainerHolder[i].iconTexture:SetInside()
				f.ContainerHolder[i].iconTexture:SetTexCoord(unpack(E.TexCoords))
			end

			f.ContainerHolder:Size(((buttonSize + buttonSpacing) * (isBank and i - 1 or i)) + buttonSpacing,buttonSize + (buttonSpacing * 2))

			if isBank then
				BankFrameItemButton_Update(f.ContainerHolder[i])
				BankFrameItemButton_UpdateLocked(f.ContainerHolder[i])
			end

			f.ContainerHolder[i]:Size(buttonSize)
			f.ContainerHolder[i]:ClearAllPoints()
			if (isBank and i == 2) or (not isBank and i == 1) then
				f.ContainerHolder[i]:Point("BOTTOMLEFT", f.ContainerHolder, "BOTTOMLEFT", buttonSpacing, buttonSpacing)
			else
				f.ContainerHolder[i]:Point("LEFT", lastContainerButton, "RIGHT", buttonSpacing, 0)
			end

			lastContainerButton = f.ContainerHolder[i]
		end

		--Bag Slots
		local numSlots = GetContainerNumSlots(bagID)
		if numSlots > 0 then
			if not f.Bags[bagID] then
				f.Bags[bagID] = CreateFrame("Frame", f:GetName().."Bag"..bagID, f.holderFrame)
				f.Bags[bagID]:SetID(bagID)
				f.Bags[bagID].UpdateBagSlots = B.UpdateBagSlots
				f.Bags[bagID].UpdateSlot = UpdateSlot
			end

			f.Bags[bagID].numSlots = numSlots
			f.Bags[bagID].type = select(2, GetContainerNumFreeSlots(bagID))

			--Hide unused slots
			for y = 1, MAX_CONTAINER_ITEMS do
				if f.Bags[bagID][y] then
					f.Bags[bagID][y]:Hide()
				end
			end

			for slotID = 1, numSlots do
				f.totalSlots = f.totalSlots + 1
				if not f.Bags[bagID][slotID] then
					f.Bags[bagID][slotID] = CreateFrame("CheckButton", f.Bags[bagID]:GetName().."Slot"..slotID, f.Bags[bagID], bagID == -1 and "BankItemButtonGenericTemplate" or "ContainerFrameItemButtonTemplate")
					f.Bags[bagID][slotID]:StyleButton()
					f.Bags[bagID][slotID]:SetTemplate("Default", true)
					f.Bags[bagID][slotID]:SetNormalTexture(nil)
					f.Bags[bagID][slotID]:SetCheckedTexture(nil)

					if _G[f.Bags[bagID][slotID]:GetName().."NewItemTexture"] then
						_G[f.Bags[bagID][slotID]:GetName().."NewItemTexture"]:Hide()
					end

					f.Bags[bagID][slotID].Count = _G[f.Bags[bagID][slotID]:GetName().."Count"]
					f.Bags[bagID][slotID].Count:ClearAllPoints()
					f.Bags[bagID][slotID].Count:Point("BOTTOMRIGHT", 0, 2)
					f.Bags[bagID][slotID].Count:FontTemplate(E.Libs.LSM:Fetch("font", E.db.bags.countFont), E.db.bags.countFontSize, E.db.bags.countFontOutline)
					f.Bags[bagID][slotID].Count:SetTextColor(countColor.r, countColor.g, countColor.b)

					if not f.Bags[bagID][slotID].questIcon then
						f.Bags[bagID][slotID].questIcon = _G[f.Bags[bagID][slotID]:GetName().."IconQuestTexture"] or _G[f.Bags[bagID][slotID]:GetName()].IconQuestTexture
						f.Bags[bagID][slotID].questIcon:SetTexture("Interface\\AddOns\\ElvUI\\media\\textures\\bagQuestIcon")
						f.Bags[bagID][slotID].questIcon:SetTexCoord(0, 1, 0, 1)
						f.Bags[bagID][slotID].questIcon:SetInside()
						f.Bags[bagID][slotID].questIcon:Hide()
					end

					if not f.Bags[bagID][slotID].JunkIcon then
						local JunkIcon = f.Bags[bagID][slotID]:CreateTexture(nil, "OVERLAY")
						JunkIcon:SetTexture("Interface\\AddOns\\ElvUI\\media\\textures\\bagJunkIcon")
						JunkIcon:Point("TOPLEFT", 1, 0)
						JunkIcon:Hide()
						f.Bags[bagID][slotID].JunkIcon = JunkIcon
					end

					f.Bags[bagID][slotID].iconTexture = _G[f.Bags[bagID][slotID]:GetName().."IconTexture"]
					f.Bags[bagID][slotID].iconTexture:SetInside(f.Bags[bagID][slotID])
					f.Bags[bagID][slotID].iconTexture:SetTexCoord(unpack(E.TexCoords))

					f.Bags[bagID][slotID].searchOverlay:SetAllPoints()

					f.Bags[bagID][slotID].cooldown = _G[f.Bags[bagID][slotID]:GetName().."Cooldown"]
					f.Bags[bagID][slotID].cooldown.CooldownOverride = "bags"
					E:RegisterCooldown(f.Bags[bagID][slotID].cooldown)
					f.Bags[bagID][slotID].bagID = bagID
					f.Bags[bagID][slotID].slotID = slotID

					f.Bags[bagID][slotID].itemLevel = f.Bags[bagID][slotID]:CreateFontString(nil, "OVERLAY")
					f.Bags[bagID][slotID].itemLevel:Point("BOTTOMRIGHT", 0, 2)
					f.Bags[bagID][slotID].itemLevel:FontTemplate(E.Libs.LSM:Fetch("font", E.db.bags.itemLevelFont), E.db.bags.itemLevelFontSize, E.db.bags.itemLevelFontOutline)

					f.Bags[bagID][slotID].bindType = f.Bags[bagID][slotID]:CreateFontString(nil, "OVERLAY")
					f.Bags[bagID][slotID].bindType:Point("TOP", 0, -2)
					f.Bags[bagID][slotID].bindType:FontTemplate(E.Libs.LSM:Fetch("font", E.db.bags.itemLevelFont), E.db.bags.itemLevelFontSize, E.db.bags.itemLevelFontOutline)

					if not f.Bags[bagID][slotID].newItemGlow then
						local newItemGlow = f.Bags[bagID][slotID]:CreateTexture(nil, "OVERLAY")
						newItemGlow:SetInside()
						newItemGlow:SetTexture("Interface\\AddOns\\ElvUI\\media\\textures\\bagNewItemGlow")
						newItemGlow:Hide()
						f.Bags[bagID][slotID].newItemGlow = newItemGlow
						f.Bags[bagID][slotID]:HookScript("OnEnter", hideNewItemGlow)
					end
				end

				f.Bags[bagID][slotID]:SetID(slotID)
				f.Bags[bagID][slotID]:Size(buttonSize)

				if f.Bags[bagID][slotID].JunkIcon then
					f.Bags[bagID][slotID].JunkIcon:Size(buttonSize/2)
				end

				f:UpdateSlot(bagID, slotID)

				if f.Bags[bagID][slotID]:GetPoint() then
					f.Bags[bagID][slotID]:ClearAllPoints()
				end

				if lastButton then
					local anchorPoint, relativePoint = (self.db.reverseSlots and "BOTTOM" or "TOP"), (self.db.reverseSlots and "TOP" or "BOTTOM")
					if isSplit and newBag and slotID == 1 then
						f.Bags[bagID][slotID]:Point(anchorPoint, lastRowButton, relativePoint, 0, self.db.reverseSlots and (buttonSpacing + bagSpacing) or -(buttonSpacing + bagSpacing))
						lastRowButton = f.Bags[bagID][slotID]
						numContainerRows = numContainerRows + 1
						numBags = numBags + 1
						numBagSlots = 0
					elseif isSplit and numBagSlots % numContainerColumns == 0 then
						f.Bags[bagID][slotID]:Point(anchorPoint, lastRowButton, relativePoint, 0, self.db.reverseSlots and buttonSpacing or -buttonSpacing)
						lastRowButton = f.Bags[bagID][slotID]
						numContainerRows = numContainerRows + 1
					elseif (not isSplit) and (f.totalSlots - 1) % numContainerColumns == 0 then
						f.Bags[bagID][slotID]:Point(anchorPoint, lastRowButton, relativePoint, 0, self.db.reverseSlots and buttonSpacing or -buttonSpacing)
						lastRowButton = f.Bags[bagID][slotID]
						numContainerRows = numContainerRows + 1
					else
						anchorPoint, relativePoint = (self.db.reverseSlots and "RIGHT" or "LEFT"), (self.db.reverseSlots and "LEFT" or "RIGHT")
						f.Bags[bagID][slotID]:Point(anchorPoint, lastButton, relativePoint, self.db.reverseSlots and -buttonSpacing or buttonSpacing, 0)
					end
				else
					local anchorPoint = self.db.reverseSlots and "BOTTOMRIGHT" or "TOPLEFT"
					f.Bags[bagID][slotID]:Point(anchorPoint, f.holderFrame, anchorPoint, 0, self.db.reverseSlots and f.bottomOffset - 8 or 0)
					lastRowButton = f.Bags[bagID][slotID]
					numContainerRows = numContainerRows + 1
				end

				lastButton = f.Bags[bagID][slotID]
				numBagSlots = numBagSlots + 1
			end
		else
			--Hide unused slots
			for y = 1, MAX_CONTAINER_ITEMS do
				if f.Bags[bagID] and f.Bags[bagID][y] then
					f.Bags[bagID][y]:Hide()
				end
			end

			if f.Bags[bagID] then
				f.Bags[bagID].numSlots = numSlots
			end

			if self.isBank then
				if self.ContainerHolder[i] then
					BankFrameItemButton_Update(self.ContainerHolder[i])
					BankFrameItemButton_UpdateLocked(self.ContainerHolder[i])
				end
			end
		end
	end

	f:Size(containerWidth, (((buttonSize + buttonSpacing) * numContainerRows) - buttonSpacing) + (isSplit and (numBags * bagSpacing) or 0 ) + f.topOffset + f.bottomOffset) -- 8 is the cussion of the f.holderFrame
end

function B:UpdateAll()
	if self.BagFrame then
		self:Layout()
	end

	if self.BankFrame then
		self:Layout(true)
	end
end

function B:OnEvent(event, ...)
	if event == "ITEM_LOCK_CHANGED" or event == "ITEM_UNLOCKED" then
		local bag, slot = ...
		self:UpdateSlot(bag, slot)
	elseif event == "BAG_UPDATE" then
		for _, bagID in ipairs(self.BagIDs) do
			local numSlots = GetContainerNumSlots(bagID)
			if (not self.Bags[bagID] and numSlots ~= 0) or (self.Bags[bagID] and numSlots ~= self.Bags[bagID].numSlots) then
				B:Layout(self.isBank)
				return
			end
		end

		self:UpdateBagSlots(...)

		--Refresh search in case we moved items around
		if B:IsSearching() then
			B:RefreshSearch()
		end
	elseif event == "BAG_UPDATE_COOLDOWN" then
		if not self:IsShown() then return end
		self:UpdateCooldowns()
	elseif event == "PLAYERBANKSLOTS_CHANGED" then
		local slot = ...
		local bagID = (slot <= NUM_BANKGENERIC_SLOTS) and -1 or (slot - NUM_BANKGENERIC_SLOTS)
		if bagID > -1 then
			B:Layout(true)
		else
			self:UpdateBagSlots(-1)
		end
	elseif (event == "QUEST_ACCEPTED" or event == "QUEST_REMOVED") and self:IsShown() then
		self:UpdateAllSlots()
	end
end

function B:UpdateTokens()
	local f = self.BagFrame

	local numTokens = 0
	for i = 1, MAX_WATCHED_TOKENS do
		local name, count, icon, currencyID = GetBackpackCurrencyInfo(i)
		local button = f.currencyButton[i]

		button:ClearAllPoints()
		if name then
			button.icon:SetTexture(icon)

			if self.db.currencyFormat == "ICON_TEXT" then
				button.text:SetText(name..": "..count)
			elseif self.db.currencyFormat == "ICON_TEXT_ABBR" then
				button.text:SetText(E:AbbreviateString(name)..": "..count)
			elseif self.db.currencyFormat == "ICON" then
				button.text:SetText(count)
			end

			button.currencyID = currencyID
			button:Show()
			numTokens = numTokens + 1
		else
			button:Hide()
		end
	end

	if numTokens == 0 then
		f.bottomOffset = 8

		if f.currencyButton:IsShown() then
			f.currencyButton:Hide()
			self:Layout()
		end

		return
	elseif not f.currencyButton:IsShown() then
		f.bottomOffset = 28
		f.currencyButton:Show()
		self:Layout()
	end

	f.bottomOffset = 28

	if numTokens == 1 then
		f.currencyButton[1]:Point("BOTTOM", f.currencyButton, "BOTTOM", -(f.currencyButton[1].text:GetWidth() / 2), 3)
	elseif numTokens == 2 then
		f.currencyButton[1]:Point("BOTTOM", f.currencyButton, "BOTTOM", -(f.currencyButton[1].text:GetWidth()) - (f.currencyButton[1]:GetWidth() / 2), 3)
		f.currencyButton[2]:Point("BOTTOMLEFT", f.currencyButton, "BOTTOM", f.currencyButton[2]:GetWidth() / 2, 3)
	else
		f.currencyButton[1]:Point("BOTTOMLEFT", f.currencyButton, "BOTTOMLEFT", 3, 3)
		f.currencyButton[2]:Point("BOTTOM", f.currencyButton, "BOTTOM", -(f.currencyButton[2].text:GetWidth() / 3), 3)
		f.currencyButton[3]:Point("BOTTOMRIGHT", f.currencyButton, "BOTTOMRIGHT", -(f.currencyButton[3].text:GetWidth()) - (f.currencyButton[3]:GetWidth() / 2), 3)
	end
end

function B:Token_OnEnter()
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetBackpackToken(self:GetID())
end

function B:Token_OnClick()
	if IsModifiedClick("CHATLINK") then
		HandleModifiedItemClick(GetCurrencyLink(self.currencyID))
	end
end

function B:UpdateGoldText()
	self.BagFrame.goldText:SetText(E:FormatMoney(GetMoney(), E.db.bags.moneyFormat, not E.db.bags.moneyCoins))
end

function B:FormatMoney(amount)
	local str, coppername, silvername, goldname = "", "|cffeda55fc|r", "|cffc7c7cfs|r", "|cffffd700g|r"

	local value = abs(amount)
	local gold = floor(value / 10000)
	local silver = floor((value / 100) % 100)
	local copper = floor(value % 100)

	if gold > 0 then
		str = format("%d%s%s", gold, goldname, (silver > 0 or copper > 0) and " " or "")
	end
	if silver > 0 then
		str = format("%s%d%s%s", str, silver, silvername, copper > 0 and " " or "")
	end
	if copper > 0 or value == 0 then
		str = format("%s%d%s", str, copper, coppername)
	end

	return str
end

function B:GetGraysValue()
	local value = 0

	for bag = 0, 4 do
		for slot = 1, GetContainerNumSlots(bag) do
			local itemID = GetContainerItemID(bag, slot)
			if itemID then
				local _, _, rarity, _, _, itype, _, _, _, _, itemPrice = GetItemInfo(itemID)
				if itemPrice then
					local stackCount = select(2, GetContainerItemInfo(bag, slot)) or 1
					local stackPrice = itemPrice * stackCount
					if (rarity and rarity == 0) and (itype and itype ~= "Quest") and (stackPrice > 0) then
						value = value + stackPrice
					end
				end
			end
		end
	end

	return value
end

function B:VendorGrays(delete)
	if B.SellFrame:IsShown() then return end
	if (not MerchantFrame or not MerchantFrame:IsShown()) and not delete then
		E:Print(L["You must be at a vendor."])
		return
	end

	for bag = 0, 4, 1 do
		for slot = 1, GetContainerNumSlots(bag), 1 do
			local itemID = GetContainerItemID(bag, slot)
			if itemID then
				local _, link, rarity, _, _, itype, _, _, _, _, itemPrice = GetItemInfo(itemID)

				if (rarity and rarity == 0) and (itype and itype ~= "Quest") and (itemPrice and itemPrice > 0) then
					tinsert(B.SellFrame.Info.itemList, {bag,slot,itemPrice,link})
				end
			end
		end
	end

	if (not B.SellFrame.Info.itemList) then return end
	if (tmaxn(B.SellFrame.Info.itemList) < 1) then return end

	--Resetting stuff
	B.SellFrame.Info.delete = delete or false
	B.SellFrame.Info.ProgressTimer = 0
	B.SellFrame.Info.SellInterval = 0.2
	B.SellFrame.Info.ProgressMax = tmaxn(B.SellFrame.Info.itemList)
	B.SellFrame.Info.goldGained = 0
	B.SellFrame.Info.itemsSold = 0

	B.SellFrame.statusbar:SetValue(0)
	B.SellFrame.statusbar:SetMinMaxValues(0, B.SellFrame.Info.ProgressMax)
	B.SellFrame.statusbar.ValueText:SetText("0 / "..B.SellFrame.Info.ProgressMax)

	--Time to sell
	B.SellFrame:Show()
end

function B:VendorGrayCheck()
	local value = B:GetGraysValue()

	if value == 0 then
		E:Print(L["No gray items to delete."])
	elseif not MerchantFrame or not MerchantFrame:IsShown() then
		E.PopupDialogs["DELETE_GRAYS"].Money = value
		E:StaticPopup_Show("DELETE_GRAYS")
	else
		B:VendorGrays()
	end
end

function B:ContructContainerFrame(name, isBank)
	if not SkinModule then SkinModule = E:GetModule("Skins") end

	local strata = E.db.bags.strata or "DIALOG"

	local f = CreateFrame("Button", name, E.UIParent)
	f:SetTemplate("Transparent")
	f:SetFrameStrata(strata)
	f.UpdateSlot = B.UpdateSlot
	f.UpdateAllSlots = B.UpdateAllSlots
	f.UpdateBagSlots = B.UpdateBagSlots
	f.UpdateCooldowns = B.UpdateCooldowns
	f:RegisterEvent("BAG_UPDATE") -- Has to be on both frames
	f:RegisterEvent("BAG_UPDATE_COOLDOWN") -- Has to be on both frames
	f.events = isBank and {"PLAYERBANKSLOTS_CHANGED"} or {"ITEM_LOCK_CHANGED", "ITEM_UNLOCKED", "QUEST_ACCEPTED", "QUEST_REMOVED"}

	for _, event in pairs(f.events) do
		f:RegisterEvent(event)
	end

	f:SetScript("OnEvent", B.OnEvent)
	f:Hide()

	f.isBank = isBank
	f.bottomOffset = isBank and 8 or 28
	f.topOffset = isBank and 45 or 50
	f.BagIDs = isBank and {-1, 5, 6, 7, 8, 9, 10, 11} or {0, 1, 2, 3, 4}
	f.Bags = {}

	local mover = (isBank and ElvUIBankMover) or ElvUIBagMover
	if mover then
		f:Point(mover.POINT, mover)
		f.mover = mover
	end

	--Allow dragging the frame around
	f:SetMovable(true)
	f:RegisterForDrag("LeftButton", "RightButton")
	f:RegisterForClicks("AnyUp")
	f:SetScript("OnDragStart", function(frame) if IsShiftKeyDown() then frame:StartMoving() end end)
	f:SetScript("OnDragStop", function(frame) frame:StopMovingOrSizing() end)
	f:SetScript("OnClick", function(frame) if IsControlKeyDown() then B.PostBagMove(frame.mover) end end)
	f:SetScript("OnLeave", function() GameTooltip:Hide() end)
	f:SetScript("OnEnter", function(frame)
		GameTooltip:SetOwner(frame, "ANCHOR_TOPLEFT", 0, 4)
		GameTooltip:ClearLines()
		GameTooltip:AddDoubleLine(L["Hold Shift + Drag:"], L["Temporary Move"], 1, 1, 1)
		GameTooltip:AddDoubleLine(L["Hold Control + Right Click:"], L["Reset Position"], 1, 1, 1)
		GameTooltip:Show()
	end)

	f.closeButton = CreateFrame("Button", name.."CloseButton", f, "UIPanelCloseButton")
	f.closeButton:Point("TOPRIGHT", -4, -4)

	SkinModule:HandleCloseButton(f.closeButton)

	f.holderFrame = CreateFrame("Frame", nil, f)
	f.holderFrame:Point("TOP", f, "TOP", 0, -f.topOffset)
	f.holderFrame:Point("BOTTOM", f, "BOTTOM", 0, 8)

	f.ContainerHolder = CreateFrame("Button", name.."ContainerHolder", f)
	f.ContainerHolder:Point("BOTTOMLEFT", f, "TOPLEFT", 0, 1)
	f.ContainerHolder:SetTemplate("Transparent")
	f.ContainerHolder:Hide()

	if isBank then
		--Bag Text
		f.bagText = f:CreateFontString(nil, "OVERLAY")
		f.bagText:FontTemplate()
		f.bagText:Point("BOTTOMRIGHT", f.holderFrame, "TOPRIGHT", -2, 4)
		f.bagText:SetJustifyH("RIGHT")
		f.bagText:SetText(L["Bank"])

		--Sort Button
		f.sortButton = CreateFrame("Button", name.."SortButton", f)
		f.sortButton:SetSize(16 + E.Border, 16 + E.Border)
		f.sortButton:SetTemplate()
		f.sortButton:Point("RIGHT", f.bagText, "LEFT", -5, E.Border * 2)
		f.sortButton:SetNormalTexture("Interface\\ICONS\\INV_Pet_Broom")
		f.sortButton:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		f.sortButton:GetNormalTexture():SetInside()
		f.sortButton:SetPushedTexture("Interface\\ICONS\\INV_Pet_Broom")
		f.sortButton:GetPushedTexture():SetTexCoord(unpack(E.TexCoords))
		f.sortButton:GetPushedTexture():SetInside()
		f.sortButton:SetDisabledTexture("Interface\\ICONS\\INV_Pet_Broom")
		f.sortButton:GetDisabledTexture():SetTexCoord(unpack(E.TexCoords))
		f.sortButton:GetDisabledTexture():SetInside()
		f.sortButton:GetDisabledTexture():SetDesaturated(true)
		f.sortButton:StyleButton(nil, true)
		f.sortButton.ttText = L["Sort Bags"]
		f.sortButton:SetScript("OnEnter", self.Tooltip_Show)
		f.sortButton:SetScript("OnLeave", self.Tooltip_Hide)
		f.sortButton:SetScript("OnClick", function()
			f:UnregisterAllEvents() --Unregister to prevent unnecessary updates
			if not f.registerUpdate then
				B:SortingFadeBags(f)
			end
			f.registerUpdate = true --Set variable that indicates this bag should be updated when sorting is done
			B:CommandDecorator(B.SortBags, "bank")()
		end)
		if E.db.bags.disableBankSort then
			f.sortButton:Disable()
		end

		--Toggle Bags Button
		f.bagsButton = CreateFrame("Button", name.."BagsButton", f.holderFrame)
		f.bagsButton:SetSize(16 + E.Border, 16 + E.Border)
		f.bagsButton:SetTemplate()
		f.bagsButton:Point("RIGHT", f.sortButton, "LEFT", -5, 0)
		f.bagsButton:SetNormalTexture("Interface\\Buttons\\Button-Backpack-Up")
		f.bagsButton:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		f.bagsButton:GetNormalTexture():SetInside()
		f.bagsButton:SetPushedTexture("Interface\\Buttons\\Button-Backpack-Up")
		f.bagsButton:GetPushedTexture():SetTexCoord(unpack(E.TexCoords))
		f.bagsButton:GetPushedTexture():SetInside()
		f.bagsButton:StyleButton(nil, true)
		f.bagsButton.ttText = L["Toggle Bags"]
		f.bagsButton:SetScript("OnEnter", self.Tooltip_Show)
		f.bagsButton:SetScript("OnLeave", self.Tooltip_Hide)
		f.bagsButton:SetScript("OnClick", function()
			local numSlots = GetNumBankSlots()
			PlaySound("igMainMenuOption")
			if numSlots >= 1 then
				ToggleFrame(f.ContainerHolder)
			else
				E:StaticPopup_Show("NO_BANK_BAGS")
			end
		end)

		f.purchaseBagButton = CreateFrame("Button", nil, f.holderFrame)
		f.purchaseBagButton:SetSize(16 + E.Border, 16 + E.Border)
		f.purchaseBagButton:SetTemplate()
		f.purchaseBagButton:Point("RIGHT", f.bagsButton, "LEFT", -5, 0)
		f.purchaseBagButton:SetNormalTexture("Interface\\ICONS\\INV_Misc_Coin_01")
		f.purchaseBagButton:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		f.purchaseBagButton:GetNormalTexture():SetInside()
		f.purchaseBagButton:SetPushedTexture("Interface\\ICONS\\INV_Misc_Coin_01")
		f.purchaseBagButton:GetPushedTexture():SetTexCoord(unpack(E.TexCoords))
		f.purchaseBagButton:GetPushedTexture():SetInside()
		f.purchaseBagButton:StyleButton(nil, true)
		f.purchaseBagButton.ttText = L["Purchase Bags"]
		f.purchaseBagButton:SetScript("OnEnter", self.Tooltip_Show)
		f.purchaseBagButton:SetScript("OnLeave", self.Tooltip_Hide)
		f.purchaseBagButton:SetScript("OnClick", function()
			local _, full = GetNumBankSlots()
			if full then
				E:StaticPopup_Show("CANNOT_BUY_BANK_SLOT")
			else
				E:StaticPopup_Show("BUY_BANK_SLOT")
			end
		end)

		f:SetScript("OnHide", function()
			CloseBankFrame()

			B:NewItemGlowBagClear(f)

			if E.db.bags.clearSearchOnClose then
				B.ResetAndClear(f.editBox)
			end
		end)

		--Search
		f.editBox = CreateFrame("EditBox", name.."EditBox", f)
		f.editBox:SetFrameLevel(f.editBox:GetFrameLevel() + 2)
		f.editBox:CreateBackdrop("Default")
		f.editBox.backdrop:Point("TOPLEFT", f.editBox, "TOPLEFT", -20, 2)
		f.editBox:Height(15)
		f.editBox:Point("BOTTOMLEFT", f.holderFrame, "TOPLEFT", (E.Border * 2) + 18, E.Border * 2 + 2)
		f.editBox:Point("RIGHT", f.purchaseBagButton, "LEFT", -5, 0)
		f.editBox:SetAutoFocus(false)
		f.editBox:SetScript("OnEscapePressed", self.ResetAndClear)
		f.editBox:SetScript("OnEnterPressed", function(eb) eb:ClearFocus() end)
		f.editBox:SetScript("OnEditFocusGained", f.editBox.HighlightText)
		f.editBox:SetScript("OnTextChanged", self.UpdateSearch)
		f.editBox:SetScript("OnChar", self.UpdateSearch)
		f.editBox:SetText(SEARCH)
		f.editBox:FontTemplate()

		f.editBox.searchIcon = f.editBox:CreateTexture(nil, "OVERLAY")
		f.editBox.searchIcon:SetTexture("Interface\\Common\\UI-Searchbox-Icon")
		f.editBox.searchIcon:Point("LEFT", f.editBox.backdrop, "LEFT", E.Border + 1, -1)
		f.editBox.searchIcon:SetSize(15, 15)
	else
		--Gold Text
		f.goldText = f:CreateFontString(nil, "OVERLAY")
		f.goldText:FontTemplate()
		f.goldText:Point("BOTTOMRIGHT", f.holderFrame, "TOPRIGHT", -2, 4)
		f.goldText:SetJustifyH("RIGHT")

		--Sort Button
		f.sortButton = CreateFrame("Button", name.."SortButton", f)
		f.sortButton:SetSize(16 + E.Border, 16 + E.Border)
		f.sortButton:SetTemplate()
		f.sortButton:Point("RIGHT", f.goldText, "LEFT", -5, E.Border * 2)
		f.sortButton:SetNormalTexture("Interface\\ICONS\\INV_Pet_Broom")
		f.sortButton:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		f.sortButton:GetNormalTexture():SetInside()
		f.sortButton:SetPushedTexture("Interface\\ICONS\\INV_Pet_Broom")
		f.sortButton:GetPushedTexture():SetTexCoord(unpack(E.TexCoords))
		f.sortButton:GetPushedTexture():SetInside()
		f.sortButton:SetDisabledTexture("Interface\\ICONS\\INV_Pet_Broom")
		f.sortButton:GetDisabledTexture():SetTexCoord(unpack(E.TexCoords))
		f.sortButton:GetDisabledTexture():SetInside()
		f.sortButton:GetDisabledTexture():SetDesaturated(true)
		f.sortButton:StyleButton(nil, true)
		f.sortButton.ttText = L["Sort Bags"]
		f.sortButton:SetScript("OnEnter", self.Tooltip_Show)
		f.sortButton:SetScript("OnLeave", self.Tooltip_Hide)
		f.sortButton:SetScript("OnClick", function()
			f:UnregisterAllEvents() --Unregister to prevent unnecessary updates
			if not f.registerUpdate then
				B:SortingFadeBags(f)
			end
			f.registerUpdate = true --Set variable that indicates this bag should be updated when sorting is done
			B:CommandDecorator(B.SortBags, "bags")()
		end)
		if E.db.bags.disableBagSort then
			f.sortButton:Disable()
		end

		--Bags Button
		f.bagsButton = CreateFrame("Button", name.."BagsButton", f)
		f.bagsButton:SetSize(16 + E.Border, 16 + E.Border)
		f.bagsButton:SetTemplate()
		f.bagsButton:Point("RIGHT", f.sortButton, "LEFT", -5, 0)
		f.bagsButton:SetNormalTexture("Interface\\Buttons\\Button-Backpack-Up")
		f.bagsButton:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		f.bagsButton:GetNormalTexture():SetInside()
		f.bagsButton:SetPushedTexture("Interface\\Buttons\\Button-Backpack-Up")
		f.bagsButton:GetPushedTexture():SetTexCoord(unpack(E.TexCoords))
		f.bagsButton:GetPushedTexture():SetInside()
		f.bagsButton:StyleButton(nil, true)
		f.bagsButton.ttText = L["Toggle Bags"]
		f.bagsButton:SetScript("OnEnter", self.Tooltip_Show)
		f.bagsButton:SetScript("OnLeave", self.Tooltip_Hide)
		f.bagsButton:SetScript("OnClick", function() ToggleFrame(f.ContainerHolder) end)

		--Vendor Grays
		f.vendorGraysButton = CreateFrame("Button", nil, f.holderFrame)
		f.vendorGraysButton:SetSize(16 + E.Border, 16 + E.Border)
		f.vendorGraysButton:SetTemplate()
		f.vendorGraysButton:Point("RIGHT", f.bagsButton, "LEFT", -5, 0)
		f.vendorGraysButton:SetNormalTexture("Interface\\ICONS\\INV_Misc_Coin_01")
		f.vendorGraysButton:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
		f.vendorGraysButton:GetNormalTexture():SetInside()
		f.vendorGraysButton:SetPushedTexture("Interface\\ICONS\\INV_Misc_Coin_01")
		f.vendorGraysButton:GetPushedTexture():SetTexCoord(unpack(E.TexCoords))
		f.vendorGraysButton:GetPushedTexture():SetInside()
		f.vendorGraysButton:StyleButton(nil, true)
		f.vendorGraysButton.ttText = L["Vendor / Delete Grays"]
		f.vendorGraysButton:SetScript("OnEnter", self.Tooltip_Show)
		f.vendorGraysButton:SetScript("OnLeave", self.Tooltip_Hide)
		f.vendorGraysButton:SetScript("OnClick", B.VendorGrayCheck)

		--Search
		f.editBox = CreateFrame("EditBox", name.."EditBox", f)
		f.editBox:SetFrameLevel(f.editBox:GetFrameLevel() + 2)
		f.editBox:CreateBackdrop("Default")
		f.editBox.backdrop:Point("TOPLEFT", f.editBox, "TOPLEFT", -20, 2)
		f.editBox:Height(15)
		f.editBox:Point("BOTTOMLEFT", f.holderFrame, "TOPLEFT", (E.Border * 2) + 18, E.Border * 2 + 2)
		f.editBox:Point("RIGHT", f.vendorGraysButton, "LEFT", -5, 0)
		f.editBox:SetAutoFocus(false)
		f.editBox:SetScript("OnEscapePressed", self.ResetAndClear)
		f.editBox:SetScript("OnEnterPressed", function(eb) eb:ClearFocus() end)
		f.editBox:SetScript("OnEditFocusGained", f.editBox.HighlightText)
		f.editBox:SetScript("OnTextChanged", self.UpdateSearch)
		f.editBox:SetScript("OnChar", self.UpdateSearch)
		f.editBox:SetText(SEARCH)
		f.editBox:FontTemplate()

		f.editBox.searchIcon = f.editBox:CreateTexture(nil, "OVERLAY")
		f.editBox.searchIcon:SetTexture("Interface\\Common\\UI-Searchbox-Icon")
		f.editBox.searchIcon:Point("LEFT", f.editBox.backdrop, "LEFT", E.Border + 1, -1)
		f.editBox.searchIcon:SetSize(15, 15)

		--Currency
		f.currencyButton = CreateFrame("Frame", nil, f)
		f.currencyButton:Point("BOTTOM", 0, 4)
		f.currencyButton:Point("TOPLEFT", f.holderFrame, "BOTTOMLEFT", 0, 18)
		f.currencyButton:Point("TOPRIGHT", f.holderFrame, "BOTTOMRIGHT", 0, 18)
		f.currencyButton:Height(22)

		for i = 1, MAX_WATCHED_TOKENS do
			f.currencyButton[i] = CreateFrame("Button", f:GetName().."CurrencyButton"..i, f.currencyButton)
			f.currencyButton[i]:Size(16)
			f.currencyButton[i]:SetTemplate("Default")
			f.currencyButton[i]:SetID(i)
			f.currencyButton[i].icon = f.currencyButton[i]:CreateTexture(nil, "OVERLAY")
			f.currencyButton[i].icon:SetInside()
			f.currencyButton[i].icon:SetTexCoord(unpack(E.TexCoords))
			f.currencyButton[i].text = f.currencyButton[i]:CreateFontString(nil, "OVERLAY")
			f.currencyButton[i].text:Point("LEFT", f.currencyButton[i], "RIGHT", 2, 0)
			f.currencyButton[i].text:FontTemplate()

			f.currencyButton[i]:SetScript("OnEnter", B.Token_OnEnter)
			f.currencyButton[i]:SetScript("OnLeave", function() GameTooltip:Hide() end)
			f.currencyButton[i]:SetScript("OnClick", B.Token_OnClick)
			f.currencyButton[i]:Hide()
		end

		f:SetScript("OnHide", function()
			CloseBackpack()
			for i = 1, NUM_BAG_FRAMES do
				CloseBag(i)
			end

			B:NewItemGlowBagClear(f)

			if ElvUIBags and ElvUIBags.buttons then
				for _, bagButton in pairs(ElvUIBags.buttons) do
					bagButton:SetChecked(false)
				end
			end

			if E.db.bags.clearSearchOnClose then
				B.ResetAndClear(f.editBox)
			end
		end)
	end

	f:SetScript("OnShow", function(self)
		self:UpdateCooldowns()
	end)

	tinsert(UISpecialFrames, f:GetName()) --Keep an eye on this for taints..
	tinsert(self.BagFrames, f)
	return f
end

function B:ToggleBags(id)
	if id and (GetContainerNumSlots(id) == 0) then return end --Closes a bag when inserting a new container..

	if self.BagFrame:IsShown() then
		self:CloseBags()
	else
		self:OpenBags()
	end
end

function B:ToggleBackpack()
	if IsOptionFrameOpen() then return end

	if IsBagOpen(0) then
		self:OpenBags()
		PlaySound("igBackPackOpen")
	else
		self:CloseBags()
		PlaySound("igBackPackClose")
	end
end

function B:ToggleSortButtonState(isBank)
	local button, disable
	if isBank and self.BankFrame then
		button = self.BankFrame.sortButton
		disable = E.db.bags.disableBankSort
	elseif not isBank and self.BagFrame then
		button = self.BagFrame.sortButton
		disable = E.db.bags.disableBagSort
	end

	if button and disable then
		button:Disable()
	elseif button and not disable then
		button:Enable()
	end
end

function B:OpenBags()
	self.BagFrame:Show()
	self.BagFrame:UpdateAllSlots()

	if not TooltipModule then TooltipModule = E:GetModule("Tooltip") end
	TooltipModule:GameTooltip_SetDefaultAnchor(GameTooltip)
end

function B:CloseBags()
	self.BagFrame:Hide()

	if self.BankFrame then
		self.BankFrame:Hide()
	end

	if not TooltipModule then TooltipModule = E:GetModule("Tooltip") end
	TooltipModule:GameTooltip_SetDefaultAnchor(GameTooltip)
end

function B:OpenBank()
	if not self.BankFrame then
		self.BankFrame = self:ContructContainerFrame("ElvUI_BankContainerFrame", true)
	end

	--Call :Layout first so all elements are created before we update
	self:Layout(true)

	self.BankFrame:Show()
	self.BankFrame:UpdateAllSlots()

	self:OpenBags()
	self:UpdateTokens()
end

function B:PLAYERBANKBAGSLOTS_CHANGED()
	self:Layout(true)
end

function B:GuildBankFrame_Update()
	B:SetGuildBankSearch(SEARCH_STRING)
end

function B:CloseBank()
	if not self.BankFrame then return end -- WHY??? WHO KNOWS!
	self.BankFrame:Hide()
end

function B:GUILDBANKFRAME_OPENED(event)
	if GuildItemSearchBox then
		GuildItemSearchBox:SetScript("OnEscapePressed", self.ResetAndClear)
		GuildItemSearchBox:SetScript("OnEnterPressed", function(sb) sb:ClearFocus() end)
		GuildItemSearchBox:SetScript("OnEditFocusGained", GuildItemSearchBox.HighlightText)
		GuildItemSearchBox:SetScript("OnTextChanged", self.UpdateSearch)
		GuildItemSearchBox:SetScript("OnChar", self.UpdateSearch)
	end

	hooksecurefunc("GuildBankFrame_Update", B.GuildBankFrame_Update)

	self:UnregisterEvent(event)
end

local playerEnteringWorldFunc = function() B:UpdateBagTypes() B:Layout() end
function B:PLAYER_ENTERING_WORLD()
	self:UpdateGoldText()

	E:Delay(2, playerEnteringWorldFunc) -- Update bag types for bagslot coloring
end

function B:UpdateContainerFrameAnchors()
	local xOffset, yOffset, screenHeight, freeScreenHeight, leftMostPoint, column
	local screenWidth = GetScreenWidth()
	local containerScale = 1
	local leftLimit = 0

	if BankFrame:IsShown() then
		leftLimit = BankFrame:GetRight() - 25
	end

	while containerScale > CONTAINER_SCALE do
		screenHeight = GetScreenHeight() / containerScale
		-- Adjust the start anchor for bags depending on the multibars
		xOffset = CONTAINER_OFFSET_X / containerScale
		yOffset = CONTAINER_OFFSET_Y / containerScale
		-- freeScreenHeight determines when to start a new column of bags
		freeScreenHeight = screenHeight - yOffset
		leftMostPoint = screenWidth - xOffset
		column = 1

		for _, frameName in ipairs(ContainerFrame1.bags) do
			local frameHeight = _G[frameName]:GetHeight()

			if freeScreenHeight < frameHeight then
				-- Start a new column
				column = column + 1
				leftMostPoint = screenWidth - (column * CONTAINER_WIDTH * containerScale) - xOffset
				freeScreenHeight = screenHeight - yOffset
			end

			freeScreenHeight = freeScreenHeight - frameHeight - VISIBLE_CONTAINER_SPACING
		end

		if leftMostPoint < leftLimit then
			containerScale = containerScale - 0.01
		else
			break
		end
	end

	if containerScale < CONTAINER_SCALE then
		containerScale = CONTAINER_SCALE
	end

	screenHeight = GetScreenHeight() / containerScale
	-- Adjust the start anchor for bags depending on the multibars
	-- xOffset = CONTAINER_OFFSET_X / containerScale
	yOffset = CONTAINER_OFFSET_Y / containerScale
	-- freeScreenHeight determines when to start a new column of bags
	freeScreenHeight = screenHeight - yOffset
	column = 0

	local bagsPerColumn = 0
	for index, frameName in ipairs(ContainerFrame1.bags) do
		local frame = _G[frameName]
		frame:SetScale(1)

		if index == 1 then
			-- First bag
			frame:Point("BOTTOMRIGHT", ElvUIBagMover, "BOTTOMRIGHT", E.Spacing, -E.Border)
			bagsPerColumn = bagsPerColumn + 1
		elseif freeScreenHeight < frame:GetHeight() then
			-- Start a new column
			column = column + 1
			freeScreenHeight = screenHeight - yOffset
			if column > 1 then
				frame:Point("BOTTOMRIGHT", ContainerFrame1.bags[(index - bagsPerColumn) - 1], "BOTTOMLEFT", -CONTAINER_SPACING, 0)
			else
				frame:Point("BOTTOMRIGHT", ContainerFrame1.bags[index - bagsPerColumn], "BOTTOMLEFT", -CONTAINER_SPACING, 0)
			end
			bagsPerColumn = 0
		else
			-- Anchor to the previous bag
			frame:Point("BOTTOMRIGHT", ContainerFrame1.bags[index - 1], "TOPRIGHT", 0, CONTAINER_SPACING)
			bagsPerColumn = bagsPerColumn + 1
		end

		freeScreenHeight = freeScreenHeight - frame:GetHeight() - VISIBLE_CONTAINER_SPACING
	end
end

function B:PostBagMove()
	if not E.private.bags.enable then return end

	-- self refers to the mover (bag or bank)
	local x, y = self:GetCenter()
	local screenHeight = E.UIParent:GetTop()
	local screenWidth = E.UIParent:GetRight()

	if y > (screenHeight / 2) then
		self:SetText(self.textGrowDown)
		self.POINT = ((x > (screenWidth/2)) and "TOPRIGHT" or "TOPLEFT")
	else
		self:SetText(self.textGrowUp)
		self.POINT = ((x > (screenWidth/2)) and "BOTTOMRIGHT" or "BOTTOMLEFT")
	end

	local bagFrame
	if self.name == "ElvUIBankMover" then
		bagFrame = B.BankFrame
	else
		bagFrame = B.BagFrame
	end

	if bagFrame then
		bagFrame:ClearAllPoints()
		bagFrame:Point(self.POINT, self)
	end
end

function B:MERCHANT_CLOSED()
	B.SellFrame:Hide()

	twipe(B.SellFrame.Info.itemList)
	B.SellFrame.Info.delete = false
	B.SellFrame.Info.ProgressTimer = 0
	B.SellFrame.Info.SellInterval = E.db.bags.vendorGrays.interval
	B.SellFrame.Info.ProgressMax = 0
	B.SellFrame.Info.goldGained = 0
	B.SellFrame.Info.itemsSold = 0
end

function B:ProgressQuickVendor()
	local item = B.SellFrame.Info.itemList[1]
	if not item then return nil, true end --No more to sell
	local bag, slot,itemPrice, link = unpack(item)

	local stackPrice = 0
	if B.SellFrame.Info.delete then
		PickupContainerItem(bag, slot)
		DeleteCursorItem()
	else
		local stackCount = select(2, GetContainerItemInfo(bag, slot)) or 1
		stackPrice = (itemPrice or 0) * stackCount
		if E.db.bags.vendorGrays.details and link then
			E:Print(format("%s|cFF00DDDDx%d|r %s", link, stackCount, B:FormatMoney(stackPrice)))
		end
		UseContainerItem(bag, slot)
	end

	tremove(B.SellFrame.Info.itemList, 1)

	return stackPrice
end

function B:VendorGreys_OnUpdate(elapsed)
	B.SellFrame.Info.ProgressTimer = B.SellFrame.Info.ProgressTimer - elapsed
	if B.SellFrame.Info.ProgressTimer > 0 then return end
	B.SellFrame.Info.ProgressTimer = B.SellFrame.Info.SellInterval

	local goldGained, lastItem = B:ProgressQuickVendor()
	if goldGained then
		B.SellFrame.Info.goldGained = B.SellFrame.Info.goldGained + goldGained
		B.SellFrame.Info.itemsSold = B.SellFrame.Info.itemsSold + 1
		B.SellFrame.statusbar:SetValue(B.SellFrame.Info.itemsSold)
		local timeLeft = (B.SellFrame.Info.ProgressMax - B.SellFrame.Info.itemsSold)*B.SellFrame.Info.SellInterval
		B.SellFrame.statusbar.ValueText:SetText(B.SellFrame.Info.itemsSold.." / "..B.SellFrame.Info.ProgressMax.." ( "..timeLeft.."s )")
	elseif lastItem then
		B.SellFrame:Hide()
		if B.SellFrame.Info.goldGained > 0 then
			E:Print((L["Vendored gray items for: %s"]):format(B:FormatMoney(B.SellFrame.Info.goldGained)))
		end
	end
end

function B:CreateSellFrame()
	B.SellFrame = CreateFrame("Frame", "ElvUIVendorGraysFrame", E.UIParent)
	B.SellFrame:Size(200,40)
	B.SellFrame:Point("CENTER", E.UIParent)
	B.SellFrame:CreateBackdrop("Transparent")
	B.SellFrame:SetAlpha(E.db.bags.vendorGrays.progressBar and 1 or 0)

	B.SellFrame.title = B.SellFrame:CreateFontString(nil, "OVERLAY")
	B.SellFrame.title:FontTemplate(nil, 12, "OUTLINE")
	B.SellFrame.title:Point("TOP", B.SellFrame, "TOP", 0, -2)
	B.SellFrame.title:SetText(L["Vendoring Grays"])

	B.SellFrame.statusbar = CreateFrame("StatusBar", "ElvUIVendorGraysFrameStatusbar", B.SellFrame)
	B.SellFrame.statusbar:Size(180, 16)
	B.SellFrame.statusbar:Point("BOTTOM", B.SellFrame, "BOTTOM", 0, 4)
	B.SellFrame.statusbar:SetStatusBarTexture(E.media.normTex)
	B.SellFrame.statusbar:SetStatusBarColor(1, 0, 0)
	B.SellFrame.statusbar:CreateBackdrop("Transparent")

	B.SellFrame.statusbar.anim = CreateAnimationGroup(B.SellFrame.statusbar)
	B.SellFrame.statusbar.anim.progress = B.SellFrame.statusbar.anim:CreateAnimation("Progress")
	B.SellFrame.statusbar.anim.progress:SetSmoothing("Out")
	B.SellFrame.statusbar.anim.progress:SetDuration(.3)

	B.SellFrame.statusbar.ValueText = B.SellFrame.statusbar:CreateFontString(nil, "OVERLAY")
	B.SellFrame.statusbar.ValueText:FontTemplate(nil, 12, "OUTLINE")
	B.SellFrame.statusbar.ValueText:Point("CENTER", B.SellFrame.statusbar)
	B.SellFrame.statusbar.ValueText:SetText("0 / 0 ( 0s )")

	B.SellFrame.Info = {
		delete = false,
		ProgressTimer = 0,
		SellInterval = E.db.bags.vendorGrays.interval,
		ProgressMax = 0,
		goldGained = 0,
		itemsSold = 0,
		itemList = {},
	}

	B.SellFrame:SetScript("OnUpdate", B.VendorGreys_OnUpdate)

	B.SellFrame:Hide()
end

function B:UpdateSellFrameSettings()
	if not B.SellFrame or not B.SellFrame.Info then return; end

	B.SellFrame.Info.SellInterval = E.db.bags.vendorGrays.interval
	B.SellFrame:SetAlpha(E.db.bags.vendorGrays.progressBar and 1 or 0)
end

B.BagIndice = {
	leatherworking = 0x0008,
	inscription = 0x0010,
	herbs = 0x0020,
	enchanting = 0x0040,
	engineering = 0x0080,
	gems = 0x0200,
	mining = 0x0400,
	fishing = 0x8000,
	cooking = 0x010000,
}

B.QuestKeys = {
	questStarter = "questStarter",
	questItem = "questItem",
}

function B:UpdateBagColors(table, indice, r, g, b)
	self[table][B.BagIndice[indice]] = {r, g, b}
end

function B:UpdateQuestColors(table, indice, r, g, b)
	self[table][B.QuestKeys[indice]] = {r, g, b}
end

function B:Initialize()
	--Creating vendor grays frame
	self:CreateSellFrame()
	self:RegisterEvent("MERCHANT_CLOSED")

	self:LoadBagBar()

	--Bag Mover (We want it created even if Bags module is disabled, so we can use it for default bags too)
	local BagFrameHolder = CreateFrame("Frame", nil, E.UIParent)
	BagFrameHolder:Width(200)
	BagFrameHolder:Height(22)
	BagFrameHolder:SetFrameLevel(BagFrameHolder:GetFrameLevel() + 400)

	if not E.private.bags.enable then
		--Set a different default anchor
		BagFrameHolder:Point("BOTTOMRIGHT", RightChatPanel, "BOTTOMRIGHT", -(E.Border*2), 22 + E.Border*4 - E.Spacing*2)
		E:CreateMover(BagFrameHolder, "ElvUIBagMover", L["Bag Mover"], nil, nil, B.PostBagMove, nil, nil, "bags,general")

		self:SecureHook("UpdateContainerFrameAnchors")

		return
	end

	E.bags = self
	self.db = E.db.bags
	self.BagFrames = {}

	self.ProfessionColors = {
		[0x0008]   = {self.db.colors.profession.leatherworking.r, self.db.colors.profession.leatherworking.g, self.db.colors.profession.leatherworking.b},
		[0x0010]   = {self.db.colors.profession.inscription.r, self.db.colors.profession.inscription.g, self.db.colors.profession.inscription.b},
		[0x0020]   = {self.db.colors.profession.herbs.r, self.db.colors.profession.herbs.g, self.db.colors.profession.herbs.b},
		[0x0040]   = {self.db.colors.profession.enchanting.r, self.db.colors.profession.enchanting.g, self.db.colors.profession.enchanting.b},
		[0x0080]   = {self.db.colors.profession.engineering.r, self.db.colors.profession.engineering.g, self.db.colors.profession.engineering.b},
		[0x0200]   = {self.db.colors.profession.gems.r, self.db.colors.profession.gems.g, self.db.colors.profession.gems.b},
		[0x0400]   = {self.db.colors.profession.mining.r, self.db.colors.profession.mining.g, self.db.colors.profession.mining.b},
		[0x8000]   = {self.db.colors.profession.fishing.r, self.db.colors.profession.fishing.g, self.db.colors.profession.fishing.b},
		[0x010000] = {self.db.colors.profession.cooking.r, self.db.colors.profession.cooking.g, self.db.colors.profession.cooking.b},
	}

	self.QuestColors = {
		["questStarter"] = {self.db.colors.items.questStarter.r, self.db.colors.items.questStarter.g, self.db.colors.items.questStarter.b},
		["questItem"] = {self.db.colors.items.questItem.r, self.db.colors.items.questItem.g, self.db.colors.items.questItem.b},
	}

	--Bag Mover: Set default anchor point and create mover
	BagFrameHolder:Point("BOTTOMRIGHT", RightChatPanel, "BOTTOMRIGHT", 0, 22 + E.Border*4 - E.Spacing*2)
	E:CreateMover(BagFrameHolder, "ElvUIBagMover", L["Bag Mover (Grow Up)"], nil, nil, B.PostBagMove, nil, nil, "bags,general")

	--Bank Mover
	local BankFrameHolder = CreateFrame("Frame", nil, E.UIParent)
	BankFrameHolder:Width(200)
	BankFrameHolder:Height(22)
	BankFrameHolder:Point("BOTTOMLEFT", LeftChatPanel, "BOTTOMLEFT", 0, 22 + E.Border*4 - E.Spacing*2)
	BankFrameHolder:SetFrameLevel(BankFrameHolder:GetFrameLevel() + 400)
	E:CreateMover(BankFrameHolder, "ElvUIBankMover", L["Bank Mover (Grow Up)"], nil, nil, B.PostBagMove, nil, nil, "bags,general")

	--Set some variables on movers
	ElvUIBagMover.textGrowUp = L["Bag Mover (Grow Up)"]
	ElvUIBagMover.textGrowDown = L["Bag Mover (Grow Down)"]
	ElvUIBagMover.POINT = "BOTTOM"
	ElvUIBankMover.textGrowUp = L["Bank Mover (Grow Up)"]
	ElvUIBankMover.textGrowDown = L["Bank Mover (Grow Down)"]
	ElvUIBankMover.POINT = "BOTTOM"

	--Create Bag Frame
	self.BagFrame = self:ContructContainerFrame("ElvUI_ContainerFrame")

	--Hook onto Blizzard Functions
	self:SecureHook("ToggleBackpack")
	self:SecureHook("ToggleBag", "ToggleBags")
	self:SecureHook("ToggleAllBags", "ToggleBackpack")
	self:SecureHook("OpenAllBags", "OpenBags")
	self:SecureHook("CloseAllBags", "CloseBags")
	self:SecureHook("BackpackTokenFrame_Update", "UpdateTokens")

	self:Layout()

	E.Bags = self

	self:DisableBlizzard()
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_MONEY", "UpdateGoldText")
	self:RegisterEvent("PLAYER_TRADE_MONEY", "UpdateGoldText")
	self:RegisterEvent("TRADE_MONEY_CHANGED", "UpdateGoldText")
	self:RegisterEvent("BANKFRAME_OPENED", "OpenBank")
	self:RegisterEvent("BANKFRAME_CLOSED", "CloseBank")
	self:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED")
	self:RegisterEvent("GUILDBANKFRAME_OPENED")
end

local function InitializeCallback()
	B:Initialize()
end

E:RegisterModule(B:GetName(), InitializeCallback)