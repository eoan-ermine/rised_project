-- "addons\\rised_tech\\lua\\autorun\\combine_barricade_hook.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal



hook.Add( "PlayerUse", "sf_friendlynpc_remove", function( ply, ent )
	if ( !IsValid( ent ) ) then return end
	if ent:GetClass() == "npc_turret_floor" and ent:GetNWString("Entity_Fraction") == "Combine" then
		time = ( CurTime() + 1 )
		if GAMEMODE.MetropolicePlunger[ply:Team()] or ply:Team() == TEAM_OTA_Tech or ply:Team() == TEAM_WORKER_UNIT then 
			if ent.weapon_ttt_turret == true then
				ent.weapon_ttt_turret = false
				ent:EmitSound("npc/turret_floor/die.wav")
				ent:Remove()
				ply:Give("combine_turret_placer")		
				ply:SelectWeapon("combine_turret_placer")		
			end
			ply:EmitSound("items/ammo_pickup.wav")
		end
	elseif ent:GetClass() == "npc_turret_floor" and ent:GetNWString("Entity_Fraction") == "Rebel" then
		time = ( CurTime() + 1 )
		if ply:Team() == TEAM_REBELENGINEER then 
			if ent.weapon_ttt_turret == true then
				ent.weapon_ttt_turret = false
				ent:EmitSound("npc/turret_floor/die.wav")
				ent:Remove()
				ply:Give("rebel_turret_placer")
				ply:SelectWeapon("rebel_turret_placer")
			end
			ply:EmitSound("items/ammo_pickup.wav")
		end
	end
end )