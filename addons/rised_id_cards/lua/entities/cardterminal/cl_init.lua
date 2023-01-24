-- "addons\\rised_id_cards\\lua\\entities\\cardterminal\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua");

surface.CreateFont("methFont", {
	font = "Arial",
	size = 30,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false, 
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
});

local name
local surname

	
local function Derma()

    local frame = vgui.Create("DFrame")
	frame:SetSize(250,250)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "" )
	frame.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
		draw.DrawText( "Регистрация", "marske4", w/4, 7, Color( 255, 255, 255, 255 ), 1 )
	end
	
	local label = vgui.Create("DLabel", frame)
	label:SetSize(500, 100)
	label:SetPos(25,15)
	label:SetFont("marske4")
	label:SetText("Введите имя:")
	
	local inputName = vgui.Create("DTextEntry", frame)
	inputName:SetPos( 25, 75 )
	inputName:SetSize( 200, 25 )
	inputName:SetText( "" )
	inputName.OnChange = function( self )
		name = self:GetValue()
		net.Start("CardTerminalWriting")
		net.SendToServer()
	end
	
	local label2 = vgui.Create("DLabel", frame)
	label2:SetSize(500, 100)
	label2:SetPos(25,75)
	label2:SetFont("marske4")
	label2:SetText("Введите фамилию:")
	
	local inputSurame = vgui.Create("DTextEntry", frame)
	inputSurame:SetPos( 25, 135 )
	inputSurame:SetSize( 200, 25 )
	inputSurame:SetText( "" )
	inputSurame.OnChange = function( self )
		surname = self:GetValue()
		net.Start("CardTerminalWriting")
		net.SendToServer()
	end

	local button = vgui.Create("DButton", frame)
	button:SetPos(25,210)
	button:SetSize(200,25)
	button:SetText("")
	button:SetTextStyleColor( Color( 0, 0, 0 ) )
	button.Hover 	= false
	button.OnCursorEntered	= function() button.Hover = true  end
	button.OnCursorExited 	= function() button.Hover = false end
	button.DoClick = function()
			if name != nil && surname != nil then
				net.Start("CardTerminalSpawn")
				net.WriteString(name)
				net.WriteString(surname)
				net.SendToServer()
			else return false end
			
			frame:Close()
		end
	button.Paint = function(s,w,h)
		if button.Hover == true then
			draw.RoundedBox(5,0,0,w,h,Color(255, 165, 0, 255))
			draw.DrawText( "Установить", "marske4", w/2, 7, Color( 255, 255, 255, 255 ), 1 )	
		else
			draw.RoundedBox(5,0,0,w,h,Color(255, 165, 0, 1))
			draw.DrawText( "Установить", "marske4", w/2, 7, Color( 255, 255, 255, 255 ), 1 )
		end
	end
end

net.Receive( "CardTerminalUsed", function()
	Derma() 	
end )

usermessage.Hook("DrawTheMenu", Derma)