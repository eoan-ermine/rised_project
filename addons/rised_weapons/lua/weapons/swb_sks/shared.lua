-- "addons\\rised_weapons\\lua\\weapons\\swb_sks\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.AimPos = Vector(-2.7, 1.646, 1.6)
	SWEP.AimAng = Vector(0, 0, 0)
		
	SWEP.SprintPos = Vector (3, 0, 1.5)
	SWEP.SprintAng = Vector (-13, 27, 0)
	
	SWEP.IconLetter = "o"
	SWEP.IconFont = "WeaponIcons"
	
	SWEP.MuzzleEffect = "swb_rifle_med"
end

SWEP.PrintName = "СКС"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_sks"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_sks"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_sks"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_sks"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_sks"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_sks"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_sks"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_sks"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_sks"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_sks"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_sks"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_sks"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_sks"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= "weapons/SKS/SKS_TP.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/uni_weapon_draw_03.wav"
SWEP.AimSound 		= "rised/weapons/aim/rifle/uni_ads_in_0" .. math.random(1,6) .. ".wav"
/////// SOUND ///////

SWEP.ReloadType = "Another"
SWEP.PlayBackRate = 1
SWEP.PlayBackRateSV = 1
SWEP.FadeCrosshairOnAim = true
SWEP.PreventQuickScoping = true

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = true
SWEP.AllowDrop = true

SWEP.SpeedDec = 30
SWEP.BulletDiameter = 5.56
SWEP.CaseLength = 45

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "swb_base"
SWEP.Category = "A - Rised - [Оружие]"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel = "models/weapons/insurgency/v_sks.mdl"
SWEP.WorldModel = "models/weapons/insurgency/w_sks.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7,62x39_ammo"

SWEP.FireDelay = 60/SWEP.RPM