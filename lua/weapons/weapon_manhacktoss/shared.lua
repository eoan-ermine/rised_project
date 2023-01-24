-- "lua\\weapons\\weapon_manhacktoss\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.Base           = "weapon_base"
SWEP.Category				= "Entropy : Zero" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep..
SWEP.Manufacturer = "Combine" --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "Insane Black Rock Shooter" --Author Tooltip
SWEP.Contact				= "" --Contact Info Tooltip
SWEP.Purpose				= "" --Purpose Tooltip
SWEP.Instructions				= "" --Instructions Tooltip
SWEP.Spawnable				= true --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable			= true --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.AdminOnly = false
SWEP.DrawCrosshair			= true		-- Draw the crosshair?
SWEP.DrawCrosshairIS = false --Draw the crosshair in ironsights?
--SWEP.PrintName				= "Manhack Toss"		-- Weapon name (Shown on HUD)
SWEP.PrintName				= "Manhack Toss"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 5			-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 20			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter if enabled in the GUI.
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30			-- This controls how "good" the weapon is for autopickup.
SWEP.UseHands = true
SWEP.ViewModel        = "models/weapons/c_manhackcontrol.mdl"
SWEP.WorldModel = "models/weapons/w_manhackcontrol.mdl"

SWEP.Primary.Automatic			= true
SWEP.Primary.ClipSize = 1
SWEP.Primary.Delay = 1.5
SWEP.Primary.Damage = 8
SWEP.Primary.DefaultClip = 3
SWEP.Primary.Ammo = "manhack"

SWEP.HoldType = "grenade"

SWEP.Idle = 0
SWEP.IdleTimer = CurTime()

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Delay = 1
SWEP.Secondary.Damage = 125
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

function SWEP:Reload()
self.Weapon:DefaultReload(ACT_VM_RELOAD) 
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:Initialize()
game.AddAmmoType( { name = "manhack" } )
self:SetWeaponHoldType( self.HoldType )
self.Idle = 0
self.IdleTimer = CurTime() + 4
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end

	if ( IsFirstTimePredicted() ) then
	if SERVER then
		local Manhack = ents.Create("npc_manhack")
	Manhack:SetOwner(self.Owner)
	Manhack:SetPos(self.Owner:GetShootPos() + self.Owner:GetAimVector()*50 )
	Manhack:SetAngles(self.Owner:EyeAngles())
	Manhack:Spawn()
	Manhack:Activate()
	Manhack:SetVelocity(self.Owner:GetAimVector()*1000 + Vector(0,0,80))
	Manhack:SetHealth(200)
	Manhack:AddRelationship( "player D_LI 99" )
	Manhack:SetSequence( "deploy" )
	Manhack.IsScripted = true
		
		self:SetNextPrimaryFire( CurTime() + 1 )
	    self:SetNextSecondaryFire( CurTime() + 1 )
		self:SendWeaponAnim( ACT_VM_THROW )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
			if GetConVar( "sk_ez_infinite_ammo" ):GetInt() == 0 then
				self:TakePrimaryAmmo( 1 )
			else
				self:TakePrimaryAmmo( 0 )
			end
	end

	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
    self:Reload()
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end
end

function SWEP:Think()
	if self.Idle == 0 and self.IdleTimer < CurTime() then
		if SERVER then
			self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
		end
		self.Idle = 1
	end
end
