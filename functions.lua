function Statistic()
World = cRoot:Get():GetDefaultWorld()
Line1=(cChatColor.Red .."In Game")
Line2=(cChatColor.Black ..PlayersTotal)
Line3=(cChatColor.Navy .."players")
 World:UpdateSign( -662, 74, 367 , Line1 , Line2, Line3, Line4 )
 		return true;
end



--[[
function BuildINIITEMS(Split, Player)
SettingsIni = cIniFile( PLUGIN:GetLocalDirectory() .. "/Items.ini" )
	SettingsIni:ReadFile()
	SettingsIni:Clear()
local split = StringSplit(AllItemsIDToChest, "\,");
	ItemsNum=#split
	for i=1,20 do
	fromstring = ("ID"..i)
itemONE=math.random(ItemsNum)
		itemTWO=math.random(ItemsNum)
	itemTHREE=math.random(ItemsNum)

	
	itemONERANDOM=math.random(2)
		itemTWORANDOM=math.random(2)
	itemTHREERANDOM=math.random(2)
	
	ItemOneEnd=split[itemONE]
ItemTwoEnd=split[itemTWO]
ItemThreeEnd=split[itemTHREE]
	ItemOneEndD=0
	ItemTwoEndD=0
	ItemThreeEndD=0
	for j=1,itemONERANDOM do
	ItemOneEndD=(ItemOneEndD..","..ItemOneEnd)
	end
	
	for k=1,itemTWORANDOM do
	ItemTwoEndD=(ItemTwoEndD..","..ItemTwoEnd)
	end
	
	for l=1,itemTHREERANDOM do
	ItemThreeEndD=(ItemThreeEndD..","..ItemThreeEnd)
	end
	
	ToChestString=(ItemOneEndD..","..ItemTwoEndD..","..ItemThreeEndD)
	BlockedBlocks = SettingsIni:GetValueSet(fromstring, "Content", ToChestString )
	end
	Blocks = StringSplit( BlockedBlocks, "," )
	SettingsIni:WriteFile()
		return true;
	end;

--]]

function LoadTimes()
Ini = cIniFile( PLUGIN:GetLocalDirectory() .. "/Config.ini" )
	Ini:ReadFile()
	Time = Ini:GetValueSetI( "Times", "Time") 
	InternalTime = Ini:GetValueSetI( "Times", "InternalTime" )
	TimeBefore = Ini:GetValueSetI( "Times", "TimeBefore")
	Ini:WriteFile()
return true;
end

function LoadSettings()
Ini = cIniFile( PLUGIN:GetLocalDirectory() .. "/Config.ini" )
	Ini:ReadFile()
	SpawnPosX = Ini:GetValueSetI( "Spawn", "X") 
	SpawnPosY = Ini:GetValueSetI( "Spawn", "Y" )
	SpawnPosZ = Ini:GetValueSetI( "Spawn", "Z")
	Ini:WriteFile()
return true;
end

	
	
	
	
	function ShowPlayersInGame(Split, Player)
	if PlayersTotal > 0 then
	PlayerNamesIG=""
	 local ScanPlayerInGame = function(OtherPlayer)
		 MyID=OtherPlayer:GetUniqueID()
  	for i=0,PlayersTotal do
if PlayerId[i]==MyID then
PlayerName=OtherPlayer:GetName()
PlayerNameIG[i]=PlayerName
PlayerNamesIG=(PlayerNamesIG.."  "..PlayerName)
end
end
end


cRoot:Get():ForEachPlayer(ScanPlayerInGame)
			Player:SendMessage(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.LightGreen .." "..PlayerNamesIG.. "" )

end
		Player:SendMessage(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .." "..PlayersTotal.. " players in game! " )
		
				return true;
	end;
	
	
	
	function RestartRound(Split, Player)
	PlayersTotal=0
	UnLoadItemsIntoBD()

local TPTOSPAWN = function(OtherPlayer)
	 World = OtherPlayer:GetWorld()
	   OtherPlayer:GetName()
          Inventory = OtherPlayer:GetInventory()
	   Inventory:Clear()
		OtherPlayer:TeleportToCoords( SpawnPosX , SpawnPosY ,SpawnPosZ  )	
			LoadTimes()
			reviveblockstwo()
			BeforeTime=false
			CanMoving=false;
end
cRoot:Get():ForEachPlayer(TPTOSPAWN)
if ThisisWin ~= true then
		cRoot:Get():BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Green .. " Round Restarted." )
		end
		
			if JustLoad == true then
						Statistic()
		end
			JustLoad=true
			
			
			ThisisWin=false
		return true;
	end;



	function startRound(Split, Player)
				LoadTimes()
			Time = 100;
			BeforeTime=true
			TimeBefore=0
			CanMoving=false;
		return true;
	end;






function CanBreak(Split,Player)
	if #Split < 2 then
		Player:SendMessage(cChatColor.Red .. 'Error')
		return true
	end
 if Split[2] == "1" then
canbreak=true
		Player:SendMessage(cChatColor.LightGreen .. 'canbreak=true ')
end
if Split[2] == "0" then
canbreak=false
		Player:SendMessage(cChatColor.Red .. 'canbreak=false ')
end
	return true
end



function CanPlace(Split,Player)
	if #Split < 2 then
		Player:SendMessage(cChatColor.Red .. 'Error')
		return true
	end
 if Split[2] == "1" then
canplace=true
		Player:SendMessage(cChatColor.LightGreen .. 'CanPlace=true ')
end
if Split[2] == "0" then
canplace=false
		Player:SendMessage(cChatColor.Red .. 'CanPlace=false ')
end
	return true
end


--============== РЕЖИМ РЕДАКТОРА ==============--
function EdtitorModeActivate(Split,Player)
	if #Split < 2 then
		Player:SendMessage(cChatColor.Red .. 'Error')
		return true
	end
 if Split[2] == "1" then
EdtitorMode=true
		Player:SendMessage(cChatColor.LightGreen .. 'EdtitorMode=true ')
end
if Split[2] == "0" then
EdtitorMode=false
		Player:SendMessage(cChatColor.Red .. 'EdtitorMode=false ')
end
	return true
end
--============== КОНЕЦ ==============--



function WinnerScaner()
	if PlayersTotal<=1 then
	Server = cRoot:Get()
		 local ScanPlayer = function(OtherPlayer)
		 MyID=OtherPlayer:GetUniqueID()
  	for i=0,NumEntities do
if PlayerId[i]==MyID then
WinnerName=OtherPlayer:GetName()
break
end
end
end
cRoot:Get():ForEachPlayer(ScanPlayer)
	Server:BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Yellow .. " Congratulations to the winner of the nickname ".. cChatColor.LightBlue .. WinnerName.."".. cChatColor.Yellow .. "!!!" )
	Server:BroadcastChat(cChatColor.LightGray .. "[".. cChatColor.Rose .. "HG".. cChatColor.LightGray .. "]".. cChatColor.Rose .. " Hunger Game Over!" )
	LOG(" Congratulations to the winner of the nickname ".. WinnerName.." !!!")
	ThisisWin=true
 RestartRound()
end
		return true;
	end;





--============== Когда сундук был поюзан, удаляем его из ини файла ==============--
function UnLoadChestContent(Split,Player)
Ini = cIniFile( PLUGIN:GetLocalDirectory() .. "/Chests.ini" )
	Ini:ReadFile()
		fromstring = ("ID"..ido)
	 Ini:DeleteValue(fromstring, "Content" )
Ini:WriteFile()
end
--===================================== КОНЕЦ ====================================--


--============== Когда сундук был открыт, загружаем его содержимое ==============--
function LoadChestContent(Split,Player)
Ini = cIniFile( PLUGIN:GetLocalDirectory() .. "/Chests.ini" )
	Ini:ReadFile()
		fromstring = ("ID"..ido)
	Content = Ini:GetValue( fromstring, "Content" )
	if Content == nil then
	Content = 0
	end
	Blocks = StringSplit( Content, "," )
	Ini:WriteFile()
end
--===================================== КОНЕЦ ====================================--



--============== УДАЛЯЕМ И ЗАГРУЖАЕМ СОДЕРЖИМОЕ СУНДУКОВ В ИНИ ФАЙЛ ==============--
function UnLoadItemsIntoBD(Split, Player)
SettingsIni = cIniFile( PLUGIN:GetLocalDirectory() .. "/Chests.ini" )
	SettingsIni:ReadFile()
	SettingsIni:Clear()
	SettingsIni:WriteFile()
		return true;
	end;

function LoadItemsIntoBD(Split, Player)
SettingsIni = cIniFile( PLUGIN:GetLocalDirectory() .. "/Chests.ini" )
	SettingsIni:ReadFile()
	SettingsIni:Clear()

	for i=1,30 do
	fromstring = ("ID"..i)
	selecteditemONE=math.random(50)
		selecteditemTWO=math.random(50)
	selecteditemTHREE=math.random(50)
	ToChestString=(ItemsIDToChest[selecteditemONE]..","..ItemsIDToChest[selecteditemTWO]..","..ItemsIDToChest[selecteditemTHREE])
	BlockedBlocks = SettingsIni:GetValueSet(fromstring, "Content", ToChestString )
	end
	Blocks = StringSplit( BlockedBlocks, "," )
	SettingsIni:WriteFile()
		return true;
	end;
--===================================== КОНЕЦ ====================================--




	--[[	function pl(Split, Player)
SettingsIni = cIniFile( PLUGIN:GetLocalDirectory() .. "/PlayersInGame.ini" )
	SettingsIni:ReadFile()
	SettingsIni:Clear()
		 local ScanPlayer = function(OtherPlayer)
		 MyID=OtherPlayer:GetUniqueID()
  	for i=0,PlayersTotal do
if PlayerId[i]==MyID then
PlayerName=OtherPlayer:GetName()
PlayerNameIG[i]=PlayerName
	BlockedBlocks = SettingsIni:GetValueSet(i, "Nickname", PlayerName )

end
end
end

cRoot:Get():ForEachPlayer(ScanPlayer)
	SettingsIni:WriteFile()
		return true;
	end;
	
	--]]
	
	
	
	

	function GetUniqueID(Split, Player)
	NumEntities=0
		 local SendMessage = function(OtherPlayer)
  		PlayerId[NumEntities]=OtherPlayer:GetUniqueID()
  		NumEntities = NumEntities + 1;
end
cRoot:Get():ForEachPlayer(SendMessage)
PlayersTotal=NumEntities
		return true;
	end;
	



function LoadSpawnCoords(Split,Player)
	local loopPlayers = function( Player )
GetUniqueID(Split, Player)
MyID=Player:GetUniqueID()
for i=0,NumEntities do
if PlayerId[i]==MyID then
PositionMy=i
end
end
--Player:SendMessage( "myidtrue= "..PositionMy);
Ini = cIniFile( PLUGIN:GetLocalDirectory() .. "/SpawnPos.ini" )
	Ini:ReadFile()
		fromstring = (PositionMy)
	spawncoordx = Ini:GetValue( fromstring, "x" )
	spawncoordy = Ini:GetValue( fromstring, "y" )
	spawncoordz = Ini:GetValue( fromstring, "z" )
	Ini:WriteFile()	  		
Player:TeleportToCoords(tonumber(spawncoordx),tonumber(spawncoordy),tonumber(spawncoordz))
   Player:GetName()
          Inventory = Player:GetInventory()
	   Inventory:Clear()
Player:Heal(100)
Player:SetFoodLevel(20);
end
cRoot:Get():ForEachPlayer(loopPlayers)
return true
end









--============================================================================================
--============================================================================================
--============================================================================================
--============================================================================================



function BlocksPlaced()
	LOG("Testing SQLite bindings...");
	
	-- Debug SQLite binding
	local TestDB, ErrCode, ErrMsg = sqlite3.open("hunger.sqlite");
	if (TestDB ~= nil) then
		local function ShowRow(UserData, NumCols, Values, Names)
			assert(UserData == 'UserData');
			LOG("New row");
			for i = 1, NumCols do
				LOG("  " .. Names[i] .. " = " .. Values[i]);
			end
			return 0;
		end
		local sql = [=[
			CREATE TABLE BlocksPlaced(x,y,z,BF,BT,BM,WorldName,Owner);
		]=]
		local Res = TestDB:exec(sql, ShowRow, 'UserData');
		if (Res ~= sqlite3.OK) then
			LOG("TestDB:exec() failed: " .. Res .. " (" .. TestDB:errmsg() .. ")");
		end;
		TestDB:close();
	else
		-- This happens if for example SQLite cannot open the file (eg. a folder with the same name exists)
		LOG("SQLite3 failed to open DB! (" .. ErrCode .. ", " .. ErrMsg ..")");
	end
	
	LOG("SQLite bindings test ended");
end


function BlocksBroken()
	LOG("Testing SQLite bindings...");
	
	-- Debug SQLite binding
	local TestDB, ErrCode, ErrMsg = sqlite3.open("hunger.sqlite");
	if (TestDB ~= nil) then
		local function ShowRow(UserData, NumCols, Values, Names)
			assert(UserData == 'UserData');
			LOG("New row");
			for i = 1, NumCols do
				LOG("  " .. Names[i] .. " = " .. Values[i]);
			end
			return 0;
		end
		local sql = [=[
			CREATE TABLE BlocksBroken(x,y,z,BF,BT,BM,WorldName,Owner);
		]=]
		local Res = TestDB:exec(sql, ShowRow, 'UserData');
		if (Res ~= sqlite3.OK) then
			LOG("TestDB:exec() failed: " .. Res .. " (" .. TestDB:errmsg() .. ")");
		end;
		TestDB:close();
	else
		-- This happens if for example SQLite cannot open the file (eg. a folder with the same name exists)
		LOG("SQLite3 failed to open DB! (" .. ErrCode .. ", " .. ErrMsg ..")");
	end
	
	LOG("SQLite bindings test ended");
end




function ChestData()
	LOG("Testing SQLite bindings...");
	
	-- Debug SQLite binding
	local TestDB, ErrCode, ErrMsg = sqlite3.open("hunger.sqlite");
	if (TestDB ~= nil) then
		local function ShowRow(UserData, NumCols, Values, Names)
			assert(UserData == 'UserData');
			LOG("New row");
			for i = 1, NumCols do
				LOG("  " .. Names[i] .. " = " .. Values[i]);
			end
			return 0;
		end
		local sql = [=[
			CREATE TABLE ChestData(x,y,z,BF,BT,BM,WorldName,ContentID);
		]=]
		local Res = TestDB:exec(sql, ShowRow, 'UserData');
		if (Res ~= sqlite3.OK) then
			LOG("TestDB:exec() failed: " .. Res .. " (" .. TestDB:errmsg() .. ")");
		end;
		TestDB:close();
	else
		-- This happens if for example SQLite cannot open the file (eg. a folder with the same name exists)
		LOG("SQLite3 failed to open DB! (" .. ErrCode .. ", " .. ErrMsg ..")");
	end
	
	LOG("SQLite bindings test ended");
end




function reviveblockstwo(Split, Player)
World = 	cRoot:Get():GetDefaultWorld()
WorldName = World:GetName()

		local TestDB, ErrCode, ErrMsg = sqlite3.open("hunger.sqlite");
		local function ShowRow(UserData, NumCols, Values, Names)
		NumBlocks = Values[1]
		end
		
		local sql = "SELECT COUNT(*) FROM BlocksBroken";
local Res = TestDB:exec(sql, ShowRow, 'UserData');			
			
		for i=1,NumBlocks do
			local sqls = "SELECT * FROM BlocksBroken WHERE (rowid = " .. i .. ")";
				local function Parser(UserData, NumValues, Values, Names)
	removedx = Values[1]
		removedy = Values[2]
	removedz = Values[3]
		removebf = Values[4]
		removedbt = Values[5]
			removedbm = Values[6]
	end
	
		if (not(TestDB:exec(sqls, Parser))) then
		return false;
	end
	blala=removedbt..':'..removedbm
	blockneed=BlockStringToType(blala)
World:FastSetBlock(removedx, removedy, removedz,removedbt,removedbm)


      	local sqlr = "DELETE FROM BlocksBroken  WHERE (x = " .. removedx .. ") AND (y ='" .. removedy .. "') AND (z ='" .. removedz .. "') AND (WorldName ='" .. WorldName .. "')";
  	local Res = TestDB:exec(sqlr, ShowRow, 'UserData');
		if (Res ~= sqlite3.OK) then
			LOG("TestDB:exec() failed: " .. Res .. " (" .. TestDB:errmsg() .. ")");
		end;
end
	--	Player:SendMessage(cChatColor.Red .. 'Revived= '..NumBlocks..' blocks')
		TestDB:close();
		return true;
	end;

	
	
	function reviveblocks(Split, Player)
PlayerName = Player:GetName()
World = Player:GetWorld()
WorldName = Player:GetWorld():GetName()

		local TestDB, ErrCode, ErrMsg = sqlite3.open("hunger.sqlite");
		local function ShowRow(UserData, NumCols, Values, Names)
		NumBlocks = Values[1]
		end
		
		local sql = "SELECT COUNT(*) FROM BlocksPlaced";
local Res = TestDB:exec(sql, ShowRow, 'UserData');			
			
		for i=1,NumBlocks do
			local sqls = "SELECT * FROM BlocksPlaced WHERE (rowid = " .. i .. ")";
				local function Parser(UserData, NumValues, Values, Names)
	removedx = Values[1]
		removedy = Values[2]
	removedz = Values[3]
		removedbt = Values[5]
			removedbm = Values[6]
	end
	
		if (not(TestDB:exec(sqls, Parser))) then
		return false;
	end
	
World:FastSetBlock(removedx, removedy, removedz,-0,0)

      	local sqlr = "DELETE FROM BlocksPlaced  WHERE (x = " .. removedx .. ") AND (y ='" .. removedy .. "') AND (z ='" .. removedz .. "') AND (WorldName ='" .. WorldName .. "')";
  	local Res = TestDB:exec(sqlr, ShowRow, 'UserData');
		if (Res ~= sqlite3.OK) then
			LOG("TestDB:exec() failed: " .. Res .. " (" .. TestDB:errmsg() .. ")");
		end;
end
		Player:SendMessage(cChatColor.Red .. 'Removed= '..NumBlocks..' blocks')
		TestDB:close();
		return true;
	end;

