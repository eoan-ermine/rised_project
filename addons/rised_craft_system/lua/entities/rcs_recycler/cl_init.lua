-- "addons\\rised_craft_system\\lua\\entities\\rcs_recycler\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

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
})

function ENT:Initialize()	

end;

function ENT:Draw()
	self:DrawModel()
	
	local pos = self:GetPos()
	local ang = self:GetAngles()

	local waterColor = Color(255, 255, 255, 255)
	
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Forward(), 90)
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 250 then
		cam.Start3D2D(pos+ang:Up()*28.3, ang, 0.06)
			draw.SimpleTextOutlined("Переработчик", "marske6", 100, -128, waterColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
		cam.End3D2D()

		ang:RotateAroundAxis(ang:Up(), 0)
		ang:RotateAroundAxis(ang:Forward(), -90)
		ang:RotateAroundAxis(ang:Right(), 90)
	end
end