-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_npc_shop.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local PANEL = {}

function PANEL:Init()
	local Scroll = vgui.Create( "brickscrafting_scrollpanel", self )
	Scroll:Dock( FILL )
	Scroll:DockMargin( 0, 0, 0, 0 )

	local InvX, InvY = 0, (ScrH()/2)-(((710/1080)*ScrH()+50)/2)
	local ScrollY, ScrollH = InvY+185, ((710/1080)*ScrH()+50)-200-50

	function self:RefreshResources()
		Scroll:Clear()

		for k, v in pairs( BRICKSCRAFTING.CONFIG.Resources ) do
			if( not v.Price ) then continue end

			if( IsValid( self.SearchBar ) ) then
				if( not string.find( string.lower( k ), string.lower( self.SearchBar:GetValue() ) ) ) then continue end
			end

			local SellAmount = 0
			local ResourceEntry = Scroll:Add( "DPanel" )
			ResourceEntry:Dock( TOP )
			ResourceEntry:DockMargin( 0, 0, 37, 10 )
			local ExtraEdge = 5
			ResourceEntry:SetTall( 55 )
			local ResMat = Material( v.icon, "noclamp smooth" )
			ResourceEntry.Paint = function( self2, w, h )
				draw.SimpleText( string.Comma(SellAmount or 0), "BCS_Roboto_17", h-ExtraEdge+5, ExtraEdge, Color( 0, 128, 181 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
			end	

			local SellResourceButton = vgui.Create( "DButton", ResourceEntry )
			SellResourceButton:Dock( RIGHT )
			SellResourceButton:DockMargin( 0, 0, 0, 0 )
			SellResourceButton:SetWide( 150 )
			SellResourceButton:SetText( "" )
			local Alpha = 0
			SellResourceButton.Paint = function( self2, w, h )
				if( self2:IsHovered() and !self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+5, 0, 100 )
				elseif( self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 200 )
				else
					Alpha = math.Clamp( Alpha-5, 0, 100 )
				end
				
				if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
					BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
					local x, y = self2:LocalToScreen( 0, 0 )
					surface.SetDrawColor( 30, 30, 44 )
					surface.DrawRect( x, y, w, h )			
					BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )
				else
					surface.SetDrawColor( 30, 30, 44 )
					surface.DrawRect( 0, 0, w, h )	
				end
		
				surface.SetDrawColor( 20, 20, 30, Alpha )
				surface.DrawRect( 0, 0, w, h )
				
				draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiNPCShopSellFor"), string.Comma( SellAmount ), DarkRP.formatMoney( SellAmount*v.Price ) ), "BCS_Roboto_16", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			SellResourceButton.DoClick = function()
				if( SellAmount > 0 and SellAmount <= ((LocalPlayer():GetBCS_Inventory().Resources or {})[k] or 0 ) ) then
					net.Start( "BCS_Net_SellResources" )
						net.WriteString( k )
						net.WriteInt( SellAmount, 32 )
					net.SendToServer()
				end
			end

			local DermaNumSlider = vgui.Create( "brickscrafting_numslider", ResourceEntry )
			DermaNumSlider:Dock( FILL )
			DermaNumSlider:DockMargin( ResourceEntry:GetTall()+40, 0, 40, 0 )
			DermaNumSlider:SetText( "" )
			DermaNumSlider:SetMinMax( 0, (LocalPlayer():GetBCS_Inventory().Resources or {})[k] or 0 )
			DermaNumSlider:SetDecimals( 0 )
			DermaNumSlider:SetDark( false )
			DermaNumSlider.OnValueChanged = function( self2, val )
				SellAmount = math.floor( val )
			end
			
			local ResourceEntryIcon = vgui.Create( "DPanel", ResourceEntry )
			ResourceEntryIcon:SetPos( 0, 0 )
			ResourceEntryIcon:SetSize( ResourceEntry:GetTall(), ResourceEntry:GetTall() )
			ResourceEntryIcon:SetToolTip( k )
			ResourceEntryIcon.Paint = function( self2, w, h ) 
				if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
					BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
					surface.SetDrawColor( 30, 30, 44 )
					local x, y = self2:LocalToScreen( 0, 0 )
					surface.DrawRect( x, y, w, h )
					BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 5, false )
				else
					surface.SetDrawColor( 30, 30, 44 )
					surface.DrawRect( 0, 0, w, h )
				end

				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial( ResMat )
				local Spacing = 10
				surface.DrawTexturedRect( Spacing, Spacing, h-(2*Spacing), h-(2*Spacing) )
			end
		end
	end
	self:RefreshResources()
end

function PANEL:SetSearchBar( srchBar )
	self.SearchBar = srchBar
	srchBar.OnTextChanged = function( text )
		self:RefreshResources()
	end
end

function PANEL:Paint( w, h )
end

vgui.Register( "brickscrafting_vgui_npc_shop", PANEL, "DPanel" )