-- "addons\\rised_weapons\\lua\\weapons\\weapon_cp_stick\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then

	AddCSLuaFile( "shared.lua" )
	
end

if CLIENT then

	SWEP.ViewModelFOV		= 54
	SWEP.ViewModelFlip		= false
	
	SWEP.PrintName = "Stunstick"
	SWEP.Slot = 0
	SWEP.Slotpos = 0
	SWEP.BounceWeaponIcon     = false
	SWEP.DrawWeaponInfoBox = false
	
end

SWEP.HoldType = "normal"

SWEP.Author = "Krede" -- Who made this 
SWEP.Category = "A - Rised - [Оружие]"

SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.ViewModel = "models/rised/weapons/c_stunstick.mdl"
SWEP.UseHands = true
SWEP.DrawCrosshair = false
SWEP.Spawnable = true

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.Ammo 			= "none"
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Automatic 		= true

SWEP.Secondary.ClipSize 	= -1 
SWEP.Secondary.Ammo 		= "none" 
SWEP.Secondary.DefaultClip 	= -1     
SWEP.Secondary.Automatic 	= false

SWEP.Sounds = {}

SWEP.Sounds.DontMove = {
	"npc/metropolice/vo/dontmove.wav",
	"npc/metropolice/vo/holdit.wav",
	"npc/metropolice/vo/holditrightthere.wav",
}
SWEP.Sounds.Move = {
	"npc/metropolice/vo/getoutofhere.wav",
	"npc/metropolice/vo/isaidmovealong.wav",
	"npc/metropolice/vo/keepmoving.wav",
	"npc/metropolice/vo/move.wav",
	"npc/metropolice/vo/movealong.wav",
	"npc/metropolice/vo/moveit2.wav",
}
SWEP.Sounds.Contact = {
	"npc/metropolice/vo/thereheis.wav",
	"npc/metropolice/vo/contactwith243suspect.wav",
	"npc/metropolice/vo/gotsuspect1here.wav",
}
SWEP.Sounds.Idle = {
	"npc/combine_soldier/vo/echo.wav",
	"npc/combine_soldier/vo/niner.wav",
	"npc/combine_soldier/vo/overwatch.wav",
	"npc/combine_soldier/vo/standingby].wav",
	"npc/metropolice/vo/patrol.wav",
	"npc/metropolice/vo/anyonepickup647e.wav",
	"npc/metropolice/vo/chuckle.wav",
}

SWEP.IronSightsPos  = Vector(5, 0, -10)
SWEP.IronSightsAng  = Vector(0, 0, -5)

function SWEP:Think()
	if !self:GetNWBool("Angry") then
		self.IronSightsPos  = LerpVector(0.1, self.IronSightsPos, Vector(5, 0, -10))
		self.IronSightsAng  = LerpVector(0.1, self.IronSightsPos, Vector(0, 0, -5))
	else
		self.IronSightsPos  = LerpVector(0.1, self.IronSightsPos, Vector(0, 0, 0))
		self.IronSightsAng  = LerpVector(0.1, self.IronSightsPos, Vector(0, 0, 0))
	end
end

function SWEP:GetViewModelPosition(EyePos, EyeAng)

	local Mul = 1.0
	local Offset = self.IronSightsPos

	if (self.IronSightsAng) then
        EyeAng = EyeAng * 1
        
		EyeAng:RotateAroundAxis(EyeAng:Right(), 	self.IronSightsAng.x * Mul)
		EyeAng:RotateAroundAxis(EyeAng:Up(), 		self.IronSightsAng.y * Mul)
		EyeAng:RotateAroundAxis(EyeAng:Forward(),   self.IronSightsAng.z * Mul)
	end

	local Right 	= EyeAng:Right()
	local Up 		= EyeAng:Up()
	local Forward 	= EyeAng:Forward()

	EyePos = EyePos + Offset.x * Right * Mul
	EyePos = EyePos + Offset.y * Forward * Mul
	EyePos = EyePos + Offset.z * Up * Mul
	
	return EyePos, EyeAng
end


local STUNSTICK_GLOW_MATERIAL = Material("effects/stunstick")
local STUNSTICK_GLOW_MATERIAL2 = Material("effects/blueflare1")
local STUNSTICK_GLOW_MATERIAL_NOZ = Material("sprites/light_glow02_add_noz")

local color_glow = Color(255, 0, 0)
local NUM_BEAM_ATTACHEMENTS = 9
local BEAM_ATTACH_CORE_NAME = "sparkrear"

function SWEP:PostDrawViewModel()
	if !self:GetNWBool("StunMode") and !self:GetNWBool("KillMode") then
		return
	end

	local viewModel = LocalPlayer():GetViewModel()

	if (!IsValid(viewModel)) then
		return
	end

	cam.Start3D(EyePos(), EyeAngles())
		local size = math.Rand(3.0, 4.0)
		local color = Color(114, 114, 114, 50 + math.sin(RealTime() * 2)*20)

		if self:GetNWBool("StunMode") then
			color = Color(117, 117, 117, 75 + math.sin(RealTime() * 2)*20)
		elseif self:GetNWBool("KillMode") then
			color = Color(255, 0, 0, 75 + math.sin(RealTime() * 2)*20)
		end

		STUNSTICK_GLOW_MATERIAL_NOZ:SetFloat("$alpha", color.a / 255)

		render.SetMaterial(STUNSTICK_GLOW_MATERIAL_NOZ)

		local attachment = viewModel:GetAttachment(viewModel:LookupAttachment(BEAM_ATTACH_CORE_NAME))

		if (attachment) then
			render.DrawSprite(attachment.Pos, size * 10, size * 15, color)
		end

		for i = 1, NUM_BEAM_ATTACHEMENTS do
			local attachment = viewModel:GetAttachment(viewModel:LookupAttachment("spark"..i.."a"))

			size = math.Rand(2.5, 5.0)

			if (attachment and attachment.Pos) then
				render.DrawSprite(attachment.Pos, size, size, color)
			end

			local attachment = viewModel:GetAttachment(viewModel:LookupAttachment("spark"..i.."b"))

			size = math.Rand(2.5, 5.0)

			if (attachment and attachment.Pos) then
				render.DrawSprite(attachment.Pos, size, size, color)
			end
		end

	cam.End3D()
end

function SWEP:SecondaryAttack()

	if !self:GetNWBool("StunMode") and !self:GetNWBool("KillMode") then
		self:SetNWBool("StunMode", true)
		self:SetNWBool("KillMode", false)	
	elseif self:GetNWBool("StunMode") then
		self:SetNWBool("StunMode", false)
		self:SetNWBool("KillMode", true)
	elseif self:GetNWBool("KillMode") then
		self:SetNWBool("StunMode", false)
		self:SetNWBool("KillMode", false)
	end
	
	self.Weapon:EmitSound("rised/weapons/stunstick/spark"..math.random(1,4)..".wav", 100, math.random(90, 100) )
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)
end

SWEP.SlashTable = {"misscenter1", "misscenter2"}
SWEP.StabTable = {"hitcenter1", "hitcenter2", "hitcenter3"}
SWEP.StabMissTable = {"misscenter1", "misscenter2"}
SWEP.SlashCounter = 1

function SWEP:PrimaryAttack()
	if self.Owner:Crouching() then return end

	if !self:GetNWBool("Angry") then
		
		local tr = {}
		tr.start = self.Owner:GetShootPos()
		tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 80 )
		tr.filter = self.Owner
		tr.mask = MASK_SHOT
		local trace = util.TraceLine( tr )
		
		if trace.Entity and trace.Entity != NULL and IsValid(trace.Entity) and ( trace.Entity:IsNPC() or trace.Entity:IsPlayer() ) then
			self.Weapon:SetNextPrimaryFire(CurTime() + 1.8)
			self.Weapon:SetNextSecondaryFire(CurTime() + 2)
			
			self.Owner:DoAnimationEvent(ACT_POLICE_HARASS2)
			if CLIENT then return end
			
			self.Owner:SetWalkSpeed( 1 )
			self.Owner:SetRunSpeed( 1 )
			
			timer.Simple( 1.5, function()
				if !self or !IsValid(self) or !self.Owner or !IsValid(self.Owner) then return end
				
				self.Owner:SetWalkSpeed( 60 )
				self.Owner:SetRunSpeed( 200 )
			end)
			
			timer.Simple(0.4, function()
				if !self or !IsValid(self) or !self.Owner or !IsValid(self.Owner) then return end
				if !trace or !trace.Entity or !IsValid(trace.Entity) or trace.Entity == NULL then return end
				
				if trace.Entity:GetPos():Distance( self.Owner:GetPos() ) > 150 then return end
				
				trace.Entity:SetVelocity( self.Owner:GetAimVector()*500 + Vector(0,0,5) )
				
				self.Sound = table.Random(self.Sounds.Move)
				self.Owner:EmitSound(self.Sound, 100, 100)
				
			end)
		end
		
	else
		if !self:GetNWBool("StunMode") and !self:GetNWBool("KillMode") then
			self.Weapon:EmitSound("rised/weapons/stunstick/stunstick_nonelectroswing"..math.random(1,3)..".wav")
		elseif self:GetNWBool("StunMode") then
		 	self.Weapon:EmitSound("rised/weapons/stunstick/stunstick_swing"..math.random(1,3)..".wav", 75, 100)
		elseif self:GetNWBool("KillMode") then
		 	self.Weapon:EmitSound("rised/weapons/stunstick/stunstick_swing"..math.random(1,3)..".wav", 100, 65)
		end
		self.Weapon:SetNextPrimaryFire(CurTime() + 1)
		self.Owner:DoAnimationEvent(ACT_MELEE_ATTACK_SWING)
		
		self.Owner:SetWalkSpeed( 1 )
		self.Owner:SetRunSpeed( 1 )
		
		timer.Simple( 0.6, function()
			if !self or !IsValid(self) or !self.Owner or !IsValid(self.Owner) then return end
			
			self.Owner:SetWalkSpeed( 60 )
			self.Owner:SetRunSpeed( 200 )
		end)
		
		timer.Simple( 0.1, function()
		
			if !self or !IsValid(self) or !self.Owner or !IsValid(self.Owner) then return end
			
			self.Owner:ViewPunch( Angle( 6, 6, 0 ) )
			
			local tr = {}
			tr.start = self.Owner:GetShootPos()
			tr.endpos = self.Owner:GetShootPos() + ( self.Owner:GetAimVector() * 60 )
			tr.filter = self.Owner
			tr.mask = MASK_SHOT
			local trace = util.TraceLine( tr )

			self:SmackEffect(trace)

			self.SlashCounter = self.SlashCounter + 1
			if self.SlashCounter > #self.SlashTable then
				self.SlashCounter = 1
			end
			local vm = self.Owner:GetViewModel()
			local seq = ""
			if trace.Hit then
				seq = self.StabTable[self.SlashCounter]
			else
				seq = self.SlashTable[self.SlashCounter]
			end
			if seq != "" then
				local seqId = vm:LookupSequence(seq) or 0
				local act = vm:GetSequenceActivity(seqId)
				vm:SendViewModelMatchingSequence(seqId)
			end
			
			if ( trace.Hit ) then
				if trace.Entity:IsValid() and trace.Entity:IsPlayer() then
					
					if SERVER then
						if !trace.Entity:isCP() then
							AddTaskExperience(self.Owner, "Норма избиений")
						end
					end
					
					if self:GetNWBool("StunMode") then
						bullet = {}
						bullet.Num    = 1
						bullet.Src    = self.Owner:GetShootPos()
						bullet.Dir    = self.Owner:GetAimVector()
						bullet.Spread = Vector(0, 0, 0)
						bullet.Tracer = 0
						bullet.Force  = 1
						bullet.Damage = 5
						bullet.Callback = function(ply, trace, dmginfo)
							dmginfo:SetDamageType(DMG_SHOCK)
						end
						self.Weapon:EmitSound("rised/weapons/stunstick/stunstick_fleshhit"..math.random(1,3)..".wav")
						self.Owner:FireBullets(bullet) 
						local fx = EffectData()
							fx:SetEntity(self.Weapon)
							fx:SetOrigin(trace.HitPos)
							fx:SetNormal(trace.HitNormal)
						util.Effect("StunstickImpact",fx)
						
						
						
					elseif self:GetNWBool("KillMode") then
						bullet = {}
						bullet.Num    = 1
						bullet.Src    = self.Owner:GetShootPos()
						bullet.Dir    = self.Owner:GetAimVector()
						bullet.Spread = Vector(0, 0, 0)
						bullet.Tracer = 0
						bullet.Force  = 1
						bullet.Damage = 25
						self.Weapon:EmitSound("rised/weapons/stunstick/stunstick_fleshhit"..math.random(1,3)..".wav")
						self.Owner:FireBullets(bullet)
					else
						bullet = {}
						bullet.Num    = 1
						bullet.Src    = self.Owner:GetShootPos()
						bullet.Dir    = self.Owner:GetAimVector()
						bullet.Spread = Vector(0, 0, 0)
						bullet.Tracer = 0
						bullet.Force  = 1
						bullet.Damage = 5
						self.Weapon:EmitSound("rised/weapons/stunstick/stunstick_fleshhit"..math.random(1,3)..".wav")
						self.Owner:FireBullets(bullet)
					end
				else
					self.Weapon:EmitSound("physics/flesh/flesh_impact_bullet"..math.random(1,5)..".wav")
					local fx = EffectData()
						fx:SetEntity(self.Weapon)
						fx:SetOrigin(trace.HitPos)
						fx:SetNormal(trace.HitNormal)
					util.Effect("StunstickImpact",fx)
				end
			end
		end)
		
	end
end

function SWEP:SmackEffect(tr)
	local vSrc = tr.StartPos
	local bFirstTimePredicted = IsFirstTimePredicted()
	local bHitWater = bit.band(util.PointContents(vSrc), MASK_WATER) ~= 0
	local bEndNotWater = bit.band(util.PointContents(tr.HitPos), MASK_WATER) == 0

	local trSplash = bHitWater and bEndNotWater and util.TraceLine({
		start = tr.HitPos,
		endpos = vSrc,
		mask = MASK_WATER
	}) or not (bHitWater or bEndNotWater) and util.TraceLine({
		start = vSrc,
		endpos = tr.HitPos,
		mask = MASK_WATER
	})

	if (trSplash and bFirstTimePredicted) then
		local data = EffectData()
		data:SetOrigin(trSplash.HitPos)
		data:SetScale(5)

		if (bit.band(util.PointContents(trSplash.HitPos), CONTENTS_SLIME) ~= 0) then
			data:SetFlags(1) --FX_WATER_IN_SLIME
		end

		util.Effect("watersplash", data)
	end

	self:DoImpactEffect(tr, DMG_BLAST)
	if (tr.Hit and bFirstTimePredicted and not trSplash) then
		local data = EffectData()
		data:SetOrigin(tr.HitPos)
		data:SetStart(vSrc)
		data:SetSurfaceProp(tr.SurfaceProps)
		data:SetDamageType(DMG_BLAST)
		data:SetHitBox(tr.HitBox)
		data:SetEntity(tr.Entity)
		util.Effect("Impact", data)
		util.Effect("StunstickImpact", data)
	end
end

SWEP.IdleTranslate = { }
SWEP.IdleTranslate[ ACT_MP_STAND_IDLE ] 					= ACT_IDLE;
SWEP.IdleTranslate[ ACT_MP_WALK ] 						    = ACT_WALK;
SWEP.IdleTranslate[ ACT_MP_RUN ] 						    = ACT_RUN;
SWEP.IdleTranslate[ ACT_MP_CROUCH_IDLE ] 				    = ACT_COVER_PISTOL_LOW;
SWEP.IdleTranslate[ ACT_MP_CROUCHWALK ] 					= ACT_WALK_CROUCH ;
SWEP.IdleTranslate[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	    = ACT_MELEE_ATTACK_SWING;
SWEP.IdleTranslate[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ]	    = ACT_MELEE_ATTACK_SWING;
SWEP.IdleTranslate[ ACT_MP_RELOAD_STAND ]		 		    = ACT_RELOAD;
SWEP.IdleTranslate[ ACT_MP_RELOAD_CROUCH ]		 		    = ACT_RELOAD;
SWEP.IdleTranslate[ ACT_MP_JUMP ] 						    = ACT_JUMP;
SWEP.IdleTranslate[ ACT_MP_SWIM_IDLE ] 						= ACT_JUMP;
SWEP.IdleTranslate[ ACT_MP_SWIM ] 						    = ACT_JUMP;

SWEP.AngryTranslate = { }
SWEP.AngryTranslate[ ACT_MP_STAND_IDLE ] 					= ACT_IDLE_ANGRY_MELEE;
SWEP.AngryTranslate[ ACT_MP_WALK ] 						    = ACT_WALK_ANGRY;
SWEP.AngryTranslate[ ACT_MP_RUN ] 						    = ACT_RUN;
SWEP.AngryTranslate[ ACT_MP_CROUCH_IDLE ] 				    = ACT_COVER_PISTOL_LOW;
SWEP.AngryTranslate[ ACT_MP_CROUCHWALK ] 					= ACT_WALK_CROUCH ;
SWEP.AngryTranslate[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	    = ACT_MELEE_ATTACK_SWING;
SWEP.AngryTranslate[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ]	    = ACT_MELEE_ATTACK_SWING;
SWEP.AngryTranslate[ ACT_MP_RELOAD_STAND ]		 		    = ACT_RELOAD;
SWEP.AngryTranslate[ ACT_MP_RELOAD_CROUCH ]		 		    = ACT_RELOAD;
SWEP.AngryTranslate[ ACT_MP_JUMP ] 						    = ACT_JUMP;
SWEP.AngryTranslate[ ACT_MP_SWIM_IDLE ] 					= ACT_JUMP;
SWEP.AngryTranslate[ ACT_MP_SWIM ] 						    = ACT_JUMP;

SWEP.FemTranslate = { }
SWEP.FemTranslate[ ACT_MP_STAND_IDLE ] 					= ACT_MP_STAND_IDLE;
SWEP.FemTranslate[ ACT_MP_WALK ] 						    = ACT_MP_WALK;
SWEP.FemTranslate[ ACT_MP_RUN ] 						    = ACT_MP_RUN;
SWEP.FemTranslate[ ACT_MP_CROUCH_IDLE ] 				    = ACT_MP_CROUCH_IDLE;
SWEP.FemTranslate[ ACT_MP_CROUCHWALK ] 					= ACT_MP_CROUCHWALK ;
SWEP.FemTranslate[ ACT_MP_ATTACK_STAND_PRIMARYFIRE ] 	    = ACT_MELEE_ATTACK_SWING;
SWEP.FemTranslate[ ACT_MP_ATTACK_CROUCH_PRIMARYFIRE ]	    = ACT_MELEE_ATTACK_SWING;
SWEP.FemTranslate[ ACT_MP_RELOAD_STAND ]		 		    = ACT_RELOAD;
SWEP.FemTranslate[ ACT_MP_RELOAD_CROUCH ]		 		    = ACT_RELOAD;
SWEP.FemTranslate[ ACT_MP_JUMP ] 						    = ACT_JUMP;
SWEP.FemTranslate[ ACT_MP_SWIM_IDLE ] 					= ACT_JUMP;
SWEP.FemTranslate[ ACT_MP_SWIM ] 						    = ACT_JUMP;

function SWEP:TranslateActivity( act )
	
	if self.Owner:GetNWString("Player_Sex") == "Мужской" then
		if self:GetNWBool("Angry") then
			
			if ( self.AngryTranslate[ act ] != nil ) then
				return self.AngryTranslate[ act ]
			end

			return -1
			
		else
			
			if ( self.IdleTranslate[ act ] != nil ) then
				return self.IdleTranslate[ act ]
			end

			return -1
			
		end
	else
		if self:GetNWBool("Angry") then
			
			if ( self.AngryTranslate[ act ] != nil ) then
				return self.AngryTranslate[ act ]
			end

			return -1
			
		else
			
			if ( self.IdleTranslate[ act ] != nil ) then
				return self.IdleTranslate[ act ]
			end

			return -1
			
		end
	end
	
end

/*---------------------------------------------------------
Reload
---------------------------------------------------------*/
function SWEP:Reload()
	if CLIENT then return end
	if self.NextReload < CurTime() then
		self.NextReload = CurTime() + 0.75
		self.Owner:EmitSound("rised/weapons/stunstick/stunstick_deploy.wav", 35)
		
		if !self:GetNWBool("Angry") then
			self:SetNWBool("Angry", true)
		else
			self:SetNWBool("Angry", false)
		end
	end
end

function SWEP:OnRemove()
	self:Holster()
	return true
end

function SWEP:Deploy()

	if CLIENT then return end
	
	self.NextReload = CurTime()

	self:SetNWBool("Angry", false)

	self.Owner:EmitSound("rised/weapons/stunstick/stunstick_deploy.wav")
	
	return true
end

function SWEP:Holster()
	if self.Owner == NULL or !IsValid(self.Owner) then return true end
	
	if self.Owner:Health() <= 0 then
		self.Sound = "npc/metropolice/die"..math.random(1,4)..".wav"
		self.Owner:EmitSound(self.Sound, 100, 100)
	end
	
	return true
end

hook.Add( "PostPlayerDraw", "ThirdpersonStunstick", function( ply )
	
	local w = ply:GetActiveWeapon( )
	
	if ( IsValid( ply:GetVehicle( ) ) ) then return end
	if ( !IsValid( w ) ) then return end
	if ( w:GetClass() != "weapon_cp_stick" ) then return end
	if !w:GetNWBool("StunMode") and !w:GetNWBool("KillMode") then return end
	
	if w:GetNWBool("StunMode") then
		local muzzle = w:LookupAttachment( "1" )
		local att = w:GetAttachment( muzzle )
		if !att then return end
		local pos = att.Pos + att.Ang:Forward() * 3
		
		local rand = math.Rand(1,2.5)
		
		render.SetMaterial( STUNSTICK_GLOW_MATERIAL2 )
		render.DrawSprite( pos, 2.5 + rand, 3 + rand, Color( 255, 255, 255, 155) )
	elseif w:GetNWBool("KillMode") then
		local muzzle = w:LookupAttachment( "1" )
		local att = w:GetAttachment( muzzle )
		if !att then return end
		local pos = att.Pos + att.Ang:Forward() * 3
		
		local rand = math.Rand(1,2.5)
		
		render.SetMaterial( STUNSTICK_GLOW_MATERIAL2 )
		render.DrawSprite( pos, 5 + rand, 5 + rand, Color( 255, 1, 1, 255 ) )
	end
end)