
-- Global variables
PLUGIN = {};
tp = {};	-- Reference to own plugin object
ItemsIDToChest = {};
PlayerNameIG={};

ItemsIDToChest[1]=258
ItemsIDToChest[2]="260,260,260"
ItemsIDToChest[3]=261
ItemsIDToChest[4]="262,262,262,262,262,262,262,262";
ItemsIDToChest[5]="266,266,266,266"
ItemsIDToChest[6]=267
ItemsIDToChest[7]=265
ItemsIDToChest[8]=270
ItemsIDToChest[9]=271
ItemsIDToChest[10]=272
ItemsIDToChest[11]=273
ItemsIDToChest[12]=274
ItemsIDToChest[13]=275
ItemsIDToChest[14]=283
ItemsIDToChest[15]=284
ItemsIDToChest[16]=285
ItemsIDToChest[17]=286
ItemsIDToChest[18]="296,296,296,296,296,296"
ItemsIDToChest[19]="297,297"
ItemsIDToChest[20]=298
ItemsIDToChest[21]=299
ItemsIDToChest[22]=300
ItemsIDToChest[23]=301
ItemsIDToChest[24]=302
ItemsIDToChest[25]=303
ItemsIDToChest[26]=304
ItemsIDToChest[27]=305
ItemsIDToChest[28]=306
ItemsIDToChest[29]=307
ItemsIDToChest[30]=308
ItemsIDToChest[31]=309

ItemsIDToChest[32]=314
ItemsIDToChest[33]=315
ItemsIDToChest[34]=316
ItemsIDToChest[35]=317

ItemsIDToChest[36]=319
ItemsIDToChest[37]=320
ItemsIDToChest[38]=322

ItemsIDToChest[39]=349
ItemsIDToChest[40]=350

ItemsIDToChest[41]=360
ItemsIDToChest[42]=363
ItemsIDToChest[43]=364
ItemsIDToChest[44]=365
ItemsIDToChest[45]=366
ItemsIDToChest[46]=367




ItemsIDToChest[47]=391
ItemsIDToChest[48]=392
ItemsIDToChest[49]=393
ItemsIDToChest[50]=305
ItemsIDToChest[51]=0
ItemsIDToChest[52]=0
ItemsIDToChest[53]=0
ItemsIDToChest[54]=0
ItemsIDToChest[55]=0
ItemsIDToChest[56]=0
ItemsIDToChest[57]=0
ItemsIDToChest[58]=0
ItemsIDToChest[59]=0
ItemsIDToChest[60]=0
ItemsIDToChest[61]=0



ItemsIDToChest[62]="360,360,360"
ItemsIDToChest[63]="363,363,363"
ItemsIDToChest[64]="364,364,364"
ItemsIDToChest[65]="365,365,365"
ItemsIDToChest[66]="366,366,367"
ItemsIDToChest[67]="367,367,368"

PlayerId= {};


--AllItemsIDToChest="256,257,260,261,262,266,265,267,268,269,270,271,272,273,274,275,282,283,284,285,286,288,290,291,292,294,296,297,298,299,300,301,302,303,304,305,306,307,308,309,314,315,316,317,319,320,322,334,349,350,357,360,363,364,365,366,367,391,392,393,394,395"


PlayersTotal=0
--------------------------

WinnerName="unknown"

canbreak=false
canplace=false

CanMoving=false;
BeforeTime=false
EdtitorMode=false
ThisisWin=false

JustLoad=false

function Initialize(Plugin)
	PLUGIN = Plugin
	Plugin:SetName("HungerGamesPlugin")
	Plugin:SetVersion("4")
		PluginManager = cRoot:Get():GetPluginManager()

			cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_LEFT_CLICK, OnPlayerLeftClick)
			cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_PLACING_BLOCK, OnPlayerPlacingBlock)
			cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_PLACED_BLOCK, OnPlayerPlacedBlock)
			cPluginManager.AddHook(cPluginManager.HOOK_PLAYER_USED_BLOCK, OnPlayerUsedBlock)
			cPluginManager.AddHook(cPluginManager.HOOK_TICK, OnTick)
			cPluginManager.AddHook(cPluginManager.HOOK_WORLD_TICK, OnWorldTick )
			cPluginManager.AddHook(cPluginManager.HOOK_WORLD_TICK, OnWorldTickTwo )
			cPluginManager.AddHook( cPluginManager.HOOK_KILLING, OnKilling )
		    cPluginManager.AddHook( cPluginManager.HOOK_PLAYER_SPAWNED, OnPlayerSpawned )
          	cPluginManager.AddHook( cPluginManager.HOOK_DISCONNECT, OnDisconnect )
			cPluginManager.AddHook( cPluginManager.HOOK_TAKE_DAMAGE, OnTakeDamage )
		cPluginManager.AddHook(cPluginManager.HOOK_HANDSHAKE, OnHandshake)

	
		PluginManager:BindCommand("/revi", "hungergames.Reviv", reviveblockstwo,      " reviveblocks");
		PluginManager:BindCommand("/canbreak", "hungergames.Break", 	CanBreak,      " CanBreak blocks");
		PluginManager:BindCommand("/canplace", "hungergames.Place", 	CanPlace,      " CanPlace blocks");
		PluginManager:BindCommand("/restartround", "hungergames.restart", 	RestartRound,      " RestartRound");
		PluginManager:BindCommand("/startround", "hungergames.start", 	startRound,      " StartRound")
		PluginManager:BindCommand("/players", "ShowPlayersInGame", 	ShowPlayersInGame,      " Show Players in Hunger Game");
--		PluginManager:BindCommand("/pl", "ShowPlayersInGame", 	pl,      " Show Players in Hunger Game");
		PluginManager:BindCommand("/em", "EdtitorModeActivate", 	EdtitorModeActivate,      " 0 or 1 to enable/disable chest editor mode");

LoadSettings()
LoadTimes()
UnLoadItemsIntoBD()
RestartRound()

	return true
end;