-- "addons\\rised_notifications\\lua\\autorun\\client\\cl_notifications.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
surface.CreateFont( "ModernNotification", {
	font = "Marske",
	extended = true,
	size = 10,
} )

local ScreenPos = ScrH() - 200

local ForegroundColor = Color( 255, 195, 87, 255 )
local ForegroundColorText = Color( 255, 195, 87, 255)
local BackgroundColor = Color( 255, 0, 0, 0 )

local Colors = {}
Colors[ NOTIFY_GENERIC ] = Color( 52, 73, 94, 0  )
Colors[ NOTIFY_ERROR ] = Color( 192, 57, 43, 0 )
Colors[ NOTIFY_UNDO ] = Color( 41, 128, 185, 0  )
Colors[ NOTIFY_HINT ] = Color( 39, 174, 96 , 0 )
Colors[ NOTIFY_CLEANUP ] = Color( 243, 156, 18, 0  )

local LoadingColor = Color( 22, 160, 133 )

local Icons = {}
Icons[ NOTIFY_GENERIC ] = Material( "notifications/generic.png" )
Icons[ NOTIFY_ERROR ] = Material( "notifications/error.png" )
Icons[ NOTIFY_UNDO ] = Material( "notifications/undo.png" )
Icons[ NOTIFY_HINT ] = Material( "notifications/hint.png" )
Icons[ NOTIFY_CLEANUP ] = Material( "notifications/cleanup.png" )

local LoadingIcon = Material( "notifications/loading.png" )

local BackgroundImage = Material( "notifications_bg.png" )

local Notifications = {}

local main_colors = Color(255, 255, 255, 255)

local function DrawNotification( x, y, w, h, text, icon, col, progress )

	main_colors = GetFractionColor(LocalPlayer():Team())

	surface.SetDrawColor( main_colors )
	surface.SetMaterial( BackgroundImage )

	if progress then
		surface.DrawTexturedRectRotated( x + 16, y + h / 2, 16, 16, -CurTime() * 360 % 360 )
	else
		surface.DrawTexturedRect( x - 350, y - 1, 400, 55 )
	end

	if !col then
		col = Color(125,125,125)
	end
	
	draw.RoundedBoxEx( 4, x, y, h, h, col, true, false, true, false )
	draw.RoundedBoxEx( 4, x + h, y, w - h, h, BackgroundColor, false, true, false, true )

	draw.SimpleText( text, "ModernNotification", x - 5, y + h / 2, main_colors,
		TEXT_ALIGN_RIGHT, TEXT_ALIGN_RIGHT )
end

function notification.AddLegacy( text, type, time )
	surface.SetFont( "ModernNotification" )

	local w = surface.GetTextSize( text ) + 20 + 32
	local h = 42
	local x = ScrW()
	local y = ScreenPos

	table.insert( Notifications, 1, {
		x = x,
		y = y,
		w = w,
		h = h,

		text = text,
		col = Colors[ type ],
		icon = Icons[ type ],
		time = CurTime() + time,

		progress = false,
	} )
end

function notification.AddProgress( id, text )
	surface.SetFont( "ModernNotification" )

	local w = surface.GetTextSize( text ) + 20 + 32
	local h = 32
	local x = ScrW()
	local y = ScreenPos

	table.insert( Notifications, 1, {
		x = x,
		y = y,
		w = w,
		h = h,

		id = id,
		text = text,
		col = LoadingColor,
		icon = LoadingIcon,
		time = math.huge,

		progress = true,
	} )	
end

local PANEL = {}

function PANEL:Init()

	self:DockPadding( 3, 3, 3, 3 )

	self.Image = vgui.Create("DImage", self)
	self.Image:SetPos(0, 0)
	self.Image:Dock(FILL)
	self.Image:SetImage("hlmv/background")

	self.Label = vgui.Create( "DLabel", self )
	self.Label:Dock( FILL )
	self.Label:SetFont( "GModNotify" )
	self.Label:SetTextColor( Color( 255, 255, 255, 255 ) )
	self.Label:SetExpensiveShadow( 1, Color( 0, 0, 0, 200 ) )
	self.Label:SetContentAlignment( 5 )

	self:SetBackgroundColor( Color( 20, 20, 20, 0 ) )

end

function notification.Kill( id )
	for k, v in ipairs( Notifications ) do
		if v.id == id then v.time = 0 end
	end
end

hook.Add( "HUDPaint", "DrawNotifications", function()
	for k, v in ipairs( Notifications ) do
		DrawNotification( math.floor( v.x ), math.floor( v.y ), v.w, v.h, v.text, v.icon, v.col, v.progress )
		v.x = Lerp( FrameTime() * 10, v.x, v.time > CurTime() and ScrW() - 10 or ScrW() + 50 )
		v.y = Lerp( FrameTime() * 10, v.y, ScreenPos - ( k - 1 ) * ( v.h + 5 ) )
	end

	for k, v in ipairs( Notifications ) do
		if v.x >= ScrW() and v.time < CurTime() then
			table.remove( Notifications, k )
		end
	end
end )
