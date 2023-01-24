-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_npc_training.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local PANEL = {}

function PANEL:Init()
	-- Training Page --
	local TrainingPage = vgui.Create( "brickscrafting_vgui_colsheet_top", self )
	TrainingPage:Dock( FILL )
	TrainingPage.Paint = function( self, w, h ) 
	end

	PanelSelf = self
	local ActiveBenchPage = ""
	function self:RefreshTraining()
		TrainingPage.Navigation:Clear()
		TrainingPage.Content:Clear()

		for key, val in pairs( BRICKSCRAFTING.CONFIG.Crafting ) do
			local ItemsToLearn = 0

			local TrainingPageBenchpage = vgui.Create( "DPanel", TrainingPage )
			TrainingPageBenchpage:Dock( FILL )
			TrainingPageBenchpage.Paint = function( self2, w, h )
				if( ItemsToLearn <= 0 ) then
					surface.SetDrawColor( 0, 0, 0, 100 )
					surface.DrawRect( 0, 10, w-37-13, h )
					
					draw.SimpleText( BRICKSCRAFTING.L("vguiNPCTrainingAllItems"), "BCS_Roboto_25", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
			end

			local TrainingPageBenchpageScroll = vgui.Create( "brickscrafting_scrollpanel", TrainingPageBenchpage )
			TrainingPageBenchpageScroll:Dock( FILL )
			TrainingPageBenchpageScroll:DockMargin( 0, 15, 0, 0 )
			TrainingPageBenchpageScroll.Paint = function( self2, w, h )
			end

			if( BRICKSCRAFTING.CONFIG.Crafting[key].Items ) then
				local ItemsTable = BRICKSCRAFTING.CONFIG.Crafting[key].Items
				for k, v in pairs( ItemsTable ) do
					ItemsTable[k].iKey = k
				end

				local NewItemsTable = ItemsTable
				--table.sort( NewItemsTable, function( a, b ) return (a.Skill or 0) < (b.Skill or 0) end )

				for k, v in pairs( NewItemsTable ) do
					if( not v.Cost and not v.Skill ) then
						continue
					end

					if( IsValid( self.SearchBar ) ) then
						if( not string.find( string.lower( v.Name ), string.lower( self.SearchBar:GetValue() ) ) ) then continue end
					end

					local MiscTable = LocalPlayer():GetBCS_MiscTable()
					if( MiscTable and MiscTable.LearntCrafts and MiscTable.LearntCrafts[key] ) then
						if( table.HasValue( MiscTable.LearntCrafts[key], v.iKey ) ) then
							continue
						end
					end

					ItemsToLearn = ItemsToLearn+1

					local ItemEntry = vgui.Create( "DPanel", TrainingPageBenchpageScroll )
					ItemEntry:Dock( TOP )
					ItemEntry:DockMargin( 0, 0, 37, 15 )
					ItemEntry:SetTall( 125 )
					local ResourceString = ""
					for key, val in pairs( v.Resources ) do
						if( BRICKSCRAFTING.CONFIG.Resources[key] ) then
							ResourceString = ResourceString .. key .. ": " .. val .. "	"
						end
					end
					local InvX, InvY = 0, (ScrH()/2)-(((710/1080)*ScrH()+50)/2)
					local ScrollY, ScrollH = InvY+200+15+15, ((710/1080)*ScrH()+50)-200-65-30
					ItemEntry.Paint = function( self2, w, h )
						BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
						surface.SetDrawColor( 30, 30, 44 )
						local x, y = self2:LocalToScreen( 0, 0 )
						surface.DrawRect( x, y, w, h )			
						BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )

						surface.SetDrawColor( 30, 30, 44 )
						surface.DrawRect( 0, 0, w, h )	
						
						draw.SimpleText( v.Name, "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
						draw.SimpleText( v.Description, "BCS_Roboto_16", h+20, 52, Color( 255, 255, 255 ), 0, 0 )
						draw.SimpleText( ResourceString, "BCS_Roboto_16", h+20, 73, Color( 255, 255, 255 ), 0, 0 )
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
					
					local ItemIconCover = vgui.Create( "DPanel", InvItemIcon )
					ItemIconCover:Dock( FILL )
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
					ItemIconCover:SetToolTip( ResourceString )
					ItemIconCover.Paint = function() end
					
					local ItemCraftButton = vgui.Create( "DButton", ItemEntry )
					ItemCraftButton:Dock( RIGHT )
					ItemCraftButton:SetWide( ItemEntry:GetTall()+10 )
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
						
						draw.SimpleText( BRICKSCRAFTING.L("vguiNPCTrainingLearn"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

						if( BRICKSCRAFTING.LUACONFIG.DarkRP and v.Cost ) then
							draw.SimpleText( DarkRP.formatMoney( v.Cost ), "BCS_Roboto_18", w/2, h-(h/4)-10, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
						else
							draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickFree"), "BCS_Roboto_18", w/2, h-(h/4)-10, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
						end
					end
					ItemCraftButton.DoClick = function()
						net.Start( "BCS_Net_LearnItem" )
							net.WriteString( key )
							net.WriteInt( v.iKey, 32 )
						net.SendToServer()
					end

					if( (v.Skill or 0) > LocalPlayer():GetBCS_SkillLevel( key ) ) then
						local ItemEntryCover = vgui.Create( "DPanel", ItemEntry )
						ItemEntryCover:SetPos( 0, 0 )
						ItemEntryCover:SetSize( ((900/1920)*ScrW())-94-35-37-13, ItemEntry:GetTall() )
						ItemEntryCover.Paint = function( self2, w, h )
							surface.SetDrawColor( 0, 0, 0, 200 )
							surface.DrawRect( 0, 0, w, h )
							
							draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickReqSkill") .. " " .. (v.Skill or 0), "DermaLarge", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
						end
					end
				end
			end
		
			TrainingPage:AddSheet( TrainingPageBenchpage, key, function() 
				ActiveBenchPage = key
			end )
		end

		TrainingPage:SetActivePage( ActiveBenchPage )
	end

	self:RefreshTraining()
end

function PANEL:SetSearchBar( srchBar )
	self.SearchBar = srchBar
	srchBar.OnTextChanged = function( text )
		self:RefreshTraining()
	end
end

function PANEL:Paint( w, h )
end

vgui.Register( "brickscrafting_vgui_npc_training", PANEL, "DPanel" )