-- "addons\\rised_weapons\\lua\\weapons\\swb_pistol\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.AimPos = Vector (-2, 1, 0.6)
	SWEP.AimAng = Vector (-0.3, 0, 0)
	
	SWEP.SprintPos = Vector (5.041, 0, 3.6778)
	SWEP.SprintAng = Vector (-17.6901, 10.321, 0)
	
	SWEP.ZoomAmount = 5
	SWEP.ViewModelMovementScale = 0.85
	SWEP.Shell = "smallshell"
	
	SWEP.IconLetter = "d"
	SWEP.IconFont = "WeaponIcons"
end

SWEP.PrintName = "USP Match"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_pistol"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_pistol"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_pistol"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_pistol"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_pistol"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_pistol"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_pistol"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_pistol"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_pistol"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_pistol"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_pistol"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_pistol"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_pistol"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= Sound("/weapons/tfa_ins2/usp_match/usp_unsil-1.wav")
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
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.Slot = 1
SWEP.SlotPos = 0
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
SWEP.ViewModel			= "models/weapons/tfa_ins2/c_usp_match.mdl"
SWEP.WorldModel			= "models/weapons/tfa_ins2/w_usp_match.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19_ammo"

SWEP.FireDelay = 60/SWEP.RPM
SWEP.Chamberable = false

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