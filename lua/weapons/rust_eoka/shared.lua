-- "lua\\weapons\\rust_eoka\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base = "tfa_gun_base"

SWEP.PrintName = "Eoka Pistol"
SWEP.Author = "Darky"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""

SWEP.Category = "TFA Rust Weapons"

SWEP.Spawnable= true
SWEP.AdminSpawnable= true
SWEP.AdminOnly = false
SWEP.CSMuzzleFlashes = false
SWEP.MuzzleFlashEffect = nil

SWEP.MuzzleAttachment			= "0"						-- "1" CSS models / "muzzle" hl2 models
SWEP.ShellAttachment			= "1"						-- "2" CSS models / "shell" hl2 models
SWEP.MuzzleFlashEnabled 		= true



SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 60
SWEP.Secondary.IronFOV = 60
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/darky_m/rust/c_eoka.mdl"
SWEP.WorldModel = "models/weapons/darky_m/rust/w_eoka.mdl"

SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true

SWEP.IronSightsPos = Vector(-4.511, 0.019, 3.92)
SWEP.IronSightsAng = Vector(0, 0, 0)


SWEP.RunSightsPos = Vector(1.222, 0, -1.415)
SWEP.RunSightsAng = Vector(-16.848, -1.236, -3.247)

SWEP.Attachments = {
	[1] = {atts = {"darky_rust_12gauge","darky_rust_12slug","darky_rust_12incendiary"}},
}


SWEP.VElements = {
}



SWEP.RTOpaque	= true
SWEP.LaserDistance = 4000
SWEP.LaserDistanceVisual = 4000


SWEP.Type = "Shotgun"

SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.Slot = 5
SWEP.SlotPos = 74
 
SWEP.UseHands = true

SWEP.FiresUnderwater = true

SWEP.DrawCrosshair = true

SWEP.DrawAmmo = true

SWEP.ReloadSound = ""

SWEP.BoltAction = false 


SWEP.Primary.IronAccuracy_SG = .075

SWEP.Primary.KickUp = 2.2 -- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown = 2.1 -- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal = 0.05 -- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.5 --Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.
--Firing Cone Related
SWEP.Primary.Spread = .15 --This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.Primary.IronAccuracy = .15 -- Ironsight accuracy, should be the same for shotguns
--Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and remove this line.
SWEP.Primary.SpreadMultiplierMax = 4 --How far the spread can expand when you shoot. Example val: 2.5
SWEP.Primary.SpreadIncrement = 0.25 --What percentage of the modifier is added on, per shot.  Example val: 1/3.5
SWEP.Primary.SpreadRecovery = 5 --How much the spread recovers, per second. Example val: 3
--Range Related
SWEP.Primary.Range = (980 * 1) -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = 0.2 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.
--Misc
SWEP.CrouchAccuracyMultiplier = 0.8 --Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
--Movespeed
SWEP.MoveSpeed = 0.8 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.75 --Multiply the player's movespeed by this when sighting.
-- Selective Fire Stuff
SWEP.SelectiveFire = false --Allow selecting your firemode?
SWEP.DisableBurstFire = true --Only auto/single?
SWEP.OnlyBurstFire = false --No auto, only burst/single?

SWEP.IronSightTime = 0.4

SWEP.VMPos = Vector(0, 0, 0)
SWEP.VMAng = Vector(0,0,0)
SWEP.VMPos_Additive = false --Set to false for an easier time using VMPos. If true, VMPos will act as a constant delta ON TOP OF ironsights, run, whateverelse

SWEP.Primary.Sound = "darky_rust.eoka-pistol-attack" -- This is the sound of the weapon, when you shoot.

SWEP.Primary.Damage = 180/20
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.NumShots = 20
SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Recoil = 1
SWEP.Primary.RPM = 100
SWEP.Primary.Force = 1

SWEP.Secondary.ClipSize = 0
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.SequenceLengthOverride = {
	[ACT_VM_PRIMARYATTACK] = 0.5
}

	-- [ Iron_Sights ]
	SWEP.data 					= {}
	SWEP.data.ironsights 			= 0
	SWEP.Secondary.IronFOV 		= 60
	SWEP.IronSightsSensitivity 		= 1							-- 0.XX = XX%
						-- Scale of the reticle overlay





--[[INSPECTION]]--
-- SWEP.InspectPos = Vector(0, -4, -10)
-- SWEP.InspectAng = Vector(45, 0, 0)
SWEP.InspectPos = nil
SWEP.InspectAng = nil

--[[SPRINTING]]--
SWEP.RunSightsPos = Vector(0, 0, 2.131)
SWEP.RunSightsAng = Vector(-13.771, 0, 0)

SWEP.Sights_Mode = TFA.Enum.ANI -- ANI = mdl, HYBRID = lua but continue idle, Lua = stop mdl animation
SWEP.Sprint_Mode = TFA.Enum.Lua -- ANI = mdl, HYBRID = ani + lua, Lua = lua only
SWEP.Idle_Mode = TFA.Enum.IDLE_BOTH --TFA.Enum.IDLE_DISABLED = no idle, TFA.Enum.IDLE_LUA = lua idle, TFA.Enum.IDLE_ANI = mdl idle, TFA.Enum.IDLE_BOTH = TFA.Enum.IDLE_ANI + TFA.Enum.IDLE_LUA
SWEP.Idle_Blend = 0.25 --Start an idle this far early into the end of a transition
SWEP.Idle_Smooth = 0.05 --Start an idle this far early into the end of another animation

SWEP.ShellAttachment			 = "shell" 		              -- Should be "2" for CSS models or "shell" for hl2 models
SWEP.MuzzleAttachment			 = "0" 	              -- Should be "1" for CSS models or "muzzle" for hl2 models
SWEP.MuzzleFlashEnabled          = true                       -- Enable muzzle flash
SWEP.MuzzleFlashEffect           = "tfa_muzzleflash_shotgun"
SWEP.MuzzleAttachmentRaw         = nil                        -- This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.AutoDetectMuzzleAttachment  = false                      -- For multi-barrel weapons, detect the proper attachment?
SWEP.SmokeParticle               = nil                        -- Smoke particle (ID within the PCF), defaults to something else based on holdtype; "" to disable
SWEP.EjectionSmokeEnabled        = false
SWEP.DisableChambering = true
-- Shell eject override
SWEP.LuaShellEject               = false                      -- Enable shell ejection through lua?
SWEP.LuaShellEjectDelay          = 0
SWEP.LuaShellScale = 2
SWEP.LuaShellModel = "models/weapons/darky_m/rust/shotgun_shell_handmade.mdl"
SWEP.LuaShellEffect              = "RifleShellEject"          -- The effect used for shell ejection; Defaults to that used for blowback
-- SWEP.LuaShellYaw = 180
-- Tracer Stuff
SWEP.TracerName 		         = nil 	                      -- Change to a string of your tracer name.  Can be custom. There is a nice example at https://github.com/garrynewman/garrysmod/blob/master/garrysmod/gamemodes/base/entities/effects/tooltracer.lua
SWEP.TracerCount  = 0 	

SWEP.IronAnimation = {
}

SWEP.SequenceLengthOverride = {
	[ACT_VM_PRIMARYATTACK] = 0.5
}

SWEP.ShellMaterial = 4

SWEP.MaterialTable_V = {
	[SWEP.ShellMaterial] = "models/darky_m/rust_weapons/sawnoffshotgun/Shotgunshell_handmade",
}
-- shit below

DEFINE_BASECLASS(SWEP.Base)

function SWEP:Initialize()
	self:SetNW2Int("TrueStrike", 5)
	self:SetNW2Int("Strike", 0)
	BaseClass.Initialize(self)
end

function SWEP:Scrape(ent)
	local strike = self:GetNW2Int("Strike")
	self:SetNW2Int("Strike", strike + 1)
	
	self.Owner:DoAnimationEvent( ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN )
	if strike + 1 == self:GetNW2Int("TrueStrike") then
		self:SetStatus(TFA.Enum.STATUS_SHOOTING, CurTime())
		self:PrimaryAttack()
		self.Owner:DoAnimationEvent( ACT_HL2MP_GESTURE_RANGE_ATTACK_CROSSBOW )
	end

	if CLIENT then
		local effectdata = EffectData()
		effectdata:SetEntity(ent)
		effectdata:SetAttachment(2)
		effectdata:SetScale(0.1)
		util.Effect("CrossbowLoad", effectdata)
	else
		self.Owner:ViewPunch(Angle(2, 0, 0))
	end
end

SWEP.EventTable = {
	[ACT_VM_SECONDARYATTACK] = {
		{ ["time"] = 16/40, ["type"] = "lua", ["value"] = function(wep, vm)
			wep:Scrape(vm)
		end, ["client"] = true, ["server"] = true },

		{ ["time"] = 33/40, ["type"] = "lua", ["value"] = function(wep, vm)
			wep:Scrape(vm)
		end, ["client"] = true, ["server"] = true },

		{ ["time"] = 52/40, ["type"] = "lua", ["value"] = function(wep, vm)
			wep:Scrape(vm)
		end, ["client"] = true, ["server"] = true },

		{ ["time"] = 73/40, ["type"] = "lua", ["value"] = function(wep, vm)
			wep:Scrape(vm)
		end, ["client"] = true, ["server"] = true },

		{ ["time"] = 92/40, ["type"] = "lua", ["value"] = function(wep, vm)
			wep:Scrape(vm)
		end, ["client"] = true, ["server"] = true },
	},
}




function SWEP:PrimaryAttack()
	return BaseClass.PrimaryAttack(self)
end

function SWEP:Think2(...)
	local owner = self:GetOwner()
	if owner:IsPlayer() then
		if owner:KeyDown(IN_ATTACK) then
			if self:CanPrimaryAttack() then
				if self:GetStatus() == 0 then
					self:SetStatus(TFA.Enum.STATUS_GRENADE_PULL, CurTime()+2.62)
					self:SendViewModelAnim(ACT_VM_SECONDARYATTACK)
					if SERVER then
						self:SetNW2Int("Strike", 0)
						self:SetNW2Int("TrueStrike", math.random(1,5))
					end
				end
			end
		else
			if self:GetStatus() == TFA.Enum.STATUS_GRENADE_PULL then
				self:SetStatus(0, CurTime()+2)
				self:SetNW2Int("Strike", 0)
				self:SendViewModelAnim(ACT_VM_IDLE)
			end
		end
	end

	return BaseClass.Think2(self, ...)
end
