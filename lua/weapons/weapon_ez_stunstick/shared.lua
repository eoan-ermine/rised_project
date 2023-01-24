-- "lua\\weapons\\weapon_ez_stunstick\\shared.lua"
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
SWEP.PrintName				= "Stunstick"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 0			-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 0			-- Position in the slot
SWEP.DrawAmmo				= false		-- Should draw the default HL2 ammo counter if enabled in the GUI.
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30			-- This controls how "good" the weapon is for autopickup.
SWEP.UseHands = true
SWEP.ViewModel        = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.ViewModelFlip = false
SWEP.BobScale = 0.2
SWEP.SwayScale = 1

SWEP.Primary.Automatic			= true
SWEP.Primary.ClipSize = 1
SWEP.Primary.Delay = 1.5
SWEP.Primary.Damage = 20
SWEP.Primary.DefaultClip = 3
SWEP.Primary.Ammo = "none"
SWEP.Primary.DelayMiss = 0.75
SWEP.Primary.DelayHit = 0.5
SWEP.Primary.Force = 1000

SWEP.HoldType = "melee"
SWEP.FiresUnderwater = true

SWEP.Idle = 0
SWEP.IdleTimer = CurTime()
SWEP.Charging = 0
SWEP.ChargingTimer = CurTime()

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Delay = 1
SWEP.Secondary.Damage = 60
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.DelayMiss = 0.75
SWEP.Secondary.DelayHit = 0.5
SWEP.Secondary.Force = 2000

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:Initialize()
self:SetWeaponHoldType( self.HoldType )
self.Idle = 0
self.IdleTimer = CurTime() + 4
end

function SWEP:PrimaryAttack()
if self.FiresUnderwater == false and self.Owner:WaterLevel() == 3 then return end
self.Owner:LagCompensation( true )
local tr = util.TraceLine( {
start = self.Owner:GetShootPos(),
endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 56,
filter = self.Owner,
mask = MASK_SHOT_HULL,
} )
if !IsValid( tr.Entity ) then
tr = util.TraceHull( {
start = self.Owner:GetShootPos(),
endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 56,
filter = self.Owner,
mins = Vector( -16, -16, 0 ),
maxs = Vector( 16, 16, 0 ),
mask = MASK_SHOT_HULL,
} )
end
if SERVER and IsValid( tr.Entity ) then
local dmginfo = DamageInfo()
local attacker = self.Owner
if !IsValid( attacker ) then
attacker = self
end
dmginfo:SetAttacker( attacker )
dmginfo:SetInflictor( self )
dmginfo:SetDamage( self.Primary.Damage )
dmginfo:SetDamageForce( self.Owner:GetForward() * self.Primary.Force )
tr.Entity:GetPhysicsObject():ApplyForceCenter( self.Owner:GetForward() * self.Primary.Force )
tr.Entity:TakeDamageInfo( dmginfo )
end
if !tr.Hit then
self:EmitSound( "Weapon_ez_StunStick.Swing" )
self:SetNextPrimaryFire( CurTime() + self.Primary.DelayMiss )
self:SetNextSecondaryFire( CurTime() + self.Primary.DelayMiss )
self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER )
end
if tr.Hit then
self:EmitSound( "Weapon_ez_StunStick.Melee_Hit" )
self:SetNextPrimaryFire( CurTime() + self.Primary.DelayHit )
self:SetNextSecondaryFire( CurTime() + self.Primary.DelayHit )
self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
end
self.Owner:LagCompensation( false )
self.Owner:SetAnimation( PLAYER_ATTACK1 )
self.Owner:ViewPunchReset()
self.Owner:ViewPunch( Angle( math.Rand( 1, 2 ), math.Rand( -3.5, -1.5 ), 0 ) )
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:SecondaryAttack()
if !( self.Charging == 0 ) then return end
if SERVER then
self.Owner:EmitSound( "Weapon_ez_StunStick.Charge" )
end
self.Charging = 1
self.ChargingTimer = CurTime() + 1.5
self.Idle = 0
self.IdleTimer = CurTime() + 7
end

function SWEP:Think()
	if self.Idle == 0 and self.IdleTimer < CurTime() then
		if SERVER then
			self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
		end
		self.Idle = 1
	end
	
if self.Charging == 1 and self.ChargingTimer > CurTime() and self.Owner:KeyDown( IN_ATTACK2 ) then
self.Owner:LagCompensation( true )
local tr = util.TraceLine( {
start = self.Owner:GetShootPos(),
endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 56,
filter = self.Owner,
mask = MASK_SHOT_HULL,
} )
if !IsValid( tr.Entity ) then
tr = util.TraceHull( {
start = self.Owner:GetShootPos(),
endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 56,
filter = self.Owner,
mins = Vector( -16, -16, 0 ),
maxs = Vector( 16, 16, 0 ),
mask = MASK_SHOT_HULL,
} )
end
if SERVER and IsValid( tr.Entity ) then
local dmginfo = DamageInfo()
local attacker = self.Owner
if !IsValid( attacker ) then
attacker = self
end
dmginfo:SetAttacker( attacker )
dmginfo:SetInflictor( self )
dmginfo:SetDamage( self.Secondary.Damage )
dmginfo:SetDamageForce( self.Owner:GetForward() * self.Secondary.Force )
tr.Entity:GetPhysicsObject():ApplyForceCenter( self.Owner:GetForward() * self.Primary.Force )
tr.Entity:TakeDamageInfo( dmginfo )
end
if !tr.Hit then
self:EmitSound( "Weapon_ez_StunStick.Swing" )
self:SetNextPrimaryFire( CurTime() + self.Primary.DelayMiss )
self:SetNextSecondaryFire( CurTime() + self.Secondary.DelayMiss )
self.Weapon:SendWeaponAnim( ACT_VM_MISSCENTER )
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
self.Charging = 0
self.ChargingTimer = CurTime()
end
if tr.Hit then
self:EmitSound( "Weapon_ez_StunStick.Charged_Hit" )
self:SetNextPrimaryFire( CurTime() + self.Primary.DelayHit )
self:SetNextSecondaryFire( CurTime() + self.Secondary.DelayHit )
self.Weapon:SendWeaponAnim( ACT_VM_HITCENTER )
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
self.Charging = 0
self.ChargingTimer = CurTime()
end
self.Owner:LagCompensation( false )
self.Owner:SetAnimation( PLAYER_ATTACK1 )
self.Owner:ViewPunchReset()
self.Owner:ViewPunch( Angle( math.Rand( 1, 2 ), math.Rand( -3.5, -1.5 ), 0 ) )
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end
end
