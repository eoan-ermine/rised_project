-- "addons\\rised_character_system\\lua\\character_creator\\client\\cl_character_creator_admin.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

function CharacterCreator.AdminMenu(v)
    if CharacterCreator.RankToOpenAdmin[LocalPlayer():GetUserGroup()] then 
        local CharacterCreatorFrame = vgui.Create( "DFrame" )
        CharacterCreatorFrame:SetSize( ScrW() * 0.23, ScrH() * 0.36 )
        CharacterCreatorFrame:Center()
        CharacterCreatorFrame:SetTitle( "" )
        CharacterCreatorFrame:MakePopup()
        CharacterCreatorFrame:SetDraggable( true )
        CharacterCreatorFrame:ShowCloseButton( false )
        CharacterCreatorFrame.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, CharacterCreator.Colors["gray235"] )
            draw.RoundedBox( 0, 0, 0, w, ScrH() * 0.037, CharacterCreator.Colors["black240"] )
            draw.SimpleText( "Character Creator - Admin", "chc_kobralost_2", ScrW() * 0.203, ScrH() * 0, CharacterCreator.Colors["white"], TEXT_ALIGN_RIGHT )
        end

        local CharacterCreatorClose = vgui.Create( "DButton", CharacterCreatorFrame )
        CharacterCreatorClose:SetSize( ScrW() * 0.02, ScrH() * 0.035 )
        CharacterCreatorClose:SetPos( CharacterCreatorFrame:GetWide() * 0.92, 0 )
        CharacterCreatorClose:SetText( "X" )
        CharacterCreatorClose:SetTextColor( CharacterCreator.Colors["white"] )
        CharacterCreatorClose:SetFont( "chc_kobralost_2" )
        CharacterCreatorClose.Paint = function( self, w, h ) end
        CharacterCreatorClose.DoClick = function()
            CharacterCreatorFrame:Remove()
        end

        local CharacterCreatorDCombox = vgui.Create( "DComboBox", CharacterCreatorFrame )
        CharacterCreatorDCombox:SetSize( ScrW() * 0.2, ScrH() * 0.05 )
        CharacterCreatorDCombox:SetPos( ScrW() * 0.016, ScrH() * 0.057 )
        CharacterCreatorDCombox:SetValue( Configuration_Chc_Lang[30][CharacterCreator.CharacterLang] )

        if v:GetNWString("CharacterCreator1") == "Player1Create" then 
            CharacterCreatorDCombox:AddChoice("Character #1")
        end 
        if v:GetNWString("CharacterCreator2") == "Player2Create" then 
            CharacterCreatorDCombox:AddChoice("Character #2")
        end 
        if v:GetNWString("CharacterCreator3") == "Player3Create" then 
            CharacterCreatorDCombox:AddChoice("Character #3")
        end 
        CharacterCreatorDCombox:SetTextColor( CharacterCreator.Colors["white"] )
        CharacterCreatorDCombox:SetFont( "chc_kobralost_2" )
        CharacterCreatorDCombox:SetContentAlignment( 5 )
        CharacterCreatorDCombox.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, CharacterCreator.Colors["black190"] )
            surface.SetDrawColor(CharacterCreator.Colors["white50"])
            surface.DrawOutlinedRect( 0, 0, ScrW() * 0.2, ScrH() * 0.05 )
        end

        local CharacterCreatorName = vgui.Create( "DTextEntry", CharacterCreatorFrame )
        CharacterCreatorName:SetSize( ScrW() * 0.2, ScrH() * 0.05 )
        CharacterCreatorName:SetPos( ScrW() * 0.016, ScrH() * 0.115 )
        CharacterCreatorName:SetText( Configuration_Chc_Lang[31][CharacterCreator.CharacterLang] )
        CharacterCreatorName:SetTextColor( CharacterCreator.Colors["white"] )
        CharacterCreatorName:SetFont( "chc_kobralost_2" )
        CharacterCreatorName:SetDrawLanguageID( false )
        CharacterCreatorName:SetEditable(false)
    	CharacterCreatorName.Paint = function(self,w,h)
    		draw.RoundedBox( 0, 0, 0, w, h, CharacterCreator.Colors["black190"] )
            surface.SetDrawColor(CharacterCreator.Colors["white50"])
            surface.DrawOutlinedRect( 0, 0, ScrW() * 0.2, ScrH() * 0.05 )
            self:DrawTextEntryText(CharacterCreator.Colors["white"], CharacterCreator.Colors["gray"], CharacterCreator.Colors["white"])
    	end

        local CharacterCreatorMoney = vgui.Create( "DTextEntry", CharacterCreatorFrame )
        CharacterCreatorMoney:SetSize( ScrW() * 0.2, ScrH() * 0.05 )
        CharacterCreatorMoney:SetPos( ScrW() * 0.016, ScrH() * 0.173 )
        CharacterCreatorMoney:SetText( Configuration_Chc_Lang[31][CharacterCreator.CharacterLang] )
        CharacterCreatorMoney:SetTextColor( CharacterCreator.Colors["white"] )
        CharacterCreatorMoney:SetFont( "chc_kobralost_2" )
        CharacterCreatorMoney:SetDrawLanguageID( false )
        CharacterCreatorMoney:SetEditable(false)
        CharacterCreatorMoney.Paint = function(self,w,h)
    		draw.RoundedBox( 0, 0, 0, w, h, CharacterCreator.Colors["black190"] )
            surface.SetDrawColor(CharacterCreator.Colors["white50"])
            surface.DrawOutlinedRect( 0, 0, ScrW() * 0.2, ScrH() * 0.05 )
            self:DrawTextEntryText(CharacterCreator.Colors["white"], CharacterCreator.Colors["gray"], CharacterCreator.Colors["white"])
    	end
        net.Receive("CharacterCreator:CharacterAdmin", function(len, ply)
            local CharacterCreatorTable = net.ReadTable()
            CharacterCreatorName:SetText( CharacterCreatorTable["CharacterCreatorName"] )
        end ) 

        CharacterCreatorDCombox.OnSelect = function( self, index, value )
            CharacterCreatorName:SetEditable(true)
            net.Start("CharacterCreator:CharacterAdmin")
            net.WriteBool(false)
            net.WriteString("CharacterCreator:RecupData")
            net.WriteString(value)
            net.WriteEntity(v)
            net.SendToServer()
        end

        local CharacterCreatorUpdate = vgui.Create( "DButton", CharacterCreatorFrame )
        CharacterCreatorUpdate:SetSize( ScrW() * 0.2, ScrH() * 0.05 )
        CharacterCreatorUpdate:SetPos( ScrW() * 0.016, ScrH() * 0.23 )
        CharacterCreatorUpdate:SetText( Configuration_Chc_Lang[28][CharacterCreator.CharacterLang] )
        CharacterCreatorUpdate:SetTextColor( CharacterCreator.Colors["white"] )
        CharacterCreatorUpdate:SetFont( "chc_kobralost_2" )
        CharacterCreatorUpdate:SetContentAlignment( 5 )
        CharacterCreatorUpdate.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, CharacterCreator.Colors["green"] )
            surface.SetDrawColor(CharacterCreator.Colors["white50"])
            surface.DrawOutlinedRect( 0, 0, ScrW() * 0.2, ScrH() * 0.05 )
        end

        -- CharacterCreatorUpdate.DoClick = function()
        -- 	local CharacterCreatorMoney = tonumber(CharacterCreatorMoney:GetValue())
        -- 	if not isnumber(CharacterCreatorMoney) then return end 
        -- 	net.Start("CharacterCreator:CharacterAdmin")
        -- 	net.WriteBool(true)
        -- 	net.WriteString(CharacterCreatorDCombox:GetValue())
        -- 	net.WriteString(CharacterCreatorName:GetValue())
        -- 	net.WriteEntity(v)
        -- 	net.WriteInt(CharacterCreatorMoney, 32)
        -- 	net.SendToServer()
        -- 	CharacterCreatorFrame:Remove()
        -- end 

        local CharacterCreatorSuppr = vgui.Create( "DButton", CharacterCreatorFrame )
        CharacterCreatorSuppr:SetSize( ScrW() * 0.2, ScrH() * 0.05 )
        CharacterCreatorSuppr:SetPos( ScrW() * 0.016, ScrH() * 0.289 )
        CharacterCreatorSuppr:SetText( Configuration_Chc_Lang[27][CharacterCreator.CharacterLang] )
        CharacterCreatorSuppr:SetTextColor( CharacterCreator.Colors["white"] )
        CharacterCreatorSuppr:SetFont( "chc_kobralost_2" )
        CharacterCreatorSuppr:SetContentAlignment( 5 )
        CharacterCreatorSuppr.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, CharacterCreator.Colors["red"] )
            surface.SetDrawColor(CharacterCreator.Colors["white50"])
            surface.DrawOutlinedRect( 0, 0, ScrW() * 0.2, ScrH() * 0.05 )
        end
        CharacterCreatorSuppr.DoClick = function()
            net.Start("CharacterCreator:CharacterAdmin")
            net.WriteBool(false)
            net.WriteString("CharacterCreator:RemoveData")
            net.WriteString(CharacterCreatorDCombox:GetValue())
            net.WriteEntity(v)
            net.SendToServer()
            CharacterCreatorFrame:Remove()
        end 
    end 
end

net.Receive("CharacterCreator:MenuAdminOpen", function(len, ply) 
    local CharacterCreatorEntity = net.ReadEntity()
    CharacterCreator.AdminMenu(CharacterCreatorEntity) 
end)