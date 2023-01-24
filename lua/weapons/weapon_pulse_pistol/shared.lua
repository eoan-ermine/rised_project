-- "lua\\weapons\\weapon_pulse_pistol\\shared.lua"
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
SWEP.PrintName				= "Pulse Pistol"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 1			-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 20			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter if enabled in the GUI.
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30			-- This controls how "good" the weapon is for autopickup.
SWEP.UseHands = true
SWEP.ViewModel        = "models/weapons/c_pulsepistol.mdl"
SWEP.WorldModel = "models/weapons/w_pulsepistol.mdl"

SWEP.Primary.Automatic			= true
SWEP.Primary.ClipSize = 50
SWEP.Primary.Delay = 0.6
SWEP.Primary.DefaultClip = 50
SWEP.Primary.Ammo = "none"

SWEP.MaxAmmo = 50
SWEP.HoldType = "revolver"

SWEP.Idle = 0
SWEP.IdleTimer = CurTime()
SWEP.Charge = 0

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.Delay = 1.95
SWEP.Secondary.Damage = 125
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

function SWEP:Reload()
self.Weapon:DefaultReload(ACT_VM_RELOAD) 
self.Idle = 0
self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:Initialize()
self:SetWeaponHoldType( self.HoldType )
self.Idle = 0
self.IdleTimer = CurTime() + 4
if ( CLIENT ) then return end

	timer.Create( "pulse_ammo" .. self:EntIndex(), 0.2, 0, function()
		if ( self:Clip1() < self.MaxAmmo ) then self:SetClip1( math.min( self:Clip1() + 1, self.MaxAmmo ) ) end
	end )
end

function SWEP:DrawWeaponSelection(x,y,wide,tall)
local c=self.TextColor or Color(255,220,0)
draw.SimpleText("d","WeaponIcons",x+wide/2,y+tall*.2,c,TEXT_ALIGN_CENTER)
self:PrintWeaponInfo(x+wide+20,y+tall*.95,alpha)
end

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	self.Idle = 0
	self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
    if self:Clip1() > 10 then
	if ( IsFirstTimePredicted() ) then
		local bullet = {}
		bullet.Num = 1
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = (self.Owner:EyeAngles()+self.Owner:GetViewPunchAngles()):Forward() 
			if GetConVar( "sk_ez_no_bullet_spread" ):GetInt() == 0 then
				bullet.Spread = Vector( 0.01, 0.01, 0 )
			else
				bullet.Spread = Vector( 0, 0, 0 )
			end
		bullet.Force = 5
		bullet.Damage = self.Primary.Damage
		bullet.TracerName = "AR2Tracer"
		self.Owner:FireBullets( bullet )
			if GetConVar( "sk_ez_no_recoil" ):GetInt() == 0 then
				self.Owner:ViewPunch(Angle( -2, math.Rand( -2, 2 ),0))
			end
		
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
			if GetConVar( "sk_ez_infinite_ammo" ):GetInt() == 0 then
				self:TakePrimaryAmmo( 10 )
			else
				self:TakePrimaryAmmo( 0 )
			end
		self:EmitSound("Weapon_PulsePistol.Single")

		self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
end
		self.Idle = 0
		self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end
end

function SWEP:SecondaryAttack()
    if self:Clip1() > 10 then
		local bullet = {}
		bullet.Num = 1
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = (self.Owner:EyeAngles()+self.Owner:GetViewPunchAngles()):Forward() 
		bullet.Spread = Vector( 0.01, 0.01, 0 )
		bullet.Force = 5
		bullet.Damage = (self.Primary.Damage + 1*(self:Clip1() - 10))
		bullet.TracerName = "AR2Tracer"
		self.Owner:FireBullets( bullet )
		self.Owner:ViewPunch(Angle( -2, math.Rand( -2, 2 ),0))
		
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
			if GetConVar( "sk_ez_infinite_ammo" ):GetInt() == 0 then
				self:TakePrimaryAmmo(self:Clip1() - 10)
			else
				self:TakePrimaryAmmo( 0 )
			end
		self:EmitSound("Weapon_PulsePistol.ChargeFire")

		self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
end
		self.Idle = 0
		self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:Think()
self.Primary.Damage = GetConVar( "sk_ez2_pulse_pistol_dmg" ):GetInt()
if self.Idle == 0 and self.IdleTimer < CurTime() then
if SERVER then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
end
self.Idle = 1
end
end

function SWEP:OnRemove()

	timer.Stop( "pulse_ammo" .. self:EntIndex() )

end

function SWEP:CustomAmmoDisplay()

	self.AmmoDisplay = self.AmmoDisplay or {}
	self.AmmoDisplay.Draw = true
	self.AmmoDisplay.PrimaryClip = self:Clip1()

	return self.AmmoDisplay

end

if ( SERVER ) then return end
killicon.AddAlias( "weapon_pulse_pistol", "weapon_pistol" )
