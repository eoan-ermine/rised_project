-- "addons\\rised_weapons\\lua\\weapons\\weapon_synth_cremator\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
	AddCSLuaFile( "shared.lua" )
	SWEP.HoldType        			= "physgun"
	util.AddNetworkString("RisedNet_SynthAnim_Cremator")
end

if CLIENT then
	language.Add("weapon_rpimmolator", "Immolator")
	SWEP.Category = "A - Rised - [Оружие]"
	SWEP.PrintName = "Immolator"
	SWEP.Slot = 5
	SWEP.SlotPos = 6
	SWEP.DrawAmmo = true
	SWEP.DrawCrosshair = true
	SWEP.ViewModelFOV = 70
	SWEP.ViewModelFlip = false
	SWEP.DrawWeaponInfoBox	= false
	SWEP.WepSelectIcon = surface.GetTextureID("HUD/swepicons/weapon_immolator") 
	SWEP.BounceWeaponIcon = false
	
	net.Receive("RisedNet_SynthAnim_Cremator", function(len)
		local ply = net.ReadEntity()
		local anim = net.ReadInt(10)
		if !IsValid(ply) then return end
		if anim == 1 then
			local seq1 = ply:LookupSequence("Fireout")
			ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, seq1, 0, true)
		elseif anim == 2 then
			local seq1 = ply:LookupSequence("Firein")
			local seq2 = ply:LookupSequence("Firebreathing1")
			ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, seq1, 0, true)
			timer.Simple(1, function()
				ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, seq2, 1, false)
			end)
		elseif anim == 3 then
			local seq1 = ply:LookupSequence("Fireloop")
			ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, seq1, 1, false)
		elseif anim == 4 then
			local seq1 = ply:LookupSequence("Firebreathing1")
			ply:AddVCDSequenceToGestureSlot(GESTURE_SLOT_CUSTOM, seq1, 1, false)
		end
	end)
end

// Code by CrazyBubba64
// Modifications by BattlePope
------------------------------ Only admin can spawn / everyone can spawn -------------------
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
-----------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------
SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
-----------------------------------------------------------------------------------------------------------

game.AddAmmoType( { name = "bp_immolator" } )
if ( CLIENT ) then language.Add( "bp_immolator_ammo", "Plasma" ) end

-----------------------------------------------------------------------------------------------------------

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 999999
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo		= "bp_immolator"
SWEP.Primary.Damage		= 30
SWEP.Primary.Recoil		= 0
SWEP.Secondary.Ammo		= "none"
-----------------------------------------------------------------------------------------------------------


-----------------------------------------------About model----------------------------------------------------------------
SWEP.ViewModel				= "models/weapons/v_cremato3.mdl"
SWEP.WorldModel				= ""
SWEP.HoldType        		= "physgun"
---------------------------------------------------------------------------------------------------------------------------------

SWEP.Sound = Sound ("weapons/1immolator/plasma_shoot.wav")

SWEP.Volume = 7
SWEP.Influence = 0

SWEP.LastSoundRelease = 0
SWEP.RestartDelay = 0
SWEP.RandomEffectsDelay = 0.2

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	self.cd = 0
	self:StopSounds()
end

function SWEP:Precache()
end

function SWEP:PrimaryAttack()
	
	if !self.Owner:GetNWBool("Rised_Synth_Cremator_Armed") or self.Owner:GetAmmoCount( self.Primary.Ammo ) < 0 or !self.canFire then return end
	
	if self:IsUnderWater() then return end
	
	if (!SERVER) then return end

	if ( self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then

		local tr, vm, muzzle, attach//, effectdata
		
		tr = { }
		tr.start = self.Owner:GetShootPos( )
		tr.filter = self.Owner
		tr.endpos = tr.start + self.Owner:GetAimVector( ) * 4096
		tr.mins = Vector( ) * -2
		tr.maxs = Vector( ) * 2
		tr = util.TraceHull( tr )
		
		local tr, vm, muzzle, attach//, effectdata
		vm = self.Owner:GetViewModel()
		local trace = self.Owner:GetEyeTrace()
		local hit = trace.HitPos
		attach = vm:LookupAttachment("muzzle")
		vstr = tostring(self.Weapon)

		local bone = self.Owner:GetAttachment(1)
		
		local startPos = trace.StartPos
		local laserHitPosNormalized = hit:GetNormalized()
		local laserLength = startPos:Distance(hit)

		local a = startPos * laserHitPosNormalized * hit

		-- local x = (startPos.x + (hit.x - startPos.x)) / math.sqrt(math.abs((startPos.x - hit.x)  + (startPos.y - hit.y) + (startPos.z - hit.z)))
		-- local y = (startPos.y + (hit.y - startPos.y)) / math.sqrt(math.abs((startPos.x - hit.x)  + (startPos.y - hit.y) + (startPos.z - hit.z)))
		-- local y = (startPos.z + (hit.z - startPos.z)) / math.sqrt(math.abs((startPos.x - hit.x)  + (startPos.y - hit.y) + (startPos.z - hit.z)))

		local d = 0.2
		local x = (startPos.x + (d * hit.x)) / (1 + d)
		local y = (startPos.y + (d * hit.y)) / (1 + d)
		local z = (startPos.z + (d * hit.z)) / (1 + d)

		-- local x = (startPos.x + hit.x) / 2
		-- local y = (startPos.y + hit.y) / 2
		-- local z = (startPos.z + hit.z) / 2

		local top = Vector(x,y,z)
		local dist = startPos:Distance(top)
		if dist < 100 then
			top = hit
		end

		local laserFinishPos = hit:GetNormalized() + hit
		
		local MuzzlePos = bone.Pos
		self:lase(vstr, attach, MuzzlePos, top, 1)
		self.Owner:ViewPunch( Angle( math.random(-.01, .01), math.random(-.01, .01), math.random(-.01, .01) ) )
		self:TakePrimaryAmmo( 1 )
		self:ShootEffects()
	else
		self:EndSound()
	end
end

function SWEP:SecondaryAttack()
	if SERVER and self.cd <= CurTime() then
		self.cd = CurTime() + 1
		if self.Owner:GetNWBool("Rised_Synth_Cremator_Armed") then
			net.Start("RisedNet_SynthAnim_Cremator")
			net.WriteEntity(self.Owner)
			net.WriteInt(1,10)
			net.Broadcast()
			timer.Simple(1.5, function()
				self.Owner:SetNWBool("Rised_Synth_Cremator_Armed", false)
				self.Owner:SetWalkSpeed(100)
				
				self.Weapon:StopSound("cremator/plasma_shoot.wav")
			end)
		else
			net.Start("RisedNet_SynthAnim_Cremator")
			net.WriteEntity(self.Owner)
			net.WriteInt(2,10)
			net.Broadcast()
			self.Owner:SetNWBool("Rised_Synth_Cremator_Armed", true)
			self.Owner:SetWalkSpeed(1)
		end
	end
	self:SetNextSecondaryFire(1)
end

function SWEP:StopSounds()
	if self.EmittingSound then
		self.Weapon:StopSound(sndAttackLoop)
		self.Weapon:StopSound(sndSprayLoop)
		self.Weapon:EmitSound(sndAttackStop)
		self.EmittingSound = false
	end
	if IsValid(self.Owner) then
		self.Owner:StopSound("npc/cremator/amb_loop.wav")
		self.Owner:StopSound("npc/cremator/amb_mad.wav")
		self.Owner:StopSound("weapons/vfirethrower/fire.wav")
	end
end

function SWEP:Reload()
end

function SWEP:Think()
	
	if self.Owner:GetNWBool("Rised_Synth_Cremator_Armed") then
		if self.Owner:KeyPressed(IN_ATTACK) and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then
			self.Weapon:EmitSound("cremator/plasma_shoot.wav")
			timer.Simple(0.5, function() self.canFire = true self.Weapon:EmitSound("cremator/plasma_shoot.wav") end)
		end
		if self.Owner:KeyReleased(IN_ATTACK) then
			self.canFire = false
			if self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then
				self.Weapon:EmitSound("cremator/plasma_stop.wav")
			end
			timer.Simple(0.5, function()
				self.Weapon:StopSound("cremator/plasma_shoot.wav")
			end)
		end
	end

	if SERVER then
		if self.Owner:GetNWBool("Rised_Synth_Cremator_Armed") then
			if self.Owner:KeyPressed(IN_ATTACK) then
				net.Start("RisedNet_SynthAnim_Cremator")
				net.WriteEntity(self.Owner)
				net.WriteInt(3,10)
				net.Broadcast()
			elseif self.Owner:KeyReleased(IN_ATTACK) then
				net.Start("RisedNet_SynthAnim_Cremator")
				net.WriteEntity(self.Owner)
				net.WriteInt(4,10)
				net.Broadcast()
			end
		end
	
		if self.Owner:Health() < 50 then
			if !self.Owner:GetNWBool("Rised_Synth_Cremator_Armed") then
				self.Owner:SetWalkSpeed(50)
			end
			if !self.Owner:GetNWBool("Synth_Cremator_LowActive") then
				self.Owner:SetNWBool("Synth_Cremator_LowActive", true)
				self:StopSounds()
				self.Owner:EmitSound("npc/cremator/amb_mad.wav", 40)
			end
		else
			if !self.Owner:GetNWBool("Rised_Synth_Cremator_Armed") then
				self.Owner:SetWalkSpeed(100)
			else
				self.Owner:SetWalkSpeed(1)
			end
			if self.Owner:GetNWBool("Synth_Cremator_LowActive") then
				self.Owner:SetNWBool("Synth_Cremator_LowActive", false)
				self:StopSounds()
				self.Owner:EmitSound("npc/cremator/amb_loop.wav", 30)
			end
		end
	end

	if SERVER then

		self.LastFrame = self.LastFrame or CurTime()
		self.LastRandomEffects = self.LastRandomEffects or 0		

		if self.Owner:KeyDown (IN_ATTACK) and self.LastSoundRelease + self.RestartDelay < CurTime() then
			self.Volume = math.Clamp (self.Volume + CurTime() - self.LastFrame, 0, 2)
			self.Influence = math.Clamp (self.Influence + (CurTime() - self.LastFrame) / 2, 0, 1)
			self.SoundPlaying = true
		elseif self.SoundObject and self.SoundPlaying then
			self.SoundObject:FadeOut (0.8)			
			self.SoundPlaying = false
			self.LastSoundRelease = CurTime()
			self.Volume = 0
			self.Influence = 0
			self:Idle()	
		end
		if not self.Owner:Alive() then
		self:EndSound()
		end
		self.LastFrame = CurTime()
		self.Weapon:SetNWBool ("on", self.SoundPlaying)
	end
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim(ACT_VM_DRAW);
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration())
	self:SetNextSecondaryFire( CurTime() + self:SequenceDuration())
	self:NextThink( CurTime() + self:SequenceDuration() )
	self:Idle()

	timer.Simple(0.5, function()
		self.Owner:EmitSound("npc/cremator/amb_loop.wav", 60)
	end)
	
   	return true
end

function SWEP:ShootEffects()
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:MuzzleFlash()								
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
end

function SWEP:IsUnderWater()
	if self:WaterLevel() < 3 then
		return false
	else
		if SERVER then
			local pos = (self.Owner:GetShootPos() + self.Owner:GetAimVector()*40)-Vector(0,0,25)

			tes = ents.Create( "point_tesla" )
			tes:SetPos( pos )
			tes:SetKeyValue( "m_SoundName", "DoSpark" )
			tes:SetKeyValue( "texture", "sprites/laserbeam.spr" )
			tes:SetKeyValue( "m_Color", "255 180 180" )
			tes:SetKeyValue("rendercolor", "255 180 180")
			tes:SetKeyValue( "m_flRadius", "100" )
			tes:SetKeyValue( "beamcount_max", "10" )
			tes:SetKeyValue( "thick_min", "5" )
			tes:SetKeyValue( "thick_max", "10" )
			tes:SetKeyValue( "lifetime_min", "0.1" )
			tes:SetKeyValue( "lifetime_max", "0.3" )
			tes:SetKeyValue( "interval_min", "0.1" )
			tes:SetKeyValue( "interval_max", "0.2" )
			tes:Spawn()
			tes:Fire( "DoSpark", "", 0 )
			tes:Fire( "DoSpark", "", 0.1 )
			tes:Fire( "DoSpark", "", 0.2 )
			tes:Fire( "DoSpark", "", 0.3 )
			tes:Fire( "kill", "", 0.3 )

			local hitdie = ents.Create("point_hurt"); --This is what kills stuff
			hitdie:SetKeyValue("Damage",200)
			hitdie:SetKeyValue("DamageRadius",200)
			hitdie:SetKeyValue("DamageType","SHOCK")
			hitdie:SetParent( self.Owner )
			hitdie:SetPos( pos )
			hitdie:Spawn();
			hitdie:Fire("hurt","",0.1); -- ACTIVATE THE POINT_HURT
			hitdie:Fire("kill","",1.2);
		end

		self:EmitSound("ambient/energy/weld"..math.random(1,2)..".wav")
		self:EmitSound("weapons/gauss/electro"..math.random(1,3)..".wav")

		self:SetNextPrimaryFire(CurTime()+0.8)
		self:SetNextSecondaryFire(CurTime()+0.8)
		return true
	end
end

function SWEP:lase(par, stat, from, to, noise)
	if SERVER then
		entItem = ents.Create ("info_target")
		realName = "entItem"..tostring(self.Owner:GetName())
		entItem:SetKeyValue("targetname", realName)
		entItem:Spawn()

		beam = ents.Create("env_laser")
		beam:SetKeyValue("renderamt", "255")
		beam:SetKeyValue("rendercolor", "255 25 0")
		beam:SetKeyValue("texture", "sprites/laserbeam.spr")
		beam:SetKeyValue("TextureScroll", "14")
		beam:SetKeyValue("targetname", "beam" )
		beam:SetKeyValue("renderfx", "2")
		beam:SetKeyValue("width", "5")
		beam:SetKeyValue("dissolvetype", "-1")
		beam:SetKeyValue("EndSprite", "")
		beam:SetKeyValue("LaserTarget", realName)//"entItem")
		beam:SetKeyValue("TouchType", "2")
		beam:SetKeyValue("NoiseAmplitude", noise)
		beam:SetOwner(self.Owner)
		beam:Spawn()

		tent = ents.Create("point_tesla")
		tent:SetKeyValue("texture","sprites/laserbeam.spr")
		tent:SetKeyValue("m_Color","255 75 0 255")
		tent:SetKeyValue("m_flRadius","150")
		tent:SetKeyValue("beamcount_min","20")
		tent:SetKeyValue("beamcount_max","50")
		tent:SetKeyValue("lifetime_min","0.05")
		tent:SetKeyValue("lifetime_max","0.06")
		tent:SetKeyValue("interval_min","0.1")
		tent:SetKeyValue("interval_max","0.35")
		tent:SetPos(to)
		tent:Spawn()
		tent:Activate()
		tent:Fire("TurnOn","",0)

		aoe = ents.Create("env_beam")
		aoe:SetKeyValue("renderamt", "255")
		aoe:SetKeyValue("rendercolor", "0 255 0")
		aoe:SetKeyValue("life", "0")
		aoe:SetKeyValue("radius", "325")
		aoe:SetKeyValue("LightningStart", "entItem")
		aoe:SetKeyValue("StrikeTime", "0.05")
		aoe:SetKeyValue("damage", "50")
		aoe:SetKeyValue("NoiseAmplitude", "7")
		aoe:SetKeyValue("texture", "sprites/laserbeam.spr")
		aoe:SetKeyValue("dissolvetype", "1")
		aoe:Fire("TurnOn", "", 0.01)
		aoe:SetPos(to)
		aoe:Fire("kill", "", 0.2)
		
		beam:Fire("TurnOn", "", 0.01)
		beam:Fire("kill", "", 0.2)

		entItem:Fire("kill", "", 0.2)
		tent:Fire("Kill","",0.2)

		entItem:SetPos(to)
		beam:SetPos(from)
	end
end

function SWEP:CreateSound ()
	self.SoundObject = CreateSound (self.Weapon, self.Sound)
	self.SoundObject:Play()
end

function SWEP:OwnerChanged()
	self:EndSound()
end

function SWEP:EndSound ()
	if self.SoundObject then
		self.SoundObject:Stop()
	end
end

function SWEP:OnRemove()
	self:EndSound()
	self:StopSounds()
	return true
end

function SWEP:Holster( weapon )
	
	self:StopIdle()
	self:StopSounds()
	
	return true
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

function SWEP:Idle()
	if ( CLIENT || !IsValid( self.Owner ) ) then return end
	timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration() - 0.2, 1, function()
		if ( !IsValid( self ) ) then return end
		self:DoIdle()
	end )
end