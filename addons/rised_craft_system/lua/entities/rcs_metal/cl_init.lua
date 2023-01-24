-- "addons\\rised_craft_system\\lua\\entities\\rcs_metal\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	
	local pos = self:GetPos()
	local ang = self:GetAngles()

	local waterColor = Color(255, 255, 255, 255)
	
	ang:RotateAroundAxis(ang:Up(), 90)
	ang:RotateAroundAxis(ang:Forward(), 0)
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 500 then
		cam.Start3D2D(pos+ang:Right()*13.5+ang:Up()*2, ang, 0.05)
			draw.SimpleText("Металл | " .. self:GetNWInt("Rised.CraftSystem.MetalWeight") .. " кг", "marske6", 0, -205, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		cam.End3D2D()

	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), -90)
	ang:RotateAroundAxis(ang:Right(), 90)
	end
end