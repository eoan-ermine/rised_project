-- "addons\\rised_weapons\\lua\\weapons\\swb_irifle\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = false
	SWEP.FadeCrosshairOnAim = true
	
	SWEP.AimPos = Vector(-3.17, -3, 0.1)
	SWEP.AimAng = Vector (2.2, 0, 0)

	
	SWEP.SprintPos = Vector(9.071, 3, 1.6418)
	SWEP.SprintAng = Vector(-12.9765, 26.8708, 0)
	
	SWEP.IconLetter = "l"
	SWEP.IconFont = "WeaponIcons"
	
	SWEP.MuzzleEffect = "swb_silenced_small"
end

SWEP.PrintName = "Impulse Rifle"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_irifle"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_irifle"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_irifle"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_irifle"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_irifle"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_irifle"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_irifle"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_irifle"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_irifle"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_irifle"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_irifle"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_irifle"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_irifle"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = ("Weapon_AR2.Reload")
SWEP.FireSound 		= Sound("Weapon_AR2.Single")
SWEP.DeploySound 	= "rised/weapons/deploy/uni_gl_beginreload_02.wav"
SWEP.AimSound 		= "rised/weapons/aim/rifle/uni_ads_in_0" .. math.random(1,6) .. ".wav"
/////// SOUND ///////

SWEP.ReloadType = "Another_NoEmptyAnimation"
SWEP.Base = 'swb_base'
SWEP.PlayBackRate = 30
SWEP.PlayBackRateSV = 12
SWEP.SpeedDec = 15
SWEP.BulletDiameter = 9
SWEP.CaseLength = 19

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = true
SWEP.AllowDrop = true

SWEP.Slot = 2
SWEP.SlotPos = 1
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi", "safe"}
SWEP.Category = "A - Rised - [Оружие]"

SWEP.Author			= "aStonedPenguin"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 60
SWEP.ViewModel 			= "models/weapons/c_ordinalrifle.mdl"
SWEP.WorldModel 		= "models/weapons/w_ordinalrifle.mdl"

SWEP.VElements = {
	["gun"] = { type = "Model", model = "models/props_combine/bunker_gun01.mdl", bone = "Base", rel = "", pos = Vector(0.824, 10.522, 8.258), angle = Angle(84.111, -59.021, -31.281), size = Vector(0.754, 0.754, 0.754), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["gun"] = { type = "Model", model = "models/props_combine/bunker_gun01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16.528, 0.351, 12.041), angle = Angle(0, 0, -180), size = Vector(1.177, 1.177, 1.177), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * 0.8 + HAng:Forward() * 9.9 + HAng:Up() * 0

		HAng:RotateAroundAxis(HAng:Right(), -1)
		HAng:RotateAroundAxis(HAng:Forward(),  180)
		HAng:RotateAroundAxis(HAng:Up(), 0)
		
		self:SetRenderOrigin(HPos + offset)
		self:SetRenderAngles(HAng)

		self:DrawModel()
	end
end
	
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Reload 		= ("Weapon_AR2.Reload")
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AR2"

SWEP.FireDelay = 60/SWEP.RPM

SWEP.Tracer = 'AR2Tracer'