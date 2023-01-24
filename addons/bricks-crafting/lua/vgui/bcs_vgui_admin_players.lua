-- "addons\\bricks-crafting\\lua\\vgui\\bcs_vgui_admin_players.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local PANEL = {}

function PANEL:Init()
	function self:RefreshPlayers()
		self:Clear()

		for k, v in pairs( player.GetAll() ) do
			if( not IsValid( v ) or not v:Nick() ) then continue end
			if( not string.find( string.lower( v:Nick() ), string.lower( self.SearchBarText or "" ) ) and not string.find( v:SteamID64() or "", self.SearchBarText or "" ) ) then continue end

			local PlayerEntry = vgui.Create( "DPanel", self )
			PlayerEntry:Dock( TOP )
			PlayerEntry:DockMargin( 0, 0, 37, 15 )
			PlayerEntry:SetTall( 125 )
			local InvX, InvY = 0, (ScrH()/2)-(((710/1080)*ScrH()+50)/2)
			local ScrollY, ScrollH = InvY+185, ((710/1080)*ScrH()+50)-185-65
			PlayerEntry.Paint = function( self2, w, h )
				BCS_BSHADOWS.BeginShadow( 0, ScrollY, ScrW(), ScrollY+ScrollH )
				surface.SetDrawColor( 30, 30, 44 )
				local x, y = self2:LocalToScreen( 0, 0 )
				surface.DrawRect( x, y, w, h )			
				BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )		

				draw.SimpleText( v:Nick(), "BCS_Roboto_25", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
				draw.SimpleText( (v:SteamID64() or BRICKSCRAFTING.L("vguiPlayersBOT")) .. " - " .. (BRICKSCRAFTING.GetAdminGroup( v ) or BRICKSCRAFTING.L("vguiPlayersUnknown")), "BCS_Roboto_16", h+20, 52, Color( 255, 255, 255 ), 0, 0 )
			end

			local Avatar = vgui.Create( "AvatarImage", PlayerEntry )
			Avatar:Dock( LEFT )
			local Margin = 10
			Avatar:DockMargin( Margin, Margin, Margin, Margin )
			Avatar:SetWide( PlayerEntry:GetTall()-(2*Margin) )
			Avatar:SetPlayer( v, 64 )

			local PlayerActionsBack = vgui.Create( "DPanel", PlayerEntry )
			PlayerActionsBack:Dock( RIGHT )
			PlayerActionsBack:SetWide( 150 )
			PlayerActionsBack.Paint = function( self2, w, h )
			end

			local PlayerActionsBack2 = vgui.Create( "DPanel", PlayerEntry )
			PlayerActionsBack2:Dock( RIGHT )
			PlayerActionsBack2:SetWide( 150 )
			PlayerActionsBack2.Paint = function( self2, w, h )
			end

			local Count = 0
			local function CreateActionButton( Text, func_click )
				Count = Count+1

				local parent = PlayerActionsBack
				if( Count > 4 ) then
					parent = PlayerActionsBack2
				end
				local PlayerActionButton = vgui.Create( "DButton", parent )
				PlayerActionButton:Dock( TOP )
				PlayerActionButton:DockMargin( 0, 5, 5, 0 )
				local Tall = (PlayerEntry:GetTall()-(5*5))/4
				PlayerActionButton:SetTall( Tall )
				PlayerActionButton:SetText( "" )
				local Alpha = 0
				PlayerActionButton.Paint = function( self2, w, h )
					if( self2:IsHovered() and !self2:IsDown() ) then
						Alpha = math.Clamp( Alpha+5, 0, 100 )
					elseif( self2:IsDown() ) then
						Alpha = math.Clamp( Alpha+10, 0, 200 )
					else
						Alpha = math.Clamp( Alpha-5, 0, 100 )
					end

					surface.SetDrawColor( 24, 25, 34 )
					surface.DrawRect( 0, 0, w, h )

					surface.SetDrawColor( 10, 10, 20, Alpha )
					surface.DrawRect( 0, 0, w, h )
					
					draw.SimpleText( Text, "BCS_Roboto_16", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
				PlayerActionButton.DoClick = func_click
			end

			CreateActionButton( BRICKSCRAFTING.L("vguiPlayersAssignResources"), function() 
				if( not IsValid( BCS_Admin_ResAdd ) ) then
					BCS_Admin_ResAdd = vgui.Create( "bcs_vgui_admin_resources", BCS_AdminMenu )
					BCS_Admin_ResAdd:SetReceiver( v:SteamID64() )
				else
					BCS_Admin_ResAdd:SetReceiver( v:SteamID64() )
				end
			end )

			CreateActionButton( BRICKSCRAFTING.L("vguiAdminPlayersSetSkill"), function() 
				local function SetSkillLevel( skill, max, benchType )
					BCS_DRAWING.SliderRequest( skill, BRICKSCRAFTING.L("vguiAdminPlayersSetSkillLvl"), 0, max, function( num ) 
						net.Start( "BCS_Net_SetSkill" )
							net.WriteString( v:SteamID64() )
							net.WriteString( benchType )
							net.WriteInt( num, 32 )
						net.SendToServer()
					end, function() end, BRICKSCRAFTING.L("vguiSet"), BRICKSCRAFTING.L("vguiCancel") )
				end

				local menu = DermaMenu()
				for key, val in pairs( BRICKSCRAFTING.BASECONFIG.Crafting ) do
					menu:AddOption( val.Skill[1] or "", function()  
						SetSkillLevel( val.Skill[1], val.Skill[2], key )
					end )
				end
				menu:AddOption( BRICKSCRAFTING.L("mining"), function()  
					SetSkillLevel( BRICKSCRAFTING.L("mining"), BRICKSCRAFTING.CONFIG.Tools.MaxPickaxeSkill, "Mining" )
				end )
				menu:AddOption( BRICKSCRAFTING.L("woodCutting"), function()  
					SetSkillLevel( BRICKSCRAFTING.L("woodCutting"), BRICKSCRAFTING.CONFIG.Tools.MaxLumberAxeSkill, "Wood Cutting" )
				end )
				menu:Open()
			end )

			CreateActionButton( BRICKSCRAFTING.L("vguiPlayersClearStorage"), function() 
				BCS_DRAWING.Query( BRICKSCRAFTING.L("vguiPlayersWhatToClear"), BRICKSCRAFTING.L("vguiPlayersStorageClearer"), BRICKSCRAFTING.L("vguiPlayersStorageAndResources"), function() 
					BCS_DRAWING.Query( string.format( BRICKSCRAFTING.L("vguiPlayersClearStorageResQuestion"), v:Nick() ), BRICKSCRAFTING.L("vguiPlayersStorageClearer"), BRICKSCRAFTING.L("vguiYes"), function() 
						net.Start( "BCS_Net_ClearStorage" )
							net.WriteString( v:SteamID64() )
							net.WriteBool( true )
						net.SendToServer()
					end, BRICKSCRAFTING.L("vguiNo"), function() end )
				end, BRICKSCRAFTING.L("vguiPlayersStorage"), function()
					BCS_DRAWING.Query( string.format( BRICKSCRAFTING.L("vguiPlayersClearStorageQuestion"), v:Nick() ), BRICKSCRAFTING.L("vguiPlayersStorageClearer"), BRICKSCRAFTING.L("vguiYes"), function() 
						net.Start( "BCS_Net_ClearStorage" )
							net.WriteString( v:SteamID64() )
							net.WriteBool( false )
						net.SendToServer()
					end, BRICKSCRAFTING.L("vguiNo"), function() end )
				end )
			end )

			CreateActionButton( BRICKSCRAFTING.L("vguiPlayersClearData"), function() 
				BCS_DRAWING.Query( string.format( BRICKSCRAFTING.L("vguiPlayersClearDataQuestion"), v:Nick() ), BRICKSCRAFTING.L("vguiPlayersDataClearer"), BRICKSCRAFTING.L("vguiYes"), function() 
					net.Start( "BCS_Net_ClearData" )
						net.WriteString( v:SteamID64() )
					net.SendToServer()
				end, BRICKSCRAFTING.L("vguiNo"), function() end )
			end )

			CreateActionButton( BRICKSCRAFTING.L("vguiPlayersCompleteQuest"), function() 
				local menu = DermaMenu()
				for key, val in pairs( BRICKSCRAFTING.CONFIG.Quests ) do
					menu:AddOption( key .. ": " .. val.Name, function()  
						BCS_DRAWING.Query( BRICKSCRAFTING.L("vguiPlayersCompleteQuestQuestion"), BRICKSCRAFTING.L("vguiPlayersQuestRewards"), BRICKSCRAFTING.L("vguiYes"), function() 
							net.Start( "BCS_Net_AdminQuest" )
								net.WriteString( v:SteamID64() )
								net.WriteInt( key, 32 )
								net.WriteBool( true )
							net.SendToServer()
						end, BRICKSCRAFTING.L("vguiNo"), function()
							net.Start( "BCS_Net_AdminQuest" )
								net.WriteString( v:SteamID64() )
								net.WriteInt( key, 32 )
								net.WriteBool( false )
							net.SendToServer()
						end, BRICKSCRAFTING.L("vguiCancel"), function() end )
					end )
				end
				menu:Open()
			end )
		end
	end

	self:RefreshPlayers()
end

function PANEL:SearchRefresh( text )
	self.SearchBarText = text
	self:RefreshPlayers()
end

function PANEL:Paint( w, h )
end

vgui.Register( "bcs_vgui_admin_players", PANEL, "brickscrafting_scrollpanel" )