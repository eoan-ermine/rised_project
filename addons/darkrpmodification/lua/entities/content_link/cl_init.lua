-- "addons\\darkrpmodification\\lua\\entities\\content_link\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua");

surface.CreateFont("methFont", {
	font = "Arial",
	size = 30,
	weight = 600,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
});

local rpname
local rpsurname

local function Derma()
    local frame = vgui.Create("DFrame")
	frame:SetSize(500,75)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "Хочешь узнать всё о сервере, заходи на wiki:" )
	frame.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	local button = vgui.Create("DButton", frame)
	button:SetPos(175,35)
	button:SetSize(150,25)
	button:SetText("")
	button:SetTextStyleColor( Color( 0, 0, 0 ) )
	button.Hover 	= false
	button.OnCursorEntered	= function() button.Hover = true  end
	button.OnCursorExited 	= function() button.Hover = false end
	button.DoClick = function()
		gui.OpenURL( "https://wiki.risedproject.com/ru/rules" )
	end
	button.Paint = function(s,w,h)
		if button.Hover == true then
			draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
			draw.DrawText( "Открыть", "Trebuchet18", w/2, 2, Color( 128, 255, 170, 255 ), 1 )	
		else
			draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
			draw.DrawText( "Открыть", "Trebuchet18", w/2, 2, Color( 255, 255, 255, 255 ), 1 )
		end
	end
end

net.Receive( "ButtonContentPressed", function()
	Derma() 	
end )

usermessage.Hook("DrawTheMenu", Derma)