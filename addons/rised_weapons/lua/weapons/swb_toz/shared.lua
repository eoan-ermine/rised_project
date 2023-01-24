-- "addons\\rised_weapons\\lua\\weapons\\swb_toz\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.AimPos = Vector (-2.398, 1.7091, 1.2)
	SWEP.AimAng = Vector (-0.0659, 0.0913, 0)
		
	SWEP.SprintPos = Vector (2, 0, 1.5)
	SWEP.SprintAng = Vector (-13, 27, 0)
	
	SWEP.ZoomAmount = 5
	SWEP.ViewModelMovementScale = 0.85
	SWEP.Shell = "shotshell"
	SWEP.ShellOnEvent = true
	
	SWEP.IconLetter = "b"
	SWEP.IconFont = "WeaponIcons"
	
	SWEP.MuzzleEffect = "swb_shotgun"
end

SWEP.PrintName = "ТОЗ"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_toz"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_toz"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_toz"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_toz"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_toz"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_toz"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_toz"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_toz"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_toz"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_toz"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_toz"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_toz"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_toz"].Weight
SWEP.ClumpSpread = 0.07
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.LoadShellSound = "weapons/toz-194m/toz_194m_shell_insert_1.wav"
SWEP.FireSound 		= "weapons/toz-194m/toz_194m_fire_1.wav"
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
SWEP.ViewModel		= "models/weapons/c_toz_194m.mdl"
SWEP.WorldModel	    = "models/weapons/w_toz_194m.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Reload		= ""
SWEP.Primary.Special		= ""
SWEP.Primary.Double		= ""
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12x70_ammo"

SWEP.FireDelay = 60/SWEP.RPM
SWEP.ShotgunReload = true
SWEP.ReloadStartWait = 1.2
SWEP.ReloadFinishWait = 1.1
SWEP.ReloadShellInsertWait = 0.8
SWEP.Chamberable = false

function SWEP:FinishAttack()
	timer.Simple(0.35, function()
		if !IsValid(self) && !IsValid(self.Owner) then return end
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

		HAng:RotateAroundAxis(HAng:Right(), -8)
		HAng:RotateAroundAxis(HAng:Forward(),  180)
		HAng:RotateAroundAxis(HAng:Up(), 0)
		
		self:SetRenderOrigin(HPos + offset)
		self:SetRenderAngles(HAng)

		self:DrawModel()
	end
end