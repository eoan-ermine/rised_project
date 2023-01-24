-- "lua\\entities\\tfbow_arrow_stuck_clientside\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
	if IsValid( self:GetParent() ) then
		self:GetParent():SetupBones()
	end
	self:SetupBones()
	self:DrawModel()
end