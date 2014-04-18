
-- Info.lua

-- Implements the g_PluginInfo standard plugin description




g_PluginInfo =
{
	Name = "HungerGames",
	Date = "2014-4-17",
	Description = "TODO!",
	
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
			},
		},
	},
};