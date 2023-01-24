-- "addons\\rised_death_system\\lua\\entities\\rds_corpse\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end