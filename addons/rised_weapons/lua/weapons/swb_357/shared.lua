-- "addons\\rised_weapons\\lua\\weapons\\swb_357\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.AimPos = Vector(-2.1, 0, 0.1)
	SWEP.AimAng = Vector(1, 0, 0)
	
	SWEP.SprintPos = Vector(1.185, -15.796, -14.254)
	SWEP.SprintAng = Vector(64.567, 0, 0)
	
	SWEP.ZoomAmount = 5
	SWEP.ViewModelMovementScale = 0.85
	SWEP.Shell = "smallshell"
	
	SWEP.IconLetter = "e"
	SWEP.IconFont = "WeaponIcons"
	
	SWEP.MuzzleEffect = "swb_pistol_large"
end

SWEP.PrintName = "CZ 75"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_357"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_357"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_357"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_357"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_357"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_357"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_357"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_357"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_357"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_357"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_357"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_357"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_357"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= ("weapons/cz75_sp01/cz75_fp.wav")
SWEP.DeploySound 	= "rised/weapons/deploy/uni_pistol_draw_03.wav"
SWEP.AimSound 		= "rised/weapons/aim/pistol/ironin.wav"
/////// SOUND ///////

SWEP.ReloadType = "Normal"
SWEP.SpeedDec = 12
SWEP.BulletDiameter = 9.1
SWEP.CaseLength = 33
SWEP.PlayBackRate = 2
SWEP.PlayBackRateSV = 2

SWEP.Kind = WEAPON_PISTOL
SWEP.AutoSpawnable = true
SWEP.AllowDrop = true
SWEP.AmmoEnt = "item_ammo_revolver_ttt"

SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.NormalHoldType = "revolver"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "swb_base"
SWEP.Category = "A - Rised - [Оружие]"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/c_pist_cz75bsp01.mdl"
SWEP.WorldModel		= "models/weapons/w_pist_cz75bsp01.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7,62x25_ammo"

SWEP.FireDelay = 60/SWEP.RPM
SWEP.Chamberable = true

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * 0.8 + HAng:Forward() * 0 + HAng:Up() * 0.8

		HAng:RotateAroundAxis(HAng:Right(), 0)
		HAng:RotateAroundAxis(HAng:Forward(),  180)
		HAng:RotateAroundAxis(HAng:Up(), 0)
		
		self:SetRenderOrigin(HPos + offset)
		self:SetRenderAngles(HAng)

		self:DrawModel()
	end
end
