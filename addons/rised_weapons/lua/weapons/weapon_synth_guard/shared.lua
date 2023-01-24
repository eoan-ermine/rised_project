-- "addons\\rised_weapons\\lua\\weapons\\weapon_synth_guard\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= true
	SWEP.AutoSwitchFrom		= true
    SWEP.Base			= "weapon_base"
	util.AddNetworkString("RisedNet_SynthAnim_Guard")
end

if CLIENT then
	
	language.Add("weapon_bp_guardgun", "Guardian")    	
	SWEP.Category = "A - Rised - [Оружие]"
	SWEP.PrintName = "Guard Gun"	
	SWEP.Slot = 0
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
	SWEP.ViewModelFOV = 58
	SWEP.ViewModelFlip = false

	SWEP.WepSelectIcon = surface.GetTextureID("HUD/swepicons/weapon_guardgun") 
	SWEP.DrawWeaponInfoBox	= false
	SWEP.BounceWeaponIcon = false 

	net.Receive("RisedNet_SynthAnim_Guard", function(len)
		local ply = net.ReadEntity()
		local anim = net.ReadInt(10)
		if !IsValid(ply) then return end

		if anim == 1 then
			local seq1 = ply:LookupSequence("idleact")
			ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, seq1, 1, true)
		elseif anim == 2 then
			local seq1 = ply:LookupSequence("idleact")
			local seq2 = ply:LookupSequence("actidle01")
			ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, seq1, 0, true)
			timer.Simple(1, function()
				ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, seq2, 1, false)
			end)
		elseif anim == 3 then
			local seq1 = ply:LookupSequence("fire")
			local seq2 = ply:LookupSequence("actidle01")
			ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, seq1, 0, true)
			timer.Simple(1.8, function()
				ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, seq2, 1, false)
			end)
		end
	end)
end

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_gu4rdgun.mdl"
SWEP.WorldModel			= "models/weapons/w_guardgun.mdl"
SWEP.HoldType			= "rpg"


SWEP.Cannon = {}
SWEP.Cannon.ShootSound		= Sound("weapons/1cguard/cguard_fire.wav")
SWEP.Cannon.ChargeSound		= Sound("weapons/1cguard/charging.wav")
SWEP.Cannon.BoomSound		= Sound("Weapon_Mortar.Impact")
SWEP.Cannon.Damage			= 500
SWEP.Cannon.Radius			= 350
SWEP.Cannon.Delay			= 2
SWEP.Cannon.Recoil			= 8

game.AddAmmoType( { name = "bp_guard" } )
if ( CLIENT ) then language.Add( "bp_guard_ammo", "Warp Ammo" ) end

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 3
SWEP.Primary.Automatic	= false
SWEP.Primary.Ammo			= "bp_guard"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

function SWEP:Deploy()
	---------------
	self.Owner:SetNWBool("Rised_Synth_Guard_Armed", false)
	self.Owner:SetModel("models/orion/combine_guard.mdl")

	local seq = self.Owner:LookupSequence("Idle01")
	local act = ACT_VM_IDLE

	if self.Owner:GetSequenceInfo(seq) != nil then
		act = self.Owner:GetSequenceInfo(seq).activity
		self.Owner:ResetSequence( seq )
	end
	-------------

	self.Weapon:SendWeaponAnim(ACT_VM_DRAW);
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration())
	self:SetNextSecondaryFire( CurTime() + self:SequenceDuration())
	self:NextThink( CurTime() + self:SequenceDuration() )
	self:Idle()
	return true
end

function SWEP:Holster( weapon )
	self.Owner:SetModel("models/player/soldier_stripped.mdl")
	self.Owner:SetWalkSpeed(240)
	if ( CLIENT ) then return end

	self:StopIdle()
	
	return true
end

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	self.Charging = false
	self.cd = 0
end

function SWEP:Think()	
	if ( self.Owner:KeyReleased( IN_ATTACK ) || ( !self.Owner:KeyDown( IN_ATTACK ) && self.Sound ) ) then		
		self:Idle()
	end
end

function SWEP:PrimaryAttack()

	if !self.Owner:GetNWBool("Rised_Synth_Guard_Armed") then return end

	if (!self:CanPrimaryAttack()) then
	
		self.Weapon:EmitSound("Weapon_Pistol.Empty")
		self.Weapon:SetNextPrimaryFire(CurTime() + 0.2)
		self.Weapon:SetNextSecondaryFire(CurTime() + 0.2)
		return
		
	end

	if SERVER then
		net.Start("RisedNet_SynthAnim_Guard")
		net.WriteEntity(self.Owner)
		net.WriteInt(3,10)
		net.Broadcast()
	end

	self.Weapon:SetNextSecondaryFire(CurTime() + 1.35 + self.Cannon.Delay)
	self.Weapon:SetNextPrimaryFire(CurTime() + 1.35 + self.Cannon.Delay)

	self.Weapon:EmitSound(self.Cannon.ChargeSound)
	
	local fx = EffectData()
	fx:SetEntity(self.Owner)
	fx:SetAttachment(1)
	util.Effect("bp_guardgun_charge",fx)
	
	self.Charging = true
	
	if CLIENT then return end
	timer.Simple(1, function() self:ShootCannon() end)
end

function SWEP:SecondaryAttack()
	if SERVER and self.cd <= CurTime() then
		self.cd = CurTime() + 1
		if self.Owner:GetNWBool("Rised_Synth_Guard_Armed") then
			net.Start("RisedNet_SynthAnim_Guard")
			net.WriteEntity(self.Owner)
			net.WriteInt(1,10)
			net.Broadcast()
			timer.Simple(0.5, function()
				self.Owner:SetNWBool("Rised_Synth_Guard_Armed", false)
				self.Owner:SetWalkSpeed(100)
			end)
		else
			net.Start("RisedNet_SynthAnim_Guard")
			net.WriteEntity(self.Owner)
			net.WriteInt(2,10)
			net.Broadcast()
			self.Owner:SetNWBool("Rised_Synth_Guard_Armed", true)
			self.Owner:SetWalkSpeed(1)
		end
	end
	self:SetNextSecondaryFire(1)
end

function SWEP:ShootCannon()

	if not self.Charging then return end
	if not self.Weapon or not self.Weapon:IsValid() then return end
	if not self.Owner or not self.Owner:Alive() then return end

	local PlayerPos = self.Owner:GetShootPos() 
	local tr = self.Owner:GetEyeTrace()
	
	local dist = (tr.HitPos - PlayerPos):Length()
	local delay = dist/8000
	
	self:TakePrimaryAmmo(1)
	
	self.Weapon:EmitSound(self.Cannon.ShootSound)
	
	local fx = EffectData()
	fx:SetEntity(self.Owner)
	fx:SetOrigin(tr.HitPos)
	fx:SetAttachment(1)
	util.Effect("bp_guardgun_fire",fx)
	util.Effect("bp_guardgun_mzzlflash",fx)
	
	--play animations
	self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	--apply recoil
	self.Owner:ViewPunch( Angle(math.Rand(-0.2,-0.1)*self.Cannon.Recoil,math.Rand(-0.1,0.1)*self.Cannon.Recoil, 0))
	
	timer.Simple(delay, function() self:Disintegrate(tr) end)

end

function SWEP:Disintegrate(tr)

	local fx = EffectData()
	fx:SetOrigin(tr.HitPos)
	fx:SetNormal(tr.HitNormal)
	util.Effect("bp_guardgun_expld",fx)
	
	if CLIENT then return end

	local splodepos = tr.HitPos + 3*tr.HitNormal

	local vaporizer = ents.Create("point_hurt")
	vaporizer:SetKeyValue("Damage",self.Cannon.Damage)
	vaporizer:SetKeyValue("DamageRadius",self.Cannon.Radius)
	vaporizer:SetKeyValue("DamageType",DMG_DISSOLVE)// DMG_BLAST)
	vaporizer:SetPos(splodepos)
	vaporizer:SetOwner(self.Owner)
	vaporizer:Spawn()
	vaporizer:Fire("hurt","",0)
	vaporizer:Fire("kill","",0.1)
	
	vaporizer:EmitSound(self.Cannon.BoomSound)

end

function SWEP:Reload( )
	if ( self:Clip1() < self.Primary.ClipSize && self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
	if self.Weapon:DefaultReload(ACT_VM_RELOAD) then
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration())
	self:SetNextSecondaryFire( CurTime() + self:SequenceDuration())
	self:NextThink( CurTime() + self:SequenceDuration() )
	self:Idle()
		end
	end
end


local StriderBulletCallback = function(attacker, tr, dmginfo)

	local fx = EffectData()
	fx:SetOrigin(tr.HitPos)
	fx:SetNormal(tr.HitNormal)
	fx:SetScale(20)
	util.Effect("cball_bounce",fx)
	util.Effect("AR2Impact",fx)

	return true

end

function SWEP:ShootStriderBullet(dmg, recoil, numbul, cone)

	--send the bullet
	local bullet 		= {} 
	bullet.Num			= numbul 
	bullet.Src			= self.Owner:GetShootPos() 
	bullet.Dir			= self.Owner:GetAimVector()
	bullet.Spread		= Vector(cone,cone,0) 
	bullet.Tracer		= 1	 
	bullet.TracerName 	= "AirboatGunTracer"
	bullet.Force		= 0.5*dmg
	bullet.Damage 		= dmg 
	bullet.Callback		= StriderBulletCallback
	self.Owner:FireBullets(bullet)

	--play animations
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:MuzzleFlash()
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	--apply recoil
	self.Owner:ViewPunch( Angle(math.Rand(-0.2,0.1)*recoil,math.Rand(-0.1,0.1)*recoil, 0))

end

function SWEP:StopCharging()

	self:StopSound(self.Cannon.ChargeSound)
	self.Charging = false

end

function SWEP:Holster(wep) 		self:StopCharging() 	return true end
function SWEP:Equip(NewOwner) 	self:StopCharging() 	return true end
function SWEP:OnRemove() 		self:StopCharging() 	return true end
function SWEP:OnDrop() 			self:StopCharging() 	return true end
function SWEP:OwnerChanged() 	self:StopCharging() 	return true end

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

function SWEP:Idle()
	if ( CLIENT || !IsValid( self.Owner ) ) then return end
	timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration() - 0.2, 1, function()
		if ( !IsValid( self ) ) then return end
		self:DoIdle()
	end )
end

function SWEP:DrawWorldModel()
end