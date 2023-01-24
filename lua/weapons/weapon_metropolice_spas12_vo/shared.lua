-- "lua\\weapons\\weapon_metropolice_spas12_vo\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
AddCSLuaFile( "shared.lua" )
SWEP.HoldType = "shotgun"
end
if CLIENT then
language.Add("weapon_metropolice_spas12_vo", "Metropolice SPAS-12")
killicon.Add( "weapon_metropolice_spas12_vo", "effects/killicons/weapon_metropolice_spas12", color_white )

SWEP.PrintName = "SPAS-12"
SWEP.Slot = 3
SWEP.SlotPos = 4
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true
SWEP.ViewModelFOV = 55
SWEP.ViewModelFlip = false

SWEP.WepSelectIcon = surface.GetTextureID("HUD/swepicons/metropolice_spas12_icon")
SWEP.DrawWeaponInfoBox	= false
SWEP.BounceWeaponIcon = false
end

SWEP.ViewModel = "models/weapons/metropolice_smg/spas12/v_spas12.mdl"
SWEP.WorldModel = "models/weapons/metropolice_smg/spas12/w_spas12.mdl"
SWEP.Category 			= "Civil Protection"
SWEP.HoldType			= "shotgun"
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.FiresUnderwater		= true

game.AddAmmoType( { name = ".12_caliber" } )
if ( CLIENT ) then language.Add( ".12_caliber_ammo", ".12 caliber ammo" ) end

SWEP.Primary.ClipSize = 8
SWEP.Primary.DefaultClip = 64
SWEP.Primary.Automatic = false
SWEP.Primary.Delay = 0.75
SWEP.Primary.Ammo = ".12_caliber"
SWEP.Primary.TakeAmmo = 1
SWEP.Primary.Recoil = 2
SWEP.Primary.Spread = 1
SWEP.Primary.Force = 9
SWEP.Primary.Damage = 6
SWEP.Primary.NumberofShots = 9
SWEP.Primary.Sound = "weapons/metropolice_smg/spas12/spas12_shot.wav"
SWEP.Primary.PumpSound = "weapons/metropolice_smg/spas12/spas12_pump.wav"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"


local deploy_vo = {"vo/npc/metropolice_beta/deploy01.wav",
"vo/npc/metropolice_beta/deploy02.wav",
"vo/npc/metropolice_beta/deploy03.wav",
"vo/npc/metropolice_beta/deploy04.wav",
"vo/npc/metropolice_beta/deploy05.wav",
"vo/npc/metropolice_beta/deploy06.wav"
}

local attack_vo = {"vo/npc/metropolice_beta/hiding01.wav",
"vo/npc/metropolice_beta/hiding02.wav",
"vo/npc/metropolice_beta/hiding03.wav",
"vo/npc/metropolice_beta/hiding04.wav",
"vo/npc/metropolice_beta/hiding05.wav",
"vo/npc/metropolice_beta/pointer01.wav",
"vo/npc/metropolice_beta/pointer02.wav",
"vo/npc/metropolice_beta/pointer04.wav",
"vo/npc/metropolice_beta/shooter03.wav"
}


function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW);
	self.Owner:EmitSound(deploy_vo[math.random(1,6)])
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration())
	self:SetNextSecondaryFire( CurTime() + self:SequenceDuration())
	self:NextThink( CurTime() + self:SequenceDuration() )
	self.Owner:EmitSound(Sound("weapons/metropolice_smg/spas12/spas12_draw.wav"))
	self:Idle()
	return true
end


function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	self.VoiceInterval = 0
	pumptime = 0
	pump = false
end
	

function SWEP:Holster()
	return true
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
	self.Owner:EmitSound(Sound( self.Primary.Sound ))
	self.Owner:ViewPunch( Angle( rnda,rndb,rnda ) )
	self:AttackVoice()
	self:TakePrimaryAmmo(self.Primary.TakeAmmo)
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	pumptime = CurTime() + (self.Primary.Delay / 2)
	pump = true
end


function SWEP:SecondaryAttack()	
self.Weapon:SetNextSecondaryFire( CurTime() + 2 )
if SERVER then
self.Owner:EmitSound("vo/npc/metropolice_beta/getonground.wav")
end
end


function SWEP:Reload()
	if ( self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
		timer.Create("ammo_add"..self.EntIndex(), 0.35, (self.Primary.ClipSize - self.Weapon:Clip1()), function()
			if not self.Weapon or not self.Owner then return end	
			if self:Ammo1() <= 0 then return end
			if self.Weapon:Clip1() > self.Primary.ClipSize then return end
		
			self.Owner:RemoveAmmo(1, self.Weapon:GetPrimaryAmmoType())
			self.Weapon:SetClip1(self.Weapon:Clip1() + 1)
		
			self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
			--self.Owner:SetAnimation(PLAYER_RELOAD)
			self.Owner:EmitSound(Sound("weapons/metropolice_smg/spas12/spas12_load.wav"))
			
			timer.Create("reload_finish"..self.EntIndex(), 0.35, 1, function()
				self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
			end)
			
		end)
	end
	
	return true
	
end


function SWEP:AttackVoice()

if CurTime() > self.VoiceInterval then
	if SERVER then
	self.Owner:EmitSound(attack_vo[math.random(1,9)])
	end
	self.VoiceInterval = CurTime() + 5
end
end


function SWEP:Think()
	if ( pump == true && pumptime <= CurTime() ) then
		self.Weapon:SendWeaponAnim( ACT_SHOTGUN_PUMP )
		self.Owner:EmitSound(Sound(self.Primary.PumpSound))
		pump = false
		end
end


function SWEP:Holster( weapon )
if ( CLIENT ) then return end
self:StopIdle()
return true
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