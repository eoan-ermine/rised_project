-- "lua\\entities\\tfa_exp_base\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:IsTranslucent()
	return true
end