-- "addons\\rised_craft_system\\lua\\entities\\rcs_workbench\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
	self:DrawModel();
	
	local pos = self:GetPos()
	local ang = self:GetAngles()

	local waterColor = Color(255, 255, 255, 255);
	
	ang:RotateAroundAxis(ang:Up(), 90);
	ang:RotateAroundAxis(ang:Forward(), 90);	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 500 then
		cam.Start3D2D(pos+ang:Up()*-20.0, ang, 0.1)
			draw.SimpleTextOutlined("Рабочий стол", "marske8", 0, -205, waterColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255));
		cam.End3D2D();

	ang:RotateAroundAxis(ang:Up(), 0);
	ang:RotateAroundAxis(ang:Forward(), -90);
	ang:RotateAroundAxis(ang:Right(), 90);
	end;
end;
