-- "addons\\rised_medical_system\\lua\\entities\\med_box_grub\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	
	if not self.size then
		self.size = 0
		self.bsizec = false
	end
			
	local dist = LocalPlayer():GetPos():DistToSqr(self:GetPos())
	
	if dist > 25000 then return end
	
	local angle = self.Entity:GetAngles()	
	
	local position = self.Entity:GetPos() + angle:Forward() * 17 + angle:Up() * 25 + angle:Right() * 1
	
	angle:RotateAroundAxis(angle:Forward(), 90)
	angle:RotateAroundAxis(angle:Right(),-90)
	angle:RotateAroundAxis(angle:Up(), 0)
	
	local ang = LocalPlayer():GetAngles()
	
	cam.Start3D2D(position, angle, 0.1)
		
		local k = 8
		local encsize = 2
	
		draw.RoundedBox( 0, -100-encsize, -10-encsize + (k*25-30), encsize, 2+encsize*2, Color(255,255,255,255) )
		draw.RoundedBox( 0, 100, 10-encsize-2+ (k*25-30), encsize, 2+encsize*2, Color(255,255,255,255) )
		draw.RoundedBox( 0, -100-encsize, 10-encsize-2+ (k*25-30), encsize, 2+encsize*2, Color(255,255,255,255) )
		draw.RoundedBox( 0, 100, -10-encsize+ (k*25-30), encsize, 2+encsize*2, Color(255,255,255,255) )
		draw.RoundedBox( 0, -100, -10-encsize+ (k*25-30), 2+encsize, encsize, Color(255,255,255,255) )
		draw.RoundedBox( 0, 100-encsize-2, -10-encsize+ (k*25-30), 2+encsize, encsize, Color(255,255,255,255) )
		draw.RoundedBox( 0, 100-encsize-2, 10+ (k*25-30), 2+encsize, encsize, Color(255,255,255,255) )
		draw.RoundedBox( 0, -100, 10+ (k*25-30),  2+encsize, encsize, Color(255,255,255,255) )
		
		draw.RoundedBox( 0, -100, -10+ (k*25-30), 200, 20, Color(0,0,0,150) )
		
		draw.SimpleTextOutlined("Л и ч и н к и", "marske4" ,0,(k*25-30), Color(255,255,255,255), 1, 1, 0.5, Color(0,0,0,255))
		
	cam.End3D2D()
end
