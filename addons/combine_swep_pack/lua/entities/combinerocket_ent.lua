-- "addons\\combine_swep_pack\\lua\\entities\\combinerocket_ent.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

local rSound = Sound("Missile.Accelerate")

function ENT:Draw()
	if SERVER then return end
	self:DrawModel()
end

if CLIENT then return end

function ENT:Initialize()
	
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:GetPhysicsObject():EnableDrag(false) 
	
	self.Entity:EmitSound(rSound)
	
	timer.Create("effedf222s"..self:EntIndex(),0.01,0, function()
		if not IsValid(self) then return end
		local ef = EffectData()
		ef:SetOrigin(self:GetPos())
		ef:SetAttachment(1)
		util.Effect("AR2Impact", ef, true, true)	//rocket tracer
	end)
	
end


ENT.lvc = 1


function ENT:Think()
self:NextThink(CurTime())

	for k, v in pairs(ents.FindInSphere(self:GetPos(), 200)) do
		if v:IsNPC("npc_combinegunship") or v:IsNPC("npc_helicopter") then
			local ef = EffectData()
			ef:SetOrigin(self:GetPos())
			ef:SetAttachment(1)
			ef:SetEntity(self.Weapon)
	util.Effect("ManhackSparks", ef, true, true)	//explosion
		util.Effect("ManhackSparks", ef, true, true)
			util.Effect("cball_explode", ef, true, true)
				util.Effect("cball_explode", ef, true, true)
					util.Effect("cball_bounce", ef, true, true)
						util.Effect("cball_bounce", ef, true, true)
			
			self:EmitSound("ambient/explosions/explode_"..math.random(1,4)..".wav", 500, 100)
			
			util.BlastDamage( self, self.Owner, self:GetPos(), 500, 200 )
			
			util.ScreenShake(self.Entity:GetPos(), 500, 255, 0.5, 1200)
			
			self:Remove()
		end
	end
	
	if self:WaterLevel() == 3 then
		self.lvc = self.lvc + 1
		
		if self.lvc == 3 then
			local ef = EffectData()
			ef:SetOrigin(self:GetPos())
			ef:SetAttachment(1)
			ef:SetEntity(self.Weapon)
	util.Effect("ManhackSparks", ef, true, true)	//explosion
		util.Effect("ManhackSparks", ef, true, true)
			util.Effect("cball_explode", ef, true, true)
				util.Effect("cball_explode", ef, true, true)
					util.Effect("cball_bounce", ef, true, true)
						util.Effect("cball_bounce", ef, true, true)
		
			self:EmitSound("ambient/explosions/explode_"..math.random(1,4)..".wav", 500, 100)
		
			util.BlastDamage( self, self.Owner, self:GetPos(), 500, 200 )
		
			util.ScreenShake(self.Entity:GetPos(), 500, 255, 0.5, 1200)
		
			self:Remove()
			
			self.lvc = 0
		end
	end
end

function ENT:PhysicsCollide(data,physobj)
		proj = ents.Create("prop_combine_ball")
	proj:SetPos( self:GetPos() )
	proj:SetOwner( self:GetOwner() )
	proj:Spawn()
	proj:Fire( "explode", 0, 0 )
	
	
	local ef = EffectData()
	ef:SetOrigin(self:GetPos())
	ef:SetAttachment(1)
	ef:SetEntity(self.Weapon)
	util.Effect("ManhackSparks", ef, true, true)	//explosion
		util.Effect("ManhackSparks", ef, true, true)
			util.Effect("cball_explode", ef, true, true)
				util.Effect("cball_explode", ef, true, true)
					util.Effect("cball_bounce", ef, true, true)
						util.Effect("cball_bounce", ef, true, true)
	
	self:EmitSound("ambient/explosions/explode_"..math.random(1,4)..".wav", 500, 100)
	
	util.BlastDamage( self, self.Owner, self:GetPos(), 500, 200 )
	
	util.ScreenShake(self.Entity:GetPos(), 500, 255, 0.5, 1200)
	
	self:Remove()
end

function ENT:OnRemove()
	self.Entity:StopSound(rSound)
end