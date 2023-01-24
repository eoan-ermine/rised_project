-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_storage.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local PANEL = {}

function PANEL:Init()
	self:SetSize( ScrW(), ScrH() )
	self:SetPos( 0, 0 )
	self:MakePopup()
	self:SetTitle( "" )
	self:ShowCloseButton( false )
	self:SetDraggable( false )

	--[[ INVENTORY ]]--
	self.InvBack = vgui.Create( "DPanel", self )
	local HeaderH = 50
	self.InvBack:SetSize( (900/1920)*ScrW(), (710/1080)*ScrH()+HeaderH )
	self.InvBack:SetPos( -self.InvBack:GetWide(), (ScrH()/2)-(self.InvBack:GetTall()/2) )
	self.InvBack:MoveTo( (ScrW()/2)-(self.InvBack:GetWide()/2), (ScrH()/2)-(self.InvBack:GetTall()/2), 0.25, 0, 1 )
	local HeaderPoly = {
		{ x = 0, y = 0 },
		{ x = 220, y = 0 },
		{ x = 220+50, y = HeaderH },
		{ x = 0, y = HeaderH }
	}
	local BackpackMat = BCS_DRAWING.GetMaterial( "IconBackpack" )
	self.InvBack.Paint = function( self2, w, h )
		surface.SetDrawColor( 24, 25, 34 )
		surface.DrawRect( 0, HeaderH, w, h-HeaderH )

		-- Header
		surface.SetDrawColor( 24, 25, 34 )
		draw.NoTexture()
		surface.DrawPoly( HeaderPoly )

		if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 10, 10 )
			surface.DrawRect( x, y, 50, 50 )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 5, false )
		else
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 10, 10, 50, 50 )
		end

		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( BackpackMat )
		local Spacing = 10
		surface.DrawTexturedRect( 10+Spacing, 10+Spacing, 50-(2*Spacing), 50-(2*Spacing) )

		draw.SimpleText( BRICKSCRAFTING.L("vguiStorage"), "BCS_Roboto_40", 10+50+20, 10+(50/2), Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
	end

	--[[ Close Button ]]--
	local CloseButton = vgui.Create( "DButton", self.InvBack )
	CloseButton:SetSize( 32, 32 )
	CloseButton:SetPos( self.InvBack:GetWide()-17-CloseButton:GetWide(), HeaderH+13 )
	CloseButton:SetText( "" )
	local CloseMat = BCS_DRAWING.GetMaterial( "IconCross" )
	local Alpha = 0
	CloseButton.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 0, 100 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 0, 200 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 100 )
		end
		
		if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
			BCS_BSHADOWS.BeginShadow()
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, w, 5, false )
		else
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 0, 0, w, h )	
		end

		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( 0, 0, w, h )

		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( CloseMat )
		local Spacing = 10
		surface.DrawTexturedRect( Spacing, Spacing, w-(2*Spacing), h-(2*Spacing) )
	end
	CloseButton.DoClick = function()
		self:SetKeyboardInputEnabled( false )
		self:SetMouseInputEnabled( false )
		self.InvBack:MoveTo( -self.InvBack:GetWide(), (ScrH()/2)-(self.InvBack:GetTall()/2), 0.25, 0, 1, function() 
			self:Remove()
		end )
	end

	--[[ RESOURCES ]]--
	self.ItemResBack = vgui.Create( "brickscrafting_scrollpanel", self.InvBack )
	self.ItemResBack:Dock( LEFT )
	self.ItemResBack:DockMargin( 0, 180, 0, 40 )
	local ItemWide = 54
	local ExtraEdge = 10
	self.ItemResBack:SetWide( ItemWide+20+20 )
	self.ItemResBack:GetVBar():SetWide( 0 )
	self.ItemResBack.Paint = function( self2, w, h ) end

	for key, val in pairs( BRICKSCRAFTING.CONFIG.Resources ) do
		local ItemResEntry = vgui.Create( "DButton", self.ItemResBack )
		ItemResEntry:Dock( TOP )
		ItemResEntry:DockMargin( 20-ExtraEdge, 0, 20-ExtraEdge, 0 )
		ItemResEntry:SetTall( ItemWide+(2*ExtraEdge) )	
		ItemResEntry:SetTooltip( key )
		ItemResEntry:SetText( "" )
		local ResMat = Material( val.icon, "noclamp smooth" )
		local Alpha = 0
		ItemResEntry.Paint = function( self2, w, h )
			if( self2:IsHovered() and !self2:IsDown() ) then
				Alpha = math.Clamp( Alpha+5, 0, 100 )
			elseif( self2:IsDown() ) then
				Alpha = math.Clamp( Alpha+10, 0, 200 )
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

			draw.SimpleText( string.Comma((LocalPlayer():GetBCS_Inventory().Resources or {})[key] or 0), "BCS_Roboto_17", w-ExtraEdge+5, ExtraEdge, Color( 0, 128, 181 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		end
		ItemResEntry.DoClick = function()
			if( ((LocalPlayer():GetBCS_Inventory().Resources or {})[key] or 0) > 0 ) then
				BCS_DRAWING.SliderRequest( BRICKSCRAFTING.L("vguiStorageDropResource"), string.format( BRICKSCRAFTING.L("vguiStorageDrop"), key ), 0, ((LocalPlayer():GetBCS_Inventory().Resources or {})[key] or 0), function( text ) 
					text = tonumber( text )
					if( isnumber( text ) and text > 0 and text <= ((LocalPlayer():GetBCS_Inventory().Resources or {})[key] or 0) ) then
						net.Start( "BCS_Net_DropResource" )
							net.WriteString( key )
							net.WriteInt( text, 32 )
						net.SendToServer()
					end
				end, function() end, "Drop", "Cancel" )
			end
		end
	end

	--[[ SEARCH BAR ]]--
	local SearchBarBack = vgui.Create( "DPanel", self.InvBack )
	SearchBarBack:Dock( TOP )
	SearchBarBack:SetTall( 50 )
	SearchBarBack:DockMargin( 12, 105, self.InvBack:GetWide()*0.4, 0 )
	local search = BCS_DRAWING.GetMaterial( "IconSearch" )
	local Alpha = 0
	local Alpha2 = 20
	SearchBarBack.Paint = function( self2, w, h )
		if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 5, false )
		else
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 0, 0, w, h )
		end

		if( self.SearchBar:IsEditing() ) then
			Alpha = math.Clamp( Alpha+5, 0, 100 )
			Alpha2 = math.Clamp( Alpha2+20, 20, 255 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 100 )
			Alpha2 = math.Clamp( Alpha2-20, 20, 255 )
		end
		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( 0, 0, w, h )
	
		surface.SetDrawColor( 255, 255, 255, Alpha2 )
		surface.SetMaterial(search)
		local size = h*0.35
		surface.DrawTexturedRect( w-size-(h-size)/2, (h-size)/2, size, size )
	end

	self.SearchBar = vgui.Create( "brickscrafting_search", SearchBarBack )
	self.SearchBar:Dock( FILL )
	self.SearchBar.OnTextChanged = function( text )
		self:RefreshInv()
	end

	--[[ SCROLL ]]--
	self.Scroll = vgui.Create( "brickscrafting_scrollpanel", self.InvBack )
	self.Scroll:Dock( FILL )
	self.Scroll:DockMargin( 0, 35, 36, 40 )

	self:RefreshInv()
end

function PANEL:RefreshInv()
	if( IsValid( self.Scroll ) ) then
		self.Scroll:Clear()
	end

	local List = vgui.Create( "DIconLayout", self.Scroll )
	List:Dock( FILL )
	local Spacing = 12
	List:SetBorder( Spacing )
	List:SetSpaceX( Spacing )
	List:SetSpaceY( Spacing )
	
	local ItemWide = 4
	local Size = ((self.InvBack:GetWide()-self.ItemResBack:GetWide()-36-13-((ItemWide-1)*Spacing)-(2*Spacing))/ItemWide)-5
	
	for key, val in pairs( LocalPlayer():GetBCS_Inventory() ) do
		if( key == "Resources" ) then continue end
	
		if( BRICKSCRAFTING.CONFIG.Crafting[val.BenchType] ) then
			if( BRICKSCRAFTING.CONFIG.Crafting[val.BenchType].Items[val.ItemKey] ) then
				local ItemTable = BRICKSCRAFTING.CONFIG.Crafting[val.BenchType].Items[val.ItemKey]

				if( not string.find( string.lower( ItemTable.Name ), string.lower( self.SearchBar:GetValue() ) ) ) then continue end
			
				local InvItemEntry = List:Add( "DPanel" )
				InvItemEntry:SetSize( Size, Size )
				
				local InvItemIcon = vgui.Create( "DModelPanel", InvItemEntry )
				InvItemIcon:Dock( FILL )
				InvItemIcon:SetModel( ItemTable.model )		
				local mn, mx = InvItemIcon.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
	
				InvItemIcon:SetFOV( 45 )
				InvItemIcon:SetCamPos( Vector( size, size, size ) )
				InvItemIcon:SetLookAt( ( mn + mx ) * 0.5 )
				function InvItemIcon:LayoutEntity( Entity ) return end
				
				local InvItemButton = vgui.Create( "DButton", InvItemIcon )
				InvItemButton:Dock( FILL )
				InvItemButton:SetText( "" )
				InvItemButton.Paint = function( self2, w, h )

				end
				InvItemButton.DoClick = function()
					local menu = DermaMenu()
					local Type = BRICKSCRAFTING.CONFIG.Crafting[val.BenchType].Items[val.ItemKey].Type
					if( BRICKSCRAFTING.CraftingTypes[Type] and BRICKSCRAFTING.CraftingTypes[Type].UseFunction ) then
						menu:AddOption( BRICKSCRAFTING.L("vguiBenchUse"), function() 
							net.Start( "BCS_Net_UseItem" )
								net.WriteInt( key, 32 )
							net.SendToServer()
						end )
					end
					if( BRICKSCRAFTING.CraftingTypes[Type] and BRICKSCRAFTING.CraftingTypes[Type].DropFunction ) then
						menu:AddOption( BRICKSCRAFTING.L("vguiBenchDrop"), function() 
							net.Start( "BCS_Net_DropItem" )
								net.WriteInt( key, 32 )
							net.SendToServer()
						end )
					end
					menu:Open()
				end

				local Alpha = 0
				local InvX, InvY = self.InvBack:GetPos()
				local ScrollY, ScrollH = InvY+200, self.InvBack:GetTall()-200-40
				InvItemEntry.Paint = function( self2, w, h )
					if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
						BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
						surface.SetDrawColor( 30, 30, 44 )
						local x, y = self2:LocalToScreen( 0, 0 )
						surface.DrawRect( x, y, w, h )
						BCS_BSHADOWS.EndShadow(1, 1, 1, 255, w, 2, true )
					else
						surface.SetDrawColor( 30, 30, 44 )
						surface.DrawRect( 0, 0, w, h )
					end

					surface.SetDrawColor( 30, 30, 44 )
					surface.DrawRect( 0, 0, w, h )

					if( InvItemButton:IsHovered() and !InvItemButton:IsDown() ) then
						Alpha = math.Clamp( Alpha+5, 0, 100 )
					elseif( InvItemButton:IsDown() ) then
						Alpha = math.Clamp( Alpha+10, 0, 200 )
					else
						Alpha = math.Clamp( Alpha-5, 0, 100 )
					end
					
					surface.SetDrawColor( 20, 20, 30, Alpha )
					surface.DrawRect( 0, 0, w, h )

					if( BRICKSCRAFTING.CONFIG.Rarity[ItemTable.Rarity or ""] ) then
						surface.SetDrawColor( BRICKSCRAFTING.CONFIG.Rarity[ItemTable.Rarity or ""].Color )
						surface.DrawOutlinedRect( 0, 0, w, h )
					end
				end

				local InvItemToolTip = vgui.Create( "DButton", InvItemButton )
				InvItemToolTip:Dock( BOTTOM )
				InvItemToolTip:SetText( "" )	
				InvItemToolTip:SetTall( 30 )
				InvItemToolTip:SetToolTip( BRICKSCRAFTING.L("vguiBenchName") .. ItemTable.Name .. BRICKSCRAFTING.L("vguiBenchDescription") .. ItemTable.Description )	
				InvItemToolTip.Paint = function( self2, w, h )
					surface.SetDrawColor( 0, 128, 181 )
					surface.DrawRect( w-50, 0, 50, h )

					local SideBit = {
						{ x = w-50-20, y = h },
						{ x = w-50, y = 0 },
						{ x = w-50, y = h },
					}
			
					surface.SetDrawColor( 0, 128, 181 )
					draw.NoTexture()
					surface.DrawPoly( SideBit )

					draw.SimpleText( BRICKSCRAFTING.L("vguiStorageInfo"), "BCS_Roboto_17", w-(70/2)+7, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
				InvItemToolTip.DoClick = function() end
			end
		end
	end
end

function PANEL:Paint( w, h )
end

vgui.Register( "brickscrafting_vgui_storage", PANEL, "DFrame" )