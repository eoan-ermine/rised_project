-- "addons\\rised_tech\\lua\\weapons\\combine_turret_placer.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.HoldType = "duel"

local language = GetConVarString( "gmod_language" )

local WorldModel = Model( "models/combine_turrets/floor_turret.mdl" )
SWEP.ViewModel			 = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel			= WorldModel
SWEP.DrawWorldModel = false

SWEP.DrawCrosshair		= false
SWEP.Primary.ClipSize		 = -1
SWEP.Primary.DefaultClip	 = -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		 = "none"
SWEP.Primary.Delay = 1

SWEP.Secondary.ClipSize	  = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic	 = false
SWEP.Secondary.Ammo	  = "none"
SWEP.Secondary.Delay = 1

-- This is special equipment

SWEP.Spawnable = true
SWEP.LimitedStock = false

SWEP.AllowDrop = true

SWEP.NoSights = true

SWEP.PrintName = "Турель"

SWEP.Category = "A - Rised - [Альянс]"

SWEP.Author = "D-Rised"
if CLIENT then
	SWEP.Slot = 3
	SWEP.ViewModelFOV = 10
	
	local lang_desc
	local lang_mapwarn
	if language == "ru" then
		lang_desc = "Уничтожает врагов Альянса."
	else
		lang_desc = "Automatically shoot and severely harm\nimprudent rebels."
	end
	SWEP.EquipMenuData = {
		type = "item_weapon",
		desc = lang_desc
	};
	
	SWEP.Purpose = lang_desc
end

function SWEP:RemoveClientPreview()
	if CLIENT then
		if IsValid(self.viewturret) then
			self.viewturret:SetNoDraw(true)
			self.viewturret:Remove()
		end
	end
end

-- On ajoute le comportement de la prévisualisation lorsque l'arme est jetée ou ramassée.
if CLIENT then
	function SWEP:OwnerChanged() -- OnDrop does not work because it is the normal drop.
		if LocalPlayer() != self.Owner then
			self:RemoveClientPreview()
		else
			self:Deploy()
		end
	end
end

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:HealthDrop()
end
function SWEP:SecondaryAttack()
	self.Weapon:SetNextSecondaryFire( CurTime() + self.Secondary.Delay )
	self:HealthDrop()
end

function SWEP:HealthDrop()
	if SERVER then
		local ply = self.Owner
		if not IsValid( ply ) then return end
		if !GAMEMODE.MetropolicePlunger[ply:Team()] and ply:Team() != TEAM_OTA_Tech and ply:Team() != TEAM_WORKER_UNIT then DarkRP.notify(ply, 0, 3, "Вы не владеете навыком установки турелей!") return end
		if self.Planted then return end
		
		local ownerTurrets = 0
		for k, v in pairs (ents.FindByClass("npc_turret_floor")) do
			if v:GetCreator() == self.Owner then
				ownerTurrets = ownerTurrets + 1
			end
		end
		
		if ownerTurrets >= 3 then DarkRP.notify(self.Owner, 0, 5 , "Достигнут лимит турелей!") return end
		
		local vsrc = ply:GetShootPos()
		local vang = ply:GetAimVector()
		local vvel = ply:GetVelocity()
		local eyetrace = ply:GetEyeTrace()
		local distply = eyetrace.HitPos:Distance( ply:GetPos() )
		
		-- Too far from the owner
		if distply > 100 or !eyetrace.HitWorld then
			if language == "ru" then
				ply:ChatPrint( "Выберите другое место." )
			else
				ply:ChatPrint( "Неподходящее место!" )
			end
			return false
		end
		
		-- local vthrow = vvel + vang * 200

		local playerangle = ply:GetAngles()
		local supportangle
		local support = ents.Create( "prop_dynamic" )
		if IsValid( support ) then
			if ply.AddCleanup != nil then
				ply:AddCleanup( "npcs", support )
			end
			support:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )
			supportangle = support:GetAngles()
			support:SetPos( eyetrace.HitPos + Vector( 0,0,0 ) )
			support:SetColor( Color( 0,0,0,0 ) )
			support:Spawn()
			support:SetCollisionGroup( COLLISION_GROUP_WORLD ) -- no physgun, etc.

			-- Invisible (propre)
			support:SetRenderMode( 10 )
			support:DrawShadow( false )
			
			support.turret = ents.Create( "npc_turret_floor" )
			if IsValid( support.turret ) then
				self.Planted = true
				support.turret.support = support
				support.turret:SetParent( support ) -- Bug in Garry's Mod
				support.turret:SetLocalPos( Vector( 0,0,0 ) )
				
				support:SetAngles( Angle( supportangle.p, playerangle.y, supportangle.r ) )
				support.turret:SetAngles( support:GetAngles() )
				
				support.turret:Spawn()
				support.turret:SetMoveType(MOVETYPE_NONE)	
				if IsValid(support.turret:GetPhysicsObject()) then
					support.turret:GetPhysicsObject():EnableMotion(false)
				end
				
				support.turret:SetNWString("Entity_Fraction", "Combine")
				
				support.turret:EmitSound("npc/turret_floor/deploy.wav")
				for k,v in pairs(player.GetAll()) do 
					if v:isCP() or v:Team() == TEAM_REBELSPY01 or v:Team() == TEAM_ADMINISTRATOR or v:Team() == TEAM_GMAN then
						support.turret:AddEntityRelationship(v, D_LI, 99)
					else 
						support.turret:AddEntityRelationship(v, D_HT, 99)
					end
				end		
				-- Bug fix:
				support.turret:SetParent( NULL )
				support.turret:DeleteOnRemove( support )
				constraint.Weld( support.turret, support, 0, 0, 0, true, false )
				
				support.turret:Activate()
				support.turret:SetMaxHealth( 150 )
				support.turret:SetHealth( 150 )
				support.turret:SetBloodColor( BLOOD_COLOR_MECH )
				support.turret.FakeDamage = self.FakeDamage
				support.turret.weapon_ttt_turret = true
				support.turret.Icon = self.Icon
				
				support.turret:SetPhysicsAttacker( ply ) -- inutile
				support.turret:SetCreator( ply ) -- responsable des dégâts
				
				-- On empêche la tourelle de bloquer son propriétaire tant qu'il est à proximité.
				support.turret:SetOwner( ply )
				
				ply:SelectWeapon("re_hands")
				
				local turret_pos = support.turret:GetPos()
				local distance_timer = "turret"..tostring( support.turret:GetCreationID() )
				timer.Create( distance_timer, 0.2, 0, function()
					if !IsValid( support.turret ) or !IsValid( ply ) then
						timer.Destroy( distance_timer )
						return
					end
					local ply_pos = ply:GetPos()
					if math.abs( turret_pos.x-ply_pos.x )>50 or math.abs( turret_pos.y-ply_pos.y )>50 then
						support.turret:SetOwner( nil )
						timer.Destroy( distance_timer )
					end
				end )
				
				AddTaskExperience(ply, "Установка турели")
				
				self:Remove()
			end
		end
	end
end


function SWEP:Reload()
	return false
end

function SWEP:OnRemove()
	if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then
		self:RemoveClientPreview()
	end
end

if CLIENT then
		function SWEP:Initialize()
			self:Deploy()
			
			self.viewturret:SetNoDraw(true)
			self.viewturret.hidden = true
			
			return self.BaseClass.Initialize(self)
		end
end

function SWEP:Deploy()
	if SERVER and IsValid(self.Owner) then
		self.Owner:DrawViewModel(false)
	end
	if CLIENT then
		if !IsValid(self.viewturret) then
			self.viewturret = ents.CreateClientProp(WorldModel)
		end
		if IsValid(self.viewturret) then
			self.viewturret:SetParent(self)
			self.viewturret:Spawn()
			self.viewturret.WellPlaced = true
			self:Think()
		end
	end
	return true
end

function SWEP:Holster()
	self:RemoveClientPreview() -- for some reason, it does not always work
	return true
end

if CLIENT then
	function SWEP:Think()
		if IsValid(self.viewturret) then
			local ply = LocalPlayer()
			if ply:GetActiveWeapon() == self then
				if self.viewturret.hidden then -- on doit le cacher de cette façon car lors du déploiement initial le hook Deploy ne fonctionne pas
					self.viewturret:SetNoDraw(false)
					self.viewturret.hidden = false
				end
				local eyetrace = ply:GetEyeTrace()
				local newpos = eyetrace.HitPos
				local distply = newpos:Distance(ply:GetPos())
				self.viewturret:SetPos(newpos)
				self.viewturret:SetAngles(Angle(0, ply:GetAngles().y, 0) + Angle(0, 0, 0))
				if distply > 100 or !eyetrace.HitWorld then
					if self.viewturret.WellPlaced then
						self.viewturret:SetColor(Color(128,0,0))
						self.viewturret:SetMaterial("models/shiny")
						self.viewturret.WellPlaced = false
					end
				else
					if !self.viewturret.WellPlaced then
						self.viewturret:SetColor(Color(255,255,255))
						self.viewturret:SetMaterial("")
						self.viewturret.WellPlaced = true
					end
				end
			else
				if !self.viewturret.hidden then
					self.viewturret:SetNoDraw(true)
					self.viewturret.hidden = true
				end
			end
		end
	end
end
