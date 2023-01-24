-- "addons\\rised_weapons\\lua\\weapons\\swb_ismg\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.FadeCrosshairOnAim = true
	
	SWEP.AimPos = Vector(-4.65, 1.346, -0.7)
	SWEP.AimAng = Vector (0.5, 0, 0)
	
	SWEP.SprintPos = Vector(9.071, 0, 1.6418)
	SWEP.SprintAng = Vector(-12.9765, 26.8708, 0)
	
	SWEP.IconLetter = "l"
	SWEP.IconFont = "WeaponIcons"
	
	SWEP.MuzzleEffect = "swb_rifle_med"
end

SWEP.PrintName = "Impulse SMG"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_ismg"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_ismg"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_ismg"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_ismg"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_ismg"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_ismg"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_ismg"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_ismg"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_ismg"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_ismg"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_ismg"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_ismg"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_ismg"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= "grunt_fire.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/uni_lean_in_04.wav"
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
SWEP.FireModes = {"auto", "semi"}
SWEP.Category = "A - Rised - [Оружие]"

SWEP.Author			= "aStonedPenguin"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModel 			= "models/weapons/c_ipistol.mdl"
SWEP.WorldModel 		= "models/hlvr/weapons/ipistol/w_ipistol_hlvr.mdl"

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * 0.8 + HAng:Forward() * 6 + HAng:Up() * -2.5

		HAng:RotateAroundAxis(HAng:Right(), 0)
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
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "AR2"

SWEP.FireDelay = 60/SWEP.RPM
SWEP.ReloadStartWait = 1.3

SWEP.Tracer = 'AR2Tracer'