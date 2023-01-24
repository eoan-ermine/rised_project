-- "addons\\rised_medical_system\\lua\\entities\\hospital_npc_patient\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")


function ENT:Draw()
	self:DrawModel()
	self:SetSequence(112)
	-- self:SetSequence(375)
	-- self:SetSequence(115)
end		