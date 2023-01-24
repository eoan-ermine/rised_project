-- "addons\\zrewards\\lua\\zrewards\\vgui\\elements\\cl_usercard.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) VGUI ELEMENT - User Card
    Developed by Zephruz
]]

if (CLIENT) then

surface.CreateFont("zrewards.USERCARD.LARGE", {
    font = "Abel",
    size = 24,
})

surface.CreateFont("zrewards.USERCARD.MEDIUM", {
    font = "Abel",
    size = 18,
})

surface.CreateFont("zrewards.USERCARD.SMALL", {
    font = "Abel",
    size = 15,
})

end

local PANEL = {}

function PANEL:Init()
    self.theme = zrewards.vgui:GetCurrentTheme()
    self._player = nil
    self._showAvatar = true

    self:SetTall(50)
end

function PANEL:SetShowAvatar(show)
    self._showAvatar = show
end

function PANEL:SetPlayer(ply)
    self._player = ply

    self:Clear()

    // avatar
    if (self._showAvatar) then
        local aSize, aPad = self:GetTall(), 4
        local avaPnl = vgui.Create("AvatarImage", self)
        avaPnl:Dock(LEFT)
        avaPnl:DockMargin(aPad,aPad,aPad,aPad)
        avaPnl:SetSize(aSize - (aPad*2), aSize - (aPad*2))
        avaPnl:SetPlayer(ply, 64)
    end

    // Referral ID
    local refIDPnl = vgui.Create("zrewards.Container", self)
    refIDPnl:Dock(BOTTOM)
    refIDPnl:SetTall(28)
    refIDPnl.Paint = function(s,w,h)
        draw.SimpleText("Referral ID: " .. ply:GetReferralID(), "zrewards.USERCARD.MEDIUM", (self._showAvatar && 0 || 5), h/2, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    // Copy referral ID
    local copyRefID = vgui.Create("zrewards.Button", refIDPnl)
    copyRefID:Dock(RIGHT)
    copyRefID:DockMargin(5,5,5,5)
    copyRefID:SetText(zrewards.lang:GetTranslation("copyReferralID"))
    copyRefID:SizeToText()
    copyRefID.DoClick = function(s)
        SetClipboardText(ply:GetReferralID())

        zlib.notifs:Create(zrewards.lang:GetTranslation(ply == LocalPlayer() && "copiedYourReferralID" || "copiedReferrerID"))
    end
end

function PANEL:PaintOver(w, h)
    local ply = self._player

    if (ply) then
        local tX = (self._showAvatar && h || 5)
        draw.SimpleText(ply:Nick(), "zrewards.USERCARD.LARGE", tX, 5, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
        //draw.SimpleText("Referral ID: " .. ply:GetReferralID(), "zrewards.USERCARD.MEDIUM", tX, h/2, Color(255,255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
end

vgui.Register("zrewards.UserCard", PANEL, "zrewards.Container")