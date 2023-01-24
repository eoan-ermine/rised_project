-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_colsheet.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

local PANEL = {}

AccessorFunc( PANEL, "ActiveButton", "ActiveButton" )

local ItemWide = 54
local ExtraEdge = 10

function PANEL:Init()

	self.Content = vgui.Create( "Panel", self )
	self.Content:Dock( FILL )

	self.Navigation = vgui.Create( "DPanel", self )
	self.Navigation:Dock( LEFT )
	self.Navigation:DockMargin( 0, 0, 0, 0 )
	self.Navigation:SetWide( ItemWide+20+20 )
	self.Navigation.Paint = function( self2, w, h ) end

	self.Items = {}

end

function PANEL:UseButtonOnlyStyle()
	self.ButtonOnly = true
end

function PANEL:AddSheet( panel, material )

	if ( !IsValid( panel ) ) then return end

	local Sheet = {}
	Sheet.Button = vgui.Create( "DButton", self.Navigation )
	Sheet.Button.Target = panel
	Sheet.Button:Dock( TOP )
	Sheet.Button:DockMargin( 20-ExtraEdge, 0, 20-ExtraEdge, 0 )
	Sheet.Button:SetTall( ItemWide+(2*ExtraEdge) )	
	Sheet.Button:SetText( "" )
	local ResMat = material
	local Alpha = 0
	Sheet.Button.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() and !self2.m_bSelected ) then
			Alpha = math.Clamp( Alpha+5, 0, 100 )
		elseif( self2:IsDown() || self2.m_bSelected ) then
			Alpha = math.Clamp( Alpha+10, 0, 100 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 100 )
		end

		if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( ExtraEdge, ExtraEdge )
			surface.DrawRect( x, y, w-(2*ExtraEdge), h-(2*ExtraEdge) )
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, w, 5, false )
		else
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( ExtraEdge, ExtraEdge, w-(2*ExtraEdge), h-(2*ExtraEdge) )
		end

		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( ExtraEdge, ExtraEdge, w-(2*ExtraEdge), h-(2*ExtraEdge) )

		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( ResMat )
		local Spacing = 10
		surface.DrawTexturedRect( ExtraEdge+Spacing, ExtraEdge+Spacing, w-(2*ExtraEdge)-(2*Spacing), h-(2*ExtraEdge)-(2*Spacing) )
	end
	Sheet.Button.DoClick = function()
		self:SetActiveButton( Sheet.Button )
	end

	Sheet.Panel = panel
	Sheet.Panel:SetParent( self.Content )
	Sheet.Panel:SetVisible( false )

	if ( self.ButtonOnly ) then
		Sheet.Button:SizeToContents()
		--Sheet.Button:SetColor( Color( 150, 150, 150, 100 ) )
	end

	table.insert( self.Items, Sheet )

	if ( !IsValid( self.ActiveButton ) ) then
		self:SetActiveButton( Sheet.Button )
	end
	
	return Sheet
end

function PANEL:SetActiveButton( active )

	if ( self.ActiveButton == active ) then return end

	if ( self.ActiveButton && self.ActiveButton.Target ) then
		self.ActiveButton.Target:SetVisible( false )
		self.ActiveButton:SetSelected( false )
		self.ActiveButton:SetToggle( false )
		--self.ActiveButton:SetColor( Color( 150, 150, 150, 100 ) )
	end

	self.ActiveButton = active
	active.Target:SetVisible( true )
	active:SetSelected( true )
	active:SetToggle( true )
	--active:SetColor( Color( 255, 255, 255, 255 ) )

	self.Content:InvalidateLayout()

end

derma.DefineControl( "brickscrafting_vgui_colsheet", "", PANEL, "Panel" )
