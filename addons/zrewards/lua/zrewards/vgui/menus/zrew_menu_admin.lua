-- "addons\\zrewards\\lua\\zrewards\\vgui\\menus\\zrew_menu_admin.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) VGUI MENU - Admin
    Developed by Zephruz
]]

if (CLIENT) then

surface.CreateFont("zrewards.ADMINMENU.MEDIUM", {
    font = "Abel",
    size = 20,
})

surface.CreateFont("zrewards.ADMINMENU.SMALL", {
    font = "Abel",
    size = 17,
})

end

local MENU_ADMIN = zrewards.vgui:RegisterMenu("zrew.Admin")
MENU_ADMIN:SetChatCommands({"!zrew_admin", "!zrewadmin"})
MENU_ADMIN:SetConsoleCommands({"zrew_admin", "zrewadmin"})

function MENU_ADMIN:Init()
    if !(table.HasValue(zrewards.config.adminGroups, LocalPlayer():GetUserGroup())) then return end
    if (IsValid(self.frame)) then self.frame:Remove() end

    self.frame = vgui.Create("zrewards.Frame")
    self.frame:SetSize(550, 650)
    self.frame:SetTitle(zrewards.lang:GetTranslation("admin"))
    self.frame:Center()
    self.frame:MakePopup()
    self.frame:SetFrameBlur(true)

    -- Reward menu nav button
    local rewardButton = self.frame:AddTopNavButton("Main Menu")
    rewardButton:SetWide(65)
    rewardButton.DoClick = function()
        local aMenu = zrewards.vgui:GetMenu("zrew.Main")

        if (aMenu) then 
            aMenu:Init()

            self.frame:Remove()
        end
    end

    self:LoadNavigation()
end

function MENU_ADMIN:LoadNavigation()
    if !(IsValid(self.frame)) then return end

    local snButtons = {
        {
            text = zrewards.lang:GetTranslation("generalInfo"),
            icon = "icon16/cog.png",
            defActive = true,
            doClick = function(s, pnl)
                self:GeneralInfo(pnl)
            end,
        },
        {
            text = zrewards.lang:GetTranslation("users"),
            icon = "icon16/user.png",
            doClick = function(s, pnl)
                self:OpenUsers(pnl)
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

--[[General Info]]
function MENU_ADMIN:GeneralInfo(pnl)
    if !(IsValid(pnl)) then return end

    self:setData("TotalUsers", 0)
    self:setData("TotalMethods", 0)
    self:setData("TotalReferrals", 0)
    self:setData("TotalRewardsGiven", 0)

    -- Stats
    local statHdr = vgui.Create("zrewards.Header", pnl)
    statHdr:Dock(TOP)
    statHdr:SetText(zrewards.lang:GetTranslation("serverStats"))

    local sPnlCont = vgui.Create("zrewards.Container", pnl)
    sPnlCont:Dock(FILL)
    sPnlCont:DockMargin(5,3,5,5)

    local statSPnl = vgui.Create("zrewards.Scrollpanel", sPnlCont)
    statSPnl:Dock(FILL)
    statSPnl:SetEmptyText(zrewards.lang:GetTranslation("noServerStats"))

    -- Stat table
    local statTbl = {
        [zrewards.lang:GetTranslation("totalUsers")] = {
            index = 1,
            info = function()
                return self:GetTotalUsers()
            end,
        },
        [zrewards.lang:GetTranslation("totalMethods")] = {
            index = 2,
            info = function()
                return self:GetTotalMethods()
            end,
        },
        [zrewards.lang:GetTranslation("totalReferrals")] = {
            index = 3,
            visible = (zrewards.config.disableReferrals != true),
            info = function()
                return self:GetTotalReferrals()
            end,
        },
        [zrewards.lang:GetTranslation("totalRewards")] = {
            index = 4,
            info = function()
                return self:GetTotalRewardsGiven()
            end,
        },
    }

    for k,v in SortedPairsByMemberValue(statTbl, "index") do
        if (v.visible == false) then continue end
        
        local gInfoPnl = vgui.Create("DPanel", statSPnl)
        gInfoPnl:Dock(TOP)
        gInfoPnl:DockMargin(5,5,5,0)
        gInfoPnl:SetTall(30)
        gInfoPnl.Paint = function(s,w,h)
            draw.RoundedBoxEx(4,0,0,w,h,Color(55,55,55,155),true,true,true,true)

            -- Draw stat text
            draw.SimpleText(k,"zrewards.ADMINMENU.MEDIUM",5,h/2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(v.info(ply),"zrewards.ADMINMENU.SMALL",w-5,h/2,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
        end
    end

    -- Retreive Stats
    zlib.network:CallAction("zrewards.referral.adminRequest", {reqName = "getTotalUsers"},
    function(val)
        self:SetTotalUsers(val)
    end)

    zlib.network:CallAction("zrewards.referral.adminRequest", {reqName = "getTotalReferrals"},
    function(val)
        self:SetTotalReferrals(val)
    end)

    zlib.network:CallAction("zrewards.methods.adminRequest", {reqName = "getTotalMethods"},
    function(val)
        self:SetTotalMethods(val)
    end)

    zlib.network:CallAction("zrewards.rewards.adminRequest", {reqName = "getTotalRewards"},
    function(val)
        self:SetTotalRewardsGiven(val)
    end)
end

--[[Users]]
function MENU_ADMIN:OpenUsers(pnl)
    if !(IsValid(pnl)) then return end

    local function loadUser(ply, sPnl)
        if (!IsValid(ply) or !IsValid(sPnl)) then return end

        local pNick, pStid = ply:Nick(), ply:SteamID()
        local pRefID = ply:GetReferralID()

        local pPnlH = 30

        local pPnl = vgui.Create("DPanel", sPnl)
        pPnl:Dock(TOP)
        pPnl:DockMargin(5,5,5,0)
        pPnl:SetTall(pPnlH)
        pPnl.Paint = function(s,w,h)
            draw.RoundedBoxEx(4,0,0,w,h,Color(55,55,55,155),true,true,true,true)

            -- Draw user name
            draw.SimpleText(pNick .. " (" .. pStid .. ")","zrewards.ADMINMENU.SMALL",(pPnlH+2),h/2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        end

        local pAva = vgui.Create("AvatarImage", pPnl)
        pAva:Dock(LEFT)
        pAva:DockMargin(3,3,3,3)
        pAva:SetWide(pPnlH - (6))
        pAva:SetPlayer(ply, 64)

        -- View Info
        local viewPInfo = vgui.Create("zrewards.Button", pPnl)
        viewPInfo:Dock(RIGHT)
        viewPInfo:DockMargin(3,3,3,3)
        viewPInfo:SetWide(100)
        viewPInfo:SetText("View Info")
        viewPInfo.DoClick = function()
            self:OpenUserInfo(ply)
        end
    end

    --[[
        Online Users
    ]]
    local onplyHdr = vgui.Create("zrewards.Header", pnl)
    onplyHdr:Dock(TOP)
    onplyHdr:SetText(zrewards.lang:GetTranslation("onlineUsers"))

    local sPnlCont = vgui.Create("zrewards.Container", pnl)
    sPnlCont:Dock(TOP)
    sPnlCont:DockMargin(5,3,5,0)
    sPnlCont:SetTall(30)

    -- Users
    local userOnCont = vgui.Create("zrewards.Container", pnl)
    userOnCont:Dock(FILL)
    userOnCont:DockMargin(5,3,5,5)

    local userOnSPnl = vgui.Create("zrewards.Scrollpanel", userOnCont)
    userOnSPnl:Dock(FILL)
    userOnSPnl:SetEmptyText(zrewards.lang:GetTranslation("noOnlineUsers"))

    -- Search/Filter
    local searchBar = vgui.Create("zrewards.TextEntry", sPnlCont)
    searchBar:Dock(FILL)
    searchBar:DockMargin(5,5,5,5)
    searchBar:SetPlaceholder(zrewards.lang:GetTranslation("enterValueToFilter"))
    searchBar.OnEnter = function(s)
        userOnSPnl:Clear()

        local sVal = s:GetText():lower()
        local resPly = {}

        for k,v in pairs(player.GetAll()) do
            local pNick, pStid, pRefID = v:Nick():lower(), v:SteamID():lower(), v:GetReferralID():lower()
            
            if (pNick:find(sVal) or pStid:find(sVal) or pRefID:find(sVal)) then
                table.insert(resPly, v)
            end
        end

        for k,v in pairs(resPly) do
            loadUser(v, userOnSPnl)
        end
    end

    -- Load Users
    for k,v in pairs(player.GetAll()) do
        loadUser(v, userOnSPnl)
    end
end

--[[Open User Info]]
function MENU_ADMIN:OpenUserInfo(ply)
    if !(IsValid(ply)) then return end

    local pNick, pStid = ply:Nick(), (ply:IsBot() && "BOT" || ply:SteamID())
    local pRefID, pReferrerID = ply:GetReferralID(), ply:GetReferrerID()

    local frame = vgui.Create("zrewards.Frame")
    frame:SetSize(555, 300)
    frame:SetTitle(zrewards.lang:GetTranslation("viewingUser",pNick))
    frame:Center()
    frame:MakePopup()
    frame:SetBackgroundBlur(true)

    -- User Info
    local userInfoCont = vgui.Create("zrewards.Container", frame)
    userInfoCont:Dock(FILL)
    userInfoCont:DockMargin(5,5,5,0)

    local uInfoSPnl = vgui.Create("zrewards.Scrollpanel", userInfoCont)
    uInfoSPnl:Dock(FILL)
    uInfoSPnl:SetEmptyText(zrewards.lang:GetTranslation("noUserInfo"))

    local infoTbl = {
        ["Steam ID"] = {
            index = 1,
            showCopy = true,
            info = function(ply)
                return pStid
            end,
        },
        [zrewards.lang:GetTranslation("referralID")] = {
            index = 2,
            visible = (zrewards.config.disableReferrals != true),
            showCopy = true,
            info = function(ply)
                return pRefID
            end,
        },
        [zrewards.lang:GetTranslation("referrerID")] = {
            index = 3,
            visible = (zrewards.config.disableReferrals != true),
            showCopy = true,
            info = function(ply)
                return (pReferrerID != "NIL" && pReferrerID || "None")
            end,
        },
        [zrewards.lang:GetTranslation("totalReferrals")] = {
            index = 4,
            visible = (zrewards.config.disableReferrals != true),
            info = function(ply)
                return (ply._totalReferrals or 0)
            end,
        },
        [zrewards.lang:GetTranslation("totalRewards")] = {
            index = 5,
            info = function(ply)
                return (ply._totalRewards or 0)
            end,
        },
    }

    for k,v in SortedPairsByMemberValue(infoTbl, "index") do
        if (v.visible == false) then continue end

        local scBtnW = 35

        local uInfoPnl = vgui.Create("DPanel", uInfoSPnl)
        uInfoPnl:Dock(TOP)
        uInfoPnl:DockMargin(5,5,5,0)
        uInfoPnl:SetTall(30)
        uInfoPnl.Paint = function(s,w,h)
            draw.RoundedBoxEx(4,0,0,w,h,Color(55,55,55,155),true,true,true,true)

            -- Draw text
            draw.SimpleText(k,"zrewards.ADMINMENU.MEDIUM",5,h/2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            draw.SimpleText(v.info(ply),"zrewards.ADMINMENU.SMALL",w-(v.showCopy && (scBtnW+10) || 5),h/2,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
        end

        if (v.showCopy) then
            local uOpt = vgui.Create("zrewards.Button", uInfoPnl)
            uOpt:Dock(RIGHT)
            uOpt:DockMargin(3,3,3,3)
            uOpt:SetWide(scBtnW)
            uOpt:SetText("Copy")
            uOpt.DoClick = function(s)
                SetClipboardText(v.info(ply))
                zlib.notifs:Create(zrewards.lang:GetTranslation("copiedToClipboard", pNick))
            end
        end
    end

    -- Option Buttons
    local optBtns = {
        [zrewards.lang:GetTranslation("clearReferrals")] = {
            index = 4,
            visible = (zrewards.config.disableReferrals != true),
            onSetup = function(btn)
                btn:SetDoubleClickConfirm(true)

                btn.OnConfirm = function()
                    zlib.network:CallAction("zrewards.referral.adminRequest", {reqName = "clearUserReferrals", steamid = pStid},
                    function(val)
                        if !(val) then return false end
                        if (IsValid(frame)) then frame:Remove() end

                        self:OpenUserInfo(ply)

                        zlib.notifs:Create(zrewards.lang:GetTranslation("clearedReferrals", pNick))
                    end)
                end
            end,
        },
        [zrewards.lang:GetTranslation("clearMethods")] = {
            index = 5,
            onSetup = function(btn)
                btn:SetDoubleClickConfirm(true)

                btn.OnConfirm = function()
                    zlib.network:CallAction("zrewards.methods.adminRequest", {reqName = "clearUserMethods", steamid = pStid},
                    function(val)
                        if !(val) then return false end
                        if (IsValid(frame)) then frame:Remove() end

                        self:OpenUserInfo(ply)

                        zlib.notifs:Create(zrewards.lang:GetTranslation("clearedMethods", pNick))
                    end)
                end
            end,
        },
    }

    local uOptCont = vgui.Create("zrewards.Container", frame)
    uOptCont:Dock(BOTTOM)
    uOptCont:DockMargin(5,5,5,5)
    uOptCont:SetTall(25)

    for k,v in SortedPairsByMemberValue(optBtns, "index") do
        if (v.visible == false) then continue end

        local uOpt = vgui.Create("zrewards.Button", uOptCont)
        uOpt:Dock(LEFT)
        uOpt:DockMargin(3,3,0,3)
        uOpt:SetWide(105)
        uOpt:SetText(k)
        if (isfunction(v.onSetup)) then
            v.onSetup(uOpt)
        end

        if (isfunction(v.doClick)) then
            uOpt.DoClick = function()
                v.doClick() 
            end
        end
    end

    -- Get Stats
    zlib.network:CallAction("zrewards.referral.adminRequest", {reqName = "getUserTotalReferrals", steamid = pStid},
    function(val)
        ply._totalReferrals = val
    end)

    zlib.network:CallAction("zrewards.rewards.adminRequest", {reqName = "getUserTotalRewards", steamid = pStid},
    function(val)
        ply._totalRewards = val
    end)
end