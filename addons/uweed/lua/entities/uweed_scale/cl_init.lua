-- "addons\\uweed\\lua\\entities\\uweed_scale\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

local grn = Color(0, 0, 0, 255)
local xpos = 0
local ypos = 80
function ENT:Draw()
	self:DrawModel()
	local ang = self:GetAngles()
	local pos = self:GetPos() + (self:GetUp()*0.5)

	ang:RotateAroundAxis(ang:Forward(), 180)
	ang:RotateAroundAxis(ang:Right(), 180)
	ang:RotateAroundAxis(ang:Up(), 90)

	-- cam.Start3D2D(pos, ang, 0.06)
	-- 	-- Background
	-- 	--draw.RoundedBox(0, xpos, ypos+0, 380, 120, Color(0, 0, 0, 225))
	-- 	-- Side bar
	-- 	--draw.RoundedBox(0, xpos, ypos+0, 10, 120, grn)
	-- 	if self:GetCurrentBag() == NULL then
	-- 		draw.SimpleText(UWeed.Translation.Scale.NoBag, "uweed_font_30", xpos, ypos, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	-- 	else
	-- 		draw.SimpleText(self:GetCurrentBag():GetBudCounter()..UWeed.Translation.Scale.Gram, "uweed_font_30", xpos, ypos, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	-- 	end
	-- cam.End3D2D()
end