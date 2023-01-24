-- "addons\\combine_sniper\\lua\\entities\\csniper_bullet.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

ENT.Type 					= "anim"
ENT.Base 					= "base_gmodentity"

ENT.Author 					= "TankNut"

ENT.RenderGroup 			= RENDERGROUP_TRANSLUCENT

ENT.StepSize 				= 0
ENT.MaxSteps 				= 0

ENT.MaxPenetrations 		= 0
ENT.MaxPenetrationDepth 	= 0

local speed = CreateConVar("csniper_bullet_speed", 27000, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "How quickly the sniper's bullet flies")
local damage = CreateConVar("csniper_bullet_damage", 140, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "How much damage each bullet does")
local force = CreateConVar("csniper_bullet_force", 2500, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "The amount of force applied to everything the bullet passes through")

function ENT:Initialize()
	self:DrawShadow(false)
	self.LastThink = CurTime()

	local pos = self:GetPos()

	if CLIENT then
		self.TraceLength = math.Rand(64, 128)

		local mins, maxs = pos, pos + (self:GetForward() * -self.TraceLength)

		OrderVectors(mins, maxs)

		self:SetRenderBoundsWS(mins, maxs)
	end

	if SERVER then
		local tr = util.TraceLine({
			start = pos,
			endpos = pos + (self:GetForward() * 8192),
			mask = MASK_SOLID_BRUSHONLY
		})

		local time = (pos - tr.HitPos):Length() / speed:GetFloat()

		self.SoundTime = CurTime() + (time * 0.5)

		self.Impacts = 0
		self.Filter = {}

		self:SetStartPos(pos)
		
		timer.Simple(3, function()
			if IsValid(ent) then
				ent:Remove()
			end
		end)
	end
end

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "Stopped")

	self:NetworkVar("Vector", 0, "StartPos")
end

if SERVER then
	function ENT:Stop(pos)
		self:SetPos(pos)
		self:SetStopped(CurTime())

		if self.SoundTime != -1 then
			self:SonicBoom()
		end

		SafeRemoveEntityDelayed(self, 1)
	end

	function ENT:SonicBoom()
		local pos = self:GetPos()

		self:EmitSound("NPC_Sniper.SonicBoom")

		local owner = self:GetOwner()
		local start = self:GetStartPos()

		if IsValid(owner) then
			for _, v in pairs(ents.GetAll()) do
				if not IsValid(v) or not v:IsNPC() then
					continue
				end

				if v:VisibleVec(pos) then
					v:UpdateEnemyMemory(owner, start)
				end
			end
		end

		self.SoundTime = -1
	end

	function ENT:Think()
		if self:GetStopped() != 0 then
			return
		end

		local pos = self:GetPos()

		if self.SoundTime != -1 and CurTime() >= self.SoundTime then
			self:SonicBoom()
		end

		local delta = CurTime() - self.LastThink

		self.LastThink = CurTime()
		self:NextThink(CurTime() + 0.05)

		local dir = self:GetForward()

		local target = pos + (dir * (delta * speed:GetFloat()))
		local dist = (pos - target):Length()

		local tr = util.TraceLine({
			start = pos,
			endpos = target,
			mask = MASK_SHOT,
			filter = {self:GetOwner()}
		})

		if tr.Fraction != 1 then
			local ent = tr.Entity

			if ent == game.GetWorld() or not self.Filter[ent] then
				self:GetOwner():FireBullets({
					Src = pos,
					Dir = dir,
					Damage = 110,
					Force = force:GetFloat(),
					Distance = dist,
					Tracer = 0
				})
			end

			self.Impacts = self.Impacts + 1

			if self.Impacts == self.MaxPenetrations or (IsValid(ent) and (ent:IsNPC() or ent:IsPlayer())) or tr.HitTexture == "**displacement**" then
				ent:ForcePlayerDrop()

				self:Stop(tr.HitPos)

				return true
			end

			local cursor = tr.HitPos

			for i = 1, self.MaxSteps do
				cursor = cursor + (dir * self.StepSize)

				if bit.band(util.PointContents(cursor), CONTENTS_SOLID) == 0 then
					self:SetPos(cursor)
					self.Filter[ent] = true

					return true
				end
			end

			self:Stop(tr.HitPos)
		else
			self:SetPos(target)
		end

		return true
	end
end

if CLIENT then
	function ENT:Think()
		self:SetNextClientThink(CurTime())

		if not self.WhizDone then
			local delta = CurTime() - self.LastThink

			self.LastThink = CurTime()

			local pos = self:GetPos()
			local dist, point = util.DistanceToLine(pos, pos + (self:GetAngles():Forward() * (delta * speed:GetFloat())), EyePos())

			if dist >= 72 then
				return true
			end

			sound.Play("Bullets.StriderNearmiss", point)

			self.WhizDone = true
		end

		return true
	end
	local beam = Material("effects/gunshiptracer")
	local sprite = Material("sprites/orangeflare1")

	function ENT:DrawTranslucent()
		local pos = self:GetPos()
		local dist = (pos - self:GetStartPos()):Length()

		local length = math.min(dist, self.TraceLength)
		local stopped = self:GetStopped()

		if stopped != 0 then
			local delta = CurTime() - stopped

			length = length - (delta * speed:GetFloat())

			if length <= 0 then
				return
			end
		end

		local endpos = pos + (self:GetForward() * -length)
		local color = color_white

		render.SetMaterial(beam)
		render.DrawBeam(pos, endpos, 2.5, 1, 0, color)

		-- Helps counteract the bullet being nearly invisible if being viewed from behind
		if self:GetOwner() == LocalPlayer() and LocalPlayer():GetViewEntity() == LocalPlayer() then
			local size = math.min(dist / self.TraceLength, 4)

			render.SetMaterial(sprite)
			render.DrawSprite(pos, size, size, color)
		end
	end
end