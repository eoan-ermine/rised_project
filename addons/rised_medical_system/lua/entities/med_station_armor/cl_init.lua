-- "addons\\rised_medical_system\\lua\\entities\\med_station_armor\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
    self:DrawModel()

	local ang = self:GetAngles()
	ang:RotateAroundAxis( self:GetAngles():Right(),270 )
	ang:RotateAroundAxis( self:GetAngles():Forward(),90 )

	local pos = self:GetPos() + ang:Right() * -7 + ang:Up() * 8.5 + ang:Forward() * -11.5
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 250 then
		cam.Start3D2D(pos, ang, 0.05)

			draw.SimpleText('Энергия: ' .. math.Round(GetGlobalInt("CombineResource_Energy"), 2),"marske4",250,-20,Color(255,255,255),0,0)
		
		cam.End3D2D()
	end
end
