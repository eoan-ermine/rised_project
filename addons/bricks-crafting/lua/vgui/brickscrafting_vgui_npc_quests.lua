-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_npc_quests.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local PANEL = {}

function PANEL:Init()
	-- Quest Page --
	local QuestPage = self

	local QuestPageScroll = vgui.Create( "brickscrafting_categorylist", QuestPage )
	QuestPageScroll:Dock( FILL )
	QuestPageScroll.Paint = function( self2, w, h )
	end

	function self:RefreshQuests()
		QuestPageScroll:Clear()

		if( not IsValid( QuestPageScroll.CurrentQuests ) ) then
			QuestPageScroll.CurrentQuests = QuestPageScroll:Add( BRICKSCRAFTING.L("vguiNPCQuestsCurrent") )
		end
		if( not IsValid( QuestPageScroll.AvailableQuests ) ) then
			QuestPageScroll.AvailableQuests = QuestPageScroll:Add( BRICKSCRAFTING.L("vguiNPCQuestsAvailable") )
		end
		if( not IsValid( QuestPageScroll.CompletedQuests ) ) then
			QuestPageScroll.CompletedQuests = QuestPageScroll:Add( BRICKSCRAFTING.L("vguiNPCQuestsCompleted") )
		end

		for k, v in pairs( BRICKSCRAFTING.CONFIG.Quests ) do
			if( IsValid( self.SearchBar ) ) then
				if( not string.find( string.lower( v.Name ), string.lower( self.SearchBar:GetValue() ) ) ) then continue end
			end

			local CatBack = QuestPageScroll.AvailableQuests

			local MiscTable = LocalPlayer():GetBCS_MiscTable()
			if( MiscTable and MiscTable.Quests and MiscTable.Quests[k] ) then
				if( MiscTable.Quests[k].Status == true ) then
					if( not v.Daily ) then
						CatBack = QuestPageScroll.CompletedQuests
					else
						local TimeLeft = (MiscTable.Quests[k].Time+(BRICKSCRAFTING.LUACONFIG.Defaults.QuestResetTime or 86400))-os.time()
						if( TimeLeft > 0 ) then
							CatBack = QuestPageScroll.CompletedQuests
						end
					end
				elseif( MiscTable.Quests[k].Status == false ) then
					CatBack = QuestPageScroll.CurrentQuests
				end
			end

			local ItemEntry = vgui.Create( "DPanel", CatBack )
			ItemEntry:Dock( TOP )
			ItemEntry:DockMargin( 0, 15, 0, 0 )
			ItemEntry:SetTall( 125 )
			local InvX, InvY = 0, (ScrH()/2)-(((710/1080)*ScrH()+50)/2)
			local ScrollY, ScrollH = InvY+200, ((710/1080)*ScrH()+50)-200-65
			ItemEntry.Paint = function( self2, w, h )
				BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
				surface.SetDrawColor( 30, 30, 44 )
				local x, y = self2:LocalToScreen( 0, 0 )
				surface.DrawRect( x, y, w, h )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )

				surface.SetDrawColor( 30, 30, 44 )
				surface.DrawRect( 0, 0, w, h )	

				if( not MiscTable or not MiscTable.Quests or not MiscTable.Quests[k] or not MiscTable.Quests[k].Status == true or not MiscTable.Quests[k].Time ) then
					if( not v.Daily ) then	
						draw.SimpleText( v.Name, "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
					else
						draw.SimpleText( v.Name .. " " .. BRICKSCRAFTING.L("vguiNPCQuestsDaily"), "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
					end
				else
					if( not v.Daily ) then
						draw.SimpleText( v.Name .. " - " .. os.date( "%d/%m/%Y - %H:%M:%S" , MiscTable.Quests[k].Time ), "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
					else
						local TimeLeft = (MiscTable.Quests[k].Time+(BRICKSCRAFTING.LUACONFIG.Defaults.QuestResetTime or 86400))-os.time()
						if( TimeLeft > 0 ) then
							draw.SimpleText( v.Name .. " " .. BRICKSCRAFTING.L("vguiNPCQuestsDaily") .. " - " .. os.date( "%H:%M:%S" , TimeLeft ) , "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
						else
							draw.SimpleText( v.Name .. " " .. BRICKSCRAFTING.L("vguiNPCQuestsDaily") , "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
						end
					end
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

			local ResourceString = ""
			for key, val in pairs( v.Rewards ) do
				if( BRICKSCRAFTING.LUACONFIG.DarkRP and key == "Money" ) then
					if( ResourceString != "" ) then
						ResourceString = ResourceString .. "\n" .. DarkRP.formatMoney( val[1] )
					else
						ResourceString = DarkRP.formatMoney( val[1] )
					end
				elseif( key == "Craftable" ) then
					local String = ""
					for key2, val2 in pairs( val ) do
						if( BRICKSCRAFTING.CONFIG.Crafting[key2] ) then
							for key3, val3 in pairs( val2 ) do
								if( BRICKSCRAFTING.CONFIG.Crafting[key2].Items[key3] ) then
									String = String .. val3 .. " " .. BRICKSCRAFTING.CONFIG.Crafting[key2].Items[key3].Name .. "   "
								end
							end
						end
					end

					if( ResourceString != "" ) then
						ResourceString = ResourceString .. "\n" .. String
					else
						ResourceString = String
					end
				elseif( key == "Resources" ) then
					local String = ""
					for key2, val2 in pairs( val ) do
						String = String .. val2 .. " " .. key2 .. "   "
					end

					if( ResourceString != "" ) then
						ResourceString = ResourceString .. "\n" .. String
					else
						ResourceString = String
					end
				end
			end
			ItemIcon:SetToolTip( ResourceString )
			
			if( not MiscTable or not MiscTable.Quests or not MiscTable.Quests[k] or not MiscTable.Quests[k].Status == true or v.Daily ) then
				local ItemCraftButton = vgui.Create( "DButton", ItemEntry )
				ItemCraftButton:Dock( RIGHT )
				ItemCraftButton:SetWide( ItemEntry:GetTall() )
				ItemCraftButton:SetText( "" )
				local Text = BRICKSCRAFTING.L("vguiNPCQuestsAccept")
				if( MiscTable and MiscTable.Quests and MiscTable.Quests[k] and MiscTable.Quests[k].Status == false ) then
					if( LocalPlayer():GetBCS_QuestCompleted( k ) ) then
						Text = BRICKSCRAFTING.L("vguiNPCQuestsHandIn")
					else
						Text = BRICKSCRAFTING.L("vguiCancel")
					end
				end
				local Alpha = 150
				ItemCraftButton.Paint = function( self2, w, h )
					if( self2:IsHovered() and !self2:IsDown() ) then
						Alpha = math.Clamp( Alpha+5, 150, 200 )
					elseif( self2:IsDown() ) then
						Alpha = math.Clamp( Alpha+10, 150, 240 )
					else
						Alpha = math.Clamp( Alpha-5, 150, 240 )
					end

					if( Text != BRICKSCRAFTING.L("vguiCancel") ) then
						surface.SetDrawColor( 14, 97, 24, Alpha )
					else
						surface.SetDrawColor( 110, 14, 24, Alpha )
					end
					surface.DrawRect( 0, 0, w, h )
					
					draw.SimpleText( Text, "BCS_Roboto_24", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
				ItemCraftButton.DoClick = function()
					if( MiscTable and MiscTable.Quests and MiscTable.Quests[k] and MiscTable.Quests[k].Status == false ) then
						if( LocalPlayer():GetBCS_QuestCompleted( k ) ) then
							net.Start( "BCS_Net_HandInQuest" )
								net.WriteInt( k, 32 )
							net.SendToServer()
						else
							net.Start( "BCS_Net_CancelQuest" )
								net.WriteInt( k, 32 )
							net.SendToServer()
						end
					elseif( not MiscTable or not MiscTable.Quests or not MiscTable.Quests[k] or not MiscTable.Quests[k].Status == true ) then
						net.Start( "BCS_Net_AcceptQuest" )
							net.WriteInt( k, 32 )
						net.SendToServer()
					elseif( v.Daily ) then
						local TimeLeft = (MiscTable.Quests[k].Time+(BRICKSCRAFTING.LUACONFIG.Defaults.QuestResetTime or 86400))-os.time()
						if( TimeLeft <= 0 ) then
							net.Start( "BCS_Net_AcceptQuest" )
								net.WriteInt( k, 32 )
							net.SendToServer()
						end
					end
				end

				if( MiscTable and MiscTable.Quests and MiscTable.Quests[k] and v.Daily ) then
					local TimeLeft = ((MiscTable.Quests[k].Time or 0)+(BRICKSCRAFTING.LUACONFIG.Defaults.QuestResetTime or 86400))-os.time()
					if( TimeLeft > 0 ) then
						ItemCraftButton:Remove()
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
			ItemResEntryAmountHeader:SetText( BRICKSCRAFTING.L("vguiNPCQuestsRewards") .. "   " )
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
						if( BRICKSCRAFTING.CONFIG.Crafting[key2] ) then
							for key3, val3 in pairs( val2 ) do
								if( BRICKSCRAFTING.CONFIG.Crafting[key2].Items[key3] ) then
									String = String .. val3 .. " " .. BRICKSCRAFTING.CONFIG.Crafting[key2].Items[key3].Name .. "   "
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
					ItemResEntryAmount:Remove()
					continue
				end
				ItemResEntryAmount:SetTextColor( Color( 255, 255, 255 ) )
				ItemResEntryAmount:SetFont( "BCS_Roboto_16" )
				ItemResEntryAmount:SizeToContents()
			end

			if( MiscTable and MiscTable.Quests and MiscTable.Quests[k] and MiscTable.Quests[k].Status == false ) then
				local ItemProgressBack = vgui.Create( "DPanel", ItemEntry )
				ItemProgressBack:Dock( TOP )
				ItemProgressBack:DockMargin( 20, 0, 0, 0 )
				ItemProgressBack:SetTall( 20 )
				ItemProgressBack.Paint = function( self2, w, h ) end

				local ItemProgressEntryHeader = vgui.Create( "DLabel", ItemProgressBack )
				ItemProgressEntryHeader:Dock( LEFT )
				ItemProgressEntryHeader:DockMargin( 0, 0, 0, 0 )
				ItemProgressEntryHeader:SetText( BRICKSCRAFTING.L("vguiNPCQuestsProgress") .. "   " )
				ItemProgressEntryHeader:SetTextColor( Color( 255, 255, 255 ) )
				ItemProgressEntryHeader:SetFont( "BCS_Roboto_16" )
				ItemProgressEntryHeader:SizeToContents()

				for key, val in pairs( v.Goal ) do
					local ItemProgressEntry = vgui.Create( "DLabel", ItemProgressBack )
					ItemProgressEntry:Dock( LEFT )
					ItemProgressEntry:DockMargin( 0, 0, 10, 0 )
					ItemProgressEntry:SetText( "" )
					ItemProgressEntry:SetTextColor( Color( 255, 255, 255 ) )
					ItemProgressEntry:SetFont( "BCS_Roboto_16" )
					
					local Text = ""
					if( key == "Resource" ) then					
						for key2, val2 in pairs( val ) do
							if( MiscTable.Quests[k].Progress and MiscTable.Quests[k].Progress[key] and MiscTable.Quests[k].Progress[key][key2] ) then
								Text = Text .. key2 .. ": " .. (MiscTable.Quests[k].Progress[key][key2] or 0) .. "/" .. val2 .. "   "
							else
								Text = Text .. key2 .. ": " .. 0 .. "/" .. val2 .. "   "
							end
						end
					elseif( key == "Craft" ) then
						for key2, val2 in pairs( val ) do
							if( BRICKSCRAFTING.CONFIG.Crafting[key2] ) then
								for key3, val3 in pairs( val2 ) do
									if( BRICKSCRAFTING.CONFIG.Crafting[key2].Items[key3] ) then
										if( MiscTable.Quests[k].Progress and MiscTable.Quests[k].Progress[key] and MiscTable.Quests[k].Progress[key][key2] and MiscTable.Quests[k].Progress[key][key2][key3] ) then
											Text = Text .. BRICKSCRAFTING.CONFIG.Crafting[key2].Items[key3].Name .. ": " .. (MiscTable.Quests[k].Progress[key][key2][key3] or 0) .. "/" .. val3 .. "  "
										else
											Text = Text .. BRICKSCRAFTING.CONFIG.Crafting[key2].Items[key3].Name .. ": " .. 0 .. "/" .. val3 .. "  "
										end
									end
								end
							end
						end
					end

					ItemProgressEntry:SetText( Text )
					ItemProgressEntry:SizeToContents()
				end
			end
		end
	end

	self:RefreshQuests()
end

function PANEL:SetSearchBar( srchBar )
	self.SearchBar = srchBar
	srchBar.OnTextChanged = function( text )
		self:RefreshQuests()
	end
end

function PANEL:Think()
	local MiscTable = LocalPlayer():GetBCS_MiscTable()
	if( MiscTable and MiscTable.Quests ) then
		for k, v in pairs( MiscTable.Quests ) do
			local QuestTable = BRICKSCRAFTING.CONFIG.Quests[k]
			if( not QuestTable or not QuestTable.Daily or v.Status != true or v.Refreshed ) then continue end

			local TimeLeft = ((MiscTable.Quests[k].Time or 0)+(BRICKSCRAFTING.LUACONFIG.Defaults.QuestResetTime or 86400))-os.time()
			if( TimeLeft <= 0 ) then
				self:RefreshQuests()
				MiscTable.Quests[k].Refreshed = true
			end
		end
	end
end

function PANEL:Paint( w, h )
end

vgui.Register( "brickscrafting_vgui_npc_quests", PANEL, "DPanel" )