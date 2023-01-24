-- "addons\\rised_combine_entities\\lua\\entities\\combine_armory\\cl_init.lua"
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

local PistolTimer = "Пистолеты"
local ShotgunTimer = "Дробовики"
local SMGTimer = "MP7"
local AR2Timer = "Магнум"
local AmmoTimer = "Патроны"

local function Derma()
	local ply = LocalPlayer()

    local frame = vgui.Create("DFrame")
	frame:SetSize(250,250)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "Выбор оружия" )
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
			if ply:Team() == TEAM_MPCURATOR || ply:Team() == TEAM_OFFICER || ply:Team() == TEAM_RAZORLEADER || ply:Team() == TEAM_RECOMMANDER || ply:Team() == TEAM_COMMANDER || ply:Team() == TEAM_REBELSPY02 || ply:Team() == TEAM_REBELSPY01 then
				net.Start("ButtonSpawnPistolCratePressed")
				net.WriteEntity(LocalPlayer())
				net.SendToServer()
			else return false end
		end
	button.Paint = function(s,w,h)
		if button.Hover == true then
			net.Receive("ArmoryTimer01", function(len, ply)
			PistolTimer = net.ReadString()
			if PistolTimer == "0" then PistolTimer = "Пистолеты" end
			end)
			draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
			draw.DrawText( PistolTimer, "Trebuchet18", w/2, 3, Color( 128, 255, 170, 255 ), 1 )		
		else
			draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
			draw.DrawText( "Пистолеты", "Trebuchet18", w/2, 3, Color( 255, 255, 255, 255 ), 1 )
		end
	end
	
	local button2 = vgui.Create("DButton", frame)
	button2:SetPos(75,85)
	button2:SetSize(100,25)
	button2:SetText("")
	button2:SetTextStyleColor( Color( 0, 0, 0 ) )
	button2.Hover 	= false
	button2.OnCursorEntered	= function() button2.Hover = true  end
	button2.OnCursorExited 	= function() button2.Hover = false end
	button2.DoClick = function()
			if ply:Team() == TEAM_OFFICER || ply:Team() == TEAM_RAZORLEADER || ply:Team() == TEAM_RECOMMANDER || ply:Team() == TEAM_COMMANDER || ply:Team() == TEAM_REBELSPY02 || ply:Team() == TEAM_REBELSPY01 then
				net.Start("ButtonSpawnShotgunCratePressed")
				net.WriteEntity(LocalPlayer())
				net.SendToServer()
			else return false end
		end
	button2.Paint = function(s,w,h)
		if button2.Hover == true then
			net.Receive("ArmoryTimer02", function(len, ply)
			ShotgunTimer = net.ReadString()
			if ShotgunTimer == "0" then ShotgunTimer = "Дробовики" end
			end)
			draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
			draw.DrawText( ShotgunTimer, "Trebuchet18", w/2, 3, Color( 128, 255, 170, 255 ), 1 )	
		else
			draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
			draw.DrawText( "Дробовики", "Trebuchet18", w/2, 3, Color( 255, 255, 255, 255 ), 1 )
		end
	end
	
	local button3 = vgui.Create("DButton", frame)
	button3:SetPos(75,125)
	button3:SetSize(100,25)
	button3:SetText("")
	button3:SetTextStyleColor( Color( 0, 0, 0 ) )
	button3.Hover 	= false
	button3.OnCursorEntered	= function() button3.Hover = true  end
	button3.OnCursorExited 	= function() button3.Hover = false end
	button3.DoClick = function()
			if ply:Team() == TEAM_OFFICER || ply:Team() == TEAM_RAZORLEADER || ply:Team() == TEAM_RECOMMANDER || ply:Team() == TEAM_COMMANDER || ply:Team() == TEAM_REBELSPY02 || ply:Team() == TEAM_REBELSPY01 then
				net.Start("ButtonSpawnSMGCratePressed")
				net.WriteEntity(LocalPlayer())
				net.SendToServer()
			else return false end
		end
	button3.Paint = function(s,w,h)
		if button3.Hover == true then
			net.Receive("ArmoryTimer03", function(len, ply)
			SMGTimer = net.ReadString()
			if SMGTimer == "0" then SMGTimer = "MP7" end
			end)
			draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
			draw.DrawText( SMGTimer, "Trebuchet18", w/2, 3, Color( 128, 255, 170, 255 ), 1 )	
		else
			draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
			draw.DrawText( "MP7", "Trebuchet18", w/2, 3, Color( 255, 255, 255, 255 ), 1 )
		end
	end
	
	local button4 = vgui.Create("DButton", frame)
	button4:SetPos(75,165)
	button4:SetSize(100,25)
	button4:SetText("")
	button4:SetTextStyleColor( Color( 0, 0, 0 ) )
	button4.Hover 	= false
	button4.OnCursorEntered	= function() button4.Hover = true  end
	button4.OnCursorExited 	= function() button4.Hover = false end
	button4.DoClick = function()
			if ply:Team() == TEAM_RAZORLEADER || ply:Team() == TEAM_RECOMMANDER || ply:Team() == TEAM_COMMANDER || ply:Team() == TEAM_REBELSPY02 || ply:Team() == TEAM_REBELSPY01 then
				net.Start("ButtonSpawnAR2CratePressed")
				net.WriteEntity(LocalPlayer())
				net.SendToServer()
			else return false end
		end
	button4.Paint = function(s,w,h)
		if button4.Hover == true then
			net.Receive("ArmoryTimer04", function(len, ply)
			AR2Timer = net.ReadString()
			if AR2Timer == "0" then AR2Timer = "Магнум" end
			end)
			draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
			draw.DrawText( AR2Timer, "Trebuchet18", w/2, 3, Color( 128, 255, 170, 255 ), 1 )	
		else
			draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
			draw.DrawText( "Магнум", "Trebuchet18", w/2, 3, Color( 255, 255, 255, 255 ), 1 )
		end
	end
end

net.Receive( "ButtonArmoryPressed", function()
	Derma() 	
end)

function ENT:Draw()
	self:DrawModel();
	
	local pos = self:GetPos()
	local ang = self:GetAngles()

	
	ang:RotateAroundAxis(ang:Up(), 90);
	ang:RotateAroundAxis(ang:Forward(), 90);	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < self:GetNWInt("distance") then	
		cam.Start3D2D(pos + ang:Up(), Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.1)
				draw.SimpleTextOutlined("Снабжение", "methFont", 8, -400, Color(1, 241, 249, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25, 100))
		cam.End3D2D()
	end
end


net.Receive("CombineLock.OpenMenu", function()
	local ent = net.ReadEntity()
	
	local frame = vgui.Create("DFrame")
	frame:SetSize(400,300)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "Конфигуратор" )
	frame.Paint = function(s,w,h)
		draw.RoundedBox(1,0,0,w,h,Color(15,15,15, 190))
	end	
	
	local text01 = vgui.Create( "DLabel", frame )
	text01:SetSize(1000,20)
	text01:SetPos( 45, 50 )
	text01:SetFont("marske4")
	text01:SetText( "Настройка правил доступа: " )
	
	local button01 = vgui.Create("DButton", frame)
	button01:SetText( "" )
	button01:SetFont("marske4")
	button01:SetPos( 20, 80 )
	button01:SetSize( 360, 30 )
	button01.Paint = function( self, w, h )
		if ent:GetNWBool("CombineLock_Factory") == true then
			draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 165, 0, 50 ) )
		else
			draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 15, 15, 125 ) )
		end
		draw.SimpleText("Работники завода", "marske4", w/2, h/2, Color(255,255,255), 1, 1)
	end
	button01.DoClick = function()
		net.Start("CombineLock.Server")
		net.WriteEntity(ent)
		net.WriteInt(1, 10)
		net.SendToServer()
	end
	
	local button02 = vgui.Create("DButton", frame)
	button02:SetText( "" )
	button02:SetFont("marske4")
	button02:SetPos( 20, 120 )
	button02:SetSize( 360, 30 )
	button02.Paint = function( self, w, h )
		if ent:GetNWBool("CombineLock_Hospital") == true then
			draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 165, 0, 50 ) )
		else
			draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 15, 15, 125 ) )
		end
		draw.SimpleText("Врачи", "marske4", w/2, h/2, Color(255,255,255), 1, 1)
	end
	button02.DoClick = function()
		net.Start("CombineLock.Server")
		net.WriteEntity(ent)
		net.WriteInt(2, 10)
		net.SendToServer()
	end
	
	local button03 = vgui.Create("DButton", frame)
	button03:SetText( "" )
	button03:SetFont("marske4")
	button03:SetPos( 20, 160 )
	button03:SetSize( 360, 30 )
	button03.Paint = function( self, w, h )
		if ent:GetNWBool("CombineLock_ExtraFood") == true then
			draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 165, 0, 50 ) )
		else
			draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 15, 15, 125 ) )
		end
		draw.SimpleText("Провизоры", "marske4", w/2, h/2, Color(255,255,255), 1, 1)
	end
	button03.DoClick = function()
		net.Start("CombineLock.Server")
		net.WriteEntity(ent)
		net.WriteInt(3, 10)
		net.SendToServer()
	end
	
	local button04 = vgui.Create("DButton", frame)
	button04:SetText( "" )
	button04:SetFont("marske4")
	button04:SetPos( 20, 200 )
	button04:SetSize( 360, 30 )
	button04.Paint = function( self, w, h )
		if ent:GetNWBool("CombineLock_HighLoyalty") == true then
			draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 165, 0, 50 ) )
		else
			draw.RoundedBox( 0, 0, 0, w, h, Color( 15, 15, 15, 125 ) )
		end
		draw.SimpleText("Высшее общество", "marske4", w/2, h/2, Color(255,255,255), 1, 1)
	end
	button04.DoClick = function()
		net.Start("CombineLock.Server")
		net.WriteEntity(ent)
		net.WriteInt(4, 10)
		net.SendToServer()
	end
	
	local button05 = vgui.Create("DButton", frame)
	button05:SetText( "Удалить" )
	button05:SetFont("marske4")
	button05:SetPos( 20, 260 )
	button05:SetSize( 360, 30 )
	button05.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 45, 45, 45, 55 ) )
	end
	button05.DoClick = function()
		net.Start("CombineLock.Server")
		net.WriteEntity(ent)
		net.WriteInt(5, 10)
		net.SendToServer()
	end
end)