-- "lua\\weapons\\weapon_metropolice_usp_match\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
AddCSLuaFile( "shared.lua" )
SWEP.HoldType = "pistol"
end
if CLIENT then
language.Add("weapon_metropolice_usp_match", "USP Match")
killicon.Add( "weapon_metropolice_usp_match", "effects/killicons/weapon_metropolice_usp_match", color_white )

SWEP.WepSelectIcon = surface.GetTextureID("HUD/swepicons/metropolice_usp_match_icon") 
SWEP.DrawWeaponInfoBox	= false
SWEP.BounceWeaponIcon = false

SWEP.PrintName = "USP Match (no voice)"
SWEP.Slot = 1
SWEP.SlotPos = 4
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true
SWEP.ViewModelFOV = 58
SWEP.ViewModelFlip = false
end

SWEP.ViewModel = "models/weapons/metropolice_smg/usp/v_usp_match.mdl"
SWEP.WorldModel = "models/weapons/metropolice_smg/usp/w_usp_match.mdl"
SWEP.Category	= "Civil Protection"
SWEP.HoldType			= "Pistol"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.FiresUnderwater		= true

game.AddAmmoType( { name = "9x19_mm_Luger" } )
if ( CLIENT ) then language.Add( "9x19_mm_Luger_ammo", "9x19 mm Luger ammo" ) end

SWEP.Primary.ClipSize = 18
SWEP.Primary.DefaultClip = 150
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.18
SWEP.Primary.Ammo = "9x19_mm_Luger"
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Recoil = 0.24
SWEP.Primary.Spread = 0.05
SWEP.Primary.Force = 4
SWEP.Primary.Damage = 9
SWEP.Primary.NumberofShots = 1

SWEP.Secondary.ClipSize = 18
SWEP.Secondary.DefaultClip = 150
SWEP.Secondary.Automatic = true
SWEP.Secondary.Delay = 0.2
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Recoil = 0.37
SWEP.Secondary.Spread = 0.32
SWEP.Secondary.Damage = 8


function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW);
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration())
	self:SetNextSecondaryFire( CurTime() + self:SequenceDuration())
	self:NextThink( CurTime() + self:SequenceDuration() )
	self.Owner:EmitSound(Sound("weapons/metropolice_smg/usp_match/usp_draw.wav"))
	self:Idle()
	return true
end

function SWEP:Holster()
return true
end


function SWEP:Think()
if ( self.Owner:KeyReleased( IN_ATTACK ) || ( !self.Owner:KeyDown( IN_ATTACK ) && self.Sound ) ) then		
self:Idle()
end
end


function SWEP:Reload()
	if ( self:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
	if self.Weapon:DefaultReload(ACT_VM_RELOAD) then
		self:SetNextPrimaryFire( CurTime() + self:SequenceDuration())
		self:NextThink( CurTime() + self:SequenceDuration() )
		self.Owner:EmitSound(Sound("weapons/metropolice_smg/usp_match/usp_reload.wav")) 
		self:Idle()
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
	self.Owner:EmitSound(Sound("weapons/metropolice_smg/usp_match/usp_shoot.wav"))
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) )
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
end


function SWEP:SecondaryAttack()	
	if ( !self:CanPrimaryAttack() ) then return end
	local bullet = {}
		bullet.Num = self.Primary.NumberofShots
		bullet.Src = self.Owner:GetShootPos()
		bullet.Dir = self.Owner:GetAimVector()
		bullet.Spread = Vector( self.Secondary.Spread * 0.1 , self.Secondary.Spread * 0.1, 0)
		bullet.Tracer = 1
		bullet.Force = self.Primary.Force
		bullet.Damage = self.Secondary.Damage
		bullet.AmmoType = self.Primary.Ammo
		bullet.TracerName = "AirboatGunTracer"
		bullet.Callback = function ( attacker, tr, dmginfo ) 
			dmginfo:SetDamageType(DMG_AIRBOAT);
		end
	local rnda = self.Secondary.Recoil * -1
	local rndb = self.Secondary.Recoil * math.random(-1, 1)
	self:ShootEffects()
	self.Owner:FireBullets( bullet )
	self.Owner:EmitSound(Sound("weapons/metropolice_smg/usp_match/usp_shoot1.wav"))
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) )
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
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


function SWEP:Holster( weapon )
if ( CLIENT ) then return end
self:StopIdle()
return true
end