-- "addons\\rised_cooking\\lua\\entities\\rc_combine_storage\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

function ENT:Draw()
    self:DrawModel()
end

local foodmodel = {
	"models/pg_plops/pg_food/pg_tortellinac.mdl",
	"models/pg_plops/pg_food/pg_tortellinan.mdl",
	"models/pg_plops/pg_food/pg_tortellinap.mdl",
	"models/pg_plops/pg_food/pg_tortellinar.mdl",
	"models/pg_plops/pg_food/pg_tortellinas.mdl",
	"models/pg_plops/pg_food/pg_tortellinat.mdl",
}

local fooddisc = {
	"Альянс набор",
	"Минимальный",
	"Лоялист",
	"Стандарт",
	"Биотик",
	"Приорити",
}

local foodenergy = {
	100,
	50,
	70,
	60,
	30,
	100,
}

local cart = {}

local matClose = Material("shenesis/general/close.png", "noclamp smooth")
net.Receive("ExtraFood.OpenMenu.Combine", function()

	local count = {}

	for i=1,6,1 do
		table.insert(count, net.ReadInt(10))
	end
	
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
		draw.RoundedBox(1,0,0,w,25,col_combine)
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
		draw.RoundedBox(4, 0, 0, w, h, col_combine)
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, col_combine)
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(255, 255, 255, 255))
	end
	
	local offset = 15
	for k,v in pairs(foodmodel) do
		
		local icon = DScrollPanel:Add("ModelImage");
		icon:SetPos( 25, offset );
		icon:SetSize(64, 64);
		icon:SetModel(v);
		
		local textLine = DScrollPanel:Add("DLabel")
		textLine:SetPos( 135, offset + 24 )
		textLine:SetText( "-" )
		textLine:SetFont( "marske4" )
		textLine:SetColor( Color( 255, 255, 255 ) )
		textLine:SizeToContents()
		textLine:SetDark( 1 )
		
		local textLine2 = DScrollPanel:Add("DLabel")
		textLine2:SetPos( 250, offset + 24 )
		textLine2:SetText( "-" )
		textLine2:SetFont( "marske4" )
		textLine2:SetColor( Color( 255, 255, 255 ) )
		textLine2:SizeToContents()
		textLine2:SetDark( 1 )
		
		local textDisc = DScrollPanel:Add("DLabel")
		textDisc:SetPos( 175, offset + 24 )
		textDisc:SetText( fooddisc[k] )
		textDisc:SetFont( "marske4" )
		textDisc:SetColor( Color( 255, 255, 255 ) )
		textDisc:SizeToContents()
		textDisc:SetDark( 1 )
		
		local textCost = DScrollPanel:Add("DLabel")
		textCost:SetPos( 380, offset + 24 )
		textCost:SetText( count[k] .. " T." )
		textCost:SetFont( "marske4" )
		textCost:SetColor( Color( 255, 255, 255 ) )
		textCost:SizeToContents()
		textCost:SetDark( 1 )
		
		local buttonAdd = DScrollPanel:Add("DButton")
		buttonAdd:SetText( "Забрать" )
		buttonAdd:SetFont( "marske4" )
		buttonAdd:SetPos( 480, offset + 16 )
		buttonAdd:SetSize( 94, 30 )
		buttonAdd.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 15, 15, 125 ) )
		end
		buttonAdd.DoClick = function()
			net.Start("ExtraFood.Server.Combine")
			net.WriteEntity(LocalPlayer())
			net.WriteInt(k, 10)
			net.SendToServer()
			
			frame:Close()
		end
		
		offset = offset + 64
	end
end)

