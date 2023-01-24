-- "addons\\uweed\\lua\\entities\\uweed_plant\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

local grn = Color(0, 0, 0, 255)
local xpos = 200
local ypos = -200
function ENT:Draw()
	self:DrawModel()
end

function ENT:DrawTranslucent()
	if self:GetPos():Distance(LocalPlayer():GetPos()) > 500 then return end
	local ang = LocalPlayer():EyeAngles()
	local pos = self:GetPos() + Vector(0,0,10)

	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)


	local stage = self:GetStage()
	cam.Start3D2D(pos, ang, 0.06)
		-- Background
		draw.RoundedBox(0, xpos, ypos, 480, 180, Color(0, 0, 0, 225))
		-- Side bar
		draw.RoundedBox(0, xpos, ypos, 10, 180, grn)

		draw.SimpleText(string.upper(UWeed.Translation.Pot.Title), "uweed_font_80", xpos+10, ypos+35, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		if stage == 0 then
			draw.SimpleText(UWeed.Translation.Pot.PlantSeed, "uweed_font_60", xpos+10, ypos+90, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(UWeed.Translation.Pot.SeedNeeded, "uweed_font_60", xpos+10, ypos+145, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		elseif stage == 1 then
			local dots = "."
			for i=1, CurTime()%3 do
				dots = dots.."."
			end
			local lightTxt = UWeed.Translation.Pot.LightLvlGood
			if self:GetLightLevel() < 10 then
				lightTxt = UWeed.Translation.Pot.LightLvlRealBad
			elseif self:GetLightLevel() < 25 then
				lightTxt = UWeed.Translation.Pot.LightLvlBad
			elseif self:GetLightLevel() > 90 then
				lightTxt = UWeed.Translation.Pot.LightLvlRealBad2
			elseif self:GetLightLevel() > 75 then
				lightTxt = UWeed.Translation.Pot.LightLvlBad2
			end
			draw.SimpleText(UWeed.Translation.Pot.PlantGorwing..dots, "uweed_font_60", xpos+10, ypos+90, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(lightTxt, "uweed_font_60", xpos+10, ypos+145, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		elseif stage == 2 then
			draw.SimpleText(UWeed.Translation.Pot.HarvestReady, "uweed_font_60", xpos+10, ypos+90, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			draw.SimpleText(UWeed.Translation.Pot.BudCount.." "..self:GetBudCount(), "uweed_font_60", xpos+10, ypos+145, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		elseif stage == 3 then
			draw.SimpleText(UWeed.Translation.Pot.HavestRuined, "uweed_font_60", xpos+10, ypos+90, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			if self:GetLightLevel() > 50 then
				draw.SimpleText(UWeed.Translation.Pot.UseReset2, "uweed_font_60", xpos+10, ypos+145, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			else
				draw.SimpleText(UWeed.Translation.Pot.UseReset, "uweed_font_60", xpos+10, ypos+145, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			end
		end
	cam.End3D2D()
end