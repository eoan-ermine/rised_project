-- "addons\\zrewards\\lua\\zrewards\\vgui\\elements\\cl_frame.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) VGUI ELEMENT - Frame
    Developed by Zephruz
]]

if (CLIENT) then

surface.CreateFont("zrewards.FRAME.SMALL", {
    font = "Abel",
    size = 18,
})

end

local PANEL = {}

function PANEL:Init()
    self.theme = zrewards.vgui:GetCurrentTheme()
    self.realTitle = ""

	self:DockPadding(0, 0, 0, 0)
    self:SetTitle("")
    self:ShowCloseButton(false)

    self:SetupTopNav()
end

function PANEL:SetEnableCloseButton(enable)
    if !(enable) then
        if (IsValid(self.cButton)) then
            self.cButton:Remove()
        end
    else
        self:SetupTopNav()
    end
end

function PANEL:SetTitle(text)
    DFrame.SetTitle(self, "")
    
    self.realTitle = text
end

function PANEL:GetTitle()
    return self.realTitle
end

function PANEL:SetupTopNav()
    if (IsValid(self.topNav)) then self.topNav:Remove() end

    local tnH = 25

    self.topNav = vgui.Create("DPanel", self)
    self.topNav:Dock(TOP)
    self.topNav:DockMargin(0,0,0,0)
    self.topNav:SetTall(tnH)
    self.topNav.Paint = function(s,w,h)
        local bgCol, titleCol = self.theme:GetColor("frame.TopNav.Background"), self.theme:GetColor("frame.TopNav.Title")
        
        draw.RoundedBoxEx(4,0,0,w,h,bgCol,true,true)
        draw.SimpleText(self:GetTitle(),"zrewards.FRAME.SMALL",5,h/2,titleCol,TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    self.cButton = vgui.Create("zrewards.CloseButton", self.topNav)
    self.cButton:Dock(RIGHT)
    self.cButton:DockMargin(3,3,3,3)
    self.cButton:SetWide(tnH - 6)
    self.cButton:SetCloseParent(self)
end

function PANEL:AddTopNavButton(text)
    if !(IsValid(self.topNav)) then self:SetupTopNav() end

    local tnH = self.topNav:GetTall()

    local nButton = vgui.Create("zrewards.Button", self.topNav)
    nButton:Dock(RIGHT)
    nButton:DockMargin(3,3,0,3)
    nButton:SetWide(tnH - 6)
    nButton:SetText(text or "NOTEXT")

    return nButton
end

function PANEL:GetSideNavContainer()
    return self.sideNav
end

function PANEL:EnableSideNav(bool)
    if (IsValid(self.sideNav)) then self.sideNav:Remove() end
    if !(bool) then return end

    self._snButtons = {}

    self.sideNav = vgui.Create("zrewards.Container", self)
    self.sideNav:Dock(LEFT)
    self.sideNav:SetWide(125)
    self.sideNav:SetRounded(false)
    
    -- Scroll Panel
    self.sideNav.sp = vgui.Create("zrewards.Scrollpanel", self.sideNav)
    self.sideNav.sp:Dock(FILL)
    self.sideNav.sp:SetEmptyText("")
end

function PANEL:AddSideNavButton(text, data)
    if !(IsValid(self.sideNav)) then self:EnableSideNav(true) end

    data = (data or {})

    local snButton = vgui.Create("zrewards.Button", self.sideNav.sp)
    local id = table.insert(self._snButtons, { button = snButton, data = data })
    
    snButton:Dock(TOP)
    snButton:DockMargin(0,3,0,0)
    snButton:SetTall(30)
    snButton:SetText(text or "")
    snButton:SetRounded(false)
    snButton.DoClick = function(s)
        s:SetDisabled(true)

        for k,v in pairs(self._snButtons) do
            if (k != id) then
                if (v.button && IsValid(v.button)) then
                    v.button:SetDisabled(false)
                end

                if (v.pnl && IsValid(v.pnl)) then
                    v.pnl:Remove()
                end
            end
        end

        if (data.doClick) then
            local pnl = vgui.Create("DPanel", self)
            pnl:Dock(FILL)
            pnl.Paint = function(s,w,h) end

            data.doClick(s, pnl)

            self._snButtons[id].pnl = pnl
        end
    end

    if (data.visible == false) then 
        snButton:SetVisible(false)
    end

    if (data.defActive) then
        snButton:DoClick()
    end

    self._snButtons[id].button = snButton

    return self._snButtons[id]
end

function PANEL:SetFrameBlur(bool)
    self.frameBlur = bool
end

function PANEL:GetFrameBlur()
    return self.frameBlur
end

function PANEL:Paint(w,h)
    if (self:GetBackgroundBlur()) then
		Derma_DrawBackgroundBlur(self, CurTime())
	end

    if (self:GetFrameBlur()) then
        zlib.util:DrawBlur(self,w,h)
    end

    local bgCol = self.theme:GetColor("frame.Background")

    draw.RoundedBoxEx(5,0,0,w,h,bgCol, true, true)
end

vgui.Register("zrewards.Frame", PANEL, "DFrame")