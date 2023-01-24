-- "addons\\rised_weapons\\lua\\weapons\\swb_asval\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true

	SWEP.AimPos = Vector(-2.95, -1.1, 1.12)
	SWEP.AimAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(0.736, -3.971, 1.802)
	SWEP.SprintAng = Vector(-13.205, 37.048, 0)
	
	SWEP.ZoomAmount = 15
	SWEP.ViewModelMovementScale = 0.85
	SWEP.Shell = "smallshell"
	
	SWEP.IconLetter = "d"
	SWEP.NoStockMuzzle = true
	killicon.AddFont("swb_tmp", "SWB_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "swb_silenced"
end

SWEP.PrintName = "АС 'Вал'"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_asval"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_asval"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_asval"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_asval"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_asval"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_asval"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_asval"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_asval"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_asval"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_asval"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_asval"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_asval"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_asval"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= "weapons/tfa_ins2/asval/asval_suppressed.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/uni_lean_in_02.wav"
SWEP.AimSound 		= "rised/weapons/aim/rifle/uni_ads_in_0" .. math.random(1,6) .. ".wav"
/////// SOUND ///////

SWEP.ReloadType = "Another"
SWEP.FadeCrosshairOnAim = false
SWEP.PlayBackRate = 30
SWEP.PlayBackRateSV = 0
SWEP.SpeedDec = 0
SWEP.BulletDiameter = 9
SWEP.CaseLength = 19

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = true
SWEP.AllowDrop = true
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.Slot = 2
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "swb_base"
SWEP.Category = "A - Rised - [Оружие]"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/tfa_ins2/v_asval.mdl"
SWEP.WorldModel		= "models/weapons/tfa_ins2/w_asval.mdl"

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * 0.8 + HAng:Forward() * 3 + HAng:Up() * 1

		HAng:RotateAroundAxis(HAng:Right(), -10)
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
SWEP.Primary.Ammo			= "9x39_ammo"

SWEP.FireDelay = 60/SWEP.RPM