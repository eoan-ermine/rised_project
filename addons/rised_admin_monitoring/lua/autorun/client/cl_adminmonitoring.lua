-- "addons\\rised_admin_monitoring\\lua\\autorun\\client\\cl_adminmonitoring.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal



net.Receive("Analyze.OpenMenu", function()

	local netlenth = net.ReadInt(32)
	local BinaryDates = net.ReadData(netlenth)
	local deBinaryDates = util.Decompress(BinaryDates)
	
	local netlenth2 = net.ReadInt(32)
	local BinaryToday = net.ReadData(netlenth2)
	local deBinaryToday = util.Decompress(BinaryToday)
	
	local dates = util.JSONToTable(deBinaryDates) or {}
	local binary = util.JSONToTable(deBinaryToday) or {}
	
	local frame = vgui.Create("DFrame") 
	frame:SetPos(50,50)
	frame:SetSize(650,350)
	frame:SetTitle("Анализ онлайна состава Rised Project")
	frame:Center()
	frame:SetDraggable(true)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame.Paint = function(s,w,h)
		draw.RoundedBox(20,0,0,w,h,Color(0, 0, 0, 200))
		draw.RoundedBox(0,0,0,w,25,Color(255, 165, 0, 255))
		draw.RoundedBoxEx(20,0,25,135,h-25,Color(0, 0, 0, 150), false, false, true, false)
	end	
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("X")
	buttonClose:SetSize(75,25)
	buttonClose:SetPos(625,0)
	buttonClose.Paint = function(me, w, h)
		draw.DrawText("X", "TargetID", 10, 5, Color(255,255,255,255), TEXT_ALIGN_CENTER)
		if (me.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 195, 87, 200), false, true, false, false)
		end

		if (me:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 195, 87, 200), false, true, false, false)
		end
	end
	buttonClose.DoClick = function()
		frame:Close()
	end
	
	---=== Кнопки по датам ===---
	local DateScroll = vgui.Create( "DScrollPanel", frame )
	DateScroll:SetSize( 150, 150 )
	DateScroll:Dock( LEFT )
	
	local AName = vgui.Create("DLabel", frame)
	AName:SetPos( 275, 30 )
	AName:SetText( "Имя" )
	AName:SetColor( Color( 255, 255, 255 ) )
	AName:SizeToContents()
	AName:SetDark( 1 )
	
	local ARank = vgui.Create("DLabel", frame)
	ARank:SetPos( 385, 30 )
	ARank:SetText( "Должность" )
	ARank:SetColor( Color( 255, 255, 255 ) )
	ARank:SizeToContents()
	ARank:SetDark( 1 )
	
	local ATime = vgui.Create("DLabel", frame)
	ATime:SetPos( 525, 30 )
	ATime:SetText( "Время" )
	ATime:SetColor( Color( 255, 255, 255 ) )
	ATime:SizeToContents()
	ATime:SetDark( 1 )
	
	local sbar = DateScroll:GetVBar()
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 50, 100))
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 50, 100))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(50, 50, 50, 100))
	end
		
	local buttonOverall = DateScroll:Add("DButton")
	buttonOverall:SetText( "За все время" )
	buttonOverall:SetPos( 0, 15 )
	buttonOverall:SetSize( 120, 30 )
	buttonOverall.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 15, 15, 200 ) )
	end
	buttonOverall.DoClick = function()
		net.Start("Analyze.Server")
		net.WriteString("Overall")
		net.SendToServer()
		
		frame:Close()
	end
	
	local offset = 46
	for k,v in pairs(dates) do
		
		local buttonAdd = DateScroll:Add("DButton")
		buttonAdd:SetText( v )
		buttonAdd:SetPos( 0, offset + 16 )
		buttonAdd:SetSize( 120, 30 )
		buttonAdd.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 15, 15, 200 ) )
		end
		buttonAdd.DoClick = function()
			net.Start("Analyze.Server")
			net.WriteString(v)
			net.SendToServer()
			
			frame:Close()
		end
		
		offset = offset + 48
	end
	
	
	
	---=== Информация по выбранной дате ===---
	local DScrollPanel = vgui.Create( "DScrollPanel", frame )
	DScrollPanel:Dock( FILL )
	
	local sbar = DScrollPanel:GetVBar()
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	
	local offset = 15
	for k,v in pairs(binary) do
	
		local playTime = v.TimePlayed
		local playHours = math.floor(playTime/60/60)
		local playMins = math.Round((playTime/60/60 - playHours) * 60)
		if playMins < 10 then
			playMins = "0" .. playMins
		end
		
		local bg = DScrollPanel:Add("DPanel")
		bg:SetPos(25, offset + 8)
		bg:SetSize(frame:GetWide(), 48)
		bg.Paint = function(s,w,h)
			draw.RoundedBox(5,0,0,w,h,Color(0, 0, 0, 100))
		end	
		
		-- local Avatar = DScrollPanel:Add( "AvatarImage" )
		-- Avatar:SetSize( 48, 48 )
		-- Avatar:SetPos( 0, offset + 8 );
		-- Avatar:SetPlayer( LocalPlayer(), 64 )
		
		local textLine = DScrollPanel:Add("DLabel")
		textLine:SetPos( 105, offset + 24 )
		textLine:SetText( v.SteamName )
		textLine:SetColor( Color( 255, 255, 255 ) )
		textLine:SizeToContents()
		textLine:SetDark( 1 )
		
		local textLine2 = DScrollPanel:Add("DLabel")
		textLine2:SetPos( 190, offset + 24 )
		textLine2:SetText( "-" )
		textLine2:SetColor( Color( 255, 255, 255 ) )
		textLine2:SizeToContents()
		textLine2:SetDark( 1 )
		
		local textDisc = DScrollPanel:Add("DLabel")
		textDisc:SetPos( 225, offset + 24 )
		textDisc:SetText( v.Rank )
		textDisc:SetColor( Color( 255, 255, 255 ) )
		textDisc:SizeToContents()
		textDisc:SetDark( 1 )
		
		local textLine2 = DScrollPanel:Add("DLabel")
		textLine2:SetPos( 320, offset + 24 )
		textLine2:SetText( "-" )
		textLine2:SetColor( Color( 255, 255, 255 ) )
		textLine2:SizeToContents()
		textLine2:SetDark( 1 )
		
		local textDisc = DScrollPanel:Add("DLabel")
		textDisc:SetPos( 373, offset + 24 )
		textDisc:SetText( playHours .. ":" .. playMins )
		textDisc:SetColor( Color( 255, 255, 255 ) )
		textDisc:SizeToContents()
		textDisc:SetDark( 1 )
		
		offset = offset + 92
	end
end)