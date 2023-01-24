-- "addons\\rised_id_cards\\lua\\idcards\\cl_idcards.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local isregtimer = false
local justonce = false
local regtimer

net.Receive("idcards_show", function()

	local citizen_id = net.ReadString()
	
	
	chat.AddText( Color( 128, 255, 245 ), "***********************")
	chat.AddText( Color( 128, 255, 170 ), "Идентификатор:")
	chat.AddText( Color( 128, 255, 170 ), citizen_id)
	chat.AddText( Color( 128, 255, 245 ), "***********************")
end)

net.Receive("idcards_show_combine", function()

	local rank = net.ReadString()
	local citizen_id = net.ReadString()
	
	chat.AddText( Color( 255, 255, 255 ), "***********************")
	chat.AddText( Color( 255, 165, 0 ), rank)
	chat.AddText( Color( 255, 165, 0 ), "Идентификатор: " .. citizen_id)
	chat.AddText( Color( 128, 255, 245 ), "***********************")
end)

net.Receive("idcards_show_certificate", function()
	local shower = net.ReadString()
	local str = net.ReadString()
	local datetime = net.ReadString()
	
	chat.AddText( Color( 128, 255, 245 ), "***********************")
	chat.AddText( Color( 128, 255, 170 ), "Сертификат: ")
	chat.AddText( Color( 128, 255, 170 ), "Имя, фамилия: " .. shower)
	chat.AddText( Color( 128, 255, 170 ), "Специальность: " .. str)
	chat.AddText( Color( 128, 255, 170 ), "Дата выдачи: " .. datetime)
	chat.AddText( Color( 128, 255, 245 ), "***********************")
end)

net.Receive("idcards_show_ticket", function()
	local shower = net.ReadString()
	local city = net.ReadString()
	local datetime = net.ReadString()
	
	chat.AddText( Color( 128, 255, 245 ), "***********************")
	chat.AddText( Color( 200, 200, 200 ), "Миграционный билет: ")
	chat.AddText( Color( 200, 200, 200 ), "Имя, фамилия: " .. shower)
	chat.AddText( Color( 200, 200, 200 ), "Город отбытия: " .. city)
	chat.AddText( Color( 200, 200, 200 ), "Дата прибытия в индустриальный сектор: " .. datetime)
	chat.AddText( Color( 128, 255, 245 ), "***********************")
end)