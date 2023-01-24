-- "addons\\rised_cooking\\lua\\entities\\cm_cookingbook\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include('shared.lua')

function ENT:Draw()
	self:DrawModel()
end

surface.CreateFont( "font33", {
	font = Calibri,
	size = 33,
	weight = 100
})

surface.CreateFont( "font45", {
	font = Calibri,
	size = 85,
	weight = 100
})

net.Receive("cookingbookv2", function()

local Frame = vgui.Create("DFrame")
Frame:SetPos(5, 5)
Frame:SetSize(ScrW() * 0.8, ScrH() * 1)
Frame:SetTitle("")
Frame:SetVisible(true)
Frame:SetDraggable(true)
Frame:Center()
Frame:ShowCloseButton(false)
Frame:MakePopup()
	Frame.Paint = function(self, w, h)
	end

local Framepage2 = vgui.Create( "DFrame" )
Framepage2:SetPos( 5, 5 )
Framepage2:SetSize(ScrW() * 0.8, ScrH() * 1)
Framepage2:SetTitle( "" )
Framepage2:SetVisible( true )
Framepage2:SetDraggable( false )
Framepage2:Center()
Framepage2:ShowCloseButton( false )
Framepage2:MakePopup()
Framepage2:Hide()
	Framepage2.Paint = function(self, w, h)
	end

local book = vgui.Create( "DImage", Frame )
book:SetPos( 0, 0 )
book:SetSize(ScrW() * 0.1360 * 5.20, ScrH() * 0.0974 * 9.5 )
book:Center()
book:SetImage( "vgui/img/book_1.png" )

local book2 = vgui.Create( "DImage", Framepage2 )
book2:SetPos( 0, 0 )
book2:SetSize(ScrW() * 0.1360 * 5.20, ScrH() * 0.0974 * 9.5 )
book2:Center()
book2:SetImage( "vgui/img/book_2.png" )

function Frame:OnClose()
	net.Start("cookingbookv2close")
	net.SendToServer()
end
function Framepage2:OnClose()
	net.Start("cookingbookv2close")
	net.SendToServer()
end

	local close = vgui.Create( "DButton", Frame )
	close:SetPos(Frame:GetWide()*0.5-100,ScrH() * 0.952)
	close:SetSize(200, 45)
	close:SetText("")
	local tablerp = 0
	close.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(200, 0, 0, 255))
	end
	close.DoClick = function()
		Frame:Close()
	end

	local close2 = vgui.Create( "DButton", Framepage2 )
	close2:SetPos(Framepage2:GetWide()*0.5-100,ScrH() * 0.952)
	close2:SetSize(200, 45)
	close2:SetText("")
	local tablerp = 0
	close2.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w, h, Color(200, 0, 0, 255))
	end
	close2.DoClick = function()
		Framepage2:Close()
	end

	local DLabel = vgui.Create( "DLabel", Frame )
	DLabel:SetPos(Frame:GetWide()*0.5-35,ScrH() * 0.962)
	DLabel:SetText( "EXIT" )
	DLabel:SetColor(Color(0,0,0,255) )
	DLabel:SetFont("font33")

	local DLabel = vgui.Create( "DLabel", Framepage2 )
	DLabel:SetPos(Framepage2:GetWide()*0.5-35,ScrH() * 0.962)
	DLabel:SetText( "EXIT" )
	DLabel:SetColor(Color(0,0,0,255) )
	DLabel:SetFont("font33")

	local nextpage = vgui.Create( "DButton", Frame )
	nextpage:SetPos(Frame:GetWide()*0.94,ScrH() * 0.45)
	nextpage:SetSize(90, 90)
	nextpage:SetText("")
	local tablerp = 0
	nextpage.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w-5, h-5, Color(35, 35, 35, 150))
		draw.RoundedBox(5, 5/2, 5/2, w-10, h-10, Color(255, 255, 0, 200))
	end
	nextpage.DoClick = function()
		Framepage2:Show()
		Frame:Hide()
	end

	local lastpage = vgui.Create( "DButton", Framepage2 )
	lastpage:SetPos(Framepage2:GetWide()*0,ScrH() * 0.45)
	lastpage:SetSize(90, 90)
	lastpage:SetText("")
	local tablerp = 0
	lastpage.Paint = function(self, w, h)
		draw.RoundedBox(5, 0, 0, w-5, h-5, Color(35, 35, 35, 150))
		draw.RoundedBox(5, 5/2, 5/2, w-10, h-10, Color(255, 255, 0, 200))
	end
	lastpage.DoClick = function()
		Framepage2:Hide()
		Frame:Show()
	end

	local DLabel = vgui.Create( "DLabel", Frame )
	DLabel:SetPos(Frame:GetWide()*0.954,ScrH() * 0.47)
	DLabel:SetSize(45, 45)
	DLabel:SetText( ">" )
	DLabel:SetColor(Color(0,0,0,245) )
	DLabel:SetFont("font45")

	local DLabel = vgui.Create( "DLabel", Framepage2 )
	DLabel:SetPos(Framepage2:GetWide()*0.013,ScrH() * 0.47)
	DLabel:SetSize(45, 45)
	DLabel:SetText( "<" )
	DLabel:SetColor(Color(0,0,0,245) )
	DLabel:SetFont("font45")
end )