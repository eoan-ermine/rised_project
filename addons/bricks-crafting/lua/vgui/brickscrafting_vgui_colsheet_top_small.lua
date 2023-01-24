-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_colsheet_top_small.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

local PANEL = {}

AccessorFunc( PANEL, "ActiveButton", "ActiveButton" )

function PANEL:Init()

	self.Navigation = vgui.Create( "DComboBox", self )
	self.Navigation:Dock( TOP )
	self.Navigation:DockMargin( 0, 0, 37+13, 0 )
	self.Navigation:SetTall( 30 )
	self.Navigation:SetFont( "BCS_Roboto_21" )
	self.Navigation.Paint = function( self2, w, h )
		surface.SetDrawColor( 0, 128, 181, 255 )
		surface.DrawRect( 0, 0, w, h )
	end
	self.Navigation.OnSelect = function( self2, index, text, data )

		self:SetActiveButton( data )
	
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

	Sheet.Panel = panel
	Sheet.Panel:SetParent( self.Content )
	Sheet.Panel:SetVisible( false )

	Sheet.Target = panel

	Sheet.Button = self.Navigation:AddChoice( label, Sheet )

	table.insert( self.Items, Sheet )

	if ( not self.ActiveButton ) then
		self:SetActiveButton( Sheet )
		self.Navigation:SetValue( label )
	end
	
	return Sheet
end

function PANEL:SetActiveButton( active )

	if ( self.ActiveButton == active ) then return end

	if ( self.ActiveButton && self.ActiveButton.Target ) then
		self.ActiveButton.Target:SetVisible( false )
	end

	self.ActiveButton = active
	active.Target:SetVisible( true )

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

derma.DefineControl( "brickscrafting_vgui_colsheet_top_small", "", PANEL, "Panel" )
