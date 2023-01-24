-- "addons\\rised_medical_system\\lua\\entities\\med_drug_heptender\\cl_init.lua"
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

	local mainColor = Color(55,125,55, 255);
	
	ang:RotateAroundAxis(ang:Up(), 75);
	ang:RotateAroundAxis(ang:Right(), 90);	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < self:GetNWInt("distance") then
		cam.Start3D2D(pos+ang:Up()*3.3, ang, 0.035)
			draw.SimpleTextOutlined("Heptender", "methFont", -25, -8, mainColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25, 100));
			--draw.SimpleTextOutlined("", "methFont", -18, 12	, mainColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25, 100));
			--draw.SimpleTextOutlined(""..self:GetNWInt("amount").."Л", "methFont", 0, 34, mainColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25, 100));
		cam.End3D2D();

	ang2:RotateAroundAxis(ang2:Up(), 224);
	ang2:RotateAroundAxis(ang2:Forward(), -180);
	ang2:RotateAroundAxis(ang2:Right(), 270);		
		cam.Start3D2D(pos+ang2:Up()*3.3, ang2, 0.1)
			surface.SetDrawColor(0, 0, 0, 200);
			surface.DrawRect(-40, -7, 62, 16);
			
			surface.SetDrawColor(mainColor);
			surface.DrawRect(-38, -5, 58, 12);				
		cam.End3D2D();
	end;
end;

-- maxAmount = 60
-- amount = x

