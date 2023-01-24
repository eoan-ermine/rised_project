-- "lua\\weapons\\weapon_metropolice_oicw\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
AddCSLuaFile( "shared.lua" )
SWEP.HoldType = "ar2"
end
if CLIENT then
language.Add("weapon_metropolice_oicw", "Metropolice OICW")
killicon.Add( "weapon_metropolice_oicw", "effects/killicons/weapon_metropolice_oicw", color_white )

SWEP.PrintName = "OICW (no voice)"
SWEP.Slot = 2
SWEP.SlotPos = 4
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true
SWEP.ViewModelFOV = 64
SWEP.ViewModelFlip = false

SWEP.WepSelectIcon = surface.GetTextureID("HUD/swepicons/metropolice_oicw_icon") 
SWEP.DrawWeaponInfoBox	= false
SWEP.BounceWeaponIcon = false 
end
	
SWEP.ViewModel = "models/weapons/metropolice_smg/oicw/v_oicw.mdl"
SWEP.WorldModel = "models/weapons/metropolice_smg/oicw/w_oicw.mdl"
SWEP.Category 			= "Civil Protection"
SWEP.HoldType			= "ar2"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.FiresUnderwater		= true

game.AddAmmoType( { name = "5,56x45_mm_NATO" } )
if ( CLIENT ) then language.Add( "5,56x45_mm_NATO_ammo", "5,56x45 mm NATO ammo" ) end

SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 150
SWEP.Primary.Automatic = true
SWEP.Primary.Delay = 0.10
SWEP.Primary.Ammo = "5,56x45_mm_NATO"
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Recoil = 0.50
SWEP.Primary.Spread = 0.30
SWEP.Primary.Force = 7
SWEP.Primary.Damage = 15
SWEP.Primary.NumberofShots = 1

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"
SWEP.Secondary.Delay		= 0.9

SWEP.Zoom = 0


function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW);
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration())
	self:SetNextSecondaryFire( CurTime() + self:SequenceDuration())
	self:NextThink( CurTime() + self:SequenceDuration() )
	self.Owner:EmitSound(Sound("weapons/metropolice_smg/oicw/oicw_draw.wav"))
	self:Idle()
	return true
end


function SWEP:Initialize()
self:SetWeaponHoldType(self.HoldType)
end
	

function SWEP:Holster()
	local OWNER = self:GetOwner()
	if (OWNER && OWNER:IsValid() && OWNER:IsPlayer() && OWNER:Alive()) then
	self.Owner:SetFOV( 0, .5 )
	self.Owner:DrawViewModel(true)
	self:StopIdle()
	self.Owner:ConCommand("pp_mat_overlay \"\"");
	self.Zoom = 0
	end
	return true
end

function SWEP:Reload( )
	if ( self:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
	if self.Weapon:DefaultReload(ACT_VM_RELOAD) then
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration())
	self:NextThink( CurTime() + self:SequenceDuration() )
	self.Owner:EmitSound(Sound("weapons/metropolice_smg/oicw/oicw_reload.wav"))
	self:Idle()
	self.Owner:SetFOV( 0, .1 )
	self.Owner:DrawViewModel(true)
	self.Owner:ConCommand("pp_mat_overlay \"\"");
	self.Zoom = 0
		end
	end
end


function SWEP:PrimaryAttack()
	if ( !self:CanPrimaryAttack() ) then return end
	local bullet = {}
		bullet.Num = self.Primary.NumberofShots
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector( self.Primary.Spread * 0.1 , self.Primary.Spread * 0.1, 0)
		bullet.Tracer = 1
		bullet.Force = self.Primary.Force
		bullet.Damage = self.Primary.Damage
		bullet.AmmoType = self.Primary.Ammo
		bullet.TracerName = "AirboatGunTracer"
		bullet.Callback = function ( attacker, tr, dmginfo ) 
			dmginfo:SetDamageType(DMG_AIRBOAT);
		end
	local rnda = self.Primary.Recoil * -1
	local rndb = 0
	self:ShootEffects()
	self.Owner:FireBullets( bullet )
	self.Owner:EmitSound(Sound("weapons/metropolice_smg/oicw/oicw_shoot.wav"))
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) )
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
end


function SWEP:SecondaryAttack()
	if(self.Zoom == 0) then
		self.Owner:SetFOV( 22, .2 )
		self.Owner:DrawViewModel(false)
		self.Owner:ConCommand("pp_mat_overlay effects/scope/scope_overlay.vmt");
		self:EmitSound("weapons/metropolice_smg/oicw/scope/binoculars_zoomin.wav")
			self.Zoom = 1
	else
		self.Owner:SetFOV( 0, .2 )
		self.Owner:DrawViewModel(true)
		self.Owner:ConCommand("pp_mat_overlay \"\"");
		self:EmitSound("weapons/metropolice_smg/oicw/scope/binoculars_zoomout.wav")
			self.Zoom = 0
	end
end


function SWEP:Think()
if ( self.Owner:KeyReleased( IN_ATTACK ) || ( !self.Owner:KeyDown( IN_ATTACK ) && self.Sound ) ) then		
self:Idle()
end
end


function SWEP:Idle()
if ( CLIENT || !IsValid( self.Owner ) ) then return end
timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration() - 0.2, 1, function()
if ( !IsValid( self ) ) then return end
self:DoIdle()
end )
end


function SWEP:DoIdleAnimation()
self:SendWeaponAnim( ACT_VM_IDLE )
end


function SWEP:DoIdle()
self:DoIdleAnimation()
timer.Adjust( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 0, function()
if ( !IsValid( self ) ) then timer.Destroy( "weapon_idle" .. self:EntIndex() ) return end
self:DoIdleAnimation()
end )
end


function SWEP:StopIdle()
timer.Destroy( "weapon_idle" .. self:EntIndex() )
end