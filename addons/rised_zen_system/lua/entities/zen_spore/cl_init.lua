-- "addons\\rised_zen_system\\lua\\entities\\zen_spore\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
	if self:GetNWBool("Entity_Enabled") then
		self:DrawModel()
	end
end
