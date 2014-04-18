function SaveArenas()
	local IniFile = cIniFile()
	ForEachArena(
		function(a_ArenaState)
			a_ArenaState:SaveToIniFile(IniFile)
		end
	)
	IniFile:WriteFile(cPluginManager:Get():GetCurrentPlugin():GetLocalFolder() .. "/Arenas.ini")
end





function LoadArenas()
	local IniFile = cIniFile()
	
	-- The file doesn't even exist so we can't do anything.
	if (not IniFile:ReadFile(cPluginManager:Get():GetCurrentPlugin():GetLocalFolder() .. "/Arenas.ini")) then
		return false
	end
	
	local NumKeys = IniFile:GetNumKeys()
	for Idx = 0, NumKeys - 1 do
		local ArenaName = IniFile:GetKeyName(Idx)
		local World = IniFile:GetValue(ArenaName, "World")
		local ArenaState = CreateArenaState(ArenaName, World)
		ArenaState:LoadFromIniFile(IniFile)
		
		InsertArenaState(ArenaName, ArenaState)
	end
end