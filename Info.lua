
-- Info.lua

-- Implements the g_PluginInfo standard plugin description




g_PluginInfo =
{
	Name = "HungerGames",
	Date = "2014-4-17",
	SourceLocation = "https://github.com/mc-server/HungerGames",
	Description = 
[[
A hunger games plugin for MCServer.

You are able to create multiple different arenas in different worlds. People can join those arenas and battle each other.
The players search for chests where they can find loot. They need it so for survival. Eventualy only one player is left and he'll be the winner.
]],
	
	Commands =
	{
		["/hg"] =
		{
			Permission = "",
			HelpString = "",
			Handler = nil,
			Subcommands =
			{
				select =
				{
					HelpString = "Used to select an arena. In the selected arena you can add spawnpoints.",
					Permission = "hungergames.select",
					Handler = HandleSelectCommand,
					ParameterCombinations =
					{
						{
							Params = "ArenaName",
							Help = "The name of the arena you would like to select.",
						},
					},
				},
				
				create =
				{
					HelpString = "Creates an new arena.",
					Permission = "hungergames.create",
					Handler = HandleCreateCommand,
					ParameterCombinations =
					{
						{
							Params = "ArenaName",
							Help = "The name of the arena you would like to create.",
						},
					},
				},
				
				add =
				{
					HelpString = "Adds a spawnpoint for the selected arena.",
					Permission = "hungergames.add",
					Handler = HandleAddCommand,
				},
				
				setboundingbox =
				{
					Alias = {"sbb", "bb"},
					HelpString = "Sets the size of the arena. All the chests inside will be filled.",
					Permission = "hungergames.setsize",
					Handler = HandleSetBoundingBoxCommand,
					ParameterCombinations =
					{
						{
							Params = "1",
							Help = "Set point 1",
						},
						
						{
							Params = "2",
							Help = "Set point 2",
						},
					},
				},
				
				join =
				{
					Alias = {"j"},
					HelpString = "Join an arena",
					Permission = "hungergames.join",
					Handler = HandleJoinCommand,
					ParameterCombinations =
					{
						{
							Params = "ArenaName",
							Help = "The name of the arena.",
						},
					},
				},
				
				leave =
				{
					HelpString = "Leave an arena",
					Permission = "hungergames.leave",
					Handler = HandleLeaveCommand,
				},
				
				setlobby =
				{
					HelpString = "Set a new position for the lobby",
					Permission = "hungergames.setlobby",
					Handler = HandleSetLobbyCommand,
				},
				
				spectate =
				{
					HelpString = "Allows you to spectate an arena",
					Permission = "hungergames.spectate",
					Handler = HandleSpectateCommand,
				},
			},
		},
	},
	
	AdditionalInfo =
	{
		{
			Title = "Setting up an arena",
			Contents =
[[
Assuming the server owner/admin already has a map.

1) {%b}Create the arena{%/b}
   To create an arena you use "/hg create [ArenaName]".
   The coordinates where you stand will be the coordinates for the lobby. When a player joins or dies in an arena he will be teleported there.
   
2) {%b}Setting the bounding box{%/b}
   Then you need to set the bounding box of the arena.
   All the chests within this bounding box will be refilled once the arena starts so it is needed. You set it using "/hg bb (point|1,2)".
   So basicly point 1 is on one side of the arena and point 2 on the opposite.
   
3) {%b}Adding spawnpoints{%/b}
   Then you have to add spawnpoints. You add them by using "/hg add"
   When an arena starts all the players will be sent to a different spawnpoint.
   
And there you have it. Your own HungerGames arena.
]],
		},
		
		{
			Title = "Configuring HungerGames",
			Contents =
[[
First open the "Config.cfg" file.

I think the variables CountDownTime, NoDamageTime, PreventMonsterSpawn and PreventAnimalSpawn speak for themselves, but just to be sure:
  {%b}CountDownTime:{%/b} The time a player can't move and do anything when an arena starts.
  {%b}NoDamageTime:{%/b} The amount of time a player can't take any damage from another player
  {%b}PreventMonsterSpawn:{%/b} If set to true then monsters (zombies, skeletons creepers etc) can't spawn inside the bounding box of an arena.
  {%b}PreventAnimalSpawn:{%/b} Same as PreventMonsterSpawn but then for animals (pigs, cows, chicken etc).
  
The hardest part is configuring the loot what a chest can have, but once you know it it's really easy.
To add an item to the list of available loot you go to ChestContent and add this behind it: 

{%code}
{
	ItemType = ItemID,
	ItemMeta = ItemMeta,
	Chance = Chance,
	Enchantment = "enchantmentname",
},
{%/code}

{%b}ItemType:{%/b} The itemid you want to have for example 267 for a diamond sword.
{%b}ItemMeta:{%/b} The meta you want to give the item.
{%b}Enchantment:{%/b} You don't have to put this in, but if you want an enchantment you simply give the name of the enchantment with an equal symbol and the level. For example: "sharpness=2" If you want multiple enchantments you use a ";" between the enchantments.
{%b}Chance:{%/b} This is important. -- IF this item gets chosen then the server chooses a random number between 1 and the given number and if it's 1 this item gets put in the chest. The problem with this is the more items you have available the less chance this item gets chosen.

Also don't forget the comma. You have to place them at the exact spot as where they are in this example.
]]
		},
	},
};