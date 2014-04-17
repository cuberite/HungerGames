function HandleSelectCommand(a_Split, a_Player)
	if (a_Split[3] == nil) then
		a_Player:SendMessage(cChatColor.Rose .. "Usage: /hg select [ArenaName]")
		return true
	end
	
	local ArenaName = table.concat(a_Split, " ", 3)
	if (not ArenaExist(ArenaName)) then
		a_Player:SendMessage(cChatColor.Rose .. "The arena doesn't exist")
		return true
	end
	
	local PlayerState = GetPlayerState(a_Player:GetName())
	PlayerState:SelectArena(ArenaName)
	a_Player:SendMessage(cChatColor.LightGreen .. "Selected arena \"" .. ArenaName .. "\".")
	return true
end





function HandleCreateCommand(a_Split, a_Player)
	if (a_Split[3] == nil) then
		a_Player:SendMessage(cChatColor.Rose .. "Usage: /hg create [ArenaName]")
		return true
	end
	
	local ArenaName = table.concat(a_Split, " ", 3)
	if (ArenaExist(ArenaName)) then
		a_Player:SendMessage(cChatColor.Rose .. "The arena already exists")
		return true
	end
	
	local ArenaState = CreateArenaState(ArenaName, a_Player:GetWorld():GetName())
	ArenaState:SetLobbyCoordinates(a_Player:GetPosition())
	
	local PlayerState = GetPlayerState(a_Player:GetName())
	PlayerState:SelectArena(ArenaName)
	
	a_Player:SendMessage(cChatColor.LightGreen .. "You created \"" .. ArenaName .. "\".")
	return true
end





function HandleAddCommand(a_Split, a_Player)
	local PlayerState = GetPlayerState(a_Player:GetName())
	if (not PlayerState:HasArenaSelected()) then
		a_Player:SendMessage(cChatColor.Rose .. "You haven't selected an arena yet.")
		return true
	end
	
	local ArenaState = GetArenaState(PlayerState:GetSelectedArena())
	if (not ArenaState) then
		a_Player:SendMessage(cChatColor.Rose .. "The arena you had selected doesn't exist anymore.")
		return true
	end
	
	ArenaState:AddSpawnPoint(a_Player:GetPosition())
	a_Player:SendMessage(cChatColor.LightGreen .. "You added an spawnpoint.")
	return true
end






function HandleSetBoundingBoxCommand(a_Split, a_Player)
	if (not a_Split[3]) then
		a_Player:SendMessage(cChatColor.Rose .. "Usage: /hg setsize [Point]. The point can either be 1 or 2.")
		return true
	end
	
	local PlayerState = GetPlayerState(a_Player:GetName())
	if (not PlayerState:HasArenaSelected()) then
		a_Player:SendMessage(cChatColor.Rose .. "You haven't selected an arena yet.")
		return true
	end
	
	local ArenaState = GetArenaState(PlayerState:GetSelectedArena())
	if (not ArenaState) then
		a_Player:SendMessage(cChatColor.Rose .. "The arena you had selected doesn't exist anymore.")
		return true
	end 
	
	local Succes, errmsg = ArenaState:SetArenaSize(Vector3i(a_Player:GetPosition()), a_Split[3])
	if (Succes) then
		a_Player:SendMessage(cChatColor.LightGreen .. "Set point " .. a_Split[3] .. " to your current position.")
	else
		a_Player:SendMessage(cChatColor.Rose .. errmsg)
	end
	return true
end





function HandleJoinCommand(a_Split, a_Player)
	if (not a_Split[3]) then
		a_Player:SendMessage(cChatColor.Rose .. "Usage: /hg join [ArenaName]")
		return true
	end
	
	local PlayerState = GetPlayerState(a_Player:GetName())
	if (PlayerState:DidJoinArena()) then
		a_Player:SendMessage(cChatColor.Rose .. "You already joined an arena.")
		return true
	end
	
	local ArenaName = table.concat(a_Split, " ", 3)
	
	if (not ArenaExist(ArenaName)) then
		a_Player:SendMessage(cChatColor.Rose .. "The arena \"" .. ArenaName .. "\" doesn't exist.")
		return true
	end
	
	local ArenaState = GetArenaState(ArenaName)

	PlayerState:JoinArena(ArenaName)	
	ArenaState:AddPlayer(a_Player)
	
	a_Player:SendMessage(cChatColor.LightGreen .. "You joined " .. ArenaName)
	return true
end
	
	
	