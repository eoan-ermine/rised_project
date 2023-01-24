-- "addons\\zrewards\\lua\\zrewards\\vgui\\elements\\cl_scrollpanel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) VGUI ELEMENT - Scrollpanel
    Developed by Zephruz
]]

if CLIENT then

surface.CreateFont("zrewards.SCROLLPNL.MEDIUM", {
    font = "Abel",
    size = 20,
})

surface.CreateFont("zrewards.SCROLLPNL.SMALL", {
    font = "Abel",
    size = 17,
})

end

local PANEL = {}

function PANEL:Init()
    self.theme = zrewards.vgui:GetCurrentTheme()

    local function paintVB(s,w,h)
        local sbCol = self.theme:GetColor("scrollpanel.ScrollBar.GRIP")
        
        draw.RoundedBoxEx(0,0,0,w,h,sbCol)
    end

    self:PaintScrollbar(nil, paintVB, paintVB, paintVB)
end

function PANEL:SetEmptyText(text)
    self.emptyText = text
end

function PANEL:GetEmptyText()
    return (self.emptyText || zrewards.lang:GetTranslation("scrollPanelEmpty"))
end

function PANEL:PaintScrollbar(paint, btnUp, btnDown, btnGrip)
	local vBar = self:GetVBar()
    
	if !(IsValid(vBar)) then return false end
	
    vBar:SetWide(5)

	vBar.Paint = function(...) if (isfunction(paint)) then paint(...) end return end
	vBar.btnUp.Paint = function(...) if (isfunction(btnUp)) then btnUp(...) end return end
	vBar.btnDown.Paint = function(...) if (isfunction(btnDown)) then btnDown(...) end return end
	vBar.btnGrip.Paint = function(...) if (isfunction(btnGrip)) then btnGrip(...) end return end
end

function PANEL:PaintOver(w, h)
    local canvas = self:GetCanvas()

    if (IsValid(canvas) && #canvas:GetChildren() <= 0) then
        draw.SimpleText(self:GetEmptyText(),"zrewards.SCROLLPNL.SMALL",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
end

vgui.Register("zrewards.Scrollpanel", PANEL, "DScrollPanel")