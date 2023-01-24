-- "addons\\darkrpmodification\\lua\\entities\\combine_idcardsystemcore\\cl_init.lua"
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

function ENT:Initialize()	

end;

local HackTimer = "Взломать"

local function Derma()
    local frame = vgui.Create("DFrame")
	frame:SetSize(250,100)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "Взлом системы ID карт" )
	frame.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end

	local button = vgui.Create("DButton", frame)
	button:SetPos(75,45)
	button:SetSize(100,25)
	button:SetText("")
	button:SetTextStyleColor( Color( 0, 0, 0 ) )
	button.Hover 	= false
	button.OnCursorEntered	= function() button.Hover = true  end
	button.OnCursorExited 	= function() button.Hover = false end
	button.DoClick = function()
			net.Start("HackIDCardSystem")
			net.SendToServer()
		end
	button.Paint = function(s,w,h)
		if button.Hover == true then
			draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
			if ply:isCP() then
				draw.DrawText( "Починить", "Trebuchet18", w/2, 3, Color( 128, 255, 170, 255 ), 1 )
			else
				draw.DrawText( "Взломать", "Trebuchet18", w/2, 3, Color( 128, 255, 170, 255 ), 1 )
			end
		else
			draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
			if ply:isCP() then
				draw.DrawText( "Починить", "Trebuchet18", w/2, 3, Color( 255, 255, 255, 255 ), 1 )
			else
				draw.DrawText( "Взломать", "Trebuchet18", w/2, 3, Color( 255, 255, 255, 255 ), 1 )
			end
		end
	end
end

net.Receive( "ButtonIDCardSystemPressed", function()
	Derma() 	
end )

function ENT:Draw()
	self:DrawModel();
	
	local pos = self:GetPos()
	local ang = self:GetAngles()

	
	ang:RotateAroundAxis(ang:Up(), 90);
	ang:RotateAroundAxis(ang:Forward(), 90);	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < self:GetNWInt("distance") then	
		cam.Start3D2D(pos + ang:Up(), Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.1)
				draw.SimpleTextOutlined("Система идентификации ID карт", "methFont", 8, -550, Color(1, 241, 249, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25, 100));
		cam.End3D2D();
	end;
end;

