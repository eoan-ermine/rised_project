-- "lua\\weapons\\tfa_ins2_remington_m24_sws.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base					= ( TFA and DVL ) and "tfa_devl_base" or "tfa_gun_base"                  -- Weapon Base
SWEP.Category               = ( TFA and TFA.Yankys_Custom_Weapon_Pack_Categories ) and "[TFA] [AT] [ Sniper Rifles ]" or "TFA Insurgency"   
SWEP.PrintName				= "Remington M24A1 SWS"	          -- Weapon name (Shown on HUD)
SWEP.Manufacturer           = "Remington Arms"                -- Gun Manufactrer (e.g. Hoeckler and Koch )          
SWEP.Type                   = ( TFA and TFA.Yankys_Custom_Weapon_Pack ) and "Type: Bolt-Action Sniper Rifle - Caliber: 7.62x51mm - Muzzle Velocity: 853 m/s" or "Bolt-Action Sniper Rifle"
SWEP.Purpose				= "A 7.62x51MM Bolt Action Sniper Rifle."   
SWEP.Instructions		    = ""    

SWEP.Author				    = "XxYanKy700xX & Shadowrun"    
SWEP.Contact				= "https://steamcommunity.com/profiles/76561198296543672/" 
 
SWEP.Spawnable				= true 
SWEP.AdminSpawnable			= true                            -- Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= true		                      -- Draw the crosshair?
SWEP.DrawCrosshairIS		= false                           -- Draw the crosshair in ironsights?

SWEP.Slot				    = 3				                  -- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73			                  -- Position in the slot
SWEP.AutoSwitchTo			= true		                      -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		                      -- Auto switch from if you pick up a better weapon
SWEP.Weight				    = 30			                  -- This controls how "good" the weapon is for autopickup.

--[[WEAPON HANDLING]]--

SWEP.Primary.Sound          = Sound("TFA_INS2.M24SWS.Fire")            -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound  = Sound("TFA_INS2.M24SWS.Fire_Suppressed") -- This is the sound of the weapon, when silenced.

SWEP.Primary.SoundEchoTable = {
	[0]   = Sound("TFA_MWR_SNI.TailInside"), 
	[256] = Sound("TFA_MWR_R700.TailOutside") 
}

SWEP.Primary.Damage                = ( TFA and TFA.Yankys_Custom_Weapon_Pack ) and 135 * TFA.Yankys_Custom_Weapon_Pack.DamageMultiplier or 140
SWEP.Primary.DamageTypeHandled     = true                     -- true will handle damagetype in base
SWEP.Primary.DamageType            = nil                      -- See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.PenetrationMultiplier = 0.9                      -- Change the amount of something this gun can penetrate through
SWEP.Primary.Velocity              = 853                      -- Bullet Velocity in m/s
SWEP.Primary.NumShots              = 1                        -- The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.

SWEP.Primary.Automatic             = false                    -- Automatic/Semi Auto
SWEP.Primary.RPM                   = 300                      -- This is in Rounds Per Minute / RPM

SWEP.Primary.Force                 = nil                      -- Force value, leave nil to autocalc
SWEP.Primary.Knockback             = nil                      -- Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize              = 0                        -- Big bullets, increase this value.  They increase the hull size of the hitscan bullet.

SWEP.FiresUnderwater               = false

--[[SHOTGUN CODE]]--
 
SWEP.Shotgun                     = true                       -- Enable shotgun style reloading.
SWEP.ShotgunEmptyAnim            = true                       -- Enable emtpy reloads on shotguns?
SWEP.ShotgunEmptyAnim_Shell      = false                      -- Enable insertion of a shell directly into the chamber on empty reload?
SWEP.ShellTime                   = 1                          -- For shotguns, how long it takes to insert a shell.

-- Miscelaneous Sounds
SWEP.IronInSound                 = nil                        -- Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound                = nil                        -- Sound to play when ironsighting out?  nil for default

-- Selective Fire Stuff
SWEP.SelectiveFire               = false                      -- Allow selecting your firemode?
SWEP.DisableBurstFire            = false                      -- Only auto/single?
SWEP.OnlyBurstFire               = false                      -- No auto, only burst/single?
SWEP.DefaultFireMode             = ""                         -- Default to auto or whatev
SWEP.FireModeName                = "BOLT-ACTION"              -- Change to a text value to override it

-- Ammo Related
SWEP.Primary.ClipSize            = 5                          -- This is the size of a clip
SWEP.Primary.DefaultClip         = SWEP.Primary.ClipSize * 13 -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo                = "SniperPenetratedRound"    -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption     = 1                          -- Ammo consumed per shot

-- Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.DisableChambering           = true                       -- Disable round-in-the-chamber
SWEP.CanJam                      = true

-- Recoil Related 
SWEP.Primary.KickUp              = 0.66                       -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown            = 0.53                       -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal      = 0.15                       -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor  = 0.55                       -- Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

-- Firing Cone Related
SWEP.Primary.Spread              = .0135                      -- This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy        = .0002                      -- Ironsight accuracy, should be the same for shotguns

-- Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 6.75                       -- How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement     = 6.75                       -- What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery      = 3.3                        -- How much the spread recovers, per second. Example val: 3

-- Range Related
SWEP.Primary.Range               = 0.8 * (3280.84 * 16)       -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff        = 0.95                       -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

SWEP.Primary.RangeFalloffLUT = {
	bezier     = true,
	
	range_func = "quintic",
	units      = "meters",
	
	lut = {
		{range = 0, damage = 1},
		{range = 500, damage = 1},
		{range = 800, damage = 1},
		{range = 800, damage = 1},
		{range = 800, damage = 1},
		{range = 800, damage = 1},
		{range = 800, damage = 1},
		{range = 1200, damage = 0.85},
		{range = 1500, damage = 0.69},
	}
}

-- Penetration Related
SWEP.MaxPenetrationCounter       = 2                          -- The maximum number of ricochets.  To prevent stack overflows.

-- Misc  
SWEP.IronRecoilMultiplier        = 0.75                       -- Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier    = 0.82                       -- Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate

-- Movespeed
SWEP.MoveSpeed                   = 0.92                       -- Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed         = 0.87                       -- Multiply the player's movespeed by this when sighting.

--[[EFFECTS]]--

-- Attachments
SWEP.ShellAttachment			 = "shell" 		              -- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleAttachment			 = "muzzle" 	              -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.MuzzleFlashEnabled          = true                       -- Enable muzzle flash
SWEP.MuzzleFlashEffect           = ( TFA and TFA.YanKys_Realistic_Muzzleflashes ) and "tfa_muzzleflash_m24" or "tfa_muzzleflash_shotgun"
SWEP.MuzzleAttachmentRaw         = nil                        -- This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment  = false                      -- For multi-barrel weapons, detect the proper attachment?
SWEP.SmokeParticle               = nil                        -- Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled        = false

-- Shell eject override
SWEP.LuaShellEject               = false                      -- Enable shell ejection through lua?
SWEP.LuaShellEjectDelay          = 0                          -- The delay to actually eject things
SWEP.LuaShellEffect              = "RifleShellEject"          -- The effect used for shell ejection; Defaults to that used for blowback

-- Tracer Stuff
SWEP.TracerName 		         = nil 	                      -- Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		         = 1 	                      -- 0 disables, otherwise, 1 in X chance

--[[VIEWMODEL]]--

SWEP.ViewModel			  = "models/weapons/smc/m24/c_m24.mdl" 
SWEP.ViewModelFOV	      = 65		                          -- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip	      = false		                      -- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands             = true                              -- Use gmod c_arms system.
SWEP.VMPos                = ( TFA and TFA.Yankys_Custom_Weapon_Pack ) and Vector(-1, 1, 0.25) or Vector(-0.5, 1, 0.25)
SWEP.VMAng                = Vector(0.1, 0, 0)                 -- The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive       = false                             -- Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.CenteredPos          = nil                               -- The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng          = nil                               -- The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.Bodygroups_V         = nil 

--[[VIEWMODEL ANIMATION HANDLING]]--

SWEP.AllowViewAttachment  = true                              -- Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.

--[[ANIMATION]]--

SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD]       = 0.35,
} -- Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others

SWEP.SequenceRateOverride = {
	["base_reload_start"] = 0.9,
}

SWEP.SequenceLengthOverride = {                               -- Changes both the status delay and the nextprimaryfire of a given animation
	[ACT_VM_PULLBACK_LOW]   = 48 / 30,
	[ACT_VM_PULLBACK_HIGH]  = 48 / 30,
}   

SWEP.SequenceRateOverrideScaled = {}                          -- Like above but scales animation length rather than being absolute

SWEP.ProceduralHoslterEnabled   = nil
SWEP.ProceduralHolsterTime      = 0.3
SWEP.ProceduralHolsterPos       = Vector(3, 0, -5)
SWEP.ProceduralHolsterAng       = Vector(-40, -30, 10)

SWEP.Sights_Mode                = TFA.Enum.LOCOMOTION_HYBRID  -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation

SWEP.Sprint_Mode                = TFA.Enum.LOCOMOTION_ANI     -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.SprintBobMult              = 0.35
SWEP.SprintFOVOffset            = 5

SWEP.Idle_Mode                  = TFA.Enum.IDLE_BOTH          -- TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend                 = 0.25                        -- Start an idle this far early into the end of a transition
SWEP.Idle_Smooth                = 0.05                        -- Start an idle this far early into the end of another animation

-- MDL Animations Below
SWEP.IronAnimation = {
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,                    -- Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK_1,                   -- Number for act, String/Number for sequence
		["value_last"] = ACT_VM_PRIMARYATTACK_2,
		["value_empty"] = ACT_VM_PRIMARYATTACK_3
	}
}

SWEP.SprintAnimation = {
	["in"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,                    -- Sequence or act
		["value"] = ACT_VM_IDLE_TO_LOWERED                    -- Number for act, String/Number for sequence
	},
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,                    -- Sequence or act
		["value"] = ACT_VM_IDLE_LOWERED,                      -- Number for act, String/Number for sequence
		["is_idle"] = true
	},
	["out"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,                    -- Sequence or act
		["value"] = ACT_VM_LOWERED_TO_IDLE                    -- Number for act, String/Number for sequence
	}
}

SWEP.PumpAction = {
	["type"] = TFA.Enum.ANIMATION_ACT,                        -- Sequence or act
	["value"] = ACT_VM_PULLBACK_LOW,                          -- Number for act, String/Number for sequence
	["value_is"] = ACT_VM_PULLBACK_HIGH
}

--[[EVENT TABLE]]--

SWEP.EventTable = {
	[ACT_VM_PULLBACK_LOW] = {
		{ ["time"] = 19.1 / 30, ["type"] = "lua", ["value"] = function(wep,vm)
			if wep and wep.EventShell then
				wep:EventShell()
			end
		end, ["client"] = true, ["server"] = true }
	},
	[ACT_VM_PULLBACK_HIGH] = {
		{ ["time"] = 18.82 / 28.5, ["type"] = "lua", ["value"] = function(wep,vm)
			if wep and wep.EventShell then
				wep:EventShell()
			end
		end, ["client"] = true, ["server"] = true }
	},
}

--[[WORLDMODEL]]--

SWEP.WorldModel	   = "models/weapons/smc/m24/w_m24.mdl" -- Weapon world model path

SWEP.Bodygroups_W  = nil 
SWEP.HoldType      = "ar2" 

-- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.Offset = {
	Pos = {
		Up = -1,
		Right = 0.7,
		Forward = 5
	},
	Ang = {
		Up = 0,
		Right = -12.05,
		Forward = 180
	},
	Scale = 1
}

SWEP.ThirdPersonReloadDisable = false   -- Disable third person reload?  True disables.
 
--[[IRONSIGHTS]]--

SWEP.data              = {}
SWEP.data.ironsights   = 1         -- Enable Ironsights
SWEP.Secondary.IronFOV = 80        -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.

SWEP.IronSightsPos     = Vector(-3.1755, -1, 0.85)
SWEP.IronSightsAng     = Vector(0, 0.01, 0)

SWEP.IronSightsReloadEnabled = true
SWEP.IronSightsReloadLock    = false

SWEP.IronSightsPos_Point_Shooting = Vector(2, -2, 0)
SWEP.IronSightsAng_Point_Shooting = Vector(0, 0, 30)
SWEP.Secondary.Point_Shooting_FOV = 70 

SWEP.IronSightsPos_Kobra      = Vector(-3.1755, 0, 0.8)
SWEP.IronSightsAng_Kobra      = Vector(0.05, 0, 0)

SWEP.IronSightsPos_EOTech     =  Vector(-3.18, 0, 0.7)
SWEP.IronSightsAng_EOTech     = Vector(-0.34, 0, 0)

SWEP.IronSightsPos_RDS        = Vector(-3.1755, 0, 0.6)
SWEP.IronSightsAng_RDS        = Vector(-0.24, 0, 0)

SWEP.IronSightsPos_2XRDS      = Vector(-3.1755, -2, 0.527)
SWEP.IronSightsAng_2XRDS      = Vector(0, -0.015, 0)
SWEP.Secondary.IronFOV_2XRDS  = 75
SWEP.RTScopeFOV_2XRDS         = 40

SWEP.IronSightsPos_C79        = Vector(-3.18, -2, 0.48)
SWEP.IronSightsAng_C79        = Vector(0, -0.015, 0)
SWEP.RTScopeFOV_C79           = 45

SWEP.IronSightsPos_Mosin      = Vector(-3.16, -2, 1.3)
SWEP.IronSightsAng_Mosin      = Vector(0, -0.0265, 0)
SWEP.IronSightsAng_Mosin      = Vector(0, -0.0265, 0)
SWEP.RTScopeFOV_Mosin         = 50

SWEP.IronSightsPos_PO4X       = Vector(-3.12, -2, 0.93)
SWEP.IronSightsAng_PO4X       = Vector(0, -0.025, 0)
SWEP.RTScopeFOV_PO4X          = 45

SWEP.IronSightsPos_MX4        = Vector(-3.185, -2, 0.705)
SWEP.IronSightsAng_MX4        = Vector(0, -0.008, 0)

--[[SPRINTING]]--

SWEP.RunSightsPos = Vector(2.4, -1.6, -0.8)
SWEP.RunSightsAng = Vector(-15, 30, -15)

--[[ CROUCHING ]] --

SWEP.CrouchPos    = Vector(-0.65, -0.85, -0.5) + SWEP.VMPos
SWEP.CrouchAng    = Vector(0, 0, -5) + SWEP.VMAng

--[[INSPECTION]]--

SWEP.InspectPos   = Vector(7.8, -6, -2.241) 
SWEP.InspectAng   = Vector(25, 45, 15.477)

--[[ATTACHMENTS]]--

SWEP.Attachments = {
	[1] = { atts = { "ins2_si_kobra", "ins2_si_eotech", "ins2_si_rds", "ins2_si_2xrds", "ins2_si_c79", "ins2_si_po4x", "ins2_si_mosin", "ins2_si_mx4" } },
	[2] = { atts = { "ins2_br_heavy", "r6s_h_barrel", "r6s_muzzle_2", "r6s_flashhider_2", "bo2_longbarrel", "ins2_br_supp", "ins2_eft_osprey" } },
	[3] = { atts = { "ins2_ub_laser", "ins2_laser_anpeq15_black", "ins2_laser_anpeq15_tan", "ins2_ub_flashlight"} },
	[4] = { atts = { "tfa_tactical_point_shooting" } },
	[5] = { atts = { "tfa_yanks_wpn_pack_heavy_stock", "tfa_yanks_wpn_pack_light_stock", "bo2_stock" } },
	[6] = { atts = { "tfa_yanks_wpn_pack_sleight_of_hand", "tfa_yanks_wpn_pack_quick_draw", "bo2_rapidfire", "bo2_quickdraw" } },
	[7] = { atts = { "am_match", "am_magnum", "am_gib", "tfa_mb_penrnd" } },
}

SWEP.AttachmentDependencies = {	
    ["tfa_tactical_point_shooting"] = {"ins2_ub_laser", "ins2_laser_anpeq15_black", "ins2_laser_anpeq15_tan", "ins2_ub_flashlight", "ins2_eft_lastac2"},
}

SWEP.AttachmentExclusions   = {}

SWEP.ViewModelBoneMods = {
	["b_wpn_muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -90) },
	["A_Optic"] = { scale = Vector(0.8, 0.8, 0.8), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["A_Suppressor"] = { scale = Vector(0.55, 0.7, 0.55), pos = Vector(0, 0.15, 0), angle = Angle(0, 0, 0) },
	["A_LaserFlashlight"] = { scale = Vector(1, 1, 1), pos = Vector(0, 1, 0), angle = Angle(0, 0, 180) },

--	["b_wpn_mag_b1"] = { scale = Vector(1, 1, 1), pos = Vector(0.2, -0.2, 0), angle = Angle(0, 0, 0) },
	["b_ch_r_upperarm"] = { scale = Vector(0.95, 0.95, 0.95), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["b_ch_l_upperarm"] = { scale = Vector(0.95, 0.95, 0.95), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["b_ch_r_hand"] = { scale = Vector(1, 1, 1), pos = Vector(-0.17, 0, 0), angle = Angle(0, 0, 0) },
	["b_ch_r_finger_40"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 10, 0) },
	["b_ch_r_finger_41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 10, 0) },
	["b_ch_r_finger_42"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 10, 0) },
}

SWEP.WorldModelBoneMods = {
	["ATTACH_Laser"] = { scale = Vector(1.1, 1.1, 1.1), pos = Vector(0.2, 0, 0), angle = Angle(0, 0, 90) },
}

SWEP.VElements = {
	["sights_folded"] = { type = "Model", model = "models/weapons/smc/m24/upgrades/a_standard_m24.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(90, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = true},
	["sight_kobra"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra_l.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["sight_kobra_lens"] = (TFA.INS2 and TFA.INS2.GetHoloSightReticle) and TFA.INS2.GetHoloSightReticle("sight_kobra") or nil,
	["sight_eotech"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech_l.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["sight_eotech_lens"] = (TFA.INS2 and TFA.INS2.GetHoloSightReticle) and TFA.INS2.GetHoloSightReticle("sight_eotech") or nil,
	["sight_rds"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint_l.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["sight_rds_lens"] = (TFA.INS2 and TFA.INS2.GetHoloSightReticle) and TFA.INS2.GetHoloSightReticle("sight_rds") or nil,
	["scope_2xrds"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_aimp2x_l.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["scope_c79"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_elcan.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["scope_po4x"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_po4x24.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["scope_mosin"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_mosin.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["scope_mx4"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_m40_l.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },

	["suppressor"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_suppressor_sec.mdl", bone = "b_wpn", rel = "", pos = Vector(0, 19, 1.22), angle = Angle(180, 90, 0), size = Vector(0.65, 0.55, 0.55), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} , bonemerge = false, active = false },
	["suppressor_osprey"] = { type = "Model", model = "models/weapons/tfa_eft/upgrades/v_osprey.mdl", bone = "b_wpn", rel = "", pos = Vector(0, 19, 1.22), angle = Angle(0, 180, 0), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} , bonemerge = false, active = false },

	["laser"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_laser_band.mdl", bone = "A_UnderBarrel", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1 ,1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "A_Beam", rel = "laser", pos = Vector(0, 0, 0), angle = Angle(0, 0.1, 0), size = Vector(1.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
	["laser_anpeq15_black"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_laser_anpeq15_band.mdl", bone = "A_LaserFlashlight", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1 ,1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["laser_beam_anpeq15_black"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "A_Beam", rel = "laser_anpeq15_black", pos = Vector(0, 0, 0.1), angle = Angle(0, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
	["laser_anpeq15_tan"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_laser_anpeq15_band_tan.mdl", bone = "A_LaserFlashlight", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1 ,1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["laser_beam_anpeq15_tan"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "A_Beam", rel = "laser_anpeq15_tan", pos = Vector(0, 0, 0.1), angle = Angle(0, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false },
	["flashlight"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_flashlight_band.mdl", bone = "A_LaserFlashlight", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 180), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
}

SWEP.WElements = {
	["ref"] = { type = "Model", model = SWEP.WorldModel, bone = "oof", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["sights_folded"] = { type = "Model", model = "models/weapons/smc/m24/upgrades/w_flipup_m24.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(90, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = true},
	["scope_mosin"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_scope_mosin.mdl", bone = "ATTACH_ModKit", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["sight_eotech"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_eotech.mdl", bone = "ATTACH_ModKit", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["scope_c79"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_elcan.mdl", bone = "ATTACH_ModKit", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["sight_rds"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_aimpoint.mdl", bone = "ATTACH_ModKit", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["scope_2xrds"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_magaim.mdl", bone = "ATTACH_ModKit", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["scope_po4x"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_po.mdl", bone = "ATTACH_ModKit", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["sight_kobra"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_kobra.mdl", bone = "ATTACH_ModKit", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["scope_mx4"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_scope_m40.mdl", bone = "ATTACH_ModKit", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["laser"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_laser_ins.mdl", bone = "ATTACH_Laser", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["suppressor"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_sil_sec2.mdl", bone = "ATTACH_Muzzle", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 0.63, 0.63), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["laser"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_laser_ins.mdl", bone = "ATTACH_Laser", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["flashlight"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_laser_ins.mdl", bone = "ATTACH_Laser", rel = "ref", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
}

SWEP.MuzzleAttachmentSilenced     = 1

SWEP.LaserSightModAttachment      = 1
SWEP.LaserSightModAttachmentWorld = 1
SWEP.LaserDotISMovement           = true

SWEP.RTAttachment_2XRDS           = 2
SWEP.ScopeDistanceMin_2XRDS       = 55
SWEP.ScopeDistanceRange_2XRDS     = 55

SWEP.RTAttachment_C79             = 2
SWEP.ScopeDistanceMin_C79         = 55
SWEP.ScopeDistanceRange_C79       = 55

SWEP.RTAttachment_PO4X            = 2
SWEP.ScopeDistanceMin_PO4X        = 55
SWEP.ScopeDistanceRange_PO4X      = 55

SWEP.RTAttachment_Mosin           = 2
SWEP.ScopeDistanceMin_Mosin       = 55
SWEP.ScopeDistanceRange_Mosin     = 55

SWEP.RTAttachment_MX4             = 2
SWEP.ScopeDistanceMin_MX4         = 55
SWEP.ScopeDistanceRange_MX4       = 55

DEFINE_BASECLASS( SWEP.Base )

if TFA.Yankys_Custom_Weapon_Pack then

    SWEP.AmmoTypeStrings = {
	    sniperpenetratedround = "7.62x51mm NATO M993"
    }

    function SWEP:OnCustomizationOpen()
	    self:EmitSound("TFA.Yankys_Custom_Weapon_Pack.Customization_Panel_Open")
    end

    function SWEP:OnCustomizationClose()
	    self:EmitSound("TFA.Yankys_Custom_Weapon_Pack.Customization_Panel_Close")
    end

end