-- "addons\\rised_animations\\lua\\autorun\\ra_animations.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

local Idle_CivilProtection_NoWeapon = {}

local Idle_CivilProtection_Pistol = {}
local Angry_CivilProtection_Pistol = {}

local Idle_CivilProtection_SMG = {}
local Angry_CivilProtection_SMG = {}

local Idle_Combine_NoWeapon = {}

local Idle_Combine_Pistol = {}
local Angry_Combine_Pistol = {}

local Idle_Combine_SMG = {}
local Angry_Combine_SMG = {}

local Idle_Combine_SG = {}
local Angry_Combine_SG = {}

local Idle_Combine_Grenade = {}

Synth_Cremator_Anim = {}

Synth_Guard_Anim = {}

Weapons_Pistol = {
	"swb_gsh18",
	"swb_357",
	"swb_pistol",
	"swb_pm",
	"swb_tt",
	"swb_deagle",
}

Weapons_SMG = {
	"swb_sks",
	"swb_smg",
	"swb_sv98",
	"swb_ak74",
	"swb_akm",
	"swb_rpk",
	"swb_asval",
	"swb_ismg",
	"swb_irifle",
	"swb_mosin",
	"swb_mp5k",
	"swb_oicw",
	"swb_snipercombine_assault",
	"swb_snipercombine_heavy",
	"swb_slk789",
	"weapon_csniper",
	"swb_m60",
	"swb_mp5a5",
	"swb_cheytac",
}

local Weapons_SG = {
	"swb_sawedoff",
	"swb_shotgun",
	"swb_toz",
	"swb_lmg",
	"swb_hammer",
	"omnishield",
}

local WeaponsSMG_Other = {
	"weapon_smg1",
	"weapon_shotgun",
	"weapon_ar2",
	"weapon_rpg",
	"weapon_crossbow",
	"swb_snipercombine_assault",
	"swb_snipercombine_heavy",
	"swb_slk789",
	"weapon_csniper",
	
	"swb_ar2",
	"swb_ar3",
	"swb_ak47",
	"swb_awp",
	"swb_famas",
	"swb_g3sg1",
	"swb_mp5",
	"swb_galil",
	"swb_m249",
	"swb_m3super90",
	"swb_m4a1",
	"swb_sg550",
	"swb_sg552",
	"swb_aug",
	"swb_scout",
	"swb_xm1014",
}

-- IDLE CP ANIMATIONS: 
	-- No Weapon --
	Idle_CivilProtection_NoWeapon[ ACT_MP_STAND_IDLE ] 						= ACT_IDLE
	Idle_CivilProtection_NoWeapon[ ACT_MP_WALK ] 						    = ACT_WALK
	Idle_CivilProtection_NoWeapon[ ACT_MP_RUN ] 						    = ACT_RUN
	Idle_CivilProtection_NoWeapon[ ACT_MP_CROUCH_IDLE ] 				   	= ACT_COVER_PISTOL_LOW -- ?
	Idle_CivilProtection_NoWeapon[ ACT_MP_CROUCHWALK ] 						= ACT_WALK_CROUCH
	Idle_CivilProtection_NoWeapon[ ACT_MP_JUMP ] 						    = ACT_JUMP
	Idle_CivilProtection_NoWeapon[ ACT_MP_SWIM_IDLE ] 						= ACT_JUMP -- ?
	Idle_CivilProtection_NoWeapon[ ACT_MP_SWIM ] 						    = ACT_JUMP -- ?

	-- Pistol --
	Idle_CivilProtection_Pistol[ ACT_MP_STAND_IDLE ] 						= ACT_IDLE
	Idle_CivilProtection_Pistol[ ACT_MP_WALK ] 						    	= ACT_WALK_PISTOL
	Idle_CivilProtection_Pistol[ ACT_MP_RUN ] 						    	= ACT_RUN_PISTOL
	Idle_CivilProtection_Pistol[ ACT_MP_CROUCH_IDLE ] 				   		= ACT_COVER_PISTOL_LOW
	Idle_CivilProtection_Pistol[ ACT_MP_CROUCHWALK ] 						= ACT_WALK_CROUCH
	Idle_CivilProtection_Pistol[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	    	= ACT_RANGE_ATTACK_PISTOL
	Idle_CivilProtection_Pistol[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ]	   		= ACT_RANGE_ATTACK_PISTOL_LOW --?
	Idle_CivilProtection_Pistol[ ACT_MP_RELOAD_STAND ]		 		    	= ACT_GESTURE_RELOAD_PISTOL
	Idle_CivilProtection_Pistol[ ACT_MP_RELOAD_CROUCH ]		 		    	= ACT_RELOAD
	Idle_CivilProtection_Pistol[ ACT_MP_JUMP ] 						    	= ACT_JUMP
	Idle_CivilProtection_Pistol[ ACT_MP_SWIM_IDLE ] 						= ACT_JUMP
	Idle_CivilProtection_Pistol[ ACT_MP_SWIM ] 						    	= ACT_JUMP
	Idle_CivilProtection_Pistol[ ACT_HL2MP_GESTURE_RELOAD_PISTOL ] 			= ACT_GESTURE_RELOAD_PISTOL

	Angry_CivilProtection_Pistol[ ACT_MP_STAND_IDLE ] 						= ACT_RANGE_ATTACK_PISTOL
	Angry_CivilProtection_Pistol[ ACT_MP_WALK ] 						    = ACT_WALK_AIM_PISTOL
	Angry_CivilProtection_Pistol[ ACT_MP_RUN ] 						    	= ACT_RUN_PISTOL
	Angry_CivilProtection_Pistol[ ACT_MP_CROUCH_IDLE ] 				   		= ACT_COVER_PISTOL_LOW
	Angry_CivilProtection_Pistol[ ACT_MP_CROUCHWALK ] 						= ACT_WALK_CROUCH
	Angry_CivilProtection_Pistol[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	    = ACT_RANGE_ATTACK_PISTOL
	Angry_CivilProtection_Pistol[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ]	    = ACT_COVER_PISTOL_LOW --?
	Angry_CivilProtection_Pistol[ ACT_MP_RELOAD_STAND ]		 		    	= ACT_GESTURE_RELOAD_PISTOL
	Angry_CivilProtection_Pistol[ ACT_MP_RELOAD_CROUCH ]		 		    = ACT_GESTURE_RELOAD_PISTOL
	Angry_CivilProtection_Pistol[ ACT_MP_JUMP ] 						    = ACT_JUMP
	Angry_CivilProtection_Pistol[ ACT_MP_SWIM_IDLE ] 						= ACT_JUMP
	Angry_CivilProtection_Pistol[ ACT_MP_SWIM ] 						    = ACT_JUMP
	Angry_CivilProtection_Pistol[ ACT_HL2MP_GESTURE_RELOAD_PISTOL ] 		= ACT_GESTURE_RELOAD_PISTOL
		
	-- SMG --
	Idle_CivilProtection_SMG[ ACT_MP_STAND_IDLE ] 							= ACT_IDLE_SMG1
	Idle_CivilProtection_SMG[ ACT_MP_WALK ] 						    	= ACT_WALK_RIFLE
	Idle_CivilProtection_SMG[ ACT_MP_RUN ] 						    		= ACT_RUN_RIFLE
	Idle_CivilProtection_SMG[ ACT_MP_CROUCH_IDLE ] 				   			= ACT_COVER_SMG1_LOW
	Idle_CivilProtection_SMG[ ACT_MP_CROUCHWALK ] 							= ACT_WALK_CROUCH
	Idle_CivilProtection_SMG[ ACT_MP_RELOAD_STAND ]		 		    		= ACT_GESTURE_RELOAD_SMG1
	Idle_CivilProtection_SMG[ ACT_MP_RELOAD_CROUCH ]		 		    	= ACT_GESTURE_RELOAD_SMG1
	Idle_CivilProtection_SMG[ ACT_MP_JUMP ] 						    	= ACT_JUMP
	Idle_CivilProtection_SMG[ ACT_MP_SWIM_IDLE ] 							= ACT_JUMP
	Idle_CivilProtection_SMG[ ACT_MP_SWIM ] 						    	= ACT_JUMP
	Idle_CivilProtection_SMG[ ACT_HL2MP_GESTURE_RELOAD_AR2 ] 				= ACT_GESTURE_RELOAD_SMG1
	
	Angry_CivilProtection_SMG[ ACT_MP_STAND_IDLE ] 							= ACT_IDLE_ANGRY_SMG1
	Angry_CivilProtection_SMG[ ACT_MP_WALK ] 						    	= ACT_WALK_AIM_RIFLE
	Angry_CivilProtection_SMG[ ACT_MP_RUN ] 						    	= ACT_RUN_AIM_RIFLE
	Angry_CivilProtection_SMG[ ACT_MP_CROUCH_IDLE ] 				   		= ACT_COVER_SMG1_LOW
	Angry_CivilProtection_SMG[ ACT_MP_CROUCHWALK ] 							= ACT_WALK_CROUCH
	Angry_CivilProtection_SMG[ ACT_MP_RELOAD_STAND ]		 		    	= ACT_GESTURE_RELOAD_SMG1
	Angry_CivilProtection_SMG[ ACT_MP_RELOAD_CROUCH ]		 		   	 	= ACT_GESTURE_RELOAD_SMG1
	Angry_CivilProtection_SMG[ ACT_MP_JUMP ] 						   	 	= ACT_JUMP
	Angry_CivilProtection_SMG[ ACT_MP_SWIM_IDLE ] 							= ACT_JUMP
	Angry_CivilProtection_SMG[ ACT_MP_SWIM ] 						   	 	= ACT_JUMP
	Angry_CivilProtection_SMG[ ACT_HL2MP_GESTURE_RELOAD_AR2 ] 				= ACT_GESTURE_RELOAD_SMG1

-- IDLE COMBINE ANIMATIONS:

	-- No Weapon --
	Idle_Combine_NoWeapon[ ACT_MP_STAND_IDLE ] 						= "idle_unarmed"
	Idle_Combine_NoWeapon[ ACT_MP_WALK ] 						    = "WalkUnarmed_All"
	Idle_Combine_NoWeapon[ ACT_MP_RUN ] 						    = "WalkUnarmed_All"
	Idle_Combine_NoWeapon[ ACT_MP_CROUCH_IDLE ] 				   	= "ShootSMG1c"
	Idle_Combine_NoWeapon[ ACT_MP_CROUCHWALK ] 						= "Crouch_WalkALL"
	Idle_Combine_NoWeapon[ ACT_MP_JUMP ] 						    = "Jump_Holding_Jump"
	Idle_Combine_NoWeapon[ ACT_MP_SWIM_IDLE ] 						= "Jump_Holding_Jump"
	Idle_Combine_NoWeapon[ ACT_MP_SWIM ] 						    = "Jump_Holding_Jump"

	-- Pistol --
	Idle_Combine_Pistol[ ACT_MP_STAND_IDLE ] 						= "idle_unarmed"
	Idle_Combine_Pistol[ ACT_MP_WALK ] 						    	= "WalkUnarmed_All"
	Idle_Combine_Pistol[ ACT_MP_RUN ] 						    	= "WalkUnarmed_All"
	Idle_Combine_Pistol[ ACT_MP_CROUCH_IDLE ] 				   		= "ShootSMG1c"
	Idle_Combine_Pistol[ ACT_MP_CROUCHWALK ] 						= "Crouch_WalkALL"
	Idle_Combine_Pistol[ ACT_MP_RELOAD_STAND ]		 		    	= ACT_GESTURE_RELOAD_SMG1
	Idle_Combine_Pistol[ ACT_MP_RELOAD_CROUCH ]		 		    	= ACT_GESTURE_RELOAD_SMG1
	Idle_Combine_Pistol[ ACT_MP_JUMP ] 						    	= "Jump_Holding_Jump"
	Idle_Combine_Pistol[ ACT_MP_SWIM_IDLE ] 						= "Jump_Holding_Jump"
	Idle_Combine_Pistol[ ACT_MP_SWIM ] 						    	= "Jump_Holding_Jump"

	Angry_Combine_Pistol[ ACT_MP_STAND_IDLE ] 						= "ShootSMG1s"
	Angry_Combine_Pistol[ ACT_MP_WALK ] 						    = "Walk_aiming_all"
	Angry_Combine_Pistol[ ACT_MP_RUN ] 						    	= "RunAIMALL1"
	Angry_Combine_Pistol[ ACT_MP_CROUCH_IDLE ] 				   		= "ShootSMG1c"
	Angry_Combine_Pistol[ ACT_MP_CROUCHWALK ] 						= "Crouch_WalkALL"
	Angry_Combine_Pistol[ ACT_MP_RELOAD_STAND ]		 		    	= ACT_GESTURE_RELOAD_SMG1
	Angry_Combine_Pistol[ ACT_MP_RELOAD_CROUCH ]		 		    = ACT_GESTURE_RELOAD_SMG1
	Angry_Combine_Pistol[ ACT_MP_JUMP ] 						    = "Jump_Holding_Jump"
	Angry_Combine_Pistol[ ACT_MP_SWIM_IDLE ] 						= "Jump_Holding_Jump"
	Angry_Combine_Pistol[ ACT_MP_SWIM ] 						    = "Jump_Holding_Jump"
		
	-- SMG --
	Idle_Combine_SMG[ ACT_MP_STAND_IDLE ] 							= "Idle1_SMG1"
	Idle_Combine_SMG[ ACT_MP_WALK ] 						    	= "WalkEasy_All"
	Idle_Combine_SMG[ ACT_MP_RUN ] 						    		= "runall"
	Idle_Combine_SMG[ ACT_MP_CROUCH_IDLE ] 				   			= "ShootSMG1c"
	Idle_Combine_SMG[ ACT_MP_CROUCHWALK ] 							= "Crouch_WalkALL"
	Idle_Combine_SMG[ ACT_MP_RELOAD_STAND ]		 		    		= ACT_GESTURE_RELOAD_SMG1
	Idle_Combine_SMG[ ACT_MP_RELOAD_CROUCH ]		 		   	 	= ACT_GESTURE_RELOAD_SMG1
	Idle_Combine_SMG[ ACT_MP_JUMP ] 						   	 	= "Jump_Holding_Jump"
	Idle_Combine_SMG[ ACT_MP_SWIM_IDLE ] 							= "Jump_Holding_Jump"
	Idle_Combine_SMG[ ACT_MP_SWIM ] 						   	 	= "Jump_Holding_Jump"
	
	Angry_Combine_SMG[ ACT_MP_STAND_IDLE ] 							= "ShootSMG1s"
	Angry_Combine_SMG[ ACT_MP_WALK ] 						    	= "Walk_aiming_all"
	Angry_Combine_SMG[ ACT_MP_RUN ] 						    	= "RunAIMALL1"
	Angry_Combine_SMG[ ACT_MP_CROUCH_IDLE ] 				   		= "ShootSMG1c"
	Angry_Combine_SMG[ ACT_MP_CROUCHWALK ] 							= "Crouch_WalkALL"
	Angry_Combine_SMG[ ACT_MP_RELOAD_STAND ]		 		    	= ACT_GESTURE_RELOAD_SMG1
	Angry_Combine_SMG[ ACT_MP_RELOAD_CROUCH ]		 		   	 	= ACT_GESTURE_RELOAD_SMG1
	Angry_Combine_SMG[ ACT_MP_JUMP ] 						   	 	= "Jump_Holding_Jump"
	Angry_Combine_SMG[ ACT_MP_SWIM_IDLE ] 							= "Jump_Holding_Jump"
	Angry_Combine_SMG[ ACT_MP_SWIM ] 						   	 	= "Jump_Holding_Jump"

	-- SHOTGUN --
	Idle_Combine_SG[ ACT_MP_STAND_IDLE ] 							= "Idle1_SMG1"
	Idle_Combine_SG[ ACT_MP_WALK ] 						    		= "Walk_ALL"
	Idle_Combine_SG[ ACT_MP_RUN ] 						    		= "Walk_ALL"
	Idle_Combine_SG[ ACT_MP_CROUCH_IDLE ] 				   			= "ShootSMG1c"
	Idle_Combine_SG[ ACT_MP_CROUCHWALK ] 							= "Crouch_WalkALL"
	Idle_Combine_SG[ ACT_MP_RELOAD_STAND ]		 		    		= ACT_GESTURE_RELOAD_SMG1
	Idle_Combine_SG[ ACT_MP_RELOAD_CROUCH ]		 		   	 		= ACT_GESTURE_RELOAD_SMG1
	Idle_Combine_SG[ ACT_MP_JUMP ] 						   	 		= "Jump_Holding_Jump"
	Idle_Combine_SG[ ACT_MP_SWIM_IDLE ] 							= "Jump_Holding_Jump"
	Idle_Combine_SG[ ACT_MP_SWIM ] 						   	 		= "Jump_Holding_Jump"
	
	Angry_Combine_SG[ ACT_MP_STAND_IDLE ] 							= "Combatidle1_SG"
	Angry_Combine_SG[ ACT_MP_WALK ] 						    	= "Walk_aiming_all_sg"
	Angry_Combine_SG[ ACT_MP_RUN ] 						    		= "RunAIMALL1_SG"
	Angry_Combine_SG[ ACT_MP_CROUCH_IDLE ] 				   			= "ShootSMG1c"
	Angry_Combine_SG[ ACT_MP_CROUCHWALK ] 							= "Crouch_WalkALL"
	Angry_Combine_SG[ ACT_MP_RELOAD_STAND ]		 		    		= ACT_GESTURE_RELOAD_SMG1
	Angry_Combine_SG[ ACT_MP_RELOAD_CROUCH ]		 		   	 	= ACT_GESTURE_RELOAD_SMG1
	Angry_Combine_SG[ ACT_MP_JUMP ] 						   	 	= "Jump_Holding_Jump"
	Angry_Combine_SG[ ACT_MP_SWIM_IDLE ] 							= "Jump_Holding_Jump"
	Angry_Combine_SG[ ACT_MP_SWIM ] 						   	 	= "Jump_Holding_Jump"

	Idle_Combine_Grenade[ ACT_MP_STAND_IDLE ] 						= "Idle1_SMG1"
	Idle_Combine_Grenade[ ACT_MP_WALK ] 						    = "Walk_ALL"
	Idle_Combine_Grenade[ ACT_MP_RUN ] 						    	= "Walk_ALL"
	Idle_Combine_Grenade[ ACT_MP_CROUCH_IDLE ] 				   		= "ShootSMG1c"
	Idle_Combine_Grenade[ ACT_MP_CROUCHWALK ] 						= "Crouch_WalkALL"
	Idle_Combine_Grenade[ ACT_MP_RELOAD_STAND ]		 		    	= ACT_GESTURE_RELOAD_SMG1
	Idle_Combine_Grenade[ ACT_MP_RELOAD_CROUCH ]		 		   	= ACT_GESTURE_RELOAD_SMG1
	Idle_Combine_Grenade[ ACT_MP_JUMP ] 						   	= "Jump_Holding_Jump"
	Idle_Combine_Grenade[ ACT_MP_SWIM_IDLE ] 						= "Jump_Holding_Jump"
	Idle_Combine_Grenade[ ACT_MP_SWIM ] 						   	= "Jump_Holding_Jump"
	Idle_Combine_Grenade[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 		= "grenthrow"
	Idle_Combine_Grenade[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ] 		= "ShootSGc"

	Synth_Cremator_Anim[ ACT_MP_STAND_IDLE ] 					= "idle01"
	Synth_Cremator_Anim[ ACT_MP_JUMP ] 							= "idle01"
	Synth_Cremator_Anim[ ACT_MP_CROUCH_IDLE ] 					= "idle01"
	Synth_Cremator_Anim[ ACT_MP_CROUCHWALK ] 					= {"walk", "walk_hurt"}
	Synth_Cremator_Anim[ ACT_MP_RUN ] 						    = {"walk", "walk_hurt"}
	Synth_Cremator_Anim[ ACT_MP_WALK ] 						    = {"walk", "walk_hurt"}

	Synth_Guard_Anim[ ACT_MP_STAND_IDLE ] 					= "Idle01"
	Synth_Guard_Anim[ ACT_MP_JUMP ] 						= "Idle01"
	Synth_Guard_Anim[ ACT_MP_RUN ] 						    = "Idle01"
	Synth_Guard_Anim[ ACT_MP_WALK ] 						= "Customwalk"
	Synth_Guard_Anim[ ACT_MP_WALK ] 						= "Customwalk"

	
net.Receive("RisedAnimation:Client", function(len, ply)
	local ply = net.ReadEntity()
	local anim = net.ReadString()
	ply:AddVCDSequenceToGestureSlot( GESTURE_SLOT_CUSTOM, anim, 0, true )
end)

hook.Add("TranslateActivity", "Rised_Animations", function(ply, act)
	--ply:SetModel("models/jq/hlvr/characters/combine/grunt/combine_grunt_hlvr_npc.mdl")
	--PrintTable(ply:GetSequenceList())
	-- CP -- 
	
	if GAMEMODE.MetropoliceJobs[ply:Team()] or ply:Team() == TEAM_REBELSPY01 or ply:Team() == TEAM_NPC then
		if IsValid(ply:GetActiveWeapon()) then
			if ply:GetActiveWeapon():GetClass() == "re_hands" then
				if ply:GetActiveWeapon():GetHoldType() == "normal" then
					if ( Idle_CivilProtection_NoWeapon[ act ] != nil ) then
						return Idle_CivilProtection_NoWeapon [ act ]
					end
				else
					if ( Idle_CivilProtection_Pistol[ act ] != nil ) then
						return Angry_CivilProtection_Pistol [ act ]
					end
				end
			elseif ply:GetActiveWeapon():GetClass() == "gmod_tool" then
				if ( Idle_CivilProtection_Pistol[ act ] != nil ) then
					return Angry_CivilProtection_Pistol [ act ]
				end
			elseif ply:GetActiveWeapon():GetClass() == "weapon_physgun" then
				if ( Idle_CivilProtection_Pistol[ act ] != nil ) then
					return Angry_CivilProtection_SMG [ act ]
				end
			elseif table.HasValue(Weapons_Pistol, ply:GetActiveWeapon():GetClass()) then
				if ( Idle_CivilProtection_Pistol[ act ] != nil ) then
					if ply:GetActiveWeapon().FireMode == "safe" then
						return Idle_CivilProtection_Pistol [ act ]
					else
						return Angry_CivilProtection_Pistol [ act ]
					end
				end
			elseif table.HasValue(Weapons_SMG, ply:GetActiveWeapon():GetClass()) or table.HasValue(Weapons_SG, ply:GetActiveWeapon():GetClass()) then
				if ( Idle_CivilProtection_SMG[ act ] != nil ) then
					if ply:GetActiveWeapon().FireMode == "safe" then
						return Idle_CivilProtection_SMG [ act ]
					else
						return Angry_CivilProtection_SMG [ act ]
					end
				end
			elseif ply:GetActiveWeapon():GetClass() != "weapon_cp_stick" then
				if ( Idle_CivilProtection_NoWeapon[ act ] != nil ) then
					return Idle_CivilProtection_NoWeapon [ act ]
				end
			end
		end
	elseif GAMEMODE.CombineJobs[ply:Team()] or ply:Team() == TEAM_SYNTH_ELITE or ply:Team() == TEAM_SYNTH_ELITE2 then
		if IsValid(ply:GetActiveWeapon()) then
			if ply:GetActiveWeapon():GetClass() == "re_hands" then
				if ply:GetActiveWeapon():GetHoldType() == "normal" then
					if ( Idle_Combine_NoWeapon[ act ] != nil ) then
						local seq = ply:LookupSequence(Idle_Combine_NoWeapon[ act ])
						if ply:GetSequenceInfo(seq) != nil then
							local new_act = ply:GetSequenceInfo(seq).activity
							ply:ResetSequence( seq )
							return new_act
						end
					end
				else
					if ( Idle_Combine_Pistol[ act ] != nil ) then
						local seq = ply:LookupSequence(Angry_Combine_Pistol[ act ])
						if ply:GetSequenceInfo(seq) != nil then
							local new_act = ply:GetSequenceInfo(seq).activity
							ply:ResetSequence( seq )
							return new_act
						end
					end
				end
			elseif ply:GetActiveWeapon():GetClass() == "weapon_frag" then
				if ( Idle_Combine_Grenade[ act ] != nil ) then
					local seq = ply:LookupSequence(Idle_Combine_Grenade[ act ])
					if ply:GetSequenceInfo(seq) != nil then
						local new_act = ply:GetSequenceInfo(seq).activity

						if ply:GetSequenceInfo(seq).activityname == "ACT_COMBINE_THROW_GRENADE" then
							ply:AddVCDSequenceToGestureSlot( GESTURE_SLOT_GRENADE, seq, 0, true )
						end
						return new_act
					end
				end
			elseif ply:GetActiveWeapon():GetClass() == "gmod_tool" then
				if ( Idle_Combine_Pistol[ act ] != nil ) then
					local seq = ply:LookupSequence(Angry_Combine_Pistol[ act ])
					if ply:GetSequenceInfo(seq) != nil then
						local new_act = ply:GetSequenceInfo(seq).activity
						return new_act
					end
				end
			elseif ply:GetActiveWeapon():GetClass() == "weapon_physgun" then
				if ( Idle_Combine_Pistol[ act ] != nil ) then
					local seq = ply:LookupSequence(Angry_Combine_SMG[ act ])
					if ply:GetSequenceInfo(seq) != nil then
						local new_act = ply:GetSequenceInfo(seq).activity
						return new_act
					end
				end
			elseif table.HasValue(Weapons_Pistol, ply:GetActiveWeapon():GetClass()) then
				if ( Idle_Combine_Pistol[ act ] != nil ) then
					if ply:GetActiveWeapon().FireMode == "safe" then
						local seq = ply:LookupSequence(Idle_Combine_Pistol[ act ])
						if ply:GetSequenceInfo(seq) != nil then
							local new_act = ply:GetSequenceInfo(seq).activity
							ply:ResetSequence( seq )
							return new_act
						end
					else
						if isnumber(Angry_Combine_Pistol[ act ]) then
							return Angry_Combine_Pistol[ act ]
						else
							local seq = ply:LookupSequence(Angry_Combine_Pistol[ act ])
							if ply:GetSequenceInfo(seq) != nil then
								local new_act = ply:GetSequenceInfo(seq).activity
								ply:ResetSequence( seq )
								return new_act
							end
						end
					end
				end
			elseif table.HasValue(Weapons_SMG, ply:GetActiveWeapon():GetClass()) then
				if ( Idle_Combine_SMG[ act ] != nil ) then
					if ply:GetActiveWeapon().FireMode == "safe" then
						local seq = ply:LookupSequence(Idle_Combine_SMG[ act ])
						if ply:GetSequenceInfo(seq) != nil then
							local new_act = ply:GetSequenceInfo(seq).activity
							ply:ResetSequence( seq )
							return new_act
						end
					else
						if isnumber(Angry_Combine_SMG[ act ]) then
							return Angry_Combine_SMG[ act ]
						else
							local seq = ply:LookupSequence(Angry_Combine_SMG[ act ])
							if ply:GetSequenceInfo(seq) != nil then
								local new_act = ply:GetSequenceInfo(seq).activity
								return new_act
							end
						end
					end
				end
			elseif table.HasValue(Weapons_SG, ply:GetActiveWeapon():GetClass()) then
				if ( Idle_Combine_SG[ act ] != nil ) then
					if ply:GetActiveWeapon().FireMode == "safe" then
						local seq = ply:LookupSequence(Idle_Combine_SG[ act ])
						if ply:GetSequenceInfo(seq) != nil then
							local new_act = ply:GetSequenceInfo(seq).activity
							return new_act
						end
					else
						if isnumber(Angry_Combine_SG[ act ]) then
							return Angry_Combine_SG[ act ]
						else
							local seq = ply:LookupSequence(Angry_Combine_SG[ act ])
							if ply:GetSequenceInfo(seq) != nil then
								local new_act = ply:GetSequenceInfo(seq).activity
								return new_act
							end
						end
					end
				end
			elseif ply:GetActiveWeapon():GetClass() != "weapon_cp_stick" then
				if ( Idle_Combine_NoWeapon[ act ] != nil ) then
					local seq = ply:LookupSequence(Idle_Combine_NoWeapon[ act ])
					if ply:GetSequenceInfo(seq) != nil then
						local new_act = ply:GetSequenceInfo(seq).activity
						ply:ResetSequence( seq )
						return new_act
					end
				end
			end
		end
	
	-- Cremator -- 
	elseif ply:Team() == TEAM_SYNTH_CREMATOR then
		
		if act == ACT_MP_WALK or act == ACT_MP_RUN or act == ACT_MP_CROUCHWALK then
			if ( Synth_Cremator_Anim[ act ] != nil ) then
				local seq = ""
				if ply:Health() <= 50 then
					seq = ply:LookupSequence(Synth_Cremator_Anim[ act ][ 2 ])
				else
					seq = ply:LookupSequence(Synth_Cremator_Anim[ act ][ 1 ])
				end

				if ply:GetSequenceInfo(seq) != nil then
					local new_act = ply:GetSequenceInfo(seq).activity
					ply:ResetSequence( seq )
					return new_act
				end
			end
		else
			if ( Synth_Cremator_Anim[ act ] != nil ) then
				local seq = ply:LookupSequence(Synth_Cremator_Anim[ act ])
				if ply:GetSequenceInfo(seq) != nil then
					local new_act = ply:GetSequenceInfo(seq).activity
					ply:ResetSequence( seq )
					return new_act
				end
			end
		end

	-- Guard -- 
	elseif ply:Team() == TEAM_SYNTH_GUARD then
		if ( Synth_Guard_Anim[ act ] != nil ) then
			local seq = ply:LookupSequence(Synth_Guard_Anim[ act ])
			if ply:GetSequenceInfo(seq) != nil then
				local new_act = ply:GetSequenceInfo(seq).activity
				ply:ResetSequence( seq )
				return new_act
			end
		end
	end
end)

hook.Add( "UpdateAnimation", "UpdateCPAnimations", function( ply, velocity, maxseqgroundspeed )
	if GAMEMODE.MetropoliceJobs[ply:Team()] or ply:Team() == TEAM_REBELSPY01 or GAMEMODE.CombineJobs[ply:Team()] or ply:Team() == TEAM_SYNTH_CREMATOR then
		ply:SetPoseParameter("head_roll", 0)
		if ply:KeyDown( IN_MOVERIGHT ) and !ply:KeyDown( IN_FORWARD ) and !ply:KeyDown( IN_BACK ) then
			ply:SetNWInt("MoveDirection", -90)
		elseif ply:KeyDown( IN_MOVERIGHT ) and ply:KeyDown( IN_FORWARD ) and !ply:KeyDown( IN_BACK ) then
			ply:SetNWInt("MoveDirection", -45)
		elseif ply:KeyDown( IN_MOVERIGHT ) and !ply:KeyDown( IN_FORWARD ) and ply:KeyDown( IN_BACK ) then
			ply:SetNWInt("MoveDirection", -135)
		elseif ply:KeyDown( IN_MOVELEFT ) and !ply:KeyDown( IN_FORWARD ) and !ply:KeyDown( IN_BACK ) then
			ply:SetNWInt("MoveDirection", 90)
		elseif ply:KeyDown( IN_MOVELEFT ) and ply:KeyDown( IN_FORWARD ) and !ply:KeyDown( IN_BACK ) then
			ply:SetNWInt("MoveDirection", 45)
		elseif ply:KeyDown( IN_MOVELEFT ) and !ply:KeyDown( IN_FORWARD ) and ply:KeyDown( IN_BACK ) then
			ply:SetNWInt("MoveDirection", 135)
		elseif ply:KeyDown( IN_BACK ) then
			ply:SetNWInt("MoveDirection", 180)
		elseif ply:KeyDown( IN_FORWARD ) then
			ply:SetNWInt("MoveDirection", 0)
		end
		
		ply:SetPoseParameter("move_yaw", ply:GetNWInt("MoveDirection"))
	end
end)

hook.Add("StartCommand", "NoZombieLadder", function(ply, cmd) 
	if ply:Team() == TEAM_SYNTH_CREMATOR or ply:Team() == TEAM_SYNTH_GUARD then
		if cmd:KeyDown(IN_MOVELEFT) or cmd:KeyDown(IN_MOVERIGHT) or cmd:KeyDown(IN_JUMP) or cmd:KeyDown(IN_SPEED) or cmd:KeyDown(IN_WALK) then
			cmd:ClearMovement()
		end
	end
end)

local CMoveData = FindMetaTable("CMoveData")
function CMoveData:RemoveKeys(keys)
	local newbuttons = bit.band(self:GetButtons(), bit.bnot(keys))
	self:SetButtons(newbuttons)
end
hook.Add("SetupMove", "Cremator Disable Jumping", function(ply, mvd, cmd)
	if mvd:KeyDown(IN_JUMP) and (ply:Team() == TEAM_SYNTH_CREMATOR or ply:Team() == TEAM_SYNTH_GUARD) then
		mvd:RemoveKeys(IN_JUMP)
	end
end)

hook.Add( "PlayerSetHandsModel", "Rised_HandsViewModel", function( ply, ent )
	if IsValid(ply) then
		if GAMEMODE.MetropoliceJobs[ply:Team()] or ply:Team() == TEAM_REBELSPY01 then
			timer.Simple(0.2, function()
				local simplemodel = player_manager.TranslateToPlayerModelName( "models/player/police.mdl" )
				local info = player_manager.TranslatePlayerHands( simplemodel )
				if ( info ) then
					if IsValid(ent) then
						ent:SetModel( "models/dpfilms/weapons/v_arms_metropolice.mdl" )
						ent:SetSkin( info.skin )
						ent:SetBodyGroups( info.body )
					end
				end
			end)
		elseif GAMEMODE.CombineJobs[ply:Team()] then
			timer.Simple(0.2, function()
				local simplemodel = player_manager.TranslateToPlayerModelName( "models/player/police.mdl" )
				local info = player_manager.TranslatePlayerHands( simplemodel )
				if ( info ) then
					if IsValid(ent) then
						ent:SetModel( info.model )
						ent:SetSkin( info.skin )
						ent:SetBodyGroups( info.body )
					end
				end
			end)
		end
	end
end)

hook.Add( "PlayerEnteredVehicle", "Rised_EnteredVehicle", function( ply, veh, role )
	if GAMEMODE.CombineJobs[ply:Team()] then
		if ply:GetModel() == "models/jq/hlvr/characters/combine/grunt/combine_grunt_hlvr_npc.mdl" then
			ply:SetModel("models/jq/hlvr/characters/combine/grunt/combine_grunt_hlvr_player.mdl")
		elseif ply:GetModel() == "models/jq/hlvr/characters/combine/suppressor/combine_suppressor_hlvr_npc.mdl" then
			ply:SetModel("models/jq/hlvr/characters/combine/suppressor/combine_suppressor_hlvr_player.mdl")
		elseif ply:GetModel() == "models/jq/hlvr/characters/combine/heavy/combine_heavy_hlvr_npc.mdl" then
			ply:SetModel("models/jq/hlvr/characters/combine/heavy/combine_heavy_hlvr_player.mdl")
		elseif ply:GetModel() == "models/jq/hlvr/characters/combine/combine_captain/combine_captain_hlvr_npc.mdl" then
			ply:SetModel("models/jq/hlvr/characters/combine/combine_captain/combine_captain_hlvr_player.mdl")
		else
			ply:SetModel("models/player/combine_soldier.mdl")
		end
	end
end)

hook.Add( "PlayerLeaveVehicle", "Rised_LeaveVehicle", function( ply, veh )
	if GAMEMODE.CombineJobs[ply:Team()] then
		if ply:GetModel() == "models/jq/hlvr/characters/combine/grunt/combine_grunt_hlvr_player.mdl" then
			ply:SetModel("models/jq/hlvr/characters/combine/grunt/combine_grunt_hlvr_npc.mdl")
		elseif ply:GetModel() == "models/jq/hlvr/characters/combine/suppressor/combine_suppressor_hlvr_player.mdl" then
			ply:SetModel("models/jq/hlvr/characters/combine/suppressor/combine_suppressor_hlvr_npc.mdl")
		elseif ply:GetModel() == "models/jq/hlvr/characters/combine/heavy/combine_heavy_hlvr_player.mdl" then
			ply:SetModel("models/jq/hlvr/characters/combine/heavy/combine_heavy_hlvr_npc.mdl")
		elseif ply:GetModel() == "models/jq/hlvr/characters/combine/combine_captain/combine_captain_hlvr_player.mdl" then
			ply:SetModel("models/jq/hlvr/characters/combine/combine_captain/combine_captain_hlvr_npc.mdl")
		else
			ply:SetModel(table.Random(RPExtraTeams[ply:Team()].model))
		end
	end
end)

local models = { "models/hl2rp/female_01.mdl",
	"models/hl2rp/female_02.mdl",
	"models/hl2rp/female_03.mdl",
	"models/hl2rp/female_04.mdl",
	"models/hl2rp/female_06.mdl",
	"models/hl2rp/female_07.mdl",
	"models/humans/combine/female_01.mdl",
	"models/humans/combine/female_02.mdl",
	"models/humans/combine/female_03.mdl",
	"models/humans/combine/female_04.mdl",
	"models/humans/combine/female_06.mdl",
	"models/humans/combine/female_07.mdl",
	"models/humans/combine/female_08.mdl",
	"models/humans/combine/female_08.mdl",
	"models/humans/combine/female_09.mdl",
	"models/humans/combine/female_10.mdl",
	"models/humans/combine/female_11.mdl",
	"models/humans/combine/female_ga.mdl",
}

local models1 = { "models/hl2rp/male_01.mdl",
	"models/hl2rp/male_02.mdl",
	"models/hl2rp/male_03.mdl",
	"models/hl2rp/male_04.mdl",
	"models/hl2rp/male_05.mdl",
	"models/hl2rp/male_06.mdl",
	"models/hl2rp/male_07.mdl",
	"models/hl2rp/male_08.mdl",
	"models/hl2rp/male_09.mdl",
}

net.Receive("anim_ris_client", function()
	local id = net.ReadInt(32)
	local ply = net.ReadEntity()
	local bool = net.ReadBool()

	if id == -100 then
		ply:AnimResetGestureSlot( GESTURE_SLOT_VCD )
	else
		ply:AddVCDSequenceToGestureSlot( GESTURE_SLOT_VCD, id, 0, bool )
	end
end)

if CLIENT then
	hook.Add("Move", "Noclip", function( ply, mv )
		if (mv:KeyPressed(IN_FORWARD) or mv:KeyPressed(IN_ATTACK) or mv:KeyPressed(IN_JUMP) or mv:KeyPressed(IN_BACK) or mv:KeyPressed(IN_MOVERIGHT) or mv:KeyPressed(IN_MOVELEFT)) and ply:GetNWBool("anim", true) then
			ply:SetNWBool("anim", false)
			net.Start( "anim_ris_server" )
			net.WriteInt(-100, 32)
			net.WriteBool(false)
			net.SendToServer()
		end
	end)
end