-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_admin_editcolor.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local PANEL = {}

function PANEL:Init()
	self:SetSize( ScrW(), ScrH() )
	self:SetPos( 0, 0 )
	self:MakePopup()
	self:SetTitle( "" )
	self:ShowCloseButton( false )
	self:SetDraggable( false )

	self.PanelBack = vgui.Create( "DPanel", self )
	self.PanelBack:SetSize( ScrW()*0.35, ScrH()*0.47 )
	self.PanelBack:SetPos( (ScrW()/2)-(self.PanelBack:GetWide()/2), -self.PanelBack:GetTall() )
	self.PanelBack.Paint = function( self2, w, h )
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
	end

	self.PanelBack:MoveTo( (ScrW()/2)-(self.PanelBack:GetWide()/2), (ScrH()/2)-(self.PanelBack:GetTall()/2), 0.25, 0, 1, function() end )

	local ScrollY, ScrollH = ((ScrH()/2)-(self.PanelBack:GetTall()/2))+30, self.PanelBack:GetTall()-30

	local CloseColorEditor = vgui.Create( "DButton", self.PanelBack )
	CloseColorEditor:Dock( BOTTOM )
	CloseColorEditor:DockMargin( 10, 10, 10, 10 )
	CloseColorEditor:SetTall( 40 )
	CloseColorEditor:SetText( "" )
	local Alpha = 0
	CloseColorEditor.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 0, 100 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 0, 200 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 100 )
		end

		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	

		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( 0, 0, w, h )

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigMiningRockSetColor"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local ColorEditorVisual = vgui.Create( "DPanel", self.PanelBack )
	ColorEditorVisual:Dock( BOTTOM )
	ColorEditorVisual:DockMargin( 10, 10, 10, 0 )
	ColorEditorVisual:SetTall( 40 )
	ColorEditorVisual:SetText( "" )

	self.ColorMixer = vgui.Create( "DColorMixer", self.PanelBack )
	self.ColorMixer:Dock( FILL )
	self.ColorMixer:DockMargin( 10, 40, 10, 0 )
	self.ColorMixer:SetPalette( false )
	self.ColorMixer:SetAlphaBar( false )
	self.ColorMixer:SetWangs( true )
	self.ColorMixer:SetColor( Color( 30, 100, 160 ) )

	ColorEditorVisual.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow()
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.SetDrawColor( self.ColorMixer:GetColor() or Color( 255, 255, 255 ) )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(2, 2, 1, 255, w, 5, false )
	end

	CloseColorEditor.DoClick = function()
		if( self.func_Close ) then
			self.func_Close( self.ColorMixer:GetColor() )
		end

		self:Remove()
	end

	--[[ Top Bar ]]--
	local TopBar = vgui.Create( "DPanel", self.PanelBack )
	TopBar:SetPos( 0, 0 )
	TopBar:SetSize( self.PanelBack:GetWide(), 30+BCS_DRAWING.ShadowSize )
	TopBar.Paint = function( self2, w, h )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( 0, 0, w, h-BCS_DRAWING.ShadowSize )

		BCS_DRAWING.DrawMaterialShadow( 0, h-BCS_DRAWING.ShadowSize, w, BCS_DRAWING.ShadowSize, "Down" )
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigColorEditor"), "BCS_Roboto_22", w/2, (h-BCS_DRAWING.ShadowSize)/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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
		self.PanelBack:MoveTo( (ScrW()/2)-(self.PanelBack:GetWide()/2), ScrH(), 0.25, 0, 1, function() 
			self:Remove()
		end )
	end
end

function PANEL:SetMixerColor( color )
	if( IsValid( self.ColorMixer ) ) then
		self.ColorMixer:SetColor( color )
	end
end

function PANEL:Paint( w, h )
end

vgui.Register( "brickscrafting_vgui_admin_editcolor", PANEL, "DFrame" )