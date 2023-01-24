-- "addons\\zrewards\\lua\\zrewards\\vgui\\menus\\zrew_menu_popup.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) VGUI MENU - Main Popup
    Developed by Zephruz
]]

if (CLIENT) then

surface.CreateFont("zrewards.POPUPMENU.MEDIUM", {
    font = "Abel",
    size = 21,
})

surface.CreateFont("zrewards.POPUPMENU.SMALL", {
    font = "Abel",
    size = 17,
})

end

local MENU_POPUP = zrewards.vgui:RegisterMenu("zrew.Popup")
MENU_POPUP:SetChatCommands({"!zrew_popup", "!zrewardspopup"})
MENU_POPUP:SetConsoleCommands({"zrew_popup", "zrewardspopup"})
MENU_POPUP:SetOpenOnSpawn(zrewards.config.disablePopupMenu == false)

function MENU_POPUP:Init()
    if (IsValid(self.frame)) then self.frame:Remove() end

    self.frame = vgui.Create("zrewards.Frame")
    self.frame:SetSize(450, 600)
    self.frame:SetTitle("")
    self.frame:Center()
    self.frame:MakePopup()
    self.frame:SetFrameBlur(true)

    self:LoadReferralInfo()
    self:LoadRewardMethods()
end

function MENU_POPUP:OnOpenOnSpawn()
    // Only display if a method is not verified
    if (zrewards.config.disablePopupOnComplete) then
        for k,v in pairs(zrewards.methods:GetAllTypes()) do
            if (v && !v:GetEnabled()) then continue end

            local verified = LocalPlayer():GetMethodVerified(v:GetUniqueName())

            if !(verified) then
                return true
            end
        end

        return false
    end

    return true
end

--[[
    Referral Info
]]
function MENU_POPUP:LoadReferralInfo()
    if (!IsValid(self.frame) || zrewards.config.disableReferrals) then return end

    local userCard = vgui.Create("zrewards.UserCard", self.frame)
    userCard:Dock(TOP)
    userCard:DockMargin(5,5,5,0)
    //userCard:SetShowAvatar(false)
    userCard:SetPlayer(LocalPlayer())
end

--[[
    Method/Reward Methods
]]
function MENU_POPUP:LoadRewardMethods()
    if !(IsValid(self.frame)) then return end

    --[[Reward Methods]]
    local rewMethodHdr = vgui.Create("zrewards.Header", self.frame)
    rewMethodHdr:Dock(TOP)
    rewMethodHdr:SetText(zrewards.lang:GetTranslation("rewardMethods"))
    rewMethodHdr:SetSecondaryText(zrewards.lang:GetTranslation("getRewardsForMethod"))

    local rewMethodCont = vgui.Create("zrewards.RewardMethodList", self.frame)
    rewMethodCont:Dock(FILL)
    rewMethodCont:DockMargin(5,3,5,5)
end