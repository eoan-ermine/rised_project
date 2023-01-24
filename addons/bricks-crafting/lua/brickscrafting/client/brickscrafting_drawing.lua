-- "addons\\bricks-crafting\\lua\\brickscrafting\\client\\brickscrafting_drawing.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[ MATERIALS ]]--
BCS_MATERIALS = {
	["Error"] = Material( "materials/brickscrafting/icons/error.png", "noclamp smooth" ),
	["IconAlert"] = Material( "materials/brickscrafting/icons/alert.png", "noclamp smooth" ),

	["IconTraining"] = Material( "materials/brickscrafting/general_icons/training.png", "noclamp smooth" ),
	["IconQuest"] = Material( "materials/brickscrafting/general_icons/quest.png", "noclamp smooth" ),
	["IconTools"] = Material( "materials/brickscrafting/general_icons/tools.png", "noclamp smooth" ),
	["IconShop"] = Material( "materials/brickscrafting/general_icons/shop.png", "noclamp smooth" ),

	["IconPlayers"] = Material( "materials/brickscrafting/general_icons/players.png", "noclamp smooth" ),
	["IconConfig"] = Material( "materials/brickscrafting/general_icons/config.png", "noclamp smooth" ),

	["IconCross"] = Material( "materials/brickscrafting/general_icons/cross.png", "noclamp smooth" ),
	["IconSearch"] = Material( "materials/brickscrafting/general_icons/search.png", "noclamp smooth" ),
	["IconBackpack"] = Material( "materials/brickscrafting/general_icons/backpack.png", "noclamp smooth" ),
	["IconCrafting"] = Material( "materials/brickscrafting/general_icons/crafting.png", "noclamp smooth" ),
	["IconAdmin"] = Material( "materials/brickscrafting/general_icons/admin.png", "noclamp smooth" ),
	["IconHint"] = Material( "materials/brickscrafting/general_icons/hint.png", "noclamp smooth" ),
}

--[[ DRAWING ]]--
BCS_DRAWING = {}

function BCS_DRAWING.GetMaterial( key )
	if( BCS_MATERIALS[key] ) then
		return BCS_MATERIALS[key]
	else
		return BCS_MATERIALS["Error"]
	end
end

function BCS_DRAWING.DrawProgress( text, status )
	local W, H = ScrW()*0.2, 50
	local X, Y = (ScrW()/2)-(W/2), 50

	surface.SetDrawColor( 30, 30, 44 )
	surface.DrawRect( X, Y, W, H )
	surface.SetDrawColor( 24, 25, 34 )
	surface.DrawRect( X, Y, math.Clamp( W*status, 0, W ), H )

	draw.SimpleText( text .. " " .. math.Round(status*100) .. "%", "BCS_Roboto_22", X+(W/2), Y+(H/2), Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

local BCSNotifcations = {}
local BCSNotifcationPanels = {}
local function CreateNotPanel( key )
	if( not BCSNotifcations[key] ) then return end
	surface.PlaySound( "buttons/lightswitch2.wav" )

	local W, H = (400/1920)*ScrW(), 50
	local X, Y = (ScrW()/2)-(W/2), 115
	--BCS_NOTIFICATION_BACK:Remove()
	if( not IsValid( BCS_NOTIFICATION_BACK ) ) then
		BCS_NOTIFICATION_BACK = vgui.Create( "DPanel" )
		BCS_NOTIFICATION_BACK:SetSize( W, (Y+H) )
		BCS_NOTIFICATION_BACK:SetPos( X, 0 )
		BCS_NOTIFICATION_BACK.Paint = function( self2, w, h ) end
	end

	for i = 1, 5 do
		if( BCSNotifcationPanels[key-i] and IsValid( BCSNotifcationPanels[key-i] ) ) then
			local panel = BCSNotifcationPanels[key-i]

			if( IsValid( panel ) ) then
				local YPos = Y-(i*H)-(i*5)
				panel:MoveTo( 0, YPos, 0.1, 0, 1, function() 
					if( YPos+H <= 0 ) then
						panel:Remove()
					end
				end )
			end
		end
	end

	local NotifcationEntry = vgui.Create( "DPanel", BCS_NOTIFICATION_BACK )
	NotifcationEntry:SetSize( 0, H )
	NotifcationEntry:SetPos( 0, Y )
	NotifcationEntry:SizeTo( W, H, 0.25, 0, 1 )
	local material = Material( BCSNotifcations[key][2] or "", "noclamp smooth" )
	local gradientRight = Material( 'vgui/gradient-l' )
	NotifcationEntry.Paint = function( self2, w, h )
		surface.SetDrawColor( 24, 25, 34, 100 )
		surface.DrawRect( h, 0, w-h, h )
		surface.SetDrawColor( 30, 30, 44, 245 )
		surface.DrawRect( 0, 0, h, h )

		surface.SetMaterial( gradientRight )
		surface.SetDrawColor( 24, 25, 34, 255 )
		surface.DrawTexturedRect( h, 0, w, h )
	
		surface.SetMaterial( material )
		surface.SetDrawColor( 255, 255, 255, 255 )
		local Spacing = 8
		surface.DrawTexturedRect( Spacing, Spacing, h-(2*Spacing), h-(2*Spacing) )
	
		draw.SimpleText( BCSNotifcations[key][1] or "", "BCS_Roboto_22", h+10, (h/2), Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
	end

	timer.Simple( 1.5, function()
		if( IsValid( NotifcationEntry ) ) then
			NotifcationEntry:SizeTo( 0, NotifcationEntry:GetTall(), 0.25, 0, 1, function()
				NotifcationEntry:Remove()
			end )
		end
	end )

	BCSNotifcationPanels[key] = NotifcationEntry
end

function BCS_DRAWING.AddNotification( text, icon )
	local key = #BCSNotifcations+1
	BCSNotifcations[key] = { text, icon }
	CreateNotPanel( key )
end

function BCS_DRAWING.CreateNotification( text, icon )
	if( IsValid( BCS_NOTIFICATION ) ) then
		BCS_NOTIFICATION:SizeTo( 0, H, 0.25, 0, 1, function()
			CreateNotPanel( text, icon )
		end )
	else
		CreateNotPanel( text, icon )
	end
end
	
local gradientDown = Material( 'vgui/gradient_down' )
local gradientUp = Material( 'vgui/gradient_up' )
local gradientLeft = Material( 'vgui/gradient-l' )
local gradientRight = Material( 'vgui/gradient-r' )
BCS_DRAWING.ShadowSize = 7
function BCS_DRAWING.DrawMaterialShadow( x, y, w, h, GradientType )
	if( GradientType == "Down" ) then
		surface.SetMaterial( gradientDown )
	elseif( GradientType == "Up" ) then
		surface.SetMaterial( gradientUp )	
	elseif( GradientType == "Left" ) then
		surface.SetMaterial( gradientLeft )	
	elseif( GradientType == "Right" ) then
		surface.SetMaterial( gradientRight )
	end
	surface.SetDrawColor( 0, 0, 0, 175 )
	surface.DrawTexturedRect( x, y, w, h )
end

--[[

	FONTS

]]--
local sizeMultiplier = math.Clamp( (ScrW()/1920), 0, 1 )
if( sizeMultiplier < 1 ) then
	sizeMultiplier = math.Clamp( sizeMultiplier+0.2, 0, 1 )
end

surface.CreateFont( "BCS_Roboto_40", {
	font = "Roboto",
	size = 40*sizeMultiplier,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "BCS_Roboto_17", {
	font = "Roboto",
	size = 17*sizeMultiplier,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "BCS_Roboto_18", {
	font = "Roboto",
	size = 18*sizeMultiplier,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "BCS_Roboto_22", {
	font = "Roboto",
	size = 22*sizeMultiplier,
	weight = 5000,
	antialias = true,
} )

surface.CreateFont( "BCS_Roboto_21", {
	font = "Roboto",
	size = 20*sizeMultiplier,
	weight = 5000,
	antialias = true,
} )

surface.CreateFont( "BCS_Roboto_25", {
	font = "Roboto",
	size = 25*sizeMultiplier,
	weight = 5000,
	antialias = true,
} )

surface.CreateFont( "BCS_Roboto_16", {
	font = "Roboto",
	size = 16*sizeMultiplier,
	weight = 500,
	antialias = true,
} )

surface.CreateFont( "BCS_Roboto_24", {
	font = "Roboto",
	size = 25*sizeMultiplier,
	weight = 2500,
	antialias = true,
} )

--[[

	DERMA QUERIES

]]--

function BCS_DRAWING.StringRequest( title, subtitle, default, func_confirm, func_cancel, confirmText, cancelText )
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 0, 0 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "" )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()
	DermaPanel.Paint = function() end
	
	local BackPanel = vgui.Create( "DPanel", DermaPanel )
	BackPanel:SetSize( (1920)*0.25, (1080)*0.2 )
	BackPanel:Center()
	BackPanel.Paint = function( self2, w, h )
		if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 24, 25, 34 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(2, 2, 1, 255, 0, 5, false )
		else
			surface.SetDrawColor( 24, 25, 34 )
			surface.DrawRect( 0, 0, w, h )		
		end

		draw.SimpleText( subtitle, "BCS_Roboto_22", w/2, 60, Color( 245, 245, 245 ), TEXT_ALIGN_CENTER, 0 )
	end
	
	local TextEntry = vgui.Create( "DTextEntry", BackPanel )
	TextEntry:SetSize( BackPanel:GetWide()*0.75, 25 )
	TextEntry:SetPos( (BackPanel:GetWide()-TextEntry:GetWide())/2, 45+50 )
	TextEntry:SetText( default or "" )
	
	local TextEntryXPos, TextEntryYPos = TextEntry:GetPos()

	local ButtonBar = vgui.Create( "DPanel", BackPanel )
	ButtonBar:SetSize( TextEntry:GetWide(), 50 )
	ButtonBar:SetPos( TextEntryXPos, BackPanel:GetTall()-15-ButtonBar:GetTall()-5 )
	ButtonBar.Paint = function( self2, w, h )
		if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(2, 2, 1, 255, 0, 5, false )
		else
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 0, 0, w, h )		
		end
	end
	
	local YesButton = vgui.Create( "DButton", ButtonBar )
	YesButton:Dock( LEFT )
	YesButton:SetWide( ButtonBar:GetWide()/2 )
	YesButton:SetText( "" )
	local Alpha = 0
	YesButton.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 0, 100 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 0, 200 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 100 )
		end

		surface.SetDrawColor( 10, 10, 20, Alpha )
		surface.DrawRect( 0, 0, w, h )
		
		draw.SimpleText( confirmText or "OK", "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	YesButton.DoClick = function()
		DermaPanel:Remove()
		func_confirm( TextEntry:GetValue() )
	end	
	
	local NoButton = vgui.Create( "DButton", ButtonBar )
	NoButton:Dock( LEFT )
	NoButton:SetWide( ButtonBar:GetWide()/2 )
	NoButton:SetText( "" )
	local Alpha = 0
	NoButton.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 0, 100 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 0, 200 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 100 )
		end

		surface.SetDrawColor( 10, 10, 20, Alpha )
		surface.DrawRect( 0, 0, w, h )
		
		draw.SimpleText( cancelText or "Cancel", "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	NoButton.DoClick = function()
		DermaPanel:Remove()
		func_cancel( TextEntry:GetValue() )
	end

	--[[ Top Bar ]]--
	local TopBar = vgui.Create( "DPanel", BackPanel )
	TopBar:SetPos( 0, 0 )
	TopBar:SetSize( BackPanel:GetWide(), 30+BCS_DRAWING.ShadowSize )
	TopBar.Paint = function( self2, w, h )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( 0, 0, w, h-BCS_DRAWING.ShadowSize )

		BCS_DRAWING.DrawMaterialShadow( 0, h-BCS_DRAWING.ShadowSize, w, BCS_DRAWING.ShadowSize, "Down" )
		
		draw.SimpleText( title, "BCS_Roboto_22", w/2, (h-BCS_DRAWING.ShadowSize)/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local MenuCloseButton = vgui.Create( "DButton", TopBar )
	MenuCloseButton:SetSize( TopBar:GetTall()-BCS_DRAWING.ShadowSize, TopBar:GetTall()-BCS_DRAWING.ShadowSize )
	MenuCloseButton:SetPos( TopBar:GetWide()-MenuCloseButton:GetWide(), 0 )
	MenuCloseButton:SetText( "" )
	local CloseMat = BCS_DRAWING.GetMaterial( "IconCross" )
	local Alpha = 100
	MenuCloseButton.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 100, 150 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 100, 250 )
		else
			Alpha = math.Clamp( Alpha-5, 100, 150 )
		end		

		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( 0, 0, w, h )

		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( CloseMat )
		local Spacing = 10
		surface.DrawTexturedRect( Spacing, Spacing, w-(2*Spacing), h-(2*Spacing) )
	end
	MenuCloseButton.DoClick = function()
		DermaPanel:Remove()
	end
end

function BCS_DRAWING.SliderRequest( title, subtitle, default, max, func_confirm, func_cancel, confirmText, cancelText )
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 0, 0 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "" )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()
	DermaPanel.Paint = function() end
	
	local BackPanel = vgui.Create( "DPanel", DermaPanel )
	BackPanel:SetSize( (1920)*0.25, (1080)*0.2 )
	BackPanel:Center()
	BackPanel.Paint = function( self2, w, h )
		if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 24, 25, 34 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(2, 2, 1, 255, 0, 5, false )
		else
			surface.SetDrawColor( 24, 25, 34 )
			surface.DrawRect( 0, 0, w, h )		
		end

		draw.SimpleText( subtitle, "BCS_Roboto_22", w/2, 60, Color( 245, 245, 245 ), TEXT_ALIGN_CENTER, 0 )
	end
	
	local DermaNumSlider = vgui.Create( "brickscrafting_numslider", BackPanel )
	DermaNumSlider:SetSize( BackPanel:GetWide()*0.5, 65 )
	DermaNumSlider:SetPos( (BackPanel:GetWide()-DermaNumSlider:GetWide())/2, 30+50 )
	DermaNumSlider:SetText( "" )
	DermaNumSlider:SetMinMax( 0, max )
	DermaNumSlider:SetDecimals( 0 )
	DermaNumSlider:SetDark( false )
	DermaNumSlider:SetValue( default )
	
	local DermaNumSliderXPos, DermaNumSliderYPos = DermaNumSlider:GetPos()

	local ButtonBar = vgui.Create( "DPanel", BackPanel )
	ButtonBar:SetSize( BackPanel:GetWide()*0.75, 50 )
	ButtonBar:SetPos( (BackPanel:GetWide()-ButtonBar:GetWide())/2, BackPanel:GetTall()-15-ButtonBar:GetTall()-5 )
	ButtonBar.Paint = function( self2, w, h )
		if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(2, 2, 1, 255, 0, 5, false )
		else
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 0, 0, w, h )			
		end
	end
	
	local YesButton = vgui.Create( "DButton", ButtonBar )
	YesButton:Dock( LEFT )
	YesButton:SetWide( ButtonBar:GetWide()/2 )
	YesButton:SetText( "" )
	local Alpha = 0
	YesButton.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 0, 100 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 0, 200 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 100 )
		end

		surface.SetDrawColor( 10, 10, 20, Alpha )
		surface.DrawRect( 0, 0, w, h )
		
		draw.SimpleText( confirmText or "OK", "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	YesButton.DoClick = function()
		DermaPanel:Remove()
		func_confirm( DermaNumSlider:GetValue() )
	end	
	
	local NoButton = vgui.Create( "DButton", ButtonBar )
	NoButton:Dock( LEFT )
	NoButton:SetWide( ButtonBar:GetWide()/2 )
	NoButton:SetText( "" )
	local Alpha = 0
	NoButton.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 0, 100 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 0, 200 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 100 )
		end

		surface.SetDrawColor( 10, 10, 20, Alpha )
		surface.DrawRect( 0, 0, w, h )
		
		draw.SimpleText( cancelText or "Cancel", "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	NoButton.DoClick = function()
		DermaPanel:Remove()
		func_cancel( DermaNumSlider:GetValue() )
	end

	--[[ Top Bar ]]--
	local TopBar = vgui.Create( "DPanel", BackPanel )
	TopBar:SetPos( 0, 0 )
	TopBar:SetSize( BackPanel:GetWide(), 30+BCS_DRAWING.ShadowSize )
	TopBar.Paint = function( self2, w, h )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( 0, 0, w, h-BCS_DRAWING.ShadowSize )

		BCS_DRAWING.DrawMaterialShadow( 0, h-BCS_DRAWING.ShadowSize, w, BCS_DRAWING.ShadowSize, "Down" )
		
		draw.SimpleText( title, "BCS_Roboto_22", w/2, (h-BCS_DRAWING.ShadowSize)/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local MenuCloseButton = vgui.Create( "DButton", TopBar )
	MenuCloseButton:SetSize( TopBar:GetTall()-BCS_DRAWING.ShadowSize, TopBar:GetTall()-BCS_DRAWING.ShadowSize )
	MenuCloseButton:SetPos( TopBar:GetWide()-MenuCloseButton:GetWide(), 0 )
	MenuCloseButton:SetText( "" )
	local CloseMat = BCS_DRAWING.GetMaterial( "IconCross" )
	local Alpha = 100
	MenuCloseButton.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 100, 150 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 100, 250 )
		else
			Alpha = math.Clamp( Alpha-5, 100, 150 )
		end		

		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( 0, 0, w, h )

		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( CloseMat )
		local Spacing = 10
		surface.DrawTexturedRect( Spacing, Spacing, w-(2*Spacing), h-(2*Spacing) )
	end
	MenuCloseButton.DoClick = function()
		DermaPanel:Remove()
	end
end

function BCS_DRAWING.Query( subtitle, title, btn1text, btn1func, btn2text, btn2func, btn3text, btn3func, btn4text, btn4func )
	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 0, 0 )
	DermaPanel:SetSize( ScrW(), ScrH() )
	DermaPanel:SetTitle( "" )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()
	DermaPanel.Paint = function() end
	
	local BackPanel = vgui.Create( "DPanel", DermaPanel )
	BackPanel:SetSize( (1920)*0.25, (1080)*0.2 )
	BackPanel:Center()
	BackPanel.Paint = function( self2, w, h )
		if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 24, 25, 34 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(2, 2, 1, 255, 0, 5, false )
		else
			surface.SetDrawColor( 24, 25, 34 )
			surface.DrawRect( 0, 0, w, h )		
		end

		draw.SimpleText( subtitle, "BCS_Roboto_22", w/2, 60, Color( 245, 245, 245 ), TEXT_ALIGN_CENTER, 0 )
	end

	local ButtonBar = vgui.Create( "DPanel", BackPanel )
	ButtonBar:SetSize( BackPanel:GetWide()*0.75, 50 )
	ButtonBar:SetPos( (BackPanel:GetWide()-ButtonBar:GetWide())/2, BackPanel:GetTall()-(ButtonBar:GetTall()+25) )
	ButtonBar.Paint = function( self2, w, h )
		if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(2, 2, 1, 255, 0, 5, false )
		else
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 0, 0, w, h )		
		end
	end
	
	local Buttons = {}
	local function AddButton( text, func )
		table.insert( Buttons, { text, func } )
	end

	if( btn1text and btn1func ) then
		AddButton( btn1text, btn1func )
	end

	if( btn2text and btn2func ) then
		AddButton( btn2text, btn2func )
	end

	if( btn3text and btn3func ) then
		AddButton( btn3text, btn3func )
	end

	if( btn4text and btn4func ) then
		AddButton( btn4text, btn4func )
	end

	for k, v in pairs( Buttons ) do
		local Button = vgui.Create( "DButton", ButtonBar )
		Button:Dock( LEFT )
		Button:SetWide( ButtonBar:GetWide()/#Buttons )
		Button:SetText( "" )
		local Alpha = 0
		Button.Paint = function( self2, w, h )
			if( self2:IsHovered() and !self2:IsDown() ) then
				Alpha = math.Clamp( Alpha+5, 0, 100 )
			elseif( self2:IsDown() ) then
				Alpha = math.Clamp( Alpha+10, 0, 200 )
			else
				Alpha = math.Clamp( Alpha-5, 0, 100 )
			end

			surface.SetDrawColor( 10, 10, 20, Alpha )
			surface.DrawRect( 0, 0, w, h )
			
			draw.SimpleText( v[1] or "", "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		Button.DoClick = function()
			DermaPanel:Remove()
			v[2]()
		end
	end

	--[[ Top Bar ]]--
	local TopBar = vgui.Create( "DPanel", BackPanel )
	TopBar:SetPos( 0, 0 )
	TopBar:SetSize( BackPanel:GetWide(), 30+BCS_DRAWING.ShadowSize )
	TopBar.Paint = function( self2, w, h )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( 0, 0, w, h-BCS_DRAWING.ShadowSize )

		BCS_DRAWING.DrawMaterialShadow( 0, h-BCS_DRAWING.ShadowSize, w, BCS_DRAWING.ShadowSize, "Down" )
		
		draw.SimpleText( title, "BCS_Roboto_22", w/2, (h-BCS_DRAWING.ShadowSize)/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local MenuCloseButton = vgui.Create( "DButton", TopBar )
	MenuCloseButton:SetSize( TopBar:GetTall()-BCS_DRAWING.ShadowSize, TopBar:GetTall()-BCS_DRAWING.ShadowSize )
	MenuCloseButton:SetPos( TopBar:GetWide()-MenuCloseButton:GetWide(), 0 )
	MenuCloseButton:SetText( "" )
	local CloseMat = BCS_DRAWING.GetMaterial( "IconCross" )
	local Alpha = 100
	MenuCloseButton.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 100, 150 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 100, 250 )
		else
			Alpha = math.Clamp( Alpha-5, 100, 150 )
		end		

		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( 0, 0, w, h )

		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( CloseMat )
		local Spacing = 10
		surface.DrawTexturedRect( Spacing, Spacing, w-(2*Spacing), h-(2*Spacing) )
	end
	MenuCloseButton.DoClick = function()
		DermaPanel:Remove()
	end
end