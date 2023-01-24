-- "addons\\rised_menus\\lua\\autorun\\client\\cl_rm_panels.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local file, Material, Fetch, find = file, Material, http.Fetch, string.find

local errorMat = Material("error")
local WebImageCache = {}
if !file.IsDir('risedrp', 'DATA') then
    file.CreateDir('risedrp')
end
function http.DownloadMaterial(url, path, callback)
    if WebImageCache[url] then return callback(WebImageCache[url]) end

    local data_path = "data/risedrp/".. path
    if file.Exists('risedrp/'..path, "DATA") then
        WebImageCache[url] = Material(data_path, "smooth", "noclamp")
        callback(WebImageCache[url])
    else
        Fetch(url, function(img)
            if img == nil or find(img, "<!DOCTYPE HTML>", 1, true) then return callback(errorMat) end
            
            file.Write('risedrp/'..path, img)
            WebImageCache[url] = Material(data_path, "smooth", "noclamp")
            callback(WebImageCache[url])
        end, function()
            callback(errorMat)
        end)
    end
end

surface.CreateFont('_font30', {font = 'Roboto', size = 30, extended = true})
surface.CreateFont('_font25', {font = 'Roboto', size = 25, extended = true})
surface.CreateFont('_font20', {font = 'Roboto', size = 20, extended = true})
surface.CreateFont('_font17', {font = 'Roboto', size = 17, extended = true})
surface.CreateFont('_font15', {font = 'Roboto', size = 15, extended = true})
surface.CreateFont('_font14', {font = 'Roboto', size = 14, extended = true})
surface.CreateFont('_font12', {font = 'Roboto', size = 12, extended = true})

local colors = {
    w = Color(235,235,235),
    green = Color(35,235,35),
    red = Color(235,35,35),
    orange = Color(215,225,100)
}

if frame then frame:Remove() frame = nil return end
local frame
local HoverOffset = 25

local bb1 = Material('materials/icons/fa32/bars.png')
local bb2 = Material('materials/icons/fa32/undo.png')

concommand.Add("extra", function(p) // чё посылаешь ((
    if frame then frame:Remove() frame = nil return end
    frame = vgui.Create("DFrame")
    frame:SetSize(ScrW() * .60, ScrH())
    frame:SetPos(ScrW() * .40, 0)
    frame:ShowCloseButton(false)
    frame:SetTitle("")
    frame:MakePopup()
    frame.OnClose = function()
        frame:Remove()
        frame = nil
    end
    frame.Paint = function(s,w,h)
        draw.RoundedBox(5,0,0,w,h,Color(0,0,0,145))
    end

    local i = 1
    local offset = 0

    frame.BackBtn = vgui.Create("DButton", frame)
    frame.BackBtn:SetPos(12,45)
    frame.BackBtn:SetText('')
    frame.BackBtn.brb = false
    frame.BackBtn.Paint = function(s,w,h)
        s.k = math.Approach(s.k or 0, s.Hovered and 150 or 0, 5)
        surface.SetDrawColor(Color(255-s.k,255-s.k,255-s.k))
        surface.SetMaterial(frame.BackBtn.brb and bb2 or bb1)
        surface.DrawTexturedRect(0,0,24,24)
        draw.SimpleText(s.brb and 'Вернуться' or 'Список', 'marske5', !frame.BackBtn.brb and w/2-15 or w/2,h/2-2, Color(255 - s.k, 255 - s.k, 255 - s.k), 1, 1)
    end
    frame.BackBtn.DoClick = function(s)
        s.brb = false
        frame.Setup()
    end
    frame.BackBtn:SetSize(170,24)

    frame.ScrollInfo = vgui.Create("DScrollPanel", frame)
    frame.ScrollInfo:SetPos(0,80)
    frame.ScrollInfo:SetSize(200,frame:GetTall() - 85)

    frame.InfoPnl = vgui.Create("DScrollPanel", frame)
    frame.InfoPnl:SetPos(200,40)
    frame.InfoPnl:SetSize(frame:GetWide() - 205,frame:GetTall() - 45)
    frame.InfoPnl.Paint = function(s,w,h)
        draw.SimpleText(s.Title ~= nil and s.Title or '', '_font30', 40, 40, colors.w, 0, 1)
    end
    frame.InfoPnl.CreateImg = function(title, x,y,w,h,t,na)
        s = frame.InfoPnl
        s.img = vgui.Create("DFrame", s)
        s.img:SetTitle(title)
        s.img:ShowCloseButton(false)
        s.img:SetSizable(true)
        http.DownloadMaterial(t, na, function(img)
            s.img.Paint = function(s,w,h)
                surface.SetDrawColor(color_white)
                surface.SetMaterial(img)
                surface.DrawTexturedRect(0,0,w,h)
            end
        end)
        s.img:SetPos(x,y)
        s.img:SetSize(w,h)
    end
    frame.InfoPnl.CreateDModelPl = function(title,x,y,w,h,mdl,sk)
        s = frame.InfoPnl
        s.img = vgui.Create("DFrame", s)
        s.img:SetTitle(title)
        s.img:ShowCloseButton(false)
        s.img:SetSizable(true)
        s.img:SetPos(x,y)
        s.img:SetSize(w,h)

        s.img.mdl = vgui.Create("DModelPanel", s.img)
        s.img.mdl:SetModel(mdl)
        s.img.mdl:SetPos(w*.1,40)
        s.img.mdl:SetSize(w*.8,h*.8)
        
        if s.img.mdl.Entity:LookupBone("ValveBiped.Bip01_Head1") ~= nil then
            s.img.mdl:SetFOV(100)
            local headpos = s.img.mdl.Entity:GetBonePosition(s.img.mdl.Entity:LookupBone("ValveBiped.Bip01_Head1"))
            s.img.mdl:SetLookAt(headpos)
            if title:EndsWith("СБ") then
                s.img.mdl:GetEntity():SetEyeTarget(Vector(200,0,15))
            end
            s.img.mdl:SetCamPos(headpos-Vector(-15, 0, 0))
        else
            s.img.mdl:SetPos(w*.1,60)
            s.img.mdl:SetFOV(95)
        end

    end
    frame.InfoPnl.CreateDModelEnt = function(title,x,y,w,h,mdl,sk)
        s = frame.InfoPnl
        s.img = vgui.Create("DFrame", s)
        s.img:SetTitle(title)
        s.img:ShowCloseButton(false)
        s.img:SetSizable(true)
        s.img:SetPos(x,y)
        s.img:SetSize(w,h)


        s.img.mdl = vgui.Create("DModelPanel", s.img)
        s.img.mdl:SetPos(20,20)
        s.img.mdl:SetSize(w-40,h-40)
        s.img.mdl:SetModel(mdl)
        if sk then
            s.img.mdl:GetEntity():SetSkin(sk)
        end

        s.img.mdl:SetLookAt(Vector(0, 0, 5))
        s.img.mdl:SetFOV(22)
        s.img.mdl:SetAnimated( true )
        s.img.mdl.Angles = Angle(0,0,0)
        s.img.mdl.DragMousePress = function(s)
            s.PressX, s.PressY = gui.MousePos()
            s.Pressed = true
        end

        s.img.mdl.DragMouseRelease = function(s)
            s.Pressed = false
        end

        s.img.mdl.LayoutEntity = function( s, ent )
            if ( s.Pressed ) then
                local mx, my = gui.MousePos()
                s.Angles = s.Angles - Angle( 0, ( s.PressX or mx ) - mx, 0 )
                s.PressX, s.PressY = gui.MousePos()
            end
            ent:SetAngles( s.Angles )
        end
    end
    
    frame.InfoPnl.CreateTxt = function(txt, x, y, font, clr, tip)
        surface.SetFont(font)
        
        local xx, yy = surface.GetTextSize(txt)
        i = i + 1

        local lines = #toLines(txt, font, frame:GetWide() - 305)

        s = frame.InfoPnl
        s.img = vgui.Create("DButton", s)
        s.img:SetText('')
        s.img:SetPos(x,75 + offset)
        s.img:SetSize(frame:GetWide() - 305, lines * 25 + 5)
        if tip then
            s.img:SetTooltip(tip)
        end
        offset = offset + y + lines * 25
        
        s.img.Paint = function(s,w,h)
            drawMultiLine(txt, font, w, 25, 0, 0, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT)
        end
    end
    frame.Setup = function()
        frame.ScrollInfo:Clear()
        frame.InfoPnl.Title = ''
        frame.InfoPnl:Clear()
        for title, inf in SortedPairs(RISED.Config.Tutorial.Menu) do
            frame.inf = vgui.Create('DButton', frame.ScrollInfo)
            frame.inf:SetText("")
            frame.inf:Dock(TOP)
            frame.inf:DockMargin(5,5,5,5)
            frame.inf.Paint = function(s,w,h)
                if (s.Hovered) then
                    draw.RoundedBoxEx(0, 0 + HoverOffset, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
                    draw.SimpleTextOutlined(title, "marske5", 5 + HoverOffset, h/2 - 8, Color(0,0,0,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, math.random(0,1), Color(215,225,100, math.random(15,20)))
                else
                    draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
                    draw.SimpleTextOutlined(title, "marske5", 10, h/2 - 8, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
                end
        
                if (s:IsDown()) then
                    draw.RoundedBoxEx(4, 0 + HoverOffset, 0, w, h, Color(25, 25, 25, 125), false, true, false, false)
                end
            end
            frame.inf.DoClick = function(s)
                
                frame.ScrollInfo:Clear()
                frame.BackBtn.brb = 1
                for title2, t in SortedPairs(inf) do
                
                    frame.inf = vgui.Create('DButton', frame.ScrollInfo)
                    frame.inf:SetText("")
                    frame.inf:Dock(TOP)
                    frame.inf.Paint = function(s,w,h)
                        if (s.Hovered) then
                            draw.RoundedBoxEx(0, 0 + HoverOffset, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
                            draw.SimpleTextOutlined(title2, "marske5", 5 + HoverOffset, h/2 - 8, Color(0,0,0,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, math.random(0,1), Color(215,225,100, math.random(15,20)))
                        else
                            draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
                            draw.SimpleTextOutlined(title2, "marske5", 10, h/2 - 8, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
                        end
                
                        if (s:IsDown()) then
                            draw.RoundedBoxEx(4, 0 + HoverOffset, 0, w, h, Color(25, 25, 25, 125), false, true, false, false)
                        end
                    end
                    frame.inf:DockMargin(5,5,5,5)
                    frame.inf.DoClick = function(s)
                        
                        frame.sel = s
                        i = 1
                        offset = 0
                        frame.InfoPnl:Clear()
                        frame.InfoPnl.Title = title2
                        if !istable(t) then
                            local code = [[
                                local args = { ... }
                                local pnl = args[1]
                            ]]
                            code = code .. t
                            local func = CompileString(code, "TestCode")
                            if func then
                                func(frame.InfoPnl)
                            end
                        else
                            i = 1
                            offset = 0
                            frame.ScrollInfo:Clear()
                            frame.InfoPnl:Clear()
                            frame.InfoPnl.Title = ''
                            for z, x in SortedPairs(t) do
                                frame.inf = vgui.Create('DButton', frame.ScrollInfo)
                                frame.inf:SetText("")
                                frame.inf:Dock(TOP)
                                frame.inf:DockMargin(5,5,5,5)
                                frame.inf.Paint = function(s,w,h)
                                    if (s.Hovered) then
                                        draw.RoundedBoxEx(0, 0 + HoverOffset, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
                                        draw.SimpleTextOutlined(z, "marske5", 5 + HoverOffset, h/2 - 8, Color(0,0,0,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, math.random(0,1), Color(215,225,100, math.random(15,20)))
                                    else
                                        draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
                                        draw.SimpleTextOutlined(z, "marske5", 10, h/2 - 8, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
                                    end
                            
                                    if (s:IsDown()) then
                                        draw.RoundedBoxEx(4, 0 + HoverOffset, 0, w, h, Color(25, 25, 25, 125), false, true, false, false)
                                    end
                                end
                                frame.inf.DoClick = function(s)
                                    
                                    i = 1
                                    offset = 0
                                    frame.InfoPnl:Clear()
                                    frame.InfoPnl.Title = z

                                    local code = [[
                                        local args = { ... }
                                        local pnl = args[1]
                                    ]]
                                    code = code .. x
                                    local func = CompileString(code, "TestCode")
                                    if func then
                                        func(frame.InfoPnl)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    frame.Setup()
end)

hook.Add("PreRender", "Rised_Panels", function()
    if input.IsKeyDown(KEY_ESCAPE) then
        CloseTutorialFrame()
    end
end)

function CloseTutorialFrame()
    if frame then
        frame:Remove()
        timer.Simple(0.2, function()
            frame = nil
        end)
        return
    end
end