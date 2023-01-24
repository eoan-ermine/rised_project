-- "addons\\rised_permissions\\lua\\entities\\rp_dontdesturbrised\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	
	if not self.size then
		self.size = 0
		self.bsizec = false
	end
			
	local dist = LocalPlayer():GetPos():Distance(self:GetPos())
	
	if dist > 1500 then return end
	
	local angle = self.Entity:GetAngles()	
	local ang = LocalPlayer():EyeAngles()

	local position = self.Entity:GetPos() + angle:Forward() * -5 + angle:Up() * 65 + angle:Right() * -2
	
	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)
	
	cam.Start3D2D(position, ang, 0.1)
		
		local k = 8
		draw.SimpleTextOutlined("Н е   б е с п о к о и т ь", "marske5" ,0,(k*25-30), Color(255,255,255,255), 1, 1, 0.5, Color(0,0,0,255))
		
	cam.End3D2D()
end
