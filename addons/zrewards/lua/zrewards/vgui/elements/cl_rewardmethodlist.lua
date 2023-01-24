-- "addons\\zrewards\\lua\\zrewards\\vgui\\elements\\cl_rewardmethodlist.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (SH) VGUI ELEMENT - Reward Method List
    Developed by Zephruz
]]

if (CLIENT) then

surface.CreateFont("zrewards.REGLIST.LARGE", {
    font = "Abel",
    size = 20,
    //shadow = true,
    antialias = true,
    //weight = 600
})

surface.CreateFont("zrewards.REGLIST.MEDIUM", {
    font = "Abel",
    size = 18,
})

surface.CreateFont("zrewards.REGLIST.SMALL", {
    font = "Abel",
    size = 15,
})

end

local PANEL = {}

function PANEL:Init() 
    self:LoadRewardMethodList()
end

function PANEL:LoadRewardMethodList()
    if (IsValid(self.regCont)) then self.regCont:Remove() end

    self.regCont = vgui.Create("zrewards.Container", self)
    self.regCont:Dock(FILL)
    //self.regCont.Paint = function(s,w,h) end

    local regSPnl = vgui.Create("zrewards.Scrollpanel", self.regCont)
    regSPnl:Dock(FILL)
    regSPnl:DockMargin(0,0,0,5)
    regSPnl:SetEmptyText(zrewards.lang:GetTranslation("noRewardMethods"))

    -- Load Methods
    zlib.network:CallAction("zrewards.methods.userRequest", {reqName = "getMethods"}, 
    function(regs)
        -- Check if registered
        local function fetchMethodData(name)
            local foundMethod = false

            for i,d in pairs(regs) do
                if (d.type != name) then continue end

                if (!istable(foundMethod) || foundMethod.date < d.date) then
                    foundMethod = d
                end
            end

            return foundMethod
        end

        -- Additional options
        local optsPnl = vgui.Create("zrewards.Container", self)
        optsPnl:Dock(TOP)
        optsPnl:DockMargin(0,0,0,3)
        optsPnl:SetTall(25)

        --Filter
        local cbFilter = vgui.Create("zrewards.CheckBox", optsPnl)
        cbFilter:Dock(LEFT)
        cbFilter:DockMargin(3,3,3,3)
        cbFilter:SetWide(optsPnl:GetTall() - 6)
        cbFilter:SetChecked(true)
        cbFilter.OnChange = function(s)
            local filter = s:GetChecked()
            local canv = regSPnl:GetCanvas()

            if (canv) then
                for k,v in pairs(canv:GetChildren()) do
                    if (v._isReg) then
                        v:SetVisible(!filter)
                    end
                end

                canv:InvalidateLayout(true)
            end
        end

        local tFilter = vgui.Create("DLabel", optsPnl)
        tFilter:Dock(LEFT)
        tFilter:SetTextColor(Color(255,255,255))
        tFilter:SetText("Hide verified")
        tFilter:SetFont("zrewards.REGLIST.SMALL")

        -- Create registration options
        local regTypes = zrewards.methods:GetAllTypes()

        for k,v in pairs(regTypes) do
            local rName, rUName = v:GetName(), v:GetUniqueName()
            local rDesc, rEnabled, rIcon, rOpts = v:GetDescription(), v:GetEnabled(), v:GetIcon(), v:GetExtraOptions()
            rIcon = (rIcon && Material(rIcon, "noclamp smooth"))

            if !(rEnabled) then continue end

            local rName, rUName = v:GetName(), v:GetUniqueName()
            local rews = zrewards.methods:GetTypeRewards(rUName)
            local tMat = Material("icon16/tick.png", "noclamp smooth")
            local totalOpts = table.Count(rOpts)
            local isReg = LocalPlayer():GetMethodVerified(rUName)
            local regData = fetchMethodData(rUName)

            local regPnl = vgui.Create("DPanel", regSPnl)
            regPnl:Dock(TOP)
            regPnl:DockMargin(5,5,5,0)
            regPnl:SetTall(75)
            regPnl:SetVisible(!isReg)
            regPnl._isReg = isReg
            regPnl.Think = function(s)
                s._isReg = LocalPlayer():GetMethodVerified(rUName)
            end
            regPnl.Paint = function(s,w,h)
                draw.RoundedBoxEx(4,0,0,w,h,Color(55,55,55,155),true,true,true,true)

                -- Draw icon
                if (rIcon) then
                    local iW, iH = 42, 42
                    local iX, iY = w - (iW + 5), 5

                    surface.SetMaterial(rIcon)

                    surface.SetDrawColor(0, 0, 0, 125)
                    surface.DrawTexturedRect(iX + 2, iY + 2, iW, iH)

                    surface.SetDrawColor(255, 255, 255, 255)
                    surface.DrawTexturedRect(iX, iY, iW, iH)
                end

                local tX, tY = 5, 5

                -- Draw verified mat
                local viW, viW = 16, 16

                surface.SetMaterial(tMat)

                if (isReg) then               
                    surface.SetDrawColor(255,255,255,255)
                else
                    surface.SetDrawColor(0,0,0,150)
                end

                surface.DrawTexturedRect(tX, tY, viW, viW)

                -- Draw text
                draw.SimpleText(rName || rUName,"zrewards.REGLIST.LARGE",tX+20,tY,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
                draw.SimpleText(rDesc || "NO DESCRIPTION","zrewards.REGLIST.MEDIUM",tX,h/2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)

                -- Draw reward text
                local rewText = ""

                for k,v in pairs(rews) do
                    local rewType = zrewards.rewards:GetType(k)

                    if (rewType) then
                        if (string.len(rewText) > 0) then
                            rewText = rewText .. ", "
                        end
                        rewText = rewText .. (isnumber(v) && zlib.util:FormatNumber(v) || string.upper(v)) .. " " .. rewType:GetName()
                    end
                end

                draw.SimpleText("Rewards: " .. rewText || "NO REWARDS","zrewards.REGLIST.MEDIUM",5,h-3,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_BOTTOM)
            end

            --[[
                Option buttons
            ]]
            local optBtns = {
                [zrewards.lang:GetTranslation("verify")] = {
                    order = 1,
                    w = 50,
                    visible = !isReg,
                    doClick = function()
                        local function verifyMethod(result)
                            if !(result) then return end

                            zlib.network:CallAction("zrewards.methods.userRequest", {reqName = "verifyMethod", methodName = rUName})
                        end

                        if (v && v.onClaimClicked) then
                            v:onClaimClicked(verifyMethod)
                        else
                            verifyMethod(true)
                        end
                    end,
                },
                ["+"] = {
                    order = 2,
                    w = 20,
                    visible = (totalOpts > 0),
                    hideOnReg = false,
                    doClick = function()
                        local optsMenu = vgui.Create("DMenu")

                        for k,v in pairs(rOpts) do
                            local opt = optsMenu:AddOption(k, 
                            function()
                                if (v.doClick) then
                                    v.doClick(v)
                                end
                            end)

                            if (v.icon) then
                                opt:SetIcon(v.icon)
                            end
                        end

                        optsMenu:Open()
                    end,
                }
            }

            local optPnl = vgui.Create("DPanel", regPnl)
            optPnl:Dock(BOTTOM)
            optPnl:DockMargin(5,0,0,5)
            optPnl:SetTall(22)
            optPnl.Paint = function(s,w,h) end

            for i,j in SortedPairsByMemberValue(optBtns, order, false) do
                local optBtn = vgui.Create("zrewards.Button", optPnl)
                optBtn:Dock(RIGHT)
                optBtn:DockMargin(0,5,5,0)
                optBtn:SetText(i)
                optBtn:SetWide(j.w)
                optBtn:SetVisible(j.visible != false)
                optBtn.DoClick = function(s)
                    j.doClick()
                end
                optBtn.Think = function(s)
                    if (j.hideOnReg != false) then
                        isReg = LocalPlayer():GetMethodVerified(rUName)

                        if (isReg) then s:Remove() end
                    end
                end
            end
        end
    end)
end

function PANEL:Paint(s,w,h) end

vgui.Register("zrewards.RewardMethodList", PANEL, "DPanel")