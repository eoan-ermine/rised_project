-- "addons\\darkrpmodification\\lua\\entities\\decal_npc_sit04\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")


function ENT:Draw()

	self:DrawModel()
	self:SetSequence(self:LookupSequence("sitccouchtv1"))
	
end		

