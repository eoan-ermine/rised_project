-- "addons\\hl2_meleepack\\lua\\weapons\\weapon_hl2pipe\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

AddCSLuaFile()

SWEP.PrintName				= "Pipe"
SWEP.Author				= "Dr. Towers"
SWEP.Instructions			= "Primary attack: Swing"
SWEP.Category				= "HL2 Melee Pack"

SWEP.Slot				= 1
SWEP.SlotPos				= 0

SWEP.Spawnable				= true

SWEP.ViewModel				= Model( "models/weapons/HL2meleepack/v_pipe.mdl" )
SWEP.WorldModel				= Model( "models/props_canal/mattpipe.mdl" )
SWEP.ViewModelFOV			= 62
SWEP.UseHands				= true

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo		= "none"

SWEP.DrawAmmo			= false

SWEP.HitDistance		= 40
SWEP.HitInclination		= 0.2
SWEP.HitPushback		= 400
SWEP.HitRate			= 1.10
SWEP.MinDamage			= 20
SWEP.MaxDamage			= 27
SWEP.Weight = 1.1

local SwingSound = Sound( "WeaponFrag.Roll" )
local HitSoundWorld = Sound( "Canister.ImpactHard" )
local HitSoundBody = Sound( "Flesh.ImpactHard" )

function SWEP:Initialize()

	self:SetHoldType( "melee" )
end

function SWEP:PrimaryAttack()

	self.Owner:SetAnimation( PLAYER_ATTACK1 )

	local vm = self.Owner:GetViewModel()
	
	self:EmitSound( SwingSound )
	self.Weapon:SetNextPrimaryFire( CurTime() + self.HitRate )

	vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )

	timer.Create("hitdelay", 0.2, 1, function() self:Hitscan() end)

	timer.Start( "hitdelay" )

end

function SWEP:SecondaryAttack()
	
	return true
end

function SWEP:OnDrop()

	
end

function SWEP:Hitscan()

//This function calculate the trajectory

	for i=0, 170 do

	local tr = util.TraceLine( {
		start = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 10)),
		endpos = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 10)) + ( self.Owner:EyeAngles():Up() * ( self.HitDistance * 0.7 * math.cos(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Forward() * ( self.HitDistance * 1.5 * math.sin(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Right() * self.HitInclination * self.HitDistance * math.cos(math.rad(i)) ),
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )

//This if shot the bullets

	if ( tr.Hit ) then
		
		local strikevector = ( self.Owner:EyeAngles():Up() * ( self.HitDistance * 0.5 * math.cos(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Forward() * ( self.HitDistance * 1.5 * math.sin(math.rad(i)) ) ) + ( self.Owner:EyeAngles():Right() * self.HitInclination * self.HitDistance * math.cos(math.rad(i)) )

		
		bullet = {}
		bullet.Num    = 1
		bullet.Src    = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 15))
		bullet.Dir    = strikevector:GetNormalized()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force  = 10
		bullet.Hullsize = 0
		bullet.Distance = self.HitDistance * 1.5
		bullet.Damage = math.random( 34, 50 )
		self.Owner:FireBullets(bullet)

		//local vPoint = (self.Owner:GetShootPos() - (self.Owner:EyeAngles():Up() * 10))
		//local effectdata = EffectData()
		//effectdata:SetOrigin( vPoint )
		//util.Effect( "BloodImpact", effectdata )

		self:EmitSound( SwingSound )

		//vm:SendViewModelMatchingSequence( vm:LookupSequence( "hitcenter1" ) )

		if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") then
			self:EmitSound( HitSoundBody )
			tr.Entity:SetVelocity( self.Owner:GetAimVector() * Vector( 1, 1, 0 ) * self.HitPushback )
		else
			self:EmitSound( HitSoundWorld )
		end
//if break
		break
//if end
		//else vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )
		end
end

end

function SWEP:Deploy()

	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence( vm:LookupSequence( "draw" ) )
	
	self.Weapon:SetNextPrimaryFire( CurTime() + 0.5 )
	
	return true
end

function SWEP:Holster()

	return true
end

function SWEP:OnRemove()

	timer.Remove("hitdelay")
	return true
end