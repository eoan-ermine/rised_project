-- "lua\\weapons\\weapon_ez2_mp5k\\shared.lua"
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
SWEP.PrintName				= "MP5K"		-- Weapon name (Shown on HUD)
SWEP.Slot				= 2		-- Slot in the weapon selection menu.  Subtract 1, as this starts at 0.
SWEP.SlotPos				= 20			-- Position in the slot
SWEP.DrawAmmo				= true		-- Should draw the default HL2 ammo counter if enabled in the GUI.
SWEP.DrawWeaponInfoBox			= false		-- Should draw the weapon info box
SWEP.BounceWeaponIcon   		= 	false	-- Should the weapon icon bounce?
SWEP.AutoSwitchTo			= true		-- Auto switch to if we pick it up
SWEP.AutoSwitchFrom			= true		-- Auto switch from if you pick up a better weapon
SWEP.Weight				= 30			-- This controls how "good" the weapon is for autopickup.
SWEP.UseHands = true
SWEP.ViewModel        = "models/weapons/c_mp5k.mdl"
SWEP.WorldModel = "models/weapons/w_mp5k.mdl"

SWEP.Primary.Automatic			= true
SWEP.Primary.ClipSize = 30
SWEP.Primary.Delay = 0.10 
SWEP.Primary.DefaultClip = 200
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Sound = Sound ( "Weapon_MP5K.Single" )

SWEP.HoldType = "smg"

SWEP.Idle = 0
SWEP.IdleTimer = CurTime()

SWEP.Secondary.ClipSize = 3
SWEP.Secondary.Delay = 1
SWEP.Secondary.Damage = 0
SWEP.Secondary.DefaultClip = 1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

function SWEP:Reload()
	if self.Weapon:DefaultReload(ACT_VM_RELOAD) then
       self:EmitSound( "Weapon_MP5K.Reload" )
end
		self.Idle = 0
		self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:Initialize()
self:SetWeaponHoldType( self.HoldType )
self.Idle = 0
self.IdleTimer = CurTime() + 4
end

function SWEP:DrawWeaponSelection(x,y,wide,tall)
local c=self.TextColor or Color(255,220,0)
draw.SimpleText("f","WeaponIcons",x+wide/2,y+tall*.2,c,TEXT_ALIGN_CENTER)
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

	if ( IsFirstTimePredicted() ) then
		local bullet = {}
		bullet.Num = 1
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
			if GetConVar( "sk_ez_no_bullet_spread" ):GetInt() == 0 then
				bullet.Spread = Vector( 0.03, 0.03, 0 )
			else
				bullet.Spread = Vector( 0, 0, 0 )
			end
		bullet.Force = 5
		bullet.Damage = self.Primary.Damage
		self.Owner:FireBullets( bullet )
		
		self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
			if GetConVar( "sk_ez_infinite_ammo" ):GetInt() == 0 then
				self:TakePrimaryAmmo( 1 )
			else
				self:TakePrimaryAmmo( 0 )
			end
		self:EmitSound(self.Primary.Sound)
		self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	    self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	end
		self.Idle = 0
		self.IdleTimer = CurTime() + self.Owner:GetViewModel():SequenceDuration()
end

function SWEP:SecondaryAttack()
 
end

function SWEP:Think()
self.Primary.Damage = GetConVar( "sk_ez2_mp5k_dmg" ):GetInt()
if self.Idle == 0 and self.IdleTimer < CurTime() then
if SERVER then
self.Weapon:SendWeaponAnim( ACT_VM_IDLE )
end
self.Idle = 1
end
end
if ( SERVER ) then return end
killicon.AddFont( "weapon_ez2_mp5k", "WeaponIcons", "f", Color( 255, 80, 0, 255 ) )