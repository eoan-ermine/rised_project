-- "lua\\weapons\\tfa_projecthl2_ar2.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base					= "tfa_gun_base"
SWEP.Category				= "TFA Project HL2" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer           =  "Combine Union" --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Description            =  ""
SWEP.Author				    = "thatrtxdude,Aiden,llopn" --Author Tooltip
SWEP.Type 				    = "Automatic Extraterrestrial Rifle"
SWEP.Contact				= "" --Contact Info Tooltip
SWEP.Purpose				= "Standard Issue Assault Rifle" --Purpose Tooltip
SWEP.Instructions				= "" --Instructions Tooltip
SWEP.Spawnable				= true
SWEP.AdminSpawnable			= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.DrawCrosshair			= true		-- Draw the crosshair?
SWEP.DrawCrosshairIS = false --Draw the crosshair in ironsights?
SWEP.PrintName				= "Project HL2 Pulse Rifle"		-- Weapon name (Shown on HUD)
SWEP.Slot				    = 2			-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 2.59 * 10		-- Position in the slot
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 2.59 * 10			-- This controls how "good" the weapon is for autopickup.


--[[WEAPON HANDLING]]--

SWEP.Primary.Sound = Sound("Project_MMOD_AR2.Fire") -- This is the sound of the weapon, when you shoot.
SWEP.Primary.PenetrationMultiplier = 0 --Change the amount of something this gun can penetrate through
SWEP.Primary.Damage = 35 -- Damage, in standard damage points.
SWEP.Primary.DamageTypeHandled = true --true will handle damagetype in base
SWEP.Primary.DamageType = 2 --See DMG enum.  This might be DMG_SHOCK, DMG_BURN, DMG_BULLET, etc.  Leave nil to autodetect.  DMG_AIRBOAT opens doors.
SWEP.Primary.Force = 10 --Force value, leave nil to autocalc
SWEP.Primary.Knockback = 0 --Autodetected if nil; this is the velocity kickback
SWEP.Primary.HullSize = 0 --Big bullets, increase this value.  They increase the hull size of the hitscan bullet.
SWEP.Primary.NumShots = 1 --The number of shots the weapon fires.  SWEP.Shotgun is NOT required for this to be >1.
SWEP.Primary.Automatic = true -- Automatic/Semi Auto
SWEP.Primary.RPM = 600 -- This is in Rounds Per Minute / RPM
SWEP.Primary.DryFireDelay = nil --How long you have to wait after firing your last shot before a dryfire animation can play.  Leave nil for full empty attack length.  Can also use SWEP.StatusLength[ ACT_VM_BLABLA ]
SWEP.Primary.BurstDelay = nil -- Delay between bursts, leave nil to autocalculate
SWEP.Primary.Velocity = 500
SWEP.IronSightTime = 0.2
SWEP.FiresUnderwater = true

SWEP.Secondary.ClipSize			= -1					-- Size of a clip
SWEP.Secondary.DefaultClip			= 2					-- Default ammo to give...
SWEP.Secondary.Ammo = "AR2AltFire"
SWEP.Secondary.Automatic = false
SWEP.Secondary.RPM = 30
SWEP.Secondary.Delay = 1.5
SWEP.Secondary.Velocity = 1000
SWEP.Secondary.Recoil = 4

--Miscelaneous Sounds
SWEP.IronInSound = Sound( "Project_MMOD_Weapon_Generic.ADSIn")  --Sound to play when ironsighting in?  nil for default
SWEP.IronOutSound = Sound( "Project_MMOD_Weapon_Generic.ADSOut") --Sound to play when ironsighting out?  nil for default
--Silencing
SWEP.CanBeSilenced = false --Can we silence?  Requires animations.
SWEP.Silenced = false --Silenced by default?
-- Selective Fire Stuff
SWEP.SelectiveFire = true --Allow selecting your firemode?
SWEP.DisableBurstFire = true --Only auto/single?
SWEP.OnlyBurstFire = false --No auto, only burst/single?
SWEP.BurstFireCount = 2
SWEP.DefaultFireMode = "" --Default to auto or whatev
SWEP.FireModeName = nil --Change to a text value to override it
--Ammo Related
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 150-- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.Primary.Ammo = "ar2" -- What kind of ammo.  Options, besides custom, include pistol, 357, smg1, ar2, buckshot, slam, SniperPenetratedRound, and AirboatGun.
SWEP.Primary.AmmoConsumption = 1 --Ammo consumed per shot
--Pistol, buckshot, and slam like to ricochet. Use AirboatGun for a light metal peircing shotgun pellets
SWEP.DisableChambering = false --Disable round-in-the-chamber
--Recoil Related
SWEP.Primary.KickUp = 0.2 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 0.1 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.1 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.1 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
SWEP.CrouchPos = Vector(-2.5, 1, -0.25)
SWEP.CrouchAng = Vector(0, 0, -16.375)
--Firing Cone Related
SWEP.Primary.Spread = .022 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = 2.75 / 10800 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 60 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 0.1
SWEP.Primary.SpreadRecovery = 60 --How much the spread recovers, per second. Example val: 3
SWEP.Secondary.Delay = 3
--Range Related
SWEP.Primary.Range = 0.55 * (3280.84 * 16) -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.85 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Penetration Related
SWEP.MaxPenetrationCounter = 3 --The maximum number of ricochets.  To prevent stack overflows.
--Misc
SWEP.IronRecoilMultiplier = 0.85 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier = 0.65 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--Movespeed
SWEP.MoveSpeed = 0.01 * (100 - ((SWEP.Weight / 10) + ((SWEP.Weight / 10) - 1.65)))
SWEP.IronSightsMoveSpeed = SWEP.MoveSpeed * 0.8
--[[PROJECTILES]]--
SWEP.ProjectileEntity = nil --Entity to shoot
SWEP.ProjectileVelocity = 0 --Entity to shoot's velocity
SWEP.ProjectileModel = nil --Entity to shoot's model
--[[VIEWMODEL]]--
SWEP.ViewModel			= "models/weapons/C_IIopnirifle.mdl" --Viewmodel path
SWEP.ViewModelFOV			= 65		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)
SWEP.UseHands = true --Use gmod c_arms system.
SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0,0,0)
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse
SWEP.CenteredPos = nil --The viewmodel positional offset, used for centering.  Leave nil to autodetect using ironsights.
SWEP.CenteredAng = nil --The viewmodel angular offset, used for centering.  Leave nil to autodetect using ironsights.
--[[WORLDMODEL]]--
SWEP.WorldModel			= "models/weapons/W_IIopnIRifle.mdl" -- Weapon world model path
SWEP.Bodygroups_W = {}
SWEP.HoldType = "ar2" -- This is how others view you carrying the weapon. Options include:
-- normal melee melee2 fist knife smg ar2 pistol rpg physgun grenade shotgun crossbow slam passive
-- You're mostly going to use ar2, smg, shotgun or pistol. rpg and crossbow make for good sniper rifles
SWEP.Offset = {
	Pos = {
		Up = -0,
		Right = 0,
		Forward = 0
	},
	Ang = {
		Up = 0,
		Right = 0,
		Forward = 0
	},
	Scale = 1
} --Procedural world model animation, defaulted for CS:S purposes.

SWEP.ThirdPersonReloadDisable = false --Disable third person reload?  True disables.
--[[SCOPES]]--
SWEP.IronSightsSensitivity = 1 --Useful for a RT scope.  Change this to 0.25 for 25% sensitivity.  This is if normal FOV compenstaion isn't your thing for whatever reason, so don't change it for normal scopes.
SWEP.BoltAction = false --Unscope/sight after you shoot?
SWEP.Scoped = false --Draw a scope overlay?
SWEP.ScopeOverlayThreshold = 0.5 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.
SWEP.ScopeScale = 0.5 --Scale of the scope overlay
SWEP.ReticleScale = 0.7 --Scale of the reticle overlay
--GDCW Overlay Options.  Only choose one.
SWEP.Secondary.UseACOG = false --Overlay option
SWEP.Secondary.UseMilDot = false --Overlay option
SWEP.Secondary.UseSVD = false --Overlay option
SWEP.Secondary.UseParabolic = false --Overlay option
SWEP.Secondary.UseElcan = false --Overlay option
SWEP.Secondary.UseGreenDuplex = false --Overlay option
if surface then
	SWEP.Secondary.ScopeTable = nil --[[
		{
			scopetex = surface.GetTextureID("scope/gdcw_closedsight"),
			reticletex = surface.GetTextureID("scope/gdcw_acogchevron"),
			dottex = surface.GetTextureID("scope/gdcw_acogcross")
		}
	]]--
end
--[[SHOTGUN CODE]]--
SWEP.Shotgun = false --Enable shotgun style reloading.
--[[SPRINTING]]--
SWEP.RunSightsPos = Vector(0, 0, 0)
SWEP.RunSightsAng = Vector(-5, 0, 0)
SWEP.SafetyPos = Vector(1.279, -2.654, 0.579)
SWEP.SafetyAng = Vector(-6.459, 27.072, 0)
--[[IRONSIGHTS]]--
SWEP.data = {}
SWEP.data.ironsights = 1 --Enable Ironsights
SWEP.Secondary.IronFOV = 65 -- How much you 'zoom' in. Less is more!  Don't have this be <= 0.  A good value for ironsights is like 70.
SWEP.IronSightsPos = Vector(-0.288, 2.526, 1.35)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RTBGBlur = false

--[[INSPECTION]]--
-- SWEP.InspectPos = Vector(0, -5, -10)
-- SWEP.InspectAng = Vector(45, 0, 0)
SWEP.InspectPos = Vector(7.5, -2.5, 0)
SWEP.InspectAng = Vector(33.5, 45, 33.5)
--[[VIEWMODEL ANIMATION HANDLING]]--
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS.
--[[VIEWMODEL BLOWBACK]]--
SWEP.BlowbackEnabled = false --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-2,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = nil --Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_Shell_Enabled = true --Shoot shells through blowback animations
SWEP.Blowback_Shell_Effect = "RifleShellEject"--Which shell effect to use
--[[VIEWMODEL PROCEDURAL ANIMATION]]--
SWEP.DoProceduralReload = false--Animate first person reload using lua?
SWEP.ProceduralReloadTime = 1 --Procedural reload time?
--[[HOLDTYPES]]--
SWEP.IronSightHoldTypeOverride = "" --This variable overrides the ironsights holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
SWEP.SprintHoldTypeOverride = "" --This variable overrides the sprint holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.

SWEP.ProceduralHoslterEnabled = nil
SWEP.ProceduralHolsterTime = 0.3
SWEP.ProceduralHolsterPos = Vector(3, 0, -5)
SWEP.ProceduralHolsterAng = Vector(-40, -30, 10)

SWEP.Sights_Mode = TFA.Enum.LOCOMOTION_HYBRID -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.SprintBobMult = 0.25
SWEP.Walk_Mode = TFA.Enum.LOCOMOTION_ANI -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation
--MDL Animations Below

SWEP.IronAnimation = {
	["shoot"] = {
		["type"] = TFA.Enum.ANIMATION_ACT, --Sequence or act
		["value"] = ACT_VM_PRIMARYATTACK_1, --Number for act, String/Number for sequence
		["value_empty"] = ACT_VM_PRIMARYATTACK_2
	} --What do you think
}

SWEP.WalkAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "Walk", --Number for act, String/Number for sequence
		["value_empty"] = "Walk_Empty",
		["is_idle"] = true
	}, --What do you think
}

SWEP.SprintAnimation = {
	["loop"] = {
		["type"] = TFA.Enum.ANIMATION_SEQ, --Sequence or act
		["value"] = "Sprint", --Number for act, String/Number for sequence
		["value_empty"] = "Sprint_Empty",
		["is_idle"] = true
	}
}
--[[EFFECTS]]--
--Attachments
SWEP.MuzzleAttachment			= "muzzle" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.ShellAttachment			= "1" 		-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleFlashEnabled = true --Enable muzzle flash
SWEP.MuzzleAttachmentRaw = nil --This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = ( TFA and TFA.YanKys_Realistic_Muzzleflashes ) and "mmod_muzzleflash_Ar2" or "tfa_muzzleflash_generic"
SWEP.ChargeMuzzleFlashEffect = "mmod_muzzleflash_Ar2_charge" --Used by the AR2, Charging Muzzle effect
SWEP.SecondaryMuzzleFlash = "mmod_muzzleflash_Ar2_alt" --Used by the AR2, Secondary Fire muzzle effect.
SWEP.SmokeParticle = nil --Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled = false --Disable automatic ejection smoke
--Shell eject override
SWEP.LuaShellEject = true --Enable shell ejection through lua?
SWEP.LuaShellEjectDelay = 0 --The delay to actually eject things
SWEP.LuaShellEffect = "RifleShellEject" --The effect used for shell ejection; Defaults to that used for blowback
SWEP.LuaShellModel = "models/weapons/shells/ProjectMMODirifleshell.mdl"
--Tracer Stuff
SWEP.TracerName 		= nil 	--Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount 		= 0 	--0 disables, otherwise, 1 in X chance
--Impact Effects
SWEP.ImpactEffect = "AR2Impact"--Impact Effect
SWEP.ImpactDecal = nil--Impact Decal
--[[EVENT TABLE]]--
SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
	    {time = 17 / 30, type = "sound", value = Sound("Project_Generic.Movement2")},
		{time = 64 / 30, type = "sound", value = Sound("Project_Generic.Movement5")},
	},
	[ACT_VM_RELOAD_EMPTY] = {
	    {time = 11 / 30, type = "sound", value = Sound("Project_Generic.Movement2")},
		{time = 25 / 30, type = "sound", value = Sound("Project_Generic.Movement5")},
	},
	
}

SWEP.StatusLengthOverride = {
	[ACT_VM_RELOAD] = 55 / 60,
	[ACT_VM_RELOAD_EMPTY] = 55 / 60,
}

SWEP.SequenceLengthOverride = {
	[ACT_VM_RELOAD]  = 89 / 60,
	[ACT_VM_RELOAD_EMPTY] = 89 / 60,
}


DEFINE_BASECLASS( SWEP.Base )

function SWEP:ChooseShootAnim(ifp)
	ifp = ifp or IsFirstTimePredicted()
	if not self:VMIV() then return end

	if self:GetIronSights() and (self.Sights_Mode == TFA.Enum.LOCOMOTION_ANI or self.Sights_Mode == TFA.Enum.LOCOMOTION_HYBRID) and self:GetStat("IronAnimation.shoot") then
		if self.LuaShellEject and ifp then
			self:EventShell()
		end

		return self:PlayAnimation(self:GetStat("IronAnimation.shoot"))
	end

	if not self.BlowbackEnabled or (not self:GetIronSights() and self.Blowback_Only_Iron) then
		success = true

		if self.LuaShellEject and (ifp or game.SinglePlayer()) then
			self:EventShell()
		end

		if self:GetActivityEnabled(ACT_VM_PRIMARYATTACK_SILENCED) and self:GetSilenced() then
			typev, tanim = self:ChooseAnimation("shoot1_silenced")
		elseif self:Clip1() <= self.Primary.AmmoConsumption and self:GetActivityEnabled(ACT_VM_PRIMARYATTACK_EMPTY) and self.Primary.ClipSize >= 1 and not self.ForceEmptyFireOff then
			typev, tanim = self:ChooseAnimation("shoot1_last")
		elseif self:Ammo1() <= self.Primary.AmmoConsumption and self:GetActivityEnabled(ACT_VM_PRIMARYATTACK_EMPTY) and self.Primary.ClipSize < 1 and not self.ForceEmptyFireOff then
			typev, tanim = self:ChooseAnimation("shoot1_last")
		elseif self:Clip1() == 0 and self:GetActivityEnabled(ACT_VM_DRYFIRE) and not self.ForceDryFireOff then
			typev, tanim = self:ChooseAnimation("shoot1_empty")
		elseif self:GetStat("Akimbo") and self:GetActivityEnabled(ACT_VM_SECONDARYATTACK) and ((self.AnimCycle == 0 and not self.Akimbo_Inverted) or (self.AnimCycle == 1 and self.Akimbo_Inverted)) then
			typev, tanim = self:ChooseAnimation("shoot2")
		elseif self:GetIronSights() and self:Clip1() == 2 and self.Primary.ClipSize >= 1 then
			typev, tanim = self:ChooseAnimation("shoot1_is_midempty")
		elseif self:GetIronSights() and self:GetActivityEnabled(ACT_VM_PRIMARYATTACK_1) then
			typev, tanim = self:ChooseAnimation("shoot1_is")
		elseif self:Clip1() == 2 and self.Primary.ClipSize >= 1 then
			typev, tanim = self:ChooseAnimation("shoot1_midempty")
		else
			typev, tanim = self:ChooseAnimation("shoot1")
		end

		if typev ~= TFA.Enum.ANIMATION_SEQ then
			return self:SendViewModelAnim(tanim)
		else
			return self:SendViewModelSeq(tanim)
		end
	else
		if game.SinglePlayer() and SERVER then
			self:CallOnClient("BlowbackFull", "")
		end

		if ifp then
			self:BlowbackFull(ifp)
		end

		if ifp or game.SinglePlayer() then
			self:EventShell()
		end

		self:SendViewModelAnim(ACT_VM_BLOWBACK)

		return true, ACT_VM_IDLE
	end
end

function SWEP:ChooseIdleAnim()
	if not self:VMIV() then return end
	--if self.Idle_WithHeld then
	--	self.Idle_WithHeld = nil
	--	return
	--end
	if self.Idle_Mode ~= TFA.Enum.IDLE_BOTH and self.Idle_Mode ~= TFA.Enum.IDLE_ANI then return end

	--self:ResetEvents()
	if self:GetIronSights() then
		if self.Sights_Mode == TFA.Enum.LOCOMOTION_LUA then
			return self:ChooseFlatAnim()
		else
			return self:ChooseADSAnim()
		end
	elseif self:GetSprinting() and self.Sprint_Mode ~= TFA.Enum.LOCOMOTION_LUA then
		return self:ChooseSprintAnim()
	elseif self:GetWalking() and self.Walk_Mode ~= TFA.Enum.LOCOMOTION_LUA then
		return self:ChooseWalkAnim()
	end

	if self:GetActivityEnabled(ACT_VM_IDLE_SILENCED) and self:GetSilenced() then
		typev, tanim = self:ChooseAnimation("idle_silenced")
	elseif (self.Primary.ClipSize > 0 and self:Clip1() == 0) or (self.Primary.ClipSize <= 0 and self:Ammo1() == 0) then
		--self:GetActivityEnabled( ACT_VM_IDLE_EMPTY ) and (self:Clip1() == 0) then
		if self:GetActivityEnabled(ACT_VM_IDLE_EMPTY) or self.HasCustomIdle == true then
			typev, tanim = self:ChooseAnimation("idle_empty")
		else --if not self:GetActivityEnabled( ACT_VM_PRIMARYATTACK_EMPTY ) then
			typev, tanim = self:ChooseAnimation("idle")
		end
	elseif (self.Primary.ClipSize > 0 and self:Clip1() == 1) or (self.Primary.ClipSize <= 0 and self:Ammo1() == 1) then
		typev, tanim = self:ChooseAnimation("idle_midempty")
	else
		typev, tanim = self:ChooseAnimation("idle")
	end

	--else
	--	return
	--end
	if typev ~= TFA.Enum.ANIMATION_SEQ then
		return self:SendViewModelAnim(tanim)
	else
		return self:SendViewModelSeq(tanim)
	end
end

function SWEP:ChooseFlatAnim()
	if not self:VMIV() then return end
	--self:ResetEvents()
	typev, tanim = self:ChooseAnimation("idle")

	if self:GetActivityEnabled(ACT_VM_IDLE_SILENCED) and self:GetSilenced() then
		typev, tanim = self:ChooseAnimation("idle_silenced")
	elseif self:Clip1() == 0 then
		--self:GetActivityEnabled( ACT_VM_IDLE_EMPTY ) and (self:Clip1() == 0) then
		typev, tanim = self:ChooseAnimation("idle_empty")
	elseif (self.Primary.ClipSize > 0 and self:Clip1() == 1) or (self.Primary.ClipSize <= 0 and self:Ammo1() == 1) then
		typev, tanim = self:ChooseAnimation("idle_midempty")
	end

	if typev ~= TFA.Enum.ANIMATION_SEQ then
		return self:SendViewModelAnim(tanim, 0.000001)
	else
		return self:SendViewModelSeq(tanim, 0.000001)
	end
end

function SWEP:ChooseDrawAnim()
	if not self:VMIV() then return end
	--self:ResetEvents()
	tanim = ACT_VM_DRAW
	success = true

	if self.IsFirstDeploy and CurTime() > (self.LastDeployAnim or CurTime()) + 0.1 then
		self.IsFirstDeploy = false
	end

	if self:GetActivityEnabled(ACT_VM_DRAW_EMPTY) and (self:Clip1() == 0) then
		typev, tanim = self:ChooseAnimation("draw_empty")
	elseif (self:GetActivityEnabled(ACT_VM_DRAW_DEPLOYED) or self.FirstDeployEnabled) and self.IsFirstDeploy then
		typev, tanim = self:ChooseAnimation("draw_first")
	elseif self:GetActivityEnabled(ACT_VM_DRAW_SILENCED) and self:GetSilenced() then
		typev, tanim = self:ChooseAnimation("draw_silenced")
	elseif (self:Clip1() == 1) then
		typev, tanim = self:ChooseAnimation("draw_midempty")
	else
		typev, tanim = self:ChooseAnimation("draw")
	end

	self.LastDeployAnim = CurTime()

	if typev ~= TFA.Enum.ANIMATION_SEQ then
		return self:SendViewModelAnim(tanim)
	else
		return self:SendViewModelSeq(tanim)
	end
end

function SWEP:ChooseHolsterAnim()
	if not self:VMIV() then return end

	if self:GetActivityEnabled(ACT_VM_HOLSTER_SILENCED) and self:GetSilenced() then
		typev, tanim = self:ChooseAnimation("holster_silenced")
	elseif self:GetActivityEnabled(ACT_VM_HOLSTER_EMPTY) and (self:Clip1() == 0) then
		typev, tanim = self:ChooseAnimation("holster_empty")
	elseif (self:Clip1() == 1) then
		typev, tanim = self:ChooseAnimation("holster_midempty")
	elseif self:GetActivityEnabled(ACT_VM_HOLSTER) then
		typev, tanim = self:ChooseAnimation("holster")
	else
		local _
		_, tanim = self:ChooseIdleAnim()

		return false, tanim
	end

	if typev ~= TFA.Enum.ANIMATION_SEQ then
		return self:SendViewModelAnim(tanim)
	else
		return self:SendViewModelSeq(tanim)
	end
end

function SWEP:ChooseReloadAnim()
	if not self:VMIV() then return false, 0 end
	if self.ProceduralReloadEnabled then return false, 0 end
	
	if self:GetActivityEnabled(ACT_VM_RELOAD_SILENCED) and self:GetSilenced() then
		typev, tanim = self:ChooseAnimation("reload_silenced")
	elseif self:GetActivityEnabled(ACT_VM_RELOAD_EMPTY) and (self:Clip1() == 0 or self:IsJammed())and not self.Shotgun then
		typev, tanim = self:ChooseAnimation("reload_empty")
	elseif (self:Clip1() == 1) and (self:Ammo1() > 1) then
		typev, tanim = self:ChooseAnimation("reload_midempty")
	else
		typev, tanim = self:ChooseAnimation("reload")
	end
	
	if (self:Clip1() == 0 and self:Ammo1() == 1) then
		typev, tanim = self:ChooseAnimation("reload_lastcapsule")
	end

	local fac = 1

	if self.Shotgun and self.ShellTime then
		fac = self.ShellTime
	end

	self.AnimCycle = 0

	if SERVER and game.SinglePlayer() then
		self.SetNW2Int = self.SetNW2Int or self.SetNWInt
		self:SetNW2Int("AnimCycle", self.AnimCycle)
	end

	if typev ~= TFA.Enum.ANIMATION_SEQ then
		return self:SendViewModelAnim(tanim, fac, fac ~= 1)
	else
		return self:SendViewModelSeq(tanim, fac, fac ~= 1)
	end
end

function SWEP:ChooseInspectAnim()
	if not self:VMIV() then return end

	if self:GetActivityEnabled(ACT_VM_FIDGET_SILENCED) and self:GetSilenced() then
		typev, tanim = self:ChooseAnimation("inspect_silenced")
	elseif self:GetActivityEnabled(ACT_VM_FIDGET) and self.Primary.ClipSize > 0 and math.Round(self:Clip1()) == 0 then
		typev, tanim = self:ChooseAnimation("inspect_empty")
	elseif self.InspectionActions then
		tanim = self.InspectionActions[self:SharedRandom(1, #self.InspectionActions, "Inspect")]
	elseif self:GetActivityEnabled(ACT_VM_FIDGET) and self.Primary.ClipSize > 0 and (self:Clip1()  == 1) then
		typev, tanim = self:ChooseAnimation("inspect_midempty" .. math.random(1,2))
	elseif self:GetActivityEnabled(ACT_VM_FIDGET) then
		typev, tanim = self:ChooseAnimation("inspect")
	else
		typev, tanim = self:ChooseAnimation("idle")
		success = false
	end

	if typev ~= TFA.Enum.ANIMATION_SEQ then
		return self:SendViewModelAnim(tanim)
	else
		return self:SendViewModelSeq(tanim)
	end
end

function SWEP:PreDrawViewModel(...)
	local vm = self.Owner:GetViewModel()
		if self.Charging == true then
			vm:SetSkin( 1 )
		else
			vm:SetSkin( 0 )
		end
	return BaseClass.PreDrawViewModel(self,...)
end

function SWEP:ChooseChargeAnim( ifp )

	if !self:OwnerIsValid() then return end

	local tanim = "Shake"
	local success = true
	
	if self:Clip1() == 1 then
		tanim = "Shake_midempty"
	elseif self:Clip1() == 0 then
		tanim = "Shake_empty"
	else
		tanim = "Shake"
	end
	
	self:SendViewModelSeq(tanim)

	if game.SinglePlayer() then
		self:CallOnClient("AnimForce",tanim)
	end

	self.lastact = tanim
	return success, tanim

end

--[[

ResponseContext	=
TeamNum	=	0
ballcount	=	0
ballradius	=	20
ballrespawntime	=	0
bullseyename	=
classname	=	point_combine_ball_launcher
damagefilter	=
effects	=	0
friction	=	1
globalname	=
gravity	=	0
hammerid	=	0
health	=	0
launchconenoise	=	0
ltime	=	0
max_health	=	0
maxballbounces	=	0
maxspeed	=	0
minspeed	=	0
modelindex	=	0
parentname	=
renderfx	=	0
rendermode	=	0
shadowcastdist	=	0
spawnflags	=	0
speed	=	0
target	=
texframeindex	=	0
waterlevel	=	0

]]

function SWEP:CanSecondaryAttack()
	
	if self:Ammo2() < 1 then
		if not self.HasPlayedEmptyClick then
			self:EmitSound("Weapon_AR2.Empty")

			self.HasPlayedEmptyClick = true
		end
		return false
	end
	
	if self.FiresUnderwater == false and self:GetOwner():WaterLevel() >= 3 then
		self:SetNextSecondaryFire(CurTime() + 0.5)
		self:EmitSound("Weapon_AR2.Empty")
		return false
	else
		return true
	end
end

function SWEP:AltAttack()

	if CurTime()<self:GetNextSecondaryFire() then return end
	if self:Ammo2()<=0 then return end
	if not self:CanSecondaryAttack() then return end

	if !self:OwnerIsValid() then return end
	self:EmitSound("Project_MMOD_AR2.Charge")
	local succ,tanim = self:ChooseChargeAnim()
	local vm = self.Owner:GetViewModel()

	local chargedelay = vm:SequenceDuration( tanim )

	if IsFirstTimePredicted() then

		local fx = EffectData()
		fx:SetEntity(self)
		fx:SetAttachment(3)
		fx:SetOrigin(self.Owner:GetShootPos())
		fx:SetNormal(self.Owner:GetAimVector())
		util.Effect( self.ChargeMuzzleFlashEffect, fx )
	end

	if SERVER then
		timer.Simple(chargedelay,function()
			if IsValid(self) and self:OwnerIsValid() then
			
				local tanim = "fire_alt"
			
				if self:Clip1() == 1 then
					tanim = "fire_alt_midempty"
				elseif self:Clip1() == 0 then
					tanim = "fire_alt_empty"
				else
					tanim = "fire_alt"
				end
				
				self:SendViewModelSeq(tanim)
				
				self:EmitSound("Project_MMOD_AR2.SecondaryFire")

				self:TakeSecondaryAmmo(1)

				local spawner = ents.Create("point_combine_ball_launcher")
				spawner:SetPos(self.Owner:GetShootPos())
				spawner:SetAngles(self.Owner:EyeAngles())
				spawner:SetOwner(self.Owner)

				spawner:SetKeyValue("speed",tostring(self.Secondary.Velocity))
				spawner:SetKeyValue("minspeed",tostring(self.Secondary.Velocity))
				spawner:SetKeyValue("maxspeed",tostring(self.Secondary.Velocity))
				spawner:SetKeyValue("maxballbounces","10")
				spawner:SetKeyValue("ltime","5")
				spawner:SetKeyValue("ballcount","0")

				self.Owner:ViewPunch(Angle(-self.Secondary.Recoil,self.Secondary.Recoil/4,self.Secondary.Recoil/6))

				spawner:Spawn()
				spawner:Activate()

    			spawner:Fire( "LaunchBall", "", 0 )
				
				SafeRemoveEntityDelayed(spawner,0.1)

				--[[
				local pBall = ents.Create( "prop_combine_ball" )
				pBall:SetOwner( self.Owner )
				pBall:SetPhysicsAttacker( self.Owner )
				pBall:SetPos( self.Owner:GetShootPos() )

				pBall:SetKeyValue("health","50")
				--pBall:SetKeyValue("speed",tostring(self.Secondary.Velocity))
				pBall:SetKeyValue("modelscale","1")

				pBall:SetVelocity( vel )
				pBall:Spawn()

				pBall:GetPhysicsObject():AddGameFlag( FVPHYSICS_DMG_DISSOLVE )
				pBall:GetPhysicsObject():AddGameFlag( FVPHYSICS_WAS_THROWN )
				pBall:GetPhysicsObject():SetVelocity( vel )
				pBall:EmitSound( "NPC_CombineBall.Launch" )
				pBall:SetModel( "models/Effects/combineball.mdl" )
				]]--

				local fx1 = EffectData()
				fx1:SetEntity(self)
				fx1:SetAttachment(3)
				fx1:SetOrigin(self.Owner:GetShootPos())
				fx1:SetNormal(self.Owner:GetAimVector())
				util.Effect( self.SecondaryMuzzleFlash, fx1 )

				self:SetNextIdleAnim( CurTime() + 1.8 )

			end
		end)
	end

	self:SetNextIdleAnim( CurTime() + chargedelay )

	self:SetNextSecondaryFire( CurTime() + 80/self.Secondary.RPM )
end

function SWEP:SetupDataTables()
	BaseClass.SetupDataTables( self )
	self:NetworkVar("Bool", 4, "ChargeAppear")
end

function SWEP:Initialize()
	BaseClass.Initialize( self )
	self:SetChargeAppear(true)
end

function SWEP:Think2()
	local nsfac = self:GetNW2Int("FireCount") + 1

	if self:GetStatus() == TFA.GetStatus("idle") then
		if not self.LastIdleTime then
			self.LastIdleTime = CurTime()
		elseif CurTime() > self.LastIdleTime + 0.1 then
			self:SetNW2Int("FireCount", 0)
		end
	else
		self.LastIdleTime = nil
	end

	BaseClass.Think2( self )
	
	if CLIENT then
	
		local chargebone = self:GetOwner():GetViewModel():LookupBone("chargemag")

		if self:GetChargeAppear() == false and chargebone ~= nil then
			self:GetOwner():GetViewModel():ManipulateBonePosition(chargebone, Vector(0,0,-5))
		elseif chargebone ~= nil then
			self:GetOwner():GetViewModel():ManipulateBonePosition(chargebone, Vector(0,0,0))
		end
	
	end

	if IsValid(self.Owner) and self:Clip1() <= 0  and self.Primary.ClipSize > 0 then
		self:Reload(true)
		end
		BaseClass.Think2(self)
	
end
	