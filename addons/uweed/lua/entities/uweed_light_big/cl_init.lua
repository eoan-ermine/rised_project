-- "addons\\uweed\\lua\\entities\\uweed_light_big\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:Think()
	if self:GetOn() then
		local dlight = DynamicLight(self:EntIndex())
		if (dlight) then
			dlight.pos = self:GetPos() + (self:GetUp()*-4)
			dlight.r = 255
			dlight.g = 255
			dlight.b = 255
			dlight.brightness = 4
			dlight.Decay = 1000
			dlight.Size = 256
			dlight.DieTime = CurTime() + 1
		end
	end
end

local grn = Color(0, 0, 0, 255)
local xpos = 500
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

	cam.Start3D2D(pos, ang, 0.06)
		if UWeed.Light.Batery then
			-- Background
			draw.RoundedBox(0, xpos, ypos+0, 665, 160, Color(0, 0, 0, 225))
			-- Side bar
			draw.RoundedBox(0, xpos, ypos+0, 10, 160, grn)
		else
			-- Background
			draw.RoundedBox(0, xpos, ypos+0, 265, 120, Color(0, 0, 0, 225))
			-- Side bar
			draw.RoundedBox(0, xpos, ypos+0, 10, 120, grn)
		end
	
		draw.SimpleText(string.upper(UWeed.Translation.BIGLAMP.Title), "uweed_font_80", xpos+10, ypos+35, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		local state = UWeed.Translation.BIGLAMP.Off
		if self:GetOn() then
			state = UWeed.Translation.BIGLAMP.On
		end
		draw.SimpleText(UWeed.Translation.BIGLAMP.State.." "..state, "uweed_font_60", xpos+10, ypos+90, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		if UWeed.Light.Batery then
			draw.SimpleText(UWeed.Translation.BIGLAMP.Battery.." "..self:GetBattery().."%", "uweed_font_60", xpos+10, ypos+135, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end

	cam.End3D2D()
end