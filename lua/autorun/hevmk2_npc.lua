-- "lua\\autorun\\hevmk2_npc.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local Category = "JustNPCS"

local function AddNPC( t, class )
	list.Set( "NPC", class or t.Class, t )
end

AddNPC( {
	Name = "HEV MK-II: Friendly", 
	Class = "npc_citizen",
	Category = Category,
	Model = "models/humans/hev_mark2.mdl",
	KeyValues = { citizentype = 4 },
	Weapons = { "weapon_pistol", "weapon_ar2", "weapon_smg1", "weapon_ar2", "weapon_shotgun" },
	Health = "100",
}, "hevmk2" )

AddNPC( {
	Name = "HEV MK-II: Not so Friendly",
	Class = "npc_combine_s",
	Category = Category,
	Model = "models/humans/hev_mark2.mdl",
	KeyValues = {Numgrenades = 4 },
	Weapons = { "weapon_pistol", "weapon_ar2", "weapon_smg1", "weapon_ar2", "weapon_shotgun" },
	Health = "100",
}, "hevmk2_evil" )