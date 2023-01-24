-- "addons\\rised_weapons\\lua\\weapons\\swb_oicw\\shared.lua"
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
	SWEP.SelectIcon = surface.GetTextureID("HUD/swepicons/metropolice_oicw_icon")
	
	SWEP.MuzzleEffect = "swb_rifle_med"
	
	SWEP.DrawWeaponInfoBox	= false
	SWEP.BounceWeaponIcon = false
	
	SWEP.DrawBlackBarsOnAim = true
	SWEP.AimOverlay = surface.GetTextureID("effects/scope/scope_overlay.vmt")
	SWEP.StretchOverlayToScreen = true
	SWEP.ZoomAmount = 70
	SWEP.DelayedZoom = true
	SWEP.SnapZoom = true
	SWEP.AdjustableZoom = true
	SWEP.MinZoom = 70
	SWEP.MaxZoom = 90
end

SWEP.PrintName = "OICW"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_oicw"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_oicw"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_oicw"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_oicw"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_oicw"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_oicw"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_oicw"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_oicw"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_oicw"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_oicw"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_oicw"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_oicw"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_oicw"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = "weapons/metropolice_smg/oicw/oicw_reload.wav"
SWEP.FireSound 		= "weapons/metropolice_smg/oicw/oicw_shoot.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/uni_gl_beginreload_02.wav"
SWEP.AimSound 		= "sniper_military_zoom.wav"
SWEP.SimpleReloadSoundType = true
/////// SOUND ///////

SWEP.ReloadType = "Another_NoEmptyAnimation"
SWEP.PlayBackRate = 30
SWEP.PlayBackRateSV = 12
SWEP.SpeedDec = 30
SWEP.BulletDiameter = 7.62
SWEP.CaseLength = 39
SWEP.MuzzlePosMod = Vector(6, 50, -7)
SWEP.RisedAimMuzzle = true

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = true
SWEP.AllowDrop = true
SWEP.UseHands = false

SWEP.Slot = 2
SWEP.SlotPos = 4
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "swb_base"
SWEP.Category = "A - Rised - [Оружие]"
SWEP.Tracer = "AirboatGunTracer"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel = "models/weapons/metropolice_smg/oicw/v_oicw.mdl"
SWEP.WorldModel = "models/weapons/metropolice_smg/oicw/w_oicw.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5,45x39_ammo"

SWEP.FireDelay = 60/SWEP.RPM