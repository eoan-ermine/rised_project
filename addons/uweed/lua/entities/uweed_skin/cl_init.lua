-- "addons\\uweed\\lua\\entities\\uweed_skin\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

local grn = Color(0, 0, 0, 255)
local xpos = 100
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
	-- 	if self:GetStage() == 0 then
	-- 		-- Background
	-- 		draw.RoundedBox(0, xpos, ypos+0, 510, 120, Color(0, 0, 0, 225))
	-- 		-- Side bar
	-- 		draw.RoundedBox(0, xpos, ypos+0, 10, 120, grn)
		
	-- 		draw.SimpleText(string.upper(UWeed.Translation.Skin.Title), "uweed_font_80", xpos+10, ypos+35, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	-- 		draw.SimpleText(UWeed.Translation.Skin.NoWeed, "uweed_font_60", xpos+10, ypos+90, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	-- 	elseif self:GetStage() == 1 then
	-- 		-- Background
	-- 		draw.RoundedBox(0, xpos, ypos+0, 510, 120, Color(0, 0, 0, 225))
	-- 		-- Side bar
	-- 		draw.RoundedBox(0, xpos, ypos+0, 10, 120, grn)
		
	-- 		draw.SimpleText(string.upper(UWeed.Translation.Skin.Title), "uweed_font_80", xpos+10, ypos+35, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	-- 		draw.SimpleText("Зажмите E чтобы скрутить", "uweed_font_60", xpos+10, ypos+90, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	-- 	elseif self:GetStage() == 2 then
	-- 		-- Background
	-- 		draw.RoundedBox(0, xpos, ypos+0, 510, 120, Color(0, 0, 0, 225))
	-- 		-- Side bar
	-- 		draw.RoundedBox(0, xpos, ypos+0, 10, 120, grn)

	-- 		local dots = "."
	-- 		for i=1, CurTime()%3 do
	-- 			dots = dots.."."
	-- 		end
		
	-- 		draw.SimpleText(string.upper(UWeed.Translation.Skin.Title), "uweed_font_80", xpos+10, ypos+35, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	-- 		draw.SimpleText("Скручивание"..dots, "uweed_font_60", xpos+10, ypos+90, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	-- 	elseif self:GetStage() == 3 then
	-- 		-- Background
	-- 		draw.RoundedBox(0, xpos, ypos+0, 510, 120, Color(0, 0, 0, 225))
	-- 		-- Side bar
	-- 		draw.RoundedBox(0, xpos, ypos+0, 10, 120, grn)

	-- 		local dots = "."
	-- 		for i=1, CurTime()%3 do
	-- 			dots = dots.."."
	-- 		end
		
	-- 		draw.SimpleText(string.upper(UWeed.Translation.Skin.Title), "uweed_font_80", xpos+10, ypos+35, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	-- 		draw.SimpleText("Возьми...", "uweed_font_60", xpos+10, ypos+90, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	-- 	end
	-- cam.End3D2D()
end