-- "addons\\darkrpmodification\\lua\\entities\\changename_notebook\\cl_init.lua"
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
	frame:SetSize(250,250)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "Смена имени и фамилии" )
	frame.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	
	local label = vgui.Create("DLabel", frame)
	label:SetSize(100, 100)
	label:SetPos(25,15)
	label:SetText("Введите имя:")
	
	local inputName = vgui.Create("DTextEntry", frame)
	inputName:SetPos( 25, 75 )
	inputName:SetSize( 200, 25 )
	inputName:SetText( "" )
	inputName.OnChange = function( self )
	rpname = self:GetValue()
	end
	
	local label2 = vgui.Create("DLabel", frame)
	label2:SetSize(100, 100)
	label2:SetPos(25,75)
	label2:SetText("Введите фамилию:")
	
	local inputSurame = vgui.Create("DTextEntry", frame)
	inputSurame:SetPos( 25, 135 )
	inputSurame:SetSize( 200, 25 )
	inputSurame:SetText( "" )
	inputSurame.OnChange = function( self )
	rpsurname = self:GetValue()
	end

	local button = vgui.Create("DButton", frame)
	button:SetPos(75,210)
	button:SetSize(100,25)
	button:SetText("")
	button:SetTextStyleColor( Color( 0, 0, 0 ) )
	button.Hover 	= false
	button.OnCursorEntered	= function() button.Hover = true  end
	button.OnCursorExited 	= function() button.Hover = false end
	button.DoClick = function()
			if rpname != nil && rpsurname != nil then
				net.Start("ButtonChangeRPNamePressed")
				net.WriteEntity(LocalPlayer())
				net.WriteString(rpname.." "..rpsurname)
				net.SendToServer()
			else return false end
		end
	button.Paint = function(s,w,h)
		if button.Hover == true then
			draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
			draw.DrawText( "Установить", "Trebuchet18", w/2, 2, Color( 128, 255, 170, 255 ), 1 )	
		else
			draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
			draw.DrawText( "Установить", "Trebuchet18", w/2, 2, Color( 255, 255, 255, 255 ), 1 )
		end
	end
end

net.Receive( "ButtonToChangeRPNamePressed", function()
	Derma() 	
end )

usermessage.Hook("DrawTheMenu", Derma)

function ENT:Initialize()	

end;

function ENT:Draw()
	self:DrawModel();
	
	local pos = self:GetPos()
	local ang = self:GetAngles()

	local waterColor = Color(128, 255, 170, 255);
	
	ang:RotateAroundAxis(ang:Up(), 90);
	ang:RotateAroundAxis(ang:Forward(), 360);	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < self:GetNWInt("distance") then
		cam.Start3D2D(pos+ang:Up()*0.7, ang, 0.06)
			draw.SimpleTextOutlined("Смена", "methFont", 0, -65, waterColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255));
			draw.SimpleTextOutlined("РП", "methFont", 0, -42, waterColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255));
			draw.SimpleTextOutlined("имени", "methFont", 0, -25, waterColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255));
		cam.End3D2D();

	ang:RotateAroundAxis(ang:Up(), 0);
	ang:RotateAroundAxis(ang:Forward(), -90);
	ang:RotateAroundAxis(ang:Right(), 90);
	end;
end;