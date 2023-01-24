-- "addons\\rised_forcefields\\lua\\entities\\rised_forcefield\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if (SERVER) then
	AddCSLuaFile()
end

local material = Material("effects/com_shield003a")
local material2 = Material("effects/com_shield004a")

local beta_shield = Material("rised/forcefields/comshieldwall")
local beta_shield2 = Material("rised/forcefields/comshieldwall2")
local beta_shield2faded = Material("rised/forcefields/comshieldwall2faded")
local beta_shield3 = Material("rised/forcefields/comshieldwall3")

ENT.Type 			= "anim"
ENT.Base 			= "base_anim"
ENT.PrintName		= "Rised Forcefield"
ENT.Category		= "Forcefields"
ENT.Spawnable		= false
ENT.AdminOnly		= true
ENT.RenderGroup 	= RENDERGROUP_BOTH

ENT.PhysgunDisabled = true

if (SERVER) then

	function ENT:SetupDataTables()
		self:DTVar("Bool", 0, "Enabled")
		self:DTVar("Bool", 1, "Alt")
		self:DTVar("Entity", 0, "Dummy")
	end

	function ENT:Initialize()
		self:SetModel("models/rised/props_combine/combine_fence01a.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:DrawShadow(false)

		self.ShieldLoop = CreateSound(self, "ambient/machines/combine_shield_loop3.wav")
		self.AllowedTeams = {}
		self.AllowedPlayers = {}
		self.Contributors = {}
	end

	function ENT:StartTouch(ent)
		if (!self:GetDTBool(0)) then return end

		if (ent:IsPlayer()) then
			if (self:ShouldCollide(ent)) then
				if (!ent.ShieldTouch) then
					ent.ShieldTouch = CreateSound(ent, "ambient/machines/combine_shield_touch_loop1.wav")
					ent.ShieldTouch:Play()
					ent.ShieldTouch:ChangeVolume(0.25, 0)
				else
					ent.ShieldTouch:Play()
					ent.ShieldTouch:ChangeVolume(0.25, 0.5)
				end
			end
		end
	end

	function ENT:Touch(ent)
		if (!self:GetDTBool(0)) then return end

		if (ent:IsPlayer()) then
			if (self:ShouldCollide(ent)) then
				if ent.ShieldTouch then
					ent.ShieldTouch:ChangeVolume(0.3, 0)
				end
			end
		end
	end

	function ENT:EndTouch(ent)
		if (!self:GetDTBool(0)) then return end

		if (ent:IsPlayer()) then
			if (self:ShouldCollide(ent)) then
				if (ent.ShieldTouch) then
					ent.ShieldTouch:FadeOut(0.5)
				end
			end
		end
	end

	function ENT:Think()
		if (IsValid(self) and self:GetDTBool(0)) then
			self.ShieldLoop:Play()
			self.ShieldLoop:ChangeVolume(0.4, 0)
		else
			self.ShieldLoop:Stop()
		end

		if self.ShieldLoop_2 then
			if (IsValid(self.fence_2) and self:GetDTBool(0)) then
				self.ShieldLoop_2:Play()
				self.ShieldLoop_2:ChangeVolume(0.4, 0)
			else
				self.ShieldLoop_2:Stop()
			end
		end

		if (IsValid(self:GetPhysicsObject())) then
			self:GetPhysicsObject():EnableMotion(false)
		end
	end

	function ENT:OnRemove()
		if (self.ShieldLoop) then
			self.ShieldLoop:Stop()
		end
		if (self.ShieldLoop_2) then
			self.ShieldLoop_2:Stop()
		end
	end

	function ENT:Toggle(value)
		if value then
			self:SetSkin(0)
			self.fence_2:SetSkin(0)
			self:EmitSound("shield/activate.wav")
			self:SetCollisionGroup(COLLISION_GROUP_NONE)
		else
			self:SetSkin(1)
			self.fence_2:SetSkin(1)
			self:EmitSound("shield/deactivate.wav")
			self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		end
		SaveForcefieldToggle(self, value)
	end

	function ENT:OnRemove()
		if (self.ShieldLoop) then
			self.ShieldLoop:Stop()
			self.ShieldLoop = nil
		end

		if (self.ShieldLoop_2) then
			self.ShieldLoop_2:Stop()
			self.ShieldLoop_2 = nil
		end

		if (self.ShieldTouch) then
			self.ShieldTouch:Stop()
			self.ShieldTouch = nil
		end
	end
end

if (CLIENT) then
	function ENT:Initialize()
		local data = {}
		data.start = self:GetPos() + Vector(0, 0, 50) + self:GetRight() * -16
		data.endpos = self:GetPos() + Vector(0, 0, 50) + self:GetRight() * -600
		data.filter = self
		local trace = util.TraceLine(data)

		local verts = {
			{pos = Vector(0, 0, -35)},
			{pos = Vector(0, 0, 150)},
			{pos = self:WorldToLocal(trace.HitPos - Vector(0, 0, 50)) + Vector(0, 0, 150)},
			{pos = self:WorldToLocal(trace.HitPos - Vector(0, 0, 50)) + Vector(0, 0, 150)},
			{pos = self:WorldToLocal(trace.HitPos - Vector(0, 0, 50)) - Vector(0, 0, 35)},
			{pos = Vector(0, 0, -35)},
		}

		self:PhysicsFromMesh(verts)
		self:EnableCustomCollisions(true)

		if (IsValid(self:GetPhysicsObject())) then
			self:GetPhysicsObject():EnableMotion(false)
		end
		
		self.AllowedTeams = {}
		self.AllowedPlayers = {}
		self.Contributors = {}
	end

	function ENT:Draw()
		local post = self:GetDTEntity(0)
		local angles = self:GetAngles()
		local matrix = Matrix()

		self:DrawModel()
		matrix:Translate(self:GetPos() + self:GetUp() * -40 + self:GetForward() * -2)
		matrix:Rotate(angles)
		
		render.SetMaterial(beta_shield2)

		if (IsValid(post)) then
			local vertex = self:WorldToLocal(post:GetPos())
			self:SetRenderBounds(vector_origin - Vector(0, 0, 40), vertex + self:GetUp() * 150)

			cam.PushModelMatrix(matrix)
			self:DrawShield(vertex)
			cam.PopModelMatrix()

			matrix:Translate(vertex)
			matrix:Rotate(Angle(0, 180, 0))

			cam.PushModelMatrix(matrix)
			self:DrawShield(vertex)
			cam.PopModelMatrix()
		end
	end

	function ENT:DrawShield(vertex)
		if (self:GetDTBool(0)) then
			local dist = self:GetDTEntity(0):GetPos():Distance(self:GetPos())
			local useAlt = self:GetDTBool(1)
			local matFac = useAlt and 70 or 45
			local height = useAlt and 3 or 5
			local frac = dist / matFac
			mesh.Begin(MATERIAL_QUADS, 1)
			mesh.Position(vector_origin)
			mesh.TexCoord(0, 0, 0)
			mesh.AdvanceVertex()
			mesh.Position(self:GetUp() * 190)
			mesh.TexCoord(0, 0, height)
			mesh.AdvanceVertex()
			mesh.Position(vertex + self:GetUp() * 190)
			mesh.TexCoord(0, frac, height)
			mesh.AdvanceVertex()
			mesh.Position(vertex)
			mesh.TexCoord(0, frac, 0)
			mesh.AdvanceVertex()
			mesh.End()
		end
	end
end

function ENT:ShouldCollide(ent)
	if (!self:GetDTBool(0)) then return false end

	if (ent:IsPlayer()) then
		if ent:isCP() || ent:Team() == TEAM_REBELSPY01 || ent:Team() == TEAM_STALKER || ent:Team() == TEAM_HAZWORKER || GAMEMODE.SynthJobs[ent:Team()] then
			return false
		else
			return true
		end
	else
		return true
	end
end

local projectiles = {}
projectiles["crossbow_bolt"]		 		= true
projectiles["grenade_ar2"]			 		= true
projectiles["hunter_flechette"]	 			= true
projectiles["npc_clawscanner"]		 		= true
projectiles["npc_combine_camera"]	 		= true
projectiles["npc_combine_s"]		 		= true
projectiles["npc_combinedropship"]	 		= true
projectiles["npc_combinegunship"]	 		= true
projectiles["npc_cscanner"]		 			= true
projectiles["npc_grenade_frag"]				= true
projectiles["npc_helicopter"]		 		= true
projectiles["npc_hunter"]			 		= true
projectiles["npc_manhack"]			 		= true
projectiles["npc_metropolice"]		 		= true
projectiles["npc_rollermine"]		 		= true
projectiles["npc_stalker"]			 		= true
projectiles["npc_strider"]			 		= true
projectiles["npc_tripmine"]		 			= true
projectiles["npc_turret_ceiling"]	 		= true
projectiles["npc_turret_floor"] 	 		= true
projectiles["prop_combine_ball"]			= true
projectiles["prop_physics"]		 			= true
projectiles["prop_vehicle_zapc"]	 		= true
projectiles["rpg_missile"]			 		= true
projectiles["sent_controllable_scanner"] 	= true

local combine_npcs = {
	"2000_CombineSoldier",
	"2000_ShotgunSoldier",
	"Beta_Stalker",
	"npc_cscanner",
	"CombineElite",
	"npc_combine_s",
	"npc_metropolice",
	"CombinePrison",
	"PrisonShotgunner",
	"npc_realistic_turret",
	"npc_rollermine",
	"npc_manhack",
	"npc_clawscanner",
	"ShotgunSoldier",
	"npc_stalker",
	"npc_turret_floor",
	"npc_combine_turret_ammosupplier",
	"npc_synth_desert",
	"npc_synth_desert_rebel",
	"npc_synth_green",
	"npc_synth_green_rebel",
	"VANCE_Combine_Assassin",
	"npc_romka_combine_elite",
	"npc_romka_combine_shotgunner",
	"npc_romka_combine_soldier",
	"npc_rtb_combine_elite",
	"npc_rised_combine",
	"npc_friendly_hlvr_combine_worker",
	"npc_friendly_hlvr_hazmat_worker",
	"npc_hostile_hlvr_combine_worker.vmt",
	"npc_hostile_hlvr_hazmat_worker",
}

hook.Add("ShouldCollide", "forcefield_ShouldCollide", function(a, b)
	local player
	local entity

	if (a:IsPlayer()) then
		player = a
		entity = b
	elseif (b:IsPlayer()) then
		player = b
		entity = a
	elseif (projectiles[a:GetClass()] or table.HasValue(combine_npcs, a:GetClass())) and b:GetClass() == "rised_forcefield" then
		return false
	elseif (projectiles[b:GetClass()] or table.HasValue(combine_npcs, a:GetClass())) and a:GetClass() == "rised_forcefield" then
		return false
	elseif (!a:IsNPC() and b:GetClass() == "rised_forcefield") then
		return false
	elseif (!b:IsNPC() and a:GetClass() == "rised_forcefield") then
		return false
	end
	
	if (IsValid(entity) and entity:GetClass() == "rised_forcefield") then
		if (IsValid(player)) then
			if (!entity:GetDTBool(0)) then
				return false
			end

			if player:isCP() || player:Team() == TEAM_REBELSPY01 || player:Team() == TEAM_STALKER || player:Team() == TEAM_HAZWORKER || GAMEMODE.SynthJobs[player:Team()] then
				return false
			else
				return true
			end
		else
			return entity:GetDTBool(0)
		end
	end
end)

hook.Add("EntityFireBullets", "forcefield_EntityFireBullets", function(ent, bullet)
	if (ent.FiredBullet) then return; end

	local tr = util.QuickTrace(bullet.Src, bullet.Dir * 10000, ent)

	if (IsValid(tr.Entity) and tr.Entity:GetClass() == "rised_forcefield") then
		for i = 1, (bullet.Num or 1) do
			local newbullet = table.Copy(bullet)
			newbullet.Src = tr.HitPos + tr.Normal * 1

			ent.FiredBullet = true
			ent:FireBullets(newbullet)
			ent.FiredBullet = false
		end

		return false
	end
end)