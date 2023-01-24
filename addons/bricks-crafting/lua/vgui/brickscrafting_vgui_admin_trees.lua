-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_admin_trees.lua"
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
end

function PANEL:SetTreeName( TreeName )
	self.PanelBack:Clear()

	local ScrollY, ScrollH = ((ScrH()/2)-(self.PanelBack:GetTall()/2))+30, self.PanelBack:GetTall()-30

	if( not BCS_ADMIN_CFG.WoodCutting[TreeName] ) then
		local TreeTable = {}
		TreeTable.model = BRICKSCRAFTING.LUACONFIG.Defaults.TreeModel

		local ColorPage
		local ResourcePage

		local BasicInfoPage = vgui.Create( "DPanel", self.PanelBack )
		BasicInfoPage:SetPos( 0, 30 )
		BasicInfoPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
		BasicInfoPage.Paint = function( self2, w, h ) end

		local BasicInfoModelPanel = vgui.Create( "DModelPanel", BasicInfoPage )
		BasicInfoModelPanel:Dock( TOP )
		BasicInfoModelPanel:DockMargin( 0, 0, 0, 0 )
		BasicInfoModelPanel:SetTall( BasicInfoPage:GetTall()-10-125 )
		BasicInfoModelPanel:SetModel( BRICKSCRAFTING.LUACONFIG.Defaults.TreeModel )		
		local mn, mx = BasicInfoModelPanel.Entity:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
		size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
		size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
	
		BasicInfoModelPanel:SetFOV( 125 )
		BasicInfoModelPanel:SetCamPos( Vector( size, size, size ) )
		BasicInfoModelPanel:SetLookAt( ( mn + mx ) * 0.5 )
		function BasicInfoModelPanel:LayoutEntity( Entity ) return end
	
		local BasicInfoModelPanelCover = vgui.Create( "DButton", BasicInfoModelPanel )
		BasicInfoModelPanelCover:Dock( FILL )
		BasicInfoModelPanelCover:SetText( "" )
		local Alpha = 0
		BasicInfoModelPanelCover.Paint = function( self2, w, h )
			if( self2:IsHovered() and !self2:IsDown() ) then
				Alpha = math.Clamp( Alpha+5, 0, 100 )
			elseif( self2:IsDown() ) then
				Alpha = math.Clamp( Alpha+10, 0, 200 )
			else
				Alpha = math.Clamp( Alpha-5, 0, 100 )
			end

			surface.SetDrawColor( 20, 20, 30, Alpha )
			surface.DrawRect( 0, 0, w, h )
		end
		BasicInfoModelPanelCover.DoClick = function()
			BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigWoodTreeModel"), BRICKSCRAFTING.L("vguiConfigWoodTreeModelPath"), TreeTable.model or BRICKSCRAFTING.LUACONFIG.Defaults.TreeModel, function( text ) 
				TreeTable.model = text
				BasicInfoModelPanel:SetModel( TreeTable.model )	
			end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
		end

		--[[ Hint Button ]]--
		local HintButton = vgui.Create( "DButton", BasicInfoModelPanelCover )
		HintButton:SetSize( 32, 32 )
		HintButton:SetPos( BasicInfoPage:GetWide()-10-HintButton:GetWide(), 10 )
		HintButton:SetText( "" )
		HintButton:SetToolTip( BRICKSCRAFTING.L("vguiConfigWoodTreeModelHint") )
		local CloseMat = BCS_DRAWING.GetMaterial( "IconHint" )
		local Alpha = 0
		HintButton.Paint = function( self2, w, h )
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
			surface.SetMaterial( CloseMat )
			local Spacing = 10
			surface.DrawTexturedRect( Spacing, Spacing, w-(2*Spacing), h-(2*Spacing) )
		end
		HintButton.DoClick = function()
			notification.AddLegacy( BRICKSCRAFTING.L("vguiConfigWoodTreeModelHint"), 1, 5 )
		end

		local BasicInfoNameDes = vgui.Create( "DPanel", BasicInfoPage )
		BasicInfoNameDes:Dock( TOP )
		BasicInfoNameDes:DockMargin( 10, 10, 10, 0 )
		BasicInfoNameDes:SetTall( 65 )
		BasicInfoNameDes.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigWoodTreeCuttingTime"), "BCS_Roboto_17", w/4, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigWoodTreeRewardAm"), "BCS_Roboto_17", (w/4)*3, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	
		local BasicInfoNameText = vgui.Create( "DNumberWang", BasicInfoNameDes )
		BasicInfoNameText:Dock( LEFT )
		BasicInfoNameText:DockMargin( 10, 10+15, 10, 10 )
		BasicInfoNameText:SetWide( ((BasicInfoPage:GetWide()-20)/2)-20 )
		BasicInfoNameText:SetValue( 5 )
		BasicInfoNameText:SetToolTip( BRICKSCRAFTING.L("vguiConfigWoodTreeCuttingTimeHint") )

		local BasicInfoNameTextBase = vgui.Create( "DNumberWang", BasicInfoNameDes )
		BasicInfoNameTextBase:Dock( RIGHT )
		BasicInfoNameTextBase:DockMargin( 10, 10+15, 10, 10 )
		BasicInfoNameTextBase:SetWide( ((BasicInfoPage:GetWide()-20)/2)-20 )
		BasicInfoNameTextBase:SetValue( 10 )
		BasicInfoNameTextBase:SetToolTip( BRICKSCRAFTING.L("vguiConfigWoodTreeRewardAmHint") )

		local BasicInfoNext = vgui.Create( "DButton", BasicInfoPage )
		BasicInfoNext:Dock( TOP )
		BasicInfoNext:DockMargin( 10, 10, 10, 0 )
		BasicInfoNext:SetTall( 40 )
		BasicInfoNext:SetText( "" )
		local Alpha = 0
		BasicInfoNext.Paint = function( self2, w, h )
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

			draw.SimpleText( BRICKSCRAFTING.L("vguiNextPage"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		BasicInfoNext.DoClick = function()
			TreeTable.BaseReward = BasicInfoNameTextBase:GetValue()

			BasicInfoPage:MoveTo( 0, -BasicInfoPage:GetTall(), 0.5, 0, 1, function() 
				BasicInfoPage:SetVisible( false )
			end )

			ColorPage:SetVisible( true )
			ColorPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
			end )
		end

		--  Color Mixer
		ColorPage = vgui.Create( "DPanel", self.PanelBack )
		ColorPage:SetPos( 0, self.PanelBack:GetTall() )
		ColorPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
		ColorPage:SetVisible( false )
		ColorPage.Paint = function( self2, w, h ) end

		local CloseColorEditor = vgui.Create( "DButton", ColorPage )
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

			draw.SimpleText( BRICKSCRAFTING.L("vguiNextPage"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end

		local ColorEditorVisual = vgui.Create( "DPanel", ColorPage )
		ColorEditorVisual:Dock( BOTTOM )
		ColorEditorVisual:DockMargin( 10, 10, 10, 0 )
		ColorEditorVisual:SetTall( 40 )
		ColorEditorVisual:SetText( "" )
	
		local ColorMixer = vgui.Create( "DColorMixer", ColorPage )
		ColorMixer:Dock( FILL )
		ColorMixer:DockMargin( 10, 10, 10, 0 )
		ColorMixer:SetPalette( false )
		ColorMixer:SetAlphaBar( false )
		ColorMixer:SetWangs( true )
		ColorMixer:SetColor( Color( 255, 255, 255 ) )

		ColorEditorVisual.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.SetDrawColor( ColorMixer:GetColor() or Color( 255, 255, 255 ) )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(2, 2, 1, 255, w, 5, false )	
		end
	
		CloseColorEditor.DoClick = function()
			TreeTable.color = ColorMixer:GetColor()

			ColorPage:MoveTo( 0, -ColorPage:GetTall(), 0.5, 0, 1, function() 
				ColorPage:SetVisible( false )
			end )

			ResourcePage:SetVisible( true )
			ResourcePage:MoveTo( 0, 30, 0.5, 0, 1, function() 
			end )
		end

		-- Resource Cost
		ResourcePage = vgui.Create( "DPanel", self.PanelBack )
		ResourcePage:SetPos( 0, self.PanelBack:GetTall() )
		ResourcePage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
		ResourcePage:SetVisible( false )
		ResourcePage.Paint = function( self2, w, h ) end

		local ResourcesToGive = {}

		local ResourceHeader = vgui.Create( "DPanel", ResourcePage )
		ResourceHeader:Dock( TOP )
		ResourceHeader:DockMargin( 10, 10, 10, 0 )
		ResourceHeader:SetTall( 30 )
		ResourceHeader.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	

			local TotalPercent = 0
			for k, v in pairs( ResourcesToGive ) do
				TotalPercent = TotalPercent+v
			end
			
			if( TotalPercent <= 100 ) then
				draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiConfigGarbageTotalPercent"), TotalPercent ), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
				draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiConfigGarbageTotalPercent"), TotalPercent ), "BCS_Roboto_17", w/2, h/2, Color( 255, 75, 75 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
		end

		local ResourceFinish = vgui.Create( "DButton", ResourcePage )
		ResourceFinish:Dock( BOTTOM )
		ResourceFinish:DockMargin( 10, 0, 10, 10 )
		ResourceFinish:SetTall( 40 )
		ResourceFinish:SetText( "" )
		local Alpha = 0
		ResourceFinish.Paint = function( self2, w, h )
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

			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigWoodTreeCreate"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		ResourceFinish.DoClick = function()
			TreeTable.resource = ResourcesToGive

			BCS_ADMIN_CFG.WoodCutting[TreeName] = TreeTable
			BCS_ADMIN_CFG_CHANGED = true

			if( self.func_Close ) then
				self.func_Close()
			end

			self:Remove()
		end

		local ResourceScroll = vgui.Create( "brickscrafting_scrollpanel", ResourcePage )
		ResourceScroll:Dock( FILL )
		ResourceScroll:DockMargin( 0, 10, 10, 10 )

		local ItemWide = 6
		local Spacing = 0
		local Size = ((ResourcePage:GetWide()-20-13-((ItemWide-1)*Spacing))/ItemWide)

		local ResourceList = vgui.Create( "DIconLayout", ResourceScroll )
		ResourceList:Dock( FILL )
		ResourceList:DockMargin( 0, 0, 10, 0 )
		ResourceList:SetSpaceX( Spacing )
		ResourceList:SetSpaceY( Spacing )

		for k, v in pairs( BCS_ADMIN_CFG.Resources ) do
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
				local x, y = self2:LocalToScreen( ExtraEdge, ExtraEdge )
				surface.SetDrawColor( 30, 30, 44 )
				surface.DrawRect( x, y, w-(2*ExtraEdge), h-(2*ExtraEdge) )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	
		
				surface.SetDrawColor( 20, 20, 30, Alpha )
				surface.DrawRect( ExtraEdge, ExtraEdge, w-(2*ExtraEdge), h-(2*ExtraEdge) )
		
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial( ResourceMat )
				local Spacing = 10
				surface.DrawTexturedRect( ExtraEdge+Spacing, ExtraEdge+Spacing, w-(2*Spacing)-(2*ExtraEdge), h-(2*Spacing)-(2*ExtraEdge) )
				draw.SimpleText( (ResourcesToGive[k] or 0) .. "%", "BCS_Roboto_17", w-ExtraEdge+5, ExtraEdge, Color( 0, 128, 181 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
			end
			ResourceEntryIcon.DoClick = function()
				BCS_DRAWING.StringRequest( k .. BRICKSCRAFTING.L("vguiConfigMiningRockPercentage"), string.format( BRICKSCRAFTING.L("vguiConfigMiningRockRes"), k ), 0, function( text )
					if( isnumber( tonumber( text ) ) ) then
						ResourcesToGive[k] = tonumber( text )
					end
				end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
			end
		end
	end

	--[[ Top Bar ]]--
	local TopBar = vgui.Create( "DPanel", self.PanelBack )
	TopBar:SetPos( 0, 0 )
	TopBar:SetSize( self.PanelBack:GetWide(), 30+BCS_DRAWING.ShadowSize )
	TopBar.Paint = function( self2, w, h )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( 0, 0, w, h-BCS_DRAWING.ShadowSize )

		BCS_DRAWING.DrawMaterialShadow( 0, h-BCS_DRAWING.ShadowSize, w, BCS_DRAWING.ShadowSize, "Down" )
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigWoodTreeCreator"), "BCS_Roboto_22", w/2, (h-BCS_DRAWING.ShadowSize)/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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

function PANEL:Paint( w, h )
end

vgui.Register( "brickscrafting_vgui_admin_addtree", PANEL, "DFrame" )




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
end

function PANEL:SetTreeData( TreeKey )
	self.PanelBack:Clear()

	local ScrollY, ScrollH = ((ScrH()/2)-(self.PanelBack:GetTall()/2))+30, self.PanelBack:GetTall()-30

	if( BCS_ADMIN_CFG.WoodCutting[TreeKey] ) then
		local TreeTable = BCS_ADMIN_CFG.WoodCutting[TreeKey]

		local ColorPage
		local ResourcePage

		local BasicInfoPage = vgui.Create( "DPanel", self.PanelBack )
		BasicInfoPage:SetPos( 0, 30 )
		BasicInfoPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
		BasicInfoPage.Paint = function( self2, w, h ) end

		local BasicInfoModelPanel = vgui.Create( "DModelPanel", BasicInfoPage )
		BasicInfoModelPanel:Dock( TOP )
		BasicInfoModelPanel:DockMargin( 0, 0, 0, 0 )
		BasicInfoModelPanel:SetTall( BasicInfoPage:GetTall()-10-265 )
		BasicInfoModelPanel:SetModel( TreeTable.model )		
		local mn, mx = BasicInfoModelPanel.Entity:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
		size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
		size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
	
		BasicInfoModelPanel:SetFOV( 125 )
		BasicInfoModelPanel:SetCamPos( Vector( size, size, size ) )
		BasicInfoModelPanel:SetLookAt( ( mn + mx ) * 0.5 )
		function BasicInfoModelPanel:LayoutEntity( Entity ) return end
	
		local BasicInfoModelPanelCover = vgui.Create( "DButton", BasicInfoModelPanel )
		BasicInfoModelPanelCover:Dock( FILL )
		BasicInfoModelPanelCover:SetText( "" )
		local Alpha = 0
		BasicInfoModelPanelCover.Paint = function( self2, w, h )
			if( self2:IsHovered() and !self2:IsDown() ) then
				Alpha = math.Clamp( Alpha+5, 0, 100 )
			elseif( self2:IsDown() ) then
				Alpha = math.Clamp( Alpha+10, 0, 200 )
			else
				Alpha = math.Clamp( Alpha-5, 0, 100 )
			end

			surface.SetDrawColor( 20, 20, 30, Alpha )
			surface.DrawRect( 0, 0, w, h )
		end
		BasicInfoModelPanelCover.DoClick = function()
			BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigWoodTreeModel"), BRICKSCRAFTING.L("vguiConfigWoodTreeModelPath"), TreeTable.model, function( text ) 
				TreeTable.model = text
				BasicInfoModelPanel:SetModel( TreeTable.model )	
			end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
		end

		--[[ Hint Button ]]--
		local HintButton = vgui.Create( "DButton", BasicInfoModelPanelCover )
		HintButton:SetSize( 32, 32 )
		HintButton:SetPos( BasicInfoPage:GetWide()-10-HintButton:GetWide(), 10 )
		HintButton:SetText( "" )
		HintButton:SetToolTip( BRICKSCRAFTING.L("vguiConfigWoodTreeModelHint") )
		local CloseMat = BCS_DRAWING.GetMaterial( "IconHint" )
		local Alpha = 0
		HintButton.Paint = function( self2, w, h )
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
			surface.SetMaterial( CloseMat )
			local Spacing = 10
			surface.DrawTexturedRect( Spacing, Spacing, w-(2*Spacing), h-(2*Spacing) )
		end
		HintButton.DoClick = function()
			notification.AddLegacy( BRICKSCRAFTING.L("vguiConfigWoodTreeModelHint"), 1, 5 )
		end

		local BasicInfoNameDes = vgui.Create( "DPanel", BasicInfoPage )
		BasicInfoNameDes:Dock( TOP )
		BasicInfoNameDes:DockMargin( 10, 10, 10, 0 )
		BasicInfoNameDes:SetTall( 65 )
		BasicInfoNameDes.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigWoodTreeRewardAm"), "BCS_Roboto_17", w/2, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end

		local BasicInfoNameTextBase = vgui.Create( "DNumberWang", BasicInfoNameDes )
		BasicInfoNameTextBase:Dock( FILL )
		BasicInfoNameTextBase:DockMargin( 10, 10+15, 10, 10 )
		BasicInfoNameTextBase:SetValue( TreeTable.BaseReward or 10 )
		BasicInfoNameTextBase:SetToolTip( BRICKSCRAFTING.L("vguiConfigWoodTreeRewardAmHint") )

		local BasicInfoModelType = vgui.Create( "DPanel", BasicInfoPage )
		BasicInfoModelType:Dock( TOP )
		BasicInfoModelType:DockMargin( 10, 10, 10, 0 )
		BasicInfoModelType:SetTall( 130 )
		BasicInfoModelType.Paint = function( self2, w, h ) end
	
		local BasicInfoExtra = vgui.Create( "DPanel", BasicInfoModelType )
		BasicInfoExtra:Dock( FILL )
		BasicInfoExtra.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
		end

		local BasicInfoExtraRarity = vgui.Create( "DButton", BasicInfoExtra )
		BasicInfoExtraRarity:Dock( TOP )
		BasicInfoExtraRarity:DockMargin( 10, 10, 10, 0 )
		BasicInfoExtraRarity:SetTall( 50 )
		BasicInfoExtraRarity:SetText( "" )
		local Alpha = 100
		BasicInfoExtraRarity.Paint = function( self2, w, h )
			if( self2:IsHovered() and !self2:IsDown() ) then
				Alpha = math.Clamp( Alpha+5, 100, 150 )
			elseif( self2:IsDown() ) then
				Alpha = math.Clamp( Alpha+10, 100, 250 )
			else
				Alpha = math.Clamp( Alpha-5, 100, 150 )
			end
	
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )				
	
			surface.SetDrawColor( 20, 20, 30, Alpha )
			surface.DrawRect( 0, 0, w, h )

			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigWoodTreeColor"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		BasicInfoExtraRarity.DoClick = function()
			BasicInfoPage:MoveTo( 0, -BasicInfoPage:GetTall(), 0.5, 0, 1, function() 
				BasicInfoPage:SetVisible( false )
			end )

			ColorPage:SetVisible( true )
			ColorPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
			end )
		end

		local BasicInfoExtraResources = vgui.Create( "DButton", BasicInfoExtra )
		BasicInfoExtraResources:Dock( TOP )
		BasicInfoExtraResources:DockMargin( 10, 10, 10, 0 )
		BasicInfoExtraResources:SetTall( 50 )
		BasicInfoExtraResources:SetText( "" )
		local Alpha = 100
		BasicInfoExtraResources.Paint = function( self2, w, h )
			if( self2:IsHovered() and !self2:IsDown() ) then
				Alpha = math.Clamp( Alpha+5, 100, 150 )
			elseif( self2:IsDown() ) then
				Alpha = math.Clamp( Alpha+10, 100, 250 )
			else
				Alpha = math.Clamp( Alpha-5, 100, 150 )
			end
	
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )				
	
			surface.SetDrawColor( 20, 20, 30, Alpha )
			surface.DrawRect( 0, 0, w, h )

			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigMiningRockResRewards"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		BasicInfoExtraResources.DoClick = function()
			BasicInfoPage:MoveTo( 0, BasicInfoPage:GetTall(), 0.5, 0, 1, function() 
				BasicInfoPage:SetVisible( false )
			end )

			ResourcePage:SetVisible( true )
			ResourcePage:MoveTo( 0, 30, 0.5, 0, 1, function() 
			end )
		end

		--  Color Mixer
		ColorPage = vgui.Create( "DPanel", self.PanelBack )
		ColorPage:SetPos( 0, self.PanelBack:GetTall() )
		ColorPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
		ColorPage:SetVisible( false )
		ColorPage.Paint = function( self2, w, h ) end

		local CloseColorEditor = vgui.Create( "DButton", ColorPage )
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

		local ColorEditorVisual = vgui.Create( "DPanel", ColorPage )
		ColorEditorVisual:Dock( BOTTOM )
		ColorEditorVisual:DockMargin( 10, 10, 10, 0 )
		ColorEditorVisual:SetTall( 40 )
		ColorEditorVisual:SetText( "" )
	
		local ColorMixer = vgui.Create( "DColorMixer", ColorPage )
		ColorMixer:Dock( FILL )
		ColorMixer:DockMargin( 10, 10, 10, 0 )
		ColorMixer:SetPalette( false )
		ColorMixer:SetAlphaBar( false )
		ColorMixer:SetWangs( true )
		ColorMixer:SetColor( TreeTable.color or Color( 255, 255, 255 ) )

		ColorEditorVisual.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.SetDrawColor( ColorMixer:GetColor() or Color( 255, 255, 255 ) )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
		end
	
		CloseColorEditor.DoClick = function()
			BasicInfoPage:SetVisible( true )
			BasicInfoPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
			end )

			ColorPage:MoveTo( 0, ColorPage:GetTall(), 0.5, 0, 1, function() 
				ColorPage:SetVisible( false )
			end )
		end

		-- Resource Cost
		ResourcePage = vgui.Create( "DPanel", self.PanelBack )
		ResourcePage:SetPos( 0, -self.PanelBack:GetTall() )
		ResourcePage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
		ResourcePage:SetVisible( false )
		ResourcePage.Paint = function( self2, w, h ) end

		local ResourcesToGive = {}
		table.CopyFromTo( TreeTable.resource, ResourcesToGive )

		local ResourceHeader = vgui.Create( "DPanel", ResourcePage )
		ResourceHeader:Dock( TOP )
		ResourceHeader:DockMargin( 10, 10, 10, 0 )
		ResourceHeader:SetTall( 30 )
		ResourceHeader.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

			local TotalPercent = 0
			for k, v in pairs( ResourcesToGive ) do
				TotalPercent = TotalPercent+v
			end
			
			if( TotalPercent <= 100 ) then
				draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiConfigGarbageTotalPercent"), TotalPercent ), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
				draw.SimpleText( string.format( BRICKSCRAFTING.L("vguiConfigGarbageTotalPercent"), TotalPercent ), "BCS_Roboto_17", w/2, h/2, Color( 255, 75, 75 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
		end

		local ResourceFinish = vgui.Create( "DButton", ResourcePage )
		ResourceFinish:Dock( BOTTOM )
		ResourceFinish:DockMargin( 10, 0, 10, 10 )
		ResourceFinish:SetTall( 40 )
		ResourceFinish:SetText( "" )
		local Alpha = 0
		ResourceFinish.Paint = function( self2, w, h )
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

			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigMiningRockSetRes"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		ResourceFinish.DoClick = function()
			TreeTable.resource = ResourcesToGive

			BasicInfoPage:SetVisible( true )
			BasicInfoPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
			end )

			ResourcePage:MoveTo( 0, -ResourcePage:GetTall(), 0.5, 0, 1, function() 
				ResourcePage:SetVisible( false )
			end )
		end

		local ResourceScroll = vgui.Create( "brickscrafting_scrollpanel", ResourcePage )
		ResourceScroll:Dock( FILL )
		ResourceScroll:DockMargin( 0, 10, 10, 10 )

		local ItemWide = 6
		local Spacing = 0
		local Size = ((ResourcePage:GetWide()-20-13-((ItemWide-1)*Spacing))/ItemWide)

		local ResourceList = vgui.Create( "DIconLayout", ResourceScroll )
		ResourceList:Dock( FILL )
		ResourceList:DockMargin( 0, 0, 10, 0 )
		ResourceList:SetSpaceX( Spacing )
		ResourceList:SetSpaceY( Spacing )

		for k, v in pairs( BCS_ADMIN_CFG.Resources ) do
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
				local x, y = self2:LocalToScreen( ExtraEdge, ExtraEdge )
				surface.SetDrawColor( 30, 30, 44 )
				surface.DrawRect( x, y, w-(2*ExtraEdge), h-(2*ExtraEdge) )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
		
				surface.SetDrawColor( 20, 20, 30, Alpha )
				surface.DrawRect( ExtraEdge, ExtraEdge, w-(2*ExtraEdge), h-(2*ExtraEdge) )
		
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial( ResourceMat )
				local Spacing = 10
				surface.DrawTexturedRect( ExtraEdge+Spacing, ExtraEdge+Spacing, w-(2*Spacing)-(2*ExtraEdge), h-(2*Spacing)-(2*ExtraEdge) )
				draw.SimpleText( (ResourcesToGive[k] or 0) .. "%", "BCS_Roboto_17", w-ExtraEdge+5, ExtraEdge, Color( 0, 128, 181 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
			end
			ResourceEntryIcon.DoClick = function()
				BCS_DRAWING.StringRequest( k .. BRICKSCRAFTING.L("vguiConfigMiningRockPercentage"), string.format( BRICKSCRAFTING.L("vguiConfigMiningRockRes"), k ), 0, function( text )
					if( isnumber( tonumber( text ) ) ) then
						ResourcesToGive[k] = tonumber( text )
					end
				end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
			end
		end

		local BasicInfoNext = vgui.Create( "DButton", BasicInfoPage )
		BasicInfoNext:Dock( TOP )
		BasicInfoNext:DockMargin( 10, 10, 10, 0 )
		BasicInfoNext:SetTall( 40 )
		BasicInfoNext:SetText( "" )
		local Alpha = 0
		BasicInfoNext.Paint = function( self2, w, h )
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

			draw.SimpleText( BRICKSCRAFTING.L("vguiSaveEdits"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		BasicInfoNext.DoClick = function()
			TreeTable.BaseReward = BasicInfoNameTextBase:GetValue()
			BCS_ADMIN_CFG.WoodCutting[TreeKey] = TreeTable
			BCS_ADMIN_CFG_CHANGED = true

			if( self.func_Close ) then
				self.func_Close()
			end

			self:Remove()
		end
	end

	--[[ Top Bar ]]--
	local TopBar = vgui.Create( "DPanel", self.PanelBack )
	TopBar:SetPos( 0, 0 )
	TopBar:SetSize( self.PanelBack:GetWide(), 30+BCS_DRAWING.ShadowSize )
	TopBar.Paint = function( self2, w, h )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( 0, 0, w, h-BCS_DRAWING.ShadowSize )

		BCS_DRAWING.DrawMaterialShadow( 0, h-BCS_DRAWING.ShadowSize, w, BCS_DRAWING.ShadowSize, "Down" )
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigWoodTreeEditor"), "BCS_Roboto_22", w/2, (h-BCS_DRAWING.ShadowSize)/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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

function PANEL:Paint( w, h )
end

vgui.Register( "brickscrafting_vgui_admin_edittree", PANEL, "DFrame" )