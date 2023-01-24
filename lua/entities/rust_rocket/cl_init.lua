-- "lua\\entities\\rust_rocket\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	if GetConVar("tfa_rust_rocket_trails"):GetBool() then
		ParticleEffect("generic_smoke", self:GetPos(), Angle(0,0,0), self)
	end
end