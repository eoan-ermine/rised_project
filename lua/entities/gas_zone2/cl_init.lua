-- "lua\\entities\\gas_zone2\\cl_init.lua"
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
	/*for k, v in pairs(player.GetAll()) do
		if v:GetPos().z >= self.Entity:GetPos().z-50 then
			for i=1, 1 do
				local particle = self.emitter:Add( "particle/particle_smokegrenade", v:GetPos() + VectorRand()* 300 )
				//if (particle) then
					particle:SetVelocity(VectorRand()* 10)
					particle:SetDieTime( math.Rand( 15, 25 ) )
					particle:SetStartAlpha( 45 )
					particle:SetEndAlpha( 0 )
					particle:SetColor( 70, 255, 25 )
					particle:SetStartSize( math.Rand( 50, 65 ) )
					particle:SetEndSize( math.Rand( 150, 200 ) )
					particle:SetRoll( math.Rand(0, 360) )
					particle:SetRollDelta( math.Rand(-1, 1) )
					particle:SetAirResistance( 10 ) 
					--particle:SetCollide(true)
					--particle:SetBounce(0.1)
					--particle:SetGravity(VectorRand()* 100)
				//end
			
			end
		end
	end*/
end
