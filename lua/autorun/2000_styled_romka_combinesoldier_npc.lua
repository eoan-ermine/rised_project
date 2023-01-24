-- "lua\\autorun\\2000_styled_romka_combinesoldier_npc.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function AddNPC( t, class )
	list.Set( "NPC", class or t.Class, t )
end


local Category = "2000 Styled Combine Soldiers"

AddNPC( {
	Name = "2000 Combine Soldier",
	Class = "npc_combine_s",
	Category = Category,
	Model = "models/wickhex/jambo/combine/2000_Combine_Soldier.mdl",
	Weapons = { "weapon_smg1", "weapon_ar2" },
	KeyValues = { SquadName = "overwatch", Numgrenades = 5 }
}, "2000_CombineSoldier" )

AddNPC( {
	Name = "2000 Shotgun Soldier",
	Class = "npc_combine_s",
	Category = Category,
	Model = "models/wickhex/jambo/combine/2000_Combine_Soldier.mdl",
	Skin = 1,
	Weapons = { "weapon_shotgun" },
	KeyValues = { SquadName = "overwatch", Numgrenades = 5 }
}, "2000_ShotgunSoldier" )
