-- "addons\\rised_medical_system\\lua\\entities\\med_drug_tire\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua");

surface.CreateFont("methFont", {
	font = "Arial",
	size = 30,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
});

function ENT:Initialize()	

end;

function ENT:Draw()
	self:DrawModel();
	
	local pos = self:GetPos()
	local ang = self:GetAngles()
	local ang2 = self:GetAngles()

	local mainColor = Color(255,255,255, 255);
	
	ang2:RotateAroundAxis(ang2:Up(), 270);
	ang2:RotateAroundAxis(ang2:Forward(), 0);
	if LocalPlayer():GetPos():Distance(self:GetPos()) < self:GetNWInt("distance") then
		cam.Start3D2D(pos+ang:Up()*2, ang2, 0.08)
			draw.SimpleTextOutlined("Шина", "methFont", -25, 0, mainColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25, 100));
		cam.End3D2D();
	end;
end;

