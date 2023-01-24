-- "addons\\rised_rpevents\\lua\\autorun\\client\\cl_rpevents.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

net.Receive("RPEvents.OpenMenu", function()

	local value = net.ReadInt(16)
	local frame = vgui.Create("DFrame") 
	frame:SetPos(25,ScrH()/5)
	frame:SetSize(250,90)
	frame:SetTitle("RP ситуация")
	frame:SetDraggable(true)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame.Paint = function(s,w,h)
		draw.RoundedBox(1,0,0,w,h,Color(15,15,15, 190))
		draw.RoundedBox(1,0,0,w,25,Color(255, 195, 87, 255))
	end	
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("X")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(225,0)
	buttonClose.Paint = function(me, w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (me.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
		end

		if (me:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
		end
	end
	buttonClose.DoClick = function()
		frame:Close()
	end

	local text01 = vgui.Create( "DLabel", frame )
	text01:SetSize(1000,20)
	text01:SetPos( 25, 35 )
	text01:SetFont("marske4")
	text01:SetText( "Учавствовать в RP ситуации?" )
	
	local buttonYes = vgui.Create("DButton", frame)
	buttonYes:SetText( "Да" )
	buttonYes:SetFont( "marske4" )
	buttonYes:SetPos( 55, 60 )
	buttonYes:SetSize( 50, 25 )
	buttonYes.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 15,15,15, 190 ) )
	end
	buttonYes.DoClick = function()
		net.Start("RPEvents.Server")
		net.WriteEntity(LocalPlayer())
		net.WriteInt(value, 16)
		net.WriteInt(1, 10)
		net.SendToServer()
		
		frame:Close()
	end
	
	local buttonNo = vgui.Create("DButton", frame)
	buttonNo:SetText( "Нет" )
	buttonNo:SetFont( "marske4" )
	buttonNo:SetPos( 145, 60 )
	buttonNo:SetSize( 50, 25 )
	buttonNo.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 15,15,15, 190 ) )
	end
	buttonNo.DoClick = function()
		net.Start("RPEvents.Server")
		net.WriteEntity(LocalPlayer())
		net.WriteInt(value, 16)
		net.WriteInt(2, 10)
		net.SendToServer()
		
		frame:Close()
	end
end)

