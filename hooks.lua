

function OnHandshake(ClientHandle, UserName)	
	local loopPlayers = function(Player)
		if (Player:GetName() == UserName) then
			Player:SendMessage("Somebody just tried to login in under your name!")
			ClientHandle:Kick(cChatColor.Red .."There is already somebody with that name")
			return true
		end
    end
    local loopWorlds = function (World)
        World:ForEachPlayer(loopPlayers)
    end
	cRoot:Get():ForEachWorld(loopWorlds)
end





function OnTick()
	if (CanMoving) then
		if (BeforeTime) then
			InternalTime = InternalTime - 1
			if InternalTime == 11990) then
				cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Gold .. " 10 minutes before the end of the round.")
			end
			if InternalTime == 6000) then
				cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Gold .. " 5 minutes before the end of the round.")
			end
			if InternalTime == 3600) then
				cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Gold .. " 3 minutes before the end of the round.")
			end
			if InternalTime == 1200) then
				cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Gold .. " 1 minutes before the end of the round..")
			end
			if InternalTime == 200) then
				cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Gold .. " 10 second before the end of the game.")
			end
			if InternalTime == 100) then
				cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Gold .. " 5 second before the end of the game.")
			end
			if InternalTime == 80) then
				cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Gold .. " 4 second before the end of the game.")
			end
			if InternalTime == 60) then
				cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Gold .. " 3 second before the end of the game")
			end
			if InternalTime == 40) then
				cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Gold .. " 2 second before the end of the game.")
			end
			if InternalTime == 20) then
				cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Gold .. " 1 second before the end of the game.")
			end
			if InternalTime == 0) then
				cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Red .. " Hunger Game Over!")
				LOG("Hunger Game Over!")
				ThisisWin = true
				RestartRound()
				PlayersTotal=0
			end
		end
	end
end





function OnWorldTickTwo(World, TimeDelta)
	TimeBefore = TimeBefore - 1
	if (TimeBefore == 3500) then
		cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 3 minutes before the start of the game.")
	end
	if (TimeBefore == 2400) then
		cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 2 minutes before the start of the game.")
	end
	if (TimeBefore == 1200) then
		cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 1 minutes before the start of the game.")
	end
	if (TimeBefore == 600) then
		cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 30 seconds before the start of the game.")
	end
	if (TimeBefore == 0) then
		GetUniqueID()
		if (PlayersTotal <= 1) then
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.LightBlue .. " Waiting for players.")
			LoadTimes()
			PlayersTotal = 0
		else
			BeforeTime = true
			CanMoving = false
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Blue .. " Waiting for players.")
			LOG("Waiting for players.")
		end
	end
end







function OnWorldTick(World, TimeDelta)
	if (BeforeTime) then
		if not(CanMoving) then
			local loopPlayers = function(Player)
				LoadSpawnCoords(Split,Player)
			end
			local loopWorlds = function (World)
				World:ForEachPlayer(loopPlayers)
			end
			cRoot:Get():ForEachWorld(loopWorlds)
		else
			return true
		end
		Time = Time - 1

		if (Time == 1190) then
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 60 seconds before the game.")
		end
		if (Time == 800) then
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 40 seconds before the game.")
		end
		if (Time == 400) then
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 20 seconds before the game.")
		end
		if (Time == 200) then
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 10 seconds before the game.")
		end
		if (Time == 180) then
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 9 seconds before the game.")
		end
		if (Time == 160) then
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 8 seconds before the game.")
		end
		if (Time == 140) then
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 7 seconds before the game.")
		end
		if (Time == 120) then
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 6 seconds before the game.")
		end
		if (Time == 100) then
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 5 seconds before the game.")
		end
		if (Time == 80) then
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 4 seconds before the game.")
		end
		if (Time == 60) then
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 3 seconds before the game.")
		end
		if (Time == 40) then
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 2 seconds before the game.")
		end
		if (Time == 20) then
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " 1 seconds before the game.")
		end
		if (Time == 5) then
			LoadItemsIntoBD(Split, Player)
			CanMoving = true;
			cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.LightBlue .. " Game Start!!!")
			LOG("Game Start!!!")
			Statistic()
		end
	end
end













function OnTakeDamage(Receiver, TDI)
	if CanMoving == false then
			return true
	end
	
	if BeforeTime == false then
			return true
	end
	
	
		if BeforeTime == true then
		if TDI.FinalDamage <=1 then
		
		TDI.FinalDamage=TDI.FinalDamage*math.random(1, 2)
		end
				TDI.FinalDamage = TDI.FinalDamage/math.random(2, 3)
	end
	
end





function OnDisconnect(Player, Reason)
	if (BeforeTime) then
		MyID = Player:GetUniqueID()
		for i = 0, NumEntities do
			if (PlayerId[i] == MyID) then
				PlayerId[i] = 99999999999
				PlayersTotal = PlayersTotal - 1
				Server = cRoot:Get()
				Statistic()
			end
		end
		WinnerScaner()
	end
	return true
end;





function OnPlayerSpawned(Player)
	World = Player:GetWorld()
	Player:GetName()
	Inventory = Player:GetInventory()
	Inventory:Clear()
	Player:TeleportToCoords(SpawnPosX, SpawnPosY, SpawnPosZ)	
	return true;
end;





function OnKilling(Victim, Killer)
	MyID = Victim:GetUniqueID()
	for i = 0, NumEntities do
		if (PlayerId[i] == MyID) then
			PlayerId[i]=99999999999
			PlayersTotal = PlayersTotal - 1
			Server = cRoot:Get()
			World = Victim:GetWorld()
			PlayerPos = Victim:GetPosition()
			World:CastThunderbolt(PlayerPos.x, PlayerPos.y, PlayerPos.z);
			Server:BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " The remaining ".. PlayersTotal.." players.")
			LOG(" The remaining ".. PlayersTotal.." players.")
			Statistic()
		end
	end
	WinnerScaner()
	return true;
end;




function OnPlayerUsedBlock(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType, BlockMeta)
	chestx=0
	if (BlockType == E_BLOCK_CHEST) then
		PlayerName = Player:GetName()
		WorldName = Player:GetWorld():GetName()

		-- ================================================================================
		local TestDB, ErrCode, ErrMsg = sqlite3.open("hunger.sqlite");
		local sql = "SELECT * FROM ChestData WHERE (x = " .. BlockX .. ") AND (y ='" .. BlockY .. "') AND (z ='" .. BlockZ .. "')  AND (BT ='" .. BlockType .. "') AND (WorldName ='" .. WorldName .. "')";
		local function Parser(UserData, NumValues, Values, Names)
			ido = Values[1]
			chestx = Values[2]
		end
		if (not(TestDB:exec(sql, Parser))) then
			return false;
		end
		TestDB:close();
		if (chestx == 0) then
			return true;
		end
		LoadChestContent(Split,Player)
		--===============================================================================

		local WindowType  = cWindow.Chest;
		local WindowSizeX = 9;
		local WindowSizeY = 3;
		local OnClosing = function(Window, Player, CanRefuse)
			return false
		end

		local OnSlotChanged = function(Window, SlotNum)
			UnLoadChestContent(Split,Player)
		end

		local Window = cLuaWindow(WindowType, WindowSizeX, WindowSizeY, "Old Chest");

		for i = 1, #Blocks do
			Window:SetSlot(Player, i, cItem(Blocks[i], 1));
		end

		Window:SetOnClosing(OnClosing);
		Window:SetOnSlotChanged(OnSlotChanged);
		Player:OpenWindow(Window);

		return true;
	else
		return false;
	end
end





function OnPlayerPlacingBlock(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType)
	if (BlockType == E_BLOCK_obsidiand) then
		sqlx =tonumber(BlockX)
		sqly = tonumber(BlockY)
		sqlz = tonumber(BlockZ)
		PlayerName = Player:GetName()
		WorldName = Player:GetWorld():GetName()
		local TestDB, ErrCode, ErrMsg = sqlite3.open("hunger.sqlite");
		local sql = "INSERT INTO BlocksPlaced (x, y, z, BF, BT, BM, WorldName, Owner) VALUES (" .. sqlx .. ", '" .. sqly .. "', '" .. sqlz .. "', '".. BlockFace .."', '".. BlockType .."', '".. BlockMeta .."', '".. WorldName .."', '".. PlayerName .."');";
		local Res = TestDB:exec(sql, ShowRow, 'UserData');
		if (Res ~= sqlite3.OK) then
			LOG("TestDB:exec() failed: " .. Res .. " (" .. TestDB:errmsg() .. ")");
		end;
		TestDB:close();
		return false;
	else
		if (canplace) then
			return false;
		else
			return true;
		end
	end
end;





function OnPlayerLeftClick(Player, BlockX, BlockY, BlockZ, BlockFace, Status, BlockMeta)
	World = Player:GetWorld()
	BlockType = World:GetBlock(BlockX, BlockY, BlockZ)
	BlockMeta = World:GetBlockMeta(BlockX, BlockY, BlockZ)
	if (BlockType == E_BLOCK_LEAVES) then
		sqlx =tonumber(BlockX)
		sqly = tonumber(BlockY)
		sqlz = tonumber(BlockZ)
		PlayerName = Player:GetName()
		WorldName = Player:GetWorld():GetName()
		local TestDB, ErrCode, ErrMsg = sqlite3.open("hunger.sqlite");
		local sql = "INSERT INTO BlocksBroken (x, y, z, BF, BT, BM, WorldName, Owner) VALUES (" .. sqlx .. ", '" .. sqly .. "', '" .. sqlz .. "', '".. BlockFace .."', '".. BlockType .."', '".. BlockMeta .."', '".. WorldName .."', '".. PlayerName .."');";
		local Res = TestDB:exec(sql, ShowRow, 'UserData');
		if (Res ~= sqlite3.OK) then
			LOG("TestDB:exec() failed: " .. Res .. " (" .. TestDB:errmsg() .. ")");
		end;
		TestDB:close();
		return false;
	else
		if (canbreak) then
			return false;
		else
		return true;
		end
	end
end;





-- EDITOR

function OnPlayerPlacedBlock(Player, BlockX, BlockY, BlockZ, BlockFace, CursorX, CursorY, CursorZ, BlockType, BlockMeta)
	if (EdtitorMode) then
		if (BlockType == E_BLOCK_CHEST) then
			sqlx =tonumber(BlockX)
			sqly = tonumber(BlockY)
			sqlz = tonumber(BlockZ)
			PlayerName = Player:GetName()
			WorldName = Player:GetWorld():GetName()
			dataids = 1
			local TestDB, ErrCode, ErrMsg = sqlite3.open("hunger.sqlite");
			local sql = "INSERT INTO ChestData (x, y, z, BF, BT, BM, WorldName, ContentID) VALUES (" .. sqlx .. ", '" .. sqly .. "', '" .. sqlz .. "', '".. BlockFace .."', '".. BlockType .."', '".. BlockMeta .."', '".. WorldName .."', '".. dataids .."');";
			local Res = TestDB:exec(sql, ShowRow, 'UserData');
			if (Res ~= sqlite3.OK) then
				LOG("TestDB:exec() failed: " .. Res .. " (" .. TestDB:errmsg() .. ")");
			end;
			TestDB:close();
			return false;
		end
	end
end;




