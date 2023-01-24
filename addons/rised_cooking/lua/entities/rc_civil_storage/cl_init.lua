-- "addons\\rised_cooking\\lua\\entities\\rc_civil_storage\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

function ENT:Draw()
    self:DrawModel()
end

local cart = {}

local matClose = Material("shenesis/general/close.png", "noclamp smooth")
net.Receive("ExtraFood.OpenMenu", function()

	local frame = vgui.Create("DFrame") 
	frame:SetPos(50,50)
	frame:SetSize(650,350)
	frame:SetTitle("Склад премиальных провизорных ресурсов")
	frame:Center()
	frame:SetDraggable(true)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame.Paint = function(s,w,h)
		draw.RoundedBox(1,0,0,w,h,Color(15,15,15, 190))
		draw.RoundedBox(1,0,0,w,25,Color(255, 165, 0, 255))
	end	
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("X")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(625,0)
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
	
	local DScrollPanel = vgui.Create( "DScrollPanel", frame )
	DScrollPanel:Dock( FILL )
	
	local sbar = DScrollPanel:GetVBar()
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(255, 165, 0, 255))
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(255, 195, 87, 255))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(255, 255, 255, 255))
	end
	
	local offset = 15
	for k,v in pairs(RISED.Config.Food) do

		if !v.Trade then continue end
		
		local textDisc = DScrollPanel:Add("DLabel")
		textDisc:SetPos( 15, offset + 24 )
		textDisc:SetText( v.Name )
		textDisc:SetFont( "marske4" )
		textDisc:SetColor( Color( 255, 255, 255 ) )
		textDisc:SizeToContents()
		textDisc:SetDark( 1 )
		
		local textLine2 = DScrollPanel:Add("DLabel")
		textLine2:SetPos( 250, offset + 24 )
		textLine2:SetText( "-" )
		textLine2:SetFont( "marske4" )
		textLine2:SetColor( Color( 255, 255, 255 ) )
		textLine2:SizeToContents()
		textLine2:SetDark( 1 )
		
		local textCost = DScrollPanel:Add("DLabel")
		textCost:SetPos( 280, offset + 24 )
		textCost:SetText( v.Cost .. " T." )
		textCost:SetFont( "marske4" )
		textCost:SetColor( Color( 255, 255, 255 ) )
		textCost:SizeToContents()
		textCost:SetDark( 1 )
		
		local buttonAdd = DScrollPanel:Add("DButton")
		buttonAdd:SetText( "Добавить" )
		buttonAdd:SetFont( "marske4" )
		buttonAdd:SetPos( 345, offset + 16 )
		buttonAdd:SetSize( 94, 30 )
		buttonAdd.Paint = function( self, w, h )
			if table.HasValue(cart, k) then
				draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 165, 0, 255 ) )
			else
				draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 125 ) )
			end
		end
		buttonAdd.DoClick = function()
			if table.HasValue(cart, k) then
				table.RemoveByValue(cart, k)
			else
				table.insert(cart, k)
			end
		end
		
		offset = offset + 64
	end
	
	-- if GAMEMODE.Rebels[LocalPlayer():Team()] then
		-- local buttonDiversion = vgui.Create("DButton", frame)
		-- buttonDiversion:SetText( "Диверсия" )
		-- buttonDiversion:SetFont( "marske4" )
		-- buttonDiversion:SetPos( 462, 250 )
		-- buttonDiversion:SetSize( 150, 30 )
		-- buttonDiversion.Paint = function( self, w, h )
		-- 	draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 25 ) )
		-- end
		-- buttonDiversion.DoClick = function()
		-- 	local str = ""
		-- 	for k,v in pairs(cart) do
		-- 		str = str .. ", " .. v
		-- 	end
			
		-- 	net.Start("ExtraFood.Server")
		-- 	net.WriteEntity(LocalPlayer())
		-- 	net.WriteString(str)
		-- 	net.WriteInt(2, 10)
		-- 	net.SendToServer()
			
		-- 	frame:Close()
		-- end
	-- elseif LocalPlayer():isCP() then
	-- 	local buttonDiversion = vgui.Create("DButton", frame)
	-- 	buttonDiversion:SetText( "Поставка Альянса" )
	-- 	buttonDiversion:SetFont( "marske4" )
	-- 	buttonDiversion:SetPos( 462, 300 )
	-- 	buttonDiversion:SetSize( 150, 30 )
	-- 	buttonDiversion.Paint = function( self, w, h )
	-- 		draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 25 ) )
	-- 	end
	-- 	buttonDiversion.DoClick = function()
	-- 		local str = ""
	-- 		for k,v in pairs(cart) do
	-- 			str = str .. ", " .. v
	-- 		end
			
	-- 		net.Start("ExtraFood.Server")
	-- 		net.WriteEntity(LocalPlayer())
	-- 		net.WriteString(str)
	-- 		net.WriteInt(3, 10)
	-- 		net.SendToServer()
			
	-- 		frame:Close()
	-- 	end
	-- end

	if !LocalPlayer():isCP() then
		local buttonBuy = vgui.Create("DButton", frame)
		if LocalPlayer():GetNWString("Player_WorkStatus") == "Провизор" then
			buttonBuy:SetText( "Купить" )
		else
			buttonBuy:SetText( "Украсть" )
		end
		buttonBuy:SetFont( "marske4" )
		buttonBuy:SetPos( 462, 300 )
		buttonBuy:SetSize( 150, 30 )
		buttonBuy.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 255 ) )
		end
		buttonBuy.DoClick = function()
			local str = ""
			for k,v in pairs(cart) do
				str = str .. ", " .. v
			end
			
			net.Start("ExtraFood.Server")
			net.WriteEntity(LocalPlayer())
			net.WriteString(str)
			net.WriteInt(1, 10)
			net.SendToServer()
			
			frame:Close()
		end
	end
end)