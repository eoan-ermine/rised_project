-- "addons\\bricks-crafting\\lua\\vgui\\brickscrafting_scrollbar.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[

	DVScrollBar

	Usage:

	Place this control in your panel. You will ideally have another panel or
		control which is bigger than the original panel. This is the Canvas.

	scrollbar:SetUp( _barsize_, _canvassize_ ) should be called whenever
		the size of your 'canvas' changes.

	scrollbar:GetOffset() can be called to get the offset of the canvas.
		You should call this in your PerformLayout function and set the Y
		pos of your canvas to this value.

	Example:

	function PANEL:PerformLayout()

		local Wide = self:GetWide()
		local YPos = 0

		-- Place the scrollbar
		self.VBar:SetPos( self:GetWide() - 16, 0 )
		self.VBar:SetSize( 16, self:GetTall() )

		-- Make sure the scrollbar knows how big our canvas is
		self.VBar:SetUp( self:GetTall(), self.pnlCanvas:GetTall() )

		-- Get data from the scrollbar
		YPos = self.VBar:GetOffset()

		-- If the scrollbar is enabled make the canvas thinner so it will fit in.
		if ( self.VBar.Enabled ) then Wide = Wide - 16 end

		-- Position the canvas according to the scrollbar's data
		self.pnlCanvas:SetPos( self.Padding, YPos + self.Padding )
		self.pnlCanvas:SetSize( Wide - self.Padding * 2, self.pnlCanvas:GetTall() )

	end

--]]

local PANEL = {}

AccessorFunc( PANEL, "m_HideButtons", "HideButtons" )

function PANEL:Init()

	self.Offset = 0
	self.Scroll = 0
	self.CanvasSize = 1
	self.BarSize = 1

	self.btnUp = vgui.Create( "DButton", self )
	self.btnUp:SetText( "" )
	self.btnUp.DoClick = function( self ) self:GetParent():AddScroll( -1 ) end
	self.btnUp.Paint = function( panel, w, h ) 
		local TopBut = {
			{ x = w/2, y = 0 },
			{ x = w, y = h },
			{ x = 0, y = h },
		}

		surface.SetDrawColor( 255, 255, 255 )
		if( panel:IsHovered() ) then
			surface.SetDrawColor( 200, 200, 200, 255 )
		end
		draw.NoTexture()
		surface.DrawPoly( TopBut )
	end

	self.btnDown = vgui.Create( "DButton", self )
	self.btnDown:SetText( "" )
	self.btnDown.DoClick = function( self ) self:GetParent():AddScroll( 1 ) end
	self.btnDown.Paint = function( panel, w, h ) 
		local BottomBut = {
			{ x = 0, y = 0 },
			{ x = w, y = 0 },
			{ x = w/2, y = h },
		}

		surface.SetDrawColor( 255, 255, 255 )
		if( panel:IsHovered() ) then
			surface.SetDrawColor( 200, 200, 200, 255 )
		end
		draw.NoTexture()
		surface.DrawPoly( BottomBut )
	end

	function draw.Circle( x, y, radius, seg )
		local cir = {}
	
		table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
		for i = 0, seg do
			local a = math.rad( ( i / seg ) * -360 )
			table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
		end
	
		local a = math.rad( 0 ) -- This is needed for non absolute segment counts
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	
		surface.DrawPoly( cir )
	end

	self.btnGrip = vgui.Create( "DScrollBarGrip", self )
	self.btnGrip.Paint = function( panel, w, h ) 
		surface.SetDrawColor( 255, 255, 255, 255 )
		if( panel:IsHovered() ) then
			surface.SetDrawColor( 200, 200, 200, 255 )
		end
		draw.NoTexture()
		draw.Circle( w/2, h/2, w/2, 55 )
	end

	self:SetSize( 13, 15 )
	self:SetHideButtons( false )

end

function PANEL:SetEnabled( b )

	if ( !b ) then

		self.Offset = 0
		self:SetScroll( 0 )
		self.HasChanged = true

	end

	self:SetMouseInputEnabled( b )
	self:SetVisible( b )

	-- We're probably changing the width of something in our parent
	-- by appearing or hiding, so tell them to re-do their layout.
	if ( self.Enabled != b ) then

		self:GetParent():InvalidateLayout()

		if ( self:GetParent().OnScrollbarAppear ) then
			self:GetParent():OnScrollbarAppear()
		end

	end

	self.Enabled = b

end

function PANEL:Value()

	return self.Pos

end

function PANEL:BarScale()

	if ( self.BarSize == 0 ) then return 1 end

	return self.BarSize / ( self.CanvasSize + self.BarSize )

end

function PANEL:SetUp( _barsize_, _canvassize_ )

	self.BarSize = _barsize_
	self.CanvasSize = math.max( _canvassize_ - _barsize_, 1 )

	self:SetEnabled( true )

	self:InvalidateLayout()

end

function PANEL:OnMouseWheeled( dlta )

	if ( !self:IsVisible() ) then return false end

	-- We return true if the scrollbar changed.
	-- If it didn't, we feed the mousehweeling to the parent panel

	return self:AddScroll( dlta * -2 )

end

function PANEL:AddScroll( dlta )

	local OldScroll = self:GetScroll()

	dlta = dlta * 25
	self:SetScroll( self:GetScroll() + dlta )
	--self:AnimateTo( self:GetScroll() + dlta, 0.025, 0, 1 )

	return OldScroll != self:GetScroll()

end

function PANEL:SetScroll( scrll )

	if ( !self.Enabled ) then self.Scroll = 0 return end

	self.Scroll = math.Clamp( scrll, 0, self.CanvasSize )

	self:InvalidateLayout()

	-- If our parent has a OnVScroll function use that, if
	-- not then invalidate layout (which can be pretty slow)

	local func = self:GetParent().OnVScroll
	if ( func ) then

		func( self:GetParent(), self:GetOffset() )

	else

		self:GetParent():InvalidateLayout()

	end

end

function PANEL:AnimateTo( scrll, length, delay, ease )

	local anim = self:NewAnimation( length, delay, ease )
	anim.StartPos = self.Scroll
	anim.TargetPos = scrll
	anim.Think = function( anim, pnl, fraction )

		pnl:SetScroll( Lerp( fraction, anim.StartPos, anim.TargetPos ) )

	end

end

function PANEL:GetScroll()

	if ( !self.Enabled ) then self.Scroll = 0 end
	return self.Scroll

end

function PANEL:GetOffset()

	if ( !self.Enabled ) then return 0 end
	return self.Scroll * -1

end

function PANEL:Think()
end

function PANEL:Paint( w, h )
	surface.SetDrawColor( 30, 30, 44 )
	surface.DrawRect( 0, 9, w, h-18 )
end

function PANEL:OnMousePressed()

	local x, y = self:CursorPos()

	local PageSize = self.BarSize

	if ( y > self.btnGrip.y ) then
		self:SetScroll( self:GetScroll() + PageSize )
	else
		self:SetScroll( self:GetScroll() - PageSize )
	end

end

function PANEL:OnMouseReleased()

	self.Dragging = false
	self.DraggingCanvas = nil
	self:MouseCapture( false )

	self.btnGrip.Depressed = false

end

function PANEL:OnCursorMoved( x, y )

	if ( !self.Enabled ) then return end
	if ( !self.Dragging ) then return end

	local x, y = self:ScreenToLocal( 0, gui.MouseY() )

	-- Uck.
	y = y - self.btnUp:GetTall()
	y = y - self.HoldPos

	local BtnHeight = self:GetWide()
	if ( self:GetHideButtons() ) then BtnHeight = 0 end

	local TrackSize = self:GetTall() - BtnHeight * 2 - self.btnGrip:GetTall()

	y = y / TrackSize

	self:SetScroll( y * self.CanvasSize )

end

function PANEL:Grip()

	if ( !self.Enabled ) then return end
	if ( self.BarSize == 0 ) then return end

	self:MouseCapture( true )
	self.Dragging = true

	local x, y = self.btnGrip:ScreenToLocal( 0, gui.MouseY() )
	self.HoldPos = y

	self.btnGrip.Depressed = true

end

function PANEL:PerformLayout()

	local Wide = self:GetWide()
	local BtnHeight = 9
	if ( self:GetHideButtons() ) then BtnHeight = 0 end
	local Scroll = self:GetScroll() / self.CanvasSize
	local BarSize = Wide
	local HPadding = 2
	local Track = self:GetTall() - ( BtnHeight * 2 ) - BarSize - (2*HPadding)
	Track = Track + 1

	Scroll = Scroll * Track

	--self.btnGrip:MoveTo( 0, HPadding+BtnHeight + Scroll, 0.25, 0, 1 )
	self.btnGrip:SetPos( 0, HPadding+BtnHeight + Scroll )
	self.btnGrip:SetSize( Wide, BarSize )

	if ( BtnHeight > 0 ) then
		self.btnUp:SetPos( 0, 0, Wide, Wide )
		self.btnUp:SetSize( Wide, BtnHeight )

		self.btnDown:SetPos( 0, self:GetTall() - BtnHeight )
		self.btnDown:SetSize( Wide, BtnHeight )
		
		self.btnUp:SetVisible( true )
		self.btnDown:SetVisible( true )
	else
		self.btnUp:SetVisible( false )
		self.btnDown:SetVisible( false )
		self.btnDown:SetSize( Wide, BtnHeight )
		self.btnUp:SetSize( Wide, BtnHeight )
	end

end

derma.DefineControl( "brickscrafting_scrollbar", "A Scrollbar", PANEL, "Panel" )
