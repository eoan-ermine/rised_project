-- "addons\\rised_weapons\\lua\\weapons\\swb_cheytac\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.AimPos = Vector (-3.1, 0.771, 1.593)
	SWEP.AimAng = Vector (-1.0659, 0, 0)
		
	SWEP.SprintPos = Vector (10, -7, 5)
	SWEP.SprintAng = Vector (-25, 45, 0)
	
	SWEP.ZoomAmount = 5
	SWEP.ViewModelMovementScale = 0.85
	SWEP.Shell = "mainshell"
	SWEP.ShellOnEvent = true
	
	SWEP.DrawBlackBarsOnAim = true
	SWEP.AimOverlay = surface.GetTextureID("swb/scope_rifle")
	SWEP.FadeDuringAiming = true
	SWEP.MoveWepAwayWhenAiming = true
	SWEP.ZoomAmount = 70
	SWEP.DelayedZoom = true
	SWEP.SnapZoom = true
	SWEP.SimulateCenterMuzzle = true
	
	SWEP.AdjustableZoom = true
	SWEP.MinZoom = 40
	SWEP.MaxZoom = 80
	
	SWEP.IconLetter = "b"
	SWEP.IconFont = "WeaponIcons"
	
	SWEP.MuzzleEffect = "swb_shotgun"
end

SWEP.PrintName = "CheyTac M200"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_cheytac"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_cheytac"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_cheytac"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_cheytac"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_cheytac"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_cheytac"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_cheytac"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_cheytac"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_cheytac"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_cheytac"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_cheytac"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_cheytac"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_cheytac"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= "weapons/tfa_l4d2/ct_m200/gunfire/awp1.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/uni_gl_beginreload_03.wav"
SWEP.AimSound 		= "rised/weapons/aim/rifle/uni_ads_in_0" .. math.random(1,6) .. ".wav"
/////// SOUND ///////

SWEP.ReloadType = "Sniper"
SWEP.CanPenetrate = false
SWEP.PlayBackRate = 1
SWEP.PlayBackRateSV = 1
SWEP.SpeedDec = 40
SWEP.BulletDiameter = 8.58
SWEP.CaseLength = 69.20

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

SWEP.ViewModelFOV	= 65
SWEP.ViewModel				= "models/weapons/c_ctm200.mdl"	-- Weapon view model
SWEP.WorldModel				= "models/weapons/w_ctm200.mdl"	-- Weapon world model
SWEP.ViewModelFlip			= false

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * 0.8 + HAng:Forward() * 0 + HAng:Up() * 0.6

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
SWEP.Primary.Ammo			= "10,3x77_ammo"


SWEP.FireDelay = 60/SWEP.RPM
SWEP.ShotgunReload = false
SWEP.ReloadStartWait = 1.2
SWEP.ReloadFinishWait = 1.1
SWEP.ReloadShellInsertWait = 0
SWEP.Chamberable = false

function SWEP:FinishAttack()
	timer.Simple(0.35, function()
		if !(self && self.Owner) then return end
		self.Weapon:SendWeaponAnim(ACT_VM_PULLBACK_LOW)
	end)
end