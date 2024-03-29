-- "addons\\rised_weapons\\lua\\weapons\\swb_akm\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.AimPos = Vector(-2.93, 0, 0.8)
	SWEP.AimAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 1.442, 2)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	killicon.AddFont("swb_ak47", "SWB_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "swb_rifle_med"
end

SWEP.PrintName = "AKM"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_akm"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_akm"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_akm"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_akm"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_akm"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_akm"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_akm"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_akm"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_akm"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_akm"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_akm"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_akm"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_akm"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= "weapons/akm/fire.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/uni_weapon_draw_02.wav"
SWEP.AimSound 		= "rised/weapons/aim/rifle/uni_ads_in_0" .. math.random(1,6) .. ".wav"
/////// SOUND ///////

SWEP.ReloadType = "Normal"
SWEP.PlayBackRate = 30
SWEP.PlayBackRateSV = 12
SWEP.SpeedDec = 30
SWEP.BulletDiameter = 7.62
SWEP.CaseLength = 39

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = true
SWEP.AllowDrop = true

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "swb_base"
SWEP.Category = "A - Rised - [Оружие]"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 75
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/c_akz.mdl"
SWEP.WorldModel	  	= "models/weapons/w_akz.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7,62x39_ammo"

SWEP.FireDelay = 60/SWEP.RPM

function SWEP:DrawModels()
	if CLIENT then
		local vm = self.Owner:GetViewModel()
		caca:SetPos( vm:GetPos() )
		caca:SetAngles( vm:GetAngles() )
		caca:AddEffects( EF_BONEMERGE )
		caca:SetNoDraw( true )
		caca:SetParent( vm )
		caca:DrawModel()
	end
end

function SWEP:DrawWorldModel()
	if not IsValid(self.Owner) then
		return
	end

	local boneindex = self.Owner:LookupBone("ValveBiped.Bip01_R_Hand")
	if boneindex then	
		local HPos, HAng = self.Owner:GetBonePosition(boneindex)

		local offset = HAng:Right() * 1 + HAng:Forward() * 4 + HAng:Up() * -1

		HAng:RotateAroundAxis(HAng:Right(), -5)
		HAng:RotateAroundAxis(HAng:Forward(),  180)
		HAng:RotateAroundAxis(HAng:Up(), 0)
		
		self:SetRenderOrigin(HPos + offset)
		self:SetRenderAngles(HAng)

		self:DrawModel()
	end
end