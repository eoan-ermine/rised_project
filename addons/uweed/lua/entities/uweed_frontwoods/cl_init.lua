-- "addons\\uweed\\lua\\entities\\uweed_frontwoods\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

local grn = Color(0, 0, 0, 255)
local xpos = 80
local ypos = -10
function ENT:Draw()
	self:DrawModel()
end

function ENT:DrawTranslucent()
	if self:GetPos():Distance(LocalPlayer():GetPos()) > 500 then return end
	local ang = LocalPlayer():EyeAngles()
	local pos = self:GetPos() + Vector(0,0,10)

	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)

	-- cam.Start3D2D(pos, ang, 0.06)
	-- 	-- Background
	-- 	draw.RoundedBox(0, xpos, ypos+0, 535, 150, Color(0, 0, 0, 225))
	-- 	-- Side bar
	-- 	draw.RoundedBox(0, xpos, ypos+0, 10, 150, grn)
	
	-- 	draw.SimpleText(string.upper(UWeed.Translation.Frontwoods.Title), "uweed_font_80", xpos+10, ypos+35, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	
	-- 	local amount = self:GetPaperCounter()
	-- 	for i=1, 3 do
	-- 		draw.RoundedBox(0, xpos+20, ypos+75+((i-1)*25), 505, 15, Color(35, 35, 35))
	-- 		if amount >= i then 
	-- 			draw.RoundedBox(0, xpos+20, ypos+75+((i-1)*25), 505, 15, Color(255, 255, 255))
	-- 		end

	-- 	end 
	-- cam.End3D2D()
end