-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_admin_tools.lua"
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

function PANEL:SetToolData( ToolCFGTable, ToolKey, ToolModel )
	self.PanelBack:Clear()

	local ScrollY, ScrollH = ((ScrH()/2)-(self.PanelBack:GetTall()/2))+30, self.PanelBack:GetTall()-30

	if( not ToolCFGTable[ToolKey] ) then return end

	local NewToolTable = ToolCFGTable[ToolKey]

	local BasicInfoPage = vgui.Create( "DPanel", self.PanelBack )
	BasicInfoPage:SetPos( 0, 30 )
	BasicInfoPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
	BasicInfoPage.Paint = function( self2, w, h ) end

	local BasicInfoPage = vgui.Create( "DPanel", self.PanelBack )
	BasicInfoPage:SetPos( 0, 30 )
	BasicInfoPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
	BasicInfoPage.Paint = function( self2, w, h ) end

	local BasicInfoModelPanel = vgui.Create( "DModelPanel", BasicInfoPage )
	BasicInfoModelPanel:Dock( TOP )
	BasicInfoModelPanel:DockMargin( 0, 0, 0, 0 )
	BasicInfoModelPanel:SetTall( BasicInfoPage:GetTall()-10-250 )
	BasicInfoModelPanel:SetModel( ToolModel )		
	BasicInfoModelPanel:SetColor( NewToolTable.Color or Color( 255, 255, 255 ) )		
	local mn, mx = BasicInfoModelPanel.Entity:GetRenderBounds()
	local size = 0
	size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
	size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
	size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

	BasicInfoModelPanel:SetFOV( 125 )
	BasicInfoModelPanel:SetCamPos( Vector( size, size, size ) )
	BasicInfoModelPanel:SetLookAt( ( mn + mx ) * 0.5 )
	function BasicInfoModelPanel:LayoutEntity( Entity ) return end

	local BasicInfoIncrease = vgui.Create( "DPanel", BasicInfoPage )
	BasicInfoIncrease:Dock( TOP )
	BasicInfoIncrease:DockMargin( 10, 10, 10, 0 )
	BasicInfoIncrease:SetTall( 65 )
	BasicInfoIncrease.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsSpeedIncrease"), "BCS_Roboto_17", w/2, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local BasicInfoIncreaseTxt = vgui.Create( "DNumberWang", BasicInfoIncrease )
	BasicInfoIncreaseTxt:Dock( FILL )
	BasicInfoIncreaseTxt:DockMargin( 10, 10+15, 10, 10 )
	BasicInfoIncreaseTxt:SetValue( NewToolTable.Increase or 0 )

	local BasicInfoCostSkill = vgui.Create( "DPanel", BasicInfoPage )
	BasicInfoCostSkill:Dock( TOP )
	BasicInfoCostSkill:DockMargin( 10, 10, 10, 0 )
	BasicInfoCostSkill:SetTall( 65 )
	BasicInfoCostSkill.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

		if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsUpgradeCost"), "BCS_Roboto_17", w/4, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsReqSkill"), "BCS_Roboto_17", (w/4)*3, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		else
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsReqSkill"), "BCS_Roboto_17", w/2, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end

	local BasicInfoCostText
	local BasicInfoSkillText
	if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then
		BasicInfoCostText = vgui.Create( "DNumberWang", BasicInfoCostSkill )
		BasicInfoCostText:Dock( LEFT )
		BasicInfoCostText:DockMargin( 10, 10+15, 10, 10 )
		BasicInfoCostText:SetWide( (BasicInfoPage:GetWide()-20-30)/2 )
		BasicInfoCostText:SetMax( 9999999999 )
		BasicInfoCostText:SetValue( NewToolTable.Cost or 0 )

		BasicInfoSkillText = vgui.Create( "DNumberWang", BasicInfoCostSkill )
		BasicInfoSkillText:Dock( RIGHT )
		BasicInfoSkillText:DockMargin( 10, 10+15, 10, 10 )
		BasicInfoSkillText:SetWide( (BasicInfoPage:GetWide()-20-40)/2 )
		BasicInfoSkillText:SetMax( 9999999999 )
		BasicInfoSkillText:SetValue( NewToolTable.Skill or 0 )
	else
		BasicInfoSkillText = vgui.Create( "DNumberWang", BasicInfoCostSkill )
		BasicInfoSkillText:Dock( FILL )
		BasicInfoSkillText:DockMargin( 10, 10+15, 10, 10 )
		BasicInfoSkillText:SetMax( 9999999999 )
		BasicInfoSkillText:SetValue( NewToolTable.Skill or 0 )
	end

	local BasicInfoColorBut = vgui.Create( "DButton", BasicInfoPage )
	BasicInfoColorBut:Dock( TOP )
	BasicInfoColorBut:DockMargin( 10, 10, 10, 10 )
	BasicInfoColorBut:SetTall( 40 )
	BasicInfoColorBut:SetText( "" )
	local Alpha = 0
	BasicInfoColorBut.Paint = function( self2, w, h )
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

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsChangeColor"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	BasicInfoColorBut.DoClick = function()
		BasicInfoPage:MoveTo( 0, -BasicInfoPage:GetTall(), 0.5, 0, 1, function() 
			BasicInfoPage:SetVisible( false )
		end )

		ColorPage:SetVisible( true )
		ColorPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
		end )
	end

	local BasicInfoFinish = vgui.Create( "DButton", BasicInfoPage )
	BasicInfoFinish:Dock( BOTTOM )
	BasicInfoFinish:DockMargin( 10, 0, 10, 10 )
	BasicInfoFinish:SetTall( 40 )
	BasicInfoFinish:SetText( "" )
	local Alpha = 0
	BasicInfoFinish.Paint = function( self2, w, h )
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
	BasicInfoFinish.DoClick = function()
		NewToolTable.Increase = BasicInfoIncreaseTxt:GetValue()

		if( BRICKSCRAFTING.LUACONFIG.DarkRP and BasicInfoCostText:GetValue() > 0 ) then
			NewToolTable.Cost = BasicInfoCostText:GetValue()
		elseif( NewToolTable.Cost ) then
			NewToolTable.Cost = nil
		end

		if( BasicInfoSkillText:GetValue() > 0 ) then
			NewToolTable.Skill = BasicInfoSkillText:GetValue()
		elseif( NewToolTable.Skill ) then
			NewToolTable.Skill = nil
		end

		ToolCFGTable[ToolKey] = NewToolTable
		BCS_ADMIN_CFG_CHANGED = true

		if( self.func_Close ) then
			self.func_Close()
		end

		self:Remove()
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
	ColorMixer:SetColor( NewToolTable.Color or Color( 255, 255, 255 ) )

	ColorEditorVisual.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.SetDrawColor( ColorMixer:GetColor() or Color( 255, 255, 255 ) )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(2, 2, 1, 255, w, 5, false )	
	end

	CloseColorEditor.DoClick = function()
		NewToolTable.Color = ColorMixer:GetColor() or Color( 255, 255, 255 )
		BasicInfoModelPanel:SetColor( NewToolTable.Color or Color( 255, 255, 255 ) )

		BasicInfoPage:SetVisible( true )
		BasicInfoPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
		end )

		ColorPage:MoveTo( 0, ColorPage:GetTall(), 0.5, 0, 1, function() 
			ColorPage:SetVisible( false )
		end )
	end

	--[[ Top Bar ]]--
	local TopBar = vgui.Create( "DPanel", self.PanelBack )
	TopBar:SetPos( 0, 0 )
	TopBar:SetSize( self.PanelBack:GetWide(), 30+BCS_DRAWING.ShadowSize )
	TopBar.Paint = function( self2, w, h )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( 0, 0, w, h-BCS_DRAWING.ShadowSize )

		BCS_DRAWING.DrawMaterialShadow( 0, h-BCS_DRAWING.ShadowSize, w, BCS_DRAWING.ShadowSize, "Down" )
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsEditor"), "BCS_Roboto_22", w/2, (h-BCS_DRAWING.ShadowSize)/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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

vgui.Register( "brickscrafting_vgui_admin_edittool", PANEL, "DFrame" )




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

function PANEL:RefreshInfo( ToolCFGTable, ToolModel )
	self.PanelBack:Clear()

	local ScrollY, ScrollH = ((ScrH()/2)-(self.PanelBack:GetTall()/2))+30, self.PanelBack:GetTall()-30

	local NewToolTable = {}

	local BasicInfoPage = vgui.Create( "DPanel", self.PanelBack )
	BasicInfoPage:SetPos( 0, 30 )
	BasicInfoPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
	BasicInfoPage.Paint = function( self2, w, h ) end

	local BasicInfoPage = vgui.Create( "DPanel", self.PanelBack )
	BasicInfoPage:SetPos( 0, 30 )
	BasicInfoPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
	BasicInfoPage.Paint = function( self2, w, h ) end

	local BasicInfoModelPanel = vgui.Create( "DModelPanel", BasicInfoPage )
	BasicInfoModelPanel:Dock( TOP )
	BasicInfoModelPanel:DockMargin( 0, 0, 0, 0 )
	BasicInfoModelPanel:SetTall( BasicInfoPage:GetTall()-10-250 )
	BasicInfoModelPanel:SetModel( ToolModel )		
	BasicInfoModelPanel:SetColor( NewToolTable.Color or Color( 255, 255, 255 ) )		
	local mn, mx = BasicInfoModelPanel.Entity:GetRenderBounds()
	local size = 0
	size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
	size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
	size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

	BasicInfoModelPanel:SetFOV( 125 )
	BasicInfoModelPanel:SetCamPos( Vector( size, size, size ) )
	BasicInfoModelPanel:SetLookAt( ( mn + mx ) * 0.5 )
	function BasicInfoModelPanel:LayoutEntity( Entity ) return end

	local BasicInfoIncrease = vgui.Create( "DPanel", BasicInfoPage )
	BasicInfoIncrease:Dock( TOP )
	BasicInfoIncrease:DockMargin( 10, 10, 10, 0 )
	BasicInfoIncrease:SetTall( 65 )
	BasicInfoIncrease.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsSpeedIncrease"), "BCS_Roboto_17", w/2, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local BasicInfoIncreaseTxt = vgui.Create( "DNumberWang", BasicInfoIncrease )
	BasicInfoIncreaseTxt:Dock( FILL )
	BasicInfoIncreaseTxt:DockMargin( 10, 10+15, 10, 10 )
	BasicInfoIncreaseTxt:SetValue( NewToolTable.Increase or 0 )

	local BasicInfoCostSkill = vgui.Create( "DPanel", BasicInfoPage )
	BasicInfoCostSkill:Dock( TOP )
	BasicInfoCostSkill:DockMargin( 10, 10, 10, 0 )
	BasicInfoCostSkill:SetTall( 65 )
	BasicInfoCostSkill.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

		if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsUpgradeCost"), "BCS_Roboto_17", w/4, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsReqSkill"), "BCS_Roboto_17", (w/4)*3, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		else
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsReqSkill"), "BCS_Roboto_17", w/2, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end

	local BasicInfoCostText
	local BasicInfoSkillText
	if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then
		BasicInfoCostText = vgui.Create( "DNumberWang", BasicInfoCostSkill )
		BasicInfoCostText:Dock( LEFT )
		BasicInfoCostText:DockMargin( 10, 10+15, 10, 10 )
		BasicInfoCostText:SetWide( (BasicInfoPage:GetWide()-20-30)/2 )
		BasicInfoCostText:SetMax( 9999999999 )
		BasicInfoCostText:SetValue( NewToolTable.Cost or 0 )

		BasicInfoSkillText = vgui.Create( "DNumberWang", BasicInfoCostSkill )
		BasicInfoSkillText:Dock( RIGHT )
		BasicInfoSkillText:DockMargin( 10, 10+15, 10, 10 )
		BasicInfoSkillText:SetWide( (BasicInfoPage:GetWide()-20-40)/2 )
		BasicInfoSkillText:SetMax( 9999999999 )
		BasicInfoSkillText:SetValue( NewToolTable.Skill or 0 )
	else
		BasicInfoSkillText = vgui.Create( "DNumberWang", BasicInfoCostSkill )
		BasicInfoSkillText:Dock( FILL )
		BasicInfoSkillText:DockMargin( 10, 10+15, 10, 10 )
		BasicInfoSkillText:SetMax( 9999999999 )
		BasicInfoSkillText:SetValue( NewToolTable.Skill or 0 )
	end

	local BasicInfoColorBut = vgui.Create( "DButton", BasicInfoPage )
	BasicInfoColorBut:Dock( TOP )
	BasicInfoColorBut:DockMargin( 10, 10, 10, 10 )
	BasicInfoColorBut:SetTall( 40 )
	BasicInfoColorBut:SetText( "" )
	local Alpha = 0
	BasicInfoColorBut.Paint = function( self2, w, h )
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

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsChangeColor"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	BasicInfoColorBut.DoClick = function()
		BasicInfoPage:MoveTo( 0, -BasicInfoPage:GetTall(), 0.5, 0, 1, function() 
			BasicInfoPage:SetVisible( false )
		end )

		ColorPage:SetVisible( true )
		ColorPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
		end )
	end

	local BasicInfoFinish = vgui.Create( "DButton", BasicInfoPage )
	BasicInfoFinish:Dock( BOTTOM )
	BasicInfoFinish:DockMargin( 10, 0, 10, 10 )
	BasicInfoFinish:SetTall( 40 )
	BasicInfoFinish:SetText( "" )
	local Alpha = 0
	BasicInfoFinish.Paint = function( self2, w, h )
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

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsCreate"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	BasicInfoFinish.DoClick = function()
		NewToolTable.Increase = BasicInfoIncreaseTxt:GetValue()

		if( BRICKSCRAFTING.LUACONFIG.DarkRP and BasicInfoCostText:GetValue() > 0 ) then
			NewToolTable.Cost = BasicInfoCostText:GetValue()
		elseif( NewToolTable.Cost ) then
			NewToolTable.Cost = nil
		end

		if( BasicInfoSkillText:GetValue() > 0 ) then
			NewToolTable.Skill = BasicInfoSkillText:GetValue()
		elseif( NewToolTable.Skill ) then
			NewToolTable.Skill = nil
		end

		table.insert( ToolCFGTable, NewToolTable )
		BCS_ADMIN_CFG_CHANGED = true

		if( self.func_Close ) then
			self.func_Close()
		end

		self:Remove()
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
	ColorMixer:SetColor( NewToolTable.Color or Color( 255, 255, 255 ) )

	ColorEditorVisual.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.SetDrawColor( ColorMixer:GetColor() or Color( 255, 255, 255 ) )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(2, 2, 1, 255, w, 5, false )	
	end

	CloseColorEditor.DoClick = function()
		NewToolTable.Color = ColorMixer:GetColor() or Color( 255, 255, 255 )
		BasicInfoModelPanel:SetColor( NewToolTable.Color or Color( 255, 255, 255 ) )

		BasicInfoPage:SetVisible( true )
		BasicInfoPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
		end )

		ColorPage:MoveTo( 0, ColorPage:GetTall(), 0.5, 0, 1, function() 
			ColorPage:SetVisible( false )
		end )
	end

	--[[ Top Bar ]]--
	local TopBar = vgui.Create( "DPanel", self.PanelBack )
	TopBar:SetPos( 0, 0 )
	TopBar:SetSize( self.PanelBack:GetWide(), 30+BCS_DRAWING.ShadowSize )
	TopBar.Paint = function( self2, w, h )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( 0, 0, w, h-BCS_DRAWING.ShadowSize )

		BCS_DRAWING.DrawMaterialShadow( 0, h-BCS_DRAWING.ShadowSize, w, BCS_DRAWING.ShadowSize, "Down" )
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigToolsCreator"), "BCS_Roboto_22", w/2, (h-BCS_DRAWING.ShadowSize)/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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

vgui.Register( "brickscrafting_vgui_admin_addtool", PANEL, "DFrame" )