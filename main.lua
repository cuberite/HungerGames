
PLUGIN = {};
tp = {};
ItemsIDToChest = {};
PlayerNameIG={};


-- Items that will spawn in the chests on the map
ItemsIDToChest[1] = 258;
ItemsIDToChest[2] = "260,260,260";
ItemsIDToChest[3] = 261;
ItemsIDToChest[4] = "262,262,262,262,262,262,262,262";
ItemsIDToChest[5] = "266,266,266,266";
ItemsIDToChest[6] = 267;
ItemsIDToChest[7] = 265;
ItemsIDToChest[8] = 270;
ItemsIDToChest[9] = 271;
ItemsIDToChest[10] = 272;
ItemsIDToChest[11] = 273;
ItemsIDToChest[12] = 274;
ItemsIDToChest[13] = 275;
ItemsIDToChest[14] = 283;
ItemsIDToChest[15] = 284;
ItemsIDToChest[16] = 285;
ItemsIDToChest[17] = 286;
ItemsIDToChest[18] = "296,296,296,296,296,296";
ItemsIDToChest[19] = "297,297";
ItemsIDToChest[20] = 298;
ItemsIDToChest[21] = 299;
ItemsIDToChest[22] = 300;
ItemsIDToChest[23] = 301;
ItemsIDToChest[24] = 302;
ItemsIDToChest[25] = 303;
ItemsIDToChest[26] = 304;
ItemsIDToChest[27] = 305;
ItemsIDToChest[28] = 306;
ItemsIDToChest[29] = 307;
ItemsIDToChest[30] = 308;
ItemsIDToChest[31] = 309;

ItemsIDToChest[32] = 314;
ItemsIDToChest[33] = 315;
ItemsIDToChest[34] = 316;
ItemsIDToChest[35] = 317;
ItemsIDToChest[36] = 319;
ItemsIDToChest[37] = 320;
ItemsIDToChest[38] = 322;
ItemsIDToChest[39] = 349;
ItemsIDToChest[40] = 350;

ItemsIDToChest[41] = 360;
ItemsIDToChest[42] = 363;
ItemsIDToChest[43] = 364;
ItemsIDToChest[44] = 365;
ItemsIDToChest[45] = 366;
ItemsIDToChest[46] = 367;


ItemsIDToChest[47] = 391;
ItemsIDToChest[48] = 392;
ItemsIDToChest[49] = 393;
ItemsIDToChest[50] = 305;
ItemsIDToChest[51] = 0;
ItemsIDToChest[52] = 0;
ItemsIDToChest[53] = 0;
ItemsIDToChest[54] = 0;
ItemsIDToChest[55] = 0;
ItemsIDToChest[56] = 0;
ItemsIDToChest[57] = 0;
ItemsIDToChest[58] = 0;
ItemsIDToChest[59] = 0;
ItemsIDToChest[60] = 0;
ItemsIDToChest[61] = 0;



ItemsIDToChest[62] = "360,360,360"
ItemsIDToChest[63] = "363,363,363"
ItemsIDToChest[64] = "364,364,364"
ItemsIDToChest[65] = "365,365,365"
ItemsIDToChest[66] = "366,366,367"
ItemsIDToChest[67] = "367,367,368"

PlayerId = {}; 

PlayersTotal = 0;
--------------------------

WinnerName = "unknown"
canbreak = false;
canplace = false;
CanMoving = false;
BeforeTime = false;
EdtitorMode = false;
ThisisWin = false;
JustLoad = false;

function Initialize(Plugin)
	PLUGIN = Plugin
	Plugin:SetName("HungerGamesPlugin")
	Plugin:SetVersion("4")
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_LEFT_CLICK,    OnPlayerLeftClick)
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_PLACING_BLOCK, OnPlayerPlacingBlock)
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_PLACED_BLOCK,  OnPlayerPlacedBlock)
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_USED_BLOCK,    OnPlayerUsedBlock)
	cPluginManager.AddHook(cPluginManager.HOOK_TICK,                 OnTick)
	cPluginManager.AddHook(cPluginManager.HOOK_WORLD_TICK,           OnWorldTick)
	cPluginManager.AddHook(cPluginManager.HOOK_WORLD_TICK,           OnWorldTickTwo)
	cPluginManager.AddHook(cPluginManager.HOOK_KILLING,              OnKilling)
	cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_SPAWNED,       OnPlayerSpawned)
	cPluginManager.AddHook(cPluginManager.HOOK_DISCONNECT,           OnDisconnect)
	cPluginManager.AddHook(cPluginManager.HOOK_TAKE_DAMAGE,          OnTakeDamage)
	cPluginManager.AddHook(cPluginManager.HOOK_HANDSHAKE,            OnHandshake)

	PM = cRoot:Get():GetPluginManager()
	PM:BindCommand("/revi",         "hungergames.Reviv",   reviveblockstwo,      " Restore foliage destroyed during the round");
	PM:BindCommand("/canbreak",     "hungergames.Break",   CanBreak,             " Allow to break blocks");
	PM:BindCommand("/canplace",     "hungergames.Place",   CanPlace,             " Allow to place blocks");
	PM:BindCommand("/restartround", "hungergames.restart", RestartRound,         " Restart Round");
	PM:BindCommand("/startround",   "hungergames.start",   startRound,           " Start Round")
	PM:BindCommand("/players",      "ShowPlayersInGame",   ShowPlayersInGame,    " Show Players in Hunger Game");
	PM:BindCommand("/em",           "EdtitorModeActivate", EdtitorModeActivate,  " 0 or 1 to enable / disable chest editor mode");
	LoadSettings() -- Load spawn position
	LoadTimes() -- Load timers from Config.ini
	UnLoadItemsIntoBD() -- Clean the contents of the chests 
	RestartRound() -- Restart round, then reset all the counters of time to return to the pre-spawn all, if the required number of players had accumulated (2), teleport all players on the map.
	return true
end;




