-- "addons\\rised_weapons\\lua\\weapons\\swb_lmg\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.FadeCrosshairOnAim = false
	
	SWEP.AimPos = Vector(-3.743, -2.346, 1.539)
	SWEP.AimAng = Vector (0, 0, 0)

	
	SWEP.SprintPos = Vector(9.071, 0, 1.6418)
	SWEP.SprintAng = Vector(-12.9765, 26.8708, 0)
	
	SWEP.IconLetter = "l"
	SWEP.IconFont = "WeaponIcons"
	
	SWEP.MuzzleEffect = "swb_rifle_med"
end

SWEP.PrintName = "Light Machine Gun"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_lmg"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_lmg"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_lmg"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_lmg"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_lmg"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_lmg"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_lmg"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_lmg"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_lmg"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_lmg"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_lmg"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_lmg"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_lmg"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= "apf_fire.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/draw_minigun_heavy.wav"
SWEP.AimSound 		= "rised/weapons/aim/rifle/uni_ads_in_0" .. math.random(1,6) .. ".wav"
SWEP.PreFireDelay = 1.4
SWEP.PreFireSound = "rised/weapons/lmg/charge.wav"
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
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Category = "A - Rised - [Оружие]"

SWEP.Author			= "aStonedPenguin"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModel = "models/weapons/c_suppressor.mdl"
SWEP.WorldModel = "models/weapons/w_suppressor.mdl"

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * -1 + HAng:Forward() * 12 + HAng:Up() * 8.5

		HAng:RotateAroundAxis(HAng:Right(), -15)
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

SWEP.Tracer = 'AirboatGunTracer'
