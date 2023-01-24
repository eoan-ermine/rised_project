-- "addons\\rised_weapons\\lua\\weapons\\swb_hammer\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	SWEP.FadeCrosshairOnAim = false
	
	SWEP.AimPos = Vector(-3.743, -2.346, 1.539)
	SWEP.AimAng = Vector (0, 0, 0)

	
	SWEP.SprintPos = Vector(9.071, 0, 1.6418)
	SWEP.SprintAng = Vector(-12.9765, 26.8708, 0)
	
	SWEP.IconLetter = "l"
	SWEP.IconFont = "WeaponIcons"
	
	SWEP.MuzzleEffect = "swb_rifle_med"
end

SWEP.PrintName = "Hammer"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_hammer"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_hammer"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_hammer"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_hammer"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_hammer"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_hammer"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_hammer"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_hammer"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_hammer"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_hammer"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_hammer"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_hammer"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_hammer"].Weight
SWEP.ClumpSpread = 0.1
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= "wallhammer_fire.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/uni_gl_beginreload_03.wav"
SWEP.AimSound 		= "rised/weapons/aim/rifle/uni_ads_in_0" .. math.random(1,6) .. ".wav"
/////// SOUND ///////

SWEP.ReloadType = "Another_NoEmptyAnimation"
SWEP.Base = 'swb_base'
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
SWEP.SlotPos = 1
SWEP.NormalHoldType = "shotgun"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Category = "A - Rised - [Оружие]"

SWEP.Author			= "D-Rised"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 50
SWEP.ViewModel = "models/weapons/c_heavyshotgun.mdl"
SWEP.WorldModel = "models/hlvr/weapons/w_shotgun_heavy/w_shotgun_heavy_hlvr.mdl"

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		--local offset = HAng:Right() * 1 + HAng:Forward() * -1 + HAng:Up() * -1.5
		local offset = HAng:Right() * 1 + HAng:Forward() * 13 + HAng:Up() * -4.5

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
SWEP.Primary.Ammo			= "12x70_ammo"

SWEP.FireDelay = 60/SWEP.RPM
SWEP.ShotgunReload = false
SWEP.ReloadStartWait = 1
SWEP.ReloadFinishWait = 1.4
SWEP.ReloadShellInsertWait = 0
SWEP.Chamberable = false

SWEP.Tracer = 'AR2Tracer'
