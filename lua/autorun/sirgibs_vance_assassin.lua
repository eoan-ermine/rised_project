-- "lua\\autorun\\sirgibs_vance_assassin.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function AddPlayerModel( name, model )

    list.Set( "PlayerOptionsModel", name, model )
    player_manager.AddValidModel( name, model )
    player_manager.AddValidHands( "VANCE_Combine_Assassin", "models/weapons/c_arms_combine.mdl", 0, "00000000" )
	
end

AddPlayerModel( "VANCE_Combine_Assassin", "models/sirgibs/ragdolls/vance/combine_assassin_player.mdl" )

--add npc or i no DL!!!!!!1111 i frends with steam admin and gonna ban your account if you dont! aaaaaaaaaggggggggg!!!!!!!!!!!!
local Category = "SirGibs NPCs"

local NPC = {
	Name = "VANCE: Combine Assassin",
	Class = "npc_combine_s",
	Model = "models/sirgibs/ragdolls/vance/combine_assassin_npc.mdl",	
	Category = Category,
	Weapons = { "weapon_smg1", "weapon_ar2" },
	KeyValues = { SquadName = "assassin", Numgrenades = 5 }
}
list.Set( "NPC", "VANCE_Combine_Assassin", NPC )