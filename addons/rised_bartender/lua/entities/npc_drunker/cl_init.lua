-- "addons\\rised_bartender\\lua\\entities\\npc_drunker\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")


function ENT:Draw()
	self:DrawModel()
	self:SetSequence(378)
end		