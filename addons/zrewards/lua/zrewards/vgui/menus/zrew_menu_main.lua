-- "addons\\zrewards\\lua\\zrewards\\vgui\\menus\\zrew_menu_main.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) VGUI MENU - Main
    Developed by Zephruz
]]

if (CLIENT) then

surface.CreateFont("zrewards.MAINMENU.MEDIUM", {
    font = "Abel",
    size = 20,
})

surface.CreateFont("zrewards.MAINMENU.SMALL", {
    font = "Abel",
    size = 17,
})

end

local MENU_MAIN = zrewards.vgui:RegisterMenu("zrew.Main")
MENU_MAIN:SetChatCommands({"!zrew_main", "!zrewards"})
MENU_MAIN:SetConsoleCommands({"zrew_main", "zrewards"})

function MENU_MAIN:Init()
    if (IsValid(self.frame)) then self.frame:Remove() end

    self.frame = vgui.Create("zrewards.Frame")
    self.frame:SetSize(550, 650)
    self.frame:SetTitle("")
    self.frame:Center()
    self.frame:MakePopup()
    self.frame:SetFrameBlur(true)
    
    if (zrewards.config.showCommunityName && zrewards.config.communityName) then
        self.frame:SetTitle(zrewards.config.communityName)
    end

    -- Admin menu nav button
    local adminButton = self.frame:AddTopNavButton("Admin")
    adminButton:SetWide(60)
    adminButton:SetVisible(table.HasValue(zrewards.config.adminGroups, LocalPlayer():GetUserGroup()))
    adminButton.DoClick = function()
        local aMenu = zrewards.vgui:GetMenu("zrew.Admin")

        if (aMenu) then 
            aMenu:Init()

            self.frame:Remove()
        end
    end

    -- User card
    local userCard = vgui.Create("zrewards.UserCard", self.frame)
    userCard:Dock(TOP)
    userCard:SetShowAvatar(false)
    userCard:SetRounded(false)
    userCard:SetPlayer(LocalPlayer())

    self:LoadNavigation()
end

function MENU_MAIN:LoadNavigation()
    if !(IsValid(self.frame)) then return end

    local snButtons = {
        {
            text = zrewards.lang:GetTranslation("rewards"),
            icon = "icon16/chart_organisation.png",
            defActive = true,
            doClick = function(s, pnl)
                self:LoadRewardMenu(pnl)
            end,
        },
        {
            text = zrewards.lang:GetTranslation("referrals"),
            icon = "icon16/user.png",
            visible = (zrewards.config.disableReferrals != true),
            doClick = function(s, pnl)
                self:LoadReferralsMenu(pnl)
            end,
        },
        {
            text = zrewards.lang:GetTranslation("referralHiscores"),
            icon = "icon16/chart_bar.png",
            visible = (zrewards.config.disableReferrals != true),
            doClick = function(s, pnl)
                self:LoadReferralHiscoresMenu(pnl)
            end,
        },
    }

    for i=1,#snButtons do
        local bData = snButtons[i]

        if (bData) then
            local btnData = self.frame:AddSideNavButton(bData.text, bData)
            local btn = btnData.button

            if (IsValid(btn) && bData.icon) then
                btn:SetIcon(bData.icon)
            end 
        end
    end
end

--[[
    Reward Menu
]]
function MENU_MAIN:LoadRewardMenu(pnl)
    if !(IsValid(pnl)) then return end

    --Reward Methods
    local rewMethodHdr = vgui.Create("zrewards.Header", pnl)
    rewMethodHdr:Dock(TOP)
    rewMethodHdr:SetText(zrewards.lang:GetTranslation("rewardMethods"))
    rewMethodHdr:SetSecondaryText(zrewards.lang:GetTranslation("getRewardsForMethod"))

    local rewMethodCont = vgui.Create("zrewards.RewardMethodList", pnl)
    rewMethodCont:Dock(TOP)
    rewMethodCont:DockMargin(5,3,5,0)
    rewMethodCont:SetTall(self.frame:GetTall()/2)

    --Reward History
    local rewHdr = vgui.Create("zrewards.Header", pnl)
    rewHdr:Dock(TOP)
    rewHdr:SetText(zrewards.lang:GetTranslation("rewardHistory"))
    rewHdr:SetSecondaryText(zrewards.lang:GetTranslation("yourHistoryOfRewards"))

    local rewCont = vgui.Create("zrewards.Container", pnl)
    rewCont:Dock(FILL)
    rewCont:DockMargin(5,3,5,5)

    local rewSPnl = vgui.Create("zrewards.Scrollpanel", rewCont)
    rewSPnl:Dock(FILL)
    rewSPnl:SetEmptyText(zrewards.lang:GetTranslation("haveNoRewards"))

    -- Load reward methods
    zlib.network:CallAction("zrewards.rewards.userRequest", {reqName = "getRewards"}, 
    function(rews)
        for k,v in SortedPairs(rews, true) do
            local rewData = (v.rewardData or {})
            local rewType = zrewards.rewards:GetType(v.rewardType)
            
            if !(rewType) then continue end

            local rewFor, rewExtVal, rewVal, rewDate = v.rewardFor, v.extraVal, rewData.val, rewData.date
            local rewMethod = zrewards.methods:GetType(rewFor)
            local rewIcon, methIcon = rewType:GetIcon()
            rewIcon = (rewIcon && Material(rewIcon))

            rewVal = (isnumber(rewVal) && zlib.util:FormatNumber(rewVal) || rewVal)
            rewExtVal = (isstring(rewExtVal) && string.len(rewExtVal) > 0 && rewExtVal || false)
            rewFor = (rewMethod && rewMethod:GetName() || rewFor)
            methIcon = (rewMethod && rewMethod:GetIcon())
            methIcon = (methIcon && Material(methIcon))

            local rewPnl = vgui.Create("DPanel", rewSPnl)
            rewPnl:Dock(TOP)
            rewPnl:DockMargin(5,5,5,0)
            rewPnl:SetTall(25)
            rewPnl.Paint = function(s,w,h)
                draw.RoundedBoxEx(4,0,0,w,h,Color(55,55,55,155),true,true,true,true)

                local rewNmX = 5

                -- Draw Icon
                if (methIcon) then
                    rewNmX = 25

                    local iW, iH = 16, 16

                    surface.SetMaterial(methIcon)

                    surface.SetDrawColor(0, 0, 0, 125)
                    surface.DrawTexturedRect(7, (h/2 - iH/2) + 2, iW, iH)

                    surface.SetDrawColor(255, 255, 255, 255)
                    surface.DrawTexturedRect(5, (h/2 - iH/2), iW, iH)
                end

                -- Draw text
                //draw.SimpleText(rewType:GetName() .. (rewVal && " - " .. tostring(rewVal) || ""), "zrewards.MAINMENU.SMALL",rewNmX,h/2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText(rewFor .. (rewExtVal && " (" .. rewExtVal .. ")" || ""),"zrewards.MAINMENU.SMALL",rewNmX,h/2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText(os.date("%m/%d/%Y", tonumber(rewDate)),"zrewards.MAINMENU.SMALL",w-5,h/2,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
            end
        end
    end)
end

--[[
    Referrals Menu
]]
function MENU_MAIN:LoadReferralsMenu(pnl)
    if !(IsValid(pnl)) then return end

    pnl:Clear()

    --[[Player referrer]]
    local pRefHdr = vgui.Create("zrewards.Header", pnl)
    pRefHdr:Dock(TOP)
    pRefHdr:SetText(zrewards.lang:GetTranslation("yourReferrer"))
    pRefHdr:SetSecondaryText(zrewards.lang:GetTranslation("whoReferredYou"))

    local cont = vgui.Create("zrewards.Container", pnl)
    cont:Dock(TOP)
    cont:DockMargin(5,3,5,0)
    cont:SetTall(45)

    zlib.network:CallAction("zrewards.referral.userRequest", {reqName = "getReferrer"}, 
    function(val)
        if !(IsValid(pnl)) then return end

        local stid, data = val.stid, val.data
        local referrerid = LocalPlayer():GetReferrerID()

        if !(data) then
            -- set referral button
            local refOpt = vgui.Create("zrewards.Button", cont)
            refOpt:Dock(RIGHT)
            refOpt:DockMargin(0,3,3,3)
            refOpt:SetWide(85)
            refOpt:SetText(zrewards.lang:GetTranslation("setReferrer"))
            refOpt.DoClick = function(s)
                local frame = vgui.Create("zrewards.Frame")
                frame:SetSize(300, 90)
                frame:SetTitle("")
                frame:Center()
                frame:MakePopup()
                frame:SetBackgroundBlur(true)

                local idEntry = vgui.Create("zrewards.TextEntry", frame)
                idEntry:Dock(TOP)
                idEntry:DockMargin(5,5,5,5)
                idEntry:SetTall(30)
                idEntry:SetPlaceholder(zrewards.lang:GetTranslation("enterUserReferralID"))

                local setBtn = vgui.Create("zrewards.Button", frame)
                setBtn:Dock(FILL)
                setBtn:DockMargin(5,0,5,5)
                setBtn:SetText(zrewards.lang:GetTranslation("setAsReferrer"))
                setBtn.DoClick = function(s)
                    -- Set referrer
                    zlib.network:CallAction("zrewards.referral.userRequest", {reqName = "setReferrer", referrerid = idEntry:GetText()}, 
                    function(val)
                        local set, msg = val.set, val.msg

                        if (set) then
                            frame:Remove()
                            self:LoadReferralsMenu(pnl)

                            zlib.notifs:Create(zrewards.lang:GetTranslation(msg || "yourReferrerSet"))
                        else
                            zlib.notifs:Create(zrewards.lang:GetTranslation(msg || "unknown error"))
                        end
                    end)
                end
            end
        end

        cont.PaintOver = function(s,w,h)
            if !(data) then
                draw.SimpleText("No referrer","zrewards.MAINMENU.MEDIUM",5,h/2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            else
                draw.SimpleText(stid,"zrewards.MAINMENU.MEDIUM",5,5,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
                draw.SimpleText(os.date("%m/%d/%Y", data.date),"zrewards.MAINMENU.SMALL",w-5,h/2,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
                draw.SimpleText("Referral ID: " .. referrerid,"zrewards.MAINMENU.SMALL",5,h-5,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM)
            end
        end
    end)

    --[[Players Referrals]]
    local refHdr = vgui.Create("zrewards.Header", pnl)
    refHdr:Dock(TOP)
    refHdr:SetText("")
    refHdr:SetSecondaryText(zrewards.lang:GetTranslation("whoYouveReferred"))
    refHdr._totalRefs = 0
    refHdr.PaintOver = function(s,w,h)
        -- Draw text
        draw.SimpleText(zrewards.lang:GetTranslation("yourReferrals") .. " (" .. s._totalRefs .. ")","zrewards.MAINMENU.MEDIUM",5,h/2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end

    local referCont = vgui.Create("zrewards.Container", pnl)
    referCont:Dock(FILL)
    referCont:DockMargin(5,3,5,5)

    local referPnl = vgui.Create("zrewards.Scrollpanel", referCont)
    referPnl:Dock(FILL)
    referPnl:SetEmptyText(zrewards.lang:GetTranslation("haveNoReferrals"))

    -- Load Referrals
    zlib.network:CallAction("zrewards.referral.userRequest", {reqName = "getReferrals"}, 
    function(val) 
        if (IsValid(refHdr)) then
            refHdr._totalRefs = #val
        end

        for k,v in pairs(val) do
            local data = v.refer_data

            if !(data) then return end

            local refPnl = vgui.Create("DPanel", referPnl)
            refPnl:Dock(TOP)
            refPnl:DockMargin(5,5,5,0)
            refPnl:SetTall(25)
            refPnl.Paint = function(s,w,h)
                draw.RoundedBoxEx(4,0,0,w,h,Color(55,55,55,155),true,true,true,true)

                -- Draw refer text
                draw.SimpleText((data.nick || k) .. " (" .. (v.referred_steamid || "nil") .. ")","zrewards.MAINMENU.SMALL",5,h/2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText(zrewards.lang:GetTranslation("referredOn") .. " " .. os.date("%m/%d/%Y", data.date),"zrewards.MAINMENU.SMALL",w-5,h/2,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
            end
        end
    end)
end

--[[
    (Referral) HiScores
]]
function MENU_MAIN:LoadReferralHiscoresMenu(pnl)
    if !(IsValid(pnl)) then return end

    -- Referral HiScores
    local refHdr = vgui.Create("zrewards.Header", pnl)
    refHdr:Dock(TOP)
    refHdr:SetText(zrewards.lang:GetTranslation("referralHiscores"))
    refHdr:SetSecondaryText(zrewards.lang:GetTranslation("referralHiscoresDesc"))

    local refCont = vgui.Create("zrewards.Container", pnl)
    refCont:Dock(FILL)
    refCont:DockMargin(5,3,5,5)

    local refSPnl = vgui.Create("zrewards.Scrollpanel", refCont)
    refSPnl:Dock(FILL)
    refSPnl:SetEmptyText(zrewards.lang:GetTranslation("noReferralHiscores"))

    -- Load hiscores
    zlib.network:CallAction("zrewards.referral.userRequest", {reqName = "getReferralHiscores"}, 
    function(hiscores)
        for k,v in pairs(hiscores) do
            -- User info
            local refCount = (v.Count || 0)
            local stid = (v.SteamID || "Unknown")
            local nick = (v.Nick || (stid == "0" && "BOT" || stid))
            local avatar = (v.Avatar != nil && v.Avatar)
            
            -- Avatar parameters
            local avaSize, avaMargin = 40, 8
            local hasAva = (avatar && k < 3)

            local topCols = {
                [1] = Color(255,215,0,195),
                [2] = Color(192,192,192,195),
                [3] = Color(205,127,50,195),
            }

            -- User Panel
            local userPnl = vgui.Create("DPanel", refSPnl)
            userPnl:Dock(TOP)
            userPnl:DockMargin(5,5,5,0)
            userPnl:SetTall(hasAva && (avaSize + (avaMargin * 2)) || 35)
            userPnl.Paint = function(s,w,h)
                draw.RoundedBoxEx(4,0,0,w,h,Color(55,55,55,155),true,true,true,true)

                -- Draw top color underline
                if (table.Count(topCols) >= k) then
                    local tColH = 5
                    draw.RoundedBoxEx(4, 0, h-tColH, w, tColH, topCols[k], false, false, true, true)
                end
                
                -- Draw text
                draw.SimpleText(k, "zrewards.MAINMENU.MEDIUM",5,h/2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText(nick, "zrewards.MAINMENU.MEDIUM",w/2,h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                draw.SimpleText(refCount .. " Referral" .. (refCount > 1 && "s" || ""), "zrewards.MAINMENU.SMALL",w-5,h/2,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
            end

            -- User Avatar
            if (hasAva) then
                local httpImg = vgui.Create("zrewards.HTMLImage", userPnl)
                httpImg:Dock(LEFT)
                httpImg:DockMargin(15 + avaMargin,avaMargin,avaMargin,avaMargin)
                httpImg:SetSize(avaSize,avaSize)
                httpImg:SetURL(avatar)
            end
        end
    end)
end