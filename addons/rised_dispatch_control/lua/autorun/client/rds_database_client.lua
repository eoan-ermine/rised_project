-- "addons\\rised_dispatch_control\\lua\\autorun\\client\\rds_database_client.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function IsDispatch()
	return LocalPlayer():Team() == TEAM_OWUDISPATCH
end

local self_citizen = {}
local self_main_frame = {}
local self_citizen_id = ""

local self_citizens_list = {}
local self_citizens_list_loading = false

local filter_wanted = false

net.Receive("RisedTerminal_CitizenDB:Client", function()
	
	local action = net.ReadString()

	if action == "Открыть" then
		CitizenDB_MainMenu()
	elseif action == "Обновить" then
		local netlenth = net.ReadInt(32)
		local binary = net.ReadData(netlenth)
		local citizen_json = util.Decompress(binary)
		local citizen = util.JSONToTable(citizen_json)

		self_citizen = citizen
	elseif action == "Открыть гражданина" then
		local netlenth = net.ReadInt(32)
		local binary = net.ReadData(netlenth)
		local citizen_json = util.Decompress(binary)
		local citizen = util.JSONToTable(citizen_json)

		self_citizen = citizen

		if IsValid(self_main_frame) then self_main_frame:Close() end
		
		OpenCitizenProfile()
	elseif action == "Открыть список всех граждан" then
		local netlenth = net.ReadInt(32)
		local binary = net.ReadData(netlenth)
		local citizens_json = util.Decompress(binary)
		local citizens = util.JSONToTable(citizens_json or "")

		self_citizens_list = citizens or {}
		
		if IsValid(self_main_frame) then self_main_frame:Close() end

		OpenCitizensList()

		self_citizens_list_loading = false
		LocalPlayer():EmitSound("rised/combine/pano_ui_affirm_lg_01.wav")
	end
end)

function CitizenDB_MainMenu()

	self_citizen = {}

	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW(),ScrH())
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame:MoveToBack()
	frame.startTime = SysTime()
	frame.Paint = function(s, w, h)
		Derma_DrawBackgroundBlur(s, 1)

		if s:HasFocus() then
			s:Close()
		end
	end

	self_main_frame = frame

	local dermaBox = vgui.Create("DFrame", frame)
	dermaBox:SetPos(0,0)
	dermaBox:SetSize(800,400)
	dermaBox:SetTitle("")
	dermaBox:Center()
	dermaBox:SetDraggable(false)
	dermaBox:ShowCloseButton(false)
	dermaBox:SetBackgroundBlur(false)
	dermaBox:MakePopup()
	dermaBox.startTime = SysTime()
	dermaBox.Paint = function(s, w, h)
		local mat_item_slot = Material("dev/dev_prisontvoverlay002")
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( mat_item_slot )
		surface.DrawTexturedRect( w/2 - w/2 + 5, 5, w - 10, h - 10 )

		draw.RoundedBox(2, 0, 0, w, h, Color(10, 10, 10, Lerp(SysTime() - s.startTime, 0, 125)));
		draw.RoundedBox(2, w/2 - w/2, h/2 - h/2, w, h, Color(10, 10, 10, 75));
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), w/2 - w/2, h/2 - h/2)

		draw.SimpleTextOutlined("База данных", "marske8", w/2, 15, Color(255, 165, 0, 255), 1, 2, 1, Color(255,165,0, 15))
		draw.SimpleTextOutlined("Введите ID гражданина:", "marske6", 75, 115, Color(255, 165, 0, 255), 0, 0, 1, Color(255,165,0, 15))
	end
	
	local buttonClose = vgui.Create("DButton", dermaBox)
	buttonClose:SetText("")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(750,25)
	buttonClose.Paint = function(s, w, h)
		draw.SimpleTextOutlined("X", "marske5", w/2-6, h/2-8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1, Color(255,165,0, 15))
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
		end
	end
	buttonClose.DoClick = function()
		frame:Close()
		LocalPlayer():EmitSound("rised/combine/pano_ui_scroll_click_01.wav")
	end
	
	local inputBox = vgui.Create("DFrame", dermaBox)
	inputBox:SetSize(500,50)
	inputBox:SetPos(75,150)
	inputBox:SetTitle("")
	inputBox:SetDraggable(false)
	inputBox:ShowCloseButton(false)
	inputBox:SetBackgroundBlur(false)
	inputBox.Paint = function(s, w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 75), false, true, false, false)
	end

	local inputSearch = vgui.Create("DTextEntry", dermaBox)
	inputSearch:SetSize(500,50)
	inputSearch:SetPos(75,150)
	inputSearch:SetFont("marske6")
	inputSearch:SetValue(self_citizen_id)
	inputSearch:SetValue("")
	inputSearch:SetTextColor(Color(200,100,0))
	inputSearch:SetPaintBackground(false)
	inputSearch:SetCursorColor(Color(200,100,0))
	inputSearch.OnEnter = function(s)
		SearchCitizen(inputSearch:GetValue())
	end
	inputSearch.OnChange = function(s)
		LocalPlayer():EmitSound("rised/combine/combine_machines_crafting_ui_select_01.wav")
	end

	local buttonSearch = vgui.Create("DButton", dermaBox)
	buttonSearch:SetText("")
	buttonSearch:SetSize(400,50)
	buttonSearch:SetPos(100,200)
	buttonSearch.Paint = function(s, w, h)
		if !s.Hovered and !s:IsDown() then
			draw.SimpleTextOutlined("Поиск", "marske6", w/2, h/2 - 10, Color(255,165,0), TEXT_ALIGHT_CENTER, TEXT_ALIGHT_CENTER, 0.5, Color(255,255,0, 5))
		end
		if (s.Hovered) then
			draw.SimpleTextOutlined("Поиск", "marske6", w/2, h/2 - 10, Color(255,165,0), TEXT_ALIGHT_CENTER, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
		end
	end
	buttonSearch.DoClick = function()
		LocalPlayer():EmitSound("rised/combine/ui_dossier_intro_text_line_0"..math.random(1, 3)..".wav")
		timer.Simple(2, function()
			if IsValid(frame) then
				SearchCitizen(inputSearch:GetValue())
				LocalPlayer():EmitSound("rised/combine/pano_ui_affirm_lg_01.wav")
			end
		end)
	end

	local buttonList = vgui.Create("DButton", dermaBox)
	buttonList:SetText("")
	buttonList:SetSize(500,50)
	buttonList:SetPos(50,265)
	buttonList.Paint = function(s, w, h)
		if self_citizens_list_loading then
			draw.SimpleTextOutlined("Открыть все дела", "marske6", w/2 - 70, h/2 - 10, Color(math.random(200,255),math.random(115,165),0), TEXT_ALIGHT_CENTER, TEXT_ALIGHT_CENTER, math.random(0,2), Color(255,255,0, 5))
		else
			if !s.Hovered and !s:IsDown() then
				draw.SimpleTextOutlined("Открыть все дела", "marske6", w/2 - 70, h/2 - 10, Color(255,165,0), TEXT_ALIGHT_CENTER, TEXT_ALIGHT_CENTER, 0.5, Color(255,255,0, 5))
			end
			if (s.Hovered) then
				draw.SimpleTextOutlined("Открыть все дела", "marske6", w/2 - 70, h/2 - 10, Color(255,165,0), TEXT_ALIGHT_CENTER, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
			end
		end
	end
	buttonList.DoClick = function()
		LocalPlayer():EmitSound("rised/combine/ui_dossier_intro_text_line_0"..math.random(1, 3)..".wav")
		GetCitizensList()
	end
	
	function SearchCitizen(value)
		net.Start("RisedTerminal_CitizenDB:Server")
		net.WriteString("Поиск гражданина")
		net.WriteString(value)
		net.SendToServer()
	end
	
	function GetCitizensList()
		self_citizens_list_loading = true
		net.Start("RisedTerminal_CitizenDB:Server")
		net.WriteString("Получить список всех граждан")
		net.SendToServer()
	end
end

function OpenCitizenProfile()

	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW(),ScrH())
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame:MoveToBack()
	frame.startTime = SysTime()
	frame.Paint = function(s, w, h)
		Derma_DrawBackgroundBlur(s, 1)
		
		if s:HasFocus() then
			s:Close()
		end
	end

	local dermaBox = vgui.Create("DFrame", frame) 
	dermaBox:SetPos(0,0)
	dermaBox:SetSize(800,400)
	dermaBox:SetTitle("")
	dermaBox:Center()
	dermaBox:SetDraggable(false)
	dermaBox:ShowCloseButton(false)
	dermaBox:SetBackgroundBlur(false)
	dermaBox:MakePopup()
	dermaBox.startTime = SysTime()
	dermaBox.Paint = function(s, w, h)
		local mat_item_slot = Material("dev/dev_prisontvoverlay002")
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( mat_item_slot )
		surface.DrawTexturedRect( w/2 - w/2 + 5, 5, w - 10, h - 10 )

		draw.RoundedBox(2, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.RoundedBox(2, w/2 - w/2, h/2 - h/2, w, h, Color(10, 10, 10, 75));
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), w/2 - w/2, h/2 - h/2)

		draw.SimpleTextOutlined("Идентификатор: " .. self_citizen['Идентификатор'], "marske8", 15, 15, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1, Color(255,165,0, 15))
		draw.SimpleTextOutlined("ФИО: " .. self_citizen['ФИО'], "marske8", 75, 100, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))
		draw.SimpleTextOutlined("ПОЛ: " .. self_citizen['Пол'], "marske5", 85, 150, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))
		draw.SimpleTextOutlined("Очки Лояльности: " .. self_citizen['Очки Лояльности'], "marske5", 85, 175, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))
		draw.SimpleTextOutlined("Место жительства: " .. self_citizen['Место жительства'], "marske5", 85, 200, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))
		draw.SimpleTextOutlined("Деятельность: " .. self_citizen['Деятельность'], "marske5", 85, 225, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))
		draw.SimpleTextOutlined("Статус: " .. self_citizen['Статус'], "marske5", 85, 250, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))
		if self_citizen["Розыск"] then
			draw.SimpleTextOutlined("В розыске: " .. self_citizen['Причина розыска'], "marske4", 85, 275, Color(175, 0, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1, Color(255,165,0, 5))
		else
			draw.SimpleTextOutlined("Розыск: Нет", "marske5", 85, 275, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))
		end
	end

	local buttonMigrationApprove = vgui.Create("DButton", dermaBox)
	buttonMigrationApprove:SetText("")
	buttonMigrationApprove:SetSize(300,25)
	buttonMigrationApprove:SetPos(0,360)
	buttonMigrationApprove.Paint = function(s, w, h)
		if self_citizen["Статус"] != "Прибывший" then return end
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		end
		draw.SimpleTextOutlined("Подтвердить миграцию", "marske5", 10, h/2 - 8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
	end
	buttonMigrationApprove.DoClick = function()
		if self_citizen["Статус"] != "Прибывший" then return end
		
		net.Start("RisedTerminal_CitizenDB:Server")
		net.WriteString("Изменить статус гражданина")
		net.WriteString(self_citizen["STEAMID"])
		net.WriteInt(self_citizen["CHAR"], 10)
		net.WriteString("Гражданин")
		net.SendToServer()

		LocalPlayer():EmitSound("rised/combine/pano_ui_sub_menu_01.wav")
	end

	local buttonCitizen = vgui.Create("DButton", dermaBox)
	buttonCitizen:SetText("")
	buttonCitizen:SetSize(300,25)
	buttonCitizen:SetPos(0,300)
	buttonCitizen.Paint = function(s, w, h)
		if self_citizen["Статус"] == "Гражданин" then return end
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		end
		draw.SimpleTextOutlined("Гражданин", "marske5", 10, h/2 - 8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
	end
	buttonCitizen.DoClick = function()
		if self_citizen["Статус"] == "Гражданин" then return end
		
		net.Start("RisedTerminal_CitizenDB:Server")
		net.WriteString("Изменить статус гражданина")
		net.WriteString(self_citizen["STEAMID"])
		net.WriteInt(self_citizen["CHAR"], 10)
		net.WriteString("Гражданин")
		net.SendToServer()

		LocalPlayer():EmitSound("rised/combine/pano_ui_sub_menu_01.wav")
	end

	local buttonAntiCitizen = vgui.Create("DButton", dermaBox)
	buttonAntiCitizen:SetText("")
	buttonAntiCitizen:SetSize(300,25)
	buttonAntiCitizen:SetPos(0,330)
	buttonAntiCitizen.Paint = function(s, w, h)
		if self_citizen["Статус"] == "Анти-гражданин" then return end
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		end
		draw.SimpleTextOutlined("Анти-гражданин", "marske5", 10, h/2 - 8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
	end
	buttonAntiCitizen.DoClick = function()
		if self_citizen["Статус"] == "Анти-гражданин" then return end
		
		net.Start("RisedTerminal_CitizenDB:Server")
		net.WriteString("Изменить статус гражданина")
		net.WriteString(self_citizen["STEAMID"])
		net.WriteInt(self_citizen["CHAR"], 10)
		net.WriteString("Анти-гражданин")
		net.SendToServer()

		LocalPlayer():EmitSound("rised/combine/pano_ui_sub_menu_01.wav")
	end
	
	local buttonClose = vgui.Create("DButton", dermaBox)
	buttonClose:SetText("")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(750,25)
	buttonClose.Paint = function(s, w, h)
		draw.SimpleTextOutlined("X", "marske5", w/2-6, h/2-9, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1, Color(255,165,0, 15))
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		end
	end
	buttonClose.DoClick = function()
		frame:Close()
	end

	local buttonAppearance = vgui.Create("DButton", dermaBox)
	buttonAppearance:SetText("")
	buttonAppearance:SetSize(300,25)
	buttonAppearance:SetPos(500,190)
	buttonAppearance.Paint = function(s, w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		end
		draw.SimpleTextOutlined("Описание внешности", "marske5", 10, h/2 - 8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
	end
	buttonAppearance.DoClick = function()
		frame:Close()
		OpenCitizenAppearance()
		LocalPlayer():EmitSound("rised/combine/pano_ui_rollover_01.wav")
	end

	local buttonHistory = vgui.Create("DButton", dermaBox)
	buttonHistory:SetText("")
	buttonHistory:SetSize(300,25)
	buttonHistory:SetPos(500,220)
	buttonHistory.Paint = function(s, w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		end
		draw.SimpleTextOutlined("Личное дело", "marske5", 10, h/2 - 8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
	end
	buttonHistory.DoClick = function()
		frame:Close()
		OpenCitizenHistory()
		LocalPlayer():EmitSound("rised/combine/pano_ui_rollover_01.wav")
	end

	local buttonIndictment = vgui.Create("DButton", dermaBox)
	buttonIndictment:SetText("")
	buttonIndictment:SetSize(300,25)
	buttonIndictment:SetPos(500,250)
	buttonIndictment:SetDisabled(true)
	buttonIndictment.Paint = function(s, w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s:GetDisabled()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(75, 75, 75, 10), false, true, false, false)
			draw.SimpleTextOutlined("Доносы", "marske5", 10, h/2 - 8, Color(125,125,125), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
			return
		end
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		end
		draw.SimpleTextOutlined("Доносы", "marske5", 10, h/2 - 8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
	end
	buttonIndictment.DoClick = function()
		frame:Close()
		LocalPlayer():EmitSound("rised/combine/pano_ui_rollover_01.wav")
	end

	local buttonWanted = vgui.Create("DButton", dermaBox)
	buttonWanted:SetText("")
	buttonWanted:SetSize(300,25)
	buttonWanted:SetPos(500,280)
	buttonWanted.Paint = function(s, w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		end
		draw.SimpleTextOutlined("Розыск", "marske5", 10, h/2 - 8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
	end
	buttonWanted.DoClick = function()
		frame:Close()
		OpenCitizenWanted()
		LocalPlayer():EmitSound("rised/combine/pano_ui_rollover_01.wav")
	end

	local btn_back = vgui.Create("DButton", dermaBox)
	btn_back:SetText("")
	btn_back:SetSize(300,25)
	btn_back:SetPos(500,315)
	btn_back.Paint = function(s, w, h)
		draw.SimpleTextOutlined("Назад", "marske5", 10, h/2 - 8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		end
	end
	btn_back.DoClick = function()
		frame:Close()

		if #self_citizens_list > 0 then
			OpenCitizensList()
		else
			CitizenDB_MainMenu()
		end

		LocalPlayer():EmitSound("rised/combine/pano_ui_menu_return_01.wav")
	end
end

function OpenCitizenAppearance()

	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW(),ScrH())
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame:MoveToBack()
	frame.startTime = SysTime()
	frame.Paint = function(s, w, h)
		Derma_DrawBackgroundBlur(s, 1)
		
		if s:HasFocus() then
			s:Close()
		end
	end

	local dermaBox = vgui.Create("DFrame", frame) 
	dermaBox:SetPos(0,0)
	dermaBox:SetSize(800,400)
	dermaBox:SetTitle("")
	dermaBox:Center()
	dermaBox:SetDraggable(false)
	dermaBox:ShowCloseButton(false)
	dermaBox:SetBackgroundBlur(false)
	dermaBox:MakePopup()
	dermaBox.startTime = SysTime()
	dermaBox.Paint = function(s, w, h)
		local mat_item_slot = Material("dev/dev_prisontvoverlay002")
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( mat_item_slot )
		surface.DrawTexturedRect( w/2 - w/2 + 5, 5, w - 10, h - 10 )

		draw.RoundedBox(2, 0, 0, w, h, Color(10, 10, 10, 125))
		draw.RoundedBox(2, w/2 - w/2, h/2 - h/2, w, h, Color(10, 10, 10, 75));
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), w/2 - w/2, h/2 - h/2)

		draw.SimpleTextOutlined("Идентификатор: " .. self_citizen['Идентификатор'], "marske8", 15, 15, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1, Color(255,165,0, 15))
		draw.SimpleTextOutlined("ФИО: " .. self_citizen['ФИО'], "marske8", 75, 100, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))
		draw.SimpleTextOutlined("ПОЛ: " .. self_citizen['Пол'], "marske5", 85, 150, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))
		draw.SimpleTextOutlined("Рост: " .. self_citizen['Рост'], "marske5", 85, 175, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))
		draw.SimpleTextOutlined("Телосложение: " .. self_citizen['Телосложение'], "marske5", 85, 200, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))
		draw.SimpleTextOutlined("Цвет глаз: " .. self_citizen['Цвет глаз'], "marske5", 85, 225, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))

		if isnumber(self_citizen['Растительность на лице']) && self_citizen['Растительность на лице'] > 0 then
			draw.SimpleTextOutlined("Растительность на лице: присутствует", "marske5", 85, 250, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))
		else
			draw.SimpleTextOutlined("Растительность на лице: отсутствует", "marske5", 85, 250, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))
		end

		drawMultiLine("Особенности внешности: " .. self_citizen['Особенности внешности'], "marske4", 400, 15, 85, 275, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1.5, Color(255,255,0, 5))
	end
	
	local buttonClose = vgui.Create("DButton", dermaBox)
	buttonClose:SetText("")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(750,25)
	buttonClose.Paint = function(s, w, h)
		draw.SimpleTextOutlined("X", "marske5", w/2-6, h/2-9, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1, Color(255,165,0, 15))
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		end
	end
	buttonClose.DoClick = function()
		frame:Close()
	end

	local btn_back = vgui.Create("DButton", dermaBox)
	btn_back:SetText("")
	btn_back:SetSize(300,25)
	btn_back:SetPos(500,315)
	btn_back.Paint = function(s, w, h)
		draw.SimpleTextOutlined("Назад", "marske5", 10, h/2 - 8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		end
	end
	btn_back.DoClick = function()
		frame:Close()
		OpenCitizenProfile()
		LocalPlayer():EmitSound("rised/combine/pano_ui_menu_return_01.wav")
	end
end

function OpenCitizenHistory()

	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW(),ScrH())
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame:MoveToBack()
	frame.startTime = SysTime()
	frame.Paint = function(s, w, h)
		Derma_DrawBackgroundBlur(s, 1)
		
		if s:HasFocus() then
			s:Close()
		end
	end
	
	local dermaBox = vgui.Create("DFrame", frame) 
	dermaBox:SetPos(0,0)
	dermaBox:SetSize(800,400)
	dermaBox:SetTitle("")
	dermaBox:Center()
	dermaBox:SetDraggable(false)
	dermaBox:ShowCloseButton(false)
	dermaBox:SetBackgroundBlur(false)
	dermaBox:MakePopup()
	dermaBox.startTime = SysTime()
	dermaBox.Paint = function(s, w, h)
		local mat_item_slot = Material("dev/dev_prisontvoverlay002")
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( mat_item_slot )
		surface.DrawTexturedRect( w/2 - w/2 + 5, 5, w - 10, h - 10 )

		draw.RoundedBox(2, 0, 0, w, h, Color(10, 10, 10, Lerp(SysTime() - s.startTime, 0, 125)));
		draw.RoundedBox(2, w/2 - w/2, h/2 - h/2, w, h, Color(10, 10, 10, 75));
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), w/2 - w/2, h/2 - h/2)

		draw.SimpleTextOutlined("Идентификатор: " .. self_citizen['Идентификатор'], "marske8", 15, 15, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1, Color(255,165,0, 15))
		draw.SimpleTextOutlined("История", "marske5", 605, 225, Color(255, 165, 0, 255), 0, 0, 1, Color(255,165,0, 15))
		draw.SimpleTextOutlined("гражданина", "marske5", 605, 245, Color(255, 165, 0, 255), 0, 0, 1, Color(255,165,0, 15))
	end
	
	local buttonClose = vgui.Create("DButton", dermaBox)
	buttonClose:SetText("")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(750,25)
	buttonClose.Paint = function(s, w, h)
		draw.SimpleTextOutlined("X", "marske5", w/2-6, h/2-8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1, Color(255,165,0, 15))
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
		end
	end
	buttonClose.DoClick = function()
		frame:Close()
	end

	local frameHistory = vgui.Create("DFrame", dermaBox)
	frameHistory:SetPos(65,65)
	frameHistory:SetSize(535,245)
	frameHistory:SetTitle("")
	frameHistory:SetDraggable(false)
	frameHistory:ShowCloseButton(false)
	frameHistory.Paint = function(s, w, h)
	end

	local scrollHistory = vgui.Create("DScrollPanel", frameHistory)
	scrollHistory:Dock( FILL )
	local sbar = scrollHistory:GetVBar()
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


	for i = #self_citizen["История"], 1, -1 do

		local record = self_citizen["История"][i]
		local recordSize = multilineSize(record["Текст"], "marske3", 450, 15, 25, 35, record["Цвет"], 0, 0, 0, Color(255,165,0, 15))
		
		local frameRecord = scrollHistory:Add("DFrame")
		frameRecord:Dock( TOP )
		frameRecord:DockMargin( 0, 0, 0, 10 )
		frameRecord:SetSize(535, 75 + recordSize)
		frameRecord:SetTitle("")
		frameRecord:SetDraggable(false)
		frameRecord:ShowCloseButton(false)
		frameRecord.Paint = function(s, w, h)
			draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 45))
			draw.SimpleTextOutlined("Запись #" .. record["Номер записи"] .. "   /   " .. record["Тип записи"] .. "   /   " .. record["Дата"], "marske4", 15, 15, record["Цвет"], 0, 0, 1, Color(255,165,0, 5))
			drawMultiLine(record["Текст"] .. " ::// конец записи", "marske3", 450, 15, 25, 35, record["Цвет"], 0, 0, 0, Color(255,165,0, 15))
		end
	end

	local btn_back = vgui.Create("DButton", dermaBox)
	btn_back:SetText("")
	btn_back:SetSize(300,25)
	btn_back:SetPos(500,365)
	btn_back.Paint = function(s, w, h)
		draw.SimpleTextOutlined("Назад", "marske5", 10, h/2 - 8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		end
	end
	btn_back.DoClick = function()
		frame:Close()
		OpenCitizenProfile()
		LocalPlayer():EmitSound("rised/combine/pano_ui_menu_return_01.wav")
	end
end

function OpenCitizenWanted()

	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW(),ScrH())
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame:MoveToBack()
	frame.startTime = SysTime()
	frame.Paint = function(s, w, h)
		Derma_DrawBackgroundBlur(s, 1)
		
		if s:HasFocus() then
			s:Close()
		end
	end
	
	local dermaBox = vgui.Create("DFrame", frame) 
	dermaBox:SetPos(0,0)
	dermaBox:SetSize(800,400)
	dermaBox:SetTitle("")
	dermaBox:Center()
	dermaBox:SetDraggable(false)
	dermaBox:ShowCloseButton(false)
	dermaBox:SetBackgroundBlur(false)
	dermaBox:MakePopup()
	dermaBox.startTime = SysTime()
	dermaBox.Paint = function(s, w, h)
		local mat_item_slot = Material("dev/dev_prisontvoverlay002")
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( mat_item_slot )
		surface.DrawTexturedRect( w/2 - w/2 + 5, 5, w - 10, h - 10 )

		draw.RoundedBox(2, 0, 0, w, h, Color(10, 10, 10, Lerp(SysTime() - s.startTime, 0, 125)));
		draw.RoundedBox(2, w/2 - w/2, h/2 - h/2, w, h, Color(10, 10, 10, 75));
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), w/2 - w/2, h/2 - h/2)
		
		draw.SimpleTextOutlined("Идентификатор: " .. self_citizen['Идентификатор'], "marske8", 15, 15, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1, Color(255,165,0, 15))
		draw.SimpleTextOutlined("Криминальные", "marske5", 605, 225, Color(255, 165, 0, 255), 0, 0, 1, Color(255,165,0, 15))
		draw.SimpleTextOutlined("записи", "marske5", 605, 245, Color(255, 165, 0, 255), 0, 0, 1, Color(255,165,0, 15))
	end
	
	local buttonClose = vgui.Create("DButton", dermaBox)
	buttonClose:SetText("")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(750,25)
	buttonClose.Paint = function(s, w, h)
		draw.SimpleTextOutlined("X", "marske5", w/2-6, h/2-8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1, Color(255,165,0, 15))
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
		end
	end
	buttonClose.DoClick = function()
		frame:Close()
	end

	local inputBox = vgui.Create("DFrame", dermaBox)
	inputBox:SetSize(250,35)
	inputBox:SetPos(75,85)
	inputBox:SetTitle("")
	inputBox:SetDraggable(false)
	inputBox:ShowCloseButton(false)
	inputBox:SetBackgroundBlur(false)
	inputBox.Paint = function(s, w, h)
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 125), false, true, false, false)
	end

	local inputReason = vgui.Create("DTextEntry", dermaBox)
	inputReason:SetSize(250,35)
	inputReason:SetPos(75,85)
	inputReason:SetFont("marske4")
	inputReason:SetValue(self_citizen_id)
	inputReason:SetTextColor(Color(200,100,0))
	inputReason:SetPaintBackground(false)
	if self_citizen["Розыск"] then
		inputReason:SetPlaceholderText("||| Введите причину снятия |||")
		inputReason:SetPlaceholderColor(Color(200,100,0))
	else
		inputReason:SetPlaceholderText("||| Введите причину розыска |||")
		inputReason:SetPlaceholderColor(Color(200,100,0))
	end
	inputReason:SetCursorColor(Color(200,100,0))
	inputReason.OnChange = function( s )
		LocalPlayer():EmitSound("rised/combine/combine_machines_crafting_ui_select_01.wav")
	end

	local buttonWanted = vgui.Create("DButton", dermaBox)
	buttonWanted:SetText("")
	buttonWanted:SetSize(400,50)
	buttonWanted:SetPos(350,75)
	buttonWanted.isWanted = self_citizen["Розыск"]
	buttonWanted.Paint = function(s, w, h)
		if !s.isWanted then
			if !s.Hovered and !s:IsDown() then
				draw.SimpleTextOutlined("Подать в розыск", "marske6", 0, h/2 - 10, Color(255,165,0), 0, 0, 0.5, Color(255,255,0, 5))
			end
			if (s.Hovered) then
				draw.SimpleTextOutlined("Подать в розыск", "marske6", 0, h/2 - 10, Color(255,165,0), 0, 0, 1.5, Color(255,255,0, 5))
			end
		else
			if !s.Hovered and !s:IsDown() then
				draw.SimpleTextOutlined("Снять розыск", "marske6", 0, h/2 - 10, Color(255,165,0), 0, 0, 0.5, Color(255,255,0, 5))
			end
			if (s.Hovered) then
				draw.SimpleTextOutlined("Снять розыск", "marske6", 0, h/2 - 10, Color(255,165,0), 0, 0, 1.5, Color(255,255,0, 5))
			end
		end
	end
	buttonWanted.DoClick = function()
		LocalPlayer():EmitSound("rised/combine/ui_dossier_intro_text_line_0"..math.random(1, 3)..".wav")
		timer.Simple(2, function()
			if IsValid(frame) then
				net.Start("RisedTerminal_CitizenDB:Server")
				net.WriteString("Розыск")
				net.WriteString(self_citizen["STEAMID"])
				net.WriteInt(self_citizen["CHAR"], 10)
				if buttonWanted.isWanted then
					net.WriteString("Снять розыск")
				else
					net.WriteString("Подать в розыск")
				end
				net.WriteString(inputReason:GetValue())
				net.SendToServer()

				timer.Simple(0.5, function()
					LocalPlayer():EmitSound("rised/combine/pano_ui_sub_menu_01.wav")
					frame:Close()
					OpenCitizenWanted()
				end)
			end
		end)
	end

	local frameHistory = vgui.Create("DFrame", dermaBox)
	frameHistory:SetPos(65,115)
	frameHistory:SetSize(535,200)
	frameHistory:SetTitle("")
	frameHistory:SetDraggable(false)
	frameHistory:ShowCloseButton(false)
	frameHistory.Paint = function(s, w, h)
	end

	local scrollHistory = vgui.Create("DScrollPanel", frameHistory)
	scrollHistory:Dock( FILL )
	local sbar = scrollHistory:GetVBar()
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

	for i = #self_citizen["История"], 1, -1 do

		local record = self_citizen["История"][i]
		local recordSize = multilineSize(record["Текст"], "marske3", 450, 15, 25, 35, record["Цвет"], 0, 0, 0, Color(255,165,0, 15))
		
		if record["Тип записи"] == "Криминальная запись" or record["Тип записи"] == "Статус розыска" then
			local frameRecord = scrollHistory:Add("DFrame")
			frameRecord:Dock( TOP )
			frameRecord:DockMargin( 0, 0, 0, 10 )
			frameRecord:SetSize(535, 75 + recordSize)
			frameRecord:SetTitle("")
			frameRecord:SetDraggable(false)
			frameRecord:ShowCloseButton(false)
			frameRecord.Paint = function(s, w, h)
				draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 45))
				draw.SimpleTextOutlined("Запись #" .. record["Номер записи"] .. "   /   " .. record["Тип записи"] .. "   /   " .. record["Дата"], "marske4", 15, 15, record["Цвет"], 0, 0, 1, Color(255,165,0, 5))
				drawMultiLine(record["Текст"] .. " ::// конец записи", "marske3", 450, 15, 25, 35, record["Цвет"], 0, 0, 0, Color(255,165,0, 15))
			end
		end
	end

	local btn_back = vgui.Create("DButton", dermaBox)
	btn_back:SetText("")
	btn_back:SetSize(300,25)
	btn_back:SetPos(500,365)
	btn_back.Paint = function(s, w, h)
		draw.SimpleTextOutlined("Назад", "marske5", 10, h/2 - 8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		end
	end
	btn_back.DoClick = function()
		frame:Close()
		OpenCitizenProfile()
		LocalPlayer():EmitSound("rised/combine/pano_ui_menu_return_01.wav")
	end
end

function OpenCitizensList()

	local frame = vgui.Create("DFrame") 
	frame:SetPos(0,0)
	frame:SetSize(ScrW(),ScrH())
	frame:SetTitle("")
	frame:Center()
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:SetBackgroundBlur(false)
	frame:MakePopup()
	frame:MoveToBack()
	frame.startTime = SysTime()
	frame.Paint = function(s, w, h)
		Derma_DrawBackgroundBlur(s, 1)
		
		if s:HasFocus() then
			s:Close()
		end
	end
	
	local dermaBox = vgui.Create("DFrame", frame) 
	dermaBox:SetPos(0,0)
	dermaBox:SetSize(800,400)
	dermaBox:SetTitle("")
	dermaBox:Center()
	dermaBox:SetDraggable(false)
	dermaBox:ShowCloseButton(false)
	dermaBox:SetBackgroundBlur(false)
	dermaBox:MakePopup()
	dermaBox.startTime = SysTime()
	dermaBox.Paint = function(s, w, h)
		local mat_item_slot = Material("dev/dev_prisontvoverlay002")
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( mat_item_slot )
		surface.DrawTexturedRect( w/2 - w/2 + 5, 5, w - 10, h - 10 )

		draw.RoundedBox(2, 0, 0, w, h, Color(10, 10, 10, Lerp(SysTime() - s.startTime, 0, 125)));
		draw.RoundedBox(2, w/2 - w/2, h/2 - h/2, w, h, Color(10, 10, 10, 75));
		draw.DrawOutlinedRoundedRect(w, h, Color(125, 125, 125, 5), w/2 - w/2, h/2 - h/2)

		draw.SimpleTextOutlined("Список всех дел:", "marske8", 15, 15, Color(255, 165, 0, 255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_LEFT, 1, Color(255,165,0, 15))
	end
	
	local buttonClose = vgui.Create("DButton", dermaBox)
	buttonClose:SetText("")
	buttonClose:SetSize(25,25)
	buttonClose:SetPos(750,25)
	buttonClose.Paint = function(s, w, h)
		draw.SimpleTextOutlined("X", "marske5", w/2-6, h/2-8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1, Color(255,165,0, 15))
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 10, 255), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(255, 255, 255, 5, 255), false, true, false, false)
		end
	end
	buttonClose.DoClick = function()
		frame:Close()
	end

	local frameHistory = vgui.Create("DFrame", dermaBox)
	frameHistory:SetPos(65,65)
	frameHistory:SetSize(535,245)
	frameHistory:SetTitle("")
	frameHistory:SetDraggable(false)
	frameHistory:ShowCloseButton(false)
	frameHistory.Paint = function(s, w, h)
	end

	local scrollHistory = vgui.Create("DScrollPanel", frameHistory)
	scrollHistory:Dock( FILL )
	local sbar = scrollHistory:GetVBar()
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

	for k,v in pairs(self_citizens_list) do
		local recordSize = multilineSize(v["ФИО"], "marske3", 450, 15, 25, 35, Color(255,255,255), 0, 0, 0, Color(255,165,0, 15))

		if v["Розыск"] and filter_wanted then
			local frameRecord = scrollHistory:Add("DFrame")
			frameRecord:Dock( TOP )
			frameRecord:DockMargin( 0, 0, 0, 10 )
			frameRecord:SetSize(535, 75)
			frameRecord:SetTitle("")
			frameRecord:SetDraggable(false)
			frameRecord:ShowCloseButton(false)
			frameRecord.Paint = function(s, w, h)
				draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 45))
				draw.SimpleTextOutlined("Идентификатор #" .. v["Идентификатор"] .. "   /   " .. v["Статус"], "marske4", 15, 15, Color(255,0,0), 0, 0, 1, Color(255,165,0, 5))
				drawMultiLine(v["ФИО"], "marske3", 450, 15, 25, 35, Color(255,0,0), 0, 0, 0, Color(255,165,0, 15))
				drawMultiLine(v["Деятельность"] .. " ::// конец записи", "marske3", 450, 15, 25, 55, Color(255,0,0), 0, 0, 0, Color(255,165,0, 15))
			end

			local btn_open = vgui.Create("DButton", frameRecord)
			btn_open:SetText("")
			btn_open:SetSize(100,25)
			btn_open:SetPos(420,45)
			btn_open.Paint = function(s, w, h)
				draw.SimpleTextOutlined("Открыть", "marske4", 10, h/2 - 8, Color(255,255,255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(145,145,145, 5))
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
				if (s.Hovered) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(145, 145, 145, 10), false, true, false, false)
				end

				if (s:IsDown()) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
				end
			end
			btn_open.DoClick = function()
				frame:Close()
				LocalPlayer():EmitSound("rised/combine/pano_ui_menu_return_01.wav")

				net.Start("RisedTerminal_CitizenDB:Server")
				net.WriteString("Поиск гражданина")
				net.WriteString(v["Идентификатор"])
				net.SendToServer()
			end
		elseif !filter_wanted then
			local frameRecord = scrollHistory:Add("DFrame")
			frameRecord:Dock( TOP )
			frameRecord:DockMargin( 0, 0, 0, 10 )
			frameRecord:SetSize(535, 75)
			frameRecord:SetTitle("")
			frameRecord:SetDraggable(false)
			frameRecord:ShowCloseButton(false)
			frameRecord.Paint = function(s, w, h)
				draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0, 45))
				draw.SimpleTextOutlined("Идентификатор #" .. v["Идентификатор"] .. "   /   " .. v["Статус"], "marske4", 15, 15, Color(255,255,255), 0, 0, 1, Color(255,165,0, 5))
				drawMultiLine(v["ФИО"], "marske3", 450, 15, 25, 35, Color(255,255,255), 0, 0, 0, Color(255,165,0, 15))
				drawMultiLine(v["Деятельность"] .. " ::// конец записи", "marske3", 450, 15, 25, 55, Color(255,255,255), 0, 0, 0, Color(255,165,0, 15))
			end

			local btn_open = vgui.Create("DButton", frameRecord)
			btn_open:SetText("")
			btn_open:SetSize(100,25)
			btn_open:SetPos(420,45)
			btn_open.Paint = function(s, w, h)
				draw.SimpleTextOutlined("Открыть", "marske4", 10, h/2 - 8, Color(255,255,255), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(145,145,145, 5))
				draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
				if (s.Hovered) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(145, 145, 145, 10), false, true, false, false)
				end

				if (s:IsDown()) then
					draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
				end
			end
			btn_open.DoClick = function()
				frame:Close()
				LocalPlayer():EmitSound("rised/combine/pano_ui_menu_return_01.wav")

				net.Start("RisedTerminal_CitizenDB:Server")
				net.WriteString("Поиск гражданина")
				net.WriteString(v["Идентификатор"])
				net.SendToServer()
			end
		end
	end

	local btn_filter_wanted = vgui.Create("DButton", dermaBox)
	btn_filter_wanted:SetText("")
	btn_filter_wanted:SetSize(300,25)
	btn_filter_wanted:SetPos(615,225)
	btn_filter_wanted.Paint = function(s, w, h)
		if self_citizens_list_loading then
			draw.SimpleTextOutlined("Розыск", "marske5", 10, h/2 - 8, Color(math.random(200, 255),math.random(115, 165),0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, math.random(0, 2), Color(255,255,0, 5))
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		else
			draw.SimpleTextOutlined("Розыск", "marske5", 10, h/2 - 8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
			draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
			if (s.Hovered or filter_wanted) then
				draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
			end

			if (s:IsDown()) then
				draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
			end
		end
	end
	btn_filter_wanted.DoClick = function()
		self_main_frame = frame
		self_citizens_list = {}
		self_citizens_list_loading = true
		filter_wanted = !filter_wanted

		net.Start("RisedTerminal_CitizenDB:Server")
		net.WriteString("Получить список всех граждан")
		net.SendToServer()

		LocalPlayer():EmitSound("rised/combine/pano_ui_menu_return_01.wav")
	end

	local btn_update = vgui.Create("DButton", dermaBox)
	btn_update:SetText("")
	btn_update:SetSize(300,25)
	btn_update:SetPos(500,340)
	btn_update.Paint = function(s, w, h)
		if self_citizens_list_loading then
			draw.SimpleTextOutlined("Обновить", "marske5", 10, h/2 - 8, Color(math.random(200, 255),math.random(115, 165),0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, math.random(0, 2), Color(255,255,0, 5))
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		else
			draw.SimpleTextOutlined("Обновить", "marske5", 10, h/2 - 8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
			draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
			if (s.Hovered) then
				draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
			end

			if (s:IsDown()) then
				draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
			end
		end
	end
	btn_update.DoClick = function()
		self_main_frame = frame
		self_citizens_list = {}
		self_citizens_list_loading = true

		net.Start("RisedTerminal_CitizenDB:Server")
		net.WriteString("Получить список всех граждан")
		net.SendToServer()

		LocalPlayer():EmitSound("rised/combine/pano_ui_menu_return_01.wav")
	end

	local btn_back = vgui.Create("DButton", dermaBox)
	btn_back:SetText("")
	btn_back:SetSize(300,25)
	btn_back:SetPos(500,370)
	btn_back.Paint = function(s, w, h)
		draw.SimpleTextOutlined("Назад", "marske5", 10, h/2 - 8, Color(255,165,0), TEXT_ALIGHT_LEFT, TEXT_ALIGHT_CENTER, 1.5, Color(255,255,0, 5))
		draw.RoundedBoxEx(0, 0, 0, w, h, Color(0, 0, 0, 145), false, true, false, false)
		if (s.Hovered) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(200, 165, 0, 10), false, true, false, false)
		end

		if (s:IsDown()) then
			draw.RoundedBoxEx(4, 0, 0, w, h, Color(25, 25, 0, 155), false, true, false, false)
		end
	end
	btn_back.DoClick = function()
		frame:Close()
		self_citizens_list = {}
		CitizenDB_MainMenu()
		LocalPlayer():EmitSound("rised/combine/pano_ui_menu_return_01.wav")
	end
end