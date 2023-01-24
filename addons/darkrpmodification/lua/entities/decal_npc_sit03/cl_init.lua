-- "addons\\darkrpmodification\\lua\\entities\\decal_npc_sit03\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")


function ENT:Draw()

	self:DrawModel()
	self:SetSequence(self:LookupSequence("sitcouch1"))
	
end		

