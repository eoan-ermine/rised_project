-- "lua\\weapons\\metro_gasmask_deploy\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base				= "metro2033_swep_base"


SWEP.Category				= "Metro Gasmask"
SWEP.Author				= "Hobo_Gus"
SWEP.Contact				= ""
SWEP.Purpose				= ""
SWEP.Instructions				= ""
SWEP.PrintName				= "GASMASK DEPLOY"		
SWEP.Slot				= 99				
SWEP.SlotPos				= 23			
SWEP.DrawAmmo				= false		
SWEP.DrawWeaponInfoBox			= false		
SWEP.BounceWeaponIcon   		= 	false	
SWEP.DrawCrosshair			= false			
SWEP.AutoSwitchTo			= true		
SWEP.AutoSwitchFrom			= true		
SWEP.HoldType 				= "normal"		

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= true
SWEP.ViewModel				= "models/weapons/metroll/v_gasmask.mdl"
SWEP.WorldModel				= ""		
SWEP.ShowWorldModel			= false
SWEP.ShowViewModel = false

SWEP.Spawnable				= false
SWEP.AdminSpawnable			= true
SWEP.FiresUnderwater = false

SWEP.PrimarySound			= Sound("vsv/shoot-1.wav")			

SWEP.Primary.Damage = 30
SWEP.Primary.TakeAmmo = -1
SWEP.Primary.ClipSize = 0
SWEP.Primary.Ammo = "ar2"
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Spread = 1	
SWEP.Primary.Cone = 0.4
SWEP.IronCone = .2
SWEP.DefaultCone = 0.4
SWEP.Primary.NumberofShots = 1
SWEP.Primary.Automatic = true
SWEP.Primary.Recoil = 1.5
SWEP.Primary.Delay = 0.10
SWEP.Primary.Force = 3

SWEP.IronSights = true
SWEP.Sprint = true

SWEP.DisableMuzzle = 1

SWEP.Tracer = 6
SWEP.CustomTracerName = "Tracer"
SWEP.ShotEffect = "muzzle_riflev2"

--SWEP.SightsPos = Vector(2.7, -4.624, 1.759)
--SWEP.SightsAng = Vector(0, 0, 0)
SWEP.IronSightsPos = Vector(2.7, -4.624, 1.759)
SWEP.IronSightsAng = Vector(0, 0, 0)
SWEP.RunPos = Vector(-1.841, -3.386, 0.708)
SWEP.RunAng = Vector(-7.441, -41.614, 0)
SWEP.HolsterT = false
SWEP.ViewModelBoneMods = {

}

function SWEP:Deploy()
self:OnDeploy()
self.Owner:SetNWInt("checkfilter", CurTime() + 5)

	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )--ACT_VM_FIDGET
	self.Owner:ViewPunch( Angle( 10,0,0 ) )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	self:SetHoldType( self.HoldType )	
	self.Primary.Cone = self.DefaultCone
	self.Weapon:SetNWInt("Reloading", CurTime() + self:SequenceDuration() )
	self.Weapon:SetNWString( "AniamtionName", "none" )
	self.Weapon:SetNWString( "PreventNearWall", false )
	--self.Owner:SetNWInt( "breathholdtime_hg", self.BreathHoldingTime )
		timer.Simple(0.5, function()
			if self.Weapon == nil then return end
				self.Owner:EmitSound("gasmask/gasmask_on_fast.wav")
				self.Owner:ViewPunch( Angle( -3,0,0 ) )
		end)
	if SERVER then
		self.HolsterT = false
		self.Owner:SetCanZoom( false ) 
		timer.Simple(self:SequenceDuration()*0.87, function()
			if self.Weapon == nil then return end
				
				self.Owner:SetNWBool("MetroGasmask", true)
				self.Owner:ViewPunch( Angle( 3,0,0 ) )
		local ply = self.Owner	
		--if (ply:GetNWInt("Filter") <= -1) then ply:SetNWInt("Filter", 360) end
			timer.Create("MMFX"..ply:SteamID(), 1, 0, function()
				sounds[ply:SteamID()] = CreateSound(ply, Sound("metromod/breath_1.wav"))
				sounds[ply:SteamID()]:SetSoundLevel(42)
				sounds[ply:SteamID()]:PlayEx(1, 100)
			end)			
					
		end)
	end
	timer.Simple(self:SequenceDuration(), function()
		if self.Weapon == nil then return end
			if SERVER then
				self.HolsterT = true
				if self.Owner:GetNWString("gasmask_lastwepon") != nil and self.Owner:HasWeapon(self.Owner:GetNWString("gasmask_lastwepon")) then
					self.Owner:SelectWeapon( self.Owner:GetNWString("gasmask_lastwepon") )
					self.Owner:StripWeapon( "metro_gasmask_deploy" ) 
				end
			end
	end)
	
	return true
end

function SWEP:Holster()
return self.HolsterT
end

function SWEP:PrimaryAttack()
end