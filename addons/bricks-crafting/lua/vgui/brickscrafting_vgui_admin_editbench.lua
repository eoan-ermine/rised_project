-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_admin_editbench.lua"
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

function PANEL:SetItemData( BenchType )
	local ScrollY, ScrollH = ((ScrH()/2)-(self.PanelBack:GetTall()/2))+30, self.PanelBack:GetTall()-30

	self.PanelBack:Clear()

	if( BCS_ADMIN_CFG.Crafting[BenchType] ) then
		local BenchTable = BCS_ADMIN_CFG.Crafting[BenchType]

		local RarityPage
		local ResourcePage

		local BasicInfoPage = vgui.Create( "DPanel", self.PanelBack )
		BasicInfoPage:SetPos( 0, 30 )
		BasicInfoPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
		BasicInfoPage.Paint = function( self2, w, h ) end

		local BasicInfoModelPanel = vgui.Create( "DModelPanel", BasicInfoPage )
		BasicInfoModelPanel:Dock( TOP )
		BasicInfoModelPanel:DockMargin( 0, 0, 0, 0 )
		BasicInfoModelPanel:SetTall( BasicInfoPage:GetTall()-10-200 )
		BasicInfoModelPanel:SetModel( BenchTable.model )		
		if( IsValid( BasicInfoModelPanel.Entity ) ) then
			local mn, mx = BasicInfoModelPanel.Entity:GetRenderBounds()
			local size = 0
			size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
			size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
			size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )
		
			BasicInfoModelPanel:SetFOV( 125 )
			BasicInfoModelPanel:SetCamPos( Vector( size, size, size ) )
			BasicInfoModelPanel:SetLookAt( ( mn + mx ) * 0.5 )
			function BasicInfoModelPanel:LayoutEntity( Entity ) return end
		end
	
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
			BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigBenchModel"), BRICKSCRAFTING.L("vguiConfigBenchModelEntry"), BenchTable.model, function( text ) 
				BasicInfoModelPanel:SetModel( text )	
			end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
		end

		--[[ Hint Button ]]--
		local HintButton = vgui.Create( "DButton", BasicInfoModelPanelCover )
		HintButton:SetSize( 32, 32 )
		HintButton:SetPos( BasicInfoPage:GetWide()-10-HintButton:GetWide(), 10 )
		HintButton:SetText( "" )
		HintButton:SetToolTip( BRICKSCRAFTING.L("vguiConfigBenchHint") )
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
			notification.AddLegacy( BRICKSCRAFTING.L("vguiConfigBenchHint"), 1, 5 )
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

			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigBenchName"), "BCS_Roboto_17", w/2, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	
		local BasicInfoNameText = vgui.Create( "DTextEntry", BasicInfoNameDes )
		BasicInfoNameText:Dock( FILL )
		BasicInfoNameText:DockMargin( 10, 25, 10, 10 )
		BasicInfoNameText:SetWide( (BasicInfoPage:GetWide()-20-30)/2 )
		BasicInfoNameText:SetText( BenchTable.Name )

		local BasicInfoSkillBack = vgui.Create( "DPanel", BasicInfoPage )
		BasicInfoSkillBack:Dock( TOP )
		BasicInfoSkillBack:DockMargin( 10, 10, 10, 0 )
		BasicInfoSkillBack:SetTall( 65 )
		BasicInfoSkillBack.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	

			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigBenchSkillNamePopup"), "BCS_Roboto_17", w/4, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigBenchMaxSkillPopup"), "BCS_Roboto_17", (w/4)*3, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	
		local BasicInfoSkillName = vgui.Create( "DTextEntry", BasicInfoSkillBack )
		BasicInfoSkillName:Dock( LEFT )
		BasicInfoSkillName:DockMargin( 10, 10+15, 10, 10 )
		BasicInfoSkillName:SetWide( (BasicInfoPage:GetWide()-20-30)/2 )
		BasicInfoSkillName:SetText( BenchTable.Skill[1] )

		local BasicInfoSkillMax = vgui.Create( "DNumberWang", BasicInfoSkillBack )
		BasicInfoSkillMax:Dock( RIGHT )
		BasicInfoSkillMax:DockMargin( 10, 10+15, 10, 10 )
		BasicInfoSkillMax:SetWide( (BasicInfoPage:GetWide()-20-40)/2 )
		BasicInfoSkillMax:SetValue( BenchTable.Skill[2] )

		local BasicInfoPageFinish = vgui.Create( "DButton", BasicInfoPage )
		BasicInfoPageFinish:Dock( BOTTOM )
		BasicInfoPageFinish:DockMargin( 10, 0, 10, 10 )
		BasicInfoPageFinish:SetTall( 40 )
		BasicInfoPageFinish:SetText( "" )
		local Alpha = 0
		BasicInfoPageFinish.Paint = function( self2, w, h )
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

			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigBenchSaveChanges"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		BasicInfoPageFinish.DoClick = function()
			BCS_ADMIN_CFG.Crafting[BenchType].Name = BasicInfoNameText:GetText()
			BCS_ADMIN_CFG.Crafting[BenchType].Skill = { BasicInfoSkillName:GetText(), BasicInfoSkillMax:GetValue() }
			BCS_ADMIN_CFG.Crafting[BenchType].model = (BasicInfoModelPanel:GetModel() or "")

			BCS_ADMIN_CFG_CHANGED = true
	
			if( self.func_Close ) then
				self.func_Close()
			end

			self.PanelBack:MoveTo( (ScrW()/2)-(self.PanelBack:GetWide()/2), ScrH(), 0.25, 0, 1, function() 
				self:Remove()
			end )
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
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigBenchEditor"), "BCS_Roboto_22", w/2, (h-BCS_DRAWING.ShadowSize)/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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

vgui.Register( "brickscrafting_vgui_admin_editbench", PANEL, "DFrame" )