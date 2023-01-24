-- "addons\\rised_weapons\\lua\\weapons\\swb_shotgun\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.AimPos = Vector (-2.6, 0, 0.7)
	SWEP.AimAng = Vector (-0.0659, 0.0913, 0)
		
	SWEP.SprintPos = Vector (3, 0, 0)
	SWEP.SprintAng = Vector (-13, 27, 0)
	
	SWEP.ZoomAmount = 5
	SWEP.ViewModelMovementScale = 0.85
	SWEP.Shell = "shotshell"
	SWEP.ShellOnEvent = true
	
	SWEP.IconLetter = "b"
	SWEP.IconFont = "WeaponIcons"
	
	SWEP.MuzzleEffect = "swb_shotgun"
end

SWEP.PrintName = "SPAS-12"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_shotgun"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_shotgun"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_shotgun"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_shotgun"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_shotgun"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_shotgun"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_shotgun"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_shotgun"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_shotgun"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_shotgun"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_shotgun"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_shotgun"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_shotgun"].Weight
SWEP.ClumpSpread = 0.07
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= Sound("weapons/tfa_ins2/spas12/fire.wav")
SWEP.DeploySound 	= "rised/weapons/deploy/uni_weapon_holster.wav"
SWEP.AimSound 		= "rised/weapons/aim/shotgun/uni_ads_in_06.wav"
/////// SOUND ///////

SWEP.ReloadType = "Normal"
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
SWEP.ViewModel			= "models/weapons/tfa_ins2/c_spas12_bri.mdl"
SWEP.WorldModel			= "models/weapons/tfa_ins2/w_spas12_bri.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12x70_ammo"

SWEP.FireDelay = 60/SWEP.RPM
SWEP.ShotgunReload = true
SWEP.ReloadStartWait = 0.6
SWEP.ReloadFinishWait = 1.1
SWEP.ReloadShellInsertWait = 0.7
SWEP.Chamberable = true

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * 0.8 + HAng:Forward() * 6 + HAng:Up() * -3

		HAng:RotateAroundAxis(HAng:Right(), -10)
		HAng:RotateAroundAxis(HAng:Forward(),  180)
		HAng:RotateAroundAxis(HAng:Up(), 0)
		
		self:SetRenderOrigin(HPos + offset)
		self:SetRenderAngles(HAng)

		self:DrawModel()
	end
end

function SWEP:FinishAttack()
	timer.Simple(0.35, function()
		if !(self && self.Owner) then return end
			self.Weapon:SendWeaponAnim(ACT_SHOTGUN_PUMP)

	end)
end