-- "addons\\zrewards\\lua\\zrewards\\vgui\\elements\\cl_checkbox.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards 2 - (SH) VGUI ELEMENT - Check box
    Developed by Zephruz
]]

if (CLIENT) then

surface.CreateFont("zrewards.CHECKBOX.SMALL", {
    font = "Abel",
    size = 17,
})

end

local PANEL = {}

function PANEL:Init() 
    self.theme = zrewards.vgui:GetCurrentTheme()
end

function PANEL:Paint(w,h)
    local bgCol, bgCheckCol = self.theme:GetColor("checkBox.Background"), self.theme:GetColor("checkBox.Background.Active")

    draw.RoundedBoxEx(4,0,0,w,h,(self:GetChecked() && bgCheckCol || bgCol), true, true, true, true)
end

vgui.Register("zrewards.CheckBox", PANEL, "DCheckBox")