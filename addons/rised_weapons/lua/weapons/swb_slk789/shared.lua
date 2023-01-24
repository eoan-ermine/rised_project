-- "addons\\rised_weapons\\lua\\weapons\\swb_slk789\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.AimPos = Vector(-2.25, 0.563, 0.7)
	SWEP.AimAng = Vector(0.1, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 1.442, 2)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.ViewModelMovementScale = 1.15
		
	language.Add("weapon_metropolice_oicw", "Metropolice OICW")
	killicon.Add( "weapon_metropolice_oicw", "effects/killicons/weapon_metropolice_oicw", color_white )
	SWEP.SelectIcon = surface.GetTextureID("HUD/swepicons/weapon_sniper") 
	
	SWEP.MuzzleEffect = "swb_rifle_med"
	
	SWEP.DrawWeaponInfoBox	= false
	SWEP.BounceWeaponIcon = false
	
	SWEP.DrawBlackBarsOnAim = true
	SWEP.AimOverlay = surface.GetTextureID("effects/scope/scope_overlay.vmt")
	SWEP.StretchOverlayToScreen = true
	SWEP.ZoomAmount = 80
	SWEP.DelayedZoom = true
	SWEP.SnapZoom = true
	SWEP.AdjustableZoom = false
	SWEP.MinZoom = 80
	SWEP.MaxZoom = 80
end

SWEP.PrintName = "Sl-k.789"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_slk789"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_slk789"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_slk789"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_slk789"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_slk789"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_slk789"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_slk789"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_slk789"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_slk789"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_slk789"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_slk789"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_slk789"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_slk789"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = "weapons/1sniper/sniper_reload.wav"
SWEP.FireSound 		= "weapons/1sniper/sniper_fire.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/uni_lean_in_02.wav"
SWEP.AimSound 		= "sniper_military_zoom.wav"
/////// SOUND ///////

SWEP.ReloadType = "Sniper"
SWEP.AimSound = "sniper_military_zoom.wav"
SWEP.PlayBackRate = 30
SWEP.PlayBackRateSV = 12
SWEP.SpeedDec = 30
SWEP.BulletDiameter = 7.62
SWEP.CaseLength = 39

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = true
SWEP.AllowDrop = true
SWEP.UseHands = false

SWEP.Slot = 3
SWEP.SlotPos = 4
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "swb_base"
SWEP.Category = "A - Rised - [Оружие]"
SWEP.Tracer = "AirboatGunTracer"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/rtb_weapons/v_sniper.mdl"
SWEP.WorldModel		= "models/rtb_weapons/w_sniper.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "10,3x77_ammo"

SWEP.FireDelay = 60/SWEP.RPM