-- "addons\\rised_weapons\\lua\\weapons\\swb_mp5a5\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.CSMuzzleFlashes = true
	
	SWEP.AimPos = Vector(-2.54, 0.1, 1.5)
	SWEP.AimAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 1.442, 2)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.ViewModelMovementScale = 1.15
		
	language.Add("weapon_metropolice_oicw", "Metropolice OICW")
	killicon.Add( "weapon_metropolice_oicw", "effects/killicons/weapon_metropolice_oicw", color_white )
	SWEP.SelectIcon = surface.GetTextureID("HUD/swepicons/metropolice_smg_icon") 
	
	SWEP.MuzzleEffect = "swb_pistol_small"
end

SWEP.PrintName = "MP5A5"

/////// BALANCE ///////
SWEP.Primary.ClipSize = RISED.Config.Weapons["swb_mp5a5"].ClipSize
SWEP.Recoil = RISED.Config.Weapons["swb_mp5a5"].Recoil
SWEP.Damage = RISED.Config.Weapons["swb_mp5a5"].Damage
SWEP.RPM = RISED.Config.Weapons["swb_mp5a5"].RPM
SWEP.HipSpread = RISED.Config.Weapons["swb_mp5a5"].HipSpread
SWEP.AimSpread = RISED.Config.Weapons["swb_mp5a5"].AimSpread
SWEP.VelocitySensitivity = RISED.Config.Weapons["swb_mp5a5"].VelocitySensitivity
SWEP.MaxSpreadInc = RISED.Config.Weapons["swb_mp5a5"].MaxSpreadInc
SWEP.SpreadPerShot = RISED.Config.Weapons["swb_mp5a5"].SpreadPerShot
SWEP.SpreadCooldown = RISED.Config.Weapons["swb_mp5a5"].SpreadCooldown
SWEP.Shots = RISED.Config.Weapons["swb_mp5a5"].Shots
SWEP.DeployTime = RISED.Config.Weapons["swb_mp5a5"].DeployTime
SWEP.Weight = RISED.Config.Weapons["swb_mp5a5"].Weight
/////// BALANCE ///////

/////// SOUND ///////
SWEP.Primary.Reload = Sound("Weapon_SMG1.Reload")
SWEP.FireSound 		= "weapons/inss_mp5a5/inss_mp5k_fp.wav"
SWEP.DeploySound 	= "rised/weapons/deploy/uni_weapon_draw_02.wav"
SWEP.AimSound 		= "rised/weapons/aim/rifle/uni_ads_in_0" .. math.random(1,6) .. ".wav"
/////// SOUND ///////

SWEP.ReloadType = "Normal"
SWEP.PlayBackRate = 30
SWEP.PlayBackRateSV = 12
SWEP.SpeedDec = 30
SWEP.BulletDiameter = 7.62
SWEP.CaseLength = 39
SWEP.ShellScale = 0.5
SWEP.Shell = "smallshell"
SWEP.MuzzlePosMod = Vector(4, 24, -3)
SWEP.RisedAimMuzzle = true
SWEP.InvertShellEjectAngle = true

SWEP.Kind = WEAPON_HEAVY
SWEP.AutoSpawnable = true
SWEP.AllowDrop = true
SWEP.UseHands = true

SWEP.Slot = 2
SWEP.SlotPos = 20
SWEP.NormalHoldType = "smg"
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
SWEP.ViewModel  	= "models/weapons/c_inss2_mp5a5.mdl"
SWEP.WorldModel 	= "models/weapons/w_inss2_mp5a5.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19_ammo"

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
			local offsetVec = Vector(4.8, -2, -1.4)
			local offsetAng = Angle(0, 0, 180)
			
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