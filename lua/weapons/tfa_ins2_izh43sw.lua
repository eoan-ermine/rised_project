-- "lua\\weapons\\tfa_ins2_izh43sw.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base					= ( TFA and DVL ) and "tfa_devl_base" or "tfa_gun_base"                   -- Weapon Base
SWEP.Category               = ( TFA and TFA.Yankys_Custom_Weapon_Pack_Categories ) and "[TFA] [AT] [ Shotguns ]" or "TFA Insurgency"   
SWEP.PrintName				= ( TFA and TFA.Yankys_Custom_Weapon_Pack ) and "Baikal IZH-43 MED" or "IZH-43 Sawed Off"   		           
SWEP.Manufacturer           = "Baikal"                         -- Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Purpose				= "A 12 Gauge Double Barrel Shotgun."
SWEP.Instructions			= ""              

SWEP.Author				    = "XxYanKy700xX"    
SWEP.Contact				= "https://steamcommunity.com/profiles/76561198296543672/" 

SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true                             -- Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= true		                       -- Draw the crosshair?
SWEP.DrawCrosshairIS		= false                            -- Draw the crosshair in ironsights?

SWEP.Slot					= 1			                       -- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 73			                   -- Position in the slot
SWEP.AutoSwitchTo			= true		                       -- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		                       -- Auto switch from if you pick up a better weapon
SWEP.Weight					= 30			                   -- This controls how "good" the weapon is for autopickup.
SWEP.Type                   = ( TFA and TFA.Yankys_Custom_Weapon_Pack ) and "Type: Break-Action Shotgun - Caliber: 12 Gauge - Muzzle Velocity: 430 m/s" or "Break-Action Shotgun"

--[[ WEAPON HANDLING ]]--

SWEP.Primary.Sound          = Sound("TFA_INS2_DOUBLEBARREL.1") 

SWEP.Primary.SoundEchoTable = {
	[0]   = Sound("TFA_MWR_SHOT.TailInside"),
	[256] = Sound("TFA_MWR_SHOT.TailOutside") 
}

SWEP.Primary.Damage                = ( TFA and TFA.Yankys_Custom_Weapon_Pack ) and 30 * TFA.Yankys_Custom_Weapon_Pack.DamageMultiplier or 16
SWEP.Primary.DamageTypeHandled     = true                      -- true will handle damagetype in base
SWEP.Primary.DamageType            = nil                       -- See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.PenetrationMultiplier = 0.995                     -- Change the amount of something this gun can penetrate through
SWEP.Primary.Velocity              = 430                       -- Bullet Velocity in m/s
SWEP.Primary.NumShots              = 12                        -- The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
  
SWEP.Primary.Automatic             = false                     -- Automatic/Semi Auto
SWEP.Primary.RPM                   = 450                       -- This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Burst             = 10000

SWEP.Primary.Force                 = nil                       -- Force value, leave nil to autocalc
SWEP.Primary.Knockback             = nil                       -- Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize              = 0                         -- Big bullets, increase this value.  They increase the hull size of the hitscan bullet.

SWEP.FiresUnderwater               = false

-- Miscelaneous Sounds--
SWEP.IronInSound                 = nil                         -- Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound                = nil                         -- Sound to play when ironsighting out?  nil for default

-- Selective Fire Stuff--
SWEP.Primary.Automatic           = false
SWEP.SelectiveFire               = true                        -- Allow selecting your firemode?
SWEP.DisableBurstFire            = false                       -- Only auto/single?
SWEP.OnlyBurstFire               = false                       -- No auto, only burst/single?
SWEP.DefaultFireMode             = "Semi"                      -- Default to auto or whatev
SWEP.FireModes                   = {"Semi","2Burst"}
SWEP.FireModeName                = "BREAK-ACTION"              -- C hange to a text value to override it

-- Ammo Related
SWEP.Primary.ClipSize            = 2                           -- This is the size of a clip
SWEP.Primary.DefaultClip         = SWEP.Primary.ClipSize * 20  -- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo                = "buckshot"                  -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption     = 1                           -- Ammo consumed per shot

SWEP.DisableChambering           = true                        -- Disable round-in-the-chamber
SWEP.CanJam                      = true

-- Recoil Related
SWEP.Primary.KickUp              = 2.7                         -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown            = 1.8                         -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal      = 0.25                        -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor  = 0.68                        -- Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

-- Firing Cone Related
SWEP.Primary.Spread              = .0415                       -- This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy        = .035                        -- Ironsight accuracy, should be the same for shotguns

-- Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.

SWEP.Primary.SpreadMultiplierMax = 2.8                         -- How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement     = 2.5                         -- What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery      = 3.05                        -- How much the spread recovers, per second. Example val: 3

-- Range Related
SWEP.Primary.Range               = 0.05 * (3280.84 * 16)       -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff        = 0.70                        -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

SWEP.Primary.RangeFalloffLUT = {
	bezier     = true,
	
	range_func = "quintic",
	units      = "meters",
	
	lut = {
		{range = 0, damage = 1},
		{range = 20, damage = 1},
		{range = 20, damage = 1},
		{range = 20, damage = 1},
		{range = 50, damage = 0.8},
		{range = 80, damage = 0.55},
	}
}

-- Misc
SWEP.IronRecoilMultiplier        = 0.8                         -- Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier    = 0.8                         -- Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate

-- Movespeed 
SWEP.MoveSpeed                   = 1                           -- Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed         = SWEP.MoveSpeed  * 0.92      -- Multiply the player's movespeed by this when sighting.

--[[EFFECTS]]--

-- Attachments
SWEP.ShellAttachment			 = "shell" 		               -- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleAttachment			 = "muzzle" 	               -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.MuzzleFlashEnabled          = true                        -- Enable muzzle flash
SWEP.MuzzleFlashEffect           = "tfa_muzzleflash_shotgun"
SWEP.MuzzleAttachmentRaw         = nil                         -- This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment  = false                       -- For multi-barrel weapons, detect the proper attachment?
SWEP.SmokeParticle               = nil                         -- Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled        = false

-- Tracer Stuff
SWEP.TracerName 		         = nil 	                       -- Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		         = 1 	                       -- 0 disables, otherwise, 1 in X chance

--[[ VIEWMODEL ]]--

SWEP.ViewModel		      = "models/weapons/tfa_ins2/c_izh43_sawnoff.mdl" 
SWEP.ViewModelFOV   	  = 70		                           -- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip        = false		                       -- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands             = true                               -- Use gmod c_arms system.

SWEP.VMPos                = ( TFA and TFA.Yankys_Custom_Weapon_Pack ) and Vector(-0.35, 0, 0.25) or Vector(-0.15, 0, 0.15)
SWEP.VMAng                = Vector(0.25, 0, 0)                 -- The viewmodel angular offset, constantly.   Subtract this from any other modifications to viewmodel angle.
SWEP.VMPos_Additive       = false                              -- Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.CenteredPos          = nil                                -- The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng          = nil                                -- The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.Bodygroups_V         = nil

--[[VIEWMODEL ANIMATION HANDLING]]--

SWEP.AllowViewAttachment  = true                               -- Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.

--[[ANIMATION]]--

SWEP.StatusLengthOverride = { -- Changes the status delay of a given animation; only used on reloads.  Otherwise, use SequenceLengthOverride or one of the others
	["base_reload"]       = 69 / 30,
	["base_reloadempty"]  = 100 / 30,
} 

SWEP.SequenceLengthOverride     = {}                           -- Changes both the status delay and the nextprimaryfire of a given animation
SWEP.SequenceRateOverride       = {}                           -- Like above but changes animation length to a target
SWEP.SequenceRateOverrideScaled = {}                           -- Like above but scales animation length rather than being absolute

SWEP.ProceduralHoslterEnabled   = nil
SWEP.ProceduralHolsterTime      = 0.3
SWEP.ProceduralHolsterPos       = Vector(3, 0, -5)
SWEP.ProceduralHolsterAng       = Vector(-40, -30, 10)

SWEP.Sights_Mode                = TFA.Enum.LOCOMOTION_HYBRID   -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation

SWEP.Sprint_Mode                = TFA.Enum.LOCOMOTION_ANI      -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.SprintBobMult              = 0.35
SWEP.SprintFOVOffset            = 5

SWEP.Idle_Mode                  = TFA.Enum.IDLE_BOTH           -- TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend                 = 0.25                         -- Start an idle this far early into the end of a transition
SWEP.Idle_Smooth                = 0.05                         -- Start an idle this far early into the end of another animation

-- MDL Animations Below
SWEP.IronAnimation = {
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_ACT,                     -- Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK_1,                    -- umber for act, String/Number for sequence
		["value_last"] = ACT_VM_PRIMARYATTACK_2
	} 
}

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ,                     -- Sequence or act
		["value"] = "base_sprint",                             -- Number for act, String/Number for sequence
		["is_idle"] = true
	}
}

--[[WORLDMODEL]]--

SWEP.WorldModel	  = "models/weapons/tfa_ins2/w_izh43_sawnoff.mdl" 
SWEP.Bodygroups_W = nil

SWEP.HoldType     = "shotgun" 

-- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles

SWEP.Offset = {
	Pos = {
		Up = -2,
		Right = 0.964,
		Forward = 4
	},
	Ang = {
		Up = 0,
		Right = -5.844,
		Forward = 180
	},
	Scale = 1
}

SWEP.ThirdPersonReloadDisable = false  -- Disable third person reload?  True disables.

--[[IRONSIGHTS]]--

SWEP.data              = {}
SWEP.data.ironsights   = 1             -- Enable Ironsights

SWEP.Secondary.IronFOV = 80            -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.

SWEP.IronSightsReloadEnabled = true
SWEP.IronSightsReloadLock    = false

SWEP.IronSightsPos     = Vector(-1.935, -2.7, 1.735)
SWEP.IronSightsAng     = Vector(0, 0, 0)

SWEP.IronSightsPos_Point_Shooting = Vector(-3.2, 2, -1)
SWEP.IronSightsAng_Point_Shooting = Vector(0, 0, -30)
SWEP.Secondary.Point_Shooting_FOV = 70 

--[[SPRINTING]]--

SWEP.RunSightsPos = Vector(3, -6, -6)  
SWEP.RunSightsAng = Vector(20, 30, 0)

--[[ CROUCHING ]] --

SWEP.CrouchPos    = Vector(-0.5, -1, -0.5) + SWEP.VMPos
SWEP.CrouchAng    = Vector(0, 0, -6.5) + SWEP.VMAng

--[[INSPECTION]]--

SWEP.InspectPos   = Vector(5, -5.619, -2.787)
SWEP.InspectAng   = Vector(22.386, 34.417, 5)

--[[ATTACHMENTS]]--

SWEP.Attachments = {
	[1] = { atts = { "ins2_br_heavy", "r6s_h_barrel" } },
	[2] = { atts = { "tfa_tactical_point_shooting" } },
	[3] = { atts = { "tfa_yanks_wpn_pack_heavy_stock", "tfa_yanks_wpn_pack_light_stock", "bo2_stock" } },
	[4] = { atts = { "tfa_yanks_wpn_pack_sleight_of_hand", "tfa_yanks_wpn_pack_quick_draw", "bo2_rapidfire", "bo2_quickdraw" } },
	[5] = { atts = { "sg_frag", "sg_slug", "ammo_dragonbreath_shells", "fas2tfa_ammo_incn", "ammo_flechette_shells", "amno_flechette", "kzsf_vc30_incendiary" } },
}

DEFINE_BASECLASS( SWEP.Base )

if TFA.Yankys_Custom_Weapon_Pack then

    SWEP.AmmoTypeStrings = {
	    buckshot = "12 Gauge B1761 Shells"
    }

    function SWEP:OnCustomizationOpen()
	    self:EmitSound("TFA.Yankys_Custom_Weapon_Pack.Customization_Panel_Open")
    end

    function SWEP:OnCustomizationClose()
	    self:EmitSound("TFA.Yankys_Custom_Weapon_Pack.Customization_Panel_Close")
    end

end