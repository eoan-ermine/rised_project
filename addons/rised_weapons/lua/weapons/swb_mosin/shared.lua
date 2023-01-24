-- "addons\\rised_weapons\\lua\\weapons\\swb_mosin\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.AimPos = Vector (-3.1, 0.771, 1.593)
	SWEP.AimAng = Vector (0.15, 0, 0)
		
	SWEP.SprintPos = Vector (3, 0, 2.5)
	SWEP.SprintAng = Vector (-13, 27, 0)
	
	SWEP.ZoomAmount = 5
	SWEP.ViewModelMovementScale = 0.85
	SWEP.Shell = "mainshell"
	SWEP.ShellOnEvent = true
	
	SWEP.IconLetter = "b"
	SWEP.IconFont = "WeaponIcons"
	
	SWEP.MuzzleEffect = "swb_shotgun"
end

SWEP.PrintName = "Винтовка Мосина"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_mosin"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_mosin"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_mosin"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_mosin"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_mosin"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_mosin"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_mosin"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_mosin"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_mosin"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_mosin"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_mosin"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_mosin"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_mosin"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= "weapons/tfa_ins2/mosin/mosin_fire.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/uni_lean_in_02.wav"
SWEP.AimSound 		= "rised/weapons/aim/rifle/uni_ads_in_0" .. math.random(1,6) .. ".wav"
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
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "swb_base"
SWEP.Category = "A - Rised - [Оружие]"

SWEP.Author			= "aStonedPenguin"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModel			= "models/weapons/tfa_ins2/v_mosin.mdl"
SWEP.WorldModel			= "models/weapons/tfa_ins2/w_mosin.mdl"

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * 0.8 + HAng:Forward() * 4.2 + HAng:Up() * -0.1

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
SWEP.Primary.Reload			= ""
SWEP.Primary.Special		= ""
SWEP.Primary.Double			= ""
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7,62x54R_ammo"

SWEP.FireDelay = 60/SWEP.RPM
SWEP.ShotgunReload = true
SWEP.ReloadStartWait = 1.2
SWEP.ReloadFinishWait = 1.1
SWEP.ReloadShellInsertWait = 0.8
SWEP.Chamberable = false

function SWEP:FinishAttack()
	timer.Simple(0.35, function()
		if !(self && self.Owner) then return end
		self.Weapon:SendWeaponAnim(ACT_VM_PULLBACK_LOW)
	end)
end