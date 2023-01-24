-- "addons\\zrewards\\lua\\zrewards\\methods\\cl_methods.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    ZRewards - (CL) Methods
    Developed by Zephruz
]]

--[[
    zrewards.methods:OpenTypeRewardsMenu(name [string])

    - Opens a method types reward list menu
]]
function zrewards.methods:OpenTypeRewardsMenu(name)
    if !(name) then return end

    local regType = self:GetType(name)

    if !(regType) then return end

    local rName, rUName = regType:GetName(), regType:GetUniqueName()

    local frame = vgui.Create("zrewards.Frame")
    frame:SetSize(350, 300)
    frame:SetTitle("'".. rName .. "' " .. zrewards.lang:GetTranslation("rewards"))
    frame:Center()
    frame:MakePopup()
    frame:SetBackgroundBlur(true)

    -- Rewards
    local rews = zrewards.methods:GetTypeRewards(rUName)

    local rewCont = vgui.Create("zrewards.Container", frame)
    rewCont:Dock(FILL)
    rewCont:DockMargin(5,5,5,5)

    for k,v in pairs(rews) do
        local rewType = zrewards.rewards:GetType(k)

        if (rewType) then
            local rewIcon = rewType:GetIcon()
            rewIcon = (rewIcon && Material(rewIcon))
            
            local rewVal = (isnumber(v) && zlib.util:FormatNumber(v) || v)

            local rewPnl = vgui.Create("DPanel", rewCont)
            rewPnl:Dock(TOP)
            rewPnl:DockMargin(5,5,5,0)
            rewPnl:SetTall(30)
            rewPnl.Paint = function(s,w,h)
                draw.RoundedBoxEx(4,0,0,w,h,Color(55,55,55,155),true,true,true,true)

                local rewNmX = 5

                -- Draw Icon
                if (rewIcon) then
                    rewNmX = 28

                    local iW, iH = 16, 16

                    surface.SetMaterial(rewIcon)

                    surface.SetDrawColor(0, 0, 0, 125)
                    surface.DrawTexturedRect(7, (h/2 - iH/2) + 2, iW, iH)

                    surface.SetDrawColor(255, 255, 255, 255)
                    surface.DrawTexturedRect(5, (h/2 - iH/2), iW, iH)
                end

                -- Draw text
                draw.SimpleText(rewType:GetName(), "zrewards.POPUPMENU.MEDIUM",rewNmX,h/2,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText(tostring(rewVal), "zrewards.POPUPMENU.SMALL",w-5,h/2,Color(255,255,255),TEXT_ALIGN_RIGHT,TEXT_ALIGN_CENTER)
            end
        end
    end
end