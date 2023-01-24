-- "addons\\uweed\\lua\\entities\\uweed_seed_box\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

local grn = Color(0, 0, 0, 255)
local xpos = 175
local ypos = 0
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
	-- 	draw.RoundedBox(0, xpos, ypos+0, 380, 120, Color(0, 0, 0, 225))
	-- 	-- Side bar
	-- 	draw.RoundedBox(0, xpos, ypos+0, 10, 120, grn)
	
	-- 	draw.SimpleText(string.upper(UWeed.Translation.SeedBox.Title), "uweed_font_80", xpos+10, ypos+35, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	-- 	draw.SimpleText(UWeed.Translation.Pot.Counter.." "..self:GetSeedCount().."/"..UWeed.SeedBox.MaxStorage, "uweed_font_60", xpos+10, ypos+90, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	-- cam.End3D2D()
end