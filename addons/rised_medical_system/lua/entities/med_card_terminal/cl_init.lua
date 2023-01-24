-- "addons\\rised_medical_system\\lua\\entities\\med_card_terminal\\cl_init.lua"
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

local function Derma(terminal, h, w, p, m, g, d)
	local height = h
	local weight = w
	local physics = p
	local mental = m
	local bloodGroup = g
	local disease = d

    local frame = vgui.Create("DFrame")
	frame:SetSize(500,500)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "" )
	frame.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
		draw.DrawText( "Медицинский терминал", "marske4", w/2, 7, Color( 255, 255, 255, 255 ), 1 )
	end
	
	local label = vgui.Create("DLabel", frame)
	label:SetSize(500, 100)
	label:SetPos(25,15)
	label:SetFont("marske4")
	label:SetText("Рост:")
	
	local input1 = vgui.Create("DTextEntry", frame)
	input1:SetPos( 25, 75 )
	input1:SetSize( 450, 25 )
	input1:SetText( h )
	input1.OnChange = function( self )
		height = self:GetValue()
		net.Start("MedCardTerminalWriting")
		net.WriteEntity(terminal)
		net.WriteInt(1,10)
		net.WriteString(height)
		net.SendToServer()
	end
	
	local label2 = vgui.Create("DLabel", frame)
	label2:SetSize(500, 100)
	label2:SetPos(25,75)
	label2:SetFont("marske4")
	label2:SetText("Вес:")
	
	local input2 = vgui.Create("DTextEntry", frame)
	input2:SetPos( 25, 135 )
	input2:SetSize( 450, 25 )
	input2:SetText( w )
	label2:SetFont("marske4")
	input2.OnChange = function( self )
		weight = self:GetValue()
		net.Start("MedCardTerminalWriting")
		net.WriteEntity(terminal)
		net.WriteInt(2,10)
		net.WriteString(weight)
		net.SendToServer()
	end
	
	local label3 = vgui.Create("DLabel", frame)
	label3:SetSize(500, 100)
	label3:SetPos(25,135)
	label3:SetFont("marske4")
	label3:SetText("Физическая подготовка:")
	
	local input3 = vgui.Create("DTextEntry", frame)
	input3:SetPos( 25, 195 )
	input3:SetSize( 450, 25 )
	input3:SetText( p )
	input3.OnChange = function( self )
		physics = self:GetValue()
		net.Start("MedCardTerminalWriting")
		net.WriteEntity(terminal)
		net.WriteInt(3,10)
		net.WriteString(physics)
		net.SendToServer()
	end
	
	local label4 = vgui.Create("DLabel", frame)
	label4:SetSize(500, 100)
	label4:SetPos(25,195)
	label4:SetFont("marske4")
	label4:SetText("Психический статус:")
	
	local input4 = vgui.Create("DTextEntry", frame)
	input4:SetPos( 25, 255 )
	input4:SetSize( 450, 25 )
	input4:SetText( m )
	input4.OnChange = function( self )
		mental = self:GetValue()
		net.Start("MedCardTerminalWriting")
		net.WriteEntity(terminal)
		net.WriteInt(4,10)
		net.WriteString(mental)
		net.SendToServer()
	end
	
	local label5 = vgui.Create("DLabel", frame)
	label5:SetSize(500, 100)
	label5:SetPos(25,255)
	label5:SetFont("marske4")
	label5:SetText("Группа крови:")
	
	local input5 = vgui.Create("DTextEntry", frame)
	input5:SetPos( 25, 315 )
	input5:SetSize( 450, 25 )
	input5:SetText( g )
	input5.OnChange = function( self )
		bloodGroup = self:GetValue()
		net.Start("MedCardTerminalWriting")
		net.WriteEntity(terminal)
		net.WriteInt(5,10)
		net.WriteString(bloodGroup)
		net.SendToServer()
	end
	
	local label6 = vgui.Create("DLabel", frame)
	label6:SetSize(500, 100)
	label6:SetPos(25,315)
	label6:SetFont("marske4")
	label6:SetText("Болезни:")
	
	local input6 = vgui.Create("DTextEntry", frame)
	input6:SetPos( 25, 375 )
	input6:SetSize( 450, 25 )
	input6:SetText( d )
	input6.OnChange = function( self )
		disease = self:GetValue()
		net.Start("MedCardTerminalWriting")
		net.WriteEntity(terminal)
		net.WriteInt(6,10)
		net.WriteString(disease)
		net.SendToServer()
	end

	local button = vgui.Create("DButton", frame)
	button:SetPos(150,435)
	button:SetSize(200,25)
	button:SetText("")
	button:SetTextStyleColor( Color( 0, 0, 0 ) )
	button.Hover 	= false
	button.OnCursorEntered	= function() button.Hover = true  end
	button.OnCursorExited 	= function() button.Hover = false end
	button.DoClick = function()
			if height != "" && weight != "" && physics != "" && mental != "" && bloodGroup != "" && disease != "" then
				net.Start("MedCardTerminalSpawn")
				net.WriteEntity(terminal)
				net.WriteString(height)
				net.WriteString(weight)
				net.WriteString(physics)
				net.WriteString(mental)
				net.WriteString(bloodGroup)
				net.WriteString(disease)
				net.SendToServer()
			else return false end
			
			frame:Close()
		end
	button.Paint = function(s,w,h)
		if button.Hover == true then
			draw.RoundedBox(5,0,0,w,h,Color(255, 195, 87, 255))
			draw.DrawText( "Установить | " .. RISED.Config.Economy.MedCardCost .. " T.", "marske4", w/2, 7, Color( 255, 255, 255, 255 ), 1 )	
		else
			draw.RoundedBox(5,0,0,w,h,Color(255, 195, 87, 1))
			draw.DrawText( "Установить | " .. RISED.Config.Economy.MedCardCost .. " T.", "marske4", w/2, 7, Color( 255, 255, 255, 255 ), 1 )
		end
	end
end

net.Receive( "MedCardTerminalUsed", function()
	local terminal = net.ReadEntity()
	local h = net.ReadString()
	local w = net.ReadString()
	local p = net.ReadString()
	local m = net.ReadString()
	local g = net.ReadString()
	local d = net.ReadString()
	Derma(terminal, h, w, p, m, g, d) 	
end )

usermessage.Hook("DrawTheMenu", Derma)