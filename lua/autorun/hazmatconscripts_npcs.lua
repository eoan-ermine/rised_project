-- "lua\\autorun\\hazmatconscripts_npcs.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local Category = "Hazmat Conscripts"

local NPC = { 	Name = "Hazmat Conscript (Friendly)", 
				Class = "npc_citizen",
				Weapons = { "weapon_ar2" },
				Model = "models/player/hazmat/hazmat1980_npc.mdl",
				Health = "100",
				KeyValues = { citizentype = 4 },
                                Category = Category    }

list.Set( "NPC", "hazmatconscript_citizennpc", NPC )

local NPC = { 	Name = "Hazmat Conscript (Enemy)", 
				Class = "npc_combine_s",
				Model = "models/player/hazmat/hazmat1980_npc_combine.mdl",
				Health = "100",
				Squadname = "Hostile Conscripts",
				Numgrenades = "2",
				Category = Category	}

list.Set( "NPC", "hazmatconscript_combine_s", NPC )