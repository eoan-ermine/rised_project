-- "addons\\rised_medical_system\\lua\\entities\\med_station_heal\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
    self:DrawModel()

	local ang = self:GetAngles()
	ang:RotateAroundAxis( self:GetAngles():Right(),270 )
	ang:RotateAroundAxis( self:GetAngles():Forward(),90 )

	local pos = self:GetPos() + ang:Right() * -12 + ang:Up() * 7 + ang:Forward() * -5
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 250 then
		cam.Start3D2D(pos, ang, 0.05)

			draw.SimpleText('Личинок: ' .. self:GetNWInt("Lichinki"),"marske4",30,18,Color(255,255,255),0,0)

			draw.SimpleText('Заряд: ' .. self:GetNWInt("Entity_Charge"),"marske4",30,-20,Color(255,255,255),0,0)
		
		cam.End3D2D()
	end
end
