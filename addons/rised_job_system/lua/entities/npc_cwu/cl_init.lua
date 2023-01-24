-- "addons\\rised_job_system\\lua\\entities\\npc_cwu\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

net.Receive("CWUNPC.OpenMenu", function()
	S_Main()
end)

local uniforms = {
	{
		["Id"] = 1,
		["Display"] = "Спецодежда - уборщика",
		["Cost"] = "50 T."
	},
	{
		["Id"] = 2,
		["Display"] = "Спецодежда - доставщика",
		["Cost"] = "100 T."
	},
	{
		["Id"] = 3,
		["Display"] = "Спецодежда - заводская",
		["Cost"] = "300 T."
	},
	{
		["Id"] = 4,
		["Display"] = "Спецодежда - медицинская",
		["Cost"] = "400 T."
	},
	{
		["Id"] = 5,
		["Display"] = "Спецодежда - главного врача",
		["Cost"] = "2000 T."
	},
	{
		["Id"] = 6,
		["Display"] = "Спецодежда - провизора",
		["Cost"] = "500 T."
	},
	{
		["Id"] = 7,
		["Display"] = "Спецодежда - бармена",
		["Cost"] = "500 T."
	},
}

function S_Main()
	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW(),1920)
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame.startTime = SysTime()
	frame.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)

		draw.SimpleText("ГСР - Работодатель", "marske6", w/2, ScrH()/10, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, ScrH()/10 + 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Сменить специальность на:", "marske6", w/4, ScrH()/10 + 25+55, Color(255, 195, 87, 255), 0, 2)
		
		draw.SimpleText("Спецодежда", "marske5", w/1.6, ScrH()/10 + 25+55, Color(255, 195, 87, 255), 0, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("X")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(ScrW()/1.5 - 25,ScrH()/10)
	buttonClose.Paint = function(me, w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (me.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
		end

		if (me:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
		end
	end
	
	buttonClose.DoClick = function()
		frame:Close()
	end
	
	local jobs_to_change = {
		{
			["JobName"] = "Уборщик",
			["JobTitle"] = "уборщика",
			["UnlockLvl"] = RISED.Config.Economy.Trashman_exp_unlock_lvl,
			["SertCost"] = RISED.Config.Economy.SertificateCost_Trashman
		},
		{
			["JobName"] = "Доставщик мяса",
			["JobTitle"] = "доставщика мяса",
			["UnlockLvl"] = RISED.Config.Economy.CourierMeat_exp_unlock_lvl,
			["SertCost"] = RISED.Config.Economy.SertificateCost_CourierMeat
		},
		{
			["JobName"] = "Обработчик мяса",
			["JobTitle"] = "обработчика мяса",
			["UnlockLvl"] = RISED.Config.Economy.MeatCooker_exp_unlock_lvl,
			["SertCost"] = RISED.Config.Economy.SertificateCost_MeatCooker
		},
		{
			["JobName"] = "Доставщик энзимов",
			["JobTitle"] = "доставщика энзимов",
			["UnlockLvl"] = RISED.Config.Economy.CourierEnzymes_exp_unlock_lvl,
			["SertCost"] = RISED.Config.Economy.SertificateCost_CourierEnzymes
		},
		{
			["JobName"] = "Сборщик рационов",
			["JobTitle"] = "сборщика рационов",
			["UnlockLvl"] = RISED.Config.Economy.Compiler_exp_unlock_lvl,
			["SertCost"] = RISED.Config.Economy.SertificateCost_Compiler
		},
		{
			["JobName"] = "Доставщик металла",
			["JobTitle"] = "доставщика металла",
			["UnlockLvl"] = RISED.Config.Economy.CourierMetal_exp_unlock_lvl,
			["SertCost"] = RISED.Config.Economy.SertificateCost_CourierMetal
		},
		{
			["JobName"] = "Прессовщик",
			["JobTitle"] = "прессовщика",
			["UnlockLvl"] = RISED.Config.Economy.MetalPressor_exp_unlock_lvl,
			["SertCost"] = RISED.Config.Economy.SertificateCost_MetalPressor
		},
		{
			["JobName"] = "Сварщик",
			["JobTitle"] = "сварщика",
			["UnlockLvl"] = RISED.Config.Economy.MetalWelder_exp_unlock_lvl,
			["SertCost"] = RISED.Config.Economy.SertificateCost_MetalWelder
		},
		{
			["JobName"] = "Ионизатор",
			["JobTitle"] = "ионизатора",
			["UnlockLvl"] = RISED.Config.Economy.MetalIonizer_exp_unlock_lvl,
			["SertCost"] = RISED.Config.Economy.SertificateCost_MetalIonizer
		},
		{
			["JobName"] = "Провизор",
			["JobTitle"] = "провизора",
			["UnlockLvl"] = RISED.Config.Economy.Provisor_exp_unlock_lvl,
			["SertCost"] = RISED.Config.Economy.SertificateCost_Provisor
		},
		{
			["JobName"] = "Бармен",
			["JobTitle"] = "бармена",
			["UnlockLvl"] = RISED.Config.Economy.Bartender_exp_unlock_lvl,
			["SertCost"] = RISED.Config.Economy.SertificateCost_Bartender
		},
		{
			["JobName"] = "Врач",
			["JobTitle"] = "врача",
			["UnlockLvl"] = RISED.Config.Economy.Doctor_exp_unlock_lvl,
			["SertCost"] = RISED.Config.Economy.SertificateCost_Doctor
		}
	}

	local jobs_offset = 0
	for k,v in pairs(jobs_to_change) do

		local ply_common_lvl = ply.Player_LevelCommon or 0

		local button = vgui.Create("DButton")
		button:SetSize(450, 25)
		button:SetPos(ScrW()/4, ScrH()/10 + 110 + jobs_offset)
		button:SetText("")
		button:SetParent(frame)
		button.Text = v["JobTitle"] .. " | " .. v["UnlockLvl"] .. " уровень"
		local width, height = surface.GetTextSize(button.Text)
		button.hovered = false
		-- button.disabled = v["UnlockLvl"] > ply_common_lvl
		button.disabled = v["UnlockLvl"] > ply_common_lvl and !IsRisedTester(ply)
		button.alpha = 0
		button.starttime = SysTime();
		button.Paint = function(self, w, h)
			if (button.starttime < SysTime()) then
				button.alpha = button.alpha or 0
				button.alpha = Lerp(FrameTime(), button.alpha, 255)
			end
			
			if (self.disabled) then
				draw.RoundedBox(0,0,h-1,w/2,1,Color(145,145,145,button.alpha));
				draw.SimpleText(self.Text, "marske4", 0, h/2, Color(145,145,145,button.alpha), 0, 1);
				return;
			end
			if (self.hovered) then
				draw.RoundedBox(0,0,h-1,w/2,1,Color(255, 195, 87,button.alpha));
				draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 195, 87,button.alpha), 0, 1);
				return;
			end
	
			draw.RoundedBox(0,0,h-1,w/10,1,Color(255, 255, 255,button.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 255, 255,button.alpha), 0, 1);
		end;
		button.OnCursorEntered = function(self)
			if (self.disabled) then return false end
			self.hovered = true
			surface.PlaySound("garrysmod/ui_hover.wav")
		end
		button.OnMousePressed = function(self)
			if (self.disabled) then return false end
			surface.PlaySound("garrysmod/ui_click.wav")
			
			frame:Close()
			S_Job(v["JobName"], v["JobTitle"], v["SertCost"])
		end
		button.OnCursorExited = function(self)
			self.hovered = false
		end

		jobs_offset = jobs_offset + 35
	end
	
	local button_quit = vgui.Create("DButton")
	button_quit:SetSize(450, 25)
	button_quit:SetPos(ScrW()/4, ScrH()/10 + 145 + jobs_offset)
	button_quit:SetText("")
	button_quit:SetFont( "marske4" )
	button_quit:SetParent(frame)
	button_quit.Text = "уволиться"
	button_quit.hovered = false
	button_quit.disabled = false
	button_quit.alpha = 0
	button_quit.starttime = SysTime() + 0.7
	button_quit.Paint = function(self, w, h)
		if (button_quit.starttime < SysTime()) then
			button_quit.alpha = button_quit.alpha or 0
			button_quit.alpha = Lerp(FrameTime(), button_quit.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w/2,1,Color(145,145,145,button_quit.alpha))
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(145,145,145,button_quit.alpha), 0, 1)
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w/2,1,Color(255, 195, 87,button_quit.alpha))
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 195, 87,button_quit.alpha), 0, 1)
			return;
		end

		draw.RoundedBox(0,0,h-1,w/10,1,Color(255, 255, 255,button_quit.alpha))
		draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 255, 255,button_quit.alpha), 0, 1)
	end;
	button_quit.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	button_quit.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		net.Start("CWUNPC.Server")
		net.WriteInt(-50,10)
		net.SendToServer()
	end
	button_quit.OnCursorExited = function(self)
		self.hovered = false
	end

	local ind = 0
	for k,v in pairs(uniforms) do
		local c_button = vgui.Create("DButton")
		c_button:SetSize(450, 25)
		c_button:SetPos(ScrW()/1.6, ScrH()/10 + 110 + 35 * ind)
		c_button:SetText("")
		c_button:SetFont( "marske4" )
		c_button:SetParent(frame)
		c_button.Text = v["Display"] .. "   [" .. v["Cost"] .. "]"
		local width, height = surface.GetTextSize(c_button.Text)
		c_button.hovered = false
		c_button.disabled = false
		c_button.alpha = 0
		c_button.starttime = SysTime();
		c_button.Paint = function(self, w, h)
			if (c_button.starttime < SysTime()) then
				c_button.alpha = c_button.alpha or 0
				c_button.alpha = Lerp(FrameTime(), c_button.alpha, 255)
			end
			
			if (self.disabled) then
				draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,c_button.alpha));
				draw.SimpleText(self.Text, "marske4", 0, h/2, Color(145,145,145,c_button.alpha), 0, 1);
				return;
			end
			if (self.hovered) then
				draw.RoundedBox(0,0,h-1,w,1,Color(255, 195, 87,c_button.alpha));
				draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 195, 87,c_button.alpha), 0, 1);
				return;
			end

			draw.RoundedBox(0,0,h-1,w/4.2,1,Color(255, 255, 255,c_button.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 255, 255,c_button.alpha), 0, 1);
		end;
		c_button.OnCursorEntered = function(self)
			if (self.disabled) then return false end
			self.hovered = true
			surface.PlaySound("garrysmod/ui_hover.wav")
		end
		c_button.OnMousePressed = function(self)
			if (self.disabled) then return false end
			surface.PlaySound("garrysmod/ui_click.wav")
			
			frame:Close()
			net.Start("CWUNPC.Server")
			net.WriteInt(v["Id"],10)
			net.SendToServer()
		end
		c_button.OnCursorExited = function(self)
			self.hovered = false
		end

		ind = ind + 1
	end
end

function S_Job(job_status, job_title, cost)

	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW()/2,ScrH()/2)
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame.startTime = SysTime()
	frame.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)

		draw.SimpleText("Смена работы на " .. job_title, "marske6", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Вы действительно хотите сменить специальность ?", "marske6", 0, 25+55, Color(255, 195, 87, 255), 0, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("X")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(ScrW()/2 - 25,0)
	buttonClose.Paint = function(me, w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (me.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
		end

		if (me:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
		end
	end
	buttonClose.DoClick = function()
		frame:Close()
	end
	
	local buttonBack = vgui.Create("DButton", frame)
	buttonBack:SetText("<")
	buttonBack:SetSize(25,25)
	buttonBack:SetPos(25,0)
	buttonBack.Paint = function(me, w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (me.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
		end

		if (me:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
		end
	end
	buttonBack.DoClick = function()
		S_Main()
		frame:Close()
	end
	
	
	
	local button01 = vgui.Create("DButton")
	button01:SetSize(800, 25)
	button01:SetPos(100, 145)
	button01:SetText("")
	button01:SetFont( "marske4" )
	button01:SetParent(frame)
	if cost <= 0 then
		button01.Text = "Получить сертификат   -   бесплатно"
	else
		button01.Text = "Подтвердить   - цена " .. cost .. " токенов"
	end
	local width, height = surface.GetTextSize(button01.Text)
	button01.hovered = false
	button01.disabled = false
	button01.alpha = 0
	button01.starttime = SysTime();
	button01.Paint = function(self, w, h)
		if (button01.starttime < SysTime()) then
			button01.alpha = button01.alpha or 0
			button01.alpha = Lerp(FrameTime(), button01.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,button01.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(145,145,145,button01.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 195, 87,button01.alpha));
			draw.SimpleText(self.Text, "marske6", 0, h/2, Color(255, 195, 87,button01.alpha), 0, 1);
			return;
		end
		
		draw.RoundedBox(0,0,h-1,w/2.7,1,Color(255, 255, 255,button01.alpha));
		draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 255, 255,button01.alpha), 0, 1);
	end;
	button01.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	button01.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		net.Start("CWUNPC.Server")
		net.WriteInt(-1,10)
		net.WriteString(job_status)
		net.SendToServer()
	end
	button01.OnCursorExited = function(self)
		self.hovered = false
	end
end

function ENT:Draw()
	self:DrawModel()
	local pos = self:GetPos()
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 0)
	ang:RotateAroundAxis(ang:Forward(), 85)	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < 500 then
		if (self:GetDTInt(1) == 0) then
			cam.Start3D2D(pos + ang:Up()*0, Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.07)
				
				draw.SimpleText("Елена Дмитриевна", "marske6", -20, -1100, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
				surface.SetDrawColor( 255, 255, 255, 50 )
				surface.DrawLine( -90, -1085, 50, -1085 )
				draw.SimpleText("Отдел трудоустройства", "Trebuchet18", -20, -1075, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);

			cam.End3D2D();
		end
	end 
end
