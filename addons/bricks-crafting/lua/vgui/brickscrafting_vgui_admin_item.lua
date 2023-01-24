-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_admin_item.lua"
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

	--[[ ITEM CREATION ]]--
	local ScrollY, ScrollH = ((ScrH()/2)-(self.PanelBack:GetTall()/2))+30, self.PanelBack:GetTall()-30

	local NewItemTable = {}
	local BenchType = ""

	local BasicInfoPage
	local RarityPage
	local ResourcePage

	local BenchChoosePage = vgui.Create( "brickscrafting_scrollpanel", self.PanelBack )
	BenchChoosePage:SetPos( 10, 40 )
	BenchChoosePage:SetSize( self.PanelBack:GetWide()-20, self.PanelBack:GetTall()-30-20 )
	BenchChoosePage.Paint = function( self2, w, h ) end

	local BenchChooseHeader = vgui.Create( "DPanel", BenchChoosePage )
	BenchChooseHeader:Dock( TOP )
	BenchChooseHeader:DockMargin( 0, 0, 10, 0 )
	BenchChooseHeader:SetTall( 30 )
	BenchChooseHeader.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemWhatBench"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	for k, v in pairs( BCS_ADMIN_CFG.Crafting ) do
		local ItemEntry = vgui.Create( "DPanel", BenchChoosePage )
		ItemEntry:Dock( TOP )
		ItemEntry:DockMargin( 0, 10, 10, 0 )
		ItemEntry:SetTall( 115 )
		ItemEntry.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

			draw.SimpleText( v.Name, "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemSkill") .. v.Skill[1], "BCS_Roboto_16", h+20, 52, Color( 255, 255, 255 ), 0, 0 )
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemMaxSkill") .. v.Skill[2], "BCS_Roboto_16", h+20, 73, Color( 255, 255, 255 ), 0, 0 )
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

		local SelectBenchButton = vgui.Create( "DButton", ItemEntry )
		SelectBenchButton:Dock( RIGHT )
		SelectBenchButton:SetWide( ItemEntry:GetTall() )
		SelectBenchButton:SetText( "" )
		local Alpha = 0
		SelectBenchButton.Paint = function( self2, w, h )
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
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiSelect"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		SelectBenchButton.DoClick = function()
			BenchType = k
			BenchChoosePage:MoveTo( 0, -BenchChoosePage:GetTall(), 0.5, 0, 1, function() 
				BenchChoosePage:SetVisible( false )
			end )

			BasicInfoPage:SetVisible( true )
			BasicInfoPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
			end )
		end
	end

	-- Basic Info
	BasicInfoPage = vgui.Create( "DPanel", self.PanelBack )
	BasicInfoPage:SetPos( 0, self.PanelBack:GetTall() )
	BasicInfoPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
	BasicInfoPage:SetVisible( false )
	BasicInfoPage.Paint = function( self2, w, h ) end

	local BasicInfoName = vgui.Create( "DPanel", BasicInfoPage )
	BasicInfoName:Dock( TOP )
	BasicInfoName:DockMargin( 10, 10, 10, 0 )
	BasicInfoName:SetTall( 50 )
	BasicInfoName.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
	end

	local BasicInfoNameText = vgui.Create( "DTextEntry", BasicInfoName )
	BasicInfoNameText:Dock( FILL )
	BasicInfoNameText:DockMargin( 10, 10, 10, 10 )
	BasicInfoNameText:SetText( BRICKSCRAFTING.L("vguiConfigItemName") )

	local BasicInfoDescription = vgui.Create( "DPanel", BasicInfoPage )
	BasicInfoDescription:Dock( TOP )
	BasicInfoDescription:DockMargin( 10, 10, 10, 0 )
	BasicInfoDescription:SetTall( 50 )
	BasicInfoDescription.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
	end

	local BasicInfoDescriptionText = vgui.Create( "DTextEntry", BasicInfoDescription )
	BasicInfoDescriptionText:Dock( FILL )
	BasicInfoDescriptionText:DockMargin( 10, 10, 10, 10 )
	BasicInfoDescriptionText:SetText( BRICKSCRAFTING.L("vguiConfigItemDescription") )

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
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemLearnCost"), "BCS_Roboto_17", w/4, 30/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemReqSkill"), "BCS_Roboto_17", (w/4)*3, 30/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		else
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemReqSkill"), "BCS_Roboto_17", w/2, 30/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end

	local BasicInfoCostText
	local BasicInfoSkillText
	if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then 
		BasicInfoCostText = vgui.Create( "DNumberWang", BasicInfoCostSkill )
		BasicInfoCostText:Dock( LEFT )
		BasicInfoCostText:DockMargin( 10, 30, 10, 10 )
		BasicInfoCostText:SetWide( ((BasicInfoPage:GetWide()-20)/2)-20 )
		BasicInfoCostText:SetMax( 99999999999999999 )
		BasicInfoCostText:SetValue( 0 )
		BasicInfoCostText:SetToolTip( BRICKSCRAFTING.L("vguiConfigItemLearnCostHint") )

		BasicInfoSkillText = vgui.Create( "DNumberWang", BasicInfoCostSkill )
		BasicInfoSkillText:Dock( RIGHT )
		BasicInfoSkillText:DockMargin( 10, 30, 10, 10 )
		BasicInfoSkillText:SetWide( ((BasicInfoPage:GetWide()-20)/2)-20 )
		BasicInfoSkillText:SetMax( 99999999999999999 )
		BasicInfoSkillText:SetValue( 0 )
		BasicInfoSkillText:SetToolTip( BRICKSCRAFTING.L("vguiConfigItemReqSkillHint") )
	else
		BasicInfoSkillText = vgui.Create( "DNumberWang", BasicInfoCostSkill )
		BasicInfoSkillText:Dock( FILL )
		BasicInfoSkillText:DockMargin( 10, 30, 10, 10 )
		BasicInfoSkillText:SetMax( 99999999999999999 )
		BasicInfoSkillText:SetValue( 0 )
		BasicInfoSkillText:SetToolTip( BRICKSCRAFTING.L("vguiConfigItemReqSkillHint") )
	end

	local BasicInfoModelType = vgui.Create( "DPanel", BasicInfoPage )
	BasicInfoModelType:Dock( TOP )
	BasicInfoModelType:DockMargin( 10, 10, 10, 0 )
	BasicInfoModelType:SetTall( BasicInfoPage:GetTall()-195-50-20 )
	BasicInfoModelType.Paint = function( self2, w, h ) end

	local BasicInfoModel = vgui.Create( "DPanel", BasicInfoModelType )
	BasicInfoModel:Dock( LEFT )
	BasicInfoModel:SetWide( ((BasicInfoPage:GetWide()-20)/2)-10 )
	BasicInfoModel.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemModel"), "BCS_Roboto_17", w/2, 30/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local ModelPath = "models/props_junk/cardboard_box003a.mdl"

	local BasicInfoModelPanel = vgui.Create( "DModelPanel", BasicInfoModel )
	BasicInfoModelPanel:Dock( FILL )
	BasicInfoModelPanel:DockMargin( 0, 30, 0, 0 )
	BasicInfoModelPanel:SetModel( ModelPath )		
	local mn, mx = BasicInfoModelPanel.Entity:GetRenderBounds()
	local size = 0
	size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
	size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
	size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

	BasicInfoModelPanel:SetFOV( 75 )
	BasicInfoModelPanel:SetCamPos( Vector( size, size, size ) )
	BasicInfoModelPanel:SetLookAt( ( mn + mx ) * 0.5 )
	function BasicInfoModelPanel:LayoutEntity( Entity ) return end

	local BasicInfoModelPanelCover = vgui.Create( "DButton", BasicInfoModel )
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
		BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigItemModel"), BRICKSCRAFTING.L("vguiConfigItemModelQuestion"), ModelPath, function( text ) 
			ModelPath = text
			BasicInfoModelPanel:SetModel( ModelPath )	
		end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
	end

	local BasicInfoType = vgui.Create( "DPanel", BasicInfoModelType )
	BasicInfoType:Dock( RIGHT )
	BasicInfoType:SetWide( ((BasicInfoPage:GetWide()-20)/2)-10 )
	BasicInfoType.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemType"), "BCS_Roboto_17", w/2, 30/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local BasicInfoTypeBox = vgui.Create( "DComboBox", BasicInfoType )
	BasicInfoTypeBox:Dock( TOP )
	BasicInfoTypeBox:DockMargin( 10, 30, 10, 0 )
	BasicInfoTypeBox:SetTall( 40 )
	BasicInfoTypeBox:SetValue( BRICKSCRAFTING.L("vguiConfigItemType") )
	for k, v in pairs( BRICKSCRAFTING.CraftingTypes ) do
		BasicInfoTypeBox:AddChoice( v.Name or k, k )
	end

	local BasicInfoTypeInfo = vgui.Create( "DScrollPanel", BasicInfoType )
	BasicInfoTypeInfo:Dock( FILL )
	BasicInfoTypeInfo:DockMargin( 10, 10, 10, 10 )

	local function TypeInfoRefresh()
		BasicInfoTypeInfo:Clear()
		BasicInfoTypeInfo.Entries = {} 
		
		local TypeKey = BasicInfoTypeBox:GetOptionData( BasicInfoTypeBox:GetSelectedID() )
		if( BRICKSCRAFTING.CraftingTypes[TypeKey] and BRICKSCRAFTING.CraftingTypes[TypeKey].ReqInfo ) then
			for k, v in pairs( BRICKSCRAFTING.CraftingTypes[TypeKey].ReqInfo ) do
				local BasicInfoTypeInfoEntry = vgui.Create( "DPanel", BasicInfoTypeInfo )
				BasicInfoTypeInfoEntry:Dock( TOP )
				BasicInfoTypeInfoEntry:DockMargin( 0, 5, 0, 0 )
				BasicInfoTypeInfoEntry:SetTall( 40 )
				BasicInfoTypeInfoEntry.Paint = function( self2, w, h ) 
					surface.SetDrawColor( 20, 20, 30, 100 )
					surface.DrawRect( 0, 0, w, h )
				end

				local BasicInfoTypeInfoEntryTxt = vgui.Create( "DLabel", BasicInfoTypeInfoEntry )
				BasicInfoTypeInfoEntryTxt:Dock( LEFT )
				BasicInfoTypeInfoEntryTxt:DockMargin( 10, 0, 0, 0 )
				BasicInfoTypeInfoEntryTxt:SetTextColor( Color( 255, 255, 255 ) )
				BasicInfoTypeInfoEntryTxt:SetFont( "BCS_Roboto_17" )
				BasicInfoTypeInfoEntryTxt:SetText( v[2] )
				BasicInfoTypeInfoEntryTxt:SizeToContents()

				if( v[1] == "String" ) then
					BasicInfoTypeInfo.Entries[k] = vgui.Create( "DTextEntry", BasicInfoTypeInfoEntry )
					BasicInfoTypeInfo.Entries[k]:Dock( FILL )
					BasicInfoTypeInfo.Entries[k]:DockMargin( 15, 5, 5, 5 )
					BasicInfoTypeInfo.Entries[k]:SetText( "" )
				elseif( v[1] == "Int" ) then
					BasicInfoTypeInfo.Entries[k] = vgui.Create( "DNumberWang", BasicInfoTypeInfoEntry )
					BasicInfoTypeInfo.Entries[k]:Dock( FILL )
					BasicInfoTypeInfo.Entries[k]:DockMargin( 15, 5, 5, 5 )
					BasicInfoTypeInfo.Entries[k]:SetMax( 9999999 )
					BasicInfoTypeInfo.Entries[k]:SetValue( 0 )
				end
			end
		end
	end

	BasicInfoTypeBox.OnSelect = function( self, index, value )
		TypeInfoRefresh()
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

		draw.SimpleText( BRICKSCRAFTING.L("vguiNextPage"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	BasicInfoNext.DoClick = function()
		local TypeKey = BasicInfoTypeBox:GetOptionData( BasicInfoTypeBox:GetSelectedID() )
		if( BasicInfoNameText:GetValue() and BasicInfoDescriptionText:GetValue() and ModelPath and TypeKey and BRICKSCRAFTING.CraftingTypes[TypeKey] ) then
			NewItemTable.Name = BasicInfoNameText:GetValue()
			NewItemTable.Description = BasicInfoDescriptionText:GetValue()
			if( BRICKSCRAFTING.LUACONFIG.DarkRP and tonumber( BasicInfoCostText:GetValue() ) > 0 ) then
				NewItemTable.Cost = tonumber( BasicInfoCostText:GetValue() )
			end
			if( tonumber( BasicInfoSkillText:GetValue() ) > 0 ) then
				NewItemTable.Skill = tonumber( BasicInfoSkillText:GetValue() )
			elseif( NewItemTable.Skill ) then
				NewItemTable.Skill = nil
			end
			NewItemTable.model = ModelPath
			NewItemTable.Type = TypeKey
			if( BRICKSCRAFTING.CraftingTypes[TypeKey].ReqInfo ) then
				NewItemTable.TypeInfo = {}
				for k, v in pairs( BRICKSCRAFTING.CraftingTypes[TypeKey].ReqInfo ) do
					if( BasicInfoTypeInfo.Entries[k] ) then
						NewItemTable.TypeInfo[k] = BasicInfoTypeInfo.Entries[k]:GetValue()
					end
				end
			end

			BasicInfoPage:MoveTo( 0, -BasicInfoPage:GetTall(), 0.5, 0, 1, function() 
				BasicInfoPage:SetVisible( false )
			end )

			RarityPage:SetVisible( true )
			RarityPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
			end )
		else
			notification.AddLegacy( BRICKSCRAFTING.L("vguiConfigItemMissingInfo"), 1, 5 )
		end
	end

	-- Rarity
	RarityPage = vgui.Create( "DPanel", self.PanelBack )
	RarityPage:SetPos( 0, self.PanelBack:GetTall() )
	RarityPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
	RarityPage:SetVisible( false )
	RarityPage.Paint = function( self2, w, h ) end

	local RarityHeader = vgui.Create( "DPanel", RarityPage )
	RarityHeader:Dock( TOP )
	RarityHeader:DockMargin( 10, 10, 10, 0 )
	RarityHeader:SetTall( 30 )
	RarityHeader.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemWhatRarity"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local RarityNext = vgui.Create( "DButton", RarityPage )
	RarityNext:Dock( BOTTOM )
	RarityNext:DockMargin( 10, 0, 10, 10 )
	RarityNext:SetTall( 40 )
	RarityNext:SetText( "" )
	local Alpha = 0
	RarityNext.Paint = function( self2, w, h )
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
	local Rarity = 0
	RarityNext.DoClick = function()
		if( BCS_ADMIN_CFG.Rarity[Rarity] ) then
			NewItemTable.Rarity = Rarity
		end

		RarityPage:MoveTo( 0, -RarityPage:GetTall(), 0.5, 0, 1, function() 
			RarityPage:SetVisible( false )
		end )

		ResourcePage:SetVisible( true )
		ResourcePage:MoveTo( 0, 30, 0.5, 0, 1, function() 
		end )
	end

	local function RefreshRarity()
		if( IsValid( RarityPage.Scroll ) ) then
			RarityPage.Scroll:Remove()
		end

		RarityPage.Scroll = vgui.Create( "brickscrafting_scrollpanel", RarityPage )
		RarityPage.Scroll:Dock( FILL )
		RarityPage.Scroll:DockMargin( 10, 10, 10, 10 )
		
		local ItemWide = 4
		local Spacing = 10
		local Size = ((RarityPage:GetWide()-30-13-((ItemWide-1)*Spacing))/ItemWide)

		local List = vgui.Create( "DIconLayout", RarityPage.Scroll )
		List:Dock( FILL )
		List:DockMargin( 0, 0, 10, 0 )
		List:SetSpaceX( Spacing )
		List:SetSpaceY( Spacing )

		local RarityEntryNone = List:Add( "DButton" )
		RarityEntryNone:SetSize( Size, Size )
		RarityEntryNone:SetText( BRICKSCRAFTING.L("vguiConfigItemNone") )
		RarityEntryNone.Paint = function( self2, w, h )
			surface.SetDrawColor( 255, 255, 255, 125 )
			surface.DrawRect( 0, 0, w, h )

			if( Rarity == 0 ) then
				surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
				surface.DrawOutlinedRect( 0, 0, w, h )
				surface.DrawOutlinedRect( 1, 1, w-2, h-2 )
			end
		end	
		RarityEntryNone.DoClick = function()
			Rarity = 0
		end

		for k, v in pairs( BCS_ADMIN_CFG.Rarity ) do
			local RarityEntry = List:Add( "DButton" )
			RarityEntry:SetSize( Size, Size )
			RarityEntry:SetText( v.Name )
			RarityEntry.Paint = function( self2, w, h )
				surface.SetDrawColor( v.Color )
				surface.DrawRect( 0, 0, w, h )

				if( Rarity == k ) then
					surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
					surface.DrawOutlinedRect( 0, 0, w, h )
					surface.DrawOutlinedRect( 1, 1, w-2, h-2 )
				end
			end	
			RarityEntry.DoClick = function()
				Rarity = k
			end
		end
	end
	RefreshRarity()

	-- Resource Cost
	ResourcePage = vgui.Create( "DPanel", self.PanelBack )
	ResourcePage:SetPos( 0, self.PanelBack:GetTall() )
	ResourcePage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
	ResourcePage:SetVisible( false )
	ResourcePage.Paint = function( self2, w, h ) end

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
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemWhatResources"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemFinish"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	local ResourcesToGive = {}
	ResourceFinish.DoClick = function()
		NewItemTable.Resources = ResourcesToGive

		ResourcePage:MoveTo( 0, -ResourcePage:GetTall(), 0.5, 0, 1, function() 
			ResourcePage:SetVisible( false )
		end )

		if( not BCS_ADMIN_CFG.Crafting[BenchType].Items ) then
			BCS_ADMIN_CFG.Crafting[BenchType].Items = {}
		end

		table.insert( BCS_ADMIN_CFG.Crafting[BenchType].Items, NewItemTable )
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
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( ExtraEdge, ExtraEdge )
			surface.DrawRect( x, y, w-(2*ExtraEdge), h-(2*ExtraEdge) )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
	
			surface.SetDrawColor( 20, 20, 30, Alpha )
			surface.DrawRect( ExtraEdge, ExtraEdge, w-(2*ExtraEdge), h-(2*ExtraEdge) )
	
			surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( ResourceMat )
			local Spacing = 10
			surface.DrawTexturedRect( ExtraEdge+Spacing, ExtraEdge+Spacing, w-(2*Spacing)-(2*ExtraEdge), h-(2*Spacing)-(2*ExtraEdge) )
			draw.SimpleText( ResourcesToGive[k] or 0, "BCS_Roboto_17", w-ExtraEdge+5, ExtraEdge, Color( 0, 128, 181 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		end
		ResourceEntryIcon.DoClick = function()
			BCS_DRAWING.StringRequest( k .. BRICKSCRAFTING.L("vguiConfigItemAmount"), string.format( BRICKSCRAFTING.L("vguiConfigItemCostToCraft"), k ), ResourcesToGive[k], function( text )
				if( isnumber( tonumber( text ) ) ) then
					ResourcesToGive[k] = tonumber( text )
				end
			end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
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
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemCreator"), "BCS_Roboto_22", w/2, (h-BCS_DRAWING.ShadowSize)/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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

vgui.Register( "brickscrafting_vgui_admin_additem", PANEL, "DFrame" )





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

function PANEL:SetItemData( BenchType, ItemKey )
	self.PanelBack:Clear()

	local ScrollY, ScrollH = ((ScrH()/2)-(self.PanelBack:GetTall()/2))+30, self.PanelBack:GetTall()-30

	if( BCS_ADMIN_CFG.Crafting[BenchType] and BCS_ADMIN_CFG.Crafting[BenchType].Items and BCS_ADMIN_CFG.Crafting[BenchType].Items[ItemKey] ) then
		local ItemTable = BCS_ADMIN_CFG.Crafting[BenchType].Items[ItemKey]

		local RarityPage
		local ResourcePage

		local BasicInfoPage = vgui.Create( "DPanel", self.PanelBack )
		BasicInfoPage:SetPos( 0, 30 )
		BasicInfoPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
		BasicInfoPage.Paint = function( self2, w, h ) end

		local BasicInfoModelPanel = vgui.Create( "DModelPanel", BasicInfoPage )
		BasicInfoModelPanel:Dock( TOP )
		BasicInfoModelPanel:DockMargin( 0, 0, 0, 0 )
		BasicInfoModelPanel:SetTall( BasicInfoPage:GetTall()-10-340 )
		BasicInfoModelPanel:SetModel( ItemTable.model )		
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
			BCS_DRAWING.StringRequest( BRICKSCRAFTING.L("vguiConfigItemModel"), BRICKSCRAFTING.L("vguiConfigItemModelQuestion"), ItemTable.model, function( text ) 
				ItemTable.model = text
				BasicInfoModelPanel:SetModel( ItemTable.model )	
			end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
		end

		--[[ Hint Button ]]--
		local HintButton = vgui.Create( "DButton", BasicInfoModelPanelCover )
		HintButton:SetSize( 32, 32 )
		HintButton:SetPos( BasicInfoPage:GetWide()-10-HintButton:GetWide(), 10 )
		HintButton:SetText( "" )
		HintButton:SetToolTip( BRICKSCRAFTING.L("vguiConfigItemModelHint") )
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
			notification.AddLegacy( BRICKSCRAFTING.L("vguiConfigItemModelHint"), 1, 5 )
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

			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemName"), "BCS_Roboto_17", w/4, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemDescription"), "BCS_Roboto_17", (w/4)*3, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	
		local BasicInfoNameText = vgui.Create( "DTextEntry", BasicInfoNameDes )
		BasicInfoNameText:Dock( LEFT )
		BasicInfoNameText:DockMargin( 10, 10+15, 10, 10 )
		BasicInfoNameText:SetWide( (BasicInfoPage:GetWide()-20-30)/2 )
		BasicInfoNameText:SetText( ItemTable.Name )

		local BasicInfoDescriptionText = vgui.Create( "DTextEntry", BasicInfoNameDes )
		BasicInfoDescriptionText:Dock( RIGHT )
		BasicInfoDescriptionText:DockMargin( 10, 10+15, 10, 10 )
		BasicInfoDescriptionText:SetWide( (BasicInfoPage:GetWide()-20-40)/2 )
		BasicInfoDescriptionText:SetText( ItemTable.Description )

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
				draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemLearnCost"), "BCS_Roboto_17", w/4, 30/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemReqSkill"), "BCS_Roboto_17", (w/4)*3, 30/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			else
				draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemReqSkill"), "BCS_Roboto_17", w/2, 30/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
		end
		
		local BasicInfoCostText
		local BasicInfoSkillText
		if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then
			BasicInfoCostText = vgui.Create( "DNumberWang", BasicInfoCostSkill )
			BasicInfoCostText:Dock( LEFT )
			BasicInfoCostText:DockMargin( 10, 30, 10, 10 )
			BasicInfoCostText:SetWide( ((BasicInfoPage:GetWide()-20)/2)-20 )
			BasicInfoCostText:SetMax( 9999999 )
			BasicInfoCostText:SetValue( ItemTable.Cost or 0 )
			BasicInfoCostText:SetToolTip( BRICKSCRAFTING.L("vguiConfigItemLearnCostHint") )
		
			BasicInfoSkillText = vgui.Create( "DNumberWang", BasicInfoCostSkill )
			BasicInfoSkillText:Dock( RIGHT )
			BasicInfoSkillText:DockMargin( 10, 30, 10, 10 )
			BasicInfoSkillText:SetWide( ((BasicInfoPage:GetWide()-20)/2)-20 )
			BasicInfoSkillText:SetMax( 9999999 )
			BasicInfoSkillText:SetValue( ItemTable.Skill or 0 )
			BasicInfoSkillText:SetToolTip( BRICKSCRAFTING.L("vguiConfigItemReqSkillHint") )
		else
			BasicInfoSkillText = vgui.Create( "DNumberWang", BasicInfoCostSkill )
			BasicInfoSkillText:Dock( FILL )
			BasicInfoSkillText:DockMargin( 10, 30, 10, 10 )
			BasicInfoSkillText:SetMax( 9999999 )
			BasicInfoSkillText:SetValue( ItemTable.Skill or 0 )
			BasicInfoSkillText:SetToolTip( BRICKSCRAFTING.L("vguiConfigItemReqSkillHint") )
		end

		local BasicInfoModelType = vgui.Create( "DPanel", BasicInfoPage )
		BasicInfoModelType:Dock( TOP )
		BasicInfoModelType:DockMargin( 10, 10, 10, 0 )
		BasicInfoModelType:SetTall( 130 )
		BasicInfoModelType.Paint = function( self2, w, h ) end
	
		local BasicInfoExtra = vgui.Create( "DPanel", BasicInfoModelType )
		BasicInfoExtra:Dock( LEFT )
		BasicInfoExtra:SetWide( ((BasicInfoPage:GetWide()-20)/2)-10 )
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

			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemChangeRarity"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		BasicInfoExtraRarity.DoClick = function()
			BasicInfoPage:MoveTo( 0, -BasicInfoPage:GetTall(), 0.5, 0, 1, function() 
				BasicInfoPage:SetVisible( false )
			end )

			RarityPage:SetVisible( true )
			RarityPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
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

			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemChangeResCost"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		BasicInfoExtraResources.DoClick = function()
			BasicInfoPage:MoveTo( 0, BasicInfoPage:GetTall(), 0.5, 0, 1, function() 
				BasicInfoPage:SetVisible( false )
			end )

			ResourcePage:SetVisible( true )
			ResourcePage:MoveTo( 0, 30, 0.5, 0, 1, function() 
			end )
		end
	
		local BasicInfoType = vgui.Create( "DPanel", BasicInfoModelType )
		BasicInfoType:Dock( RIGHT )
		BasicInfoType:SetWide( ((BasicInfoPage:GetWide()-20)/2)-10 )
		BasicInfoType.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
	
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemTypeInfo"), "BCS_Roboto_17", w/2, 30/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	
		local BasicInfoTypeInfo = vgui.Create( "DScrollPanel", BasicInfoType )
		BasicInfoTypeInfo:Dock( FILL )
		BasicInfoTypeInfo:DockMargin( 10, 30, 10, 10 )
	
		local function TypeInfoRefresh()
			BasicInfoTypeInfo:Clear()
			BasicInfoTypeInfo.Entries = {} 
	
			if( BRICKSCRAFTING.CraftingTypes[ItemTable.Type] and BRICKSCRAFTING.CraftingTypes[ItemTable.Type].ReqInfo ) then
				for k, v in pairs( BRICKSCRAFTING.CraftingTypes[ItemTable.Type].ReqInfo ) do
					local BasicInfoTypeInfoEntry = vgui.Create( "DPanel", BasicInfoTypeInfo )
					BasicInfoTypeInfoEntry:Dock( TOP )
					BasicInfoTypeInfoEntry:DockMargin( 0, 5, 0, 0 )
					BasicInfoTypeInfoEntry:SetTall( 40 )
					BasicInfoTypeInfoEntry.Paint = function( self2, w, h ) 
						surface.SetDrawColor( 20, 20, 30, 100 )
						surface.DrawRect( 0, 0, w, h )
					end
	
					local BasicInfoTypeInfoEntryTxt = vgui.Create( "DLabel", BasicInfoTypeInfoEntry )
					BasicInfoTypeInfoEntryTxt:Dock( LEFT )
					BasicInfoTypeInfoEntryTxt:DockMargin( 10, 0, 0, 0 )
					BasicInfoTypeInfoEntryTxt:SetTextColor( Color( 255, 255, 255 ) )
					BasicInfoTypeInfoEntryTxt:SetFont( "BCS_Roboto_17" )
					BasicInfoTypeInfoEntryTxt:SetText( v[2] )
					BasicInfoTypeInfoEntryTxt:SizeToContents()
	
					if( v[1] == "String" ) then
						BasicInfoTypeInfo.Entries[k] = vgui.Create( "DTextEntry", BasicInfoTypeInfoEntry )
						BasicInfoTypeInfo.Entries[k]:Dock( FILL )
						BasicInfoTypeInfo.Entries[k]:DockMargin( 15, 5, 5, 5 )
						BasicInfoTypeInfo.Entries[k]:SetText( ItemTable.TypeInfo[k] or "" )
					elseif( v[1] == "Int" ) then
						BasicInfoTypeInfo.Entries[k] = vgui.Create( "DNumberWang", BasicInfoTypeInfoEntry )
						BasicInfoTypeInfo.Entries[k]:Dock( FILL )
						BasicInfoTypeInfo.Entries[k]:DockMargin( 15, 5, 5, 5 )
						BasicInfoTypeInfo.Entries[k]:SetMax( 9999999 )
						BasicInfoTypeInfo.Entries[k]:SetValue( ItemTable.TypeInfo[k] or 0 )
					end
				end
			end
		end
		TypeInfoRefresh()

		-- Rarity
		RarityPage = vgui.Create( "DPanel", self.PanelBack )
		RarityPage:SetPos( 0, self.PanelBack:GetTall() )
		RarityPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
		RarityPage:SetVisible( false )
		RarityPage.Paint = function( self2, w, h ) end

		local RarityHeader = vgui.Create( "DPanel", RarityPage )
		RarityHeader:Dock( TOP )
		RarityHeader:DockMargin( 10, 10, 10, 0 )
		RarityHeader:SetTall( 30 )
		RarityHeader.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemWhatRarity"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end

		local RarityNext = vgui.Create( "DButton", RarityPage )
		RarityNext:Dock( BOTTOM )
		RarityNext:DockMargin( 10, 0, 10, 10 )
		RarityNext:SetTall( 40 )
		RarityNext:SetText( "" )
		local Alpha = 0
		RarityNext.Paint = function( self2, w, h )
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

			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemSetRarity"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		local Rarity = ItemTable.Rarity or 0
		RarityNext.DoClick = function()
			if( BCS_ADMIN_CFG.Rarity[Rarity] ) then
				ItemTable.Rarity = Rarity
			end

			RarityPage:MoveTo( 0, RarityPage:GetTall(), 0.5, 0, 1, function() 
				RarityPage:SetVisible( false )
			end )

			BasicInfoPage:SetVisible( true )
			BasicInfoPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
			end )
		end

		local function RefreshRarity()
			if( IsValid( RarityPage.Scroll ) ) then
				RarityPage.Scroll:Remove()
			end

			RarityPage.Scroll = vgui.Create( "brickscrafting_scrollpanel", RarityPage )
			RarityPage.Scroll:Dock( FILL )
			RarityPage.Scroll:DockMargin( 10, 10, 10, 10 )
			
			local ItemWide = 4
			local Spacing = 10
			local Size = ((RarityPage:GetWide()-30-13-((ItemWide-1)*Spacing))/ItemWide)

			local List = vgui.Create( "DIconLayout", RarityPage.Scroll )
			List:Dock( FILL )
			List:DockMargin( 0, 0, 10, 0 )
			List:SetSpaceX( Spacing )
			List:SetSpaceY( Spacing )

			local RarityEntryNone = List:Add( "DButton" )
			RarityEntryNone:SetSize( Size, Size )
			RarityEntryNone:SetText( BRICKSCRAFTING.L("vguiConfigItemNone") )
			RarityEntryNone.Paint = function( self2, w, h )
				surface.SetDrawColor( 255, 255, 255, 125 )
				surface.DrawRect( 0, 0, w, h )

				if( Rarity == 0 ) then
					surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
					surface.DrawOutlinedRect( 0, 0, w, h )
					surface.DrawOutlinedRect( 1, 1, w-2, h-2 )
				end
			end	
			RarityEntryNone.DoClick = function()
				Rarity = 0
			end

			for k, v in pairs( BCS_ADMIN_CFG.Rarity ) do
				local RarityEntry = List:Add( "DButton" )
				RarityEntry:SetSize( Size, Size )
				RarityEntry:SetText( v.Name )
				RarityEntry.Paint = function( self2, w, h )
					surface.SetDrawColor( v.Color )
					surface.DrawRect( 0, 0, w, h )

					if( Rarity == k ) then
						surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
						surface.DrawOutlinedRect( 0, 0, w, h )
						surface.DrawOutlinedRect( 1, 1, w-2, h-2 )
					end
				end	
				RarityEntry.DoClick = function()
					Rarity = k
				end
			end
		end
		RefreshRarity()

		-- Resource Cost
		ResourcePage = vgui.Create( "DPanel", self.PanelBack )
		ResourcePage:SetPos( 0, -self.PanelBack:GetTall() )
		ResourcePage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
		ResourcePage:SetVisible( false )
		ResourcePage.Paint = function( self2, w, h ) end

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
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemWhatResources"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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

			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemSetResCost"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
		local ResourcesToGive = {}
		table.CopyFromTo( ItemTable.Resources, ResourcesToGive )
		ResourceFinish.DoClick = function()
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
				surface.SetDrawColor( 30, 30, 44 )
				local x, y = self2:LocalToScreen( ExtraEdge, ExtraEdge )
				surface.DrawRect( x, y, w-(2*ExtraEdge), h-(2*ExtraEdge) )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
		
				surface.SetDrawColor( 20, 20, 30, Alpha )
				surface.DrawRect( ExtraEdge, ExtraEdge, w-(2*ExtraEdge), h-(2*ExtraEdge) )
		
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial( ResourceMat )
				local Spacing = 10
				surface.DrawTexturedRect( ExtraEdge+Spacing, ExtraEdge+Spacing, w-(2*Spacing)-(2*ExtraEdge), h-(2*Spacing)-(2*ExtraEdge) )
				draw.SimpleText( ResourcesToGive[k] or 0, "BCS_Roboto_17", w-ExtraEdge+5, ExtraEdge, Color( 0, 128, 181 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
			end
			ResourceEntryIcon.DoClick = function()
				BCS_DRAWING.StringRequest( k .. BRICKSCRAFTING.L("vguiConfigItemAmount"), string.format( BRICKSCRAFTING.L("vguiConfigItemCostToCraft"), k ), 0, function( text )
					if( isnumber( tonumber( text ) ) ) then
						ResourcesToGive[k] = tonumber( text )
						PrintTable( ItemTable.Resources )
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
			ItemTable.Name = BasicInfoNameText:GetText()
			ItemTable.Description = BasicInfoDescriptionText:GetText()
			ItemTable.Resources = ResourcesToGive
			if( BRICKSCRAFTING.LUACONFIG.DarkRP and tonumber( BasicInfoCostText:GetValue() ) > 0 ) then
				ItemTable.Cost = tonumber( BasicInfoCostText:GetValue() )
			end
			if( tonumber( BasicInfoSkillText:GetValue() ) > 0 ) then
				ItemTable.Skill = tonumber( BasicInfoSkillText:GetValue() )
			elseif( ItemTable.Skill ) then
				ItemTable.Skill = nil
			end
			if( BRICKSCRAFTING.CraftingTypes[ItemTable.Type] and BRICKSCRAFTING.CraftingTypes[ItemTable.Type].ReqInfo ) then
				for k, v in pairs( BRICKSCRAFTING.CraftingTypes[ItemTable.Type].ReqInfo ) do
					if( BasicInfoTypeInfo.Entries[k] ) then
						ItemTable.TypeInfo[k] = BasicInfoTypeInfo.Entries[k]:GetValue()
					end
				end
			end
			BCS_ADMIN_CFG.Crafting[BenchType].Items[ItemKey] = ItemTable
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
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigItemEditor"), "BCS_Roboto_22", w/2, (h-BCS_DRAWING.ShadowSize)/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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

vgui.Register( "brickscrafting_vgui_admin_edititem", PANEL, "DFrame" )