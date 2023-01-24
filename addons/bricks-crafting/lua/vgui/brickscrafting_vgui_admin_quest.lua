-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_admin_quest.lua"
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

function PANEL:RefreshInfo()
	local ScrollY, ScrollH = ((ScrH()/2)-(self.PanelBack:GetTall()/2))+30, self.PanelBack:GetTall()-30

	self.PanelBack:Clear()

	local QuestTable = {}

	local GoalPage
	local RewardsPage

	local BasicInfoPage = vgui.Create( "DPanel", self.PanelBack )
	BasicInfoPage:SetPos( 0, 30 )
	BasicInfoPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
	BasicInfoPage.Paint = function( self2, w, h ) end

	local BasicInfoName = vgui.Create( "DPanel", BasicInfoPage )
	BasicInfoName:Dock( TOP )
	BasicInfoName:DockMargin( 10, 10, 10, 0 )
	BasicInfoName:SetTall( 65 )
	BasicInfoName.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestName"), "BCS_Roboto_17", w/2, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local BasicInfoNameText = vgui.Create( "DTextEntry", BasicInfoName )
	BasicInfoNameText:Dock( FILL )
	BasicInfoNameText:DockMargin( 10, 10+15, 10, 10 )
	BasicInfoNameText:SetText( BRICKSCRAFTING.L("vguiConfigQuestName") )

	local BasicInfoDescription = vgui.Create( "DPanel", BasicInfoPage )
	BasicInfoDescription:Dock( TOP )
	BasicInfoDescription:DockMargin( 10, 10, 10, 0 )
	BasicInfoDescription:SetTall( 65 )
	BasicInfoDescription.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestDes"), "BCS_Roboto_17", w/2, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local BasicInfoDescriptionText = vgui.Create( "DTextEntry", BasicInfoDescription )
	BasicInfoDescriptionText:Dock( FILL )
	BasicInfoDescriptionText:DockMargin( 10, 10+15, 10, 10 )
	BasicInfoDescriptionText:SetText( BRICKSCRAFTING.L("vguiConfigQuestDes") )

	local BasicInfoDailyText = vgui.Create( "DButton", BasicInfoPage )
	BasicInfoDailyText:Dock( TOP )
	BasicInfoDailyText:DockMargin( 10, 10, 10, 0 )
	BasicInfoDailyText:SetTall( 40 )
	BasicInfoDailyText:SetText( "" )
	local Alpha = 150
	local DailyQuest = false
	BasicInfoDailyText.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 150, 200 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 150, 240 )
		else
			Alpha = math.Clamp( Alpha-5, 150, 240 )
		end

		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

		if( DailyQuest ) then
			surface.SetDrawColor( 14, 97, 24, Alpha )
		else
			surface.SetDrawColor( 110, 14, 24, Alpha )
		end	

		surface.DrawRect( 0, 0, w, h )

		if( DailyQuest ) then
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestDaily") .. " - " .. BRICKSCRAFTING.L("vguiConfigQuestEnabled"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		else
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestDaily") .. " - " .. BRICKSCRAFTING.L("vguiConfigQuestDisabled"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end
	BasicInfoDailyText.DoClick = function()
		if( DailyQuest ) then
			DailyQuest = false
		else
			DailyQuest = true
		end	
	end

	local BasicInfoIcon = vgui.Create( "brickscrafting_scrollpanel", BasicInfoPage )
	BasicInfoIcon:Dock( FILL )
	BasicInfoIcon:DockMargin( 10, 10, 10, 0 )

	local ItemWide = 6
	local Spacing = 10
	local Size = ((self.PanelBack:GetWide()-50-((ItemWide-1)*Spacing))/ItemWide)

	local BasicInfoIconList = vgui.Create( "DIconLayout", BasicInfoIcon )
	BasicInfoIconList:Dock( FILL )
	BasicInfoIconList:DockMargin( 0, 0, 10, 0 )
	BasicInfoIconList:SetSpaceX( Spacing )
	BasicInfoIconList:SetSpaceY( Spacing )

	local ChosenIcon = ""
	local function RefreshIcons()
		BasicInfoIconList:Clear()

		for k, v in pairs( BCS_MATERIALS ) do
			local BasicInfoIconEntry = vgui.Create( "DButton", BasicInfoIconList )
			BasicInfoIconEntry:SetSize( Size, Size )
			BasicInfoIconEntry:SetToolTip( k )
			BasicInfoIconEntry:SetText( "" )
			local Alpha = 0
			BasicInfoIconEntry.Paint = function( self2, w, h )
				if( self2:IsHovered() and !self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+5, 0, 100 )
				elseif( self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 200 )
				else
					Alpha = math.Clamp( Alpha-5, 0, 100 )
				end

				if( ChosenIcon == k ) then
					Alpha = 255
				end
				
				BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
				local x, y = self2:LocalToScreen( 0, 0 )
				surface.SetDrawColor( 30, 30, 44 )
				surface.DrawRect( x, y, w, h )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
		
				surface.SetDrawColor( 20, 20, 30, Alpha )
				surface.DrawRect( 0, 0, w, h )
		
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial( v )
				local Spacing = 10
				surface.DrawTexturedRect( Spacing, Spacing, w-(2*Spacing), h-(2*Spacing) )
			end
			BasicInfoIconEntry.DoClick = function()
				ChosenIcon = k
			end
		end
	end
	RefreshIcons()

	local BasicInfoNext = vgui.Create( "DButton", BasicInfoPage )
	BasicInfoNext:Dock( BOTTOM )
	BasicInfoNext:DockMargin( 10, 10, 10, 10 )
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
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	

		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( 0, 0, w, h )

		draw.SimpleText( BRICKSCRAFTING.L("vguiNextPage"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	BasicInfoNext.DoClick = function()
		if( not BCS_MATERIALS[ChosenIcon] ) then
			notification.AddLegacy( BRICKSCRAFTING.L("vguiConfigQuestNeedIcon"), 1, 5 )
			return
		end

		QuestTable.Name = BasicInfoNameText:GetText()
		QuestTable.Description = BasicInfoDescriptionText:GetText()
		QuestTable.Icon = ChosenIcon
		QuestTable.Daily = DailyQuest

		BasicInfoPage:MoveTo( 0, -BasicInfoPage:GetTall(), 0.5, 0, 1, function() 
			BasicInfoPage:SetVisible( false )
		end )

		GoalPage:SetVisible( true )
		GoalPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
		end )
	end

	--  Goal Page
	GoalPage = vgui.Create( "DPanel", self.PanelBack )
	GoalPage:SetPos( 0, self.PanelBack:GetTall() )
	GoalPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
	GoalPage:SetVisible( false )
	GoalPage.Paint = function( self2, w, h ) end

	local GoalPageHeader = vgui.Create( "DPanel", GoalPage )
	GoalPageHeader:Dock( TOP )
	GoalPageHeader:DockMargin( 10, 10, 10, 0 )
	GoalPageHeader:SetTall( 30 )
	GoalPageHeader.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestWhatDo"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local GoalPageScroll = vgui.Create( "brickscrafting_categorylist", GoalPage )
	GoalPageScroll:Dock( FILL )
	GoalPageScroll:DockMargin( 10, 10, 10, 0 )
	GoalPageScroll.pnlCanvas:DockPadding( 0, 0, 10, 10 )
	GoalPageScroll.Paint = function() end

	QuestTable.Goal = {}
	for k, v in pairs( BRICKSCRAFTING.QuestTypes ) do
		GoalPageScroll[k] = GoalPageScroll:Add( v.GoalHeader )
	end

	for k, v in pairs( BCS_ADMIN_CFG.Resources ) do
		local GoalPageEntry = vgui.Create( "DPanel", GoalPageScroll["Resource"] )
		GoalPageEntry:Dock( TOP )
		GoalPageEntry:DockMargin( 0, 10, 0, 0 )
		GoalPageEntry:SetTall( 30 )
		GoalPageEntry.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )			
			
			draw.SimpleText( k, "BCS_Roboto_17", 10, h/2, Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
		end

		local GoalPageEntryAmount = vgui.Create( "brickscrafting_numslider", GoalPageEntry )
		GoalPageEntryAmount:Dock( RIGHT )
		GoalPageEntryAmount:DockMargin( 0, 0, 20, 0 )
		GoalPageEntryAmount:SetWide( 150 )
		GoalPageEntryAmount:SetText( "" )
		GoalPageEntryAmount:SetMin( 0 )
		GoalPageEntryAmount:SetMax( BRICKSCRAFTING.LUACONFIG.Defaults.QuestResGoalMax )
		GoalPageEntryAmount:SetDecimals( 0 )
		GoalPageEntryAmount:SetDark( true )
		GoalPageEntryAmount:DisableStuff()
		GoalPageEntryAmount.OnValueChanged = function( self2, val )
			val = math.Round( val )

			if( not QuestTable.Goal["Resource"] ) then
				QuestTable.Goal["Resource"] = {}
			end

			if( val > 0 ) then
				QuestTable.Goal["Resource"][k] = val
			else
				if( QuestTable.Goal["Resource"][k] ) then
					QuestTable.Goal["Resource"][k] = nil
				end
			end
		end
	end

	for k, v in pairs( BCS_ADMIN_CFG.Crafting ) do
		for key, val in pairs( BCS_ADMIN_CFG.Crafting[k].Items or {} ) do
			local GoalPageEntry = vgui.Create( "DPanel", GoalPageScroll["Craft"] )
			GoalPageEntry:Dock( TOP )
			GoalPageEntry:DockMargin( 0, 10, 0, 0 )
			GoalPageEntry:SetTall( 30 )
			GoalPageEntry.Paint = function( self2, w, h )
				BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
				local x, y = self2:LocalToScreen( 0, 0 )
				surface.SetDrawColor( 30, 30, 44 )
				surface.DrawRect( x, y, w, h )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )				
				
				draw.SimpleText( val.Name, "BCS_Roboto_17", 10, h/2, Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
			end

			local GoalPageEntryAmount = vgui.Create( "brickscrafting_numslider", GoalPageEntry )
			GoalPageEntryAmount:Dock( RIGHT )
			GoalPageEntryAmount:DockMargin( 0, 0, 20, 0 )
			GoalPageEntryAmount:SetWide( 150 )
			GoalPageEntryAmount:SetText( "" )
			GoalPageEntryAmount:SetMin( 0 )
			GoalPageEntryAmount:SetMax( BRICKSCRAFTING.LUACONFIG.Defaults.QuestCraftGoalMax )
			GoalPageEntryAmount:SetDecimals( 0 )
			GoalPageEntryAmount:SetDark( true )
			GoalPageEntryAmount:DisableStuff()
			GoalPageEntryAmount.OnValueChanged = function( self2, val )
				val = math.Round( val )

				if( not QuestTable.Goal["Craft"] ) then
					QuestTable.Goal["Craft"] = {}
				end

				if( not QuestTable.Goal["Craft"][k] ) then
					QuestTable.Goal["Craft"][k] = {}
				end

				if( val > 0 ) then
					QuestTable.Goal["Craft"][k][key] = val
				else
					if( QuestTable.Goal["Craft"][k][key] ) then
						QuestTable.Goal["Craft"][k][key] = nil
					end
				end
			end
		end
	end

	local GoalPageNext = vgui.Create( "DButton", GoalPage )
	GoalPageNext:Dock( BOTTOM )
	GoalPageNext:DockMargin( 10, 10, 10, 10 )
	GoalPageNext:SetTall( 40 )
	GoalPageNext:SetText( "" )
	local Alpha = 0
	GoalPageNext.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 0, 100 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 0, 200 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 100 )
		end

		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	

		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( 0, 0, w, h )

		draw.SimpleText( BRICKSCRAFTING.L("vguiNextPage"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	GoalPageNext.DoClick = function()
		GoalPage:MoveTo( 0, -GoalPage:GetTall(), 0.5, 0, 1, function() 
			GoalPage:SetVisible( false )
		end )

		RewardsPage:SetVisible( true )
		RewardsPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
		end )
	end

	-- Rewards Page
	RewardsPage = vgui.Create( "DPanel", self.PanelBack )
	RewardsPage:SetPos( 0, self.PanelBack:GetTall() )
	RewardsPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
	RewardsPage:SetVisible( false )
	RewardsPage.Paint = function( self2, w, h ) end

	local RewardsPageHeader = vgui.Create( "DPanel", RewardsPage )
	RewardsPageHeader:Dock( TOP )
	RewardsPageHeader:DockMargin( 10, 10, 10, 0 )
	RewardsPageHeader:SetTall( 30 )
	RewardsPageHeader.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestRewards"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local RewardsPageScroll = vgui.Create( "brickscrafting_categorylist", RewardsPage )
	RewardsPageScroll:Dock( FILL )
	RewardsPageScroll:DockMargin( 10, 10, 10, 10 )
	RewardsPageScroll.pnlCanvas:DockPadding( 0, 0, 10, 0 )
	RewardsPageScroll.Paint = function() end

	QuestTable.Rewards = {}
	for k, v in pairs( BRICKSCRAFTING.RewardTypes ) do
		RewardsPageScroll[k] = RewardsPageScroll:Add( v.Name or k )
	end

	if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then
		local RewardsPageMoney = vgui.Create( "DPanel", RewardsPageScroll["Money"] )
		RewardsPageMoney:Dock( TOP )
		RewardsPageMoney:DockMargin( 0, 10, 0, 0 )
		RewardsPageMoney:SetTall( 30 )
		RewardsPageMoney.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )				
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestMoney"), "BCS_Roboto_17", 10, h/2, Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
		end

		local RewardsPageMoneyAmount = vgui.Create( "brickscrafting_textentry", RewardsPageMoney )
		RewardsPageMoneyAmount:Dock( RIGHT )
		RewardsPageMoneyAmount:DockMargin( 0, 0, 20, 0 )
		RewardsPageMoneyAmount:SetWide( 150 )
		RewardsPageMoneyAmount:SetText( BRICKSCRAFTING.L("vguiConfigQuestAmount") )
		RewardsPageMoneyAmount.OnChange = function( self2 )
			val = tonumber( RewardsPageMoneyAmount:GetValue() )

			if( not isnumber(val) ) then return end

			if( val > 0 ) then
				if( not QuestTable.Rewards["Money"] ) then
					QuestTable.Rewards["Money"] = {}
				end
				QuestTable.Rewards["Money"][1] = val
			else
				if( QuestTable.Rewards["Money"] ) then
					QuestTable.Rewards["Money"] = nil
				end
			end
		end
	end

	for k, v in pairs( BCS_ADMIN_CFG.Resources ) do
		local RewardsPageEntry = vgui.Create( "DPanel", RewardsPageScroll["Resources"] )
		RewardsPageEntry:Dock( TOP )
		RewardsPageEntry:DockMargin( 0, 10, 0, 0 )
		RewardsPageEntry:SetTall( 30 )
		RewardsPageEntry.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )			
			
			draw.SimpleText( k, "BCS_Roboto_17", 10, h/2, Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
		end

		local RewardsPageEntryAmount = vgui.Create( "brickscrafting_numslider", RewardsPageEntry )
		RewardsPageEntryAmount:Dock( RIGHT )
		RewardsPageEntryAmount:DockMargin( 0, 0, 20, 0 )
		RewardsPageEntryAmount:SetWide( 150 )
		RewardsPageEntryAmount:SetText( "" )
		RewardsPageEntryAmount:SetMin( 0 )
		RewardsPageEntryAmount:SetMax( BRICKSCRAFTING.LUACONFIG.Defaults.QuestResGoalMax )
		RewardsPageEntryAmount:SetDecimals( 0 )
		RewardsPageEntryAmount:SetDark( true )
		RewardsPageEntryAmount:DisableStuff()
		RewardsPageEntryAmount.OnValueChanged = function( self2, val )
			val = math.Round( val )

			if( not QuestTable.Rewards["Resources"] ) then
				QuestTable.Rewards["Resources"] = {}
			end

			if( val > 0 ) then
				QuestTable.Rewards["Resources"][k] = val
			else
				if( QuestTable.Rewards["Resources"][k] ) then
					QuestTable.Rewards["Resources"][k] = nil
				end
			end
		end
	end

	for k, v in pairs( BCS_ADMIN_CFG.Crafting ) do
		for key, val in pairs( BCS_ADMIN_CFG.Crafting[k].Items or {} ) do
			local RewardsPageEntry = vgui.Create( "DPanel", RewardsPageScroll["Craftable"] )
			RewardsPageEntry:Dock( TOP )
			RewardsPageEntry:DockMargin( 0, 10, 0, 0 )
			RewardsPageEntry:SetTall( 30 )
			RewardsPageEntry.Paint = function( self2, w, h )
				BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
				local x, y = self2:LocalToScreen( 0, 0 )
				surface.SetDrawColor( 30, 30, 44 )
				surface.DrawRect( x, y, w, h )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )			
				
				draw.SimpleText( val.Name, "BCS_Roboto_17", 10, h/2, Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
			end

			local RewardsPageEntryAmount = vgui.Create( "brickscrafting_numslider", RewardsPageEntry )
			RewardsPageEntryAmount:Dock( RIGHT )
			RewardsPageEntryAmount:DockMargin( 0, 0, 20, 0 )
			RewardsPageEntryAmount:SetWide( 150 )
			RewardsPageEntryAmount:SetText( "" )
			RewardsPageEntryAmount:SetMin( 0 )
			RewardsPageEntryAmount:SetMax( BRICKSCRAFTING.LUACONFIG.Defaults.QuestCraftGoalMax )
			RewardsPageEntryAmount:SetDecimals( 0 )
			RewardsPageEntryAmount:SetDark( true )
			RewardsPageEntryAmount:DisableStuff()
			RewardsPageEntryAmount.OnValueChanged = function( self2, val )
				val = math.Round( val )

				if( not QuestTable.Rewards["Craftable"] ) then
					QuestTable.Rewards["Craftable"] = {}
				end

				if( not QuestTable.Rewards["Craftable"][k] ) then
					QuestTable.Rewards["Craftable"][k] = {}
				end

				if( val > 0 ) then
					QuestTable.Rewards["Craftable"][k][key] = val
				else
					if( QuestTable.Rewards["Craftable"][k][key] ) then
						QuestTable.Rewards["Craftable"][k][key] = nil
					end
				end
			end
		end
	end

	local RewardsPageFinish = vgui.Create( "DButton", RewardsPage )
	RewardsPageFinish:Dock( BOTTOM )
	RewardsPageFinish:DockMargin( 10, 0, 10, 10 )
	RewardsPageFinish:SetTall( 40 )
	RewardsPageFinish:SetText( "" )
	local Alpha = 0
	RewardsPageFinish.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 0, 100 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 0, 200 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 100 )
		end

		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )	

		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( 0, 0, w, h )

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestCreate"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	RewardsPageFinish.DoClick = function()
		table.insert( BCS_ADMIN_CFG.Quests, QuestTable )
		BCS_ADMIN_CFG_CHANGED = true

		if( self.func_Close ) then
			self.func_Close()
		end

		self:Remove()
	end

	--[[ Top Bar ]]--
	local TopBar = vgui.Create( "DPanel", self.PanelBack )
	TopBar:SetPos( 0, 0 )
	TopBar:SetSize( self.PanelBack:GetWide(), 30+BCS_DRAWING.ShadowSize )
	TopBar.Paint = function( self2, w, h )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( 0, 0, w, h-BCS_DRAWING.ShadowSize )

		BCS_DRAWING.DrawMaterialShadow( 0, h-BCS_DRAWING.ShadowSize, w, BCS_DRAWING.ShadowSize, "Down" )
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestCreator"), "BCS_Roboto_22", w/2, (h-BCS_DRAWING.ShadowSize)/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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

vgui.Register( "brickscrafting_vgui_admin_addquest", PANEL, "DFrame" )




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

function PANEL:SetQuestData( QuestKey )
	self.PanelBack:Clear()

	local ScrollY, ScrollH = ((ScrH()/2)-(self.PanelBack:GetTall()/2))+30, self.PanelBack:GetTall()-30

	if( not BCS_ADMIN_CFG.Quests[QuestKey] ) then return end

	local QuestTable = BCS_ADMIN_CFG.Quests[QuestKey]

	local GoalPage
	local RewardsPage

	local BasicInfoPage = vgui.Create( "DPanel", self.PanelBack )
	BasicInfoPage:SetPos( 0, 30 )
	BasicInfoPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
	BasicInfoPage.Paint = function( self2, w, h ) end

	local BasicInfoName = vgui.Create( "DPanel", BasicInfoPage )
	BasicInfoName:Dock( TOP )
	BasicInfoName:DockMargin( 10, 10, 10, 0 )
	BasicInfoName:SetTall( 65 )
	BasicInfoName.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestName"), "BCS_Roboto_17", w/2, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local BasicInfoNameText = vgui.Create( "DTextEntry", BasicInfoName )
	BasicInfoNameText:Dock( FILL )
	BasicInfoNameText:DockMargin( 10, 10+15, 10, 10 )
	BasicInfoNameText:SetText( QuestTable.Name )

	local BasicInfoDescription = vgui.Create( "DPanel", BasicInfoPage )
	BasicInfoDescription:Dock( TOP )
	BasicInfoDescription:DockMargin( 10, 10, 10, 0 )
	BasicInfoDescription:SetTall( 65 )
	BasicInfoDescription.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestDes"), "BCS_Roboto_17", w/2, 25/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local BasicInfoDescriptionText = vgui.Create( "DTextEntry", BasicInfoDescription )
	BasicInfoDescriptionText:Dock( FILL )
	BasicInfoDescriptionText:DockMargin( 10, 10+15, 10, 10 )
	BasicInfoDescriptionText:SetText( QuestTable.Description )

	local BasicInfoDailyText = vgui.Create( "DButton", BasicInfoPage )
	BasicInfoDailyText:Dock( TOP )
	BasicInfoDailyText:DockMargin( 10, 10, 10, 0 )
	BasicInfoDailyText:SetTall( 40 )
	BasicInfoDailyText:SetText( "" )
	local Alpha = 150
	BasicInfoDailyText.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 150, 200 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 150, 240 )
		else
			Alpha = math.Clamp( Alpha-5, 150, 240 )
		end

		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

		if( QuestTable.Daily ) then
			surface.SetDrawColor( 14, 97, 24, Alpha )
		else
			surface.SetDrawColor( 110, 14, 24, Alpha )
		end	

		surface.DrawRect( 0, 0, w, h )

		if( DailyQuest ) then
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestDaily") .. " - " .. BRICKSCRAFTING.L("vguiConfigQuestEnabled"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		else
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestDaily") .. " - " .. BRICKSCRAFTING.L("vguiConfigQuestDisabled"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		end
	end
	BasicInfoDailyText.DoClick = function()
		if( QuestTable.Daily ) then
			QuestTable.Daily = false
		else
			QuestTable.Daily = true
		end	
	end

	local BasicInfoIcon = vgui.Create( "brickscrafting_scrollpanel", BasicInfoPage )
	BasicInfoIcon:Dock( FILL )
	BasicInfoIcon:DockMargin( 10, 10, 10, 0 )

	local ItemWide = 6
	local Spacing = 10
	local Size = ((self.PanelBack:GetWide()-50-((ItemWide-1)*Spacing))/ItemWide)

	local BasicInfoIconList = vgui.Create( "DIconLayout", BasicInfoIcon )
	BasicInfoIconList:Dock( FILL )
	BasicInfoIconList:DockMargin( 0, 0, 10, 0 )
	BasicInfoIconList:SetSpaceX( Spacing )
	BasicInfoIconList:SetSpaceY( Spacing )

	local ChosenIcon = QuestTable.Icon or ""
	local function RefreshIcons()
		BasicInfoIconList:Clear()

		for k, v in pairs( BCS_MATERIALS ) do
			local BasicInfoIconEntry = vgui.Create( "DButton", BasicInfoIconList )
			BasicInfoIconEntry:SetSize( Size, Size )
			BasicInfoIconEntry:SetToolTip( k )
			BasicInfoIconEntry:SetText( "" )
			local Alpha = 0
			BasicInfoIconEntry.Paint = function( self2, w, h )
				if( self2:IsHovered() and !self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+5, 0, 100 )
				elseif( self2:IsDown() ) then
					Alpha = math.Clamp( Alpha+10, 0, 200 )
				else
					Alpha = math.Clamp( Alpha-5, 0, 100 )
				end

				if( ChosenIcon == k ) then
					Alpha = 255
				end
				
				BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
				surface.SetDrawColor( 30, 30, 44 )
				local x, y = self2:LocalToScreen( 0, 0 )
				surface.DrawRect( x, y, w, h )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
		
				surface.SetDrawColor( 20, 20, 30, Alpha )
				surface.DrawRect( 0, 0, w, h )
		
				surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial( v )
				local Spacing = 10
				surface.DrawTexturedRect( Spacing, Spacing, w-(2*Spacing), h-(2*Spacing) )
			end
			BasicInfoIconEntry.DoClick = function()
				ChosenIcon = k
			end
		end
	end
	RefreshIcons()

	local BasicInfoNext = vgui.Create( "DButton", BasicInfoPage )
	BasicInfoNext:Dock( BOTTOM )
	BasicInfoNext:DockMargin( 10, 10, 10, 10 )
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
		if( not BCS_MATERIALS[ChosenIcon] ) then
			notification.AddLegacy( BRICKSCRAFTING.L("vguiConfigQuestNeedIcon"), 1, 5 )
			return
		end

		QuestTable.Name = BasicInfoNameText:GetText()
		QuestTable.Description = BasicInfoDescriptionText:GetText()
		QuestTable.Icon = ChosenIcon

		BasicInfoPage:MoveTo( 0, -BasicInfoPage:GetTall(), 0.5, 0, 1, function() 
			BasicInfoPage:SetVisible( false )
		end )

		GoalPage:SetVisible( true )
		GoalPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
		end )
	end

	--  Goal Page
	GoalPage = vgui.Create( "DPanel", self.PanelBack )
	GoalPage:SetPos( 0, self.PanelBack:GetTall() )
	GoalPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
	GoalPage:SetVisible( false )
	GoalPage.Paint = function( self2, w, h ) end

	local GoalPageHeader = vgui.Create( "DPanel", GoalPage )
	GoalPageHeader:Dock( TOP )
	GoalPageHeader:DockMargin( 10, 10, 10, 0 )
	GoalPageHeader:SetTall( 30 )
	GoalPageHeader.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestWhatDo"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local GoalPageScroll = vgui.Create( "brickscrafting_categorylist", GoalPage )
	GoalPageScroll:Dock( FILL )
	GoalPageScroll:DockMargin( 10, 10, 10, 0 )
	GoalPageScroll.pnlCanvas:DockPadding( 0, 0, 10, 10 )
	GoalPageScroll.Paint = function() end

	QuestTable.Goal = QuestTable.Goal or {}
	for k, v in pairs( BRICKSCRAFTING.QuestTypes ) do
		GoalPageScroll[k] = GoalPageScroll:Add( v.GoalHeader )
	end

	for k, v in pairs( BCS_ADMIN_CFG.Resources ) do
		local GoalPageEntry = vgui.Create( "DPanel", GoalPageScroll["Resource"] )
		GoalPageEntry:Dock( TOP )
		GoalPageEntry:DockMargin( 0, 10, 0, 0 )
		GoalPageEntry:SetTall( 30 )
		GoalPageEntry.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )			
			
			draw.SimpleText( k, "BCS_Roboto_17", 10, h/2, Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
		end

		local GoalPageEntryAmount = vgui.Create( "brickscrafting_numslider", GoalPageEntry )
		GoalPageEntryAmount:Dock( RIGHT )
		GoalPageEntryAmount:DockMargin( 0, 0, 20, 0 )
		GoalPageEntryAmount:SetWide( 150 )
		GoalPageEntryAmount:SetText( "" )
		GoalPageEntryAmount:SetMin( 0 )
		GoalPageEntryAmount:SetMax( BRICKSCRAFTING.LUACONFIG.Defaults.QuestResGoalMax )
		GoalPageEntryAmount:SetDecimals( 0 )
		GoalPageEntryAmount:SetDark( true )
		GoalPageEntryAmount:DisableStuff()
		if( QuestTable.Goal["Resource"] and QuestTable.Goal["Resource"][k] ) then
			GoalPageEntryAmount:SetValue( QuestTable.Goal["Resource"][k] )
		end
		GoalPageEntryAmount.OnValueChanged = function( self2, val )
			val = math.Round( val )

			if( not QuestTable.Goal["Resource"] ) then
				QuestTable.Goal["Resource"] = {}
			end

			if( val > 0 ) then
				QuestTable.Goal["Resource"][k] = val
			else
				if( QuestTable.Goal["Resource"][k] ) then
					QuestTable.Goal["Resource"][k] = nil
				end
			end
		end
	end

	for k, v in pairs( BCS_ADMIN_CFG.Crafting ) do
		for key, val in pairs( BCS_ADMIN_CFG.Crafting[k].Items or {} ) do
			local GoalPageEntry = vgui.Create( "DPanel", GoalPageScroll["Craft"] )
			GoalPageEntry:Dock( TOP )
			GoalPageEntry:DockMargin( 0, 10, 0, 0 )
			GoalPageEntry:SetTall( 30 )
			GoalPageEntry.Paint = function( self2, w, h )
				BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
				surface.SetDrawColor( 30, 30, 44 )
				local x, y = self2:LocalToScreen( 0, 0 )
				surface.DrawRect( x, y, w, h )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )					
				
				draw.SimpleText( val.Name, "BCS_Roboto_17", 10, h/2, Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
			end

			local GoalPageEntryAmount = vgui.Create( "brickscrafting_numslider", GoalPageEntry )
			GoalPageEntryAmount:Dock( RIGHT )
			GoalPageEntryAmount:DockMargin( 0, 0, 20, 0 )
			GoalPageEntryAmount:SetWide( 150 )
			GoalPageEntryAmount:SetText( "" )
			GoalPageEntryAmount:SetMin( 0 )
			GoalPageEntryAmount:SetMax( BRICKSCRAFTING.LUACONFIG.Defaults.QuestCraftGoalMax )
			GoalPageEntryAmount:SetDecimals( 0 )
			GoalPageEntryAmount:SetDark( true )
			GoalPageEntryAmount:DisableStuff()
			if( QuestTable.Goal["Craft"] and QuestTable.Goal["Craft"][k] and QuestTable.Goal["Craft"][k][key] ) then
				GoalPageEntryAmount:SetValue( QuestTable.Goal["Craft"][k][key] )
			end
			GoalPageEntryAmount.OnValueChanged = function( self2, val )
				val = math.Round( val )

				if( not QuestTable.Goal["Craft"] ) then
					QuestTable.Goal["Craft"] = {}
				end

				if( not QuestTable.Goal["Craft"][k] ) then
					QuestTable.Goal["Craft"][k] = {}
				end

				if( val > 0 ) then
					QuestTable.Goal["Craft"][k][key] = val
				else
					if( QuestTable.Goal["Craft"][k][key] ) then
						QuestTable.Goal["Craft"][k][key] = nil
					end

					if( table.Count( QuestTable.Goal["Craft"][k] ) <= 0 ) then
						QuestTable.Goal["Craft"][k] = nil

						if( table.Count( QuestTable.Goal["Craft"] ) > 0 ) then
							for key2, val2 in pairs( QuestTable.Goal["Craft"] ) do
								if( table.Count( val2 ) <= 0 ) then
									QuestTable.Goal["Craft"][key2] = nil
								end
							end
						end

						if( table.Count( QuestTable.Goal["Craft"] ) <= 0 ) then
							QuestTable.Goal["Craft"] = nil
						end
					end
				end
			end
		end
	end

	local GoalPageNext = vgui.Create( "DButton", GoalPage )
	GoalPageNext:Dock( BOTTOM )
	GoalPageNext:DockMargin( 10, 10, 10, 10 )
	GoalPageNext:SetTall( 40 )
	GoalPageNext:SetText( "" )
	local Alpha = 0
	GoalPageNext.Paint = function( self2, w, h )
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
	GoalPageNext.DoClick = function()
		GoalPage:MoveTo( 0, -GoalPage:GetTall(), 0.5, 0, 1, function() 
			GoalPage:SetVisible( false )
		end )

		RewardsPage:SetVisible( true )
		RewardsPage:MoveTo( 0, 30, 0.5, 0, 1, function() 
		end )
	end

	-- Rewards Page
	RewardsPage = vgui.Create( "DPanel", self.PanelBack )
	RewardsPage:SetPos( 0, self.PanelBack:GetTall() )
	RewardsPage:SetSize( self.PanelBack:GetWide(), self.PanelBack:GetTall()-30 )
	RewardsPage:SetVisible( false )
	RewardsPage.Paint = function( self2, w, h ) end

	local RewardsPageHeader = vgui.Create( "DPanel", RewardsPage )
	RewardsPageHeader:Dock( TOP )
	RewardsPageHeader:DockMargin( 10, 10, 10, 0 )
	RewardsPageHeader:SetTall( 30 )
	RewardsPageHeader.Paint = function( self2, w, h )
		BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
		surface.SetDrawColor( 30, 30, 44 )
		local x, y = self2:LocalToScreen( 0, 0 )
		surface.DrawRect( x, y, w, h )			
		BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestRewards"), "BCS_Roboto_17", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local RewardsPageScroll = vgui.Create( "brickscrafting_categorylist", RewardsPage )
	RewardsPageScroll:Dock( FILL )
	RewardsPageScroll:DockMargin( 10, 10, 10, 10 )
	RewardsPageScroll.pnlCanvas:DockPadding( 0, 0, 10, 0 )
	RewardsPageScroll.Paint = function() end

	QuestTable.Rewards = QuestTable.Rewards or {}
	for k, v in pairs( BRICKSCRAFTING.RewardTypes ) do
		RewardsPageScroll[k] = RewardsPageScroll:Add( v.Name or k )
	end

	if( BRICKSCRAFTING.LUACONFIG.DarkRP ) then
		local RewardsPageMoney = vgui.Create( "DPanel", RewardsPageScroll["Money"] )
		RewardsPageMoney:Dock( TOP )
		RewardsPageMoney:DockMargin( 0, 10, 0, 0 )
		RewardsPageMoney:SetTall( 30 )
		RewardsPageMoney.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )					
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestMoney"), "BCS_Roboto_17", 10, h/2, Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
		end

		local RewardsPageMoneyAmount = vgui.Create( "brickscrafting_textentry", RewardsPageMoney )
		RewardsPageMoneyAmount:Dock( RIGHT )
		RewardsPageMoneyAmount:DockMargin( 0, 0, 20, 0 )
		RewardsPageMoneyAmount:SetWide( 150 )
		RewardsPageMoneyAmount:SetText( (QuestTable.Rewards["Money"] or {})[1] or 0 )
		RewardsPageMoneyAmount.OnChange = function( self2 )
			val = tonumber( RewardsPageMoneyAmount:GetValue() )

			if( not isnumber(val) ) then return end

			if( val > 0 ) then
				if( not QuestTable.Rewards["Money"] ) then
					QuestTable.Rewards["Money"] = {}
				end
				QuestTable.Rewards["Money"][1] = val
			else
				if( QuestTable.Rewards["Money"] ) then
					QuestTable.Rewards["Money"] = nil
				end
			end
		end
	end

	for k, v in pairs( BCS_ADMIN_CFG.Resources ) do
		local RewardsPageEntry = vgui.Create( "DPanel", RewardsPageScroll["Resources"] )
		RewardsPageEntry:Dock( TOP )
		RewardsPageEntry:DockMargin( 0, 10, 0, 0 )
		RewardsPageEntry:SetTall( 30 )
		RewardsPageEntry.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )				
			
			draw.SimpleText( k, "BCS_Roboto_17", 10, h/2, Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
		end

		local RewardsPageEntryAmount = vgui.Create( "brickscrafting_numslider", RewardsPageEntry )
		RewardsPageEntryAmount:Dock( RIGHT )
		RewardsPageEntryAmount:DockMargin( 0, 0, 20, 0 )
		RewardsPageEntryAmount:SetWide( 150 )
		RewardsPageEntryAmount:SetText( "" )
		RewardsPageEntryAmount:SetMin( 0 )
		RewardsPageEntryAmount:SetMax( BRICKSCRAFTING.LUACONFIG.Defaults.QuestResGoalMax )
		RewardsPageEntryAmount:SetDecimals( 0 )
		RewardsPageEntryAmount:SetDark( true )
		RewardsPageEntryAmount:DisableStuff()
		if( QuestTable.Rewards["Resources"] and QuestTable.Rewards["Resources"][k] ) then
			RewardsPageEntryAmount:SetValue( QuestTable.Rewards["Resources"][k] )
		end
		RewardsPageEntryAmount.OnValueChanged = function( self2, val )
			val = math.Round( val )

			if( not QuestTable.Rewards["Resources"] ) then
				QuestTable.Rewards["Resources"] = {}
			end

			if( val > 0 ) then
				QuestTable.Rewards["Resources"][k] = val
			else
				if( QuestTable.Rewards["Resources"][k] ) then
					QuestTable.Rewards["Resources"][k] = nil
				end
			end
		end
	end

	for k, v in pairs( BCS_ADMIN_CFG.Crafting ) do
		for key, val in pairs( BCS_ADMIN_CFG.Crafting[k].Items or {} ) do
			local RewardsPageEntry = vgui.Create( "DPanel", RewardsPageScroll["Craftable"] )
			RewardsPageEntry:Dock( TOP )
			RewardsPageEntry:DockMargin( 0, 10, 0, 0 )
			RewardsPageEntry:SetTall( 30 )
			RewardsPageEntry.Paint = function( self2, w, h )
				BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
				surface.SetDrawColor( 30, 30, 44 )
				local x, y = self2:LocalToScreen( 0, 0 )
				surface.DrawRect( x, y, w, h )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )				
				
				draw.SimpleText( val.Name, "BCS_Roboto_17", 10, h/2, Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
			end

			local RewardsPageEntryAmount = vgui.Create( "brickscrafting_numslider", RewardsPageEntry )
			RewardsPageEntryAmount:Dock( RIGHT )
			RewardsPageEntryAmount:DockMargin( 0, 0, 20, 0 )
			RewardsPageEntryAmount:SetWide( 150 )
			RewardsPageEntryAmount:SetText( "" )
			RewardsPageEntryAmount:SetMin( 0 )
			RewardsPageEntryAmount:SetMax( BRICKSCRAFTING.LUACONFIG.Defaults.QuestCraftGoalMax )
			RewardsPageEntryAmount:SetDecimals( 0 )
			RewardsPageEntryAmount:SetDark( true )
			RewardsPageEntryAmount:DisableStuff()
			if( QuestTable.Rewards["Craftable"] and QuestTable.Rewards["Craftable"][k] and QuestTable.Rewards["Craftable"][k][key] ) then
				RewardsPageEntryAmount:SetValue( QuestTable.Rewards["Craftable"][k][key] )
			end
			RewardsPageEntryAmount.OnValueChanged = function( self2, val )
				val = math.Round( val )

				if( not QuestTable.Rewards["Craftable"] ) then
					QuestTable.Rewards["Craftable"] = {}
				end

				if( not QuestTable.Rewards["Craftable"][k] ) then
					QuestTable.Rewards["Craftable"][k] = {}
				end

				if( val > 0 ) then
					QuestTable.Rewards["Craftable"][k][key] = val
				else
					if( QuestTable.Rewards["Craftable"][k][key] ) then
						QuestTable.Rewards["Craftable"][k][key] = nil
					end
				end
			end
		end
	end

	local RewardsPageFinish = vgui.Create( "DButton", RewardsPage )
	RewardsPageFinish:Dock( BOTTOM )
	RewardsPageFinish:DockMargin( 10, 0, 10, 10 )
	RewardsPageFinish:SetTall( 40 )
	RewardsPageFinish:SetText( "" )
	local Alpha = 0
	RewardsPageFinish.Paint = function( self2, w, h )
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
	RewardsPageFinish.DoClick = function()
		BCS_ADMIN_CFG.Quests[QuestKey] = QuestTable
		BCS_ADMIN_CFG_CHANGED = true

		if( self.func_Close ) then
			self.func_Close()
		end

		self:Remove()
	end

	--[[ Top Bar ]]--
	local TopBar = vgui.Create( "DPanel", self.PanelBack )
	TopBar:SetPos( 0, 0 )
	TopBar:SetSize( self.PanelBack:GetWide(), 30+BCS_DRAWING.ShadowSize )
	TopBar.Paint = function( self2, w, h )
		surface.SetDrawColor( 30, 30, 44 )
		surface.DrawRect( 0, 0, w, h-BCS_DRAWING.ShadowSize )

		BCS_DRAWING.DrawMaterialShadow( 0, h-BCS_DRAWING.ShadowSize, w, BCS_DRAWING.ShadowSize, "Down" )
		
		draw.SimpleText( BRICKSCRAFTING.L("vguiConfigQuestEditor"), "BCS_Roboto_22", w/2, (h-BCS_DRAWING.ShadowSize)/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
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

vgui.Register( "brickscrafting_vgui_admin_editquest", PANEL, "DFrame" )