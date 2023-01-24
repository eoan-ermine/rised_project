-- "addons\\bricks-crafting\\lua\\vgui\\bcs_vgui_admin_resources.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local PANEL = {}

function PANEL:Init()
	self:SetSize( (330/1920)*ScrW(), (480/1080)*ScrH() )

	local X, Y = (ScrW()/2)-(BCS_AdminMenu.MenuBack:GetWide()/2), (ScrH()/2)-(BCS_AdminMenu.MenuBack:GetTall()/2)
	self:SetPos( ScrW(), Y+50+((BCS_AdminMenu.MenuBack:GetTall()-50)/2)-(self:GetTall()/2) )
	self:MoveTo( X+BCS_AdminMenu.MenuBack:GetWide()+30, Y+50+((BCS_AdminMenu.MenuBack:GetTall()-50)/2)-(self:GetTall()/2), 0.1, 0, 1 )

	local BottomButtonsBack = vgui.Create( "DPanel", self )
	BottomButtonsBack:Dock( BOTTOM )
	local Spacing = 10
	BottomButtonsBack:DockMargin( Spacing, 0, Spacing, Spacing )
	BottomButtonsBack:SetTall( 30 )
	BottomButtonsBack.Paint = function( self2, w, h ) end

	local MenuCloseButton = vgui.Create( "DButton", BottomButtonsBack )
	MenuCloseButton:Dock( RIGHT )
	MenuCloseButton:SetWide( self:GetWide()/3 )
	MenuCloseButton:SetText( "" )
	local Alpha = 0
	MenuCloseButton.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 0, 100 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 0, 200 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 100 )
		end

		BCS_BSHADOWS.BeginShadow()
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )

		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( 0, 0, w, h )
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiCancel"), "BCS_Roboto_16", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	MenuCloseButton.DoClick = function()
		self:SetKeyboardInputEnabled( false )
		self:SetMouseInputEnabled( false )
		self:MoveTo( ScrW(), Y+50+((BCS_AdminMenu.MenuBack:GetTall()-50)/2)-(self:GetTall()/2), 0.1, 0, 1, function() 
			self:Remove()
		end )
	end

	local AssignResourceButton = vgui.Create( "DButton", BottomButtonsBack )
	AssignResourceButton:Dock( LEFT )
	AssignResourceButton:SetWide( (self:GetWide()-(3*Spacing))-MenuCloseButton:GetWide() )
	AssignResourceButton:SetText( "" )
	local Alpha = 0
	AssignResourceButton.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 0, 100 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 0, 200 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 100 )
		end

		BCS_BSHADOWS.BeginShadow()
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )

		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( 0, 0, w, h )
		
		local ply = player.GetBySteamID64( self.Receiver or "" )
		if( IsValid( ply ) ) then
			draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiResourcesAssign"), ply:Nick() ), "BCS_Roboto_16", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		else
			draw.SimpleText( BRICKSCRAFTING.L("vguiResourcesNoUser"), "BCS_Roboto_16", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end

	local Scroll = vgui.Create( "brickscrafting_scrollpanel", self )
	Scroll:Dock( FILL )
	Scroll:DockMargin( 25, 25, 25, 25 )

	local ResourcesToGive = {}

	for k, v in pairs( BRICKSCRAFTING.CONFIG.Resources ) do
		local ResourceEntry = Scroll:Add( "DPanel" )
		ResourceEntry:Dock( TOP )
		local ExtraEdge = 5
		ResourceEntry:SetTall( 55+(2*ExtraEdge) )
		local ResMat = Material( v.icon, "noclamp smooth" )
		ResourceEntry.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( ExtraEdge, ExtraEdge )
			surface.DrawRect( x, y, h-(2*ExtraEdge), h-(2*ExtraEdge) )
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 5, false )

			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( ResMat )
			local Spacing = 10
			surface.DrawTexturedRect( ExtraEdge+Spacing, ExtraEdge+Spacing, h-(2*ExtraEdge)-(2*Spacing), h-(2*ExtraEdge)-(2*Spacing) )

			draw.SimpleText( string.Comma(ResourcesToGive[k] or 0), "BCS_Roboto_17", h-ExtraEdge+5, ExtraEdge, Color( 0, 128, 181 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		end	

		local DermaNumSlider = vgui.Create( "brickscrafting_numslider", ResourceEntry )
		DermaNumSlider:Dock( FILL )
		DermaNumSlider:DockMargin( ResourceEntry:GetTall()+20, 0, 20, 0 )
		DermaNumSlider:SetText( "" )
		DermaNumSlider:SetMinMax( 0, BRICKSCRAFTING.LUACONFIG.Defaults.ResorceAddMax )
		DermaNumSlider:SetDecimals( 0 )
		DermaNumSlider:SetDark( false )
		DermaNumSlider.OnValueChanged = function( self2, val )
			ResourcesToGive[k] = math.Round( val )
		end
		
		local ResourceEntryIcon = vgui.Create( "DPanel", ResourceEntry )
		ResourceEntryIcon:SetPos( 0, 0 )
		ResourceEntryIcon:SetSize( ResourceEntry:GetTall(), ResourceEntry:GetTall() )
		ResourceEntryIcon:SetToolTip( k )
		ResourceEntryIcon.Paint = function() end
	end

	AssignResourceButton.DoClick = function()
		if( self.Receiver and isstring( self.Receiver ) and table.Count( ResourcesToGive ) > 0 ) then
			net.Start( "BCS_Net_AssignResources" )
				net.WriteString( self.Receiver or "" )
				net.WriteTable( ResourcesToGive )
			net.SendToServer()

			self:SetKeyboardInputEnabled( false )
			self:SetMouseInputEnabled( false )
			self:MoveTo( ScrW(), Y+50+((BCS_AdminMenu.MenuBack:GetTall()-50)/2)-(self:GetTall()/2), 0.1, 0, 1, function() 
				self:Remove()
			end )
		else
			notification.AddLegacy( BRICKSCRAFTING.L("vguiResourcesInvalidPly"), 1, 5 )
		end
	end
end

function PANEL:SetReceiver( SteamID64 )
	self.Receiver = SteamID64
end

function PANEL:Paint( w, h )
	surface.SetDrawColor( 24, 25, 34 )
	surface.DrawRect( 0, 0, w, h )
end

vgui.Register( "bcs_vgui_admin_resources", PANEL, "DPanel" )