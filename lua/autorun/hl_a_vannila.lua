-- "lua\\autorun\\hl_a_vannila.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local Category = "Rised Project"
 
local NPC = {   Name = "Combine", 
                Class = "npc_combine_s",
                Model = "models/rised_project/combine/rised_combine.mdl",
                Health = "100", 
                Weapons = { "weapon_ar2" }, 
                Category = Category }
                               
list.Set( "NPC", "npc_rised_combine", NPC )

