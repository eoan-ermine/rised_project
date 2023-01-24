-- "addons\\zrewards\\lua\\zrewards\\vgui\\elements\\cl_container.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) VGUI ELEMENT - Container
    Developed by Zephruz
]]

if (CLIENT) then

surface.CreateFont("zrewards.HEADER.MEDIUM", {
    font = "Abel",
    size = 21,
})

surface.CreateFont("zrewards.HEADER.SMALL", {
    font = "Abel",
    size = 17,
})

end

local PANEL = {}

function PANEL:Init()
    self.theme = zrewards.vgui:GetCurrentTheme()

    self.isRounded = true
end

function PANEL:SetRounded(bool)
    self.isRounded = bool
end

function PANEL:GetRounded()
    return self.isRounded
end

function PANEL:Paint(w,h)
    local bgCol = self.theme:GetColor("container.Background")
    local rounded = self:GetRounded()
  
    draw.RoundedBoxEx(4,0,0,w,h,bgCol,rounded,rounded,rounded,rounded)
end

vgui.Register("zrewards.Container", PANEL, "DPanel")

--[[
    ZRewards - (SH) VGUI ELEMENT - Header
    Developed by Zephruz
]]        
local PANEL = {}

function PANEL:Init() 
    self.theme = zrewards.vgui:GetCurrentTheme()

    self:Dock(TOP)
    self:DockMargin(5,5,5,0)
    self:SetTall(28)
end

function PANEL:SetMainText(txt)
    self.mainText = txt
end

function PANEL:SetSubText(txt)
    self.subText = txt
end

function PANEL:GetMainText() return self.mainText end
function PANEL:GetSubText() return self.subText end

function PANEL:PaintOver(w,h)
    local mainTxt, subTxt = self:GetMainText(), self:GetSubText()

    if (mainTxt) then
        draw.SimpleText(mainTxt,"zrewards.HEADER.MEDIUM",5,h/2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end
    
    if (subTxt) then
        draw.SimpleText(subTxt,"zrewards.HEADER.SMALL",w-5,h/2,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
    end
end

vgui.Register("zrewards.Header", PANEL, "zrewards.Container")