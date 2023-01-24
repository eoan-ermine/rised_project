-- "addons\\dispatch_control\\lua\\entities\\dispatch_terminal\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

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
})

function ENT:Draw()
	self:DrawModel();
	
	local pos = self:GetPos()
	local ang = self:GetAngles()

	ang:RotateAroundAxis(ang:Up(), 90);
	ang:RotateAroundAxis(ang:Forward(), 90);	
	if LocalPlayer():GetPos():Distance(self:GetPos()) < self:GetNWInt("distance") then	
		cam.Start3D2D(pos + ang:Up(), Angle(0, LocalPlayer():EyeAngles().y-90, 90), 0.1)
				draw.SimpleTextOutlined("Терминал контроля DISPATCH", "methFont", 8, -550, Color(1, 241, 249, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(25, 25, 25, 100));
		cam.End3D2D();
	end;
end;

include("shared.lua")

net.Receive("DispatchTerminalClient", function()
	local action = net.ReadString()

	if action == "Меню" then
		Dispatch_Main()
	elseif action == "Силовые поля" then
		local netlenth = net.ReadInt(32)
		local binary = net.ReadData(netlenth)
		local forcefields_json = util.Decompress(binary)
		local forcefields_db = util.JSONToTable(forcefields_json)

		City_Forcefields(forcefields_db)
	elseif action == "Камера" then
		local netlenth = net.ReadInt(32)
		local binary = net.ReadData(netlenth)
		local camera_data_json = util.Decompress(binary)
		local camera_data = util.JSONToTable(camera_data_json)

		local netlenth2 = net.ReadInt(32)
		local binary2 = net.ReadData(netlenth2)
		local extra_json = util.Decompress(binary2)
		local extra = util.JSONToTable(extra_json)
		
		City_Camera(camera_data, extra)
	end
end)

local function DispatchButtonPaint(self, w, h)
	if (self.starttime < SysTime()) then
		self.alpha = self.alpha or 0
		self.alpha = Lerp(FrameTime(), self.alpha, 255)
	end
	
	if (self.disabled) then
		draw.RoundedBox(0,0,h-1,w/2,1,Color(145,145,145,self.alpha));
		draw.SimpleText(self.Text, "marske4", 0, h/2, Color(145,145,145,self.alpha), 0, 1);
		return;
	end
	if (self.hovered) then
		draw.RoundedBox(0,0,h-1,w/2,1,Color(255, 165, 0,self.alpha));
		draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 165, 0,self.alpha), 0, 1);
		return;
	end

	draw.RoundedBox(0,0,h-1,w/10,1,Color(255, 255, 255,self.alpha));
	draw.SimpleText(self.Text, "marske4", 0, h/2, Color(255, 255, 255,self.alpha), 0, 1);
end

function Dispatch_Main()

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

		draw.SimpleText("Контроль панель", "marske12", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Надзор", "marske5", 0, 25+55, col_combine, 0, 2)
		
		draw.SimpleText("Операции", "marske5", w/2, 25+55, col_combine, 0, 2)
		
		draw.SimpleText("", "marske5", w/1.2, 25+55, col_combine, 0, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
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
		draw.SimpleText("X", "marske4", w/2, h/2, Color(255,165,0), 1, 1)
	end
	
	buttonClose.DoClick = function()
		frame:Close()
	end
	
	local button01 = vgui.Create("DButton")
	button01:SetSize(450, 25)
	button01:SetPos(50, 135)
	button01:SetText("")
	button01:SetFont( "marske4" )
	button01:SetParent(frame)
	button01.Text = "Гражданская оборона"
	local width, height = surface.GetTextSize(button01.Text)
	button01.hovered = false
	button01.disabled = false
	button01.alpha = 0
	button01.starttime = SysTime();
	button01.Paint = DispatchButtonPaint
	button01.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	button01.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		
		frame:Close()
		V_CP()
	end
	button01.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local button02 = vgui.Create("DButton")
	button02:SetSize(450, 25)
	button02:SetPos(50, 200)
	button02:SetText("")
	button02:SetFont( "marske4" )
	button02:SetParent(frame)
	button02.Text = "Сверхчеловеческий отдел"
	local width, height = surface.GetTextSize(button02.Text)
	button02.hovered = false
	button02.disabled = false
	button02.alpha = 0
	button02.starttime = SysTime();
	button02.Paint = DispatchButtonPaint
	button02.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	button02.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		
		frame:Close()
		V_OTA()
	end
	button02.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local button03 = vgui.Create("DButton")
	button03:SetSize(450, 25)
	button03:SetPos(50, 265)
	button03:SetText("")
	button03:SetFont( "marske4" )
	button03:SetParent(frame)
	button03.Text = "Городское видеонаблюдение"
	local width, height = surface.GetTextSize(button03.Text)
	button03.hovered = false
	button03.disabled = false
	button03.alpha = 0
	button03.starttime = SysTime();
	button03.Paint = DispatchButtonPaint
	button03.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	button03.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		
		frame:Close()
		V_City()
	end
	button03.OnCursorExited = function(self)
		self.hovered = false
	end

	
	local button_r01 = vgui.Create("DButton")
	button_r01:SetSize(450, 25)
	button_r01:SetPos(ScrW()/4 + 50, 135)
	button_r01:SetText("")
	button_r01:SetFont( "marske4" )
	button_r01:SetParent(frame)
	button_r01.Text = "Силовые поля"
	local width, height = surface.GetTextSize(button_r01.Text)
	button_r01.hovered = false
	button_r01.disabled = false
	button_r01.alpha = 0
	button_r01.starttime = SysTime();
	button_r01.Paint = DispatchButtonPaint
	button_r01.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	button_r01.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")

		frame:Close()

		net.Start("DispatchTerminalServer")
		net.WriteString("Получить силовые поля")
		net.SendToServer()
	end
	button_r01.OnCursorExited = function(self)
		self.hovered = false
	end

	local button_r02 = vgui.Create("DButton")
	button_r02:SetSize(450, 25)
	button_r02:SetPos(ScrW()/4 + 50, 200)
	button_r02:SetText("")
	button_r02:SetFont( "marske4" )
	button_r02:SetParent(frame)
	button_r02.Text = "Открыть базу данных"
	local width, height = surface.GetTextSize(button_r02.Text)
	button_r02.hovered = false
	button_r02.disabled = false
	button_r02.alpha = 0
	button_r02.starttime = SysTime();
	button_r02.Paint = DispatchButtonPaint
	button_r02.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	button_r02.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")

		frame:Close()

		CitizenDB_MainMenu()
	end
	button_r02.OnCursorExited = function(self)
		self.hovered = false
	end
end

function V_CP()
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

		draw.SimpleText("Гражданская оборона", "marske12", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Список сотрудников", "marske5", 0, 25+55, col_combine, 0, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
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
		draw.SimpleText("X", "marske4", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonClose.DoClick = function()
		frame:Close()
	end
	
	local buttonBack = vgui.Create("DButton", frame)
	buttonBack:SetText("")
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
		draw.SimpleText("<", "marske5", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonBack.DoClick = function()
		Dispatch_Main()
		frame:Close()
	end
	
	local panel = vgui.Create("DPanel", frame)
	panel:DockPadding(40, 110, 20, 10)
	panel:Dock(FILL)
	panel.Paint = function(self, w, h)
	end
	
	local DScrollPanel = vgui.Create( "DScrollPanel", panel )
	DScrollPanel:Dock( FILL )
	
	local sbar = DScrollPanel:GetVBar()
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(255, 165, 0, 0))
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(255, 165, 0, 0))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(255, 255, 255, 0))
	end
	
	local offset = 0
	for k,v in pairs(player.GetAll()) do
		if GAMEMODE.MetropoliceJobs[v:Team()] then
			local button01 = DScrollPanel:Add("DButton") 
			button01:SetSize(450, 25)
			button01:SetPos(100, offset)
			button01:SetText("")
			button01:SetFont( "marske4" )
			button01.Text = v:Nick()
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
					draw.SimpleText(self.Text, "marske5", 0, h/2, Color(145,145,145,button01.alpha), 0, 1);
					return;
				end
				if (self.hovered) then
					draw.RoundedBox(0,0,h-1,w/2,1,Color(255, 165, 0,button01.alpha));
					draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button01.alpha), 0, 1);
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
				V_Unit(v)
			end
			button01.OnCursorExited = function(self)
				self.hovered = false
			end
			
			offset = offset + 35
		end
	end
end

function V_OTA()
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

		draw.SimpleText("Сверхчеловеческий отдел", "marske12", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Список сотрудников", "marske5", 0, 25+55, col_combine, 0, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
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
		draw.SimpleText("X", "marske4", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonClose.DoClick = function()
		frame:Close()
	end
	
	local buttonBack = vgui.Create("DButton", frame)
	buttonBack:SetText("")
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
		draw.SimpleText("<", "marske5", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonBack.DoClick = function()
		Dispatch_Main()
		frame:Close()
	end
	
	local panel = vgui.Create("DPanel", frame)
	panel:DockPadding(40, 110, 20, 10)
	panel:Dock(FILL)
	panel.Paint = function(self, w, h)
	end
	
	local DScrollPanel = vgui.Create( "DScrollPanel", panel )
	DScrollPanel:Dock( FILL )
	
	local sbar = DScrollPanel:GetVBar()
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(255, 165, 0, 0))
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(255, 165, 0, 0))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(255, 255, 255, 0))
	end
	
	local offset = 0
	for k,v in pairs(player.GetAll()) do
		if GAMEMODE.CombineJobs[v:Team()] then
			local button01 = DScrollPanel:Add("DButton") 
			button01:SetSize(450, 25)
			button01:SetPos(100, offset)
			button01:SetText("")
			button01:SetFont( "marske4" )
			button01.Text = v:Nick()
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
					draw.SimpleText(self.Text, "marske5", 0, h/2, Color(145,145,145,button01.alpha), 0, 1);
					return;
				end
				if (self.hovered) then
					draw.RoundedBox(0,0,h-1,w/2,1,Color(255, 165, 0,button01.alpha));
					draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button01.alpha), 0, 1);
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
				V_Unit(v)
			end
			button01.OnCursorExited = function(self)
				self.hovered = false
			end
			
			offset = offset + 35
		end
	end
end

function V_City()
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

		draw.SimpleText("Городское видеонаблюдение", "marske12", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Камеры", "marske5", 0, 25+55, col_combine, 0, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
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
		draw.SimpleText("X", "marske4", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonClose.DoClick = function()
		frame:Close()
	end
	
	local buttonBack = vgui.Create("DButton", frame)
	buttonBack:SetText("")
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
		draw.SimpleText("<", "marske5", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonBack.DoClick = function()
		Dispatch_Main()
		frame:Close()
	end
	
	
	
	local button01 = vgui.Create("DButton")
	button01:SetSize(450, 25)
	button01:SetPos(100, 145)
	button01:SetText("")
	button01:SetFont( "marske4" )
	button01:SetParent(frame)
	button01.Text = "Камера 01"
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
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button01.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button01.alpha), 0, 1);
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
		surface.PlaySound("buttons/combine_button1.wav")
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Переключиться на камеру")
		net.WriteInt(1,10)
		net.SendToServer()
		
		Cam_Selector01()
	end
	button01.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local button02 = vgui.Create("DButton")
	button02:SetSize(450, 25)
	button02:SetPos(100, 245)
	button02:SetText("")
	button02:SetFont( "marske4" )
	button02:SetParent(frame)
	button02.Text = "Камера 02"
	local width, height = surface.GetTextSize(button02.Text)
	button02.hovered = false
	button02.disabled = false
	button02.alpha = 0
	button02.starttime = SysTime();
	button02.Paint = function(self, w, h)
		if (button02.starttime < SysTime()) then
			button02.alpha = button02.alpha or 0
			button02.alpha = Lerp(FrameTime(), button02.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,button02.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(145,145,145,button02.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button02.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button02.alpha), 0, 1);
			return;
		end
		
		draw.RoundedBox(0,0,h-1,w/2.7,1,Color(255, 255, 255,button02.alpha));
		draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 255, 255,button02.alpha), 0, 1);
	end;
	button02.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	button02.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("buttons/combine_button1.wav")
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Переключиться на камеру")
		net.WriteInt(2,10)
		net.SendToServer()
		
		Cam_Selector02()
	end
	button02.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local button03 = vgui.Create("DButton")
	button03:SetSize(450, 25)
	button03:SetPos(100, 345)
	button03:SetText("")
	button03:SetFont( "marske4" )
	button03:SetParent(frame)
	button03.Text = "Камера 03"
	local width, height = surface.GetTextSize(button03.Text)
	button03.hovered = false
	button03.disabled = false
	button03.alpha = 0
	button03.starttime = SysTime();
	button03.Paint = function(self, w, h)
		if (button03.starttime < SysTime()) then
			button03.alpha = button03.alpha or 0
			button03.alpha = Lerp(FrameTime(), button03.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,button03.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(145,145,145,button03.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button03.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button03.alpha), 0, 1);
			return;
		end
		
		draw.RoundedBox(0,0,h-1,w/2.7,1,Color(255, 255, 255,button03.alpha));
		draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 255, 255,button03.alpha), 0, 1);
	end;
	button03.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	button03.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("buttons/combine_button1.wav")
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Переключиться на камеру")
		net.WriteInt(3,10)
		net.SendToServer()
		
		Cam_Selector03()
	end
	button03.OnCursorExited = function(self)
		self.hovered = false
	end
end

function V_Unit(unit)
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

		draw.SimpleText("Юнит Гражданской обороны", "marske12", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText(unit:Name(), "marske5", 0, 25+55, col_combine, 0, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
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
		draw.SimpleText("X", "marske4", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonClose.DoClick = function()
		frame:Close()
	end
	
	local buttonBack = vgui.Create("DButton", frame)
	buttonBack:SetText("")
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
		draw.SimpleText("<", "marske5", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonBack.DoClick = function()
		Dispatch_Main()
		frame:Close()
	end
	
	
	
	local button01 = vgui.Create("DButton")
	button01:SetSize(450, 25)
	button01:SetPos(100, 145)
	button01:SetText("")
	button01:SetFont( "marske4" )
	button01:SetParent(frame)
	button01.Text = "Видеонаблюдение через визор"
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
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button01.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button01.alpha), 0, 1);
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
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Переключиться на визор")
		net.WriteEntity(unit)
		net.SendToServer()
		
		Unit_Selector(unit)
	end
	button01.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local button02 = vgui.Create("DButton")
	button02:SetSize(450, 25)
	button02:SetPos(100, 200)
	button02:SetText("")
	button02:SetFont( "marske4" )
	button02:SetParent(frame)
	button02.Text = "Установка очков лояльности"
	local width, height = surface.GetTextSize(button02.Text)
	button02.hovered = false
	button02.disabled = false
	button02.alpha = 0
	button02.starttime = SysTime();
	button02.Paint = function(self, w, h)
		if (button02.starttime < SysTime()) then
			button02.alpha = button02.alpha or 0
			button02.alpha = Lerp(FrameTime(), button02.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,button02.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(145,145,145,button02.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button02.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button02.alpha), 0, 1);
			return;
		end
		
		draw.RoundedBox(0,0,h-1,w/2.7,1,Color(255, 255, 255,button02.alpha));
		draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 255, 255,button02.alpha), 0, 1);
	end;
	button02.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	button02.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		Unit_Loyalty(unit)
	end
	button02.OnCursorExited = function(self)
		self.hovered = false
	end
end

function Unit_Loyalty(unit)
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

		draw.SimpleText("Установка очков лояльности", "marske12", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText(unit:Name(), "marske5", 0, 25+55, col_combine, 0, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
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
		draw.SimpleText("X", "marske4", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonClose.DoClick = function()
		frame:Close()
	end
	
	local DermaNumSlider = vgui.Create( "DNumSlider", frame )
	DermaNumSlider:SetPos( 0, 100 )
	DermaNumSlider:SetSize( 300, 100 )
	DermaNumSlider:SetMin( -5 )
	DermaNumSlider:SetMax( 5 )
	DermaNumSlider:SetDecimals( 0 )
	
	local button01 = vgui.Create("DButton")
	button01:SetSize(450, 25)
	button01:SetPos(100, 200)
	button01:SetText("")
	button01:SetFont( "marske4" )
	button01:SetParent(frame)
	button01.Text = "Установить"
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
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button01.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button01.alpha), 0, 1);
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
		
		local value = math.Round(DermaNumSlider:GetValue())
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Установить лояльность")
		net.WriteEntity(unit)
		net.WriteInt(value, 10)
		net.SendToServer()
	end
	button01.OnCursorExited = function(self)
		self.hovered = false
	end
end

function Unit_Selector(unit)
	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW()/2,ScrH()/1.2)
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame.startTime = SysTime()
	frame.Paint = function(self, w, h)

		draw.SimpleText("Выбор юнита:", "marske12", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText(unit:Name(), "marske5", 0, 25+55, col_combine, 0, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
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
		draw.SimpleText("X", "marske4", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonClose.DoClick = function()
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Отключиться от визора")
		net.SendToServer()
	end
	
	local buttonBack = vgui.Create("DButton", frame)
	buttonBack:SetText("")
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
		draw.SimpleText("<", "marske5", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonBack.DoClick = function()
		Dispatch_Main()
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Отключиться от визора")
		net.SendToServer()
	end
	
	local button01 = vgui.Create("DButton")
	button01:SetSize(450, 25)
	button01:SetPos(0, 200)
	button01:SetText("")
	button01:SetFont( "marske4" )
	button01:SetParent(frame)
	button01.Text = "Предыдущий"
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
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button01.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button01.alpha), 0, 1);
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
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Предыдущий визор")
		net.WriteInt(1,10)
		net.SendToServer()
	end
	button01.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local button02 = vgui.Create("DButton")
	button02:SetSize(450, 25)
	button02:SetPos(ScrW()/4, 200)
	button02:SetText("")
	button02:SetFont( "marske4" )
	button02:SetParent(frame)
	button02.Text = "Следующий"
	local width, height = surface.GetTextSize(button02.Text)
	button02.hovered = false
	button02.disabled = false
	button02.alpha = 0
	button02.starttime = SysTime();
	button02.Paint = function(self, w, h)
		if (button02.starttime < SysTime()) then
			button02.alpha = button02.alpha or 0
			button02.alpha = Lerp(FrameTime(), button02.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,button02.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(145,145,145,button02.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button02.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button02.alpha), 0, 1);
			return;
		end
		
		draw.RoundedBox(0,0,h-1,w/2.7,1,Color(255, 255, 255,button02.alpha));
		draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 255, 255,button02.alpha), 0, 1);
	end;
	button02.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	button02.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Следующий визор")
		net.WriteInt(1,10)
		net.SendToServer()
	end
	button02.OnCursorExited = function(self)
		self.hovered = false
	end
end

function Cam_Selector01()

	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW()/2,ScrH()/1.2)
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame.startTime = SysTime()
	frame.Paint = function(self, w, h)

		draw.SimpleText("Выбор камеры:", "marske12", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Камера 01", "marske5", 0, 25+55, col_combine, 0, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
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
		draw.SimpleText("X", "marske4", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonClose.DoClick = function()
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Отключиться от визора")
		net.SendToServer()
	end
	
	local buttonBack = vgui.Create("DButton", frame)
	buttonBack:SetText("")
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
		draw.SimpleText("<", "marske5", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonBack.DoClick = function()
		Dispatch_Main()
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Отключиться от визора")
		net.SendToServer()
	end
	
	local button01 = vgui.Create("DButton")
	button01:SetSize(450, 25)
	button01:SetPos(0, 200)
	button01:SetText("")
	button01:SetFont( "marske4" )
	button01:SetParent(frame)
	button01.Text = "Предыдущая"
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
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button01.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button01.alpha), 0, 1);
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
		surface.PlaySound("buttons/combine_button1.wav")
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Переключиться на камеру")
		net.WriteInt(3,10)
		net.SendToServer()
		
		Cam_Selector03()
	end
	button01.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local button02 = vgui.Create("DButton")
	button02:SetSize(450, 25)
	button02:SetPos(ScrW()/4, 200)
	button02:SetText("")
	button02:SetFont( "marske4" )
	button02:SetParent(frame)
	button02.Text = "Следующая"
	local width, height = surface.GetTextSize(button02.Text)
	button02.hovered = false
	button02.disabled = false
	button02.alpha = 0
	button02.starttime = SysTime();
	button02.Paint = function(self, w, h)
		if (button02.starttime < SysTime()) then
			button02.alpha = button02.alpha or 0
			button02.alpha = Lerp(FrameTime(), button02.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,button02.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(145,145,145,button02.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button02.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button02.alpha), 0, 1);
			return;
		end
		
		draw.RoundedBox(0,0,h-1,w/2.7,1,Color(255, 255, 255,button02.alpha));
		draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 255, 255,button02.alpha), 0, 1);
	end;
	button02.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	button02.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("buttons/combine_button1.wav")
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Переключиться на камеру")
		net.WriteInt(2,10)
		net.SendToServer()
		
		Cam_Selector02()
	end
	button02.OnCursorExited = function(self)
		self.hovered = false
	end
end

function Cam_Selector02()
	
	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW()/2,ScrH()/1.2)
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame.startTime = SysTime()
	frame.Paint = function(self, w, h)

		draw.SimpleText("Выбор камеры:", "marske12", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Камера 02", "marske5", 0, 25+55, col_combine, 0, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
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
		draw.SimpleText("X", "marske4", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonClose.DoClick = function()
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Отключиться от визора")
		net.SendToServer()
	end
	
	local buttonBack = vgui.Create("DButton", frame)
	buttonBack:SetText("")
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
		draw.SimpleText("<", "marske5", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonBack.DoClick = function()
		Dispatch_Main()
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Отключиться от визора")
		net.SendToServer()
	end
	
	local button01 = vgui.Create("DButton")
	button01:SetSize(450, 25)
	button01:SetPos(0, 200)
	button01:SetText("")
	button01:SetFont( "marske4" )
	button01:SetParent(frame)
	button01.Text = "Предыдущая"
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
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button01.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button01.alpha), 0, 1);
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
		surface.PlaySound("buttons/combine_button1.wav")
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Переключиться на камеру")
		net.WriteInt(1,10)
		net.SendToServer()
		
		Cam_Selector01()
	end
	button01.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local button02 = vgui.Create("DButton")
	button02:SetSize(450, 25)
	button02:SetPos(ScrW()/4, 200)
	button02:SetText("")
	button02:SetFont( "marske4" )
	button02:SetParent(frame)
	button02.Text = "Следующая"
	local width, height = surface.GetTextSize(button02.Text)
	button02.hovered = false
	button02.disabled = false
	button02.alpha = 0
	button02.starttime = SysTime();
	button02.Paint = function(self, w, h)
		if (button02.starttime < SysTime()) then
			button02.alpha = button02.alpha or 0
			button02.alpha = Lerp(FrameTime(), button02.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,button02.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(145,145,145,button02.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button02.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button02.alpha), 0, 1);
			return;
		end
		
		draw.RoundedBox(0,0,h-1,w/2.7,1,Color(255, 255, 255,button02.alpha));
		draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 255, 255,button02.alpha), 0, 1);
	end;
	button02.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	button02.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("buttons/combine_button1.wav")
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Переключиться на камеру")
		net.WriteInt(3,10)
		net.SendToServer()
		
		Cam_Selector03()
	end
	button02.OnCursorExited = function(self)
		self.hovered = false
	end
end

function Cam_Selector03()
	
	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW()/2,ScrH()/1.2)
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame.startTime = SysTime()
	frame.Paint = function(self, w, h)

		draw.SimpleText("Выбор камеры:", "marske12", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Камера 03", "marske5", 0, 25+55, col_combine, 0, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
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
		draw.SimpleText("X", "marske4", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonClose.DoClick = function()
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Отключиться от визора")
		net.SendToServer()
	end
	
	local buttonBack = vgui.Create("DButton", frame)
	buttonBack:SetText("")
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
		draw.SimpleText("<", "marske5", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonBack.DoClick = function()
		Dispatch_Main()
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Отключиться от визора")
		net.SendToServer()
	end
	
	local button01 = vgui.Create("DButton")
	button01:SetSize(450, 25)
	button01:SetPos(0, 200)
	button01:SetText("")
	button01:SetFont( "marske4" )
	button01:SetParent(frame)
	button01.Text = "Предыдущая"
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
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button01.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button01.alpha), 0, 1);
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
		surface.PlaySound("buttons/combine_button1.wav")
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Переключиться на камеру")
		net.WriteInt(2,10)
		net.SendToServer()
		
		Cam_Selector02()
	end
	button01.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local button02 = vgui.Create("DButton")
	button02:SetSize(450, 25)
	button02:SetPos(ScrW()/4, 200)
	button02:SetText("")
	button02:SetFont( "marske4" )
	button02:SetParent(frame)
	button02.Text = "Следующая"
	local width, height = surface.GetTextSize(button02.Text)
	button02.hovered = false
	button02.disabled = false
	button02.alpha = 0
	button02.starttime = SysTime();
	button02.Paint = function(self, w, h)
		if (button02.starttime < SysTime()) then
			button02.alpha = button02.alpha or 0
			button02.alpha = Lerp(FrameTime(), button02.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-1,w,1,Color(145,145,145,button02.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(145,145,145,button02.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button02.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button02.alpha), 0, 1);
			return;
		end
		
		draw.RoundedBox(0,0,h-1,w/2.7,1,Color(255, 255, 255,button02.alpha));
		draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 255, 255,button02.alpha), 0, 1);
	end;
	button02.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	button02.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("buttons/combine_button1.wav")
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Переключиться на камеру")
		net.WriteInt(1,10)
		net.SendToServer()
		
		Cam_Selector01()
	end
	button02.OnCursorExited = function(self)
		self.hovered = false
	end
end

function City_Scanner()
	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW()/2,ScrH()/1.2)
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame.startTime = SysTime()
	frame.Paint = function(self, w, h)

		draw.SimpleText("Выбор камеры:", "marske12", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Камера 01", "marske5", 0, 25+55, col_combine, 0, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
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
		draw.SimpleText("X", "marske4", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonClose.DoClick = function()
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.SendToServer()
	end
	
	local buttonBack = vgui.Create("DButton", frame)
	buttonBack:SetText("")
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
		draw.SimpleText("<", "marske5", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonBack.DoClick = function()
		Dispatch_Main()
		frame:Close()
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Отключиться от визора")
		net.SendToServer()
	end
	
	local button01 = vgui.Create("DButton")
	button01:SetSize(450, 25)
	button01:SetPos(0, 200)
	button01:SetText("")
	button01:SetFont( "marske4" )
	button01:SetParent(frame)
	button01.Text = "Закрыть"
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
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,button01.alpha));
			draw.SimpleText(self.Text, "marske5", 0, h/2, Color(255, 165, 0,button01.alpha), 0, 1);
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
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Отключиться от визора")
		net.SendToServer()
	end
	button01.OnCursorExited = function(self)
		self.hovered = false
	end
end

function City_Forcefields(forcefields_db)

	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW()/2,ScrH()/1.2)
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame.startTime = SysTime()
	frame.Paint = function(self, w, h)
		draw.SimpleText("Силовые поля альянса", "marske12", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
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
		draw.SimpleText("X", "marske4", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonClose.DoClick = function()
		frame:Close()
	end
	
	local buttonBack = vgui.Create("DButton", frame)
	buttonBack:SetText("")
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
		draw.SimpleText("<", "marske5", w/2, h/2, Color(255,165,0), 1, 1)
	end
	buttonBack.DoClick = function()
		Dispatch_Main()
		frame:Close()
	end
	
	local scrollPanel = vgui.Create("DScrollPanel", frame)
	scrollPanel:SetPos(100, ScrH()/2 - (ScrH()/2.5))
	scrollPanel:SetSize(ScrW()/2, ScrH()/1.5)
	
	local sbar = scrollPanel:GetVBar()
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnUp:Paint(w, h)
	end
	function sbar.btnDown:Paint(w, h)
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(255, 165, 0, 15))
	end

	for k,v in pairs(forcefields_db) do

		local location = v["Location"]
		local index = v["Index"]
		local activated = v["Activated"]

		local frameRecord = scrollPanel:Add("DFrame")
		frameRecord:Dock( TOP )
		frameRecord:DockMargin( 0, 0, 0, 10 )
		frameRecord:SetSize(ScrW()/3, 100)
		frameRecord:SetTitle("")
		frameRecord:SetDraggable(false)
		frameRecord:ShowCloseButton(false)
		frameRecord.Paint = function(s, w, h)
			draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 75))
			draw.SimpleTextOutlined("Силовое поле - " .. location, "marske4", 15, 15, Color(255,255,255), 0, 0, 1, Color(255,165,0, 5))
			drawMultiLine("Индекс: " .. index .. " :://", "marske3", 450, 15, 25, 35, Color(255,255,255), 0, 0, 0, Color(255,165,0, 15))
		end

		local btn_field = frameRecord:Add("DButton")
		btn_field:DockMargin(25,250,0,0)
		btn_field:SetSize(175, 50)
		btn_field:SetPos(25, 50)
		btn_field:SetText("")
		btn_field:SetFont("marske4")
		btn_field.Text = activated and "Деактивировать" or "Активировать"
		local width, height = surface.GetTextSize(btn_field.Text)
		btn_field.hovered = false
		btn_field.disabled = false
		btn_field.alpha = 0
		btn_field.starttime = SysTime();
		btn_field.Paint = function(self, w, h)
			if (self.starttime < SysTime()) then
				self.alpha = self.alpha or 0
				self.alpha = Lerp(FrameTime(), self.alpha, 255)
			end
			
			if (self.disabled) then
				draw.RoundedBox(0,0,h-15,w/2,1,Color(145,145,145,self.alpha));
				draw.SimpleText(self.Text, "marske3", 0, h/2, Color(145,145,145,self.alpha), 0, 1);
				return;
			end
			if (self.hovered) then
				draw.RoundedBox(0,0,h-15,w/2,1,Color(255, 165, 0,self.alpha));
				draw.SimpleText(self.Text, "marske3", 0, h/2, Color(255, 165, 0,self.alpha), 0, 1);
				return;
			end

			draw.RoundedBox(0,0,h-15,w/4,1,Color(255, 255, 255,self.alpha));
			draw.SimpleText(self.Text, "marske3", 0, h/2, Color(255, 255, 255,self.alpha), 0, 1);
		end
		btn_field.OnCursorEntered = function(self)
			if (self.disabled) then return false end
			self.hovered = true
			surface.PlaySound("garrysmod/ui_hover.wav")
		end
		btn_field.OnMousePressed = function(self)
			if (self.disabled) then return false end
			surface.PlaySound("garrysmod/ui_click.wav")

			net.Start("DispatchTerminalServer")
			net.WriteString("Переключить силовое поле")
			net.WriteString(location)
			net.WriteInt(index, 10)
			net.WriteBool(!activated)
			net.SendToServer()

			activated = !activated
			self.Text = activated and "Деактивировать" or "Активировать"
		end
		btn_field.OnCursorExited = function(self)
			self.hovered = false
		end

		local btn_field_cam = frameRecord:Add("DButton")
		btn_field_cam:DockMargin(25,250,0,0)
		btn_field_cam:SetSize(100, 50)
		btn_field_cam:SetPos(200, 50)
		btn_field_cam:SetText("")
		btn_field_cam:SetFont("marske3")
		btn_field_cam.Text = "Камера"
		local width, height = surface.GetTextSize(btn_field_cam.Text)
		btn_field_cam.hovered = false
		btn_field_cam.disabled = false
		btn_field_cam.alpha = 0
		btn_field_cam.starttime = SysTime();
		btn_field_cam.Paint = function(self, w, h)
			if (self.starttime < SysTime()) then
				self.alpha = self.alpha or 0
				self.alpha = Lerp(FrameTime(), self.alpha, 255)
			end
			
			if (self.disabled) then
				draw.RoundedBox(0,0,h-15,w/2,1,Color(145,145,145,self.alpha));
				draw.SimpleText(self.Text, "marske3", 0, h/2, Color(145,145,145,self.alpha), 0, 1);
				return;
			end
			if (self.hovered) then
				draw.RoundedBox(0,0,h-15,w/2,1,Color(255, 165, 0,self.alpha));
				draw.SimpleText(self.Text, "marske3", 0, h/2, Color(255, 165, 0,self.alpha), 0, 1);
				return;
			end

			draw.RoundedBox(0,0,h-15,w/4,1,Color(255, 255, 255,self.alpha));
			draw.SimpleText(self.Text, "marske3", 0, h/2, Color(255, 255, 255,self.alpha), 0, 1);
		end
		btn_field_cam.OnCursorEntered = function(self)
			if (self.disabled) then return false end
			self.hovered = true
			surface.PlaySound("garrysmod/ui_hover.wav")
		end
		btn_field_cam.OnMousePressed = function(self)
			if (self.disabled) then return false end
			surface.PlaySound("garrysmod/ui_click.wav")
			frame:Close()
			
			net.Start("DispatchTerminalServer")
			net.WriteString("Открыть камеру")
			net.WriteString(location.."_"..index)
			net.WriteVector(v["Pos_01"])
			net.WriteAngle(v["Ang_01"])
			net.WriteString(location)
			net.WriteInt(index, 10)
			net.WriteBool(activated)
			net.SendToServer()
		end
		btn_field_cam.OnCursorExited = function(self)
			self.hovered = false
		end
	end
end

function City_Camera(cam_data, extra)

	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW(),ScrH())
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame.startTime = SysTime()
	frame.Paint = function(self, w, h)
		-- draw.SimpleText("Силовые поля альянса", "marske12", w/2, 0, Color(255, 255, 255, 255), 1, 2)
		-- draw.RoundedBox(0, w/2 - 150, 35, 300, 1, Color(255, 255, 255, 255));
	end

	local frameRecord = frame:Add("DFrame")
	frameRecord:SetSize(ScrW(), ScrH())
	frameRecord:SetTitle("")
	frameRecord:SetDraggable(false)
	frameRecord:ShowCloseButton(false)
	frameRecord.Paint = function(s, w, h)
		draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 75))
	end

	local cam_pos = cam_data.pos + cam_data.ang:Forward() * 3 + cam_data.ang:Right() * 7
	local cam_ang = cam_data.ang
	cam_ang:RotateAroundAxis(cam_ang:Up(), -75);

	local cameraFrame = frameRecord:Add("DFrame")
	cameraFrame:SetTitle('')
	cameraFrame:SetSize(ScrW(),ScrH())
	-- cameraFrame:SetPos(25,25)
	cameraFrame:SetDraggable(false)
	cameraFrame:ShowCloseButton(false)
	cameraFrame.camRT = GetRenderTarget("CityCameraRT" .. cam_data.id, 1024, 1024, false)
	cameraFrame.camMat = CreateMaterial("CityCameraRT" .. cam_data.id, "UnlitGeneric",{
		["$basetexture"] = cameraFrame.camRT:GetName(),
	})
	cameraFrame.Paint = function(s,w,h)
		surface.SetDrawColor(255, 255, 255)
		surface.SetMaterial(cameraFrame.camMat)
		surface.DrawTexturedRect(0, 0, w, h)
		draw.SimpleText(cam_data.id .. " ::||", 'marske3', 5, 5, Color(235,235,235), TEXT_ALIGN_LEFT)
		draw.SimpleText(os.date( "%H:%M:%S - %d/%m/%Y" , os.time() ), 'marske2', 5, 20, Color(235,235,235), TEXT_ALIGN_LEFT)
	end
	cameraFrame.Drawing = true
	cameraFrame.OnClose = function()
		cameraFrame.Drawing = false
		cameraFrame = nil
	end
	hook.Add("ShouldDrawLocalPlayer", cameraFrame, function()
		if cameraFrame.Drawing then
			return true
		end
	end)

	hook.Add("PreRender", "CityCameraRT" .. cam_data.id, function()
		if !IsValid(cameraFrame) then
			hook.Remove("PreRender", "CityCameraRT" .. cam_data.id)
			return
		end

		if (cameraFrame.NextDraw or 0) > CurTime() then return end
		cameraFrame.NextDraw = CurTime() + 1/25 -- 25 fps
		cameraFrame.Drawing = true

		local x, y = cameraFrame:LocalToScreen()

		render.PushRenderTarget(cameraFrame.camRT)
		cam.Start2D()
			render.Clear( 0, 0, 0, 0 )
			render.RenderView({
				origin = cam_pos,
				angles = cam_ang,
				fov = 80,
				x = 0, y = 0,
				w = ScrW(), h = ScrH()
			})
		cam.End2D()
		render.PopRenderTarget()

		cameraFrame.Drawing = nil
	end)
	
	local btn_field = frameRecord:Add("DButton")
	btn_field:DockMargin(25,250,0,0)
	btn_field:SetSize(175, 50)
	btn_field:SetPos(30, 45)
	btn_field:SetText("")
	btn_field:SetFont("marske4")
	btn_field.Text = extra.activated and "Деактивировать" or "Активировать"
	local width, height = surface.GetTextSize(btn_field.Text)
	btn_field.hovered = false
	btn_field.disabled = false
	btn_field.alpha = 0
	btn_field.starttime = SysTime();
	btn_field.Paint = function(self, w, h)
		if (self.starttime < SysTime()) then
			self.alpha = self.alpha or 0
			self.alpha = Lerp(FrameTime(), self.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-15,w/2,1,Color(145,145,145,self.alpha));
			draw.SimpleText(self.Text, "marske3", 0, h/2, Color(145,145,145,self.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-15,w/2,1,Color(255, 165, 0,self.alpha));
			draw.SimpleText(self.Text, "marske3", 0, h/2, Color(255, 165, 0,self.alpha), 0, 1);
			return;
		end

		draw.RoundedBox(0,0,h-15,w/4,1,Color(255, 255, 255,self.alpha));
		draw.SimpleText(self.Text, "marske3", 0, h/2, Color(255, 255, 255,self.alpha), 0, 1);
	end
	btn_field.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	btn_field.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		
		net.Start("DispatchTerminalServer")
		net.WriteString("Переключить силовое поле")
		net.WriteString(extra.location)
		net.WriteInt(extra.index, 10)
		net.WriteBool(!extra.activated)
		net.SendToServer()

		extra.activated = !extra.activated
		self.Text = extra.activated and "Деактивировать" or "Активировать"
	end
	btn_field.OnCursorExited = function(self)
		self.hovered = false
	end
	
	local btn_back = frameRecord:Add("DButton")
	btn_back:SetSize(175, 50)
	btn_back:SetPos(175, 45)
	btn_back:SetText("")
	btn_back:SetFont("marske4")
	btn_back.Text = "Назад"
	local width, height = surface.GetTextSize(btn_back.Text)
	btn_back.hovered = false
	btn_back.disabled = false
	btn_back.alpha = 0
	btn_back.starttime = SysTime();
	btn_back.Paint = function(self, w, h)
		if (self.starttime < SysTime()) then
			self.alpha = self.alpha or 0
			self.alpha = Lerp(FrameTime(), self.alpha, 255)
		end
		
		if (self.disabled) then
			draw.RoundedBox(0,0,h-15,w/2,1,Color(145,145,145,self.alpha));
			draw.SimpleText(self.Text, "marske3", 0, h/2, Color(145,145,145,self.alpha), 0, 1);
			return;
		end
		if (self.hovered) then
			draw.RoundedBox(0,0,h-15,w/2,1,Color(255, 165, 0,self.alpha));
			draw.SimpleText(self.Text, "marske3", 0, h/2, Color(255, 165, 0,self.alpha), 0, 1);
			return;
		end

		draw.RoundedBox(0,0,h-15,w/4,1,Color(255, 255, 255,self.alpha));
		draw.SimpleText(self.Text, "marske3", 0, h/2, Color(255, 255, 255,self.alpha), 0, 1);
	end
	btn_back.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	btn_back.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")

		frame:Close()

		net.Start("DispatchTerminalServer")
		net.WriteString("Получить силовые поля")
		net.SendToServer()

		net.Start("DispatchTerminalServer")
		net.WriteString("Домой")
		net.SendToServer()
	end
	btn_back.OnCursorExited = function(self)
		self.hovered = false
	end
end