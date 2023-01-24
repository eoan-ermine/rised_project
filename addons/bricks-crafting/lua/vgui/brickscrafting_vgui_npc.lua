-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_vgui_npc.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local PANEL = {}

function PANEL:Init()
	self:SetSize( ScrW(), ScrH() )
	self:SetPos( 0, 0 )
	self:MakePopup()
	self:SetTitle( "" )
	self:ShowCloseButton( false )
	self:SetDraggable( false )

	--[[ INVENTORY ]]--
	self.MenuBack = vgui.Create( "DPanel", self )
	local HeaderH = 50
	self.MenuBack:SetSize( (900/1920)*ScrW(), (710/1080)*ScrH()+HeaderH )
	self.MenuBack:SetPos( -self.MenuBack:GetWide(), (ScrH()/2)-(self.MenuBack:GetTall()/2) )
	self.MenuBack:MoveTo( (ScrW()/2)-(self.MenuBack:GetWide()/2), (ScrH()/2)-(self.MenuBack:GetTall()/2), 0.25, 0, 1 )
	local HeaderPoly = {
		{ x = 0, y = 0 },
		{ x = 220, y = 0 },
		{ x = 220+50, y = HeaderH },
		{ x = 0, y = HeaderH }
	}
	local BackpackMat = BCS_DRAWING.GetMaterial( "IconCrafting" )
	self.MenuBack.Paint = function( self2, w, h )
		surface.SetDrawColor( 24, 25, 34 )
		surface.DrawRect( 0, HeaderH, w, h-HeaderH )

		-- Header
		surface.SetDrawColor( 24, 25, 34 )
		draw.NoTexture()
		surface.DrawPoly( HeaderPoly )

		if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 10, 10 )
			surface.DrawRect( x, y, 50, 50 )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 5, false )
		else
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 10, 10, 50, 50 )
		end

		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( BackpackMat )
		local Spacing = 10
		surface.DrawTexturedRect( 10+Spacing, 10+Spacing, 50-(2*Spacing), 50-(2*Spacing) )

		draw.SimpleText( BRICKSCRAFTING.L("vguiNPCHeader"), "BCS_Roboto_40", 10+50+20, 10+(50/2), Color( 255, 255, 255 ), 0, TEXT_ALIGN_CENTER )
	end

	--[[ Close Button ]]--
	local CloseButton = vgui.Create( "DButton", self.MenuBack )
	CloseButton:SetSize( 32, 32 )
	CloseButton:SetPos( self.MenuBack:GetWide()-17-CloseButton:GetWide(), HeaderH+13 )
	CloseButton:SetText( "" )
	local CloseMat = BCS_DRAWING.GetMaterial( "IconCross" )
	local Alpha = 0
	CloseButton.Paint = function( self2, w, h )
		if( self2:IsHovered() and !self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+5, 0, 100 )
		elseif( self2:IsDown() ) then
			Alpha = math.Clamp( Alpha+10, 0, 200 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 100 )
		end
		
		if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
			BCS_BSHADOWS.BeginShadow()
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( x, y, w, h )			
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, w, 5, false )
		else
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 0, 0, w, h )
		end

		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( 0, 0, w, h )

		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( CloseMat )
		local Spacing = 10
		surface.DrawTexturedRect( Spacing, Spacing, w-(2*Spacing), h-(2*Spacing) )
	end
	CloseButton.DoClick = function()
		self:SetKeyboardInputEnabled( false )
		self:SetMouseInputEnabled( false )
		self.MenuBack:MoveTo( -self.MenuBack:GetWide(), (ScrH()/2)-(self.MenuBack:GetTall()/2), 0.25, 0, 1, function() 
			self:Remove()
		end )
	end

	--[[ SEARCH BAR ]]--
	local SearchBarBack = vgui.Create( "DPanel", self.MenuBack )
	SearchBarBack:Dock( TOP )
	SearchBarBack:SetTall( 50 )
	SearchBarBack:DockMargin( 94, 105, self.MenuBack:GetWide()*0.4, 0 )
	local search = BCS_DRAWING.GetMaterial( "IconSearch" )
	local Alpha = 0
	local Alpha2 = 20
	SearchBarBack.Paint = function( self2, w, h )
		if( not BRICKSCRAFTING.LUACONFIG.DisableShadows ) then
			BCS_BSHADOWS.BeginShadow()
			surface.SetDrawColor( 30, 30, 44 )
			local x, y = self2:LocalToScreen( 0, 0 )
			surface.DrawRect( x, y, w, h )
			BCS_BSHADOWS.EndShadow(1, 1, 1, 255, 50, 5, false )
		else
			surface.SetDrawColor( 30, 30, 44 )
			surface.DrawRect( 0, 0, w, h )
		end

		if( self.SearchBar:IsEditing() ) then
			Alpha = math.Clamp( Alpha+5, 0, 100 )
			Alpha2 = math.Clamp( Alpha2+20, 20, 255 )
		else
			Alpha = math.Clamp( Alpha-5, 0, 100 )
			Alpha2 = math.Clamp( Alpha2-20, 20, 255 )
		end
		surface.SetDrawColor( 20, 20, 30, Alpha )
		surface.DrawRect( 0, 0, w, h )
	
		surface.SetDrawColor( 255, 255, 255, Alpha2 )
		surface.SetMaterial(search)
		local size = h*0.35
		surface.DrawTexturedRect( w-size-(h-size)/2, (h-size)/2, size, size )
	end

	self.SearchBar = vgui.Create( "brickscrafting_search", SearchBarBack )
	self.SearchBar:Dock( FILL )

	--[[ Pages ]]--
	local sheet = vgui.Create( "brickscrafting_vgui_colsheet", self.MenuBack )
	sheet:Dock( FILL )
	sheet:DockMargin( 0, 20, 0, 0 )

	-- Pages --
	local Pages = {
		[1] = {
			name = "Quests",
			element = "brickscrafting_vgui_npc_quests",
			icon = BCS_DRAWING.GetMaterial( "IconQuest" )
		},
		[2] = {
			name = "Training",
			element = "brickscrafting_vgui_npc_training",
			icon = BCS_DRAWING.GetMaterial( "IconTraining" )
		},
		[3] = {
			name = "Tools",
			element = "brickscrafting_vgui_npc_tools",
			icon = BCS_DRAWING.GetMaterial( "IconTools" )
		}
	}

	for k, v in pairs( BRICKSCRAFTING.CONFIG.Resources ) do
		if( v.Price ) then 
			Pages[4] = {
				name = "Shop",
				element = "brickscrafting_vgui_npc_shop",
				icon = BCS_DRAWING.GetMaterial( "IconShop" )
			}
			break
		end
	end

	self.CreatedPages = {}

	for i = 1, #Pages do
		local v = Pages[i]
		self.CreatedPages[v.name] = vgui.Create( v.element, sheet )
		self.CreatedPages[v.name]:Dock( FILL )
		self.CreatedPages[v.name]:DockMargin( 0, 10, 35, 65 )
		if( self.CreatedPages[v.name].SetSearchBar ) then
			self.CreatedPages[v.name]:SetSearchBar( self.SearchBar )
		end
		self.CreatedPages[v.name].Paint = function( self, w, h ) 
		end

		sheet:AddSheet( self.CreatedPages[v.name], v.icon )
	end
end

function PANEL:Paint( w, h )
end

vgui.Register( "brickscrafting_vgui_npc", PANEL, "DFrame" )