-- "addons\\darkrpmodification\\lua\\entities\\info_npc\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

net.Receive("InfoNPC.OpenMenu", function()
	CUWInfo()
end)

function CUWInfo()
	local frame = vgui.Create("DFrame")
	frame:SetSize(400,450)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "Информация" )
	frame.Paint = function(s,w,h)
		draw.RoundedBox(1,0,0,w,h,Color(15,15,15, 190))
	end	
	
	local text01 = vgui.Create( "DLabel", frame )
	text01:SetSize(1000,20)
	text01:SetPos( 25, 50 )
	text01:SetFont("i_like_dis_font")
	text01:SetText( "Здравствуй!" )
	
	local text02 = vgui.Create( "DLabel", frame )
	text02:SetSize(1000,20)
	text02:SetPos( 25, 70 )
	text02:SetFont("i_like_dis_font")
	text02:SetText( "Ты уже вступил в ряды соотрудников ГСР?" )
	
	local text03 = vgui.Create( "DLabel", frame )
	text03:SetSize(1000,20)
	text03:SetPos( 25, 90 )
	text03:SetFont("i_like_dis_font")
	text03:SetText( "В любом случае у меня ты можешь узнать" )
	
	local text04 = vgui.Create( "DLabel", frame )
	text04:SetSize(1000,20)
	text04:SetPos( 25, 110 )
	text04:SetFont("i_like_dis_font")
	text04:SetText( "всё о различных видах деятельности." )
	
	local button01 = vgui.Create("DButton", frame)
	button01:SetText( "Уборка мусора" )
	button01:SetFont("i_like_dis_font")
	button01:SetPos( 20, 150 )
	button01:SetSize( 360, 30 )
	button01.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 45, 175, 85, 225 ) )
	end
	button01.DoClick = function()
		CUWInfo01()
		frame:Close()
	end
	
	local button02 = vgui.Create("DButton", frame)
	button02:SetText( "Доставка компонентов" )
	button02:SetFont("i_like_dis_font")
	button02:SetPos( 20, 200 )
	button02:SetSize( 360, 30 )
	button02.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 45, 175, 85, 225 ) )
	end
	button02.DoClick = function()
		CUWInfo02()
		frame:Close()
	end
	
	local button03 = vgui.Create("DButton", frame)
	button03:SetText( "Обработка мяса" )
	button03:SetFont("i_like_dis_font")
	button03:SetPos( 20, 250 )
	button03:SetSize( 360, 30 )
	button03.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 45, 175, 85, 225 ) )
	end
	button03.DoClick = function()
		CUWInfo03()
		frame:Close()
	end
	
	local button04 = vgui.Create("DButton", frame)
	button04:SetText( "Заправка раздатчиков" )
	button04:SetFont("i_like_dis_font")
	button04:SetPos( 20, 300 )
	button04:SetSize( 360, 30 )
	button04.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 45, 175, 85, 225 ) )
	end
	button04.DoClick = function()
		CUWInfo04()
		frame:Close()
	end
	
	local button05 = vgui.Create("DButton", frame)
	button05:SetText( "Киномеханик" )
	button05:SetFont("i_like_dis_font")
	button05:SetPos( 20, 350 )
	button05:SetSize( 360, 30 )
	button05.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color( 45, 175, 85, 225 ) )
	end
	button05.DoClick = function()
		CUWInfo05()
		frame:Close()
	end
end

function CUWInfo01()
	local frame = vgui.Create("DFrame")
	frame:SetSize(400,250)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "Уборка мусора" )
	frame.Paint = function(s,w,h)
		draw.RoundedBox(1,0,0,w,h,Color(15,15,15, 190))
	end	
	
	local text01 = vgui.Create( "DLabel", frame )
	text01:SetSize(1000,20)
	text01:SetPos( 35, 50 )
	text01:SetFont("Trebuchet18")
	text01:SetText( "Уборка мусора в городе заключается в" )
	
	local text02 = vgui.Create( "DLabel", frame )
	text02:SetSize(1000,20)
	text02:SetPos( 25, 70 )
	text02:SetFont("Trebuchet18")
	text02:SetText( "своевременном очищении города от результата" )
	
	local text03 = vgui.Create( "DLabel", frame )
	text03:SetSize(1000,20)
	text03:SetPos( 25, 90 )
	text03:SetFont("Trebuchet18")
	text03:SetText( "жизнидеятельности жителей его населяющих," )
	
	local text04 = vgui.Create( "DLabel", frame )
	text04:SetSize(1000,20)
	text04:SetPos( 25, 110 )
	text04:SetFont("Trebuchet18")
	text04:SetText( "в основном это использованные рационы питания." )
	
	local text05 = vgui.Create( "DLabel", frame )
	text05:SetSize(1000,20)
	text05:SetPos( 25, 130 )
	text05:SetFont("Trebuchet18")
	text05:SetText( "Далее вам необходимо отнести их на специальный" )
	
	local text06 = vgui.Create( "DLabel", frame )
	text06:SetSize(1000,20)
	text06:SetPos( 25, 150 )
	text06:SetFont("Trebuchet18")
	text06:SetText( "мусороперерабатывающий завод." )
	
	local button01 = vgui.Create("DButton", frame)
	button01:SetText( "Назад" )
	button01:SetPos( 100, 190 )
	button01:SetSize( 200, 30 )
	button01.DoClick = function()
		CUWInfo()
		frame:Close()
	end
end

function CUWInfo02()
	local frame = vgui.Create("DFrame")
	frame:SetSize(400,250)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "Доставка компонентов" )
	frame.Paint = function(s,w,h)
		draw.RoundedBox(1,0,0,w,h,Color(15,15,15, 190))
	end	
	
	local text01 = vgui.Create( "DLabel", frame )
	text01:SetSize(1000,20)
	text01:SetPos( 35, 50 )
	text01:SetFont("Trebuchet18")
	text01:SetText( "Первое звено в создании питательных рационов" )
	
	local text02 = vgui.Create( "DLabel", frame )
	text02:SetSize(1000,20)
	text02:SetPos( 25, 70 )
	text02:SetFont("Trebuchet18")
	text02:SetText( "заключается в доставке необходимых компонентов." )
	
	local text03 = vgui.Create( "DLabel", frame )
	text03:SetSize(1000,20)
	text03:SetPos( 25, 90 )
	text03:SetFont("Trebuchet18")
	text03:SetText( "1. Мясо - поставки находятся на складе" )
	
	local text04 = vgui.Create( "DLabel", frame )
	text04:SetSize(1000,20)
	text04:SetPos( 25, 110 )
	text04:SetFont("Trebuchet18")
	text04:SetText( "2. Энзимы - поставки находятся возле грузовика" )
	
	local text05 = vgui.Create( "DLabel", frame )
	text05:SetSize(1000,20)
	text05:SetPos( 25, 135 )
	text05:SetFont("Trebuchet18")
	text05:SetText( "Всё это нужно принести на завод." )
	
	local text06 = vgui.Create( "DLabel", frame )
	text06:SetSize(1000,20)
	text06:SetPos( 25, 155 )
	text06:SetFont("Trebuchet18")
	text06:SetText( "Мясо на стол, Энзимы в контейнер." )
	
	local button01 = vgui.Create("DButton", frame)
	button01:SetText( "Назад" )
	button01:SetPos( 100, 190 )
	button01:SetSize( 200, 30 )
	button01.DoClick = function()
		CUWInfo()
		frame:Close()
	end
end

function CUWInfo03()
	local frame = vgui.Create("DFrame")
	frame:SetSize(400,250)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "Обработка мяса" )
	frame.Paint = function(s,w,h)
		draw.RoundedBox(1,0,0,w,h,Color(15,15,15, 190))
	end	
	
	local text01 = vgui.Create( "DLabel", frame )
	text01:SetSize(1000,20)
	text01:SetPos( 35, 50 )
	text01:SetFont("Trebuchet18")
	text01:SetText( "Обработка мяса производится в 2 этапа:" )
	
	local text02 = vgui.Create( "DLabel", frame )
	text02:SetSize(1000,20)
	text02:SetPos( 25, 75 )
	text02:SetFont("Trebuchet18")
	text02:SetText( "1. Обработка плазменно-кислотным аппаратом" )
	
	local text03 = vgui.Create( "DLabel", frame )
	text03:SetSize(1000,20)
	text03:SetPos( 25, 95 )
	text03:SetFont("Trebuchet18")
	text03:SetText( "2. Термическая обработка в цилиндрей" )
	
	local text04 = vgui.Create( "DLabel", frame )
	text04:SetSize(1000,20)
	text04:SetPos( 25, 120 )
	text04:SetFont("Trebuchet18")
	text04:SetText( "Далее готовое мясо необходимо поместить в" )
	
	local text05 = vgui.Create( "DLabel", frame )
	text05:SetSize(1000,20)
	text05:SetPos( 25, 140 )
	text05:SetFont("Trebuchet18")
	text05:SetText( "специальный контейнер, который находится" )
	
	local text06 = vgui.Create( "DLabel", frame )
	text06:SetSize(1000,20)
	text06:SetPos( 25, 160 )
	text06:SetFont("Trebuchet18")
	text06:SetText( "непосредственно с вашим рабочим местом." )
	
	local button01 = vgui.Create("DButton", frame)
	button01:SetText( "Назад" )
	button01:SetPos( 100, 190 )
	button01:SetSize( 200, 30 )
	button01.DoClick = function()
		CUWInfo()
		frame:Close()
	end
end

function CUWInfo04()
	local frame = vgui.Create("DFrame")
	frame:SetSize(400,250)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "Заправка раздатчиков рационов питания" )
	frame.Paint = function(s,w,h)
		draw.RoundedBox(1,0,0,w,h,Color(15,15,15, 190))
	end	
	
	local text01 = vgui.Create( "DLabel", frame )
	text01:SetSize(1000,20)
	text01:SetPos( 35, 50 )
	text01:SetFont("Trebuchet18")
	text01:SetText( "Заключительный этап важной для города цепочки" )
	
	local text02 = vgui.Create( "DLabel", frame )
	text02:SetSize(1000,20)
	text02:SetPos( 25, 70 )
	text02:SetFont("Trebuchet18")
	text02:SetText( "создания рационов питания заключается в сборе" )
	
	local text03 = vgui.Create( "DLabel", frame )
	text03:SetSize(1000,20)
	text03:SetPos( 25, 90 )
	text03:SetFont("Trebuchet18")
	text03:SetText( "всех 3 компонентов:" )
	
	local text04 = vgui.Create( "DLabel", frame )
	text04:SetSize(1000,20)
	text04:SetPos( 25, 110 )
	text04:SetFont("Trebuchet18")
	text04:SetText( "Вода  -  Мясо  -  Энзимы" )
	
	local text05 = vgui.Create( "DLabel", frame )
	text05:SetSize(1000,20)
	text05:SetPos( 25, 130 )
	text05:SetFont("Trebuchet18")
	text05:SetText( "Главное соблюсти правильную пропорцию. А затем" )
	
	local text06 = vgui.Create( "DLabel", frame )
	text06:SetSize(1000,20)
	text06:SetPos( 25, 150 )
	text06:SetFont("Trebuchet18")
	text06:SetText( "отнести и заправить раздатчики." )
	
	local button01 = vgui.Create("DButton", frame)
	button01:SetText( "Назад" )
	button01:SetPos( 100, 190 )
	button01:SetSize( 200, 30 )
	button01.DoClick = function()
		CUWInfo()
		frame:Close()
	end
end

function CUWInfo05()
	local frame = vgui.Create("DFrame")
	frame:SetSize(400,250)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "Киномеханик" )
	frame.Paint = function(s,w,h)
		draw.RoundedBox(1,0,0,w,h,Color(15,15,15, 190))
	end	
	
	local text01 = vgui.Create( "DLabel", frame )
	text01:SetSize(1000,20)
	text01:SetPos( 35, 50 )
	text01:SetFont("Trebuchet18")
	text01:SetText( "Киномеханик отвечает за осуществление" )
	
	local text02 = vgui.Create( "DLabel", frame )
	text02:SetSize(1000,20)
	text02:SetPos( 25, 70 )
	text02:SetFont("Trebuchet18")
	text02:SetText( "кинопоказов в городе. Продавайте гражданам " )
	
	local text03 = vgui.Create( "DLabel", frame )
	text03:SetSize(1000,20)
	text03:SetPos( 25, 90 )
	text03:SetFont("Trebuchet18")
	text03:SetText( "наушники и по соглашению с ГО проводите показы" )
	
	local text04 = vgui.Create( "DLabel", frame )
	text04:SetSize(1000,20)
	text04:SetPos( 25, 110 )
	text04:SetFont("Trebuchet18")
	text04:SetText( "фильмов." )
	
	local button01 = vgui.Create("DButton", frame)
	button01:SetText( "Назад" )
	button01:SetPos( 100, 190 )
	button01:SetSize( 200, 30 )
	button01.DoClick = function()
		CUWInfo()
		frame:Close()
	end
end

function CUWInfo06()
	local frame = vgui.Create("DFrame")
	frame:SetSize(400,250)
	frame:Center()
	frame:SetVisible(true)
	frame:MakePopup()
	frame:SetTitle( "Управляющий ГСР" )
	frame.Paint = function(s,w,h)
		draw.RoundedBox(1,0,0,w,h,Color(15,15,15, 190))
	end	
	
	local text01 = vgui.Create( "DLabel", frame )
	text01:SetSize(1000,20)
	text01:SetPos( 35, 50 )
	text01:SetFont("Trebuchet18")
	text01:SetText( "Вам предоставлена честь работать в системе" )
	
	local text02 = vgui.Create( "DLabel", frame )
	text02:SetSize(1000,20)
	text02:SetPos( 25, 70 )
	text02:SetFont("Trebuchet18")
	text02:SetText( "управления сотрудниками рабочего класса города." )
	
	local text03 = vgui.Create( "DLabel", frame )
	text03:SetSize(1000,20)
	text03:SetPos( 25, 90 )
	text03:SetFont("Trebuchet18")
	text03:SetText( "В ваши обязанности входит осуществление занятости" )
	
	local text04 = vgui.Create( "DLabel", frame )
	text04:SetSize(1000,20)
	text04:SetPos( 25, 110 )
	text04:SetFont("Trebuchet18")
	text04:SetText( "безработной части города. А также контроль за теми" )
	
	local text05 = vgui.Create( "DLabel", frame )
	text05:SetSize(1000,20)
	text05:SetPos( 25, 130 )
	text05:SetFont("Trebuchet18")
	text05:SetText( "кто уже состоит в рядах сотрудников ГСР." )
	
	local text06 = vgui.Create( "DLabel", frame )
	text06:SetSize(1000,20)
	text06:SetPos( 25, 150 )
	text06:SetFont("Trebuchet18")
	text06:SetText( "Альянс доверяет вам, не подведите." )
	
	local button01 = vgui.Create("DButton", frame)
	button01:SetText( "Назад" )
	button01:SetPos( 100, 190 )
	button01:SetSize( 200, 30 )
	button01.DoClick = function()
		CUWInfo()
		frame:Close()
	end
end