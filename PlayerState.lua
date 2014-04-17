
local g_PlayerStates = {}





function cPlayerState(a_PlayerName)
	local self = {}
	
	local m_PlayerName = a_PlayerName
	local m_JoinedArena
	local m_SelectedArena
	
	do
		-- Returns true if the player did join an arena. Else it returns false
		function self:DidJoinArena()
			return (m_JoinedArena ~= nil)
		end
		
		-- Returns the arena that the player has joined.
		function self:GetJoinedArena()
			return m_JoinedArena
		end
		
		-- Leaves the current arena.
		function self:LeaveArena()
			m_JoinedArena = nil
		end

		-- Join an arena.
		function self:JoinArena(a_ArenaName)
			assert(type(a_ArenaName) == 'string')
			
			m_JoinedArena = a_ArenaName
		end
	end
	
	do
		-- returns true if the player has an arena selected
		function self:HasArenaSelected()
			return (m_SelectedArena ~= nil)
		end
		
		-- Selects an arena. Returns false if it failed.
		function self:SelectArena(a_ArenaName)
			if (not ArenaExist(a_ArenaName)) then
				return false, "The arena does not exist."
			end
			
			m_SelectedArena = a_ArenaName
			return true
		end
		
		-- returns the arena wich the player has selected
		function self:GetSelectedArena()
			return m_SelectedArena
		end
	end
	
	return self
end





function GetPlayerState(a_PlayerName)
	assert(type(a_PlayerName) == "string")
	
	if (g_PlayerStates[a_PlayerName]) then
		return g_PlayerStates[a_PlayerName]
	end
	
	local PlayerState = cPlayerState(a_PlayerName)
	g_PlayerStates[a_PlayerName] = PlayerState
	
	return PlayerState
end