-- "lua\\entities\\tfbow_arrow\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")
local cv_ht = GetConVar("host_timescale")

function ENT:Draw()
	local ang, tmpang
	tmpang = self:GetAngles()
	ang = tmpang

	if not self.roll then
		self.roll = 0
	end

	local phobj = self:GetPhysicsObject()

	if IsValid(phobj) then
		self.roll = self.roll + phobj:GetVelocity():Length() / 3600 * cv_ht:GetFloat()
	end

	ang:RotateAroundAxis(ang:Forward(), self.roll)
	self:SetAngles(ang)
	self:DrawModel() -- Draw the model.
	self:SetAngles(tmpang)
end
