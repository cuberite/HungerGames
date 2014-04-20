function ParseItems()
	for Idx, ItemInfo in ipairs(Config.ChestContent) do
		if (type(ItemInfo.ItemType) == 'string') then
			local Item = cItem()
			if (not StringToItem(ItemInfo.ItemType, Item)) then
				LOGWARNING("Item " .. ItemInfo.ItemType .. " is unknown. Ignoring the item.")
				table.remove(Config.ChestContent, Idx)
			end
			
			ItemInfo.ItemType = Item.m_ItemType
			ItemInfo.ItemMeta = Item.m_ItemDamage
		end
	end
end