-- "addons\\rised_rp_curator_system\\lua\\autorun\\client\\rrcs_client.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
net.Receive("Rised.RPCurator.OpenMenu", function()

	local netlenth = net.ReadInt(32)
	local dataRaw = net.ReadData(netlenth)
	local data = util.Decompress(dataRaw)
	local teamBansTable = util.JSONToTable(data) or {}
	
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
		draw.RoundedBox(2, w/2 - 400, h/2 - 400, 800, 800, Color(10, 10, 10, 75));
		draw.DrawOutlinedRoundedRect(800, 800, Color(125, 125, 125, 5), w/2 - 400, h/2 - 400)

		draw.SimpleText("Кураторский раздел", "marske8", w/2, ScrH()/2 - 355, Color(255, 255, 255, 255), 1, 2)
		draw.RoundedBox(0, w/2 - 150, ScrH()/2 - 320, 300, 1, Color(255, 255, 255, 255));
		draw.SimpleText("Меню", "marske6", w/2, ScrH()/2 - 310, Color(255, 255, 255, 255), 1, 2)
		
		self.ready = true;
	end
	
	local buttonClose = vgui.Create("DButton", frame)
	buttonClose:SetText("")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(ScrW()/1.5 - 25,ScrH()/2 - 355)
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

	local selectedPlayerSteamID = ""
	local selectedTeam = 0

	local DScrollPanelJobs = vgui.Create("DScrollPanel", frame)
	DScrollPanelJobs:SetSize(350,500)
	DScrollPanelJobs:SetPos(ScrW()/2 + 50,ScrH()/2 - 250)
	
	local sbar = DScrollPanelJobs:GetVBar()
	function sbar:Paint(w, h)
		draw.RoundedBox(10, 0, 15, w, h-30, Color(10, 10, 10, 125))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 0))
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 0))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(255, 255, 255, 1))
	end

	local itemsIndex = {}
	for k,v in pairs(RISED.Config.Trade.Clothes.Items) do
		if v["Blocked"] == false then
			table.insert(itemsIndex, k)
		end
	end
	
	offset = 0
	local jobButtons = {}
	for k,v in pairs(RPExtraTeams) do
		
		local buttonAdd = DScrollPanelJobs:Add("DButton")
		buttonAdd:SetSize(340, 50)
		buttonAdd:SetPos(0, offset)
		buttonAdd:SetText("")
		buttonAdd:SetFont("marske4")
		buttonAdd.Text = v.name
		buttonAdd.team = k
		buttonAdd.isBanned = false
		buttonAdd.teamBanHours = 0
		local width, height = surface.GetTextSize(buttonAdd.Text)
		buttonAdd.hovered = false
		buttonAdd.disabled = false
		buttonAdd.alpha = 0
		buttonAdd.enabled = false
		buttonAdd.starttime = SysTime()
		buttonAdd.Paint = function(self, w, h)
			if (buttonAdd.starttime < SysTime()) then
				buttonAdd.alpha = buttonAdd.alpha or 0
				buttonAdd.alpha = Lerp(FrameTime(), buttonAdd.alpha, 255)
			end
			
			if (self.disabled) then
				draw.SimpleText(self.Text, "marske5", 20, h/2, Color(145, 145, 145, buttonAdd.alpha), 0, 1)
				return
			end

			if (self.hovered or self.enabled) then
				draw.RoundedBox(0,0,h-1,w/4,1,Color(255, 165, 0,buttonAdd.alpha))
				draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
				draw.SimpleText(self.Text, "marske5", 20, h/2, Color(255, 165, 0, buttonAdd.alpha), 0, 1)
				return
			end
			
			if self.isBanned then
				draw.RoundedBox(0,0,h-1,w/4,1,Color(255, 0, 0,buttonAdd.alpha))
				draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
				draw.SimpleText(self.Text, "marske5", 20, h/2-5, Color(255, 0, 0, buttonAdd.alpha), 0, 1)
				draw.SimpleText("Время блокировки: " .. self.teamBanHours .. " часа", "marske4", 35, h/2 + 15, Color(255, 0, 0, buttonAdd.alpha), 0, 1);
				return
			end
			
			draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
			draw.SimpleText(self.Text, "marske4", 20, h/2, Color(255, 255, 255, buttonAdd.alpha), 0, 1)
		end
		buttonAdd.OnCursorEntered = function(self)
			if (self.disabled) then return false end
			self.hovered = true
			surface.PlaySound("garrysmod/ui_hover.wav")
		end
		buttonAdd.OnMousePressed = function(self)
			if (self.disabled) then return false end
			surface.PlaySound("garrysmod/ui_click.wav")

			for s,c in pairs(jobButtons) do
				c.enabled = false
			end
			
			if (self.enabled) then
				self.enabled = false
				selectedTeam = 0
			else
				self.enabled = true
				selectedTeam = k
			end
		end
		buttonAdd.OnCursorExited = function(self)
			self.hovered = false
		end
		
		table.insert(jobButtons, buttonAdd)
		offset = offset + 75
	end

	local DScrollPanel = vgui.Create("DScrollPanel", frame)
	DScrollPanel:SetSize(400,550)
	DScrollPanel:SetPos(ScrW()/2 - 400,ScrH()/2 - 250)
	
	local sbar = DScrollPanel:GetVBar()
	function sbar:Paint(w, h)
		draw.RoundedBox(10, 0, 15, w, h-30, Color(10, 10, 10, 125))
	end
	function sbar.btnUp:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 0))
	end
	function sbar.btnDown:Paint(w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 0))
	end
	function sbar.btnGrip:Paint(w, h)
		draw.RoundedBox(10, 0, 0, w, h, Color(255, 255, 255, 1))
	end

	local itemsIndex = {}
	for k,v in pairs(RISED.Config.Trade.Clothes.Items) do
		if v["Blocked"] == false then
			table.insert(itemsIndex, k)
		end
	end
	
	local offset = 0
	local playerButtons = {}
	for k,v in pairs(player.GetAll()) do
		
		local buttonAdd = DScrollPanel:Add("DButton")
		buttonAdd:SetSize(400, 75)
		buttonAdd:SetPos(0, offset)
		buttonAdd:SetText("")
		buttonAdd:SetFont("marske4")
		buttonAdd.Text = v:SteamName()
		buttonAdd.Job = RPExtraTeams[v:Team()].name
		local width, height = surface.GetTextSize(buttonAdd.Text)
		buttonAdd.hovered = false
		buttonAdd.disabled = false
		buttonAdd.alpha = 0
		buttonAdd.enabled = false
		buttonAdd.starttime = SysTime()
		buttonAdd.Paint = function(self, w, h)
			if (buttonAdd.starttime < SysTime()) then
				buttonAdd.alpha = buttonAdd.alpha or 0
				buttonAdd.alpha = Lerp(FrameTime(), buttonAdd.alpha, 255)
			end
			
			if (self.disabled) then
				draw.SimpleText(self.Text, "marske5", 20, h/2, Color(145, 145, 145, buttonAdd.alpha), 0, 1)
				return
			end
			
			if (self.hovered or self.enabled) then
				draw.RoundedBox(0,0,h-1,w/4,1,Color(255, 165, 0,buttonAdd.alpha))
				draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
				draw.SimpleText(self.Text, "marske5", 20, h/2 - 5, Color(255, 165, 0, buttonAdd.alpha), 0, 1)
				draw.SimpleText(self.Job, "marske4", 35, h/2 + 20, Color(255, 165, 0, buttonAdd.alpha), 0, 1)
				return
			end
			
			draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
			draw.SimpleText(self.Text, "marske5", 20, h/2 - 5, Color(255, 255, 255, buttonAdd.alpha), 0, 1)
			draw.SimpleText(self.Job, "marske4", 65, h/2 + 20, Color(255, 255, 255, buttonAdd.alpha), 0, 1)
		end
		buttonAdd.OnCursorEntered = function(self)
			if (self.disabled) then return false end
			self.hovered = true
			surface.PlaySound("garrysmod/ui_hover.wav")
		end
		buttonAdd.OnMousePressed = function(self)
			if (self.disabled) then return false end
			surface.PlaySound("garrysmod/ui_click.wav")
			
			for s,c in pairs(playerButtons) do
				c.enabled = false
			end

			if (self.enabled) then
				self.enabled = false
				selectedPlayerSteamID = ""
			else
				selectedPlayerSteamID = v:SteamID()
				self.enabled = true
			end
			
			for s,c in pairs(jobButtons) do
				for m,n in pairs(teamBansTable) do
					if v:SteamID() == n.player_id and c.team == n.ban_team then
						local teamBanHours = math.Round((n.ban_time - os.time())/60/60, 1)
						if teamBanHours > 0 then
							timer.Simple(0.2, function()
								c.isBanned = true
								c.teamBanHours = teamBanHours
							end)
						else
							c.isBanned = false
							c.teamBanHours = 0
						end
					else
						c.isBanned = false
						c.teamBanHours = 0
					end
				end
			end
		end
		buttonAdd.OnCursorExited = function(self)
			self.hovered = false
		end
		
		table.insert(playerButtons, buttonAdd)
		offset = offset + 100
	end

	local inputLabel = vgui.Create("DLabel", frame)
	inputLabel:SetPos(ScrW()/2 - 350, ScrH()/2 + 310)
	inputLabel:SetSize(250, 50)
	inputLabel:SetText("Блокировка по SteamID:")
	inputLabel:SetFont("marske5")

	local inputSteamID = vgui.Create("DTextEntry", frame)
	inputSteamID:SetPos(ScrW()/2 - 350, ScrH()/2 + 350)
	inputSteamID:SetSize( 250, 25 )
	inputSteamID:SetText( "" )
	inputSteamID.OnChange = function( self )
		net.Start("CardTerminalWriting")
		net.SendToServer()
	end

	local buttonBan = vgui.Create("DButton", frame)
	buttonBan:SetSize(250, 50)
	buttonBan:SetPos(ScrW()/2 + 100, ScrH()/2 + 270)
	buttonBan:SetText("")
	buttonBan:SetFont("marske4")
	buttonBan.Text = "Заблокировать"
	local width, height = surface.GetTextSize(buttonBan.Text)
	buttonBan.hovered = false
	buttonBan.disabled = false
	buttonBan.alpha = 0
	buttonBan.starttime = SysTime()
	buttonBan.Paint = function(self, w, h)
		if (buttonBan.starttime < SysTime()) then
			buttonBan.alpha = buttonBan.alpha or 0
			buttonBan.alpha = Lerp(FrameTime(), buttonBan.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonBan.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return;
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonBan.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonBan.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonBan.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonBan.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonBan.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()

		if selectedPlayerSteamID != "" and selectedTeam != 0 then
			net.Start("Rised.RPCurator.Server")
			net.WriteString(selectedPlayerSteamID)
			net.WriteInt(selectedTeam,10)
			net.WriteString("Ban")
			net.SendToServer()
		elseif inputSteamID:GetValue() != "" and selectedTeam != 0 then
			net.Start("Rised.RPCurator.Server")
			net.WriteString(inputSteamID:GetValue())
			net.WriteInt(selectedTeam,10)
			net.WriteString("Ban")
			net.SendToServer()
		end
	end
	buttonBan.OnCursorExited = function(self)
		self.hovered = false
	end

	local buttonUnBan = vgui.Create("DButton", frame)
	buttonUnBan:SetSize(250, 50)
	buttonUnBan:SetPos(ScrW()/2 + 100, ScrH()/2 + 330)
	buttonUnBan:SetText("")
	buttonUnBan:SetFont("marske4")
	buttonUnBan.Text = "Разблокировать"
	local width, height = surface.GetTextSize(buttonUnBan.Text)
	buttonUnBan.hovered = false
	buttonUnBan.disabled = false
	buttonUnBan.alpha = 0
	buttonUnBan.starttime = SysTime();
	buttonUnBan.Paint = function(self, w, h)
		if (buttonUnBan.starttime < SysTime()) then
			buttonUnBan.alpha = buttonUnBan.alpha or 0
			buttonUnBan.alpha = Lerp(FrameTime(), buttonUnBan.alpha, 255)
		end
		
		if (self.disabled) then
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(145, 145, 145, buttonUnBan.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return;
		end

		if (self.hovered) then
			draw.RoundedBox(0,0,h-1,w,1,Color(255, 165, 0,buttonUnBan.alpha))
			draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 3), 0, 0)
			draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 165, 0, buttonUnBan.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			return;
		end
		
		draw.RoundedBox(5, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), 0, 0)
		draw.SimpleText(self.Text, "marske5", w/2, h/2, Color(255, 255, 255, buttonUnBan.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	buttonUnBan.OnCursorEntered = function(self)
		if (self.disabled) then return false end
		self.hovered = true
		surface.PlaySound("garrysmod/ui_hover.wav")
	end
	buttonUnBan.OnMousePressed = function(self)
		if (self.disabled) then return false end
		surface.PlaySound("garrysmod/ui_click.wav")
		frame:Close()
		
		if selectedPlayerSteamID != "" and selectedTeam != 0 then
			net.Start("Rised.RPCurator.Server")
			net.WriteString(selectedPlayerSteamID)
			net.WriteInt(selectedTeam,10)
			net.WriteString("UnBan")
			net.SendToServer()
		elseif inputSteamID:GetValue() != "" and selectedTeam != 0 then
			net.Start("Rised.RPCurator.Server")
			net.WriteString(inputSteamID:GetValue())
			net.WriteInt(selectedTeam,10)
			net.WriteString("UnBan")
			net.SendToServer()
		end
	end
	buttonUnBan.OnCursorExited = function(self)
		self.hovered = false
	end
end)