-- "addons\\bricks-crafting\\lua\\vgui\\bcs_vgui_admin_config.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local PANEL = {}

function PANEL:Init()
	BCS_ADMIN_CFG = table.Copy( BRICKSCRAFTING.CONFIG )
	
	local ColSheet = vgui.Create( "brickscrafting_vgui_colsheet_top", self )
	if( ScrW() < 1920 ) then
		ColSheet = vgui.Create( "brickscrafting_vgui_colsheet_top_small", self )
	end
	ColSheet:Dock( FILL )
	ColSheet.Paint = function( self, w, h ) end

	--[[ RARITY ]]--
	local RarityPage = vgui.Create( "DPanel", ColSheet )
	RarityPage:Dock( FILL )
	RarityPage.Paint = function( self, w, h ) end

	local NewRarityBack = vgui.Create( "DPanel", RarityPage )
	NewRarityBack:Dock( TOP )
	NewRarityBack:DockMargin( 0, 10, 37+13, 0 )
	NewRarityBack:SetTall( 125 )
	NewRarityBack.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow()
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 2, 2)
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigNewRarity"), "BCS_Roboto_25", 10, 10, Color( 255, 255, 255 ), 0, 0 )
	end

	local NewRarityTextEntry = vgui.Create( "brickscrafting_textentry", NewRarityBack )
	NewRarityTextEntry:Dock( LEFT )
	NewRarityTextEntry:DockMargin( 8, 40, 10, 25 )
	NewRarityTextEntry:SetWide( 150 )
	NewRarityTextEntry:SetText( BRICKSCRAFTING.L("vguiConfigRarityName") )
	NewRarityTextEntry:SetPaintBackground( false )

	local NewRarityColorMixer = vgui.Create( "DColorMixer", NewRarityBack )
	NewRarityColorMixer:Dock( FILL )
	NewRarityColorMixer:DockMargin( 50, 10, 10, 10 )
	NewRarityColorMixer:SetPalette( false )
	NewRarityColorMixer:SetAlphaBar( false )
	NewRarityColorMixer:SetWangs( true )
	NewRarityColorMixer:SetColor( Color( 30, 100, 160 ) )

	local function RefreshRarity()
		if( IsValid( RarityPage.Scroll ) ) then
			RarityPage.Scroll:Remove()
		end

		RarityPage.Scroll = vgui.Create( "brickscrafting_scrollpanel", RarityPage )
		RarityPage.Scroll:Dock( FILL )

		local List = vgui.Create( "DIconLayout", RarityPage.Scroll )
		List:Dock( FILL )
		List:DockMargin( 0, 10, 0, 0 )
		local Spacing = 10
		List:SetSpaceX( Spacing )
		List:SetSpaceY( Spacing )
		
		local ItemWide = 4
		local Size = (((900/1920)*ScrW())-94-35-37-13-((ItemWide-1)*Spacing))/ItemWide

		for k, v in pairs( BCS_ADMIN_CFG.Rarity ) do
			if( not string.find( string.lower( v.Name ), string.lower( self.SearchBarText or "" ) ) ) then continue end

			local RarityEntry = List:Add( "DButton" )
			RarityEntry:SetSize( Size, Size )
			RarityEntry:SetText( "" )
			local Alpha = 0
			RarityEntry.Paint = function( self2, w, h )
				surface.SetDrawColor( v.Color )
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
				
				draw.SimpleText( v.Name, "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			RarityEntry.DoClick = function()
				local menu = DermaMenu()
				menu:AddOption( BRICKSCRAFTING.L("vguiChangeName"), function()  
					BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiChangeName"), BRICKSCRAFTING.L("vguiNewNameQuestion"), v.Name, function( text ) 
						BCS_ADMIN_CFG.Rarity[k].Name = text
						BCS_ADMIN_CFG_CHANGED = true
						RefreshRarity()
					end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
				end )
				menu:AddOption( BRICKSCRAFTING.L("vguiRemove"), function()  
					BCS_ADMIN_CFG.Rarity[k] = nil
					BCS_ADMIN_CFG_CHANGED = true
					RefreshRarity()
				end )
				menu:Open()
			end
		end
	end
	RefreshRarity()

	local NewRarityButton = vgui.Create( "DButton", NewRarityBack )
	NewRarityButton:Dock( RIGHT )
	NewRarityButton:SetWide( 125 )
	NewRarityButton:SetText( "" )
	local Alpha = 0
	NewRarityButton.Paint = function( self2, w, h )
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
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigAddRarity"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	NewRarityButton.DoClick = function()
		local NewRarity = {}
		NewRarity.Name = NewRarityTextEntry:GetValue()
		NewRarity.Color = NewRarityColorMixer:GetColor()

		table.insert( BCS_ADMIN_CFG.Rarity, NewRarity )
		BCS_ADMIN_CFG_CHANGED = true
		RefreshRarity()
	end

	ColSheet:AddSheet( RarityPage, BRICKSCRAFTING.L("vguiConfigRarity") )

	--[[ Benches ]]--
	local BenchPage = vgui.Create( "DPanel", ColSheet )
	BenchPage:Dock( FILL )
	BenchPage.Paint = function( self, w, h ) end

	local BenchPageScroll = vgui.Create( "brickscrafting_scrollpanel", BenchPage )
	BenchPageScroll:Dock( FILL )

	local function RefreshBenches()
		BenchPageScroll:Clear()

		local AddNewItem = vgui.Create( "DButton", BenchPageScroll )
		AddNewItem:Dock( TOP )
		AddNewItem:DockMargin( 0, 10, 37, 0 )
		AddNewItem:SetTall( 115 )
		AddNewItem:SetText( "" )
		local Alpha = 0
		local InvX, InvY = 0, (ScrH()/2)-(((710/1080)*ScrH()+50)/2)
		local ScrollY, ScrollH = InvY+185+30, ((710/1080)*ScrH()+50)-185-65-30
		AddNewItem.Paint = function( self2, w, h )
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
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigNewBench"), "BCS_Roboto_25", w/2, h/2, Color( 255, 255, 255, 125+Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		AddNewItem.DoClick = function()
			local NewBench = {}
			BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigBenchID"), BRICKSCRAFTING.L("vguiConfigBenchIDEntry"), "newbench", function( benchID ) 
				if( not BCS_ADMIN_CFG.Crafting[benchID] ) then
					BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigBenchName"), BRICKSCRAFTING.L("vguiConfigBenchNameEntry"), "New Bench", function( benchName ) 
						NewBench.Name = benchName
						BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigBenchModel"), BRICKSCRAFTING.L("vguiConfigBenchModelEntry"), "models/brickscrafting/workbench_1.mdl", function( benchModel ) 
							NewBench.model = benchModel
							BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigBenchSkillName"), BRICKSCRAFTING.L("vguiConfigBenchSkillNameEntry"), "New Bench Crafting", function( benchSkillName ) 
								NewBench.Skill = {}
								NewBench.Skill[1] = benchSkillName
								BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigBenchMaxSkill"), BRICKSCRAFTING.L("vguiConfigBenchMaxSkillEntry"), 100, function( benchMaxSkill ) 
									if( isnumber( tonumber( benchMaxSkill ) ) ) then
										NewBench.Skill[2] = tonumber( benchMaxSkill )

										BCS_ADMIN_CFG.Crafting[benchID] = NewBench
										BCS_ADMIN_CFG_CHANGED = true
										RefreshBenches()
									else
										notification.AddLegacy( BRICKSCRAFTING.L("vguiConfigBenchMaxSkillNumber"), 1, 3 )
									end
								end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
							end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
						end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
					end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
				else
					notification.AddLegacy( BRICKSCRAFTING.L("vguiConfigBenchAlreadyBench"), 1, 3 )
				end
			end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
		end

		for k, v in pairs( BCS_ADMIN_CFG.Crafting ) do
			if( not string.find( string.lower( v.Name ), string.lower( self.SearchBarText or "" ) ) ) then continue end

			local ItemEntry = vgui.Create( "DPanel", BenchPageScroll )
			ItemEntry:Dock( TOP )
			ItemEntry:DockMargin( 0, 10, 37, 0 )
			ItemEntry:SetTall( 115 )
			local InvX, InvY = 0, (ScrH()/2)-(((710/1080)*ScrH()+50)/2)
			local ScrollY, ScrollH = InvY+185+30, ((710/1080)*ScrH()+50)-185-65-30
			ItemEntry.Paint = function( self2, w, h )
				BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
				surface.SetDrawColor( 30, 30, 44 )
				local x, y = self2:LocalToScreen( 0, 0 )
				surface.DrawRect( x, y, w, h )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )			

				draw.SimpleText( v.Name, "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
				draw.SimpleText( BRICKSCRAFTING.L("vguiConfigBenchSkill") .. " " .. v.Skill[1], "BCS_Roboto_16", h+20, 52, Color( 255, 255, 255 ), 0, 0 )
				draw.SimpleText( BRICKSCRAFTING.L("vguiConfigBenchMaxSkillLvl") .. " " .. v.Skill[2], "BCS_Roboto_16", h+20, 73, Color( 255, 255, 255 ), 0, 0 )
			end
			
			local InvItemIcon = vgui.Create( "DModelPanel", ItemEntry )
			InvItemIcon:Dock( LEFT )
			InvItemIcon:SetWide( ItemEntry:GetTall() )
			InvItemIcon:SetModel( v.model )		
			if( IsValid( InvItemIcon.Entity ) ) then
				local mn, mx = InvItemIcon.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

				InvItemIcon:SetFOV( 45 )
				InvItemIcon:SetCamPos( Vector( size, size, size ) )
				InvItemIcon:SetLookAt( ( mn + mx ) * 0.5 )
				function InvItemIcon:LayoutEntity( Entity ) return end
			end

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
				
				draw.SimpleText( BRICKSCRAFTING.L("vguiEdit"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ItemCraftButton.DoClick = function()
				if( not IsValid( BCS_AdminEditBench ) ) then
					BCS_AdminEditBench = vgui.Create( "brickscrafting_vgui_admin_editbench" ) 
					BCS_AdminEditBench:SetItemData( k )
					BCS_AdminEditBench.func_Close = function()
						RefreshBenches()
					end
				end
			end

			local ItemDeleteButton = vgui.Create( "DButton", ItemEntry )
			ItemDeleteButton:SetPos( 0, 0 )
			ItemDeleteButton:SetSize( ((900/1920)*ScrW())-94-35-37-13-ItemEntry:GetTall(), ItemEntry:GetTall() )
			ItemDeleteButton:SetText( "" )
			local Alpha = 0
			ItemDeleteButton.Paint = function( self2, w, h )
				if( self2:IsHovered() and !self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 150 )
				elseif( self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 240 )
				else
					Alpha = math.Clamp( Alpha-10, 0, 150 )
				end
	
				surface.SetDrawColor( 10, 10, 20, Alpha )
				surface.DrawRect( 0, 0, w, h )
				
				draw.SimpleText( BRICKSCRAFTING.L("vguiDelete"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255, Alpha*2 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ItemDeleteButton.DoClick = function()
				BCS_DRAWING.Query( BRICKSCRAFTING.L("vguiDeleteConfirm") .. "\n" .. BRICKSCRAFTING.L("vguiConfigBenchDeleteTip"), BRICKSCRAFTING.L("vguiDeleteConfirmation"), BRICKSCRAFTING.L("vguiConfirm"), function() 
					BCS_ADMIN_CFG.Crafting[k] = nil
					BCS_ADMIN_CFG_CHANGED = true
					RefreshBenches()
					self.RefreshItems()
				end, BRICKSCRAFTING.L("vguiCancel"), function() end )
			end
		end
	end
	RefreshBenches()

	ColSheet:AddSheet( BenchPage, BRICKSCRAFTING.L("vguiConfigBench") )

    --[[ Items ]]--
	local ItemPage = vgui.Create( "DPanel", ColSheet )
	ItemPage:Dock( FILL )
	ItemPage.Paint = function( self, w, h ) end

	local ItemPageScroll = vgui.Create( "brickscrafting_categorylist", ItemPage )
	ItemPageScroll:Dock( FILL )
	ItemPageScroll.Paint = function( self, w, h ) end

	function self.RefreshItems()
		ItemPageScroll:Clear()

		local AddNewItem = vgui.Create( "DButton", ItemPageScroll )
		AddNewItem:Dock( TOP )
		AddNewItem:DockMargin( 0, 10, 0, 0 )
		AddNewItem:SetTall( 115 )
		AddNewItem:SetText( "" )
		local Alpha = 0
		local InvX, InvY = 0, (ScrH()/2)-(((710/1080)*ScrH()+50)/2)
		local ScrollY, ScrollH = InvY+185+30, ((710/1080)*ScrH()+50)-185-65-30
		AddNewItem.Paint = function( self2, w, h )
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

			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 0, 0, w, h )	
	
			surface.SetDrawColor( 20, 20, 30, Alpha )
			surface.DrawRect( 0, 0, w, h )
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemNew"), "BCS_Roboto_25", w/2, h/2, Color( 255, 255, 255, 125+Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		AddNewItem.DoClick = function()
			if( not IsValid( BCS_AdminItemCreator ) ) then
				BCS_AdminItemCreator = vgui.Create( "brickscrafting_vgui_admin_additem" ) 
				BCS_AdminItemCreator.func_Close = function()
					self.RefreshItems()
				end
			end
		end

		for k, v in pairs( BCS_ADMIN_CFG.Crafting ) do
			if( not IsValid( ItemPageScroll[k] ) ) then
				ItemPageScroll[k] = ItemPageScroll:Add( k )
				ItemPageScroll[k]:DockMargin( 0, 10, 0, 0 )
			end

			if( BCS_ADMIN_CFG.Crafting[k].Items ) then
				for key, val in pairs( BCS_ADMIN_CFG.Crafting[k].Items ) do
					if( not string.find( string.lower( val.Name ), string.lower( self.SearchBarText or "" ) ) ) then continue end

					local ItemEntry = vgui.Create( "DPanel", ItemPageScroll[k] )
					ItemEntry:Dock( TOP )
					ItemEntry:DockMargin( 0, 10, 0, 0 )
					ItemEntry:SetTall( 115 )
					local InvX, InvY = 0, (ScrH()/2)-(((710/1080)*ScrH()+50)/2)
					local ScrollY, ScrollH = InvY+185+30, ((710/1080)*ScrH()+50)-185-65-30
					ItemEntry.Paint = function( self2, w, h )
						BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
						surface.SetDrawColor( 30, 30, 44 )
						local x, y = self2:LocalToScreen( 0, 0 )
						surface.DrawRect( x, y, w, h )			
						BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	

						surface.SetDrawColor( 30, 30, 44 )
						surface.DrawRect( 0, 0, w, h )	
		
						draw.SimpleText( val.Name, "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
						draw.SimpleText( val.Description, "BCS_Roboto_16", h+20, 52, Color( 255, 255, 255 ), 0, 0 )
					end
					
					local InvItemIcon = vgui.Create( "DModelPanel", ItemEntry )
					InvItemIcon:Dock( LEFT )
					InvItemIcon:SetWide( ItemEntry:GetTall() )
					InvItemIcon:SetModel( val.model )		
					if( IsValid( InvItemIcon.Entity ) ) then
						local mn, mx = InvItemIcon.Entity:GetRenderBounds()
						local size = 0
						size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
						size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
						size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
		
						InvItemIcon:SetFOV( 45 )
						InvItemIcon:SetCamPos( Vector( size, size, size ) )
						InvItemIcon:SetLookAt( ( mn + mx ) * 0.5 )
						function InvItemIcon:LayoutEntity( Entity ) return end
					end
		
					local ItemEditButton = vgui.Create( "DButton", ItemEntry )
					ItemEditButton:Dock( RIGHT )
					ItemEditButton:SetWide( ItemEntry:GetTall() )
					ItemEditButton:SetText( "" )
					local Alpha = 0
					ItemEditButton.Paint = function( self2, w, h )
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
						
						draw.SimpleText( BRICKSCRAFTING.L("vguiEdit"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
					end
					ItemEditButton.DoClick = function()
						if( not IsValid( BCS_AdminEditItem ) ) then
							BCS_AdminEditItem = vgui.Create( "brickscrafting_vgui_admin_edititem" ) 
							BCS_AdminEditItem:SetItemData( k, key )
							BCS_AdminEditItem.func_Close = function()
								self.RefreshItems()
							end
						end
					end

					local ItemDeleteButton = vgui.Create( "DButton", ItemEntry )
					ItemDeleteButton:SetPos( 0, 0 )
					ItemDeleteButton:SetSize( ((900/1920)*ScrW())-94-35-37-13-ItemEntry:GetTall(), ItemEntry:GetTall() )
					ItemDeleteButton:SetText( "" )
					local Alpha = 0
					ItemDeleteButton.Paint = function( self2, w, h )
						if( self2:IsHovered() and !self2:IsDown() ) then
							Alpha = math.Clamp( Alpha+10, 0, 150 )
						elseif( self2:IsDown() ) then
							Alpha = math.Clamp( Alpha+10, 0, 240 )
						else
							Alpha = math.Clamp( Alpha-10, 0, 150 )
						end
			
						surface.SetDrawColor( 10, 10, 20, Alpha )
						surface.DrawRect( 0, 0, w, h )
						
						draw.SimpleText( BRICKSCRAFTING.L("vguiDelete"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255, Alpha*2 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
					end
					ItemDeleteButton.DoClick = function()
						BCS_DRAWING.Query( BRICKSCRAFTING.L("vguiDeleteConfirm"), BRICKSCRAFTING.L("vguiDeleteConfirmation"), BRICKSCRAFTING.L("vguiConfirm"), function() 
							BCS_ADMIN_CFG.Crafting[k].Items[key] = nil
							BCS_ADMIN_CFG_CHANGED = true
							self.RefreshItems()
						end, BRICKSCRAFTING.L("vguiCancel"), function() end )
					end
				end
			end
		end
	end
	self.RefreshItems()

	ColSheet:AddSheet( ItemPage, BRICKSCRAFTING.L("vguiConfigItem") )

	--[[ Resources ]]--
	local ResourcesPage = vgui.Create( "brickscrafting_scrollpanel", ColSheet )
	ResourcesPage:Dock( FILL )
	ResourcesPage:DockMargin( 0, 0, 0, 0 )

	local ItemWide = 6
	local Spacing = 10
	local ResPageWide = ((900/1920)*ScrW())-94-30
	local Size = ((ResPageWide-13-37-((ItemWide-1)*Spacing))/ItemWide)

	local AddNewItem = vgui.Create( "DButton", ResourcesPage )
	AddNewItem:Dock( TOP )
	AddNewItem:DockMargin( 0, 10, 37, 0 )
	AddNewItem:SetTall( 115 )
	AddNewItem:SetText( "" )
	local Alpha = 0
	local InvX, InvY = 0, (ScrH()/2)-(((710/1080)*ScrH()+50)/2)
	local ScrollY, ScrollH = InvY+185+30, ((710/1080)*ScrH()+50)-185-65-30
	AddNewItem.Paint = function( self2, w, h )
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

		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( 0, 0, w, h )	

		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( 0, 0, w, h )
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigResourceAddNew"), "BCS_Roboto_25", w/2, h/2, Color( 255, 255, 255, 125+Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local ResourceList = vgui.Create( "DIconLayout", ResourcesPage )
	ResourceList:Dock( FILL )
	ResourceList:DockMargin( 0, 10, 10, 0 )
	ResourceList:SetSpaceX( Spacing )
	ResourceList:SetSpaceY( Spacing )

	local function RefreshResources()
		ResourceList:Clear()

		for k, v in pairs( BCS_ADMIN_CFG.Resources ) do
			if( not string.find( string.lower( k ), string.lower( self.SearchBarText or "" ) ) ) then continue end

			local ResourceEntryIcon = vgui.Create( "DButton", ResourceList )
			ResourceEntryIcon:SetSize( Size, Size )
			ResourceEntryIcon:SetToolTip( k )
			ResourceEntryIcon:SetText( "" )
			local ResourceMat = Material( v.icon or "materials/brickscrafting/icons/error.png", "noclamp smooth" )
			local Alpha = 0
			local ExtraEdge = 10
			ResourceEntryIcon.Paint = function( self2, w, h )
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
		
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial( ResourceMat )
				local Spacing = 10
				surface.DrawTexturedRect( Spacing, Spacing, w-(2*Spacing), h-(2*Spacing) )
			end
			ResourceEntryIcon.DoClick = function()
				local menu = DermaMenu()
				menu:AddOption( BRICKSCRAFTING.L("vguiRemove"), function() 
					BCS_ADMIN_CFG.Resources[k] = nil 
					BCS_ADMIN_CFG_CHANGED = true
					RefreshResources()
				end )
				menu:AddOption( BRICKSCRAFTING.L("vguiConfigResourceChangeModel"), function() 
					BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigResourceModel"), BRICKSCRAFTING.L("vguiConfigResourceModelEntry"), v.model or "", function( text ) 
						BCS_ADMIN_CFG.Resources[k].model = text
						BCS_ADMIN_CFG_CHANGED = true
					end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
				end )
				menu:AddOption( BRICKSCRAFTING.L("vguiConfigResourceChangeIcon"), function() 
					BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigResourceIcon"), BRICKSCRAFTING.L("vguiConfigResourceIconEntry"), v.icon or "", function( text ) 
						BCS_ADMIN_CFG.Resources[k].icon = text
						BCS_ADMIN_CFG_CHANGED = true
					end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
				end )
				menu:AddOption( BRICKSCRAFTING.L("vguiConfigResourceChangeColor"), function() 
					BCS_EDITCOLOR = vgui.Create( "brickscrafting_vgui_admin_editcolor" )
					BCS_EDITCOLOR:SetMixerColor( v.color or Color( 255, 255, 255 ) )
					BCS_EDITCOLOR.func_Close = function( color )
						BCS_ADMIN_CFG.Resources[k].color = color or Color( 255, 255, 255 )
					end
					BCS_ADMIN_CFG_CHANGED = true
				end )
				menu:AddOption( BRICKSCRAFTING.L("vguiNPCShopSetPrice"), function() 
					BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiNPCShopResourcePrice"), BRICKSCRAFTING.L("vguiNPCShopResourcePriceEntry"), v.Price or 0, function( text )
						text = tonumber( text )
						
						if( isnumber( text ) ) then
							if( text > 0 ) then
								BCS_ADMIN_CFG.Resources[k].Price = text
							else
								BCS_ADMIN_CFG.Resources[k].Price = nil
							end
							BCS_ADMIN_CFG_CHANGED = true
						end
					end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
				end )
				menu:Open()
			end
		end
	end
	RefreshResources()

	AddNewItem.DoClick = function()
		local NewResource = {}
		BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigResourceName"), BRICKSCRAFTING.L("vguiConfigResourceNameEntry"), "Wood", function( resName ) 
			BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigResourceModel"), BRICKSCRAFTING.L("vguiConfigResourceModelEntry"), "models/props_junk/garbage_plasticbottle003a.mdl", function( text ) 
				NewResource.model = text
				BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigResourceIcon"), BRICKSCRAFTING.L("vguiConfigResourceIconEntry"), "materials/brickscrafting/icons/quest.png", function( text ) 
					NewResource.icon = text

					if( not BCS_ADMIN_CFG.Resources[resName] ) then
						BCS_ADMIN_CFG.Resources[resName] = NewResource
						BCS_ADMIN_CFG_CHANGED = true
						RefreshResources()
					else
						notification.AddLegacy( BRICKSCRAFTING.L("vguiConfigResourceNameAlready"), 1, 5 )
					end
				end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
			end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
		end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
	end

	ColSheet:AddSheet( ResourcesPage, BRICKSCRAFTING.L("vguiConfigResource") )

	--[[ Garbage Pile ]]--
	local GarbagePilePage = vgui.Create( "DPanel", ColSheet )
	GarbagePilePage:Dock( FILL )
	GarbagePilePage.Paint = function( self2, w, h ) end

	local GarbagePileCollectTime = vgui.Create( "DPanel", GarbagePilePage )
	GarbagePileCollectTime:Dock( TOP )
	GarbagePileCollectTime:DockMargin( 0, 10, 37+13, 0 )
	GarbagePileCollectTime:SetTall( 65 )
	GarbagePileCollectTime.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow()
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )			

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigGarbageCollectTime"), "BCS_Roboto_17", w/2, 30/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local GarbagePileCollectTimeTxt = vgui.Create( "DNumberWang", GarbagePileCollectTime )
	GarbagePileCollectTimeTxt:Dock( FILL )
	GarbagePileCollectTimeTxt:DockMargin( 10, 30, 10, 10 )
	GarbagePileCollectTimeTxt:SetMax( 9999999 )
	GarbagePileCollectTimeTxt:SetValue( BCS_ADMIN_CFG.Garbage.CollectTime or 0 )
	GarbagePileCollectTimeTxt:SetToolTip( BRICKSCRAFTING.L("vguiConfigGarbageCollectTimeHint") )
	GarbagePileCollectTimeTxt.OnValueChange = function( self2, val )
		BCS_ADMIN_CFG.Garbage.CollectTime = self2:GetValue() or 0
		BCS_ADMIN_CFG_CHANGED = true
	end

	local GarbagePileTotalPercent = vgui.Create( "DPanel", GarbagePilePage )
	GarbagePileTotalPercent:Dock( TOP )
	GarbagePileTotalPercent:DockMargin( 0, 10, 37+13, 0 )
	GarbagePileTotalPercent:SetTall( 30 )
	GarbagePileTotalPercent.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow()
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )			

		local TotalPercent = 0
		for k, v in pairs( BCS_ADMIN_CFG.Garbage.Resources ) do
			TotalPercent = TotalPercent+v
		end

		if( TotalPercent <= 100 ) then
			draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiConfigGarbageTotalPercent"), TotalPercent ), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		else
			draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiConfigGarbageTotalPercent"), TotalPercent ), "BCS_Roboto_17", w/2, h/2, Color( 255, 75, 75 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end

	local GarbagePileResBack = vgui.Create( "brickscrafting_scrollpanel", GarbagePilePage )
	GarbagePileResBack:Dock( FILL )
	GarbagePileResBack:DockMargin( 0, 10, 0, 0 )

	local ItemWide = 6
	local Spacing = 10
	local GarbagePageWide = ((900/1920)*ScrW())-94-30
	local Size = ((GarbagePageWide-13-37-((ItemWide-1)*Spacing))/ItemWide)

	local GarbagePileResList = vgui.Create( "DIconLayout", GarbagePileResBack )
	GarbagePileResList:Dock( FILL )
	GarbagePileResList:DockMargin( 0, 0, 0, 0 )
	GarbagePileResList:SetSpaceX( Spacing )
	GarbagePileResList:SetSpaceY( Spacing )

	local function RefreshGarbageResources()
		GarbagePileResList:Clear()

		for k, v in pairs( BCS_ADMIN_CFG.Resources ) do
			local ResourceEntryIcon = vgui.Create( "DButton", GarbagePileResList )
			ResourceEntryIcon:SetSize( Size, Size )
			ResourceEntryIcon:SetText( "" )
			ResourceEntryIcon:SetToolTip( k )
			local ResourceMat = Material( v.icon or "materials/brickscrafting/icons/error.png", "noclamp smooth" )
			local Alpha = 0
			local ExtraEdge = 0
			local InvX, InvY = 0, (ScrH()/2)-(((710/1080)*ScrH()+50)/2)
			local ScrollY, ScrollH = InvY+185+30, ((710/1080)*ScrH()+50)-185-65-30
			ResourceEntryIcon.Paint = function( self2, w, h )
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
				surface.DrawRect( x, y, w-(2*ExtraEdge), h-(2*ExtraEdge) )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	
		
				surface.SetDrawColor( 20, 20, 30, Alpha )
				surface.DrawRect( ExtraEdge, ExtraEdge, w-(2*ExtraEdge), h-(2*ExtraEdge) )
		
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial( ResourceMat )
				local Spacing = 10
				surface.DrawTexturedRect( ExtraEdge+Spacing, ExtraEdge+Spacing, w-(2*Spacing)-(2*ExtraEdge), h-(2*Spacing)-(2*ExtraEdge) )
				draw.SimpleText( (BCS_ADMIN_CFG.Garbage.Resources[k] or 0) .. "%", "BCS_Roboto_17", w-ExtraEdge-3, ExtraEdge+1, Color( 0, 128, 181 ), TEXT_ALIGN_RIGHT, 0 )
			end
			ResourceEntryIcon.DoClick = function()
				BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigGarbageResourcePercentage"), BRICKSCRAFTING.L("vguiConfigGarbageChanceRes"), 0, function( text ) 
					if( isnumber( tonumber( text ) ) ) then
						BCS_ADMIN_CFG.Garbage.Resources[k] = tonumber( text )
						BCS_ADMIN_CFG_CHANGED = true
					end
				end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
			end
		end
	end
	RefreshGarbageResources()

	ColSheet:AddSheet( GarbagePilePage, BRICKSCRAFTING.L("vguiConfigGarbage") )

	--[[ Mining ]]--
	local MiningPage = vgui.Create( "DPanel", ColSheet )
	MiningPage:Dock( FILL )
	MiningPage.Paint = function( self, w, h ) end

	local MiningPageScroll = vgui.Create( "brickscrafting_scrollpanel", MiningPage )
	MiningPageScroll:Dock( FILL )

	local function RefreshMining()
		MiningPageScroll:Clear()

		local AddNewItem = vgui.Create( "DButton", MiningPageScroll )
		AddNewItem:Dock( TOP )
		AddNewItem:DockMargin( 0, 10, 37, 0 )
		AddNewItem:SetTall( 115 )
		AddNewItem:SetText( "" )
		local Alpha = 0
		local InvX, InvY = 0, (ScrH()/2)-(((710/1080)*ScrH()+50)/2)
		local ScrollY, ScrollH = InvY+185+30, ((710/1080)*ScrH()+50)-185-65-30
		AddNewItem.Paint = function( self2, w, h )
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

			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 0, 0, w, h )	
	
			surface.SetDrawColor( 20, 20, 30, Alpha )
			surface.DrawRect( 0, 0, w, h )
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigMiningNewRock"), "BCS_Roboto_25", w/2, h/2, Color( 255, 255, 255, 125+Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		AddNewItem.DoClick = function()
			BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigMiningRockCreation"), BRICKSCRAFTING.L("vguiConfigMiningRockName"), "rock name", function( text ) 
				if( not BCS_ADMIN_CFG.Mining[text] ) then
					if( not IsValid( BCS_AdminAddRock ) ) then
						BCS_AdminAddRock = vgui.Create( "brickscrafting_vgui_admin_addmining" ) 
						BCS_AdminAddRock:SetRockName( text )
						BCS_AdminAddRock.func_Close = function()
							RefreshMining()
						end
					end
				else
					notification.AddLegacy( BRICKSCRAFTING.L("vguiConfigMiningAlreadyRock"), 1, 5 )
				end
			end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
		end

		for k, v in pairs( BCS_ADMIN_CFG.Mining ) do
			if( not string.find( string.lower( k ), string.lower( self.SearchBarText or "" ) ) ) then continue end

			local ItemEntry = vgui.Create( "DPanel", MiningPageScroll )
			ItemEntry:Dock( TOP )
			ItemEntry:DockMargin( 0, 10, 37, 0 )
			ItemEntry:SetTall( 115 )
			ItemEntry.Paint = function( self2, w, h )
				BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
				surface.SetDrawColor( 30, 30, 44 )
				local x, y = self2:LocalToScreen( 0, 0 )
				surface.DrawRect( x, y, w, h )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	

				surface.SetDrawColor( 30, 30, 44 )
				surface.DrawRect( 0, 0, w, h )	

				draw.SimpleText( k, "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
				draw.SimpleText( BRICKSCRAFTING.L("vguiConfigMiningRockRewardAm") .. ": " ..  (v.BaseReward or 10), "BCS_Roboto_16", h+20, 52, Color( 255, 255, 255 ), 0, 0 )
			end
			
			local InvItemIcon = vgui.Create( "DModelPanel", ItemEntry )
			InvItemIcon:Dock( LEFT )
			InvItemIcon:SetWide( ItemEntry:GetTall() )
			InvItemIcon:SetModel( v.model )		
			if( IsValid( InvItemIcon.Entity ) ) then
				InvItemIcon:SetColor( v.color or Color( 255, 255, 255 ) )
				local mn, mx = InvItemIcon.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

				InvItemIcon:SetFOV( 45 )
				InvItemIcon:SetCamPos( Vector( size, size, size ) )
				InvItemIcon:SetLookAt( ( mn + mx ) * 0.5 )
				function InvItemIcon:LayoutEntity( Entity ) return end
			end	

			local ItemEditButton = vgui.Create( "DButton", ItemEntry )
			ItemEditButton:Dock( RIGHT )
			ItemEditButton:SetWide( ItemEntry:GetTall() )
			ItemEditButton:SetText( "" )
			local Alpha = 0
			ItemEditButton.Paint = function( self2, w, h )
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
				
				draw.SimpleText( BRICKSCRAFTING.L("vguiEdit"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ItemEditButton.DoClick = function()
				if( not IsValid( BCS_AdminEditRock ) ) then
					BCS_AdminEditRock = vgui.Create( "brickscrafting_vgui_admin_editmining" ) 
					BCS_AdminEditRock:SetRockData( k )
					BCS_AdminEditRock.func_Close = function()
						RefreshMining()
					end
				end
			end

			local ItemDeleteButton = vgui.Create( "DButton", ItemEntry )
			ItemDeleteButton:SetPos( 0, 0 )
			ItemDeleteButton:SetSize( ((900/1920)*ScrW())-94-35-37-13-ItemEntry:GetTall(), ItemEntry:GetTall() )
			ItemDeleteButton:SetText( "" )
			local Alpha = 0
			ItemDeleteButton.Paint = function( self2, w, h )
				if( self2:IsHovered() and !self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 150 )
				elseif( self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 240 )
				else
					Alpha = math.Clamp( Alpha-10, 0, 150 )
				end
	
				surface.SetDrawColor( 10, 10, 20, Alpha )
				surface.DrawRect( 0, 0, w, h )
				
				draw.SimpleText( BRICKSCRAFTING.L("vguiDelete"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255, Alpha*2 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ItemDeleteButton.DoClick = function()
				BCS_DRAWING.Query( BRICKSCRAFTING.L("vguiDeleteConfirm"), BRICKSCRAFTING.L("vguiDeleteConfirmation"), BRICKSCRAFTING.L("vguiConfirm"), function() 
					BCS_ADMIN_CFG.Mining[k] = nil
					BCS_ADMIN_CFG_CHANGED = true
					RefreshMining()
				end, BRICKSCRAFTING.L("vguiCancel"), function() end )
			end
		end
	end
	RefreshMining()

	ColSheet:AddSheet( MiningPage, BRICKSCRAFTING.L("mining") )

	--[[ WoodCutting ]]--
	local WoodCuttingPage = vgui.Create( "DPanel", ColSheet )
	WoodCuttingPage:Dock( FILL )
	WoodCuttingPage.Paint = function( self, w, h ) end

	local WoodCuttingPageScroll = vgui.Create( "brickscrafting_scrollpanel", WoodCuttingPage )
	WoodCuttingPageScroll:Dock( FILL )

	local function RefreshWoodCutting()
		WoodCuttingPageScroll:Clear()

		local AddNewItem = vgui.Create( "DButton", WoodCuttingPageScroll )
		AddNewItem:Dock( TOP )
		AddNewItem:DockMargin( 0, 10, 37, 0 )
		AddNewItem:SetTall( 115 )
		AddNewItem:SetText( "" )
		local Alpha = 0
		local InvX, InvY = 0, (ScrH()/2)-(((710/1080)*ScrH()+50)/2)
		local ScrollY, ScrollH = InvY+185+30, ((710/1080)*ScrH()+50)-185-65-30
		AddNewItem.Paint = function( self2, w, h )
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

			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 0, 0, w, h )	

			surface.SetDrawColor( 20, 20, 30, Alpha )
			surface.DrawRect( 0, 0, w, h )
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigWoodNewTree"), "BCS_Roboto_25", w/2, h/2, Color( 255, 255, 255, 125+Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		AddNewItem.DoClick = function()
			BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigWoodCreation"), BRICKSCRAFTING.L("vguiConfigWoodNameOfTree"), "tree name", function( text ) 
				if( not BCS_ADMIN_CFG.WoodCutting[text] ) then
					if( not IsValid( BCS_AdminAddTree ) ) then
						BCS_AdminAddTree = vgui.Create( "brickscrafting_vgui_admin_addtree" ) 
						BCS_AdminAddTree:SetTreeName( text )
						BCS_AdminAddTree.func_Close = function()
							RefreshWoodCutting()
						end
					end
				else
					notification.AddLegacy( BRICKSCRAFTING.L("vguiConfigWoodAlreadyTree"), 1, 5 )
				end
			end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
		end

		for k, v in pairs( BCS_ADMIN_CFG.WoodCutting ) do
			if( not string.find( string.lower( k ), string.lower( self.SearchBarText or "" ) ) ) then continue end

			local ItemEntry = vgui.Create( "DPanel", WoodCuttingPageScroll )
			ItemEntry:Dock( TOP )
			ItemEntry:DockMargin( 0, 10, 37, 0 )
			ItemEntry:SetTall( 115 )
			ItemEntry.Paint = function( self2, w, h )
				BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
				surface.SetDrawColor( 30, 30, 44 )
				local x, y = self2:LocalToScreen( 0, 0 )
				surface.DrawRect( x, y, w, h )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	

				surface.SetDrawColor( 30, 30, 44 )
				surface.DrawRect( 0, 0, w, h )	

				draw.SimpleText( k, "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
				draw.SimpleText( BRICKSCRAFTING.L("vguiConfigMiningRockRewardAm") .. ": " ..  v.BaseReward or 10, "BCS_Roboto_16", h+20, 52, Color( 255, 255, 255 ), 0, 0 )
			end
			
			local InvItemIcon = vgui.Create( "DModelPanel", ItemEntry )
			InvItemIcon:Dock( LEFT )
			InvItemIcon:SetWide( ItemEntry:GetTall() )
			InvItemIcon:SetModel( v.model )		
			if( IsValid( InvItemIcon.Entity ) ) then
				local mn, mx = InvItemIcon.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

				InvItemIcon:SetFOV( 45 )
				InvItemIcon:SetCamPos( Vector( size, size, size ) )
				InvItemIcon:SetLookAt( ( mn + mx ) * 0.5 )
				function InvItemIcon:LayoutEntity( Entity ) return end
			end	

			local ItemEditButton = vgui.Create( "DButton", ItemEntry )
			ItemEditButton:Dock( RIGHT )
			ItemEditButton:SetWide( ItemEntry:GetTall() )
			ItemEditButton:SetText( "" )
			local Alpha = 0
			ItemEditButton.Paint = function( self2, w, h )
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
				
				draw.SimpleText( BRICKSCRAFTING.L("vguiEdit"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ItemEditButton.DoClick = function()
				if( not IsValid( BCS_AdminEditTree ) ) then
					BCS_AdminEditTree = vgui.Create( "brickscrafting_vgui_admin_edittree" ) 
					BCS_AdminEditTree:SetTreeData( k )
					BCS_AdminEditTree.func_Close = function()
						RefreshWoodCutting()
					end
				end
			end

			local ItemDeleteButton = vgui.Create( "DButton", ItemEntry )
			ItemDeleteButton:SetPos( 0, 0 )
			ItemDeleteButton:SetSize( ((900/1920)*ScrW())-94-35-37-13-ItemEntry:GetTall(), ItemEntry:GetTall() )
			ItemDeleteButton:SetText( "" )
			local Alpha = 0
			ItemDeleteButton.Paint = function( self2, w, h )
				if( self2:IsHovered() and !self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 150 )
				elseif( self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 240 )
				else
					Alpha = math.Clamp( Alpha-10, 0, 150 )
				end
	
				surface.SetDrawColor( 10, 10, 20, Alpha )
				surface.DrawRect( 0, 0, w, h )
				
				draw.SimpleText( BRICKSCRAFTING.L("vguiDelete"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255, Alpha*2 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ItemDeleteButton.DoClick = function()
				BCS_DRAWING.Query( BRICKSCRAFTING.L("vguiDeleteConfirm"), BRICKSCRAFTING.L("vguiDeleteConfirmation"), BRICKSCRAFTING.L("vguiConfirm"), function() 
					BCS_ADMIN_CFG.WoodCutting[k] = nil
					BCS_ADMIN_CFG_CHANGED = true
					RefreshWoodCutting()
				end, BRICKSCRAFTING.L("vguiCancel"), function() end )
			end
		end
	end
	RefreshWoodCutting()

	ColSheet:AddSheet( WoodCuttingPage, BRICKSCRAFTING.L("vguiConfigWood") )

	--[[ Quests ]]--
	local QuestsPage = vgui.Create( "DPanel", ColSheet )
	QuestsPage:Dock( FILL )
	QuestsPage.Paint = function( self, w, h ) end

	local QuestsPageScroll = vgui.Create( "brickscrafting_scrollpanel", QuestsPage )
	QuestsPageScroll:Dock( FILL )

	local function RefreshQuests()
		QuestsPageScroll:Clear()

		local AddNewItem = vgui.Create( "DButton", QuestsPageScroll )
		AddNewItem:Dock( TOP )
		AddNewItem:DockMargin( 0, 10, 37, 0 )
		AddNewItem:SetTall( 115 )
		AddNewItem:SetText( "" )
		local Alpha = 0
		local InvX, InvY = 0, (ScrH()/2)-(((710/1080)*ScrH()+50)/2)
		local ScrollY, ScrollH = InvY+185+30, ((710/1080)*ScrH()+50)-185-65-30
		AddNewItem.Paint = function( self2, w, h )
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

			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 0, 0, w, h )	
	
			surface.SetDrawColor( 20, 20, 30, Alpha )
			surface.DrawRect( 0, 0, w, h )
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestNewQuest"), "BCS_Roboto_25", w/2, h/2, Color( 255, 255, 255, 125+Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		AddNewItem.DoClick = function()
			if( not IsValid( BCS_AdminAddQuest ) ) then
				/*if( IsValid( BCS_AdminMenu ) ) then
					BCS_AdminMenu:AlphaTo( 0, 0.25, 0 )
				end*/

				BCS_AdminAddQuest = vgui.Create( "brickscrafting_vgui_admin_addquest" ) 
				BCS_AdminAddQuest:RefreshInfo()
				BCS_AdminAddQuest.func_Close = function()
					RefreshQuests()
				end
			end
		end

		for k, v in pairs( BCS_ADMIN_CFG.Quests ) do
			if( not string.find( string.lower( v.Name ), string.lower( self.SearchBarText or "" ) ) ) then continue end

			local ItemEntry = vgui.Create( "DPanel", QuestsPageScroll )
			ItemEntry:Dock( TOP )
			ItemEntry:DockMargin( 0, 10, 37, 0 )
			ItemEntry:SetTall( 115 )
			ItemEntry.Paint = function( self2, w, h )
				BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
				surface.SetDrawColor( 30, 30, 44 )
				local x, y = self2:LocalToScreen( 0, 0 )
				surface.DrawRect( x, y, w, h )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	

				surface.SetDrawColor( 30, 30, 44 )
				surface.DrawRect( 0, 0, w, h )	

				if( not v.Daily ) then
					draw.SimpleText( v.Name, "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
				else
					draw.SimpleText( v.Name .. " " .. BRICKSCRAFTING.L("vguiNPCQuestsDaily"), "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
				end
				draw.SimpleText( v.Description, "BCS_Roboto_16", h+20, 52, Color( 255, 255, 255 ), 0, 0 )
			end
			
			local ItemIcon = vgui.Create( "DPanel", ItemEntry )
			ItemIcon:Dock( LEFT )
			ItemIcon:SetWide( ItemEntry:GetTall() )
			ItemIcon.Paint = function( self2, w, h )
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial( BCS_DRAWING.GetMaterial( v.Icon ) )
				local IconSize = h*0.75
				surface.DrawTexturedRect( (h-IconSize)/2, (h-IconSize)/2, IconSize, IconSize )
			end

			local ItemEditButton = vgui.Create( "DButton", ItemEntry )
			ItemEditButton:Dock( RIGHT )
			ItemEditButton:SetWide( ItemEntry:GetTall() )
			ItemEditButton:SetText( "" )
			local Alpha = 0
			ItemEditButton.Paint = function( self2, w, h )
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
				
				draw.SimpleText( BRICKSCRAFTING.L("vguiEdit"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ItemEditButton.DoClick = function()
				if( not IsValid( BCS_AdminEditQuest ) ) then
					BCS_AdminEditQuest = vgui.Create( "brickscrafting_vgui_admin_editquest" ) 
					BCS_AdminEditQuest:SetQuestData( k )
					BCS_AdminEditQuest.func_Close = function()
						RefreshQuests()
					end
				end
			end

			local ItemResBack = vgui.Create( "DPanel", ItemEntry )
			ItemResBack:Dock( TOP )
			ItemResBack:DockMargin( 20, 52+20, 0, 0 )
			ItemResBack:SetTall( 25 )
			ItemResBack.Paint = function( self2, w, h ) end

			local ItemResEntryAmountHeader = vgui.Create( "DLabel", ItemResBack )
			ItemResEntryAmountHeader:Dock( LEFT )
			ItemResEntryAmountHeader:DockMargin( 0, 0, 0, 0 )
			ItemResEntryAmountHeader:SetText( BRICKSCRAFTING.L("vguiConfigQuestRewardsList") )
			ItemResEntryAmountHeader:SetTextColor( Color( 255, 255, 255 ) )
			ItemResEntryAmountHeader:SetFont( "BCS_Roboto_16" )
			ItemResEntryAmountHeader:SizeToContents()
			
			for key, val in pairs( v.Rewards ) do
				local ItemResEntryAmount = vgui.Create( "DLabel", ItemResBack )
				ItemResEntryAmount:Dock( LEFT )
				ItemResEntryAmount:DockMargin( 0, 0, 10, 0 )
				if( BRICKSCRAFTING.LUACONFIG.DarkRP and key == "Money" ) then
					ItemResEntryAmount:SetText( DarkRP.formatMoney( val[1] ) )
				elseif( key == "Craftable" ) then
					local String = ""
					for key2, val2 in pairs( val ) do
						if( BCS_ADMIN_CFG.Crafting[key2] ) then
							for key3, val3 in pairs( val2 ) do
								if( BCS_ADMIN_CFG.Crafting[key2].Items[key3] ) then
									String = String .. val3 .. " " .. BCS_ADMIN_CFG.Crafting[key2].Items[key3].Name .. "   "
								end
							end
						end
					end
					ItemResEntryAmount:SetText( String )
				elseif( key == "Resources" ) then
					local String = ""
					for key2, val2 in pairs( val ) do
						String = String .. val2 .. " " .. key2 .. "   "
					end
					ItemResEntryAmount:SetText( String )
				else

				end
				ItemResEntryAmount:SetTextColor( Color( 255, 255, 255 ) )
				ItemResEntryAmount:SetFont( "BCS_Roboto_16" )
				ItemResEntryAmount:SizeToContents()
			end

			local ItemDeleteButton = vgui.Create( "DButton", ItemEntry )
			ItemDeleteButton:SetPos( 0, 0 )
			ItemDeleteButton:SetSize( ((900/1920)*ScrW())-94-35-37-13-ItemEntry:GetTall(), ItemEntry:GetTall() )
			ItemDeleteButton:SetText( "" )
			local Alpha = 0
			ItemDeleteButton.Paint = function( self2, w, h )
				if( self2:IsHovered() and !self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 150 )
				elseif( self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 240 )
				else
					Alpha = math.Clamp( Alpha-10, 0, 150 )
				end
	
				surface.SetDrawColor( 10, 10, 20, Alpha )
				surface.DrawRect( 0, 0, w, h )
				
				draw.SimpleText( BRICKSCRAFTING.L("vguiDelete"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255, Alpha*2 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ItemDeleteButton.DoClick = function()
				BCS_DRAWING.Query( BRICKSCRAFTING.L("vguiDeleteConfirm"), BRICKSCRAFTING.L("vguiDeleteConfirmation"), BRICKSCRAFTING.L("vguiConfirm"), function() 
					BCS_ADMIN_CFG.Quests[k] = nil
					BCS_ADMIN_CFG_CHANGED = true
					RefreshQuests()
				end, BRICKSCRAFTING.L("vguiCancel"), function() end )
			end
		end
	end
	RefreshQuests()

	ColSheet:AddSheet( QuestsPage, BRICKSCRAFTING.L("vguiConfigQuest") )

    --[[ Tools ]]--
	local ToolsPage = vgui.Create( "DPanel", ColSheet )
	ToolsPage:Dock( FILL )
	ToolsPage.Paint = function( self, w, h ) end

	local ToolsPageScroll = vgui.Create( "brickscrafting_categorylist", ToolsPage )
	ToolsPageScroll:Dock( FILL )
	ToolsPageScroll.Paint = function( self, w, h ) end

	local InvX, InvY = 0, (ScrH()/2)-(((710/1080)*ScrH()+50)/2)
	local ScrollY, ScrollH = InvY+185+30, ((710/1080)*ScrH()+50)-185-65-30

	local function RefreshTools()
		ToolsPageScroll:Clear()

		ToolsPageScroll["Pickaxe"] = ToolsPageScroll:Add( BRICKSCRAFTING.L("pickaxe") )
		ToolsPageScroll["Pickaxe"]:DockMargin( 0, 10, 0, 0 )

		local ToolsPagePickaxeLevel = vgui.Create( "DPanel", ToolsPageScroll["Pickaxe"] )
		ToolsPagePickaxeLevel:Dock( TOP )
		ToolsPagePickaxeLevel:DockMargin( 0, 10, 0, 0 )
		ToolsPagePickaxeLevel:SetTall( 65 )
		ToolsPagePickaxeLevel.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	
	
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsPickaxeMax"), "BCS_Roboto_17", w/2, 30/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	
		local ToolsPagePickaxeLevelTxt = vgui.Create( "DNumberWang", ToolsPagePickaxeLevel )
		ToolsPagePickaxeLevelTxt:Dock( FILL )
		ToolsPagePickaxeLevelTxt:DockMargin( 10, 30, 10, 10 )
		ToolsPagePickaxeLevelTxt:SetMax( 9999999 )
		ToolsPagePickaxeLevelTxt:SetValue( BCS_ADMIN_CFG.Tools.MaxPickaxeSkill or 0 )
		ToolsPagePickaxeLevelTxt:SetToolTip( BRICKSCRAFTING.L("vguiConfigToolsPickaxeMaxLvl") )
		ToolsPagePickaxeLevelTxt.OnValueChange = function( self2, val )
			BCS_ADMIN_CFG.Tools.MaxPickaxeSkill = self2:GetValue() or 0
			BCS_ADMIN_CFG_CHANGED = true
		end

		local AddNewPickaxe = vgui.Create( "DButton", ToolsPageScroll["Pickaxe"] )
		AddNewPickaxe:Dock( TOP )
		AddNewPickaxe:DockMargin( 0, 10, 0, 0 )
		AddNewPickaxe:SetTall( 115 )
		AddNewPickaxe:SetText( "" )
		local Alpha = 0
		AddNewPickaxe.Paint = function( self2, w, h )
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

			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 0, 0, w, h )	
	
			surface.SetDrawColor( 20, 20, 30, Alpha )
			surface.DrawRect( 0, 0, w, h )
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsPickaxeNew"), "BCS_Roboto_25", w/2, h/2, Color( 255, 255, 255, 125+Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		AddNewPickaxe.DoClick = function()
			if( not IsValid( BCS_AdminAddTools ) ) then
				BCS_AdminAddTools = vgui.Create( "brickscrafting_vgui_admin_addtool" ) 
				BCS_AdminAddTools:RefreshInfo( BCS_ADMIN_CFG.Tools.Pickaxe, BRICKSCRAFTING.LUACONFIG.Defaults.PickaxeModel )
				BCS_AdminAddTools.func_Close = function()
					RefreshTools()
				end
			end
		end

		for k, v in pairs( BCS_ADMIN_CFG.Tools.Pickaxe ) do
			local ToolsPagePickaxeEntry = vgui.Create( "DPanel", ToolsPageScroll["Pickaxe"] )
			ToolsPagePickaxeEntry:Dock( TOP )
			ToolsPagePickaxeEntry:DockMargin( 0, 10, 0, 0 )
			ToolsPagePickaxeEntry:SetTall( 115 )
			local LeftSpacing = 10
			ToolsPagePickaxeEntry.Paint = function( self2, w, h )
				BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
				surface.SetDrawColor( 30, 30, 44 )
				local x, y = self2:LocalToScreen( 0, 0 )
				surface.DrawRect( x, y, w, h )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	

				draw.SimpleText( k, "BCS_Roboto_22", LeftSpacing+(30/2), h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiConfigToolsPickaxeLevel"), k ), "BCS_Roboto_25", h+20+40, 24, Color( 255, 255, 255 ), 0, 0 )
				if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then
					draw.SimpleText(string.format( BRICKSCRAFTING.L("vguiConfigToolsPickaxeReq"), DarkRP.formatMoney( v.Cost or 0 ), (v.Skill or 0) ), "BCS_Roboto_16", h+20+40, 52, Color( 255, 255, 255 ), 0, 0 )
					draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiConfigToolsPickaxeIncrease"), v.Increase or 0 ), "BCS_Roboto_16", h+20+40, 72, Color( 255, 255, 255 ), 0, 0 )
				else
					draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiConfigToolsPickaxeIncrease"), v.Increase or 0 ), "BCS_Roboto_16", h+20+40, 52, Color( 255, 255, 255 ), 0, 0 )
				end
			end

			local ToolsPagePickaxeEntryUp = vgui.Create( "DButton", ToolsPagePickaxeEntry )
			ToolsPagePickaxeEntryUp:SetPos( LeftSpacing, 5 )
			ToolsPagePickaxeEntryUp:SetSize( 30, (ToolsPagePickaxeEntry:GetTall()-10)/3 )
			ToolsPagePickaxeEntryUp:SetText( "" )
			local Alpha = 100
			ToolsPagePickaxeEntryUp.Paint = function( self2, w, h )
				if( self2:IsHovered() and !self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+5, 100, 200 )
				elseif( self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 100, 255 )
				else
					Alpha = math.Clamp( Alpha-5, 100, 255 )
				end
				
				draw.SimpleText( "▲", "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255, Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ToolsPagePickaxeEntryUp.DoClick = function()
				if( not BCS_ADMIN_CFG.Tools.Pickaxe[k-1] ) then return end

				local TempChange = BCS_ADMIN_CFG.Tools.Pickaxe[k-1]

				BCS_ADMIN_CFG.Tools.Pickaxe[k-1] = v
				BCS_ADMIN_CFG.Tools.Pickaxe[k] = TempChange

				BCS_ADMIN_CFG_CHANGED = true

				RefreshTools()
			end

			local ToolsPagePickaxeEntryDown = vgui.Create( "DButton", ToolsPagePickaxeEntry )
			ToolsPagePickaxeEntryDown:SetSize( 30, (ToolsPagePickaxeEntry:GetTall()-10)/3 )
			ToolsPagePickaxeEntryDown:SetPos( LeftSpacing, ToolsPagePickaxeEntry:GetTall()-5-ToolsPagePickaxeEntryDown:GetTall() )
			ToolsPagePickaxeEntryDown:SetText( "" )
			local Alpha = 100
			ToolsPagePickaxeEntryDown.Paint = function( self2, w, h )
				if( self2:IsHovered() and !self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+5, 100, 200 )
				elseif( self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 100, 255 )
				else
					Alpha = math.Clamp( Alpha-5, 100, 255 )
				end
	
				draw.SimpleText( "▼", "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255, Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ToolsPagePickaxeEntryDown.DoClick = function()
				if( not BCS_ADMIN_CFG.Tools.Pickaxe[k+1] ) then return end

				local TempChange = BCS_ADMIN_CFG.Tools.Pickaxe[k+1]

				BCS_ADMIN_CFG.Tools.Pickaxe[k+1] = v
				BCS_ADMIN_CFG.Tools.Pickaxe[k] = TempChange

				BCS_ADMIN_CFG_CHANGED = true

				RefreshTools()
			end

			local ToolsPagePickaxeEntryIcon = vgui.Create( "DModelPanel", ToolsPagePickaxeEntry )
			ToolsPagePickaxeEntryIcon:Dock( LEFT )
			ToolsPagePickaxeEntryIcon:DockMargin( LeftSpacing+30, 0, 0, 0 )
			ToolsPagePickaxeEntryIcon:SetWide( ToolsPagePickaxeEntry:GetTall() )
			ToolsPagePickaxeEntryIcon:SetModel( BRICKSCRAFTING.LUACONFIG.Defaults.PickaxeModel )		
			ToolsPagePickaxeEntryIcon:SetColor( v.Color or Color( 255, 255, 255 ) )		
			if( IsValid( ToolsPagePickaxeEntryIcon.Entity ) ) then
				local mn, mx = ToolsPagePickaxeEntryIcon.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

				ToolsPagePickaxeEntryIcon:SetFOV( 45 )
				ToolsPagePickaxeEntryIcon:SetCamPos( Vector( size, size, size ) )
				ToolsPagePickaxeEntryIcon:SetLookAt( ( mn + mx ) * 0.5 )
				function ToolsPagePickaxeEntryIcon:LayoutEntity( Entity ) return end
			end

			local ItemEditButton = vgui.Create( "DButton", ToolsPagePickaxeEntry )
			ItemEditButton:Dock( RIGHT )
			ItemEditButton:SetWide( ToolsPagePickaxeEntry:GetTall() )
			ItemEditButton:SetText( "" )
			local Alpha = 0
			ItemEditButton.Paint = function( self2, w, h )
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
				
				draw.SimpleText( BRICKSCRAFTING.L("vguiEdit"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ItemEditButton.DoClick = function()
				if( not IsValid( BCS_AdminEditTools) ) then
					BCS_AdminEditTools = vgui.Create( "brickscrafting_vgui_admin_edittool" ) 
					BCS_AdminEditTools:SetToolData( BCS_ADMIN_CFG.Tools.Pickaxe, k, BRICKSCRAFTING.LUACONFIG.Defaults.PickaxeModel  )
					BCS_AdminEditTools.func_Close = function()
						RefreshTools()
					end
				end
			end

			local ItemDeleteButton = vgui.Create( "DButton", ToolsPagePickaxeEntry )
			ItemDeleteButton:SetPos( 0, 0 )
			ItemDeleteButton:SetSize( ((900/1920)*ScrW())-94-35-37-13-ToolsPagePickaxeEntry:GetTall(), ToolsPagePickaxeEntry:GetTall() )
			ItemDeleteButton:SetText( "" )
			local Alpha = 0
			ItemDeleteButton.Paint = function( self2, w, h )
				if( self2:IsHovered() and !self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 150 )
				elseif( self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 240 )
				else
					Alpha = math.Clamp( Alpha-10, 0, 150 )
				end
	
				surface.SetDrawColor( 10, 10, 20, Alpha )
				surface.DrawRect( 0, 0, w, h )
				
				draw.SimpleText( BRICKSCRAFTING.L("vguiDelete"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255, Alpha*2 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ItemDeleteButton.DoClick = function()
				BCS_DRAWING.Query( BRICKSCRAFTING.L("vguiDeleteConfirm"), BRICKSCRAFTING.L("vguiDeleteConfirmation"), BRICKSCRAFTING.L("vguiConfirm"), function() 
					table.remove( BCS_ADMIN_CFG.Tools.Pickaxe, k )
					BCS_ADMIN_CFG_CHANGED = true
					RefreshTools()
				end, BRICKSCRAFTING.L("vguiCancel"), function() end )
			end
		end

		ToolsPageScroll["LumberAxe"] = ToolsPageScroll:Add( BRICKSCRAFTING.L("lumberAxe") )
		ToolsPageScroll["LumberAxe"]:DockMargin( 0, 10, 0, 0 )

		local ToolsPageLumberAxeLevel = vgui.Create( "DPanel", ToolsPageScroll["LumberAxe"] )
		ToolsPageLumberAxeLevel:Dock( TOP )
		ToolsPageLumberAxeLevel:DockMargin( 0, 10, 0, 0 )
		ToolsPageLumberAxeLevel:SetTall( 65 )
		ToolsPageLumberAxeLevel.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	
	
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsLumberAxeMax"), "BCS_Roboto_17", w/2, 30/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	
		local ToolsPageLumberAxeLevelTxt = vgui.Create( "DNumberWang", ToolsPageLumberAxeLevel )
		ToolsPageLumberAxeLevelTxt:Dock( FILL )
		ToolsPageLumberAxeLevelTxt:DockMargin( 10, 30, 10, 10 )
		ToolsPageLumberAxeLevelTxt:SetMax( 9999999 )
		ToolsPageLumberAxeLevelTxt:SetValue( BCS_ADMIN_CFG.Tools.MaxLumberAxeSkill or 0 )
		ToolsPageLumberAxeLevelTxt:SetToolTip( BRICKSCRAFTING.L("vguiConfigToolsLumberAxeMaxLvl") )
		ToolsPageLumberAxeLevelTxt.OnValueChange = function( self2, val )
			BCS_ADMIN_CFG.Tools.MaxLumberAxeSkill = self2:GetValue() or 0
			BCS_ADMIN_CFG_CHANGED = true
		end

		local AddNewLumberAxe = vgui.Create( "DButton", ToolsPageScroll["LumberAxe"] )
		AddNewLumberAxe:Dock( TOP )
		AddNewLumberAxe:DockMargin( 0, 10, 0, 0 )
		AddNewLumberAxe:SetTall( 115 )
		AddNewLumberAxe:SetText( "" )
		local Alpha = 0
		AddNewLumberAxe.Paint = function( self2, w, h )
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

			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 0, 0, w, h )	
	
			surface.SetDrawColor( 20, 20, 30, Alpha )
			surface.DrawRect( 0, 0, w, h )
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsLumberAxeNew"), "BCS_Roboto_25", w/2, h/2, Color( 255, 255, 255, 125+Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		AddNewLumberAxe.DoClick = function()
			if( not IsValid( BCS_AdminAddTools ) ) then
				BCS_AdminAddTools = vgui.Create( "brickscrafting_vgui_admin_addtool" ) 
				BCS_AdminAddTools:RefreshInfo( BCS_ADMIN_CFG.Tools.LumberAxe, BRICKSCRAFTING.LUACONFIG.Defaults.LumberAxeModel )
				BCS_AdminAddTools.func_Close = function()
					RefreshTools()
				end
			end
		end

		for k, v in pairs( BCS_ADMIN_CFG.Tools.LumberAxe ) do
			local ToolsPageLumberAxeEntry = vgui.Create( "DPanel", ToolsPageScroll["LumberAxe"] )
			ToolsPageLumberAxeEntry:Dock( TOP )
			ToolsPageLumberAxeEntry:DockMargin( 0, 10, 0, 0 )
			ToolsPageLumberAxeEntry:SetTall( 115 )
			local LeftSpacing = 10
			ToolsPageLumberAxeEntry.Paint = function( self2, w, h )
				BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
				surface.SetDrawColor( 30, 30, 44 )
				local x, y = self2:LocalToScreen( 0, 0 )
				surface.DrawRect( x, y, w, h )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	

				draw.SimpleText( k, "BCS_Roboto_22", LeftSpacing+(30/2), h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

				draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiConfigToolsLumberAxeLevel"), k ), "BCS_Roboto_25", h+20+40, 24, Color( 255, 255, 255 ), 0, 0 )
				if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then	
					draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiConfigToolsLumberAxeReq"), DarkRP.formatMoney( v.Cost or 0 ), (v.Skill or 0)), "BCS_Roboto_16", h+20+40, 52, Color( 255, 255, 255 ), 0, 0 )
					draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiConfigToolsLumberAxeIncrease"), (v.Increase or 0)), "BCS_Roboto_16", h+20+40, 72, Color( 255, 255, 255 ), 0, 0 )
				else
					draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiConfigToolsLumberAxeIncrease"), (v.Increase or 0)), "BCS_Roboto_16", h+20+40, 52, Color( 255, 255, 255 ), 0, 0 )
				end
			end

			local ToolsPageLumberAxeEntryUp = vgui.Create( "DButton", ToolsPageLumberAxeEntry )
			ToolsPageLumberAxeEntryUp:SetPos( LeftSpacing, 5 )
			ToolsPageLumberAxeEntryUp:SetSize( 30, (ToolsPageLumberAxeEntry:GetTall()-10)/3 )
			ToolsPageLumberAxeEntryUp:SetText( "" )
			local Alpha = 100
			ToolsPageLumberAxeEntryUp.Paint = function( self2, w, h )
				if( self2:IsHovered() and !self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+5, 100, 200 )
				elseif( self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 100, 255 )
				else
					Alpha = math.Clamp( Alpha-5, 100, 255 )
				end
				
				draw.SimpleText( "▲", "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255, Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ToolsPageLumberAxeEntryUp.DoClick = function()
				if( not BCS_ADMIN_CFG.Tools.LumberAxe[k-1] ) then return end

				local TempChange = BCS_ADMIN_CFG.Tools.LumberAxe[k-1]

				BCS_ADMIN_CFG.Tools.LumberAxe[k-1] = v
				BCS_ADMIN_CFG.Tools.LumberAxe[k] = TempChange

				BCS_ADMIN_CFG_CHANGED = true

				RefreshTools()
			end

			local ToolsPageLumberAxeEntryDown = vgui.Create( "DButton", ToolsPageLumberAxeEntry )
			ToolsPageLumberAxeEntryDown:SetSize( 30, (ToolsPageLumberAxeEntry:GetTall()-10)/3 )
			ToolsPageLumberAxeEntryDown:SetPos( LeftSpacing, ToolsPageLumberAxeEntry:GetTall()-5-ToolsPageLumberAxeEntryDown:GetTall() )
			ToolsPageLumberAxeEntryDown:SetText( "" )
			local Alpha = 100
			ToolsPageLumberAxeEntryDown.Paint = function( self2, w, h )
				if( self2:IsHovered() and !self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+5, 100, 200 )
				elseif( self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 100, 255 )
				else
					Alpha = math.Clamp( Alpha-5, 100, 255 )
				end
	
				draw.SimpleText( "▼", "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255, Alpha ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ToolsPageLumberAxeEntryDown.DoClick = function()
				if( not BCS_ADMIN_CFG.Tools.LumberAxe[k+1] ) then return end

				local TempChange = BCS_ADMIN_CFG.Tools.LumberAxe[k+1]

				BCS_ADMIN_CFG.Tools.LumberAxe[k+1] = v
				BCS_ADMIN_CFG.Tools.LumberAxe[k] = TempChange

				BCS_ADMIN_CFG_CHANGED = true

				RefreshTools()
			end

			local ToolsPageLumberAxeEntryIcon = vgui.Create( "DModelPanel", ToolsPageLumberAxeEntry )
			ToolsPageLumberAxeEntryIcon:Dock( LEFT )
			ToolsPageLumberAxeEntryIcon:DockMargin( LeftSpacing+30, 0, 0, 0 )
			ToolsPageLumberAxeEntryIcon:SetWide( ToolsPageLumberAxeEntry:GetTall() )
			ToolsPageLumberAxeEntryIcon:SetModel( BRICKSCRAFTING.LUACONFIG.Defaults.LumberAxeModel )		
			ToolsPageLumberAxeEntryIcon:SetColor( v.Color or Color( 255, 255, 255 ) )		
			if( IsValid( ToolsPageLumberAxeEntryIcon.Entity ) ) then
				local mn, mx = ToolsPageLumberAxeEntryIcon.Entity:GetRenderBounds()
				local size = 0
				size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
				size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
				size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

				ToolsPageLumberAxeEntryIcon:SetFOV( 45 )
				ToolsPageLumberAxeEntryIcon:SetCamPos( Vector( size, size, size ) )
				ToolsPageLumberAxeEntryIcon:SetLookAt( ( mn + mx ) * 0.5 )
				function ToolsPageLumberAxeEntryIcon:LayoutEntity( Entity ) return end
			end

			local ItemEditButton = vgui.Create( "DButton", ToolsPageLumberAxeEntry )
			ItemEditButton:Dock( RIGHT )
			ItemEditButton:SetWide( ToolsPageLumberAxeEntry:GetTall() )
			ItemEditButton:SetText( "" )
			local Alpha = 0
			ItemEditButton.Paint = function( self2, w, h )
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
				
				draw.SimpleText( BRICKSCRAFTING.L("vguiEdit"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ItemEditButton.DoClick = function()
				if( not IsValid( BCS_AdminEditTools) ) then
					BCS_AdminEditTools = vgui.Create( "brickscrafting_vgui_admin_edittool" ) 
					BCS_AdminEditTools:SetToolData( BCS_ADMIN_CFG.Tools.LumberAxe, k, BRICKSCRAFTING.LUACONFIG.Defaults.LumberAxeModel )
					BCS_AdminEditTools.func_Close = function()
						RefreshTools()
					end
				end
			end

			local ItemDeleteButton = vgui.Create( "DButton", ToolsPageLumberAxeEntry )
			ItemDeleteButton:SetPos( 0, 0 )
			ItemDeleteButton:SetSize( ((900/1920)*ScrW())-94-35-37-13-ToolsPageLumberAxeEntry:GetTall(), ToolsPageLumberAxeEntry:GetTall() )
			ItemDeleteButton:SetText( "" )
			local Alpha = 0
			ItemDeleteButton.Paint = function( self2, w, h )
				if( self2:IsHovered() and !self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 150 )
				elseif( self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 240 )
				else
					Alpha = math.Clamp( Alpha-10, 0, 150 )
				end
	
				surface.SetDrawColor( 10, 10, 20, Alpha )
				surface.DrawRect( 0, 0, w, h )
				
				draw.SimpleText( BRICKSCRAFTING.L("vguiDelete"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255, Alpha*2 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
			ItemDeleteButton.DoClick = function()
				BCS_DRAWING.Query( BRICKSCRAFTING.L("vguiDeleteConfirm"), BRICKSCRAFTING.L("vguiDeleteConfirmation"), BRICKSCRAFTING.L("vguiConfirm"), function() 
					table.remove( BCS_ADMIN_CFG.Tools.LumberAxe, k )
					BCS_ADMIN_CFG_CHANGED = true
					RefreshTools()
				end, BRICKSCRAFTING.L("vguiCancel"), function() end )
			end
		end
	end
	RefreshTools()

	ColSheet:AddSheet( ToolsPage, BRICKSCRAFTING.L("vguiConfigTools") )

	function self:SearchRefresh( text )
		self.SearchBarText = text
		RefreshRarity()
		RefreshBenches()
		self.RefreshItems()
		RefreshQuests()
		RefreshMining()
		RefreshResources()
		RefreshWoodCutting()
	end
end

function PANEL:Paint( w, h )
end

vgui.Register( "bcs_vgui_admin_config", PANEL, "DPanel" )