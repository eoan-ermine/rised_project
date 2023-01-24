-- "addons\\zrewards\\lua\\zrewards\\vgui\\elements\\cl_html.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) VGUI ELEMENT - HTML
    Developed by Zephruz
]]

if (CLIENT) then

surface.CreateFont("zrewards.HTML.MEDIUM", {
    font = "Abel",
    size = 25,
})

end

local PANEL = {}

function PANEL:Init() end

function PANEL:PaintOver(w,h)
    if !(self:IsLoading()) then return end
    
    draw.SimpleText("Loading, please wait...", "zrewards.HTML.MEDIUM", w/2 + 2, h/2 + 2, Color(55,55,55,225), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText("Loading, please wait...", "zrewards.HTML.MEDIUM", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end

vgui.Register("zrewards.HTML", PANEL, "DHTML")