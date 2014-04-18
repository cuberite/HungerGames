function RegisterHooks()
	cPluginManager:AddHook(cPluginManager.HOOK_TICK, OnTick)
	cPluginManager:AddHook(cPluginManager.HOOK_KILLING, OnKilling)
	cPluginManager:AddHook(cPluginManager.HOOK_TAKE_DAMAGE, OnTakeDamage)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_DESTROYED, OnPlayerDestroyed)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_USING_BLOCK, OnPlayerUsingBlock)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_LEFT_CLICK, OnPlayerLeftClick)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_PLACING_BLOCK, OnPlayerPlacingBlock)
	cPluginManager:AddHook(cPluginManager.HOOK_PLAYER_USING_ITEM, OnPlayerPlacingBlock)
	cPluginManager:AddHook(cPluginManager.HOOK_SPAWNING_MONSTER, OnSpawningMonster)
end





function OnTick(a_TimeDelta)
	ForEachArena(
		function(a_ArenaState)
			a_ArenaState:Tick()
		end
	)
end




function OnKilling(a_Victim, a_Killer)
	if (not a_Victim:IsPlayer()) then
		return false
	end
	
	local Player = tolua.cast(a_Victim, "cPlayer")
	
	local PlayerState = GetPlayerState(Player:GetName())
	if (not PlayerState:DidJoinArena()) then
		return false
	end
	
	local ArenaState = GetArenaState(PlayerState:GetJoinedArena())
	ArenaState:RemovePlayer(Player)
	
	Player:SetHealth(20)
	return true
end





function OnTakeDamage(a_Receiver, a_TDI)
	if (not a_Receiver:IsPlayer()) then
		return false
	end
	
	local Player = tolua.cast(a_Receiver, "cPlayer")
	local PlayerState = GetPlayerState(Player:GetName())
	
	if (not PlayerState:DidJoinArena()) then
		return false
	end
	
	local ArenaState = GetArenaState(PlayerState:GetJoinedArena())
	if (ArenaState:GetNoDamageTime() == 0) then
		return false
	end
	
	return true
end





function OnPlayerUsingBlock(a_Player, a_BlockX, a_BlockY, a_BlockZ, a_BlockFace, a_CursorX, a_CursorY, a_CursorZ, a_BlockType, a_BlockMeta)
	if (a_BlockType ~= E_BLOCK_CHEST) then
		return false
	end
	
	local PlayerState = GetPlayerState(a_Player:GetName())
	if (not PlayerState:DidJoinArena()) then
		return false
	end
	
	local ArenaState = GetArenaState(PlayerState:GetJoinedArena())
	if (ArenaState:GetCountDownTime() == 0) then
		return false
	end
	
	return true
end





function OnPlayerDestroyed(a_Player)
	local PlayerState = GetPlayerState(a_Player:GetName())
	if (not PlayerState:DidJoinArena()) then
		return false
	end
	
	local ArenaState = GetArenaState(PlayerState:GetJoinedArena())
	if (not ArenaState) then
		return false
	end
	
	PlayerState:LeaveArena()
	ArenaState:RemovePlayer(a_Player)
end





function OnPlayerLeftClick(a_Player, a_BlockX, a_BlockY, a_BlockZ, a_BlockFace, a_Action)
	if ((a_Action ~= 0) and (a_Action ~= 1) and (a_Action ~= 2)) then
		return false
	end
		
	local PlayerState = GetPlayerState(a_Player:GetName())
	if (not PlayerState:DidJoinArena()) then
		return false
	end
	
	local Succes, BlockType, BlockMeta = a_Player:GetWorld():GetBlockTypeMeta(a_BlockX, a_BlockY, a_BlockZ)
	if ((BlockType ~= E_BLOCK_LEAVES) and (BlockType ~= E_BLOCK_TALL_GRASS)) then
		return true
	end
	
	local ArenaState = GetArenaState(PlayerState:GetJoinedArena())
	ArenaState:AddDestroyedBlock(Vector3i(a_BlockX, a_BlockY, a_BlockZ), BlockType, BlockMeta)
end





function OnPlayerPlacingBlock(a_Player, a_BlockX, a_BlockY, a_BlockZ)
	local PlayerState = GetPlayerState(a_Player:GetName())
	if (not PlayerState:DidJoinArena()) then
		return false
	end
	
	return true
end





function OnSpawningMonster(a_World, a_Monster)
	local Position = a_Monster:GetPosition()
	local IsInsideArena = false
	
	ForEachArena(
		function(a_ArenaState)
			if (a_ArenaState:IsInside(Position)) then
				IsInsideArena = true
				return true
			end
		end
	)
	
	if (not IsInsideArena) then
		return false
	end
	
	local MonsterFamily = a_Monster:GetMobFamily()
	
	if (MonsterFamily == cMonster.mfHostile) then
		if (Config.PreventMonsterSpawn) then
			return true
		end
	elseif (MonsterFamily == cMonster.mfPassive) then
		if (Config.PreventAnimalSpawn) then
			return true
		end
	end
end



