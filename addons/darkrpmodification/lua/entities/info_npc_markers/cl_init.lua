-- "addons\\darkrpmodification\\lua\\entities\\info_npc_markers\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

net.Receive("InfoNPCMarkers.OpenMenu", function()
	InfoMarkers()
end)

function InfoMarkers()
	local frame = vgui.Create("DFrame")
	frame:SetSize(400,450)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "Информация" )
	frame.Paint = function(s,w,h)
		draw.RoundedBox(1,0,0,w,h,Color(15,15,15, 190))
	end	
	
	local text01 = vgui.Create( "DLabel", frame )
	text01:SetSize(1000,20)
	text01:SetPos( 45, 50 )
	text01:SetFont("marske4")
	text01:SetText( "Привет!" )
	
	local text02 = vgui.Create( "DLabel", frame )
	text02:SetSize(1000,20)
	text02:SetPos( 45, 70 )
	text02:SetFont("marske4")
	text02:SetText( "Ты только прибыл?" )
	
	local text03 = vgui.Create( "DLabel", frame )
	text03:SetSize(1000,20)
	text03:SetPos( 45, 90 )
	text03:SetFont("marske4")
	text03:SetText( "Я помогу тебе узнать город получше." )
	
	local text04 = vgui.Create( "DLabel", frame )
	text04:SetSize(1000,20)
	text04:SetPos( 45, 110 )
	text04:SetFont("marske4")
	text04:SetText( "Спрашивай:" )
	
	local button01 = vgui.Create("DButton", frame)
	button01:SetText( "Нексус Надзора" )
	button01:SetFont("marske4")
	button01:SetPos( 20, 150 )
	button01:SetSize( 360, 30 )
	button01.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 15, 15, 125 ) )
	end
	button01.DoClick = function()
		InfoMarker01()
		frame:Close()
	end
	
	local button02 = vgui.Create("DButton", frame)
	button02:SetText( "Гражданский центр" )
	button02:SetFont("marske4")
	button02:SetPos( 20, 200 )
	button02:SetSize( 360, 30 )
	button02.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 15, 15, 125 ) )
	end
	button02.DoClick = function()
		InfoMarker02()
		frame:Close()
	end
	
	local button03 = vgui.Create("DButton", frame)
	button03:SetText( "Раздатчики рационов питания" )
	button03:SetFont("marske4")
	button03:SetPos( 20, 250 )
	button03:SetSize( 360, 30 )
	button03.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 15, 15, 125 ) )
	end
	button03.DoClick = function()
		InfoMarker03()
		frame:Close()
	end
	
	local button04 = vgui.Create("DButton", frame)
	button04:SetText( "Завод ГСР" )
	button04:SetFont("marske4")
	button04:SetPos( 20, 300 )
	button04:SetSize( 360, 30 )
	button04.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 15, 15, 125 ) )
	end
	button04.DoClick = function()
		InfoMarker04()
		frame:Close()
	end
	
	local button05 = vgui.Create("DButton", frame)
	button05:SetText( "Больница" )
	button05:SetFont("marske4")
	button05:SetPos( 20, 350 )
	button05:SetSize( 360, 30 )
	button05.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 15, 15, 125 ) )
	end
	button05.DoClick = function()
		InfoMarker05()
		frame:Close()
	end
	
	local button06 = vgui.Create("DButton", frame)
	button06:SetText( "Верховная партия Альянса" )
	button06:SetFont("marske4")
	button06:SetPos( 20, 400 )
	button06:SetSize( 360, 30 )
	button06.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 15, 15, 125 ) )
	end
	button06.DoClick = function()
		InfoMarker06()
		frame:Close()
	end
end

function InfoMarker01()
	local ply = LocalPlayer()
	local playerpos = ply:GetPos()
	local material = Material( "icon16/pilcrow.png" )
	hook.Add( "HUDPaint", "HUDInfoMarker01", function()
		local markerPos = Vector(-814.008362, -1228.160400, 480.232605)
		local pos = markerPos:ToScreen()
		local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
		surface.SetDrawColor( color_white )
		surface.SetMaterial( material )
		surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
		dist = math.Round( ( dist / 17.3 ) - 3, 0 )
		if dist >= 2 then
			draw.SimpleText( dist .. "m " .. "Нексус Надзора", "Trebuchet18", pos.x + 21, pos.y, color_white )
		elseif ply:IsValid() then
			hook.Remove( "HUDPaint", "HUDInfoMarker01" )
		end
	end )
end
function InfoMarker02()
	local ply = LocalPlayer()
	local playerpos = ply:GetPos()
	local material = Material( "icon16/pilcrow.png" )
	hook.Add( "HUDPaint", "HUDInfoMarker02", function()
		local markerPos = Vector(961.427490, -1378.961548, 522.531250)
		local pos = markerPos:ToScreen()
		local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
		surface.SetDrawColor( color_white )
		surface.SetMaterial( material )
		surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
		dist = math.Round( ( dist / 17.3 ) - 3, 0 )
		if dist >= 2 then
			draw.SimpleText( dist .. "m " .. "Гражданский центр", "Trebuchet18", pos.x + 21, pos.y, color_white )
		elseif ply:IsValid() then
			hook.Remove( "HUDPaint", "HUDInfoMarker02" )
		end
	end )
end

function InfoMarker03()
	local ply = LocalPlayer()
	local playerpos = ply:GetPos()
	local material = Material( "icon16/pilcrow.png" )
	hook.Add( "HUDPaint", "HUDInfoMarker03", function()
		local markerPos = Vector(273.306946, -234.872253, 488.761810)
		local pos = markerPos:ToScreen()
		local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
		surface.SetDrawColor( color_white )
		surface.SetMaterial( material )
		surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
		dist = math.Round( ( dist / 17.3 ) - 3, 0 )
		if dist >= 2 then
			draw.SimpleText( dist .. "m " .. "Раздатчики рационов питания", "Trebuchet18", pos.x + 21, pos.y, color_white )
		elseif ply:IsValid() then
			hook.Remove( "HUDPaint", "HUDInfoMarker03" )
		end
	end )
end

function InfoMarker04()
	local ply = LocalPlayer()
	local playerpos = ply:GetPos()
	local material = Material( "icon16/pilcrow.png" )
	hook.Add( "HUDPaint", "HUDInfoMarker04", function()
		local markerPos = Vector(1043.999268, -3401.822266, 65.824875)
		local pos = markerPos:ToScreen()
		local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
		surface.SetDrawColor( color_white )
		surface.SetMaterial( material )
		surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
		dist = math.Round( ( dist / 17.3 ) - 3, 0 )
		if dist >= 2 then
			draw.SimpleText( dist .. "m " .. "Завод ГСР", "Trebuchet18", pos.x + 21, pos.y, color_white )
		elseif ply:IsValid() then
			hook.Remove( "HUDPaint", "HUDInfoMarker04" )
		end
	end )
end

function InfoMarker05()
	local ply = LocalPlayer()
	local playerpos = ply:GetPos()
	local material = Material( "icon16/pilcrow.png" )
	hook.Add( "HUDPaint", "HUDInfoMarker05", function()
		local markerPos = Vector(292.161774, 1405.282349, 431.189484)
		local pos = markerPos:ToScreen()
		local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
		surface.SetDrawColor( color_white )
		surface.SetMaterial( material )
		surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
		dist = math.Round( ( dist / 17.3 ) - 3, 0 )
		if dist >= 2 then
			draw.SimpleText( dist .. "m " .. "Больница", "Trebuchet18", pos.x + 21, pos.y, color_white )
		elseif ply:IsValid() then
			hook.Remove( "HUDPaint", "HUDInfoMarker05" )
		end
	end )
end

function InfoMarker06()
	local ply = LocalPlayer()
	local playerpos = ply:GetPos()
	local material = Material( "icon16/pilcrow.png" )
	hook.Add( "HUDPaint", "HUDInfoMarker06", function()
		local markerPos = Vector(-3874.654785, -349.713776, 467.005310)
		local pos = markerPos:ToScreen()
		local dist = markerPos:Distance( LocalPlayer():GetPos() )
						
		surface.SetDrawColor( color_white )
		surface.SetMaterial( material )
		surface.DrawTexturedRect( pos.x, pos.y, 16, 16 )
						
		dist = math.Round( ( dist / 17.3 ) - 3, 0 )
		if dist >= 2 then
			draw.SimpleText( dist .. "m " .. "Верховная партия Альянса", "Trebuchet18", pos.x + 21, pos.y, color_white )
		elseif ply:IsValid() then
			hook.Remove( "HUDPaint", "HUDInfoMarker06" )
		end
	end )
end

function ENT:Draw()
	self:DrawModel()
	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 85)	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 500 then
		if (self:GetDTInt(1) == 0) then
			cam.Start3D2D(pos + ang:Up()*0, Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.07)
				
				draw.SimpleText("Вера Аркадьевна", "marske6", -20, -1100, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
				surface.SetDrawColor( 255, 255, 255, 50 )
				surface.DrawLine( -90, -1085, 50, -1085 )
				draw.SimpleText("Гид по C17I", "Trebuchet18", -20, -1075, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

			cam.End3D2D();
		end
	end 
end 