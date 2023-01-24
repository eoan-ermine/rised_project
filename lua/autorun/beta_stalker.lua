-- "lua\\autorun\\beta_stalker.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local NPC = { 	Name = "Beta Stalker", 
				Class = "npc_stalker",
				Model = "models/Beta Stalker/stalker.mdl",
				Health = "100",
				Offset = 30,
				KeyValues = { SquadName = "overwatch" },
				Category = "Combine"	}
			 
list.Set( "NPC","Beta_Stalker", NPC )