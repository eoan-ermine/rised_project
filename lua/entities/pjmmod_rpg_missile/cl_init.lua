-- "lua\\entities\\pjmmod_rpg_missile\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

function ENT:Draw()
	self:DrawModel()
end

function ENT:OnRemove()
end