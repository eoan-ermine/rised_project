-- "lua\\entities\\gas_zone1\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

function ENT:Draw()

self:DrawModel()

end

function ENT:OnRemove()
end

function ENT:Initialize()
pos = self:GetPos()

self.emitter = ParticleEmitter( pos )
end

function ENT:Think()
		 	pos = self:GetPos()
		for i=1, 1 do
			
			//end
		
		end
		
end
