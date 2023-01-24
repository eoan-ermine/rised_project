-- "lua\\weapons\\weapon_suitcharge.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

AddCSLuaFile()

SWEP.PrintName = "HEV battery"
SWEP.Author = "Spok"
SWEP.Purpose = "RMB - use it for yourself, LMB - for someone else."

SWEP.Slot = 5
SWEP.SlotPos = 3
SWEP.DrawAmmo = true
SWEP.Category = "Disposable"	

SWEP.Spawnable = true

SWEP.ViewModel = Model( "models/weapons/c_battery_reference.mdl" )
SWEP.WorldModel = Model( "models/weapons/w_suitcharger.mdl" )
SWEP.ViewModelFOV = 75
SWEP.UseHands = true

SWEP.Primary.ClipSize = 10
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.HealAmount = 15 -- Maximum heal amount per use
SWEP.MaxAmmo = 10 -- Maxumum ammo

local HealSound = Sound( "ItemBattery.Touch" )
local DenySound = Sound( "SuitRecharge.Deny" )

function SWEP:Initialize()

	self:SetHoldType( "slam" )

	if ( CLIENT ) then return end
end

function SWEP:PrimaryAttack()

	if ( CLIENT ) then return end

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
		filter = self.Owner
	} )

	local ent = tr.Entity

	local need = self.HealAmount
	if ( IsValid( ent ) && ( ent:IsPlayer() ) ) then need = math.min( 100 - ent:Armor(), self.HealAmount ) end

	if ( IsValid( ent ) && self:Clip1() >= 1 && ( ent:IsPlayer() ) && ent:Armor() < 100 ) then

		self:TakePrimaryAmmo( 1 )
		

		ent:SetArmor( math.min( 100, ent:Armor() + need ) )
		ent:EmitSound( HealSound )

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() + 0.5 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 1, function() if ( IsValid( self ) ) and self:Clip1() >= 1  then self:SendWeaponAnim( ACT_VM_IDLE ) else self:Remove () end end )

	else

		self.Owner:EmitSound( DenySound )
		self:SetNextPrimaryFire( CurTime() + 1 )

	end
end

function SWEP:SecondaryAttack()

	if ( CLIENT ) then return end

	local ent = self.Owner

	local need = self.HealAmount
	if ( IsValid( ent ) ) then need = math.min( 100 - ent:Armor(), self.HealAmount ) end

	if ( IsValid( ent ) && self:Clip1() >= 1 && ent:Armor() < 100 ) then

		self:TakePrimaryAmmo( 1 )

		ent:SetArmor( math.min( 100, ent:Armor() + need ) )
		ent:EmitSound( HealSound )

		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )

		self:SetNextSecondaryFire( CurTime() + self:SequenceDuration() + 0.5 )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )

		timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 1, function() if ( IsValid( self ) ) and  self:Clip1() >= 1  then self:SendWeaponAnim( ACT_VM_IDLE ) else self:Remove () end end )

	else

		ent:EmitSound( DenySound )
		self:SetNextSecondaryFire( CurTime() + 1 )

	end
end

function SWEP:OnRemove()

	timer.Stop( "weapon_idle" .. self:EntIndex() )

end

function SWEP:Holster()

	timer.Stop( "weapon_idle" .. self:EntIndex() )

	return true

end


		




