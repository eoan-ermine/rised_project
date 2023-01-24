-- "addons\\rised_weapons\\lua\\weapons\\swb_sawedoff\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.AimPos = Vector (-1.9, 1.7091, 1.2)
	SWEP.AimAng = Vector (-0.0659, 0.0913, 0)
		
	SWEP.SprintPos = Vector (3, 0, 1.5)
	SWEP.SprintAng = Vector (-23, 27, 0)
	
	SWEP.ZoomAmount = 5
	SWEP.ViewModelMovementScale = 0.85
	SWEP.Shell = "shotshell"
	SWEP.ShellOnEvent = true
	
	SWEP.IconLetter = "b"
	SWEP.IconFont = "WeaponIcons"
	
	SWEP.MuzzleEffect = "swb_shotgun"
end

SWEP.PrintName = "Обрез"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_sawedoff"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_sawedoff"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_sawedoff"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_sawedoff"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_sawedoff"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_sawedoff"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_sawedoff"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_sawedoff"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_sawedoff"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_sawedoff"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_sawedoff"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_sawedoff"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_sawedoff"].Weight
SWEP.ClumpSpread = 0.1
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= "weapons/tfa_ins2/doublebarrel/doublebarrel_fire.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/uni_weapon_holster.wav"
SWEP.AimSound 		= "rised/weapons/aim/shotgun/uni_ads_in_06.wav"
/////// SOUND ///////

SWEP.ReloadType = "Another"
SWEP.CanPenetrate = false
SWEP.PlayBackRate = 1
SWEP.PlayBackRateSV = 1
SWEP.SpeedDec = 30
SWEP.BulletDiameter = 5
SWEP.CaseLength = 10

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = true
SWEP.AllowDrop = true
SWEP.AmmoEnt = "item_box_buckshot_ttt"

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "swb_base"
SWEP.Category = "A - Rised - [Оружие]"

SWEP.Author			= "aStonedPenguin"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModel				= "models/weapons/v_nam_sawedoff.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_sawedoff.mdl"	-- Weapon world model

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Reload		= ""
SWEP.Primary.Special		= ""
SWEP.Primary.Double		= ""
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12x70_ammo"

SWEP.FireDelay = 60/SWEP.RPM
SWEP.ShotgunReload = false
SWEP.ReloadStartWait = 1.2
SWEP.ReloadFinishWait = 1.1
SWEP.ReloadShellInsertWait = 0.8
SWEP.Chamberable = false

function SWEP:FinishAttack()
	timer.Simple(0.35, function()
		if !(self && self.Owner) then return end
			self.Weapon:SendWeaponAnim(ACT_SHOTGUN_PUMP)
		if SERVER then
			self.Weapon:EmitSound(self.Primary.Special)
		end
	end)
end

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * 1 + HAng:Forward() * 4.2 + HAng:Up() * -2.5

		HAng:RotateAroundAxis(HAng:Right(), -5)
		HAng:RotateAroundAxis(HAng:Forward(),  180)
		HAng:RotateAroundAxis(HAng:Up(), 0)
		
		self:SetRenderOrigin(HPos + offset)
		self:SetRenderAngles(HAng)

		self:DrawModel()
	end
end