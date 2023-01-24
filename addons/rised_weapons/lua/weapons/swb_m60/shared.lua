-- "addons\\rised_weapons\\lua\\weapons\\swb_m60\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.AimPos = Vector(-1.75, 0.563, 0.2)
	SWEP.AimAng = Vector(0.1, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 1.442, 2)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	killicon.AddFont("swb_m60", "SWB_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "swb_rifle_med"
end

SWEP.PrintName = "M60"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_m60"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_m60"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_m60"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_m60"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_m60"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_m60"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_m60"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_m60"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_m60"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_m60"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_m60"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_m60"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_m60"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= "weapons/tfa_nam_m60/m60_fp.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/draw_minigun_heavy.wav"
SWEP.AimSound 		= "rised/weapons/aim/rifle/uni_ads_in_0" .. math.random(1,6) .. ".wav"
/////// SOUND ///////

SWEP.ReloadType = "Another"
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
SWEP.ViewModel 	= "models/weapons/v_nam_m60.mdl"
SWEP.WorldModel = "models/weapons/w_nam_m60.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5,45x39_ammo"

SWEP.FireDelay = 60/SWEP.RPM

if CLIENT then
	local WorldModel = ClientsideModel(SWEP.WorldModel)

	-- Settings...
	WorldModel:SetSkin(1)
	WorldModel:SetNoDraw(true)

	function SWEP:DrawWorldModel()
		local _Owner = self:GetOwner()

		if (IsValid(_Owner)) then
			-- Specify a good position
			local offsetVec = Vector(3, -1, -1)
			local offsetAng = Angle(15, 0, 180)
			
			local boneid = _Owner:LookupBone("ValveBiped.Bip01_R_Hand") -- Right Hand
			if !boneid then return end

			local matrix = _Owner:GetBoneMatrix(boneid)
			if !matrix then return end

			local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

			WorldModel:SetPos(newPos)
			WorldModel:SetAngles(newAng)

			WorldModel:SetupBones()
		else
			WorldModel:SetPos(self:GetPos())
			WorldModel:SetAngles(self:GetAngles())
		end

		WorldModel:DrawModel()
	end
end