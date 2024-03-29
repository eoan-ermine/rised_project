-- "addons\\rised_weapons\\lua\\weapons\\swb_deagle\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.AimPos = Vector(-3.6, -2.096, 0.32)
	SWEP.AimAng = Vector(-0.401, 0, 0)
		
	SWEP.SprintPos = Vector(0, -6.514, -5.271)
	SWEP.SprintAng = Vector(45.637, 0, 0)
	
	SWEP.ZoomAmount = 5
	SWEP.ViewModelMovementScale = 0.85
	SWEP.Shell = "smallshell"
	
	SWEP.IconLetter = "y"
	
	SWEP.MuzzleEffect = "swb_pistol_small"
end

SWEP.PrintName = "Desert Eagle"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_deagle"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_deagle"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_deagle"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_deagle"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_deagle"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_deagle"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_deagle"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_deagle"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_deagle"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_deagle"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_deagle"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_deagle"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_deagle"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= "weapons/tfa_ins2/deagle/de_single.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/uni_pistol_draw_03.wav"
SWEP.AimSound 		= "rised/weapons/aim/pistol/ironin.wav"
/////// SOUND ///////

SWEP.ReloadType = "Another"
SWEP.PlayBackRate = 30
SWEP.PlayBackRateSV = 12
SWEP.SpeedDec = 10
SWEP.BulletDiameter = 9
SWEP.CaseLength = 19

SWEP.Kind = WEAPON_PISTOL
SWEP.AutoSpawnable = true
SWEP.AllowDrop = true
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.Slot = 1
SWEP.SlotPos = 0
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "swb_base"
SWEP.Category = "A - Rised - [Оружие]"

SWEP.Author			= "D-Rised"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/tfa_ins2/c_deagle.mdl"
SWEP.WorldModel		= "models/weapons/tfa_ins2/w_deagle.mdl"

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * 0.8 + HAng:Forward() * 5 + HAng:Up() * -1.6

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
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7,62x25_ammo"

SWEP.FireDelay = 60/SWEP.RPM