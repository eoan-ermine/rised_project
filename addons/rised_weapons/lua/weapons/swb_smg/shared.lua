-- "addons\\rised_weapons\\lua\\weapons\\swb_smg\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.AimPos = Vector (-2.815, 0, 0.8)
	SWEP.AimAng = Vector (0, 0, 0)
	
	SWEP.SprintPos = Vector(9.071, 0, 1.6418)
	SWEP.SprintAng = Vector(-12.9765, 26.8708, 0)
	
	SWEP.ZoomAmount = 15
	SWEP.ViewModelMovementScale = 0.85
	SWEP.Shell = "smallshell"

	SWEP.IconLetter = "a"
	SWEP.IconFont = "WeaponIcons"
	
	SWEP.MuzzleEffect = "swb_rifle_med"
end

SWEP.PrintName = "MP7"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_smg"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_smg"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_smg"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_smg"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_smg"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_smg"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_smg"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_smg"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_smg"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_smg"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_smg"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_smg"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_smg"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= Sound("weapons/tfa_ins2/mp7/fp.wav")
SWEP.DeploySound 	= "rised/weapons/deploy/uni_lean_in_02.wav"
SWEP.AimSound 		= "rised/weapons/aim/pp/uni_ads_in_02.wav"
/////// SOUND ///////

SWEP.ReloadType = "Normal"
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
SWEP.SlotPos = 0
SWEP.NormalHoldType = "smg"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Category = "A - Rised - [Оружие]"

SWEP.Author			= "aStonedPenguin"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModel			= "models/weapons/tfa_ins2/c_mp7.mdl"
SWEP.WorldModel			= "models/weapons/tfa_ins2/w_mp7.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "SMG1"

SWEP.FireDelay = 60/SWEP.RPM

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * 0.8 + HAng:Forward() * 6 + HAng:Up() * -1.5

		HAng:RotateAroundAxis(HAng:Right(), -15)
		HAng:RotateAroundAxis(HAng:Forward(),  180)
		HAng:RotateAroundAxis(HAng:Up(), 0)
		
		self:SetRenderOrigin(HPos + offset)
		self:SetRenderAngles(HAng)

		self:DrawModel()
	end
    
    self:SetModelScale(1.2)
end