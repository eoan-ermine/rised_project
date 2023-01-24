-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_npc_tools.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local PANEL = {}

function PANEL:Init()
	-- Pickaxe Page --
	local PickaxePage = vgui.Create( "brickscrafting_scrollpanel", self )
	PickaxePage:Dock( FILL )
	PickaxePage.Paint = function( self2, w, h )
	end

	function self:RefreshPickaxe()
		PickaxePage:Clear()

		local MiscTable = LocalPlayer():GetBCS_MiscTable()

		local SkillProgress = vgui.Create( "DPanel", PickaxePage )
		SkillProgress:Dock( TOP )
		SkillProgress:DockMargin( 0, 0, 37, 0 )
		SkillProgress:SetTall( 30 )
		local SkillLevel = 0
		SkillProgress.Paint = function( self2, w, h )
			local SkillLevel = LocalPlayer():GetBCS_SkillLevel( "Mining" )
		
			surface.SetDrawColor( 0, 128, 181, 100 )
			surface.DrawRect( 0, 0, w, h )		
			
			surface.SetDrawColor( 0, 128, 181 )
			surface.DrawRect( 0, 0, math.Clamp( w*(SkillLevel/BRICKSCRAFTING.CONFIG.Tools.MaxPickaxeSkill), 0, w ), h )
			
			draw.SimpleText( BRICKSCRAFTING.L("mining"), "BCS_Roboto_18", 15, h/2, Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
			draw.SimpleText( SkillLevel .. "/" .. BRICKSCRAFTING.CONFIG.Tools.MaxPickaxeSkill, "BCS_Roboto_18", w-15, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		end

		local ItemEntry = vgui.Create( "DPanel", PickaxePage )
		ItemEntry:Dock( TOP )
		ItemEntry:DockMargin( 0, 10, 37, 0 )
		ItemEntry:SetTall( 125 )
		ItemEntry.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )

			draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickLevel") .. " " .. (MiscTable.PickaxeLevel or 0), "Trebuchet24", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
			draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickDes"), "BCS_Roboto_16", h+20, 52, Color( 255, 255, 255 ), 0, 0 )
			draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickCurLevel") .. " " .. ((BRICKSCRAFTING.CONFIG.Tools.Pickaxe[(MiscTable.PickaxeLevel or 0)] or {}).Increase or 0) .. "%", "BCS_Roboto_16", h+20, 73, Color( 255, 255, 255 ), 0, 0 )
			if( BRICKSCRAFTING.CONFIG.Tools.Pickaxe[(MiscTable.PickaxeLevel or 0)+1] ) then
				draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickNextLevel") .. " " .. (BRICKSCRAFTING.CONFIG.Tools.Pickaxe[(MiscTable.PickaxeLevel or 0)+1].Increase or 0) .. "%", "BCS_Roboto_16", h+20, 94, Color( 255, 255, 255 ), 0, 0 )
			end
		end

		local InvItemIcon = vgui.Create( "DModelPanel", ItemEntry )
		InvItemIcon:Dock( LEFT )
		InvItemIcon:SetWide( ItemEntry:GetTall() )
		InvItemIcon:SetModel( BRICKSCRAFTING.LUACONFIG.Defaults.PickaxeModel )		
		local mn, mx = InvItemIcon.Entity:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
		size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
		size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

		InvItemIcon:SetFOV( 45 )
		InvItemIcon:SetCamPos( Vector( size, size, size ) )
		InvItemIcon:SetLookAt( ( mn + mx ) * 0.5 )
		function InvItemIcon:LayoutEntity( Entity ) return end

		if( BRICKSCRAFTING.CONFIG.Tools.Pickaxe[(MiscTable.PickaxeLevel or 0)] ) then
			InvItemIcon:SetColor( BRICKSCRAFTING.CONFIG.Tools.Pickaxe[(MiscTable.PickaxeLevel or 0)].Color or Color( 255, 255, 255 ) )
		end
		
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
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickUpgrade"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

			if( BRICKSCRAFTING.CONFIG.Tools.Pickaxe[(MiscTable.PickaxeLevel or 0)+1] ) then
				if( BRICKSCRAFTING.LUACONFIG.DarkRP and BRICKSCRAFTING.CONFIG.Tools.Pickaxe[(MiscTable.PickaxeLevel or 0)+1].Cost ) then
					draw.SimpleText( DarkRP.formatMoney( BRICKSCRAFTING.CONFIG.Tools.Pickaxe[(MiscTable.PickaxeLevel or 0)+1].Cost ), "BCS_Roboto_18", w/2, h-(h/4)-10, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				else
					draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickFree"), "BCS_Roboto_18", w/2, h-(h/4)-10, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
			else
				draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickMax"), "BCS_Roboto_18", w/2, h-(h/4)-10, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
		end
		ItemCraftButton.DoClick = function()
			if( BRICKSCRAFTING.CONFIG.Tools.Pickaxe[(MiscTable.PickaxeLevel or 0)+1] ) then
				net.Start( "BCS_Net_UpgradePickaxe" )
				net.SendToServer()
			else
				notification.AddLegacy( BRICKSCRAFTING.L("vguiNPCToolsPickAlreadyMax"), 1, 3 )
			end
		end

		if( BRICKSCRAFTING.CONFIG.Tools.Pickaxe[(MiscTable.PickaxeLevel or 0)+1] and (BRICKSCRAFTING.CONFIG.Tools.Pickaxe[(MiscTable.PickaxeLevel or 0)+1].Skill or 0) > LocalPlayer():GetBCS_SkillLevel( "Mining" ) ) then
			local ItemEntryCover = vgui.Create( "DPanel", ItemEntry )
			ItemEntryCover:SetPos( 0, 0 )
			ItemEntryCover:SetSize( ((900/1920)*ScrW())-94-35-37-13, ItemEntry:GetTall() )
			ItemEntryCover.Paint = function( self2, w, h )
				surface.SetDrawColor( 0, 0, 0, 200 )
				surface.DrawRect( 0, 0, w, h )
				
				draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickReqSkill") .. " " .. (BRICKSCRAFTING.CONFIG.Tools.Pickaxe[(MiscTable.PickaxeLevel or 0)+1].Skill or 0), "DermaLarge", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
		end

		-- Lumber Axe --
		local SkillProgress = vgui.Create( "DPanel", PickaxePage )
		SkillProgress:Dock( TOP )
		SkillProgress:DockMargin( 0, 10, 37, 0 )
		SkillProgress:SetTall( 30 )
		local SkillLevel = 0
		SkillProgress.Paint = function( self2, w, h )
			local SkillLevel = LocalPlayer():GetBCS_SkillLevel( "Wood Cutting" )
		
			surface.SetDrawColor( 0, 128, 181, 100 )
			surface.DrawRect( 0, 0, w, h )		
			
			surface.SetDrawColor( 0, 128, 181 )
			surface.DrawRect( 0, 0, math.Clamp( w*(SkillLevel/BRICKSCRAFTING.CONFIG.Tools.MaxLumberAxeSkill), 0, w ), h )
			
			draw.SimpleText( BRICKSCRAFTING.L("woodCutting"), "BCS_Roboto_18", 15, h/2, Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
			draw.SimpleText( SkillLevel .. "/" .. BRICKSCRAFTING.CONFIG.Tools.MaxLumberAxeSkill, "BCS_Roboto_18", w-15, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
		end

		local ItemEntry = vgui.Create( "DPanel", PickaxePage )
		ItemEntry:Dock( TOP )
		ItemEntry:DockMargin( 0, 10, 37, 0 )
		ItemEntry:SetTall( 125 )
		ItemEntry.Paint = function( self2, w, h )
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 2, false )

			draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsAxeLevel") .. " " .. (MiscTable.LumberAxeLevel or 0), "Trebuchet24", h+20, 24, Color( 255, 255, 255 ), 0, 0 )
			draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsAxeDes"), "BCS_Roboto_16", h+20, 52, Color( 255, 255, 255 ), 0, 0 )
			draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickCurLevel") .. " " .. ((BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)] or {}).Increase or 0) .. "%", "BCS_Roboto_16", h+20, 73, Color( 255, 255, 255 ), 0, 0 )
			if( BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)+1] ) then
				draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickNextLevel") .. " " .. (BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)+1].Increase or 0) .. "%", "BCS_Roboto_16", h+20, 94, Color( 255, 255, 255 ), 0, 0 )
			end
		end

		local InvItemIcon = vgui.Create( "DModelPanel", ItemEntry )
		InvItemIcon:Dock( LEFT )
		InvItemIcon:SetWide( ItemEntry:GetTall() )
		InvItemIcon:SetModel( BRICKSCRAFTING.LUACONFIG.Defaults.LumberAxeModel )	
		local mn, mx = InvItemIcon.Entity:GetRenderBounds()
		local size = 0
		size = math.max( size, math.abs( mn.x ) + math.abs( mx.x ) )
		size = math.max( size, math.abs( mn.y ) + math.abs( mx.y ) )
		size = math.max( size, math.abs( mn.z ) + math.abs( mx.z ) )

		InvItemIcon:SetFOV( 45 )
		InvItemIcon:SetCamPos( Vector( size, size, size ) )
		InvItemIcon:SetLookAt( ( mn + mx ) * 0.5 )
		function InvItemIcon:LayoutEntity( Entity ) return end

		if( BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)] ) then
			InvItemIcon:SetColor( BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)].Color or Color( 255, 255, 255 ) )
		end
		
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
			
			draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickUpgrade"), "BCS_Roboto_22", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )

			if( BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)+1] ) then
				if( BRICKSCRAFTING.LUACONFIG.DarkRP and BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)+1].Cost ) then
					draw.SimpleText( DarkRP.formatMoney( BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)+1].Cost ), "BCS_Roboto_18", w/2, h-(h/4)-10, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				else
					draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickFree"), "BCS_Roboto_18", w/2, h-(h/4)-10, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
				end
			else
				draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickMax"), "BCS_Roboto_18", w/2, h-(h/4)-10, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
		end
		ItemCraftButton.DoClick = function()
			if( BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)+1] ) then
				net.Start( "BCS_Net_UpgradeLumberAxe" )
				net.SendToServer()
			else
				notification.AddLegacy( BRICKSCRAFTING.L("vguiNPCToolsAxeAlreadyMax"), 1, 3 )
			end
		end

		if( BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)+1] and (BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)+1].Skill or 0) > LocalPlayer():GetBCS_SkillLevel( "Wood Cutting" ) ) then
			local ItemEntryCover = vgui.Create( "DPanel", ItemEntry )
			ItemEntryCover:SetPos( 0, 0 )
			ItemEntryCover:SetSize( ((900/1920)*ScrW())-94-35-37-13, ItemEntry:GetTall() )
			ItemEntryCover.Paint = function( self2, w, h )
				surface.SetDrawColor( 0, 0, 0, 200 )
				surface.DrawRect( 0, 0, w, h )
				
				draw.SimpleText( BRICKSCRAFTING.L("vguiNPCToolsPickReqSkill") .. " " .. (BRICKSCRAFTING.CONFIG.Tools.LumberAxe[(MiscTable.LumberAxeLevel or 0)+1].Skill or 0), "DermaLarge", w/2, h/2, Color( 255, 255, 255 ), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
			end
		end
	end

	self:RefreshPickaxe()
end

function PANEL:Paint( w, h )
end

vgui.Register( "brickscrafting_vgui_npc_tools", PANEL, "DPanel" )