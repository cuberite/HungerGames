
--[[
 This file contains the ArenaState class.
 The ArenaState manages everything that happens in an arena.
]]




local g_ArenaStates = {}





function cArenaState(a_ArenaName, a_WorldName)
	local m_ArenaName = a_ArenaName
	local m_World = a_WorldName
	
	local m_HasStarted = false
	local m_CountDownLeft = Config.CountDownTime
	local m_NoDamageTimeLeft = Config.NoDamageTime
	
	local m_SpawnPoints = {}
	
	local m_Players = {}
	local m_Inventories = {}
	
	local m_LobbyCoordinates = Vector3d()
	local m_BoundingBox = cCuboid()
	
	local m_DestroyedBlocks = {}
	
	
	
	
	
	-- Create the object.
	local self = {}
	self.ArenaName = m_ArenaName
	
	-- Loops through each player in the arena and calls the given callback.
	function self:ForEachPlayer(a_Callback)
		local World = cRoot:Get():GetWorld(m_World)
		local ShouldStop = false
		
		for PlayerName, _ in pairs(m_Players) do
			if (ShouldStop) then
				return
			end
			
			World:DoWithPlayer(PlayerName, 
				function(a_Player)
					if (a_Callback(a_Player)) then
						ShouldStop = true
					end
				end
			)
		end
	end
	
	
	
	
	
	-- Sends a message to all the players who joined the arena.
	function self:BroadcastChat(a_Message)
		self:ForEachPlayer(
			function(a_Player)
				a_Player:SendMessage(a_Message)
			end
		)
	end
	
	
	
	
	
	do -- Lobby related functions
		-- Returns the coordinates for the lobby
		function self:GetLobbyCoordinates()
			return m_LobbyCoordinates
		end
		
		-- Sets the coordinates for the lobby
		function self:SetLobbyCoordinates(a_LobbyCoordinates)
			m_LobbyCoordinates:Set(a_LobbyCoordinates.x, a_LobbyCoordinates.y, a_LobbyCoordinates.z)
		end
		
		-- Returns true if the lobby coordinates are set.
		function self:AreLobbyCoordinateSet()
			return (m_LobbyCoordinates:Length() ~= 0)
		end
	end
	
	
	
	
	
	do -- All the ArenaSize functions
		function self:SetArenaSizeP1(a_Point)
			assert((tolua.type(a_Point) == "Vector3<int>") or (tolua.type(a_Point) == "const Vector3<int>"))
			m_BoundingBox.p1:Set(a_Point.x, a_Point.y, a_Point.z)
			m_BoundingBox:Sort()
		end
		
		function self:SetArenaSizeP2(a_Point)
			assert((tolua.type(a_Point) == "Vector3<int>") or (tolua.type(a_Point) == "const Vector3<int>"))
			m_BoundingBox.p2:Set(a_Point.x, a_Point.y, a_Point.z)
			m_BoundingBox:Sort()
		end
		
		function self:SetArenaSize(a_Vector, a_Point)
			a_Point = tostring(a_Point)
			
			if (a_Point == '1') then
				self:SetArenaSizeP1(a_Vector)
				return true
			elseif (a_Point == '2') then
				self:SetArenaSizeP2(a_Vector)
				return true
			else
				return false, "Invalid point \"" .. a_Point .. "\""
			end
		end
		
		function self:IsInside(a_Point)
			assert((tolua.type(a_Point) == "Vector3<double>") or (tolua.type(a_Point) == "const Vector3<double>"))
			
			return m_BoundingBox:IsInside(a_Point)
		end
	end
	
	
	
	
	
	-- Returns true if the arena has started
	function self:HasStarted()
		return m_HasStarted
	end
	
	
	
	
	
	-- Returns the world where the arena is in
	function self:GetWorldName()
		return m_World
	end
	
	
	
	
	
	-- Returns the name of the arena.
	function self:GetName()
		return m_ArenaName
	end
	
	
	
	
	
	-- Returns the amount of players who joined.
	function self:GetNumPlayers()
		local Count = 0
		for PlayerName, _ in pairs(m_Players) do
			Count = Count + 1
		end
		
		return Count
	end
	
	
	
	
	
	-- Returns the amount of playing players
	function self:GetNumPlayingPlayers()
		local Count = 0
		for PlayerName, Info in pairs(m_Players) do
			if (Info.IsPlaying) then
				Count = Count + 1
			end
		end
		
		return Count
	end
	
	
	
	
	
	-- Returns the players who are still in the game
	function self:GetPlayingPlayers()
		local res = {}
		for PlayerName, Info in pairs(m_Players) do
			if (Info.IsPlaying) then
				table.insert(res, PlayerName)
			end
		end
		
		return res
	end
	
	
	
	
	
	do -- Manages the players joining and leaving.
		-- Adds a player to the arena. Returns true if succes and returns false if: the arena is full or the arena already started.
		function self:AddPlayer(a_Player)
			if (m_HasStarted) then
				return false, "The arena already started."
			end
			
			if (#m_SpawnPoints == self:GetNumPlayers()) then
				return false, "The arena is full."
			end
			
			m_Players[a_Player:GetName()] = 
			{
				IsPlaying = false,
				SpawnPoint = nil,
			}
			
			if (a_Player:GetWorld():GetName() ~= m_World) then
				a_Player:MoveToWorld(m_World)
			end
			
			a_Player:TeleportToCoords(m_LobbyCoordinates.x, m_LobbyCoordinates.y, m_LobbyCoordinates.z)
			
			if (self:GetNumPlayers() == #m_SpawnPoints) then
				self:StartArena()
			end
		end
		
		-- Removes the player from the arena
		function self:RemovePlayer(a_Player)
			a_Player:TeleportToCoords(m_LobbyCoordinates.x, m_LobbyCoordinates.y, m_LobbyCoordinates.z)
			m_Players[a_Player:GetName()] = nil
			
			if (not m_HasStarted) then
				return
			end
			
			if (self:GetNumPlayingPlayers() == 1) then
				self:StopArena()
			end
		end
	end
	
	
	
	
	
	-- Adds a block to the table with destroyed blocks. They get replaced once the match is over.
	function self:AddDestroyedBlock(a_Pos, a_BlockType, a_BlockMeta)
		table.insert(m_DestroyedBlocks, {Pos = a_Pos, BlockType = a_BlockType, BlockMeta = a_BlockMeta})
	end
	
	
	
	
	
	do
		-- Adds a spawnpoint.
		function self:AddSpawnPoint(a_SpawnPoint)
			assert((tolua.type(a_SpawnPoint) == "Vector3<double>") or (tolua.type(a_SpawnPoint) == "const Vector3<double>"))
			
			table.insert(m_SpawnPoints, {Coordinates = Vector3d(a_SpawnPoint), IsTaken = false})
		end
		
		-- Returns the amount of spawnpoints
		function self:GetNumSpawnPoints()
			return #m_SpawnPoints
		end
	end
	
	
	
	
	
	-- Refills all the chests that are in the arena.
	function self:RefillChestsInArena()
		local MinChunkX = math.floor(m_BoundingBox.p1.x / 16)
		local MinChunkZ = math.floor(m_BoundingBox.p1.z / 16)
		local MaxChunkX = math.floor(m_BoundingBox.p2.x / 16)
		local MaxChunkZ = math.floor(m_BoundingBox.p2.z / 16)
		local ChunkCoords = {}
		
		for X = MinChunkX, MaxChunkX do
			for Z = MinChunkZ, MaxChunkZ do
				table.insert(ChunkCoords, {X, Z})
			end
		end
		
		local function GetRandomItem()
			local AvailableItems = Config.ChestContent
			local RandomItem = AvailableItems[math.random(1, #AvailableItems)]
			local ItemChance = RandomItem.Chance
			if (math.random(1, RandomItem.Chance) == 1) then
				local Item = cItem(RandomItem.ItemType, 1, RandomItem.ItemMeta)
				Item.m_Enchantments:AddFromString(RandomItem.Enchantment or "")
				return Item
			else
				return cItem()
			end
		end
		
		local World = cRoot:Get():GetWorld(m_World)
		World:ChunkStay(ChunkCoords,
			function(a_ChunkX, a_ChunkZ)
				World:ForEachChestInChunk(a_ChunkX, a_ChunkZ,
					function(a_ChestEntity)
						if (m_BoundingBox:IsInside(a_ChestEntity:GetPosX(), a_ChestEntity:GetPosY(), a_ChestEntity:GetPosZ())) then
							for X = 1, 3 do
								for Y = 1, 9 do
									a_ChestEntity:SetSlot(X * Y - 1, GetRandomItem())
								end
							end
						end
					end
				)
			end, 
			
			function() 
			end
		)
	end
	
	
	
	
	
	-- Starts the arena. 
	function self:StartArena()
		-- Refill all the chests inside the arena.
		self:RefillChestsInArena()
		
		local SpawnPoint = 1
		self:ForEachPlayer(
			function(a_Player)
				local PlayerName = a_Player:GetName()
				
				-- Save the inventory
				local InventoryContent = cItems()
				local Inventory = a_Player:GetInventory()
				Inventory:CopyToItems(InventoryContent)
				m_Inventories[PlayerName] = InventoryContent
				Inventory:Clear()
				
				-- Teleport the player to one of the spawnpoint coordinates.
				local Coordinates = m_SpawnPoints[SpawnPoint].Coordinates
				a_Player:TeleportToCoords(Coordinates.x, Coordinates.y, Coordinates.z)
				
				-- Set the gamemode to survival
				a_Player:SetGameMode(eGameMode_Survival)
				
				-- Mark the player as IsPlaying and save his spawnpoint coordinates.
				m_Players[PlayerName].IsPlaying = true
				m_Players[PlayerName].SpawnPoint = Coordinates
				
				-- Heal the player completely
				a_Player:Heal(20)
				a_Player:Feed(20, 20)
				
				SpawnPoint = SpawnPoint + 1
			end
		)
		
		m_HasStarted = true
	end
	
	
	
	
	
	-- Stops the arena
	function self:StopArena(a_IsForceStop)
		if (a_IsForceStop) then
			self:BroadcastChat("The match is over.")
		else
			local Winner = self:GetPlayingPlayers()
			self:BroadcastChat(Winner[1] .. " has won the game")
		end
		
		self:ForEachPlayer(
			function(a_Player)
				local PlayerName = a_Player:GetName()
				local PlayerState = GetPlayerState(PlayerName)
				
				-- Teleport the player to the lobby.
				a_Player:TeleportToCoords(m_LobbyCoordinates.x, m_LobbyCoordinates.y, m_LobbyCoordinates.z)
				
				-- Remove the player
				self:RemovePlayer(a_Player)
				PlayerState:LeaveArena()
				
				-- Give the player his items back.
				local Inventory = a_Player:GetInventory()
				Inventory:Clear()
				Inventory:AddItems(m_Inventories[PlayerName] or cItems(), true, true)
			end
		)
		
		-- Delete all the inventories wich were saved.
		m_Inventories = {}
		
		-- Reset the counters
		m_CountDownLeft = Config.CountDownTime
		m_NoDamageTimeLeft = Config.NoDamageTime
		
		-- Replace all the destroyed grass and leave blocks.
		local World = cRoot:Get():GetWorld(m_World)
		for Idx, BlockInfo in ipairs(m_DestroyedBlocks) do
			World:SetBlock(BlockInfo.Pos.x, BlockInfo.Pos.y, BlockInfo.Pos.z, BlockInfo.BlockType, BlockInfo.BlockMeta)
		end
		
		-- Reset the table wich contains all the destroyed blocks.
		m_DestroyedBlocks = {}
		
		-- Mark as "Not started"
		m_HasStarted = false
	end
	
	
	
	
	
	-- Gets called each tick. It's used to teleport the players to their spawn point if the arena didn't start yet.
	function self:Tick()
		if (not m_HasStarted) then
			return
		end
		
		if (m_NoDamageTimeLeft ~= 0) then
			m_NoDamageTimeLeft = m_NoDamageTimeLeft - 1
		end
		
		if (m_CountDownLeft == 0) then
			return
		end
		
		m_CountDownLeft = m_CountDownLeft - 1
		
		if (m_CountDownLeft == 5 * 20) then
			self:BroadcastChat("5 seconds left")
		elseif (m_CountDownLeft == 4 * 20) then
			self:BroadcastChat("4")
		elseif (m_CountDownLeft == 3 * 20) then
			self:BroadcastChat("3")
		elseif (m_CountDownLeft == 2 * 20) then
			self:BroadcastChat("2")
		elseif (m_CountDownLeft == 1 * 20) then
			self:BroadcastChat("1")
		elseif (m_CountDownLeft == 0) then
			self:BroadcastChat("The match has started!")
		end
		
		self:ForEachPlayer(
			function(a_Player)
				local PlayerName = a_Player:GetName()
				local Coords = m_Players[PlayerName].SpawnPoint
				a_Player:TeleportToCoords(Coords.x, Coords.y, Coords.z)
			end
		)
	end
	
	
	
	
	
	do
		function self:GetCountDownTime()
			return m_CountDownLeft
		end
	
		function self:GetNoDamageTime()
			return m_NoDamageTimeLeft
		end
	end
	
	
	
	
	
	-- Saves all the info about the arena in an IniFile object.
	function self:SaveToIniFile(a_IniFile)
		local SpawnPoints = ""
		for I, Coordinates in pairs(m_SpawnPoints) do
			SpawnPoints = SpawnPoints .. Coordinates.Coordinates.x .. "," .. Coordinates.Coordinates.y .. "," .. Coordinates.Coordinates.z .. ";"
		end
		
		a_IniFile:SetValue(m_ArenaName, "SpawnPoints", SpawnPoints)
		a_IniFile:SetValue(m_ArenaName, "World", m_World)
		a_IniFile:SetValue(m_ArenaName, "LobbyCoordinates", m_LobbyCoordinates.x .. "," .. m_LobbyCoordinates.y .. "," .. m_LobbyCoordinates.z)
		a_IniFile:SetValue(m_ArenaName, "BoundingBox", 
			m_BoundingBox.p1.x .. "," ..
			m_BoundingBox.p1.y .. "," ..
			m_BoundingBox.p1.z .. ";" ..
			m_BoundingBox.p2.x .. "," ..
			m_BoundingBox.p2.y .. "," ..
			m_BoundingBox.p2.z .. ","
		)
	end
	
	
	
	
	
	-- Loads all the info from an IniFile object.
	function self:LoadFromIniFile(a_IniFile)
		local SpawnPoints = StringSplit(a_IniFile:GetValue(m_ArenaName, "SpawnPoints"), ";")
		for Idx = 1, #SpawnPoints do
			local Coords = StringSplit(SpawnPoints[Idx], ",")
			self:AddSpawnPoint(Vector3d(Coords[1], Coords[2], Coords[3]))
		end
		
		local BoundingBox = StringSplit(a_IniFile:GetValue(m_ArenaName, "BoundingBox"), ";")
		
		do
			local Coords = StringSplit(BoundingBox[1], ",")
			m_BoundingBox.p1:Set(Coords[1], Coords[2], Coords[3])
			
			local Coords = StringSplit(BoundingBox[2], ",")
			m_BoundingBox.p2:Set(Coords[1], Coords[2], Coords[3])
		end
		
		local LobbyCoords = StringSplit(a_IniFile:GetValue(m_ArenaName, "LobbyCoordinates"), ",")
		
		self:SetLobbyCoordinates(Vector3d(LobbyCoords[1], LobbyCoords[2], LobbyCoords[3]))
	end
	
	return self
end





function GetArenaState(a_ArenaStateName)
	if (g_ArenaStates[a_ArenaStateName]) then
		return g_ArenaStates[a_ArenaStateName]
	end
	
	return false
end





function CreateArenaState(a_ArenaName, a_WorldName)
	assert(type(a_ArenaName) == "string")
	assert(type(a_WorldName) == "string")
	
	if (g_ArenaStates[a_ArenaName]) then
		return false, "The arena already exists."
	end
	
	local ArenaState = cArenaState(a_ArenaName, a_WorldName)
	g_ArenaStates[a_ArenaName] = ArenaState
	
	return ArenaState
end





function ArenaExist(a_ArenaName)
	return (g_ArenaStates[a_ArenaName] ~= nil)
end





function ForEachArena(a_Callback)
	for ArenaName, ArenaState in pairs(g_ArenaStates) do
		a_Callback(ArenaState)
	end
end





function InsertArenaState(a_ArenaName, a_ArenaState)
	if (g_ArenaStates[a_ArenaName]) then
		return false
	end
	
	g_ArenaStates[a_ArenaName] = a_ArenaState
	return true
end





function DoWithArena(a_ArenaName, a_Callback)
	assert(type(a_Callback) == 'function')
	
	if (not g_ArenaStates[a_ArenaName]) then
		return false
	end
	
	a_Callback(g_ArenaStates[a_ArenaName])
end




