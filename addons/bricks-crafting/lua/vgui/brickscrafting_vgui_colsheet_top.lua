-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_colsheet_top.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

local PANEL = {}

AccessorFunc( PANEL, "ActiveButton", "ActiveButton" )

function PANEL:Init()

	self.Navigation = vgui.Create( "DPanel", self )
	self.Navigation:Dock( TOP )
	self.Navigation:DockMargin( 0, 0, 37+13, 0 )
	self.Navigation:SetTall( 30 )
	self.Navigation.Paint = function( self2, w, h )
		surface.SetDrawColor( 0, 128, 181, 255 )
		surface.DrawRect( 0, 0, w, h )
	end

	self.Content = vgui.Create( "Panel", self )
	self.Content:Dock( FILL )

	self.Items = {}

end

function PANEL:UseButtonOnlyStyle()
	self.ButtonOnly = true
end

function PANEL:AddSheet( panel, label, click_func )

	if ( !IsValid( panel ) ) then return end

	local Sheet = {}
	Sheet.Button = vgui.Create( "DButton", self.Navigation )
	Sheet.Button.Target = panel
	Sheet.Button:Dock( LEFT )
	Sheet.Button:DockMargin( 20, 0, 0, 0 )
	Sheet.Button:SetText( "" )
	surface.SetFont( "BCS_Roboto_21" )
	local TextX, TextY = surface.GetTextSize( label )
	Sheet.Button:SetWide( TextX+0 )
	Sheet.Button.PageLabel = label
	local Alpha = 0
	Sheet.Button.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() and !self2.m_bSelected ) then
			Alpha = math.Clamp( Alpha+5, 0, 225 )
		elseif( self2:IsDown() || self2.m_bSelected ) then
			Alpha = math.Clamp( Alpha+10, 0, 255 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 255 )
		end

		draw.SimpleText( label, "BCS_Roboto_21", w/2, h/2, Color( 0, 0, 0, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( label, "BCS_Roboto_21", w/2, h/2, Color( 255, 255, 255, Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	Sheet.Button.DoClick = function()
		self:SetActiveButton( Sheet.Button )

		if( click_func ) then
			click_func()
		end
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

function PANEL:SetActivePage( page )
	for k, v in pairs( self.Items ) do
		if( v.Button and v.Button.PageLabel ) then
			if( v.Button.PageLabel == page ) then
				self:SetActiveButton( v.Button )
			end
		end
	end
end

derma.DefineControl( "brickscrafting_vgui_colsheet_top", "", PANEL, "Panel" )
