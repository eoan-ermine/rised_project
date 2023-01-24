-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_bench.lua"
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
	self.MenuBack = vgui.Create( "DPanel", self )
	local HeaderH = 50
	self.MenuBack:SetSize( (815/1920)*ScrW(), (685/1080)*ScrH()+HeaderH )
	self.MenuBack:SetPos( -self.MenuBack:GetWide(), (ScrH()/2)-(self.MenuBack:GetTall()/2) )
	self.MenuBack:MoveTo( (ScrW()/2)-(self.MenuBack:GetWide()/2), (ScrH()/2)-(self.MenuBack:GetTall()/2), 0.25, 0, 1 )
	local HeaderPoly = {
		{ x = 0, y = 0 },
		{ x = 220, y = 0 },
		{ x = 220+50, y = HeaderH },
		{ x = 0, y = HeaderH }
	}
	local CraftingMat = BCS_DRAWING.GetMaterial( "IconCrafting" )
	self.MenuBack.Paint = function( self2, w, h )
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
		surface.SetMaterial( CraftingMat )
		local Spacing = 10
		surface.DrawTexturedRect( 10+Spacing, 10+Spacing, 50-(2*Spacing), 50-(2*Spacing) )

		draw.SimpleText( BRICKSCRAFTING.L("vguiNPCHeader"), "BCS_Roboto_40", 10+50+20, 10+(50/2), Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
	end

	--[[ Close Button ]]--
	local CloseButton = vgui.Create( "DButton", self.MenuBack )
	CloseButton:SetSize( 32, 32 )
	CloseButton:SetPos( self.MenuBack:GetWide()-17-CloseButton:GetWide(), HeaderH+13 )
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
		local X, Y = (ScrW()/2)-(self.MenuBack:GetWide()/2), (ScrH()/2)-(self.MenuBack:GetTall()/2)
		if( IsValid( self.InvBack ) ) then
			self.InvBack:MoveTo( ScrW()+self.InvBack:GetWide(), Y+HeaderH+((self.MenuBack:GetTall()-HeaderH)/2)-(self.InvBack:GetTall()/2), 0.25, 0, 1, function() end )
		end
		self.MenuBack:MoveTo( -self.MenuBack:GetWide(), (ScrH()/2)-(self.MenuBack:GetTall()/2), 0.25, 0, 1, function() 
			self:Remove()
		end )
	end

	--[[ Hint Button ]]--
	local NPCFindHint = vgui.Create( "DButton", self.MenuBack )
	NPCFindHint:SetSize( 32, 32 )
	NPCFindHint:SetPos( self.MenuBack:GetWide()-17-CloseButton:GetWide()-10-NPCFindHint:GetWide(), HeaderH+13 )
	NPCFindHint:SetText( "" )
	NPCFindHint:SetToolTip( BRICKSCRAFTING.L("vguiBenchHint") )
	local CloseMat = BCS_DRAWING.GetMaterial( "IconHint" )
	local Alpha = 0
	NPCFindHint.Paint = function( self2, w, h )
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
	NPCFindHint.DoClick = function()
		if( BCS_HighlightNPC != true ) then
			BCS_HighlightNPC = true
			notification.AddLegacy( BRICKSCRAFTING.L("vguiBenchNPCHighlight"), 0, 5 )
		end
	end

	--[[ SEARCH BAR ]]--
	local SearchBarBack = vgui.Create( "DPanel", self.MenuBack )
	SearchBarBack:Dock( TOP )
	SearchBarBack:SetTall( 50 )
	SearchBarBack:DockMargin( 23, 105, 485*(ScrW()/1920), 0 )
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
		self:RefreshBCS()
	end

	self.SkillProgress = vgui.Create( "DPanel", self.MenuBack )
	self.SkillProgress:Dock( TOP )
	self.SkillProgress:DockMargin( 23, 25, 53, 0 )
	self.SkillProgress:SetTall( 30 )
	local SkillLevel = 0
	self.SkillProgress.Paint = function( self2, w, h )
		if( not self.BenchType or not BRICKSCRAFTING.CONFIG.Crafting[self.BenchType] ) then return end

		local SkillTable = BRICKSCRAFTING.CONFIG.Crafting[self.BenchType].Skill
		SkillLevel = Lerp( FrameTime()*5, SkillLevel, LocalPlayer():GetBCS_SkillLevel( self.BenchType ) )
		
		surface.SetDrawColor( 0, 128, 181, 100 )
		surface.DrawRect( 0, 0, w, h )		
		
		surface.SetDrawColor( 0, 128, 181 )
		surface.DrawRect( 0, 0, math.Clamp( w*(SkillLevel/SkillTable[2]), 0, w ), h )
		
		draw.SimpleText( SkillTable[1], "BCS_Roboto_18", 15, h/2, Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
		draw.SimpleText( math.Clamp( LocalPlayer():GetBCS_SkillLevel( self.BenchType ), 0, SkillTable[2] ) .. "/" .. SkillTable[2], "BCS_Roboto_18", w-15, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
	end

	--[[ SCROLL ]]--
	self.Scroll = vgui.Create( "brickscrafting_scrollpanel", self.MenuBack )
	self.Scroll:Dock( FILL )
	self.Scroll:DockMargin( 0, 5, 20, 40 )

	--[[ INVENTORY ]]--
	self.InvBack = vgui.Create( "DPanel", self )
	self.InvBack:SetSize( (415/1920)*ScrW(), (600/1080)*ScrH() )
	local X, Y = (ScrW()/2)-(self.MenuBack:GetWide()/2), (ScrH()/2)-(self.MenuBack:GetTall()/2)
	self.InvBack:SetPos( ScrW()+self.InvBack:GetWide(), Y+HeaderH+((self.MenuBack:GetTall()-HeaderH)/2)-(self.InvBack:GetTall()/2) )
	self.InvBack:MoveTo( X+self.MenuBack:GetWide()+20, Y+HeaderH+((self.MenuBack:GetTall()-HeaderH)/2)-(self.InvBack:GetTall()/2), 0.25, 0, 1 )
	self.InvBack.Paint = function( self2, w, h )
		surface.SetDrawColor( 24, 25, 34 )
		surface.DrawRect( 0, 0, w, h )
	end	

	self:RefreshInv()
end

function PANEL:RefreshInv()
	if( not BRICKSCRAFTING.CONFIG.Crafting[self.BenchType] ) then return end

	local SkillTable = BRICKSCRAFTING.CONFIG.Crafting[self.BenchType].Skill
	if( not SkillTable or not SkillTable[2] or SkillTable[2] <= 0 ) then
		if( IsValid( self.SkillProgress ) ) then
			self.SkillProgress:Remove()
			self.Scroll:DockMargin( 0, 5+25, 20, 40 )
		end
	end

	self.InvBack:Clear()
	
	--[[ RESOURCES ]]--
	self.ItemResBack = vgui.Create( "brickscrafting_scrollpanel", self.InvBack )
	self.ItemResBack:Dock( LEFT )
	self.ItemResBack:DockMargin( 12, 12, 12, 12 )
	local ItemWide = 48
	local ExtraEdge = 5
	self.ItemResBack:SetWide( ItemWide+(2*ExtraEdge) )
	self.ItemResBack:GetVBar():SetWide( 0 )
	self.ItemResBack.Paint = function( self2, w, h ) end
	
	for key, val in pairs( BRICKSCRAFTING.CONFIG.Resources ) do
		local ItemResEntry = vgui.Create( "DPanel", self.ItemResBack )
		ItemResEntry:Dock( TOP )
		ItemResEntry:DockMargin( 0, 0, 0, 10 )
		ItemResEntry:SetTall( ItemWide+(2*ExtraEdge) )	
		ItemResEntry:SetTooltip( key )
		local ResMat = Material( val.icon, "noclamp smooth" )
		ItemResEntry.Paint = function( self2, w, h )
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

			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( ResMat )
			local Spacing = 10
			surface.DrawTexturedRect( ExtraEdge+Spacing, ExtraEdge+Spacing, w-(2*ExtraEdge)-(2*Spacing), h-(2*ExtraEdge)-(2*Spacing) )

			draw.SimpleText( string.Comma((LocalPlayer():GetBCS_Inventory().Resources or {})[key] or 0), "BCS_Roboto_17", w-ExtraEdge+5, ExtraEdge, Color( 0, 128, 181 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		end
	end
	
	local Scroll = vgui.Create( "brickscrafting_scrollpanel", self.InvBack )
	Scroll:Dock( FILL )
	Scroll:DockMargin( 0, 0, 20, 40 )

	local List = vgui.Create( "DIconLayout", Scroll )
	List:Dock( FILL )
	local Spacing = 10
	List:SetBorder( Spacing )
	List:SetSpaceX( Spacing )
	List:SetSpaceY( Spacing )
	
	local ItemWide = 3
	local Size = (self.InvBack:GetWide()-20-((ItemWide+1)*Spacing))/ItemWide-10
	
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
				InvItemButton:SetToolTip( BRICKSCRAFTING.L("vguiBenchName") .. ItemTable.Name .. BRICKSCRAFTING.L("vguiBenchDescription") .. ItemTable.Description )	
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
				local ScrollY, ScrollH = InvY+24+98, self.InvBack:GetTall()-40-24-98
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
			end
		end
	end
end

function PANEL:RefreshBCS()
	if( not BRICKSCRAFTING.CONFIG.Crafting[self.BenchType] ) then return end
	if( not BRICKSCRAFTING.CONFIG.Crafting[self.BenchType].Items ) then return end
	self.Scroll:Clear()

	local ScrollY, ScrollH = (ScrH()/2)-(self.MenuBack:GetTall()/2)+215, self.MenuBack:GetTall()-255
	
	for k, v in pairs( BRICKSCRAFTING.CONFIG.Crafting[self.BenchType].Items ) do
		if( v.Cost or v.Skill ) then
			local MiscTable = LocalPlayer():GetBCS_MiscTable()
			if( not MiscTable or not MiscTable.LearntCrafts or not MiscTable.LearntCrafts[self.BenchType] or not table.HasValue( MiscTable.LearntCrafts[self.BenchType], k ) ) then
				continue
			end
		end

		if( self.SearchBar:GetValue() != BRICKSCRAFTING.L("vguiSearch") ) then
			if( not string.find( string.lower( v.Name ), string.lower( self.SearchBar:GetValue() ) ) ) then continue end
		end

		local ItemEntry = vgui.Create( "DPanel", self.Scroll )
		ItemEntry:Dock( TOP )
		ItemEntry:DockMargin( 23, 10, 20, 10 )
		ItemEntry:SetTall( 115 )
		ItemEntry.Paint = function( self2, w, h )
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
			
			draw.SimpleText( v.Name, "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
			draw.SimpleText( v.Description, "BCS_Roboto_16", h+20, 52, Color( 255, 255, 255 ), 0, 0 )
		end

		local ResourceBack = vgui.Create( "DPanel", ItemEntry )
		ResourceBack:SetPos( ItemEntry:GetTall()+20, 73 )
		surface.SetFont( "BCS_Roboto_16" )
		local TextX, TextY = surface.GetTextSize( "Iron: 96" )
		ResourceBack:SetSize( 1000, TextY )
		ResourceBack.Paint = function( self2, w, h ) end

		for key, val in pairs( v.Resources ) do
			if( val <= 0 ) then continue end

			if( BRICKSCRAFTING.CONFIG.Resources[key] ) then
				local ResourceEntry = vgui.Create( "DLabel", ResourceBack )
				ResourceEntry:SetFont( "BCS_Roboto_16" )
				ResourceEntry:SetText( key .. ": " .. string.Comma( val ) )
				ResourceEntry:SetTextColor( Color( 255, 255, 255 ) )
				ResourceEntry:Dock( LEFT )
				ResourceEntry:DockMargin( 0, 0, 10, 0 )
				ResourceEntry:SizeToContents()
			end
		end
		
		local InvItemIcon = vgui.Create( "DModelPanel", ItemEntry )
		InvItemIcon:Dock( LEFT )
		InvItemIcon:SetWide( ItemEntry:GetTall() )
		InvItemIcon:SetModel( v.model )		
		local mn, mx = InvItemIcon.Entity:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
		size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
		size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

		InvItemIcon:SetFOV( 45 )
		InvItemIcon:SetCamPos( Vector( size, size, size ) )
		InvItemIcon:SetLookAt( ( mn + mx ) * 0.5 )
		function InvItemIcon:LayoutEntity( Entity ) return end

		local ResourceString = ""
		for key, val in pairs( v.Resources ) do
			if( BRICKSCRAFTING.CONFIG.Resources[key] ) then
				if( ResourceString != "" ) then
					ResourceString = ResourceString .. "\n" .. key .. ": " .. val
				else
					ResourceString = ResourceString .. key .. ": " .. val
				end
			end
		end
		InvItemIcon:SetToolTip( ResourceString )
		
		local ItemCraftButton = vgui.Create( "DButton", ItemEntry )
		ItemCraftButton:Dock( RIGHT )
		ItemCraftButton:SetWide( ItemEntry:GetTall() )
		ItemCraftButton:SetText( "" )
		local Alpha = 0
		ItemCraftButton.Paint = function( self2, w, h )
			surface.SetDrawColor( 18, 18, 29 )
			surface.DrawRect( 0, 0, w, h )

			if( self2:IsHovered() and !self2:IsDown() ) then
				Alpha = math.Clamp( Alpha+5, 0, 100 )
			elseif( self2:IsDown() ) then
				Alpha = math.Clamp( Alpha+10, 0, 200 )
			else
				Alpha = math.Clamp( Alpha-5, 0, 100 )
			end

			surface.SetDrawColor( 10, 10, 20, Alpha )
			surface.DrawRect( 0, 0, w, h )
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiBenchCraft"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		ItemCraftButton.DoClick = function()
			net.Start( "BCS_Net_CraftItem" )
				net.WriteString( self.BenchType )
				net.WriteInt( k, 32 )
			net.SendToServer()
		end
	end
end

function PANEL:Paint( w, h )
end

vgui.Register( "brickscrafting_vgui_bench", PANEL, "DFrame" )