-- "addons\\uweed\\lua\\entities\\uweed_npc\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

local grn = Color(0, 0, 0, 255)
local xpos = 100
local ypos = -50
function ENT:Draw()
	self:DrawModel()
end

function ENT:DrawTranslucent()
	if self:GetPos():Distance(LocalPlayer():GetPos()) > 500 then return end
	local ang = LocalPlayer():EyeAngles()

	local pos
    if self:LookupBone("ValveBiped.Bip01_Head1") != nil then
    	pos = self:GetBonePosition(self:LookupBone("ValveBiped.Bip01_Head1")) + Vector(0,0,3)
    else 
    	pos = self:GetPos()+ Vector(0,0,68)
    end 

	ang:RotateAroundAxis(ang:Forward(), 90)
	ang:RotateAroundAxis(ang:Right(), 90)

	cam.Start3D2D(pos, ang, 0.06)
		-- Background
		draw.RoundedBox(0, xpos, ypos+0, 530, 170, Color(0, 0, 0, 225))
		-- Side bar
		draw.RoundedBox(0, xpos, ypos+0, 10, 170, grn)

		draw.SimpleText(string.upper(UWeed.Translation.NPC.Title), "uweed_font_80", xpos+10, ypos+35, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.SimpleText(string.format(UWeed.Translation.NPC.Sell, DarkRP.formatMoney(self:GetSellPrice())), "uweed_font_60", xpos+10, ypos+90, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.SimpleText(UWeed.Translation.NPC.Holding.." "..DarkRP.formatMoney(self:GetHolding()*self:GetSellPrice()), "uweed_font_60", xpos+10, ypos+140, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	cam.End3D2D()
end