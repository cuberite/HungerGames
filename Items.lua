
-- This file handles contains functions to manage the items given in the config file.

local g_TotalWeight = 0





-- Checks all the items for errors and counts the total weight.
function ParseItems()
	for Idx, ItemInfo in ipairs(Config.ChestContent) do
		local IsValid = true -- Lua doesn't have 'continue' so we have to do it the hard way.
		
		if (type(ItemInfo.ItemType) == 'string') then
			local Item = cItem()
			if (not StringToItem(ItemInfo.ItemType, Item)) then
				LOGWARNING("Item " .. ItemInfo.ItemType .. " is unknown. Ignoring the item.")
				table.remove(Config.ChestContent, Idx)
				IsValid = false
			else
				ItemInfo.ItemType = Item.m_ItemType
				ItemInfo.ItemMeta = Item.m_ItemDamage
			end
		end
		
		if (IsValid) then
			g_TotalWeight = g_TotalWeight + ItemInfo.Chance
		end
	end
end





-- Returns a random item based on the chance(Weight) of the item.
function GetRandomItem()
	local TempWeight = math.random(0, g_TotalWeight)
	
	for Idx, ItemInfo in ipairs(Config.ChestContent) do
		TempWeight = TempWeight - ItemInfo.Chance
		if (TempWeight < 0) then
			local Item = cItem(ItemInfo.ItemType, 1, ItemInfo.ItemMeta)
			Item.m_Enchantments:AddFromString(ItemInfo.Enchantment or "")
			return Item
		end
	end
	
	return cItem(E_BLOCK_AIR)
end




