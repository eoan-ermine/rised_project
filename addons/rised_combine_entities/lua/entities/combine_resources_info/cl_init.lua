-- "addons\\rised_combine_entities\\lua\\entities\\combine_resources_info\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	
	local pos = self:GetPos()
	local ang = self:GetAngles()

	local main_color = Color(255,165,0)
	local secondary_color = Color(255,255,255)
	local outline_color = Color(75,25,0)

	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 90)
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 250 then	

		cam.Start3D2D(pos+ang:Up()*27+ang:Forward()*10.5+ang:Right()*-42.5, ang, 0.12)
			draw.SimpleTextOutlined("Энергия:", "marske4", -65, -10, main_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, outline_color)
			draw.SimpleTextOutlined("Металл:", "marske4", -65, 35, main_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, outline_color)
			draw.SimpleTextOutlined("Микросхемы OTA:", "marske4", -140, 250, main_color, TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, outline_color)
		cam.End3D2D()	

		ang:RotateAroundAxis(ang:Right(), 25)

		cam.Start3D2D(pos+ang:Up()*17+ang:Forward()*12.5+ang:Right()*-42.5, ang, 0.12)
			draw.SimpleTextOutlined(math.Round(GetGlobalInt("CombineResource_Energy"), 2), "marske4", 190, -10, secondary_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, outline_color)
			draw.SimpleTextOutlined(math.Round(GetGlobalInt("CombineResource_Metal"), 2), "marske4", 190, 35, secondary_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, outline_color)
			draw.SimpleTextOutlined(GetGlobalInt("CombineResource_Micro"), "marske4", 180, 250, secondary_color, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, outline_color)
		cam.End3D2D()
	end
end