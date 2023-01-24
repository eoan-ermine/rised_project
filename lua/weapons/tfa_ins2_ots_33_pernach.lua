-- "lua\\weapons\\tfa_ins2_ots_33_pernach.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base					= ( TFA and DVL ) and "tfa_devl_base" or "tfa_gun_base"                    -- Weapon Base
SWEP.Category               = ( TFA and TFA.Yankys_Custom_Weapon_Pack_Categories ) and "[TFA] [AT] [ Pistols ]" or "TFA Insurgency"   
SWEP.PrintName				= ( TFA and TFA.Yankys_Custom_Weapon_Pack ) and "KBP OTs-33 Pernach" or "OTs-33 Pernach"   		           
SWEP.Manufacturer           = "KBP Instrument Design Bureau"    -- Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Purpose				= "An Russian 9x18MM Automatic Pistol." 
SWEP.Instructions			= ""              

SWEP.Author				    = "XxyanKy700xX"                    -- Author Tooltip
SWEP.Contact				= "https://steamcommunity.com/profiles/76561198296543672/" 

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true                              -- Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= true		                        -- Draw the crosshair?
SWEP.DrawCrosshairIS		= false                             -- Draw the crosshair in ironsights?

SWEP.Slot					= 1			                        -- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73			                    -- Position in the slot
SWEP.AutoSwitchTo			= true		                        -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		                        -- Auto switch from if you pick up a better weapon
SWEP.Weight					= 30			                    -- This controls how "good" the weapon is for autopickup.
SWEP.Type                   = ( TFA and TFA.Yankys_Custom_Weapon_Pack ) and "Type: Machine Pistol - Caliber: 9x18mm - Muzzle Velocity: 330 m/s" or "Machine Pistol"

--[[ WEAPON HANDLING ]]--

SWEP.Primary.Sound          = Sound("TFA_INS2.OTS33.Fire")            -- This is the sound of the weapon, when you shoot.
SWEP.Primary.SilencedSound  = Sound("TFA_INS2.OTS33.Fire_Suppressed") -- This is the sound of the weapon, when silenced.

SWEP.Primary.SoundEchoTable = {
	[0]   = Sound("TFA_MWR_AK74U.TailInside"), 
	[256] = Sound("TFA_MWR_AK74U.TailOutside") 
}

SWEP.Primary.Damage                = ( TFA and TFA.Yankys_Custom_Weapon_Pack ) and 40 * TFA.Yankys_Custom_Weapon_Pack.DamageMultiplier or 27                        
SWEP.Primary.DamageTypeHandled     = true                       -- true will handle damagetype in base
SWEP.Primary.DamageType            = nil                        -- See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.PenetrationMultiplier = 0.825                      -- Change the amount of something this gun can penetrate through
SWEP.Primary.Velocity              = 330                        -- Bullet Velocity in m/s
SWEP.Primary.NumShots              = 1                          -- The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.

SWEP.Primary.Automatic             = true                       -- Automatic/Semi Auto
SWEP.Primary.RPM                   = 900                        -- This is in Rounds Per Minute / RPM

SWEP.Primary.Force                 = nil                        -- Force value, leave nil to autocalc
SWEP.Primary.Knockback             = nil                        -- Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize              = 0                          -- Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.FiresUnderwater               = true                       -- Enable or Disable fire Under Water

-- Miscelaneous Sounds
SWEP.IronInSound                   = nil                        -- Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound                  = nil                        -- Sound to play when ironsighting out?  nil for default

--[[ Ammo Related ]]--

SWEP.Primary.ClipSize              = 27                         -- This is the size of a clip
SWEP.Primary.DefaultClip           = SWEP.Primary.ClipSize * 13  -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo                  = "pistol"                   -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption       = 1                          -- Ammo consumed per shot
SWEP.DisableChambering             = false                      -- Disable round-in-the-chamber
 SWEP.CanJam                       = true

--[[ Selective Fire Stuff ]]--

SWEP.SelectiveFire               = true                         -- Allow selecting your firemode?
SWEP.DisableBurstFire            = true                         -- Only auto/single?
SWEP.OnlyBurstFire               = false                        -- No auto, only burst/single?
SWEP.DefaultFireMode             = ""                           -- Default to auto or whatev
SWEP.FireModeName                = nil                          -- Change to a text value to override it

--[[ Recoil Related ]]--

SWEP.Primary.KickUp              = 0.32                         -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown            = 0.3                          -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal      = 0.18                         -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor  = 0.67                         -- Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

--[[ Firing Cone Related ]]--

SWEP.Primary.Spread              = .0244                        -- This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy        = .0105                        -- Ironsight accuracy, should be the same for shotguns

-- Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.

SWEP.Primary.SpreadMultiplierMax = 4.2                          -- How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement     = 1.2                          -- What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery      = 8                            -- How much the spread recovers, per second. Example val: 3

--[[ Movespeed ]]--

SWEP.MoveSpeed                   = 1                            -- Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed         = 0.95                         -- Multiply the player's movespeed by this when sighting.


--[[ Range Related ]]--

SWEP.Primary.Range               = 0.2 * (3280.84 * 16)         -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff        = 0.85                         -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

SWEP.Primary.RangeFalloffLUT = {
	bezier     = true,
	
	range_func = "quintic",
	units      = "meters",
	
	lut = {
		{range = 0, damage = 1},
		{range = 50, damage = 1},
		{range = 100, damage = 1},
		{range = 100, damage = 1},
		{range = 100, damage = 1},
		{range = 150, damage = 0.90},
		{range = 200, damage = 0.80},
		{range = 300, damage = 0.65},
	}
}

--[[ Penetration Related ]]--

SWEP.MaxPenetrationCounter       = 3                            -- The maximum number of ricochets.  To prevent stack overflows.

--[[ Misc ]]--

SWEP.IronRecoilMultiplier        = 0.8                          -- Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier    = 0.645                        -- Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate

--[[EFFECTS]]--

-- Attachments
SWEP.MuzzleFlashEnabled          = true                         -- Enable muzzle flash
SWEP.MuzzleAttachmentRaw         = nil                          -- This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.MuzzleFlashEffect           = ( TFA and TFA.YanKys_Realistic_Muzzleflashes ) and "tfa_muzzleflash_ots_pernach" or "tfa_muzzleflash_pistol"     -- Change to a string of your muzzle flash effect.  Copy/paste one of the existing from the base.

SWEP.MuzzleAttachment			 = "muzzle" 		            -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			 = "shell" 		                -- Should be "2" for CSS models or "shell" for hl2 models

SWEP.AutoDetectMuzzleAttachment  = false                        -- For multi-barrel weapons, detect the proper attachment?
SWEP.SmokeParticle               = nil                          -- Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled        = false                        -- Disable automatic ejection smoke

-- Shell eject override
SWEP.LuaShellEject               = true                         -- Enable shell ejection through lua?
SWEP.LuaShellEjectDelay          = 0                            -- The delay to actually eject things
SWEP.LuaShellEffect              = "ShellEject"                 -- The effect used for shell ejection; Defaults to that used for blowback

-- Tracer Stuff
SWEP.TracerName 		         = nil 	                        -- Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		         = 1	                        -- 0 disables, otherwise, 1 in X chance

--[[ VIEWMODEL ]]--

SWEP.ViewModel		= "models/weapons/c_ins2_pist_ots33.mdl" 

SWEP.VMPos          = ( TFA and TFA.Yankys_Custom_Weapon_Pack ) and Vector(-0.72, 0, 0) or Vector(-0.15, 0, 0)
SWEP.VMAng          = Vector(0.1, 0, 0)
SWEP.VMPos_Additive = false                                     -- Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse

SWEP.ViewModelFOV   = 70		                                -- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip  = false		                                -- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands       = true                                      -- Use gmod c_arms system.
  
SWEP.CenteredPos    = nil                                       -- The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng    = nil                                       -- The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.Bodygroups_V   = {}

--[ ANIMATION ]--

SWEP.SequenceLengthOverride = {}                                -- Changes both the status delay and the nextprimaryfire of a given animation

SWEP.SequenceRateOverride   = {
	[ACT_VM_RELOAD]         = 1.1,
	[ACT_VM_RELOAD_EMPTY]   = 1.1
}

SWEP.StatusLengthOverride   = {                                 -- Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others
	[ACT_VM_RELOAD]         = 65 / 30,
	[ACT_VM_RELOAD_EMPTY]   = 87 / 30
} 

SWEP.ProceduralHoslterEnabled = nil
SWEP.ProceduralHolsterTime    = 0.3
SWEP.ProceduralHolsterPos     = Vector(3, 0, -5)
SWEP.ProceduralHolsterAng     = Vector(-40, -30, 10)

SWEP.Sights_Mode              = TFA.Enum.LOCOMOTION_HYBRID      -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation

SWEP.Sprint_Mode              = TFA.Enum.LOCOMOTION_ANI         -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.SprintBobMult            = 0.35
SWEP.SprintFOVOffset          = 5

SWEP.Idle_Mode                = TFA.Enum.IDLE_BOTH              -- TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend               = 0.25                            -- Start an idle this far early into the end of a transition
SWEP.Idle_Smooth              = 0.05                            -- Start an idle this far early into the end of another animation

--[ MDL Animations Below ]--
SWEP.IronAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,                      -- Sequence or act
		["value"] = "base_idle",                                -- Number for act, String/Number for sequence
		["value_empty"] = "empty_idle"
	},
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,                      -- Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK_1,                     -- Number for act, String/Number for sequence
		["value_last"] = ACT_VM_PRIMARYATTACK_2,
		["value_empty"] = ACT_VM_PRIMARYATTACK_3
	}
}

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,                      -- Sequence or act
		["value"] = "base_sprint",                              -- Number for act, String/Number for sequence
		["value_empty"] = "empty_sprint",
		["is_idle"] = true
	}
}

--[[VIEWMODEL ANIMATION HANDLING]]--

SWEP.AllowViewAttachment    = true 

--[[ WORLDMODEL ]]--

SWEP.WorldModel	    = "models/weapons/w_ins2_pist_ots33.mdl"    -- Weapon world model path
SWEP.Bodygroups_W   = {}                                        -- Weapon World model BodyGroups
SWEP.HoldType       = "pistol"                                  -- This is how others view you carrying the weapon. Options include:

-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.Offset = { -- Procedural world model animation, defaulted for CS:S purposes.
	Pos = {
		Up = -1.5,
		Right = 1.2,
		Forward = 1.8
	},
	Ang = {
		Up = -1,
		Right = -5,
		Forward = 180
	},
	
	Scale = 1
}

SWEP.ThirdPersonReloadDisable  = false  -- Disable third person reload?  True disables.

-- [[ IRONSIGHTS ]] --

SWEP.data = {}
SWEP.data.ironsights   = 1  -- Enable Ironsights
SWEP.Secondary.IronFOV = 80 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.

SWEP.IronSightsReloadEnabled = true
SWEP.IronSightsReloadLock    = false

SWEP.IronSightsPos       = Vector(-1.8505, -0.4, 0.41) -- SWEP.IronSightsPos = Vector(-1.85, -0.5, 0.1) Railed
SWEP.IronSightsAng       = Vector(0.27, 0.02, 0)       -- SWEP.IronSightsAng = Vector(0.65, 0.035, 0)   Railed

SWEP.IronSightsPos_Point_Shooting = Vector(-4, 0, -1)
SWEP.IronSightsAng_Point_Shooting = Vector(0, 0, -30)
SWEP.Secondary.Point_Shooting_FOV = 70 

SWEP.IronSightsPos_Kobra  = Vector(-1.865, -0.55, -0.965)
SWEP.IronSightsAng_Kobra  = Vector(0.05, -0.12, 0)

SWEP.IronSightsPos_RDS    = Vector(-1.87, -0.55, -0.95)
SWEP.IronSightsAng_RDS    = Vector(0.05, -0.12, 0)

SWEP.IronSightsPos_EOTech = Vector(-1.865, -1.25, -0.9)
SWEP.IronSightsAng_EOTech = Vector(-0.1, -0.12, 0)

--[[ SPRINTING ]]--

SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-8.5, 5, -5)

--[[ CROUCHING ]] --

SWEP.CrouchPos    = Vector(-1.92, -1.2, -1)
SWEP.CrouchAng    = Vector(0, 0, -20)

--[[ INSPECTION ]] --

SWEP.InspectPos     = Vector(5.5, -5.5, -2.241) 
SWEP.InspectAng     = Vector(24.622, 36, 15.477)

--[[ ATTACHMENTS ]]--

SWEP.Attachments = {
	[1] = { atts = { "ins2_si_kobra", "ins2_si_eotech", "ins2_si_rds" } },
	[2] = { atts = { "ins2_br_heavy", "r6s_h_barrel", "r6s_muzzle_2", "r6s_flashhider_2", "bo2_longbarrel", "ins2_br_supp", "ins2_eft_aac", "ins2_eft_osprey" } },
	[3] = { atts = { "ins2_ub_laser_railed_ots33" } },
	[4] = { atts = { "ins2_stock_ots33" } },
	[5] = { atts = { "tfa_tactical_point_shooting" } },
	[6] = { atts = { "tfa_yanks_wpn_pack_sleight_of_hand", "tfa_yanks_wpn_pack_quick_draw", "bo2_rapidfire", "bo2_quickdraw" }},
	[7] = { atts = { "am_match", "am_magnum", "am_gib", "tfa_mb_penrnd" } },
}

SWEP.AttachmentDependencies = {	
    ["tfa_tactical_point_shooting"] = {"ins2_ub_laser_railed_ots33"},
}

SWEP.AttachmentExclusions   = {}

SWEP.ViewModelBoneMods = {
	["A_Muzzle"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, -90) },
	["A_Optic"] = { scale = Vector(0.8, 0.8, 0.8), pos = Vector(0, 0, -0.05), angle = Angle(0, 0, 0) },
	["A_Suppressor"] = { scale = Vector(1, 1, 1), pos = Vector(0.04, 0, 0), angle = Angle(0, 0, 0) },
	["A_LaserFlashlight"] = { scale = Vector(1, 1, 1), pos = Vector(-1.5, -15, -2), angle = Angle(0, 0, 0) },
--	["A_LaserFlashlight"] = { scale = Vector(0.8, 0.8, 0.8), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["R UpperArm"] = { scale = Vector(1, 1, 1), pos = Vector(0.075, 0, 0), angle = Angle(0, 0, 0) },
--	["L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 2, -10) },
--	["L Finger01"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 5, -10) },
}

SWEP.WorldModelBoneMods = {
	["Muzzle"] = { scale = wmscale, pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
}

SWEP.VElements = {
	["rail_sights"] = { type = "Model", model = "models/weapons/upgrades/a_modkit_ots33.mdl", bone = "Weapon", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false},
	["sight_kobra"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_kobra_l.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["sight_kobra_lens"] = (TFA.INS2 and TFA.INS2.GetHoloSightReticle) and TFA.INS2.GetHoloSightReticle("sight_kobra") or nil,
	["sight_eotech"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_eotech.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["sight_eotech_lens"] = (TFA.INS2 and TFA.INS2.GetHoloSightReticle) and TFA.INS2.GetHoloSightReticle("sight_eotech") or nil,
	["sight_rds"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_optic_aimpoint.mdl", bone = "A_Optic", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, active = false, bonemerge = true },
	["sight_rds_lens"] = (TFA.INS2 and TFA.INS2.GetHoloSightReticle) and TFA.INS2.GetHoloSightReticle("sight_rds") or nil,

	["suppressor"] = { type = "Model", model = "models/weapons/upgrades/a_suppressor_ots33.mdl", bone = "A_Suppressor", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = true, active = false, bodygroup = {} },
	["laser"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_laser_g18.mdl", bone = "A_LaserFlashlight", rel = "", pos = Vector(-17, -1.8, 2.12), angle = Angle(0, 0, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_railed"] = { type = "Model", model = "models/weapons/upgrades/a_laser_p320.mdl", bone = "A_LaserFlashlight", rel = "", pos = Vector(-13, -1.6, 1.55), angle = Angle(0, 0, 0), size = Vector(0.95, 0.95, 0.95), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
--	["laser_railed"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/a_laser_g18.mdl", bone = "A_LaserFlashlight", rel = "", pos = Vector(-13.5, -1.7, 1.5), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["laser_modkit"] = { type = "Model", model = "models/weapons/upgrades/a_modkit_ots33.mdl", bone = "Weapon", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false},
	["laser_beam"] = { type = "Model", model = "models/tfa/lbeam.mdl", bone = "LaserPistol", rel = "laser", pos = Vector(1.8, 0.1, -1.2), angle = Angle(0, 0, 0), size = Vector(2, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	
--	["flashlight_lastac"] = { type = "Model", model = "models/weapons/tfa_eft/upgrades/tactical/LASTAC2/LASTAC2.mdl", bone = "A_LaserFlashlight", rel = "", pos = Vector(0.2, 0, 0.4), angle = Angle(0, 0, 0), size = Vector(0.9, 0.9, 0.9), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["suppressor_osprey"] = { type = "Model", model = "models/weapons/tfa_eft/upgrades/v_osprey.mdl", bone = "A_Suppressor", rel = "", pos = Vector(0, -0.6, -0.1), angle = Angle(0, 0, 0), size = Vector(0.95, 0.95, 0.8), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
	["suppressor_aac"] = { type = "Model", model = "models/weapons/tfa_eft/upgrades/v_aac.mdl", bone = "A_Suppressor", rel = "", pos = Vector(0, -0.6, -0.1), angle = Angle(0, 0, 0), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = false, active = false, bodygroup = {} },
}

SWEP.WElements = {
	["rail_sights"] = { type = "Model", model = "models/weapons/upgrades/a_modkit_ots33.mdl", bone = "ATTACH_ModKit", rel = "", pos = Vector(0, 14.5, 1), angle = Angle(0, 90, 0), size = Vector(1.25, 1.25, 1.25), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = false, active = false},
	["sight_eotech"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_eotech.mdl", bone = "ATTACH_ModKit", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["sight_rds"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_aimpoint.mdl", bone = "ATTACH_ModKit", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["sight_kobra"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_kobra.mdl", bone = "ATTACH_ModKit", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
	["suppressor"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_sil_pistol.mdl", bone = "", rel = "", pos = Vector(-11.5, -3.6, -32.9), angle = Angle(90, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bonemerge = true, active = false, bodygroup = {} },
	["laser"] = { type = "Model", model = "models/weapons/tfa_ins2/upgrades/w_laser_sec.mdl", bone = "ATTACH_Laser", rel = "", pos = Vector(0.65, 8, 9), angle = Angle(90, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, bonemerge = true, active = false },
}

local wmscale = Vector(1 / 1.3, 1 / 1.3, 1 / 1.3)

SWEP.MuzzleAttachmentSilenced     = 1

SWEP.LaserSightModAttachment      = 1
SWEP.LaserSightModAttachmentWorld = 0
SWEP.LaserDotISMovement           = true

DEFINE_BASECLASS( SWEP.Base )        -- Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.

if TFA.Yankys_Custom_Weapon_Pack then

    SWEP.AmmoTypeStrings = {
	    pistol = "9x18mm Makarov 7N30"
    }

    function SWEP:OnCustomizationOpen()
	    self:EmitSound("TFA.Yankys_Custom_Weapon_Pack.Customization_Panel_Open")
    end

    function SWEP:OnCustomizationClose()
	    self:EmitSound("TFA.Yankys_Custom_Weapon_Pack.Customization_Panel_Close")
    end

end