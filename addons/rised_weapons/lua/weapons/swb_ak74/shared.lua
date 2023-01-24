-- "addons\\rised_weapons\\lua\\weapons\\swb_ak74\\shared.lua"
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
	
	SWEP.IconLetter = "b"
	killicon.AddFont("swb_ak47", "SWB_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "swb_rifle_med"
end

SWEP.PrintName = "AK-74"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_ak74"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_ak74"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_ak74"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_ak74"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_ak74"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_ak74"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_ak74"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_ak74"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_ak74"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_ak74"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_ak74"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_ak74"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_ak74"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound		= "weapons/ak74/ak74_tp.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/uni_weapon_draw_03.wav"
SWEP.AimSound 		= "rised/weapons/aim/rifle/uni_ads_in_0" .. math.random(1,6) .. ".wav"
/////// SOUND ///////

SWEP.ReloadType = "Another"
SWEP.PlayBackRate = 30
SWEP.PlayBackRateSV = 12
SWEP.SpeedDec = 30
SWEP.BulletDiameter = 7.62
SWEP.CaseLength = 39
SWEP.ReloadSpeed = 2

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = true
SWEP.AllowDrop = true

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "swb_base"
SWEP.Category = "A - Rised - [Оружие]"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel = "models/weapons/insurgency/v_ak74.mdl"
SWEP.WorldModel = "models/weapons/insurgency/w_ak74.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5,45x39_ammo"

SWEP.FireDelay = 60/SWEP.RPM

if CLIENT then
	caca = ClientsideModel( "models/weapons/insurgency/upgrades/a_standard_ak74.mdl", RENDERGROUP_VIEWMODEL )
end
function SWEP:DrawModels()
	if CLIENT then
		local vm = self.Owner:GetViewModel()
		caca:SetPos( vm:GetPos() )
		caca:SetAngles( vm:GetAngles() )
		caca:AddEffects( EF_BONEMERGE )
		caca:SetNoDraw( true )
		caca:SetParent( vm )
		caca:DrawModel()
	end
end

function SWEP:ViewModelDrawn()
if CLIENT then
if not( self.Hands ) then
self:DrawModels()
end
if not( caca ) then
self:DrawModels()
end
if caca then
caca:DrawModel()
end
end
end