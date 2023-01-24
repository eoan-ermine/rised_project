-- "lua\\autorun\\hlvr_combine_workers_npc.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local Category = "Half-Life: Alyx"
local NPC = {
		 		Name = "Friendly Combine Worker", 
				Class = "npc_citizen",
				KeyValues = { citizentype = 4 },
				Model = "models/hlvr/characters/worker/npc/worker_citizen.mdl",
				Health = "100",
				Category = Category	
		}
list.Set( "NPC", "npc_friendly_hlvr_combine_worker", NPC )

local Category = "Half-Life: Alyx"
local NPC = {
		 		Name = "Hostile Combine Worker", 
				Class = "npc_combine_s",
				KeyValues = { citizentype = 4 },
				Model = "models/hlvr/characters/worker/npc/worker_combine.mdl",
				Health = "100",
				Category = Category	
		}
list.Set( "NPC", "npc_hostile_hlvr_combine_worker.vmt", NPC )

local Category = "Half-Life: Alyx"
local NPC = {
		 		Name = "Friendly Hazmat Worker", 
				Class = "npc_citizen",
				KeyValues = { citizentype = 4 },
				Model = "models/hlvr/characters/hazmat_worker/npc/hazmat_worker_citizen.mdl",
				Health = "100",
				Category = Category	
		}
list.Set( "NPC", "npc_friendly_hlvr_hazmat_worker", NPC )

local Category = "Half-Life: Alyx"
local NPC = {
		 		Name = "Hostile Hazmat Worker", 
				Class = "npc_combine_s",
				KeyValues = { citizentype = 4 },
				Model = "models/hlvr/characters/hazmat_worker/npc/hazmat_worker_combine.mdl",
				Health = "100",
				Category = Category	
		}
list.Set( "NPC", "npc_hostile_hlvr_hazmat_worker", NPC )