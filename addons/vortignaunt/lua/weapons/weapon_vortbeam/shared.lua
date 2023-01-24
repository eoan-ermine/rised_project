-- "addons\\vortignaunt\\lua\\weapons\\weapon_vortbeam\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if (SERVER) then
	AddCSLuaFile( "shared.lua" )
	
	resource.AddFile("models/weapons/c_vortbeamvm.mdl")
	resource.AddFile("materials/vgui/entities/weapon_vortbeam.vmt")
	resource.AddFile("materials/vgui/killicons/weapon_vortbeam.vmt")
	
	SWEP.AutoSwitchTo		= true
	SWEP.AutoSwitchFrom		= true
end

if ( CLIENT ) then
	SWEP.DrawAmmo			= true
	SWEP.PrintName			= "Vortigaunt Beam"
	SWEP.Author				= "Jvs"
	SWEP.DrawCrosshair		= true
	SWEP.ViewModelFOV		= 60

	SWEP.Contact		= "jvs_34@yahoo.it"
	SWEP.Purpose		= "Zap everything! Vortigaunt Style"
	SWEP.Instructions	= "Primary: Vortigaunt zap.\nSecondary: Self battery healing."

	killicon.Add("weapon_vortbeam","VGUI/killicons/weapon_vortbeam",Color(255,255,255));

	local function VortBeamHitFlash()
		local alpha = 255
		hook.Add("HUDPaint", "RP_VortBeamHitFlash", function()
			alpha = Lerp(0.10, alpha, 0)
			surface.SetDrawColor(255,255,255,alpha)
			surface.DrawRect(0,0,ScrW(), ScrH())

			if math.Round(alpha) == 0 then
				hook.Remove("HUDPaint", "RP_VortBeamHitFlash")
			end
		end)
	end
	usermessage.Hook("VortBeamHitFlash", VortBeamHitFlash)

end

CreateConVar("vorthands_beamdamage", 100, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE))
CreateConVar("vorthands_beamrange", 1000, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE))
CreateConVar("vorthands_beamchargetime", 1.25, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE))
CreateConVar("vorthands_healdelay", 5, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE))
CreateConVar("vorthands_maxarmorheal", 28, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE))
CreateConVar("vorthands_minarmorheal", 12, bit.bor(FCVAR_NOTIFY, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE))

SWEP.Category				= "Other"
SWEP.UseHands				= true
SWEP.Slot					= 3
SWEP.SlotPos				= 5
SWEP.Weight					= 5
SWEP.Spawnable     			= true
SWEP.AdminSpawnable  		= true
 
SWEP.ViewModel 				= "models/weapons/c_vortbeamvm.mdl"
SWEP.WorldModel 			= ""

SWEP.Range					= 2*100*12
SWEP.DamageForce			= 48000	
SWEP.HealSound				= Sound("NPC_Vortigaunt.SuitOn")
SWEP.HealLoop				= Sound("NPC_Vortigaunt.StartHealLoop")
SWEP.AttackLoop				= Sound("NPC_Vortigaunt.ZapPowerup" )
SWEP.AttackSound			= Sound("NPC_Vortigaunt.ClawBeam")
SWEP.HealDelay				= 1.5
SWEP.MaxArmor				= 28
SWEP.MinArmor				= 12
SWEP.ArmorLimit				= 100
SWEP.BeamDamage				= 100
SWEP.BeamChargeTime			= 1.25
SWEP.Deny					= Sound("Buttons.snd19")			

SWEP.Primary.ClipSize		= 1
SWEP.Primary.DefaultClip	= 50
SWEP.Primary.Ammo 			= "AR2AltFire"
SWEP.Primary.Automatic		= true

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo 		= false
SWEP.Secondary.Automatic 	= true

function SWEP:Initialize()
	self.Charging=false;
	self.Healing=false;
	self.HealTime=CurTime();
	self.ChargeTime=CurTime();
	self:SetWeaponHoldType("fist")
	self:SetHoldType("fist")
	if (CLIENT) then return end
	self:CreateSounds()
end 

function SWEP:Precache()
	PrecacheParticleSystem( "vortigaunt_beam" );
	PrecacheParticleSystem( "vortigaunt_beam_charge" );
	PrecacheParticleSystem( "vortigaunt_charge_token_b" );
	PrecacheParticleSystem( "vortigaunt_charge_token_c" );
	PrecacheParticleSystem( "vortigaunt_charge_token" );
	util.PrecacheModel(self.ViewModel)
end

function SWEP:CreateSounds()
	if (!self.ChargeSound) then
		self.ChargeSound = CreateSound( self.Weapon, self.AttackLoop );
	end
	if (!self.HealingSound) then
		self.HealingSound = CreateSound( self.Weapon, self.HealLoop );
	end
end

function SWEP:DispatchEffect(EFFECTSTR)
	local pPlayer=self.Owner;
	if !pPlayer then return end
	local view;
	if CLIENT then view=GetViewEntity() else view=pPlayer:GetViewEntity() end
	if ( !pPlayer:IsNPC() && view:IsPlayer() ) then
		ParticleEffectAttach( EFFECTSTR, PATTACH_POINT_FOLLOW, pPlayer:GetViewModel(), pPlayer:GetViewModel():LookupAttachment( "muzzle" ) );
	else
		ParticleEffectAttach( EFFECTSTR, PATTACH_POINT_FOLLOW, pPlayer, pPlayer:LookupAttachment( "anim_attachment_rh" ) );
	end
end

function SWEP:ShootEffect(EFFECTSTR,startpos,endpos)
	local pPlayer=self.Owner;
	if !pPlayer then return end
	local view;
	if CLIENT then view=GetViewEntity() else view=pPlayer:GetViewEntity() end
	if ( !pPlayer:IsNPC() && view:IsPlayer() ) then
		--util.ParticleTracerEx( EFFECTSTR, self.Weapon:GetAttachment( self.Weapon:LookupAttachment( "muzzle" ) ).Pos,endpos, true, pPlayer:GetViewModel():EntIndex(), pPlayer:GetViewModel():LookupAttachment( "muzzle" ) );
		util.ParticleTracerEx( EFFECTSTR, self.Owner:GetShootPos(),endpos, true, pPlayer:GetViewModel():EntIndex(), pPlayer:GetViewModel():LookupAttachment( "muzzle" ) );
	else
		util.ParticleTracerEx( EFFECTSTR, pPlayer:GetAttachment( pPlayer:LookupAttachment( "anim_attachment_rh" ) ).Pos,endpos, true,pPlayer:EntIndex(), pPlayer:LookupAttachment( "anim_attachment_rh" ) );
	end
end
	
function SWEP:ImpactEffect( traceHit )
	local data = EffectData();
	data:SetOrigin(traceHit.HitPos)
	data:SetNormal(traceHit.HitNormal)
	data:SetScale(20)
	util.Effect( "StunstickImpact", data );
	local rand=math.random(1,1.5);
	self:CreateBlast(rand,traceHit.HitPos)
	self:CreateBlast(rand,traceHit.HitPos)		
	
	if SERVER && traceHit.Entity && IsValid(traceHit.Entity) && string.find(traceHit.Entity:GetClass(),"ragdoll") then
		traceHit.Entity:Fire("StartRagdollBoogie");
		--[[
		local boog=ents.Create("env_ragdoll_boogie")
		boog:SetPos(traceHit.Entity:GetPos())
		boog:SetParent(traceHit.Entity)
		boog:Spawn()
		boog:SetParent(traceHit.Entity)
		]]
	end
end

function SWEP:CreateBlast(scale,pos)
	if CLIENT then return end
	local blastspr = ents.Create("env_sprite");
	blastspr:SetPos( pos );
	blastspr:SetKeyValue( "model", "sprites/vortring1.vmt")
	blastspr:SetKeyValue( "scale",tostring(scale))
	blastspr:SetKeyValue( "framerate",60)
	blastspr:SetKeyValue( "spawnflags","1")
	blastspr:SetKeyValue( "brightness","255")
	blastspr:SetKeyValue( "angles","0 0 0")
	blastspr:SetKeyValue( "rendermode","9")
	blastspr:SetKeyValue( "renderamt","255")
	blastspr:Spawn()
	blastspr:Fire("kill","",0.45)
end						
function SWEP:Shoot(dmg,effect)
	local pPlayer=self.Owner
	if !pPlayer then return end
	local traceres=util.QuickTrace(self.Owner:EyePos(),self.Owner:GetAimVector()*GetConVar("vorthands_beamrange"):GetFloat() or 32768,self.Owner)
	self:ShootEffect(effect or "vortigaunt_beam",pPlayer:EyePos(),traceres.HitPos)
	if SERVER then
		if IsValid(traceres.Entity) then
			local DMG=DamageInfo()
			if math.random(0, 100) > 50 then
				DMG:SetDamageType(DMG_SHOCK)
			end
			DMG:SetDamage(dmg or GetConVar("vorthands_beamdamage"):GetFloat() or 100)
			DMG:SetAttacker(self.Owner)
			DMG:SetInflictor(self)
			DMG:SetDamagePosition(traceres.HitPos)
			DMG:SetDamageForce(pPlayer:GetAimVector()*self.DamageForce)
			traceres.Entity:TakeDamageInfo(DMG)
			if traceres.Entity:IsPlayer() then
				umsg.Start("VortBeamHitFlash", traceres.Entity)
				umsg.End()
			end
		end
	end
	self.Owner:GetViewModel():EmitSound(self.AttackSound)
	self:ImpactEffect( traceres )
end

function SWEP:Holster( wep )
	self:StopEveryThing()
	return true
end

function SWEP:OnRemove()
	self:StopEveryThing()
end

function SWEP:StopEveryThing()
	self.Charging=false;
	
	if SERVER && self.ChargeSound then
		self.ChargeSound:Stop();
	end
	
	self.Healing=false;
	
	if SERVER && self.HealingSound then
		self.HealingSound:Stop();
	end
	
	local pPlayer = self.LastOwner;
	if !IsValid(pPlayer) then
		return;
	end
	
	local Weapon = self.Weapon
	if (!pPlayer) then return end
	if (!pPlayer:GetViewModel()) then return end
	if ( CLIENT ) then if ( pPlayer == LocalPlayer() ) then pPlayer:GetViewModel():StopParticles();end	end
	pPlayer:StopParticles();
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	self:SetDeploySpeed( 1 )
	return true
end

function SWEP:Think()
	if self.Owner && IsValid(self.Owner) then self.LastOwner=self.Owner end
	if self.Charging && self.ChargeTime-0.25 < CurTime() && !self.attack then
		self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
		self:DispatchEffect("vortigaunt_charge_token")
		--self.Owner:SetAnimation(PLAYER_ATTACK1)
		timer.Simple(0.75,function()if !IsValid(self.Owner) || self.Owner:GetActiveWeapon()!=self || !IsValid(self)  then return end self.Weapon:SendWeaponAnim(ACT_VM_IDLE)end)
		self.attack=true;
	end
	
	if self.Charging && self.ChargeTime < CurTime() then
		if IsValid(self.Owner:GetViewModel())then self.Owner:GetViewModel():StopParticles() end
		self.Owner:StopParticles()
		self:Shoot()
		self.Charging=false;
	
		self.attack=false;
		self:SetWeaponHoldType("fist")
		self:SetHoldType("fist")
		if SERVER && self.ChargeSound then	self.ChargeSound:Stop();end
		
		self.Weapon:SetNextPrimaryFire(CurTime()+0.5)
		self.Weapon:SetNextSecondaryFire(CurTime()+0.5)
	end
	
	if self.Healing && self.HealTime<CurTime() then
		if self.Owner:Armor()>=self.ArmorLimit then
			self.Weapon:EmitSound(self.Deny)
			self.Weapon:SetNextPrimaryFire(CurTime()+SoundDuration(self.Deny))
			self.Weapon:SetNextSecondaryFire(CurTime()+SoundDuration(self.Deny))
			if IsValid(self.Owner:GetViewModel()) then self.Owner:GetViewModel():StopParticles() end
			self.Owner:StopParticles()
			self.Healing=false;
			self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			if SERVER && self.HealingSound then	self.HealingSound:Stop();end
			return
		end
		self:SetWeaponHoldType("fist")
		self:SetHoldType("fist")
		
		if IsValid(self.Owner:GetViewModel())then self.Owner:GetViewModel():StopParticles() end
		self.Owner:StopParticles()
		self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		self.Healing=false;
		self.Owner:EmitSound(self.HealSound)
		if SERVER && self.HealingSound then	self.HealingSound:Stop();end
		self:GiveArmor()
		self.Weapon:SetNextPrimaryFire(CurTime()+0.5)
		self.Weapon:SetNextSecondaryFire(CurTime()+0.5)
	end
end

function SWEP:GiveArmor()
	if CLIENT then return end
	local arm=math.random(GetConVar("vorthands_minarmorheal"):GetFloat() or 12,GetConVar("vorthands_maxarmorheal"):GetFloat() or 28)
	local plarm=self.Owner:Armor()
	if plarm>=self.ArmorLimit then return end
	if plarm <= (self.ArmorLimit - arm) then
		self.Owner:SetArmor( plarm + arm )
		else
		self.Owner:SetArmor(self.ArmorLimit)
	end		
end

function SWEP:PrimaryAttack()
	if self.Charging || self.Healing then return end
	
	self:DispatchEffect("vortigaunt_charge_token_b")
	self:DispatchEffect("vortigaunt_charge_token_c")
	self.ChargeTime=CurTime()+GetConVar("vorthands_beamchargetime"):GetFloat() or 1.25;
	self.attack=false;
	self.Charging=true
	self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
	
	self:SetWeaponHoldType("magic")
	self:SetHoldType("magic")
	
	--[[
	self:ShootEffect("vortigaunt_beam_charge",self.Owner:EyePos(),self.Owner:GetPos()+Vector(0,32,0))
	self:ShootEffect("vortigaunt_beam_charge",self.Owner:EyePos(),self.Owner:GetPos()+Vector(0,-32,0))
	self:ShootEffect("vortigaunt_beam_charge",self.Owner:EyePos(),self.Owner:GetPos()+Vector(32,0,0))
	self:ShootEffect("vortigaunt_beam_charge",self.Owner:EyePos(),self.Owner:GetPos()+Vector(-32,0,0))
	]]
	if SERVER && self.ChargeSound then
		self.ChargeSound:PlayEx( 100, 150 );
	end
	self.Weapon:SetNextPrimaryFire(CurTime()+3)
	self.Weapon:SetNextSecondaryFire(CurTime()+3)
end

function SWEP:SecondaryAttack()
	if self.Charging || self.Healing || self.Owner:Armor()>=self.ArmorLimit then return end
	self.HealTime=CurTime()+GetConVar("vorthands_healdelay"):GetFloat() or 1.5;
	self.Healing=true;
	self:DispatchEffect("vortigaunt_charge_token")
	self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
	if SERVER && self.HealingSound then
		self.HealingSound:PlayEx( 100, 150 );
	end
	
	self:SetWeaponHoldType("slam")
	self:SetHoldType("slam")

	self.Weapon:SetNextPrimaryFire(CurTime()+0.5)
	self.Weapon:SetNextSecondaryFire(CurTime()+0.5)
end

function SWEP:Reload()
end
