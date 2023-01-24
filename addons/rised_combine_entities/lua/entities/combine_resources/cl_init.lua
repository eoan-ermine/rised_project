-- "addons\\rised_combine_entities\\lua\\entities\\combine_resources\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	
	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 90)
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 250 then	
		cam.Start3D2D(pos+ang:Up()*16, ang, 0.12)
			draw.SimpleText("/// Контейнер сдачи ресурсов", "marske4", -120, -110, Color(255, 165, 0, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1)
		cam.End3D2D()
	end
end