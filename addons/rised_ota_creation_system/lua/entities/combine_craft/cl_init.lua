-- "addons\\rised_ota_creation_system\\lua\\entities\\combine_craft\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

local tt = 0

local to_draw = 255

local to_text_ = 0

local ttt = 0

local ui = vgui.Create

combine_craft = {}

combine_craft.description = {}

combine_craft.Text_Color = ColorAlpha(col_combine, 255)

combine_craft.description = {
    [TEAM_OTA_Grunt] = [[OW-ECHO]],
    [TEAM_OTA_Hammer] = [[OW-WALLHAMMER]],
    [TEAM_OTA_Ordinal] = [[OW-ORDINAL]],
    [TEAM_OTA_Soldier] = [[OW-I17.Soldier]],
    [TEAM_OTA_Striker] = [[OW-I17.Striker]],
    [TEAM_OTA_Razor] = [[OW-I17.Razor]],
    [TEAM_OTA_Suppressor] = [[OW-I17.Suppressor]],
    [TEAM_OTA_Assassin] = [[OW-I17.Assassin]],
    [TEAM_OTA_Tech] = [[OW-I17.Tech]],
    [TEAM_OTA_Commander] = [[OW-I17.Commander]],
    [TEAM_OTA_Elite] = [[OW-I17.Elite]],
    [TEAM_OTA_Crypt] = [[OW-I17.Crypt]],
    [TEAM_SYNTH_CREMATOR] = [[SYNTH.CREMATOR]],
    [TEAM_SYNTH_GUARD] = [[SYNTH.GUARD]],
}

combine_craft.microschemes = {
    [TEAM_OTA_Grunt] = 5,
    [TEAM_OTA_Hammer] = 25,
    [TEAM_OTA_Ordinal] = 15,
	[TEAM_OTA_Soldier] = 15,
	[TEAM_OTA_Striker] = 15,
	[TEAM_OTA_Razor] = 15,
	[TEAM_OTA_Suppressor] = 15,
	[TEAM_OTA_Assassin] = 15,
	[TEAM_OTA_Tech] = 15,
	[TEAM_OTA_Commander] = 15,
	[TEAM_OTA_Elite] = 15,
	[TEAM_OTA_Crypt] = 15,
	[TEAM_SYNTH_CREMATOR] = 15,
	[TEAM_SYNTH_GUARD] = 15,
}

combine_craft.energy = {
    [TEAM_OTA_Grunt] = 250,
    [TEAM_OTA_Hammer] = 2500,
    [TEAM_OTA_Ordinal] = 500,
	[TEAM_OTA_Soldier] = 1500,
	[TEAM_OTA_Striker] = 1500,
	[TEAM_OTA_Razor] = 1500,
	[TEAM_OTA_Suppressor] = 1500,
	[TEAM_OTA_Assassin] = 1500,
	[TEAM_OTA_Tech] = 1500,
	[TEAM_OTA_Commander] = 1500,
	[TEAM_OTA_Elite] = 1500,
	[TEAM_OTA_Crypt] = 1500,
	[TEAM_SYNTH_CREMATOR] = 1500,
	[TEAM_SYNTH_GUARD] = 1500,
}


surface.CreateFont('Combine.ThisIsPanel', {font = "Marske", extended = true, size = 20, weight = 500})

surface.CreateFont('Combine.Button', {font = "Marske", extended = true, size = 20, weight = 500})

surface.CreateFont('Combine.Text', {font = "Marske", extended = true, size = 15, weight = 500})

surface.CreateFont('Combine.BigBoiName', {font = "Marske", extended = true, size = 19, weight = 500})

function ENT:Draw()

    self:DrawModel()

    local Pos = self:GetPos()
    local Ang = self:GetAngles()


    surface.SetFont("Combine.ThisIsPanel")
    local text = "Панель создания ОТА"

    if LocalPlayer():GetPos():Distance(self:GetPos()) > 150 then to_draw = 0 else to_draw = 255 end 

    local TextWidth = surface.GetTextSize(text)

    tt = math.Round(math.Approach(tt, to_draw, 3))

    Ang:RotateAroundAxis(Ang:Up(), 90)

    Ang:RotateAroundAxis(Ang:Forward(), 90)

    cam.Start3D2D(Pos + Ang:Up() * 1, Ang, 0.11)

        draw.WordBox(2, -TextWidth * 0.58, -400, text, "Combine.ThisIsPanel", Color(25, 25, 25, tt / 2), ColorAlpha(col_combine, tt))

    cam.End3D2D()

end

local to_show = false

function combine_craft.UI_Panel()

    local ply = LocalPlayer()

    if (!ply:isCP()) then return end

    local console_frame = ui "DFrame"

    console_frame:SetSize(ScrW(), ScrH())

    console_frame:Center()

    console_frame:SetTitle( ' ' )

    console_frame:AlphaTo(0, 0, 0)

    console_frame:AlphaTo(255, 1, 0.1)

    console_frame:MakePopup()

    console_frame:ShowCloseButton(false)

    timer.Simple(1, function() gui.EnableScreenClicker(true) end)

    local total_microschemes = GetGlobalInt('CombineResource_Micro')

    local total_energy = GetGlobalInt('CombineResource_Energy')

    console_frame.Paint = function(self, w, h)

        local ota_count = 0

        for _, z in ipairs(player.GetAll()) do

            if z:isCP() then

                ota_count = ota_count + 1

            end

        end

        if to_show then 

            ttt = math.Round(math.Approach(ttt, to_text_, 0.6))

        end

        Derma_DrawBackgroundBlur(self, 0)

        draw.SimpleText("Микросхем: " .. total_microschemes, "Combine.Text", 42, 20, Color(combine_craft.Text_Color.r, combine_craft.Text_Color.g, combine_craft.Text_Color.b, ttt))

        draw.SimpleText("Электросхем: " .. total_energy, "Combine.Text", 42, 45, Color(combine_craft.Text_Color.r, combine_craft.Text_Color.g, combine_craft.Text_Color.b, ttt))

        draw.SimpleText("Количество ОТА: " .. ota_count, "Combine.Text", 42, 70, Color(combine_craft.Text_Color.r, combine_craft.Text_Color.g, combine_craft.Text_Color.b, ttt))

    end

    console_frame.OnClose = function(self)

        gui.EnableScreenClicker(false)

    end

    local panel = ui("DScrollPanel", console_frame)
    
    panel:SetPos(40, 100)

    panel:SetSize(ScrW() / 4, ScrH() / 1.3)

    panel.Paint = function(self, w, h)

        surface.SetDrawColor(0, 0, 0, 100)

        surface.DrawRect(0, 0, w, h)

    end

    local you_have_chosen = ui("DPanel", console_frame)

    you_have_chosen:SetPos(ScrW() / 3, 100)

    you_have_chosen:SetSize(ScrW() / 3, ScrH() / 1.3)

    you_have_chosen.Paint = function(self, w, h)

        surface.SetDrawColor(0, 0, 0, 100)

        surface.DrawRect(0, 0, w, h)


    end

    local panel_description = ui("DPanel", you_have_chosen)

    panel_description:SetPos(0, ScrH() / 2.6)
 
    panel_description:SetSize(ScrW() / 3, ScrH() / 2.6)

    panel_description.Paint = function(self, w, h)

        surface.SetDrawColor(45, 45, 45, 0)

        surface.DrawRect(0, 0, w, h)

    end

    local ready_to_create = ui("DButton", you_have_chosen)

    ready_to_create.OnCursorMoved = function(self) self.Hovered = true end
        
    ready_to_create.OnCursorExited = function(self) self.Hovered = false end

    ready_to_create:SetText(' ')
    
    ready_to_create:Dock(BOTTOM)

    ready_to_create:DockMargin(5, 5, 5, 5)

    ready_to_create.microschemes = 0

    ready_to_create.energy = 0

    ready_to_create.divorce = nil

    ready_to_create.ota = nil
    
    ready_to_create.Paint = function(self, w, h)

        draw.RoundedBox(0, 0, 0, w, h, self.divorce ~= nil and (self.divorce and Color(50, 0, 0) or (!self.divorce) and Color(0, 50, 0)) or ((!self.Hovered) and Color(25, 25, 25) or Color(60, 60, 60)))

        draw.SimpleText('Создать', "Combine.BigBoiName", w / 2, h / 2, self.divorce ~= nil and (self.divorce and Color(255, 0, 0, 255) or (!self.divorce) and Color(0, 255, 0, 255)) or ((!self.Hovered) and combine_craft.Text_Color or Color(255, 255, 255, 200)), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end

    ready_to_create.DoClick = function(self)

        if total_microschemes - self.microschemes >= 0 then
            
            if total_energy - self.energy >= 0 then

                ready_to_create.divorce = false

                net.Start("combine_craft push_button")

                net.WriteUInt(ready_to_create.ota.team, 9)

                net.SendToServer()

                LocalPlayer():EmitSound('buttons/combine_button1.wav', 100)
                
                timer.Simple(0.8, function()
                
                    console_frame:Close()

                    to_text_ = 0

                    to_show = false

                    ttt = 0
                    
                end)
                
            else

                ready_to_create.divorce = true

                LocalPlayer():EmitSound('buttons/combine_button_locked.wav', 100)

            end

        else

            ready_to_create.divorce = true

            LocalPlayer():EmitSound('buttons/combine_button_locked.wav', 100)

        end

        timer.Simple(0.4, function() ready_to_create.divorce = nil end)

    end

    local lbl = ui("DLabel", panel_description)

    lbl:SetText(' ')

    lbl:SetPos( 10, 10 )

    lbl:SetWide(panel_description:GetWide() - 20)
    lbl:SetFont("Trebuchet18")
    lbl:SetAutoStretchVertical(true)

    local dmodel_panel = ui("DModelPanel", you_have_chosen)

    dmodel_panel:SetPos(you_have_chosen:GetWide() / 2 - 200, -40)

    dmodel_panel:SetSize(400, 400)

    dmodel_panel:SetModel(' ')

    function dmodel_panel:LayoutEntity( Entity ) return end

    for z, x in pairs(RPExtraTeams) do

        if GAMEMODE.OTANN[z] then

            local microschemes = combine_craft.microschemes[z]

            local energy = combine_craft.energy[z]

            local ota_list = ui("DButton", panel)

            ota_list.OnCursorMoved = function(self) self.Hovered = true end
        
            ota_list.OnCursorExited = function(self) self.Hovered = false end

            ota_list:Dock(TOP)

            ota_list:DockMargin(5, 5, 5, 40)

            ota_list:SetSize(0, 75)

            ota_list:SetText(' ')

            ota_list.Paint = function(self, w, h)

                draw.RoundedBox(0, 0, 0, w, h, (!self.Hovered) and Color(25, 25, 25, 50) or Color(60, 60, 60, 50))

                draw.SimpleText(x.name, "Combine.BigBoiName", w / 2 + 15, h / 2, (!self.Hovered) and combine_craft.Text_Color or Color(255, 255, 255, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

            end

            local choose_model

            if istable(x.model) then choose_model = table.Random(x.model) else choose_model = x.model end
    
            ota_list.DoClick = function(self)

                you_have_chosen:Show()

                ready_to_create.microschemes = microschemes

                ready_to_create.energy = energy

                ready_to_create.ota = x

                dmodel_panel:SetModel(choose_model)

                local text = DarkRP.textWrap(DarkRP.deLocalise(combine_craft.description[z] .. ' \nНужно микросхем: ' .. microschemes .. '\nНужно энергии: ' .. energy or ""):gsub('\t', ''), "Trebuchet18", panel_description:GetWide() - 43)

                local _, h = surface.GetTextSize(text)

                surface.SetFont("Trebuchet18")

                lbl:SetText(text)
                lbl:SetTall(h)

                dmodel_panel.Angles = Angle(0,0,0)

                function dmodel_panel:DragMousePress()
                    
                    self.PressX, self.PressY = gui.MousePos()
                    
                    self.Pressed = true
                    
                end
                
                function dmodel_panel:DragMouseRelease()
                    
                    self.Pressed = false
                    
                end
                
                function dmodel_panel:LayoutEntity( ent )
                    
                    if not IsValid(ent) then return end
                    
                    if ( self.bAnimated ) then
                        
                        self:RunAnimation()
                        
                    end
                
                    if ( self.Pressed ) then
                        
                        local mx, my = gui.MousePos()
                        
                        self.Angles = self.Angles - Angle( 0, ( self.PressX or mx ) - mx, 0 )
                
                        self.PressX, self.PressY = gui.MousePos()
                        
                    end
                
                    ent:SetAngles( self.Angles )
                    
                end

            end

            local Dmodel = ui("SpawnIcon", ota_list)

            Dmodel:SetPos( 0, 0 )

            Dmodel:SetSize(70, 75)

            Dmodel:SetModel(choose_model)

        end

    end

    local button_leave = ui("DButton", console_frame)

    button_leave:SetText(" ")

    button_leave:SetPos(ScrW() - 100, 40)

    button_leave.OnCursorMoved = function(self)

        self.Hovered = true

    end

    button_leave.OnCursorExited = function(self)

        self.Hovered = false

    end

    button_leave.Paint = function(self, w, h)

        draw.SimpleText("Выйти", "Combine.Text", w / 2, h / 2, (!self.Hovered) and combine_craft.Text_Color or Color(255, 255, 255, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    end

    button_leave.DoClick = function(self)

        console_frame:Close()

        to_text_ = 0

        to_show = false

        ttt = 0

    end

    if (!to_Show) then

        button_leave:Hide()

        panel:Hide()

        you_have_chosen:Hide()

        local btn2 = ui('DButton', console_frame)

        btn2:SetText(' ')

        btn2:SetPos(ScrW() / 2 - 62.5, ScrH() / 2 + 2)

        btn2:SetSize(125, 50)

        btn2.OnCursorMoved = function(self)

            self.Hovered = true
    
        end
    
        btn2.OnCursorExited = function(self)
    
            self.Hovered = false
    
        end
    
        btn2.Paint = function(self, w, h)

            draw.SimpleText("Выйти", "Combine.Button", w / 2, h / 2, (!self.Hovered) and combine_craft.Text_Color or Color(255, 255, 255, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        end

        btn2.DoClick = function(self)

            console_frame:Close()
    
            ttt = 0

            to_show = false

            to_text_ = 0

        end

        local to_text = ''

        local ttext = ui("DLabel", console_frame)

        ttext:SetPos(ScrW() / 2 - 250, ScrH() / 2 - 250)

        ttext:SetSize(500, 500)

        ttext:SetText('')

        ttext.Paint = function(self, w, h)

            draw.SimpleText(to_text, "Combine.Text", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        end
        
        local btn = ui('DButton', console_frame)

        btn:SetText(' ')

        btn:SetPos(ScrW() / 2 - 62.5, ScrH() / 2 - 50)

        btn:SetSize(125, 50)

        btn.OnCursorMoved = function(self)

            self.Hovered = true
    
        end
    
        btn.OnCursorExited = function(self)
    
            self.Hovered = false
    
        end
    
        btn.Paint = function(self, w, h)

            --draw.RoundedBox(0, 10, 10, w - 20, h - 20, (!self.Hovered) and Color(25, 25, 25) or Color(60, 60, 60))

            draw.SimpleText("Войти", "Combine.Button", w / 2, h / 2, (!self.Hovered) and combine_craft.Text_Color or Color(255, 255, 255, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            
        end
    
        btn.DoClick = function(self, w, h)
 
            btn2:Hide()

            self:Hide()

            panel:AlphaTo(0, 0, 0)

            button_leave:AlphaTo(0, 0, 0)

            timer.Simple(0.2, function()
            
                to_text = 'Входим.'

                timer.Simple(0.2, function()
            
                    to_text = 'Входим..'

                    timer.Simple(0.2, function()
                
                        to_text = 'Входим...'

                        timer.Simple(0.2, function()
                
                            to_text = 'Входим.'

                            timer.Simple(0.2, function()
                
                                to_text = 'Входим..'

                                timer.Simple(0.2, function()
                
                                    to_text = 'Входим...'

                                    timer.Simple(0.2, function()
                
                                        to_text = 'Входим.'
                                        
                                        timer.Simple(0.2, function()
                
                                            to_text = 'Входим..'

                                            timer.Simple(0.2, function()
                
                                                to_text = 'Входим...'

                                                timer.Simple(0.2, function()
                
                                                    to_text = ''
                                    
                                                end)
                                
                                            end)
                            
                                        end)
                        
                                    end)
                    
                                end)
                
                            end)
            
                        end)
        
                    end)
    
                end)
    
            end)

            timer.Simple(2, function() to_show = true to_text_ = 255 end)
            
            timer.Simple(2, function()

                panel:Show()

                panel:AlphaTo(255, 1, 0.1)

                button_leave:Show()

                button_leave:AlphaTo(255, 1, 0.1)

            end)

        end

    end

end