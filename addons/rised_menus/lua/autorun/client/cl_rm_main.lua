-- "addons\\rised_menus\\lua\\autorun\\client\\cl_rm_main.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local fr = {}

function OpenEscape()

    if IsValid(fr) then
        fr:SetVisible(!fr:IsVisible())
        if fr:IsVisible() then fr:AlphaTo(0,0) fr:AlphaTo(255,.3) else fr:AlphaTo(0,.3) end
        return
    end

    fr = vgui.Create("DPanel")
    fr:SetSize( ScrW(), ScrH() )
    fr:MakePopup()
    fr.Paint = function(s,w,h)
    end
    
	fr.bg = vgui.Create( "Material", fr )
	fr.bg:SetPos( 0, 0 )
	fr.bg:SetMaterial( "materials/rised/bg/beta_main_menu_bg.png" )
	fr.bg:SetSize( ScrW(), ScrH() )
    
	fr.connect_panel = vgui.Create( "DPanel", fr )
	fr.connect_panel:SetPos( 0, 0 )
	fr.connect_panel:SetSize( ScrW(), ScrH() )
	fr.connect_panel.Paint = function(s,w,h)
        -- draw.RoundedBox(0, 0, 0, 134, h, Color(0,0,0,145))
        -- draw.RoundedBox(0, ScrW() * .07 + ScrW() * .2, 0, 58, h, Color(0,0,0,145))
    end

    HoverOffset = 50

    fr.list = vgui.Create('DScrollPanel', fr)
    fr.list:SetPaintBackground(0)
    fr.list:SetPos(ScrW() * .07, ScrH() * .37)
    fr.list:SetSize(ScrW() * .18, ScrH())
    fr.list.Paint = function(s,w,h)
        -- draw.RoundedBox(0, 0, 0, w, h, Color(0,0,0,145))
    end

    fr.bnt_play = vgui.Create('DButton', fr.list)
    fr.bnt_play:Dock(TOP)
    fr.bnt_play:DockMargin(0, 10, 0, 0)
    fr.bnt_play:SetSize(500,25)
    fr.bnt_play:SetText("")
    fr.bnt_play.Text = "Начать игру"
    fr.bnt_play.Paint = function(s,w,h)
        if LocalPlayer():GetNWBool("Player_MainMenu_Spawned") then
            s.Text = "Продолжить"
        end
		if (s.Hovered) then
            draw.RoundedBoxEx(0, 0 + HoverOffset, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		    -- draw.SimpleTextOutlined(fr.bnt_play.Text, "marske6", 10, h/2 - 10, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
            draw.SimpleTextOutlined(fr.bnt_play.Text, "marske6", 5 + HoverOffset, h/2 - 10, Color(0,0,0,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, math.random(0,1), Color(215,225,100, math.random(15,20)))
        else
            draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		    draw.SimpleTextOutlined(fr.bnt_play.Text, "marske6", 10, h/2 - 10, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0 + HoverOffset, 0, w, h, Color(25, 25, 25, 125), false, true, false, false)
		end
    end
    fr.bnt_play.DoClick = function()
        fr:SetVisible(false)
        CloseTutorialFrame()
        if !LocalPlayer():GetNWBool("Player_MainMenu_Spawned") and !LocalPlayer():GetNWBool("IsBanned") then
            CharacterCreator.MenuSpawn()
        end
    end

    fr.btn_tutorial = vgui.Create('DButton', fr.list)
    fr.btn_tutorial:Dock(TOP)
    fr.btn_tutorial:DockMargin(0, 75, 0, 0)
    fr.btn_tutorial:SetSize(500,25)
    fr.btn_tutorial:SetText("")
    fr.btn_tutorial.Paint = function(s,w,h)
		if (s.Hovered) then
            draw.RoundedBoxEx(0, 0 + HoverOffset, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		    -- draw.SimpleTextOutlined(fr.bnt_play.Text, "marske6", 10, h/2 - 10, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
            draw.SimpleTextOutlined("Обучение", "marske6", 5 + HoverOffset, h/2 - 10, Color(0,0,0,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, math.random(0,1), Color(215,225,100, math.random(15,20)))
        else
            draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		    draw.SimpleTextOutlined("Обучение", "marske6", 10, h/2 - 10, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0 + HoverOffset, 0, w, h, Color(25, 25, 25, 125), false, true, false, false)
		end
    end
    fr.btn_tutorial.DoClick = function()
        -- fr:SetVisible(false)
        RunConsoleCommand('extra')
    end

    fr.btn_wiki = vgui.Create('DButton', fr.list)
    fr.btn_wiki:Dock(TOP)
    fr.btn_wiki:DockMargin(0, 10, 0, 0)
    fr.btn_wiki:SetSize(500,25)
    fr.btn_wiki:SetText("")
    fr.btn_wiki.Paint = function(s,w,h)
		if (s.Hovered) then
            draw.RoundedBoxEx(0, 0 + HoverOffset, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		    -- draw.SimpleTextOutlined(fr.bnt_play.Text, "marske6", 10, h/2 - 10, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
            draw.SimpleTextOutlined("Википедия", "marske6", 5 + HoverOffset, h/2 - 10, Color(0,0,0,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, math.random(0,1), Color(215,225,100, math.random(15,20)))
        else
            draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		    draw.SimpleTextOutlined("Википедия", "marske6", 10, h/2 - 10, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0 + HoverOffset, 0, w, h, Color(25, 25, 25, 125), false, true, false, false)
		end
    end
    fr.btn_wiki.DoClick = function()
        gui.OpenURL( "https://wiki.risedproject.com" )
    end

    fr.btn_vk = vgui.Create('DButton', fr.list)
    fr.btn_vk:Dock(TOP)
    fr.btn_vk:DockMargin(0, 10, 0, 0)
    fr.btn_vk:SetSize(500,25)
    fr.btn_vk:SetText("")
    fr.btn_vk.Paint = function(s,w,h)
		if (s.Hovered) then
            draw.RoundedBoxEx(0, 0 + HoverOffset, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		    -- draw.SimpleTextOutlined(fr.bnt_play.Text, "marske6", 10, h/2 - 10, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
            draw.SimpleTextOutlined("Группа ВК", "marske6", 5 + HoverOffset, h/2 - 10, Color(0,0,0,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, math.random(0,1), Color(215,225,100, math.random(15,20)))
        else
            draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		    draw.SimpleTextOutlined("Группа ВК", "marske6", 10, h/2 - 10, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0 + HoverOffset, 0, w, h, Color(25, 25, 25, 125), false, true, false, false)
		end
    end
    fr.btn_vk.DoClick = function()
        gui.OpenURL( "https://vk.com/risedproject_beta" )
    end

    fr.btn_contacts = vgui.Create('DButton', fr.list)
    fr.btn_contacts:Dock(TOP)
    fr.btn_contacts:DockMargin(0, 10, 0, 0)
    fr.btn_contacts:SetSize(500,25)
    fr.btn_contacts:SetText("")
    fr.btn_contacts.Paint = function(s,w,h)
		if (s.Hovered) then
            draw.RoundedBoxEx(0, 0 + HoverOffset, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		    -- draw.SimpleTextOutlined(fr.bnt_play.Text, "marske6", 10, h/2 - 10, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
            draw.SimpleTextOutlined("Дискорд сообщество", "marske6", 5 + HoverOffset, h/2 - 10, Color(0,0,0,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, math.random(0,1), Color(215,225,100, math.random(15,20)))
        else
            draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		    draw.SimpleTextOutlined("Дискорд сообщество", "marske6", 10, h/2 - 10, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0 + HoverOffset, 0, w, h, Color(25, 25, 25, 125), false, true, false, false)
		end
    end
    fr.btn_contacts.DoClick = function()
        gui.OpenURL( "https://discord.gg/PwcexFJzHP" )
    end

    fr.bnt_exit = vgui.Create('DButton', fr.list)
    fr.bnt_exit:Dock(TOP)
    fr.bnt_exit:DockMargin(0, 100, 0, 0)
    fr.bnt_exit:SetSize(500,25)
    fr.bnt_exit:SetText("")
    fr.bnt_exit.Paint = function(s,w,h)
		if (s.Hovered) then
            draw.RoundedBoxEx(0, 0 + HoverOffset, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		    -- draw.SimpleTextOutlined(fr.bnt_play.Text, "marske6", 10, h/2 - 10, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
            draw.SimpleTextOutlined("Покинуть сервер", "marske6", 5 + HoverOffset, h/2 - 10, Color(0,0,0,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, math.random(0,1), Color(215,225,100, math.random(15,20)))
        else
            draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		    draw.SimpleTextOutlined("Покинуть сервер", "marske6", 10, h/2 - 10, Color(215,225,100), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 0.5, Color(215,225,100, 1))
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0 + HoverOffset, 0, w, h, Color(125, 0, 0, 125), false, true, false, false)
		end
    end
    fr.bnt_exit.DoClick = function()
        fr:SetVisible(false)
        RunConsoleCommand('disconnect')
    end
end

hook.Add("PreRender", "Rised_MainMenu", function()
    if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() and LocalPlayer():GetNWBool("Player_MainMenu_Spawned") then
        gui.HideGameUI()
        OpenEscape()
        gui.HideGameUI()
        return true
    end
end)

hook.Add("PostGamemodeLoaded", "Rised_MainMenu_PostGamemodeLoaded", function()
    OpenEscape()
end)