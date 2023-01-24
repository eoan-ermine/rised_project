-- "addons\\rised_config\\lua\\autorun\\client\\rc_config_client.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local x_size = ScrW()/2 - (ScrW()/4)
local config

net.Receive("Rised_Config:Client_OpenMenu", function()
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
		Derma_DrawBackgroundBlur(self, self.startTime)
		draw.RoundedBox(2, 0, 0, w, h, Color(10, 10, 10, 75));

		draw.SimpleText("Конфигурация сервера", "marske8", w/2, 100, Color(255, 255, 255, 255), 1, 1)
		draw.RoundedBox(0, w/2 - 150, 125, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Главное меню", "marske6", w/2, 145, Color(255, 255, 255, 255), 1, 1)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(ScrW()/1.5 - 25, 100)
	buttonClose.Paint = function(me, w, h)
		draw.SimpleText("X", "marske5", w/2-6, h/2-8, Color(255,255,255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER)
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

	local DScrollPanel = vgui.Create("DScrollPanel", frame)
	DScrollPanel:SetPos(ScrW()/2 - (ScrW()/4), ScrH()/1.8 - (ScrH()/2.5))
	DScrollPanel:SetSize(ScrW()/2, ScrH()/1.5)
	
	local sbar = DScrollPanel:GetVBar()
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
	end

	local buttonTutorial = DScrollPanel:Add("DButton")
	buttonTutorial:SetSize(250, 50)
	buttonTutorial:Dock(4)
	buttonTutorial:DockMargin(0,50,0,0)
	buttonTutorial:SetText("")
	buttonTutorial:SetFont("marske4")
	buttonTutorial.Text = "Обучение"
	local width, height = surface.GetTextSize(buttonTutorial.Text)
	buttonTutorial.hovered = false
	buttonTutorial.disabled = false
	buttonTutorial.alpha = 0
	buttonTutorial.starttime = SysTime();
	buttonTutorial.Paint = function(self, w, h)
		if (buttonTutorial.starttime < SysTime()) then
			buttonTutorial.alpha = buttonTutorial.alpha or 0
			buttonTutorial.alpha = Lerp(FrameTime(), buttonTutorial.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonTutorial.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonTutorial.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonTutorial.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonTutorial.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonTutorial.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonTutorial.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		net.Start("Rised_Config:Server")
		net.WriteString("open_config")
		net.WriteString("Tutorial")
		net.WriteBool(true)
		net.SendToServer()
	end
	buttonTutorial.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonEconomy = DScrollPanel:Add("DButton")
	buttonEconomy:SetSize(250, 50)
	buttonEconomy:Dock(4)
	buttonEconomy:DockMargin(0,50,0,0)
	buttonEconomy:SetText("")
	buttonEconomy:SetFont("marske4")
	buttonEconomy.Text = "Экономика"
	local width, height = surface.GetTextSize(buttonEconomy.Text)
	buttonEconomy.hovered = false
	buttonEconomy.disabled = false
	buttonEconomy.alpha = 0
	buttonEconomy.starttime = SysTime();
	buttonEconomy.Paint = function(self, w, h)
		if (buttonEconomy.starttime < SysTime()) then
			buttonEconomy.alpha = buttonEconomy.alpha or 0
			buttonEconomy.alpha = Lerp(FrameTime(), buttonEconomy.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonEconomy.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonEconomy.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonEconomy.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonEconomy.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonEconomy.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonEconomy.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		net.Start("Rised_Config:Server")
		net.WriteString("open_config")
		net.WriteString("Economy")
		net.WriteBool(false)
		net.SendToServer()
	end
	buttonEconomy.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonTrade = DScrollPanel:Add("DButton")
	buttonTrade:SetSize(250, 50)
	buttonTrade:Dock(4)
	buttonTrade:DockMargin(0,50,0,0)
	buttonTrade:SetText("")
	buttonTrade:SetFont("marske4")
	buttonTrade.Text = "Торговля"
	local width, height = surface.GetTextSize(buttonTrade.Text)
	buttonTrade.hovered = false
	buttonTrade.disabled = false
	buttonTrade.alpha = 0
	buttonTrade.starttime = SysTime();
	buttonTrade.Paint = function(self, w, h)
		if (buttonTrade.starttime < SysTime()) then
			buttonTrade.alpha = buttonTrade.alpha or 0
			buttonTrade.alpha = Lerp(FrameTime(), buttonTrade.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonTrade.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonTrade.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonTrade.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonTrade.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonTrade.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonTrade.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		net.Start("Rised_Config:Server")
		net.WriteString("open_config")
		net.WriteString("Trade")
		net.WriteBool(true)
		net.SendToServer()
	end
	buttonTrade.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonFood = DScrollPanel:Add("DButton")
	buttonFood:SetSize(250, 50)
	buttonFood:Dock(4)
	buttonFood:DockMargin(0,50,0,0)
	buttonFood:SetText("")
	buttonFood:SetFont("marske4")
	buttonFood.Text = "Еда"
	local width, height = surface.GetTextSize(buttonFood.Text)
	buttonFood.hovered = false
	buttonFood.disabled = false
	buttonFood.alpha = 0
	buttonFood.starttime = SysTime();
	buttonFood.Paint = function(self, w, h)
		if (buttonFood.starttime < SysTime()) then
			buttonFood.alpha = buttonFood.alpha or 0
			buttonFood.alpha = Lerp(FrameTime(), buttonFood.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonFood.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonFood.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonFood.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonFood.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonFood.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonFood.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		net.Start("Rised_Config:Server")
		net.WriteString("open_config")
		net.WriteString("Food")
		net.WriteBool(false)
		net.SendToServer()
	end
	buttonFood.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonWeapons = DScrollPanel:Add("DButton")
	buttonWeapons:SetSize(250, 50)
	buttonWeapons:Dock(4)
	buttonWeapons:DockMargin(0,50,0,0)
	buttonWeapons:SetText("")
	buttonWeapons:SetFont("marske4")
	buttonWeapons.Text = "Оружие"
	local width, height = surface.GetTextSize(buttonWeapons.Text)
	buttonWeapons.hovered = false
	buttonWeapons.disabled = false
	buttonWeapons.alpha = 0
	buttonWeapons.starttime = SysTime();
	buttonWeapons.Paint = function(self, w, h)
		if (buttonWeapons.starttime < SysTime()) then
			buttonWeapons.alpha = buttonWeapons.alpha or 0
			buttonWeapons.alpha = Lerp(FrameTime(), buttonWeapons.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonWeapons.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonWeapons.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonWeapons.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonWeapons.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonWeapons.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonWeapons.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		net.Start("Rised_Config:Server")
		net.WriteString("open_config")
		net.WriteString("Weapons")
		net.WriteBool(true)
		net.SendToServer()
	end
	buttonWeapons.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonApartments = DScrollPanel:Add("DButton")
	buttonApartments:SetSize(250, 50)
	buttonApartments:Dock(4)
	buttonApartments:DockMargin(0,50,0,0)
	buttonApartments:SetText("")
	buttonApartments:SetFont("marske4")
	buttonApartments.Text = "Квартиры"
	local width, height = surface.GetTextSize(buttonApartments.Text)
	buttonApartments.hovered = false
	buttonApartments.disabled = false
	buttonApartments.alpha = 0
	buttonApartments.starttime = SysTime();
	buttonApartments.Paint = function(self, w, h)
		if (buttonApartments.starttime < SysTime()) then
			buttonApartments.alpha = buttonApartments.alpha or 0
			buttonApartments.alpha = Lerp(FrameTime(), buttonApartments.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonApartments.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonApartments.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonApartments.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonApartments.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonApartments.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonApartments.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		net.Start("Rised_Config:Server")
		net.WriteString("open_config")
		net.WriteString("Apartments")
		net.WriteBool(false)
		net.SendToServer()
	end
	buttonApartments.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonHistory = DScrollPanel:Add("DButton")
	buttonHistory:SetSize(250, 50)
	buttonHistory:Dock(4)
	buttonHistory:DockMargin(0,50,0,0)
	buttonHistory:SetText("")
	buttonHistory:SetFont("marske4")
	buttonHistory.Text = "Истории"
	local width, height = surface.GetTextSize(buttonHistory.Text)
	buttonHistory.hovered = false
	buttonHistory.disabled = false
	buttonHistory.alpha = 0
	buttonHistory.starttime = SysTime();
	buttonHistory.Paint = function(self, w, h)
		if (buttonHistory.starttime < SysTime()) then
			buttonHistory.alpha = buttonHistory.alpha or 0
			buttonHistory.alpha = Lerp(FrameTime(), buttonHistory.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonHistory.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonHistory.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonHistory.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonHistory.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonHistory.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonHistory.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		net.Start("Rised_Config:Server")
		net.WriteString("open_config")
		net.WriteString("History")
		net.WriteBool(true)
		net.SendToServer()
	end
	buttonHistory.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonLoot = DScrollPanel:Add("DButton")
	buttonLoot:SetSize(250, 50)
	buttonLoot:Dock(4)
	buttonLoot:DockMargin(0,50,0,0)
	buttonLoot:SetText("")
	buttonLoot:SetFont("marske4")
	buttonLoot.Text = "Лут"
	local width, height = surface.GetTextSize(buttonLoot.Text)
	buttonLoot.hovered = false
	buttonLoot.disabled = false
	buttonLoot.alpha = 0
	buttonLoot.starttime = SysTime();
	buttonLoot.Paint = function(self, w, h)
		if (buttonLoot.starttime < SysTime()) then
			buttonLoot.alpha = buttonLoot.alpha or 0
			buttonLoot.alpha = Lerp(FrameTime(), buttonLoot.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonLoot.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonLoot.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonLoot.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonLoot.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonLoot.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonLoot.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		net.Start("Rised_Config:Server")
		net.WriteString("open_config")
		net.WriteString("Loot")
		net.WriteBool(false)
		net.SendToServer()
	end
	buttonLoot.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonRecycler = DScrollPanel:Add("DButton")
	buttonRecycler:SetSize(250, 50)
	buttonRecycler:Dock(4)
	buttonRecycler:DockMargin(0,50,0,0)
	buttonRecycler:SetText("")
	buttonRecycler:SetFont("marske4")
	buttonRecycler.Text = "Переработчик"
	local width, height = surface.GetTextSize(buttonRecycler.Text)
	buttonRecycler.hovered = false
	buttonRecycler.disabled = false
	buttonRecycler.alpha = 0
	buttonRecycler.starttime = SysTime();
	buttonRecycler.Paint = function(self, w, h)
		if (buttonRecycler.starttime < SysTime()) then
			buttonRecycler.alpha = buttonRecycler.alpha or 0
			buttonRecycler.alpha = Lerp(FrameTime(), buttonRecycler.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonRecycler.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonRecycler.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonRecycler.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonRecycler.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonRecycler.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonRecycler.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		net.Start("Rised_Config:Server")
		net.WriteString("open_config")
		net.WriteString("CraftMachineItems")
		net.WriteBool(false)
		net.SendToServer()
	end
	buttonRecycler.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonMusic = DScrollPanel:Add("DButton")
	buttonMusic:SetSize(250, 50)
	buttonMusic:Dock(4)
	buttonMusic:DockMargin(0,50,0,0)
	buttonMusic:SetText("")
	buttonMusic:SetFont("marske4")
	buttonMusic.Text = "Музыка"
	local width, height = surface.GetTextSize(buttonMusic.Text)
	buttonMusic.hovered = false
	buttonMusic.disabled = false
	buttonMusic.alpha = 0
	buttonMusic.starttime = SysTime();
	buttonMusic.Paint = function(self, w, h)
		if (buttonMusic.starttime < SysTime()) then
			buttonMusic.alpha = buttonMusic.alpha or 0
			buttonMusic.alpha = Lerp(FrameTime(), buttonMusic.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonMusic.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonMusic.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonMusic.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonMusic.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonMusic.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonMusic.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		net.Start("Rised_Config:Server")
		net.WriteString("open_config")
		net.WriteString("Music")
		net.WriteBool(true)
		net.SendToServer()
	end
	buttonMusic.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonBackup = vgui.Create("DButton", frame)
	buttonBackup:SetSize(250, 50)
	buttonBackup:SetPos(ScrW()/2 - 125, ScrH() - 100)
	buttonBackup:SetText("")
	buttonBackup:SetFont("marske3")
	buttonBackup.Text = "Бэкап всех конфигов"
	local width, height = surface.GetTextSize(buttonBackup.Text)
	buttonBackup.hovered = false
	buttonBackup.disabled = false
	buttonBackup.alpha = 0
	buttonBackup.starttime = SysTime();
	buttonBackup.Paint = function(self, w, h)
		if (buttonBackup.starttime < SysTime()) then
			buttonBackup.alpha = buttonBackup.alpha or 0
			buttonBackup.alpha = Lerp(FrameTime(), buttonBackup.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonBackup.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonBackup.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonBackup.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonBackup.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonBackup.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonBackup.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")

		net.Start("Rised_Config:Server")
		net.WriteString("backup_all_configs")
		net.SendToServer()
	end
	buttonBackup.OnCursorExited = function(self)
		self.hovered = false
	end
end)

net.Receive("Rised_Config:Client_SaveConfig", function()
	local netlenth = net.ReadInt(32)
	local configRaw = net.ReadData(netlenth)
	local configJSON = util.Decompress(configRaw)
	local config = util.JSONToTable(configJSON) or {}

	RISED.Config = config
end)

net.Receive("Rised_Config:Client_OpenConfig", function()
	local netlenth = net.ReadInt(32)
	local configRaw = net.ReadData(netlenth)
	local configJSON = util.Decompress(configRaw)
	local config = util.JSONToTable(configJSON) or {}

	local config_type = net.ReadString()
	local config_folders = net.ReadBool()

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
		Derma_DrawBackgroundBlur(self, self.startTime)
		draw.RoundedBox(2, 0, 0, w, h, Color(10, 10, 10, 75));

		draw.SimpleText("Конфигурация сервера", "marske8", w/2, 100, Color(255, 255, 255, 255), 1, 1)
		draw.RoundedBox(0, w/2 - 150, 125, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText(config_type, "marske6", w/2, 145, Color(255, 255, 255, 255), 1, 1)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(ScrW()/1.5 - 25, 100)
	buttonClose.Paint = function(me, w, h)
		draw.SimpleText("X", "marske5", w/2-6, h/2-8, Color(255,255,255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER)
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
	buttonBack:SetSize(250, 50)
	buttonBack:SetPos(ScrW()/2 - 300, ScrH() - 100)
	buttonBack:SetText("")
	buttonBack:SetFont("marske4")
	buttonBack.Text = "Назад"
	local width, height = surface.GetTextSize(buttonBack.Text)
	buttonBack.hovered = false
	buttonBack.disabled = false
	buttonBack.alpha = 0
	buttonBack.starttime = SysTime();
	buttonBack.Paint = function(self, w, h)
		if (buttonBack.starttime < SysTime()) then
			buttonBack.alpha = buttonBack.alpha or 0
			buttonBack.alpha = Lerp(FrameTime(), buttonBack.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonBack.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonBack.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonBack.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonBack.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonBack.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonBack.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		net.Start("Rised_Config:Server")
		net.WriteString("open_menu")
		net.SendToServer()
	end
	buttonBack.OnCursorExited = function(self)
		self.hovered = false
	end

	local DScrollPanel = vgui.Create("DScrollPanel", frame)
	DScrollPanel:SetPos(ScrW()/2 - (ScrW()/4), ScrH()/1.8 - (ScrH()/2.5))
	DScrollPanel:SetSize(ScrW()/2, ScrH()/1.5)
	
	local sbar = DScrollPanel:GetVBar()
	function sbar:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 100))
	end

	if config_folders then
		for k,v in pairs(config) do
			local btn_type = DScrollPanel:Add("DButton")
			btn_type:SetSize(250, 50)
			btn_type:Dock(4)
			btn_type:DockMargin(0,50,0,0)
			btn_type:SetText("")
			btn_type:SetFont("marske4")
			btn_type.Text = k
			local width, height = surface.GetTextSize(btn_type.Text)
			btn_type.hovered = false
			btn_type.disabled = false
			btn_type.alpha = 0
			btn_type.starttime = SysTime();
			btn_type.Paint = function(self, w, h)
				if (btn_type.starttime < SysTime()) then
					btn_type.alpha = btn_type.alpha or 0
					btn_type.alpha = Lerp(FrameTime(), btn_type.alpha, 255)
				end
				
				if (self.disabled) then
					draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, btn_type.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					return
				end

				if (self.hovered) then
					draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,btn_type.alpha))
					draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
					draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, btn_type.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
					return
				end
				
				draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
				draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
				draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, btn_type.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			btn_type.OnCursorEntered = function(self)
				if (self.disabled) then return false end
				self.hovered = true
				surface.PlaySound("garrysmod/ui_hover.wav")
			end
			btn_type.OnMousePressed = function(self)
				if (self.disabled) then return false end
				surface.PlaySound("garrysmod/ui_click.wav")
				frame:Close()
				
				if config_type == "Tutorial" && k == "Menu" then
					RisedConfig_TutorialMenuEdit(config, config[k], k, config_folders, config_type)
				else
					RisedConfig_OpenConfigEdit(config, config[k], k, config_folders, config_type)
				end
			end
			btn_type.OnCursorExited = function(self)
				self.hovered = false
			end
		end
	else
		frame:Close()
		RisedConfig_OpenConfigEdit(config, config, config_type, config_folders, config_type)
	end
end)

function RisedConfig_OpenConfigEdit(config_all, config, title, folders, mainfolder)

	local config_text = util.TableToJSON(config, true)

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
		Derma_DrawBackgroundBlur(self, self.startTime)
		draw.RoundedBox(2, 0, 0, w, h, Color(10, 10, 10, 75));

		draw.SimpleText("Конфигурация сервера", "marske8", w/2, 100, Color(255, 255, 255, 255), 1, 1)
		draw.RoundedBox(0, w/2 - 150, 125, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText(title, "marske6", w/2, 145, Color(255, 255, 255, 255), 1, 1)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(ScrW()/1.5 - 25, 100)
	buttonClose.Paint = function(me, w, h)
		draw.SimpleText("X", "marske5", w/2-6, h/2-8, Color(255,255,255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER)
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
	buttonBack:SetSize(250, 50)
	buttonBack:SetPos(ScrW()/2 - 375, ScrH() - 100)
	buttonBack:SetText("")
	buttonBack:SetFont("marske4")
	buttonBack.Text = "Назад"
	local width, height = surface.GetTextSize(buttonBack.Text)
	buttonBack.hovered = false
	buttonBack.disabled = false
	buttonBack.alpha = 0
	buttonBack.starttime = SysTime();
	buttonBack.Paint = function(self, w, h)
		if (buttonBack.starttime < SysTime()) then
			buttonBack.alpha = buttonBack.alpha or 0
			buttonBack.alpha = Lerp(FrameTime(), buttonBack.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonBack.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonBack.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonBack.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonBack.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonBack.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonBack.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		if folders then
			net.Start("Rised_Config:Server")
			net.WriteString("open_config")
			net.WriteString(mainfolder)
			net.WriteBool(true)
			net.SendToServer()
		else
			net.Start("Rised_Config:Server")
			net.WriteString("open_menu")
			net.SendToServer()
		end
	end
	buttonBack.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonBackup = vgui.Create("DButton", frame)
	buttonBackup:SetSize(125, 50)
	buttonBackup:SetPos(ScrW()/2 - 15, ScrH() - 100)
	buttonBackup:SetText("")
	buttonBackup:SetFont("marske3")
	buttonBackup.Text = "Бэкап"
	local width, height = surface.GetTextSize(buttonBackup.Text)
	buttonBackup.hovered = false
	buttonBackup.disabled = false
	buttonBackup.alpha = 0
	buttonBackup.starttime = SysTime();
	buttonBackup.Paint = function(self, w, h)
		if (buttonBackup.starttime < SysTime()) then
			buttonBackup.alpha = buttonBackup.alpha or 0
			buttonBackup.alpha = Lerp(FrameTime(), buttonBackup.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonBackup.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonBackup.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonBackup.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonBackup.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonBackup.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonBackup.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")

		config_all[title] = util.JSONToTable(config_text)
		
		local configJSON = util.TableToJSON(config_all, true)
		local binary = util.Compress(configJSON, true)
		net.Start("Rised_Config:Server")
		net.WriteString("backup_config")
		net.WriteString(mainfolder)
		net.WriteInt(#binary, 32)
		net.WriteData(binary, #binary)
		net.SendToServer()
	end
	buttonBackup.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonSave = vgui.Create("DButton", frame)
	buttonSave:SetSize(250, 50)
	buttonSave:SetPos(ScrW()/2 + 125, ScrH() - 100)
	buttonSave:SetText("")
	buttonSave:SetFont("marske4")
	buttonSave.Text = "Сохранить"
	local width, height = surface.GetTextSize(buttonSave.Text)
	buttonSave.hovered = false
	buttonSave.disabled = false
	buttonSave.alpha = 0
	buttonSave.starttime = SysTime();
	buttonSave.Paint = function(self, w, h)
		if (buttonSave.starttime < SysTime()) then
			buttonSave.alpha = buttonSave.alpha or 0
			buttonSave.alpha = Lerp(FrameTime(), buttonSave.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonSave.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonSave.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonSave.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonSave.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonSave.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonSave.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")

		config_all[title] = util.JSONToTable(config_text)
		
		local configJSON = util.TableToJSON(config_all, true)
		local binary = util.Compress(configJSON, true)
		net.Start("Rised_Config:Server")
		net.WriteString("save_config")
		net.WriteString(mainfolder)
		net.WriteInt(#binary, 32)
		net.WriteData(binary, #binary)
		net.SendToServer()
	end
	buttonSave.OnCursorExited = function(self)
		self.hovered = false
	end

	local configInput = vgui.Create("DTextEntry", frame)
	configInput:SetPos(ScrW()/2 - (ScrW()/4), ScrH()/1.8 - (ScrH()/2.5))
	configInput:SetSize(ScrW()/2, ScrH()/1.5)
	configInput:SetValue(config_text)
	configInput:SetMultiline(true)
	configInput:SetTabbingDisabled(true)
	configInput:SetPaintBackground(false)
	configInput:SetTabbingDisabled(false)
	configInput:SetVerticalScrollbarEnabled(true)
	configInput:SetTextColor(Color(255,195,0))
	configInput.OnChange = function(self)
		config_text = self:GetValue()
	end
end

function RisedConfig_TutorialMenuEdit(config_all, config, title, folders, mainfolder)

	local config_text = util.TableToJSON(config, true)

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
		Derma_DrawBackgroundBlur(self, self.startTime)
		draw.RoundedBox(2, 0, 0, w, h, Color(10, 10, 10, 75));

		draw.SimpleText("Конфигурация сервера", "marske8", w/2, 100, Color(255, 255, 255, 255), 1, 1)
		draw.RoundedBox(0, w/2 - 150, 125, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText(title, "marske6", w/2, 145, Color(255, 255, 255, 255), 1, 1)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(ScrW()/1.5 - 25, 100)
	buttonClose.Paint = function(me, w, h)
		draw.SimpleText("X", "marske5", w/2-6, h/2-8, Color(255,255,255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER)
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
	buttonBack:SetSize(250, 50)
	buttonBack:SetPos(ScrW()/2 - 375, ScrH() - 100)
	buttonBack:SetText("")
	buttonBack:SetFont("marske4")
	buttonBack.Text = "Назад"
	local width, height = surface.GetTextSize(buttonBack.Text)
	buttonBack.hovered = false
	buttonBack.disabled = false
	buttonBack.alpha = 0
	buttonBack.starttime = SysTime();
	buttonBack.Paint = function(self, w, h)
		if (buttonBack.starttime < SysTime()) then
			buttonBack.alpha = buttonBack.alpha or 0
			buttonBack.alpha = Lerp(FrameTime(), buttonBack.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonBack.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonBack.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonBack.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonBack.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonBack.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonBack.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		if folders then
			net.Start("Rised_Config:Server")
			net.WriteString("open_config")
			net.WriteString(mainfolder)
			net.WriteBool(true)
			net.SendToServer()
		else
			net.Start("Rised_Config:Server")
			net.WriteString("open_menu")
			net.SendToServer()
		end
	end
	buttonBack.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonBackup = vgui.Create("DButton", frame)
	buttonBackup:SetSize(125, 50)
	buttonBackup:SetPos(ScrW()/2 - 15, ScrH() - 100)
	buttonBackup:SetText("")
	buttonBackup:SetFont("marske3")
	buttonBackup.Text = "Бэкап"
	local width, height = surface.GetTextSize(buttonBackup.Text)
	buttonBackup.hovered = false
	buttonBackup.disabled = false
	buttonBackup.alpha = 0
	buttonBackup.starttime = SysTime();
	buttonBackup.Paint = function(self, w, h)
		if (buttonBackup.starttime < SysTime()) then
			buttonBackup.alpha = buttonBackup.alpha or 0
			buttonBackup.alpha = Lerp(FrameTime(), buttonBackup.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonBackup.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonBackup.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonBackup.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonBackup.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonBackup.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonBackup.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")

		config_all[title] = config
		
		local configJSON = util.TableToJSON(config_all, true)
		local binary = util.Compress(configJSON, true)
		net.Start("Rised_Config:Server")
		net.WriteString("backup_config")
		net.WriteString(mainfolder)
		net.WriteInt(#binary, 32)
		net.WriteData(binary, #binary)
		net.SendToServer()
	end
	buttonBackup.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonSave = vgui.Create("DButton", frame)
	buttonSave:SetSize(250, 50)
	buttonSave:SetPos(ScrW()/2 + 125, ScrH() - 100)
	buttonSave:SetText("")
	buttonSave:SetFont("marske4")
	buttonSave.Text = "Сохранить"
	local width, height = surface.GetTextSize(buttonSave.Text)
	buttonSave.hovered = false
	buttonSave.disabled = false
	buttonSave.alpha = 0
	buttonSave.starttime = SysTime();
	buttonSave.Paint = function(self, w, h)
		if (buttonSave.starttime < SysTime()) then
			buttonSave.alpha = buttonSave.alpha or 0
			buttonSave.alpha = Lerp(FrameTime(), buttonSave.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonSave.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonSave.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonSave.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonSave.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonSave.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonSave.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")

		config_all[title] = config
		
		local configJSON = util.TableToJSON(config_all, true)
		local binary = util.Compress(configJSON, true)
		net.Start("Rised_Config:Server")
		net.WriteString("save_config")
		net.WriteString(mainfolder)
		net.WriteInt(#binary, 32)
		net.WriteData(binary, #binary)
		net.SendToServer()
	end
	buttonSave.OnCursorExited = function(self)
		self.hovered = false
	end

	local config_panel = vgui.Create( "DPanel", frame )
	config_panel:SetPos(x_size, ScrH()/1.8 - (ScrH()/2.5))
	config_panel:SetSize(ScrW()/2, ScrH()/1.5)
	config_panel.Paint = function(self, w, h)
	end

	local dScrollPanel = vgui.Create( "DScrollPanel", config_panel )
	dScrollPanel:Dock( FILL )
	local sbar = dScrollPanel:GetVBar()
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
	
	local folders = {}
	for k_main,v in pairs(config) do
		local title_edit = dScrollPanel:Add("DTextEntry")
		title_edit:Dock(TOP)
		title_edit:DockMargin( 50, 0, 0, 0 )
		title_edit:SetValue(k_main)
		title_edit:SetFont("marske4")
		title_edit:SetMultiline(true)
		title_edit:SetTabbingDisabled(true)
		title_edit:SetPaintBackground(false)
		title_edit:SetTabbingDisabled(false)
		title_edit:SetTextColor(Color(255,255,255))
		title_edit.OnChange = function(self)
			config[self:GetValue()] = config[k_main]
			config[k_main] = nil
			k_main = self:GetValue()
		end

		if istable(v) then
			for k_sub,j in pairs(v) do
				local edit = dScrollPanel:Add("DTextEntry")
				edit:Dock(TOP)
				edit:DockMargin( 100, 15, 0, 0 )
				edit:SetValue(k_sub)
				edit:SetFont("marske3")
				edit:SetMultiline(true)
				edit:SetTabbingDisabled(true)
				edit:SetPaintBackground(false)
				edit:SetTabbingDisabled(false)
				edit:SetTextColor(Color(255,255,255))
				edit.OnChange = function(self)
					config[k_main][self:GetValue()] = config[k_main][k_sub]
					config[k_main][k_sub] = nil
					k_sub = self:GetValue()
				end

				if istable(j) then
					for k_ssub,c in pairs(j) do
						local edit = dScrollPanel:Add("DTextEntry")
						edit:Dock(TOP)
						edit:DockMargin( 150, 15, 0, 0 )
						edit:SetValue(k_ssub)
						edit:SetFont("marske3")
						edit:SetMultiline(true)
						edit:SetTabbingDisabled(true)
						edit:SetPaintBackground(false)
						edit:SetTabbingDisabled(false)
						edit:SetTextColor(Color(255,255,255))
						edit.OnChange = function(self)
							config[k_main][k_sub][self:GetValue()] = config[k_main][k_sub][k_ssub]
							config[k_main][k_sub][k_ssub] = nil
							k_ssub = self:GetValue()
						end
						if istable(с) then
						else
							local extra_data = {}
							extra_data.config_all = config_all
							extra_data.config = config
							extra_data.title = title
							extra_data.folders = folders
							extra_data.mainfolder = mainfolder

							local keys = {k_main, k_sub, k_ssub}
							GenerateConfigEditor(frame, dScrollPanel, c, keys, extra_data, 175)
						end
					end
				else
					local extra_data = {}
					extra_data.config_all = config_all
					extra_data.config = config
					extra_data.title = title
					extra_data.folders = folders
					extra_data.mainfolder = mainfolder

					local keys = {k_main, k_sub}
					GenerateConfigEditor(frame, dScrollPanel, j, keys, extra_data, 125)
				end
				
				local btn_add_main = dScrollPanel:Add("DButton")
				btn_add_main:SetSize(250, 25)
				btn_add_main:DockMargin( 100, 25, 0, 0 )
				btn_add_main:Dock(TOP)
				btn_add_main:SetText("")
				btn_add_main.Paint = function(me, w, h)
					draw.SimpleText("Добавить подраздел", "marske3", w/2-30, h/2-5, Color(255,255,255), TEXT_ALIGHT_CENTER, TEXT_ALIGHT_CENTER)
					draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
					if (me.Hovered) then
						draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
					end

					if (me:IsDown()) then
						draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
					end
				end
				btn_add_main.DoClick = function()

					config[k_main]["Новый подраздел"] = {}
					config[k_main]["Новый подраздел"] = ""

					frame:Close()
					RisedConfig_TutorialMenuEdit(config_all, config, title, folders, mainfolder)
				end

				local btn_add_delete = dScrollPanel:Add("DButton")
				btn_add_delete:SetSize(250, 25)
				btn_add_delete:DockMargin( 100, 5, 0, 50 )
				btn_add_delete:Dock(TOP)
				btn_add_delete:SetText("")
				btn_add_delete.Paint = function(me, w, h)
					draw.SimpleText("Удалить подраздел", "marske3", w/2-30, h/2-5, Color(255,255,255), TEXT_ALIGHT_CENTER, TEXT_ALIGHT_CENTER)
					draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
					if (me.Hovered) then
						draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
					end

					if (me:IsDown()) then
						draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
					end
				end
				btn_add_delete.DoClick = function()
					if #table.GetKeys(config[k_main]) <= 1 then return end
					config[k_main][k_sub] = nil
					frame:Close()
					RisedConfig_TutorialMenuEdit(config_all, config, title, folders, mainfolder)
				end
			end

			local btn_add_main = dScrollPanel:Add("DButton")
			btn_add_main:SetSize(250, 50)
			btn_add_main:DockMargin( 50, 0, 0, 0 )
			btn_add_main:Dock(TOP)
			btn_add_main:SetText("")
			btn_add_main.Paint = function(me, w, h)
				draw.SimpleText("Добавить раздел", "marske3", w/2-30, h/2-5, Color(255,255,255), TEXT_ALIGHT_CENTER, TEXT_ALIGHT_CENTER)
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
				if (me.Hovered) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
				end

				if (me:IsDown()) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
				end
			end
			btn_add_main.DoClick = function()

				config["Новый раздел"] = {}
				config["Новый раздел"]["Новый подраздел"] = ""

				frame:Close()
				RisedConfig_TutorialMenuEdit(config_all, config, title, folders, mainfolder)
			end

			local btn_add_delete = dScrollPanel:Add("DButton")
			btn_add_delete:SetSize(250, 50)
			btn_add_delete:DockMargin( 50, 5, 0, 100 )
			btn_add_delete:Dock(TOP)
			btn_add_delete:SetText("")
			btn_add_delete.Paint = function(me, w, h)
				draw.SimpleText("Удалить раздел", "marske3", w/2-30, h/2-5, Color(255,255,255), TEXT_ALIGHT_CENTER, TEXT_ALIGHT_CENTER)
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
				if (me.Hovered) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
				end

				if (me:IsDown()) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
				end
			end
			btn_add_delete.DoClick = function()
				if #table.GetKeys(config) <= 1 then return end
				frame:Close()
				config[k_main] = nil
				RisedConfig_TutorialMenuEdit(config_all, config, title, folders, mainfolder)
			end
		end
	end
end

function UpdateConfigValue(config, keys, value)
	if #keys == 1 then
		config[keys[1]] = value
	elseif #keys == 2 then
		config[keys[1]][keys[2]] = value
	elseif #keys == 3 then
		config[keys[1]][keys[2]][keys[3]] = value
	elseif #keys == 4 then
		config[keys[1]][keys[2]][keys[3]][keys[4]] = value
	elseif #keys == 5 then
		config[keys[1]][keys[2]][keys[3]][keys[4]][keys[5]] = value
	end
end

function GenerateConfigEditor(main_frame, pnl, j, keys, extra_data, offset)
	
	local str_arr = string.Split(j, "pnl.")

	for m,c in pairs(str_arr) do

		if !string.StartWith(c, "Create") and m == 1 then

			local btn_panel = pnl:Add("DPanel")
			btn_panel:Dock( TOP )
			btn_panel:DockMargin(offset, 2, 0, 0)
			btn_panel.Paint = function(self, w, h)
			end

			local btn_text = btn_panel:Add("DButton")
			btn_text:SetSize(x_size/2, 0)
			btn_text:SetText("")
			btn_text:Dock(LEFT)
			btn_text.Paint = function(me, w, h)
				draw.SimpleText("Добавить текст", "marske3", w/2-30, h/2-5, Color(255,255,255), TEXT_ALIGHT_CENTER, TEXT_ALIGHT_CENTER)
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
				if (me.Hovered) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
				end

				if (me:IsDown()) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
				end
			end
			btn_text.DoClick = function()

				table.insert(str_arr, m+1, "CreateTxt('∎ Новая строка', 50, 0, '_font30', Color(215,225,100))")

				local save_str = ""
				for q,w in pairs(str_arr) do
					if !string.StartWith(w, "Create") then continue end
					save_str = save_str .. " pnl." .. w
				end
				UpdateConfigValue(extra_data.config, keys, save_str)

				main_frame:Close()	
				RisedConfig_TutorialMenuEdit(extra_data.config_all, extra_data.config, extra_data.title, extra_data.folders, extra_data.mainfolder)
			end

			local btn_img = btn_panel:Add("DButton")
			btn_img:SetSize(x_size/2, 0)
			btn_img:SetText("")
			btn_img:Dock(LEFT)
			btn_img.Paint = function(me, w, h)
				draw.SimpleText("Добавить изображение", "marske3", w/2-70, h/2-5, Color(255,255,255), TEXT_ALIGHT_CENTER, TEXT_ALIGHT_CENTER)
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
				if (me.Hovered) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
				end

				if (me:IsDown()) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
				end
			end
			btn_img.DoClick = function()

				table.insert(str_arr, m+1, "CreateImg('∎ Новое изображение', 0, 100, 200, 200, 'https://media.discordapp.net/attachments/955883172682420308/977746370368765972/white_200.png', 'new.jpg')")

				local save_str = ""
				for q,w in pairs(str_arr) do
					if !string.StartWith(w, "Create") then continue end
					save_str = save_str .. " pnl." .. w
				end
				UpdateConfigValue(extra_data.config, keys, save_str)

				main_frame:Close()	
				RisedConfig_TutorialMenuEdit(extra_data.config_all, extra_data.config, extra_data.title, extra_data.folders, extra_data.mainfolder)
			end

		elseif string.StartWith(c, "Create") then
		
			local lines = #toLines(c, "Default", ScrW()/2-125)
			
			local edit = pnl:Add("DTextEntry")
			edit:SetSize(ScrW()/2, 25 * lines)
			edit:Dock(TOP)
			edit:DockMargin(offset, 20, 0, 0)
			edit:SetValue(c)
			edit:SetMultiline(true)
			edit:SetTextColor(Color(0,0,0))
			edit:SetVerticalScrollbarEnabled(true)
			-- edit:SetPaintBackground(false)
			edit.OnChange = function(self)
				str_arr[m] = self:GetValue()
				local save_str = ""
				for q,w in pairs(str_arr) do
					if !string.StartWith(w, "Create") then continue end
					save_str = save_str .. " pnl." .. w
				end
				UpdateConfigValue(extra_data.config, keys, save_str)
			end

			local btn_panel = pnl:Add("DPanel")
			btn_panel:Dock( TOP )
			btn_panel:DockMargin(offset, 2, 0, 0)
			btn_panel.Paint = function(self, w, h)
			end

			local btn_text = btn_panel:Add("DButton")
			btn_text:SetSize(x_size/2, 0)
			btn_text:SetText("")
			btn_text:Dock(LEFT)
			btn_text.Paint = function(me, w, h)
				draw.SimpleText("Добавить текст", "marske3", w/2-30, h/2-5, Color(255,255,255), TEXT_ALIGHT_CENTER, TEXT_ALIGHT_CENTER)
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
				if (me.Hovered) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
				end

				if (me:IsDown()) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
				end
			end
			btn_text.DoClick = function()

				table.insert(str_arr, m+1, "CreateTxt('∎ Новая строка', 50, 0, '_font30', Color(215,225,100))")

				local save_str = ""
				for q,w in pairs(str_arr) do
					if !string.StartWith(w, "Create") then continue end
					save_str = save_str .. " pnl." .. w
				end
				UpdateConfigValue(extra_data.config, keys, save_str)

				main_frame:Close()	
				RisedConfig_TutorialMenuEdit(extra_data.config_all, extra_data.config, extra_data.title, extra_data.folders, extra_data.mainfolder)
			end

			local btn_img = btn_panel:Add("DButton")
			btn_img:SetSize(x_size/2, 0)
			btn_img:SetText("")
			btn_img:Dock(LEFT)
			btn_img.Paint = function(me, w, h)
				draw.SimpleText("Добавить изображение", "marske3", w/2-70, h/2-5, Color(255,255,255), TEXT_ALIGHT_CENTER, TEXT_ALIGHT_CENTER)
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
				if (me.Hovered) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
				end

				if (me:IsDown()) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
				end
			end
			btn_img.DoClick = function()

				table.insert(str_arr, m+1, "CreateImg('∎ Новое изображение', 0, 100, 200, 200, 'https://media.discordapp.net/attachments/955883172682420308/977746370368765972/white_200.png', 'new.jpg')")

				local save_str = ""
				for q,w in pairs(str_arr) do
					if !string.StartWith(w, "Create") then continue end
					save_str = save_str .. " pnl." .. w
				end
				UpdateConfigValue(extra_data.config, keys, save_str)

				main_frame:Close()	
				RisedConfig_TutorialMenuEdit(extra_data.config_all, extra_data.config, extra_data.title, extra_data.folders, extra_data.mainfolder)
			end

			local btn_delete = btn_panel:Add("DButton")
			btn_delete:SetSize(x_size/2, 0)
			btn_delete:SetText("")
			btn_delete:Dock(LEFT)
			btn_delete.Paint = function(me, w, h)
				draw.SimpleText("Удалить", "marske3", w/2-30, h/2-5, Color(255,255,255), TEXT_ALIGHT_CENTER, TEXT_ALIGHT_CENTER)
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
				if (me.Hovered) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
				end

				if (me:IsDown()) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
				end
			end
			btn_delete.DoClick = function()

				table.remove(str_arr, m)

				local save_str = ""
				for q,w in pairs(str_arr) do
					if !string.StartWith(w, "Create") then continue end
					save_str = save_str .. " pnl." .. w
				end
				UpdateConfigValue(extra_data.config, keys, save_str)

				main_frame:Close()	
				RisedConfig_TutorialMenuEdit(extra_data.config_all, extra_data.config, extra_data.title, extra_data.folders, extra_data.mainfolder)
			end
		end
	end
end