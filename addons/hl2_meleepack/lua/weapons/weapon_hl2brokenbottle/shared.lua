-- "addons\\hl2_meleepack\\lua\\weapons\\weapon_hl2brokenbottle\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

AddCSLuaFile()

SWEP.PrintName				= "Broken Bottle"
SWEP.Author				= "Dr. Towers"
SWEP.Instructions			= "Primary attack: Stab"
SWEP.Category				= "HL2 Melee Pack"

SWEP.Slot				= 1
SWEP.SlotPos				= 0

SWEP.Spawnable				= true

SWEP.ViewModel				= Model( "models/weapons/HL2meleepack/v_brokenbottle.mdl" )
SWEP.WorldModel				= Model( "models/weapons/HL2meleepack/w_brokenbottle.mdl" )
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

SWEP.HitDistance		= 28
SWEP.HitInclination		= 0.2
SWEP.HitPushback		= 0
SWEP.HitRate			= 0.50
SWEP.MinDamage			= 5
SWEP.MaxDamage			= 15
SWEP.Weight = 0.15

local SwingSound = Sound( "WeaponFrag.Roll" )
local HitSoundWorld = Sound( "GlassBottle.ImpactHard" )
local HitSoundBody = Sound( "Flesh_Bloody.ImpactHard" )

function SWEP:Initialize()

	self:SetHoldType( "knife" )
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

	local tr = util.TraceLine( {
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * self.HitDistance * 1.5 ),
		filter = self.Owner,
		mask = MASK_SHOT_HULL
	} )

//This if shot the bullets

	if ( tr.Hit ) then
		
		bullet = {}
		bullet.Num    = 1
		bullet.Src    = self.Owner:GetShootPos()
		bullet.Dir    = self.Owner:GetAimVector()
		bullet.Spread = Vector(0, 0, 0)
		bullet.Tracer = 0
		bullet.Force  = 5
		bullet.Hullsize = 0
		bullet.Distance = self.HitDistance * 1.5
		bullet.Damage = math.random( 5, 15 )
		self.Owner:FireBullets(bullet)

		self:EmitSound( SwingSound )

		//vm:SendViewModelMatchingSequence( vm:LookupSequence( "hitcenter1" ) )

		if tr.Entity:IsPlayer() or string.find(tr.Entity:GetClass(),"npc") or string.find(tr.Entity:GetClass(),"prop_ragdoll") then
			self:EmitSound( HitSoundBody )
		else
			self:EmitSound( HitSoundWorld )
		end

	
//if end
		//else vm:SendViewModelMatchingSequence( vm:LookupSequence( "misscenter1" ) )
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