-- "addons\\adv_duplicator\\lua\\entities\\gmod_contr_spawner\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
	self.BaseClass.Draw(self)
	self.Entity:DrawModel()
end
