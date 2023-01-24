-- "addons\\rised_medical_system\\lua\\entities\\rms_grub\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
	if self:GetNWBool("Entity_Enabled") then
		self:DrawModel()
	end
end
