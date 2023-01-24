-- "addons\\zrewards\\lua\\zrewards\\vgui\\elements\\cl_button.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) VGUI ELEMENT - Button
    Developed by Zephruz
]]

if (CLIENT) then

surface.CreateFont("zrewards.BUTTON.MEDIUM", {
    font = "Abel",
    size = 25,
})

surface.CreateFont("zrewards.BUTTON.SMALL", {
    font = "Abel",
    size = 18,
})

end

local PANEL = {}

function PANEL:Init()
    self.theme = zrewards.vgui:GetCurrentTheme()
    self.realText = ""
    self._font = "zrewards.BUTTON.SMALL"
    self._icon = false
    self.isRounded = true
    self.isDoubleClickConfirm = false

    self:SetText("")
end

function PANEL:SetDoubleClickConfirm(bool)
    self._totalClicks = 0
    self.isDoubleClickConfirm = bool

    if (bool) then
        self.DoClick = function()
            self._totalClicks = self._totalClicks + 1

            if (self._totalClicks >= 2 && self.OnConfirm) then
                self:OnConfirm()

                self._totalClicks = 0
            end
        end
    end
end

function PANEL:GetDoubleClickConfirm()
    return self.isDoubleClickConfirm
end

function PANEL:SetIcon(icon)
    self._icon = Material(icon)
end

function PANEL:GetIcon()
    return self._icon
end

function PANEL:SetRounded(bool)
    self.isRounded = bool
end

function PANEL:GetRounded()
    return self.isRounded
end

function PANEL:SetFont(font)
    if !(font) then return end
    
    self._font = font
end

function PANEL:GetFont()
    return self._font
end

function PANEL:SizeToText(pad)
    local tW, tH = zlib.util:GetTextSize(self:GetText(), self:GetFont())
    
    self:SetWide(tW + (pad || 10))
end

function PANEL:SetText(text)
    DButton.SetText(self, "")

    self.realText = text
end

function PANEL:GetText()
    return self.realText
end

function PANEL:Paint(w,h)
    local bgCol, bgHovCol = self.theme:GetColor("button.Background"), self.theme:GetColor("button.BackgroundHover")
    local textCol = self.theme:GetColor("button.Text")
    local rounded, icon, dblClick = self:GetRounded(), self:GetIcon(), self:GetDoubleClickConfirm()
    local txt, font = self:GetText(), (self:GetFont() || "zrewards.BUTTON.SMALL")

    draw.RoundedBoxEx(4,0,0,w,h,((self:IsHovered() || self:GetDisabled()) && bgHovCol || bgCol), rounded, rounded, rounded, rounded)

    if (icon) then
        local iH, iW = 16, 16

        surface.SetDrawColor(0, 0, 0, 125)
        surface.SetMaterial(icon)
        surface.DrawTexturedRect(5, (h/2 - iH/2), iH, iW)
    end

    -- Check double click
    if (dblClick && self._totalClicks == 1) then
        txt = "Confirm"
    end

    -- Text
    draw.SimpleText(txt,font,w/2,h/2,textCol,TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
end

vgui.Register("zrewards.Button", PANEL, "DButton")