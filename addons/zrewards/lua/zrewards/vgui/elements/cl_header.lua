-- "addons\\zrewards\\lua\\zrewards\\vgui\\elements\\cl_header.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards 2 - (SH) VGUI ELEMENT - Header
    Developed by Zephruz
]]

if (CLIENT) then

surface.CreateFont("zrewards.HEADER.MEDIUM", {
    font = "Abel",
    size = 22,
})

surface.CreateFont("zrewards.HEADER.SMALL", {
    font = "Abel",
    size = 18,
})

surface.CreateFont("zrewards.HEADER.XSMALL", {
    font = "Abel",
    size = 15,
})

end

local PANEL = {}

function PANEL:Init()
    self.theme = zrewards.vgui:GetCurrentTheme()
    self:DockMargin(5,5,5,0)
    self:SetTall(28)
    self.isRounded = true

    self._text = ""
    self._secText = ""
end

function PANEL:SetSecondaryText(val)
    self._secText = val
end

function PANEL:GetSecondaryText()
    return self._secText
end

function PANEL:SetText(val)
    self._text = val
end

function PANEL:GetText()
    return self._text
end

function PANEL:SetRounded(bool)
    self.isRounded = bool
end

function PANEL:GetRounded()
    return self.isRounded
end

function PANEL:Paint(w,h)
    local bgCol, textCol = self.theme:GetColor("header.Background"), self.theme:GetColor("header.Text")
    local rounded = self:GetRounded()
  
    draw.RoundedBoxEx(4,0,0,w,h,bgCol,rounded,rounded,rounded,rounded)
    draw.SimpleText(self:GetText(), "zrewards.HEADER.MEDIUM", 5, h/2, textCol, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

    if (self._secText) then
        local sText, sFont = self:GetSecondaryText(), "zrewards.HEADER.SMALL"
        local tW, tH = zlib.util:GetTextSize(sText, "zrewards.HEADER.SMALL")

        if (tW >= w/2) then
            sFont = "zrewards.HEADER.XSMALL"
        end

        draw.SimpleText(sText,sFont,w-5,h/2,textCol,TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
    end
end

vgui.Register("zrewards.Header", PANEL, "DPanel")