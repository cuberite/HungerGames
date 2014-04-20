function Initialize(a_Plugin)
	a_Plugin:SetName("HungerGames")
	a_Plugin:SetVersion(1)
	
	local ConfigLoader, errormsg = loadfile(a_Plugin:GetLocalFolder() .. "/Config.cfg")
	if (not ConfigLoader) then
		LOGERROR("Could not load HungerGames. There is an error in the config: \"", a_Plugin:GetLocalFolder() .. "/Config.cfg\"")
		LOGERROR(errormsg)
		return false
	end
	
	ConfigLoader()
	
	ParseItems()
		
	LoadArenas()
	
	dofile(cPluginManager:GetPluginsPath() .. "/InfoReg.lua");

	-- Initialize in-game commands:
	RegisterPluginInfoCommands();
	
	RegisterHooks()
	
	LOG("HungerGames has initialized")
	return true
end





function OnDisable()
	ForEachArena(
		function(a_ArenaState)
			a_ArenaState:StopArena(true)
		end
	)
	
	SaveArenas()
end