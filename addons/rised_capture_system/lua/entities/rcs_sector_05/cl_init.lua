-- "addons\\rised_capture_system\\lua\\entities\\rcs_sector_05\\cl_init.lua"
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

function ENT:Draw()
	self:DrawModel();
	
	local pos = self:GetPos()
	local ang = self:GetAngles()

	local combineColor = Color(175, 175, 255, 250);
	local rebelColor = Color(115, 0, 0, 250);
	local neutralColor = Color(255, 255, 255, 255);
	
	local combineValue = self:GetNWInt("SectorCombineValue")
	local rebelValue = -combineValue
	
	ang:RotateAroundAxis(ang:Up(), 90);
	ang:RotateAroundAxis(ang:Forward(), 65);	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 500 then
		cam.Start3D2D(pos+ang:Up()*19, ang, 0.12)
			if self:GetNWBool("SectorCombine") then
				draw.SimpleTextOutlined("Под контролем Альянса", "marske4", 0, -425, col_neutral, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
				draw.SimpleTextOutlined(self.SectorName, "marske4", 0, -440, col_neutral, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
			elseif self:GetNWBool("SectorRebel") then
				draw.SimpleTextOutlined("Захвачен Сопротивлением", "marske4", 3, -425, col_neutral, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
				draw.SimpleTextOutlined(self.SectorName, "marske4", 0, -440, col_neutral, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
			else
				draw.SimpleTextOutlined("Нейтральный сектор", "marske4", 0, -425, col_neutral, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
				draw.SimpleTextOutlined(self.SectorName, "marske4", 0, -440, col_neutral, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
			end
		cam.End3D2D();
	
		if combineValue > 0 then
			cam.Start3D2D(pos+ang:Up()*19, ang, 0.12)
					surface.SetDrawColor(Color(0, 0, 0, 225))
					surface.DrawRect(-168, -410, 340, 18)
				
					surface.SetDrawColor(col_combine)
					surface.DrawRect(-164, -408, math.Round((combineValue*332)/100), 14)	
					draw.SimpleTextOutlined(math.Round((combineValue*100)/100).."%", "TargetIDSmall", 0, -402, col_neutral, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 0.3, Color(0, 0, 0, 255));
		
			cam.End3D2D()
		end
		
		if rebelValue > 0 then
			cam.Start3D2D(pos+ang:Up()*19, ang, 0.12)
					surface.SetDrawColor(Color(0, 0, 0, 225))
					surface.DrawRect(-168, -410, 340, 18)
				
					surface.SetDrawColor(col_rebel)
					surface.DrawRect(-164, -408, math.Round((rebelValue*332)/100), 14)	
					draw.SimpleTextOutlined(math.Round((rebelValue*100)/100).."%", "TargetIDSmall", 0, -402, col_neutral, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25, 0));
		
			cam.End3D2D()
		end
	ang:RotateAroundAxis(ang:Up(), 0);
	ang:RotateAroundAxis(ang:Forward(), -90);
	ang:RotateAroundAxis(ang:Right(), 90);
	end;
end;