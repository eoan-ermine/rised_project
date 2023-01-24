-- "addons\\lcdprinters\\lua\\entities\\lcd_npc\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

net.Receive("Printers.OpenMenu", function()
	PrintersNPC_Main()
end)

function PrintersNPC_Main()
	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW(),ScrH()/2)
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame.startTime = SysTime()
	frame.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)

		draw.SimpleText("Продавец принтеров и комплектующих", "marske12", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Принтеры", "marske5", w/4, 25+55, Color(255, 195, 87, 255), 0, 2)
		
		draw.SimpleText("Компоненты", "marske5", w/1.6, 25+55, Color(255, 195, 87, 255), 0, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("X")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(ScrW()/1.5 - 25,0)
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

	local button01 = vgui.Create("DButton")
	button01:SetSize(450, 25)
	button01:SetPos(ScrW()/4, 110)
	button01:SetText("")
	button01:SetFont( "marske4" )
	button01:SetParent(frame)
	button01.Text = "Обычный принтер   [5000 T.]"
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
			draw.RoundedBox(0,0,h-1,w/2,1,Color(145,145,145,button01.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(145,145,145,button01.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w/2,1,Color(255, 195, 87,button01.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 195, 87,button01.alpha), 0, 1);
			return;
		end

		draw.RoundedBox(0,0,h-1,w/10,1,Color(255, 255, 255,button01.alpha));
		draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 255, 255,button01.alpha), 0, 1);
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
		net.Start("Printers.Server")
		net.WriteInt(-1,10)
		net.SendToServer()
	end
	button01.OnCursorExited = function(self)
		self.hovered = false
	end
	
	-- local button02 = vgui.Create("DButton")
	-- button02:SetSize(450, 25)
	-- button02:SetPos(ScrW()/4, 110 + 35)
	-- button02:SetText("")
	-- button02:SetFont( "marske4" )
	-- button02:SetParent(frame)
	-- button02.Text = "Сертификат - доставщика"
	-- button02.hovered = false
	-- button02.disabled = false
	-- button02.alpha = 0
	-- button02.starttime = SysTime() + 0.1;
	-- button02.Paint = function(self, w, h)
		-- if (button02.starttime < SysTime()) then
			-- button02.alpha = button02.alpha or 0
			-- button02.alpha = Lerp(FrameTime(), button02.alpha, 255)
		-- end
		
		-- if (self.disabled) then
			-- draw.RoundedBox(0,0,h-1,w/2,1,Color(145,145,145,button02.alpha));
			-- draw.SimpleText(self.Text, "marske4", 0, h/2, Color(145,145,145,button02.alpha), 0, 1);
			-- return;
		-- end
		-- if (self.hovered) then
			-- draw.RoundedBox(0,0,h-1,w/2,1,Color(255, 195, 87,button02.alpha));
			-- draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 195, 87,button02.alpha), 0, 1);
			-- return;
		-- end

		-- draw.RoundedBox(0,0,h-1,w/10,1,Color(255, 255, 255,button02.alpha));
		-- draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 255, 255,button02.alpha), 0, 1);
	-- end;
	-- button02.OnCursorEntered = function(self)
		-- if (self.disabled) then return false end
		-- self.hovered = true
		-- surface.PlaySound("garrysmod/ui_hover.wav")
	-- end
	-- button02.OnMousePressed = function(self)
		-- if (self.disabled) then return false end
		-- surface.PlaySound("garrysmod/ui_click.wav")
		
		-- frame:Close()
		-- S_Courier()
	-- end
	-- button02.OnCursorExited = function(self)
		-- self.hovered = false
	-- end
	
	
	
	local c_button01 = vgui.Create("DButton")
	c_button01:SetSize(450, 25)
	c_button01:SetPos(ScrW()/1.6, 110)
	c_button01:SetText("")
	c_button01:SetFont( "marske4" )
	c_button01:SetParent(frame)
	c_button01.Text = "Охладитель   [50 T.]"
	local width, height = surface.GetTextSize(c_button01.Text)
	c_button01.hovered = false
	c_button01.disabled = false
	c_button01.alpha = 0
	c_button01.starttime = SysTime();
	c_button01.Paint = function(self, w, h)
		if (c_button01.starttime < SysTime()) then
			c_button01.alpha = c_button01.alpha or 0
			c_button01.alpha = Lerp(FrameTime(), c_button01.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,c_button01.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(145,145,145,c_button01.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 195, 87,c_button01.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 195, 87,c_button01.alpha), 0, 1);
			return;
		end

		draw.RoundedBox(0,0,h-1,w/4.2,1,Color(255, 255, 255,c_button01.alpha));
		draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 255, 255,c_button01.alpha), 0, 1);
	end;
	c_button01.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	c_button01.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		
		frame:Close()
		net.Start("Printers.Server")
		net.WriteInt(1,10)
		net.SendToServer()
	end
	c_button01.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local c_button02 = vgui.Create("DButton")
	c_button02:SetSize(450, 25)
	c_button02:SetPos(ScrW()/1.6, 110 + 35)
	c_button02:SetText("")
	c_button02:SetFont( "marske4" )
	c_button02:SetParent(frame)
	c_button02.Text = "Усилитель   [10000 T.]"
	c_button02.hovered = false
	c_button02.disabled = false
	c_button02.alpha = 0
	c_button02.starttime = SysTime() + 0.1;
	c_button02.Paint = function(self, w, h)
		if (c_button02.starttime < SysTime()) then
			c_button02.alpha = c_button02.alpha or 0
			c_button02.alpha = Lerp(FrameTime(), c_button02.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,c_button02.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(145,145,145,c_button02.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 195, 87,c_button02.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 195, 87,c_button02.alpha), 0, 1);
			return;
		end

		draw.RoundedBox(0,0,h-1,w/4.2,1,Color(255, 255, 255,c_button02.alpha));
		draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 255, 255,c_button02.alpha), 0, 1);
	end;
	c_button02.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	c_button02.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		
		frame:Close()
		net.Start("Printers.Server")
		net.WriteInt(2,10)
		net.SendToServer()
	end
	c_button02.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local c_button03 = vgui.Create("DButton")
	c_button03:SetSize(450, 25)
	c_button03:SetPos(ScrW()/1.6, 110 + 35 * 2)
	c_button03:SetText("")
	c_button03:SetFont( "marske4" )
	c_button03:SetParent(frame)
	c_button03.Text = "Кулер   [750 T.]"
	c_button03.hovered = false
	c_button03.disabled = false
	c_button03.alpha = 0
	c_button03.starttime = SysTime() + 0.2;
	c_button03.Paint = function(self, w, h)
		if (c_button03.starttime < SysTime()) then
			c_button03.alpha = c_button03.alpha or 0
			c_button03.alpha = Lerp(FrameTime(), c_button03.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,c_button03.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(145,145,145,c_button03.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 195, 87,c_button03.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 195, 87,c_button03.alpha), 0, 1);
			return;
		end

		draw.RoundedBox(0,0,h-1,w/4.2,1,Color(255, 255, 255,c_button03.alpha));
		draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 255, 255,c_button03.alpha), 0, 1);
	end;
	c_button03.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	c_button03.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		
		frame:Close()
		net.Start("Printers.Server")
		net.WriteInt(3,10)
		net.SendToServer()
	end
	c_button03.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local c_button04 = vgui.Create("DButton")
	c_button04:SetSize(450, 25)
	c_button04:SetPos(ScrW()/1.6, 110 + 35 * 3)
	c_button04:SetText("")
	c_button04:SetFont( "marske4" )
	c_button04:SetParent(frame)
	c_button04.Text = "Экран   [50 T.]"
	c_button04.hovered = false
	c_button04.disabled = false
	c_button04.alpha = 0
	c_button04.starttime = SysTime() + 0.3;
	c_button04.Paint = function(self, w, h)
		if (c_button04.starttime < SysTime()) then
			c_button04.alpha = c_button04.alpha or 0
			c_button04.alpha = Lerp(FrameTime(), c_button04.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,c_button04.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(145,145,145,c_button04.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 195, 87,c_button04.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 195, 87,c_button04.alpha), 0, 1);
			return;
		end

		draw.RoundedBox(0,0,h-1,w/4.2,1,Color(255, 255, 255,c_button04.alpha));
		draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 255, 255,c_button04.alpha), 0, 1);
	end;
	c_button04.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	c_button04.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		
		frame:Close()
		net.Start("Printers.Server")
		net.WriteInt(4,10)
		net.SendToServer()
	end
	c_button04.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local c_button05 = vgui.Create("DButton")
	c_button05:SetSize(450, 25)
	c_button05:SetPos(ScrW()/1.6, 110 + 35 * 4)
	c_button05:SetText("")
	c_button05:SetFont( "marske4" )
	c_button05:SetParent(frame)
	c_button05.Text = "Хранилище   [300 T.]"
	c_button05.hovered = false
	c_button05.disabled = false
	c_button05.alpha = 0
	c_button05.starttime = SysTime() + 0.4;
	c_button05.Paint = function(self, w, h)
		if (c_button05.starttime < SysTime()) then
			c_button05.alpha = c_button05.alpha or 0
			c_button05.alpha = Lerp(FrameTime(), c_button05.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,c_button05.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(145,145,145,c_button05.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 195, 87,c_button05.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 195, 87,c_button05.alpha), 0, 1);
			return;
		end

		draw.RoundedBox(0,0,h-1,w/4.2,1,Color(255, 255, 255,c_button05.alpha));
		draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 255, 255,c_button05.alpha), 0, 1);
	end;
	c_button05.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	c_button05.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		
		frame:Close()
		net.Start("Printers.Server")
		net.WriteInt(5,10)
		net.SendToServer()
	end
	c_button05.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local c_button06 = vgui.Create("DButton")
	c_button06:SetSize(450, 25)
	c_button06:SetPos(ScrW()/1.6, 110 + 35 * 5)
	c_button06:SetText("")
	c_button06:SetFont( "marske4" )
	c_button06:SetParent(frame)
	c_button06.Text = "Защитный блок   [250 T.]"
	c_button06.hovered = false
	c_button06.disabled = false
	c_button06.alpha = 0
	c_button06.starttime = SysTime() + 0.5
	c_button06.Paint = function(self, w, h)
		if (c_button06.starttime < SysTime()) then
			c_button06.alpha = c_button06.alpha or 0
			c_button06.alpha = Lerp(FrameTime(), c_button06.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,c_button06.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(145,145,145,c_button06.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 195, 87,c_button06.alpha));
			draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 195, 87,c_button06.alpha), 0, 1);
			return;
		end

		draw.RoundedBox(0,0,h-1,w/4.2,1,Color(255, 255, 255,c_button06.alpha));
		draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 255, 255,c_button06.alpha), 0, 1);
	end;
	c_button06.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	c_button06.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		
		frame:Close()
		net.Start("Printers.Server")
		net.WriteInt(6,10)
		net.SendToServer()
	end
	c_button06.OnCursorExited = function(self)
		self.hovered = false
	end
end