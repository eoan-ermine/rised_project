-- "addons\\zrewards\\lua\\zrewards\\vgui\\elements\\cl_closebutton.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) VGUI ELEMENT - Close Button
    Developed by Zephruz
]]

if (CLIENT) then

surface.CreateFont("zrewards.CLOSEBUTTON.MEDIUM", {
    font = "Abel",
    size = 25,
})

surface.CreateFont("zrewards.CLOSEBUTTON.SMALL", {
    font = "Roboto Light",
    size = 28,
    weight = 100,
})

end

local PANEL = {}

function PANEL:Init() 
    self.theme = zrewards.vgui:GetCurrentTheme()

    self.closeParent = nil
    self.realText = ""

    self:SetText("×")
end

function PANEL:SetText(text)
    DButton.SetText(self, "")

    self.realText = text
end

function PANEL:GetText()
    return self.realText
end

function PANEL:SetCloseParent(parent)
    self.closeParent = parent
end

function PANEL:GetCloseParent()
    return self.closeParent
end

function PANEL:DoClick()
    local cParent = self:GetCloseParent()

    if (IsValid(cParent)) then
        cParent:Remove()
    end
end

function PANEL:Paint(w,h)
    local bgCol, bgHovCol = self.theme:GetColor("closeButton.Background"), self.theme:GetColor("closeButton.BackgroundHover")
    local textCol = self.theme:GetColor("closeButton.Text")

    draw.RoundedBoxEx(4,0,0,w,h,(self:IsHovered() && bgHovCol || bgCol), true, true, true, true)
    draw.SimpleText(self:GetText(),"zrewards.CLOSEBUTTON.SMALL",w/2,h/2-2,textCol,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
end

vgui.Register("zrewards.CloseButton", PANEL, "DButton")