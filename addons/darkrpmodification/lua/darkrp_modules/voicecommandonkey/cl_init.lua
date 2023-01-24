-- "addons\\darkrpmodification\\lua\\darkrp_modules\\voicecommandonkey\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local panel0 local panel1 local panel2 local panel3 local panel4 local panel5 local panel6 local panel7 local panel8 local panel9 local bool0 = false local bool1 = false local bool2 = false local bool3 = false local bool4 = false local bool5 = false local bool6 = false local bool7 = false local bool8 = false local bool9 = false
local combpanel0 local combpanel1 local combpanel2 local combpanel3 local combpanel4 local combpanel5 local combpanel6 local combbool0 = false local combbool1 = false local combbool2 = false local combbool3 = false local combbool4 = false local combbool5 = false local combbool6 = false

local VoicePanels = {}
local combVoicePanels = {}

hook.Add( "PlayerButtonDown", "KeyDown_Voice", function(ply, button)
	if ply:isCP() then
		if GAMEMODE.MetropoliceJobs[ply:Team()] then
			local isopen0 = false
			local isopen1 = false
			
			if button == KEY_PAD_0 and isopen0 == false then
				isopen0 = true
				bool0 = true
				
				if panel0 != nil then panel0:Remove() end
				
				panel0 = vgui.Create("VoiceMenu0") 
				panel0:Init()
				table.insert(VoicePanels, 0, panel0)
			end
			
			if button == KEY_PAD_1 and bool0 == true then
				bool0 = false
				panel0:Remove()
				
				panel1 = vgui.Create("VoiceMenu1") 
				panel1:Init()
				table.insert(VoicePanels, 1, panel1)
				
				timer.Simple(0.01, function() bool1 = true end)
			end
			
			if button == KEY_PAD_2 and bool0 == true then
				bool0 = false
				panel0:Remove()
				
				panel2 = vgui.Create("VoiceMenu2") 
				panel2:Init()
				table.insert(VoicePanels, 2, panel2)
				
				timer.Simple(0.01, function() bool2 = true end)
			end
			
			if button == KEY_PAD_3 and bool0 == true then
				bool0 = false
				panel0:Remove()
				
				panel3 = vgui.Create("VoiceMenu3") 
				panel3:Init()
				table.insert(VoicePanels, 3, panel3)
				
				timer.Simple(0.01, function() bool3 = true end)
			end
			
			if button == KEY_PAD_4 and bool0 == true then
				bool0 = false
				panel0:Remove()
				
				panel4 = vgui.Create("VoiceMenu4") 
				panel4:Init()
				table.insert(VoicePanels, 4, panel4)
				
				timer.Simple(0.01, function() bool4 = true end)
			end
			
			if button == KEY_PAD_5 and bool0 == true then
				bool0 = false
				panel0:Remove()
				
				panel5 = vgui.Create("VoiceMenu5") 
				panel5:Init()
				table.insert(VoicePanels, 5, panel5)
				
				timer.Simple(0.01, function() bool5 = true end)
			end
			
			if button == KEY_PAD_6 and bool0 == true then
				bool0 = false
				panel0:Remove()
				
				panel6 = vgui.Create("VoiceMenu6") 
				panel6:Init()
				table.insert(VoicePanels, 6, panel6)
				
				timer.Simple(0.01, function() bool6 = true end)
			end
			
			if button == KEY_PAD_7 and bool0 == true then
				bool0 = false
				panel0:Remove()
				
				panel7 = vgui.Create("VoiceMenu7") 
				panel7:Init()
				table.insert(VoicePanels, 7, panel7)
				
				timer.Simple(0.01, function() bool7 = true end)
			end
			
			if button == KEY_PAD_8 and bool0 == true then
				bool0 = false
				panel0:Remove()
				
				panel8 = vgui.Create("VoiceMenu8") 
				panel8:Init()
				table.insert(VoicePanels, 8, panel8)
				
				timer.Simple(0.01, function() bool8 = true end)
			end
			
			if button == KEY_PAD_9 and bool0 == true then
				bool0 = false
				panel0:Remove()
					
				panel9 = vgui.Create("VoiceMenu9") 
				panel9:Init()
				table.insert(VoicePanels, 9, panel9)
					
				timer.Simple(0.01, function() bool9 = true end)
			end
			
			if button == KEY_PAD_1 and bool1 == true then
				isopen1 = false
				RunConsoleCommand("say", "Гражданин.")
			end	
			if button == KEY_PAD_2 and bool1 == true then
				isopen1 = false
				RunConsoleCommand("say", "Документ.")
			end	
			if button == KEY_PAD_3 and bool1 == true then
				isopen1 = false
				RunConsoleCommand("say", "Полный порядок.")
			end	
			if button == KEY_PAD_4 and bool1 == true then
				isopen1 = false
				RunConsoleCommand("say", "Проходи.")
			end	
			if button == KEY_PAD_5 and bool1 == true then
				isopen1 = false
				RunConsoleCommand("say", "Можешь идти.")
			end
			if button == KEY_PAD_6 and bool1 == true then
				isopen1 = false
				RunConsoleCommand("say", "Первое предупреждение, отойти.")
			end
			if button == KEY_PAD_7 and bool1 == true then
				isopen1 = false
				RunConsoleCommand("say", "Второе предупреждение.")
			end
			if button == KEY_PAD_8 and bool1 == true then
				isopen1 = false
				RunConsoleCommand("say", "Последнее предупреждение.")
			end
			if button == KEY_PAD_9 and bool1 == true then
				isopen1 = false
				RunConsoleCommand("say", "Готовьтесь к отправлению правосудия.")
			end
			
			if button == KEY_PAD_1 and bool2 == true then
				isopen1 = false
				RunConsoleCommand("say", "Стоять!")
			end	
			if button == KEY_PAD_2 and bool2 == true then
				isopen1 = false
				RunConsoleCommand("say", "Стоять на месте!")
			end	
			if button == KEY_PAD_3 and bool2 == true then
				isopen1 = false
				RunConsoleCommand("say", "Всем оставаться на месте!")
			end	
			if button == KEY_PAD_4 and bool2 == true then
				isopen1 = false
				RunConsoleCommand("say", "Назад немедленно!")
			end	
			if button == KEY_PAD_5 and bool2 == true then
				isopen1 = false
				RunConsoleCommand("say", "Я сказал отойти!")
			end
			if button == KEY_PAD_6 and bool2 == true then
				isopen1 = false
				RunConsoleCommand("say", "А теперь убирайся!")
			end
			if button == KEY_PAD_7 and bool2 == true then
				isopen1 = false
				RunConsoleCommand("say", "Двигайся!")
			end
			
			if button == KEY_PAD_1 and bool3 == true then
				isopen1 = false
				RunConsoleCommand("say", "Так точно.")
			end	
			if button == KEY_PAD_2 and bool3 == true then
				isopen1 = false
				RunConsoleCommand("say", "Вас понял.")
			end	
			if button == KEY_PAD_3 and bool3 == true then
				isopen1 = false
				RunConsoleCommand("say", "Зафиксировано нападение.")
			end	
			if button == KEY_PAD_4 and bool3 == true then
				isopen1 = false
				RunConsoleCommand("say", "Приговор приведен в исполнение.")
			end	
			if button == KEY_PAD_5 and bool3 == true then
				isopen1 = false
				RunConsoleCommand("say", "Готов к отсечению.")
			end
			if button == KEY_PAD_6 and bool3 == true then
				isopen1 = false
				RunConsoleCommand("say", "Выдвигаюсь.")
			end
			if button == KEY_PAD_7 and bool3 == true then
				isopen1 = false
				RunConsoleCommand("say", "Продолжаю поиск.")
			end
			if button == KEY_PAD_8 and bool3 == true then
				isopen1 = false
				RunConsoleCommand("say", "Объект не обнаружен.")
			end
			if button == KEY_PAD_9 and bool3 == true then
				isopen1 = false
				RunConsoleCommand("say", "Здесь все в порядке.")
			end
			
			if button == KEY_PAD_1 and bool4 == true then
				isopen1 = false
				RunConsoleCommand("say", "Все чисто.")
			end	
			if button == KEY_PAD_2 and bool4 == true then
				isopen1 = false
				RunConsoleCommand("say", "Готов.")
			end	
			if button == KEY_PAD_3 and bool4 == true then
				isopen1 = false
				RunConsoleCommand("say", "Нарушитель.")
			end	
			if button == KEY_PAD_4 and bool4 == true then
				isopen1 = false
				RunConsoleCommand("say", "Вот он!")
			end	
			if button == KEY_PAD_5 and bool4 == true then
				isopen1 = false
				RunConsoleCommand("say", "Вон он!")
			end
			if button == KEY_PAD_6 and bool4 == true then
				isopen1 = false
				RunConsoleCommand("say", "Убит.")
			end
			if button == KEY_PAD_7 and bool4 == true then
				isopen1 = false
				RunConsoleCommand("say", "Вирусное загрязнение.")
			end
			if button == KEY_PAD_8 and bool4 == true then
				isopen1 = false
				RunConsoleCommand("say", "Инфекция.")
			end
			if button == KEY_PAD_9 and bool4 == true then
				isopen1 = false
				RunConsoleCommand("say", "Некротики.")
			end
			
			if button == KEY_PAD_1 and bool5 == true then
				isopen1 = false
				RunConsoleCommand("say", "Зомби убит.")
			end	
			if button == KEY_PAD_2 and bool5 == true then
				isopen1 = false
				RunConsoleCommand("say", "Злоумышленник.")
			end	
			if button == KEY_PAD_3 and bool5 == true then
				isopen1 = false
				RunConsoleCommand("say", "Неизвестный.")
			end	
			if button == KEY_PAD_4 and bool5 == true then
				isopen1 = false
				RunConsoleCommand("say", "Объект подходит по ориентировке.")
			end	
			if button == KEY_PAD_5 and bool5 == true then
				isopen1 = false
				RunConsoleCommand("say", "Угроза обществу.")
			end
			if button == KEY_PAD_6 and bool5 == true then
				isopen1 = false
				RunConsoleCommand("say", "Мятеж.")
			end
			if button == KEY_PAD_7 and bool5 == true then
				isopen1 = false
				RunConsoleCommand("say", "Предписание о неповиновении.")
			end
			if button == KEY_PAD_8 and bool5 == true then
				isopen1 = false
				RunConsoleCommand("say", "Восстанавливаю порядок.")
			end
			if button == KEY_PAD_9 and bool5 == true then
				isopen1 = false
				RunConsoleCommand("say", "Приговор вынесен.")
			end
			
			if button == KEY_PAD_1 and bool6 == true then
				isopen1 = false
				RunConsoleCommand("say", "Приступление присечено.")
			end	
			if button == KEY_PAD_2 and bool6 == true then
				isopen1 = false
				RunConsoleCommand("say", "Прикройте меня, отхожу.")
			end	
			if button == KEY_PAD_3 and bool6 == true then
				isopen1 = false
				RunConsoleCommand("say", "Боезапас на исходе, иду в укрытие.")
			end	
			if button == KEY_PAD_4 and bool6 == true then
				isopen1 = false
				RunConsoleCommand("say", "Что то есть.")
			end	
			if button == KEY_PAD_5 and bool6 == true then
				isopen1 = false
				RunConsoleCommand("say", "Осторожно.")
			end
			if button == KEY_PAD_6 and bool6 == true then
				isopen1 = false
				RunConsoleCommand("say", "Ищешь неприятности.")
			end
			if button == KEY_PAD_7 and bool6 == true then
				isopen1 = false
				RunConsoleCommand("say", "Хочешь в участок.")
			end
			if button == KEY_PAD_8 and bool6 == true then
				isopen1 = false
				RunConsoleCommand("say", "Черт.")
			end
			if button == KEY_PAD_9 and bool6 == true then
				isopen1 = false
				RunConsoleCommand("say", "Ха ха ха.")
			end
			
			if button == KEY_PAD_1 and bool7 == true then
				isopen1 = false
				RunConsoleCommand("say", "Присечь.")
			end	
			if button == KEY_PAD_2 and bool7 == true then
				isopen1 = false
				RunConsoleCommand("say", "Проверить.")
			end	
			if button == KEY_PAD_3 and bool7 == true then
				isopen1 = false
				RunConsoleCommand("say", "Задержать.")
			end	
			if button == KEY_PAD_4 and bool7 == true then
				isopen1 = false
				RunConsoleCommand("say", "Фиксировать.")
			end	
			if button == KEY_PAD_5 and bool7 == true then
				isopen1 = false
				RunConsoleCommand("say", "Изолировать.")
			end
			if button == KEY_PAD_6 and bool7 == true then
				isopen1 = false
				RunConsoleCommand("say", "Стерилизовать.")
			end
			if button == KEY_PAD_7 and bool7 == true then
				isopen1 = false
				RunConsoleCommand("say", "Отсечь.")
			end
			
			if button == KEY_PAD_1 and bool8 == true then
				isopen1 = false
				RunConsoleCommand("say", "Искать.")
			end	
			if button == KEY_PAD_2 and bool8 == true then
				isopen1 = false
				RunConsoleCommand("say", "Применить.")
			end	
			if button == KEY_PAD_3 and bool8 == true then
				isopen1 = false
				RunConsoleCommand("say", "Проверить численность.")
			end	
			if button == KEY_PAD_4 and bool8 == true then
				isopen1 = false
				RunConsoleCommand("say", "Патруль.")
			end	
			if button == KEY_PAD_5 and bool8 == true then
				isopen1 = false
				RunConsoleCommand("say", "Вмешаться.")
			end
			if button == KEY_PAD_6 and bool8 == true then
				isopen1 = false
				RunConsoleCommand("say", "Расследовать.")
			end
			if button == KEY_PAD_7 and bool8 == true then
				isopen1 = false
				RunConsoleCommand("say", "Оставаться на позиции.")
			end
			
			if button == KEY_PAD_1 and bool9 == true then
				isopen1 = false
				RunConsoleCommand("say", "Выйти к назначенным точкам.")
			end	
			if button == KEY_PAD_2 and bool9 == true then
				isopen1 = false
				RunConsoleCommand("say", "Отряд вперед.")
			end	
			if button == KEY_PAD_3 and bool9 == true then
				isopen1 = false
				RunConsoleCommand("say", "Назад.")
			end	
			if button == KEY_PAD_4 and bool9 == true then
				isopen1 = false
				RunConsoleCommand("say", "Продолжаем.")
			end	
			if button == KEY_PAD_5 and bool9 == true then
				isopen1 = false
				RunConsoleCommand("say", "Выполнять.")
			end
			if button == KEY_PAD_6 and bool9 == true then
				isopen1 = false
				RunConsoleCommand("say", "Всем выдвигаться.")
			end
			if button == KEY_PAD_7 and bool9 == true then
				isopen1 = false
				RunConsoleCommand("say", "Набор рабочих.")
			end
		elseif GAMEMODE.CombineJobs[ply:Team()] then
			local combisopen0 = false
			local combisopen1 = false
			
			if button == KEY_PAD_0 and combisopen0 == false then
				combisopen0 = true
				combbool0 = true
				
				if combpanel0 != nil then combpanel0:Remove() end
				
				combpanel0 = vgui.Create("combVoiceMenu0") 
				combpanel0:Init()
				table.insert(combVoicePanels, 0, combpanel0)
			end
			
			if button == KEY_PAD_1 and combbool0 == true then
				combbool0 = false
				combpanel0:Remove()
				
				combpanel1 = vgui.Create("combVoiceMenu1") 
				combpanel1:Init()
				table.insert(combVoicePanels, 1, combpanel1)
				
				timer.Simple(0.01, function() combbool1 = true end)
			end
			
			if button == KEY_PAD_2 and combbool0 == true then
				combbool0 = false
				combpanel0:Remove()
				
				combpanel2 = vgui.Create("combVoiceMenu2") 
				combpanel2:Init()
				table.insert(combVoicePanels, 2, combpanel2)
				
				timer.Simple(0.01, function() combbool2 = true end)
			end
			
			if button == KEY_PAD_3 and combbool0 == true then
				combbool0 = false
				combpanel0:Remove()
				
				combpanel3 = vgui.Create("combVoiceMenu3") 
				combpanel3:Init()
				table.insert(combVoicePanels, 3, combpanel3)
				
				timer.Simple(0.01, function() combbool3 = true end)
			end
			
			if button == KEY_PAD_4 and combbool0 == true then
				combbool0 = false
				combpanel0:Remove()
				
				combpanel4 = vgui.Create("combVoiceMenu4") 
				combpanel4:Init()
				table.insert(combVoicePanels, 4, combpanel4)
				
				timer.Simple(0.01, function() combbool4 = true end)
			end
			
			if button == KEY_PAD_5 and combbool0 == true then
				combbool0 = false
				combpanel0:Remove()
				
				combpanel5 = vgui.Create("combVoiceMenu5") 
				combpanel5:Init()
				table.insert(combVoicePanels, 5, combpanel5)
				
				timer.Simple(0.01, function() combbool5 = true end)
			end
			
			if button == KEY_PAD_6 and combbool0 == true then
				combbool0 = false
				combpanel0:Remove()
				
				combpanel6 = vgui.Create("combVoiceMenu6") 
				combpanel6:Init()
				table.insert(combVoicePanels, 5, combpanel6)
				
				timer.Simple(0.01, function() combbool6 = true end)
			end
			
			if button == KEY_PAD_1 and combbool1 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Попадание.")
			end	
			if button == KEY_PAD_2 and combbool1 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Нарушитель номер 1.")
			end	
			if button == KEY_PAD_3 and combbool1 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Защита держит.")
			end	
			if button == KEY_PAD_4 and combbool1 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Паразиты.")
			end	
			if button == KEY_PAD_5 and combbool1 == true then
				combisopen1 = false
				RunConsoleCommand("say", "В секторе опасные формы жизни.")
			end
			if button == KEY_PAD_6 and combbool1 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Чисто.")
			end
			if button == KEY_PAD_7 and combbool1 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Контакт.")
			end
			if button == KEY_PAD_8 and combbool1 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Преследую.")
			end
			if button == KEY_PAD_9 and combbool1 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Убит.")
			end
			
			if button == KEY_PAD_1 and combbool2 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Кидаю гранату!")
			end	
			if button == KEY_PAD_2 and combbool2 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Граната!")
			end	
			if button == KEY_PAD_3 and combbool2 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Вижу.")
			end	
			if button == KEY_PAD_4 and combbool2 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Не вижу.")
			end	
			if button == KEY_PAD_5 and combbool2 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Некротики.")
			end
			if button == KEY_PAD_6 and combbool2 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Мятеж.")
			end
			if button == KEY_PAD_7 and combbool2 == true then
				combisopen1 = false
				RunConsoleCommand("say", "В секторе опасность.")
			end
			if button == KEY_PAD_8 and combbool2 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Выдвигаюсь.")
			end
			if button == KEY_PAD_9 and combbool2 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Легко ранен.")
			end
			
			if button == KEY_PAD_1 and combbool3 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Есть.")
			end	
			if button == KEY_PAD_2 and combbool3 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Лидер.")
			end	
			if button == KEY_PAD_3 and combbool3 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Требуются стимуляторы.")
			end	
			if button == KEY_PAD_4 and combbool3 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Рота.")
			end	
			if button == KEY_PAD_5 and combbool3 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Жду указаний.")
			end
			
			if button == KEY_PAD_1 and combbool4 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Ложись, ложись!")
			end	
			if button == KEY_PAD_2 and combbool4 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Прикрой!")
			end	
			if button == KEY_PAD_3 and combbool4 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Уходим!")
			end	
			if button == KEY_PAD_4 and combbool4 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Держать позицию.")
			end	
			if button == KEY_PAD_5 and combbool4 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Гранаты к бою.")
			end
			if button == KEY_PAD_6 and combbool4 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Оружие к бою.")
			end
			
			if button == KEY_PAD_1 and combbool5 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Доложить об опасности.")
			end	
			if button == KEY_PAD_2 and combbool5 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Внимательно докладывайте обо всём.")
			end	
			if button == KEY_PAD_3 and combbool5 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Рота готова, прочесываем.")
			end	
			if button == KEY_PAD_4 and combbool5 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Отлично, добей его.")
			end	
			if button == KEY_PAD_5 and combbool5 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Не стрелять.")
			end
			if button == KEY_PAD_6 and combbool5 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Выполняй.")
			end 
			
			if button == KEY_PAD_1 and combbool6 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Укрыться!")
			end	
			if button == KEY_PAD_2 and combbool6 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Направо!")
			end	
			if button == KEY_PAD_3 and combbool6 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Налево!")
			end	
			if button == KEY_PAD_4 and combbool6 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Стоять!")
			end	
			if button == KEY_PAD_5 and combbool6 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Группа!")
			end
			if button == KEY_PAD_6 and combbool6 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Вперед!")
			end
			if button == KEY_PAD_7 and combbool7 == true then
				combisopen1 = false
				RunConsoleCommand("say", "Наступать!")
			end
		end
	end
end )

hook.Add( "PlayerButtonUp", "KeyDown_Voice", function(ply, button)
if ply:isCP() then
	if button == KEY_PAD_0 then
		bool0 = false
		bool1 = false
		bool2 = false
		bool3 = false
		bool4 = false
		bool5 = false
		bool6 = false
		bool7 = false
		bool8 = false
		bool9 = false
		
		for k,v in pairs(VoicePanels) do
			v:Remove()
		end
		
		combbool0 = false
		combbool1 = false
		combbool2 = false
		combbool3 = false
		combbool4 = false
		combbool5 = false
		combbool6 = false
		combbool7 = false
		combbool8 = false
		combbool9 = false
		
		for k,v in pairs(combVoicePanels) do
			v:Remove()
		end
	end
end
end )

local PANEL0 = {}
function PANEL0:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("1. Обращения к гражданским")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,25)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("2. Приказы гражданским")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,50)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("3. Ответы")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,75)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("4. Общие I")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,100)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("5. Общие II")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,125)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("6. Общие III")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,150)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("7. Приказы I")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,175)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("8. Приказы II")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,200)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("9. Приказы III")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,225)
end
vgui.Register("VoiceMenu0",PANEL0,"DFrame")

local PANEL1 = {}
function PANEL1:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel1 = vgui.Create("DLabel",self)
	self.MyDLabel1:SetText("1. Гражданин.")
	self.MyDLabel1:SizeToContents()
	self.MyDLabel1:SetPos(25,25)
	
	self.MyDLabel2 = vgui.Create("DLabel",self)
	self.MyDLabel2:SetText("2. Документ.")
	self.MyDLabel2:SizeToContents()
	self.MyDLabel2:SetPos(25,50)
	
	self.MyDLabel3 = vgui.Create("DLabel",self)
	self.MyDLabel3:SetText("3. Полный порядок.")
	self.MyDLabel3:SizeToContents()
	self.MyDLabel3:SetPos(25,75)
	
	self.MyDLabel4 = vgui.Create("DLabel",self)
	self.MyDLabel4:SetText("4. Проходи.")
	self.MyDLabel4:SizeToContents()
	self.MyDLabel4:SetPos(25,100)
	
	self.MyDLabel5 = vgui.Create("DLabel",self)
	self.MyDLabel5:SetText("5. Можешь идти.")
	self.MyDLabel5:SizeToContents()
	self.MyDLabel5:SetPos(25,125)
	
	self.MyDLabel6 = vgui.Create("DLabel",self)
	self.MyDLabel6:SetText("6. Первое предупреждение, отойти.")
	self.MyDLabel6:SizeToContents()
	self.MyDLabel6:SetPos(25,150)
	
	self.MyDLabel7 = vgui.Create("DLabel",self)
	self.MyDLabel7:SetText("7. Второе предупреждение.")
	self.MyDLabel7:SizeToContents()
	self.MyDLabel7:SetPos(25,175)
	
	self.MyDLabel8 = vgui.Create("DLabel",self)
	self.MyDLabel8:SetText("8. Последнее предупреждение.")
	self.MyDLabel8:SizeToContents()
	self.MyDLabel8:SetPos(25,200)
	
	self.MyDLabel9 = vgui.Create("DLabel",self)
	self.MyDLabel9:SetText("9. Готовьтесь к отправлению правосудия.")
	self.MyDLabel9:SizeToContents()
	self.MyDLabel9:SetPos(25,225)
end
vgui.Register("VoiceMenu1",PANEL1,"DFrame")

local PANEL2 = {}
function PANEL2:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel1 = vgui.Create("DLabel",self)
	self.MyDLabel1:SetText("1. Стоять!")
	self.MyDLabel1:SizeToContents()
	self.MyDLabel1:SetPos(25,25)
	
	self.MyDLabel2 = vgui.Create("DLabel",self)
	self.MyDLabel2:SetText("2. Стоять на месте!")
	self.MyDLabel2:SizeToContents()
	self.MyDLabel2:SetPos(25,50)
	
	self.MyDLabel3 = vgui.Create("DLabel",self)
	self.MyDLabel3:SetText("3. Всем оставаться на месте!")
	self.MyDLabel3:SizeToContents()
	self.MyDLabel3:SetPos(25,75)
	
	self.MyDLabel4 = vgui.Create("DLabel",self)
	self.MyDLabel4:SetText("4. Назад немедленно!")
	self.MyDLabel4:SizeToContents()
	self.MyDLabel4:SetPos(25,100)
	
	self.MyDLabel5 = vgui.Create("DLabel",self)
	self.MyDLabel5:SetText("5. Я сказал отойти!")
	self.MyDLabel5:SizeToContents()
	self.MyDLabel5:SetPos(25,125)
	
	self.MyDLabel6 = vgui.Create("DLabel",self)
	self.MyDLabel6:SetText("6. А теперь убирайся!")
	self.MyDLabel6:SizeToContents()
	self.MyDLabel6:SetPos(25,150)
	
	self.MyDLabel7 = vgui.Create("DLabel",self)
	self.MyDLabel7:SetText("7. Двигайся!")
	self.MyDLabel7:SizeToContents()
	self.MyDLabel7:SetPos(25,175)
	
	self.MyDLabel8 = vgui.Create("DLabel",self)
	self.MyDLabel8:SetText("8. Бросай оружие! На землю!")
	self.MyDLabel8:SizeToContents()
	self.MyDLabel8:SetPos(25,175)
	
	self.MyDLabel9 = vgui.Create("DLabel",self)
	self.MyDLabel9:SetText("9. На землю!")
	self.MyDLabel9:SizeToContents()
	self.MyDLabel9:SetPos(25,175)
end
vgui.Register("VoiceMenu2",PANEL2,"DFrame")

local PANEL3 = {}
function PANEL3:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel1 = vgui.Create("DLabel",self)
	self.MyDLabel1:SetText("1. Так точно.")
	self.MyDLabel1:SizeToContents()
	self.MyDLabel1:SetPos(25,25)
	
	self.MyDLabel2 = vgui.Create("DLabel",self)
	self.MyDLabel2:SetText("2. Вас понял.")
	self.MyDLabel2:SizeToContents()
	self.MyDLabel2:SetPos(25,50)
	
	self.MyDLabel3 = vgui.Create("DLabel",self)
	self.MyDLabel3:SetText("3. Зафиксировано нападение.")
	self.MyDLabel3:SizeToContents()
	self.MyDLabel3:SetPos(25,75)
	
	self.MyDLabel4 = vgui.Create("DLabel",self)
	self.MyDLabel4:SetText("4. Приговор приведен в исполнение.")
	self.MyDLabel4:SizeToContents()
	self.MyDLabel4:SetPos(25,100)
	
	self.MyDLabel5 = vgui.Create("DLabel",self)
	self.MyDLabel5:SetText("5. Готов к отсечению.")
	self.MyDLabel5:SizeToContents()
	self.MyDLabel5:SetPos(25,125)
	
	self.MyDLabel6 = vgui.Create("DLabel",self)
	self.MyDLabel6:SetText("6. Выдвигаюсь.")
	self.MyDLabel6:SizeToContents()
	self.MyDLabel6:SetPos(25,150)
	
	self.MyDLabel7 = vgui.Create("DLabel",self)
	self.MyDLabel7:SetText("7. Продолжаю поиск.")
	self.MyDLabel7:SizeToContents()
	self.MyDLabel7:SetPos(25,175)
	
	self.MyDLabel8 = vgui.Create("DLabel",self)
	self.MyDLabel8:SetText("8. Объект не обнаружен.")
	self.MyDLabel8:SizeToContents()
	self.MyDLabel8:SetPos(25,200)
	
	self.MyDLabel9 = vgui.Create("DLabel",self)
	self.MyDLabel9:SetText("9. Здесь все в порядке.")
	self.MyDLabel9:SizeToContents()
	self.MyDLabel9:SetPos(25,225)
end
vgui.Register("VoiceMenu3",PANEL3,"DFrame")

local PANEL4 = {}
function PANEL4:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel1 = vgui.Create("DLabel",self)
	self.MyDLabel1:SetText("1. Все чисто.")
	self.MyDLabel1:SizeToContents()
	self.MyDLabel1:SetPos(25,25)
	
	self.MyDLabel2 = vgui.Create("DLabel",self)
	self.MyDLabel2:SetText("2. Готов.")
	self.MyDLabel2:SizeToContents()
	self.MyDLabel2:SetPos(25,50)
	
	self.MyDLabel3 = vgui.Create("DLabel",self)
	self.MyDLabel3:SetText("3. Нарушитель.")
	self.MyDLabel3:SizeToContents()
	self.MyDLabel3:SetPos(25,75)
	
	self.MyDLabel4 = vgui.Create("DLabel",self)
	self.MyDLabel4:SetText("4. Вот он!")
	self.MyDLabel4:SizeToContents()
	self.MyDLabel4:SetPos(25,100)
	
	self.MyDLabel5 = vgui.Create("DLabel",self)
	self.MyDLabel5:SetText("5. Вон он!")
	self.MyDLabel5:SizeToContents()
	self.MyDLabel5:SetPos(25,125)
	
	self.MyDLabel6 = vgui.Create("DLabel",self)
	self.MyDLabel6:SetText("6. Убит.")
	self.MyDLabel6:SizeToContents()
	self.MyDLabel6:SetPos(25,150)
	
	self.MyDLabel7 = vgui.Create("DLabel",self)
	self.MyDLabel7:SetText("7. Вирусное загрязнение.")
	self.MyDLabel7:SizeToContents()
	self.MyDLabel7:SetPos(25,175)
	
	self.MyDLabel8 = vgui.Create("DLabel",self)
	self.MyDLabel8:SetText("8. Инфекция.")
	self.MyDLabel8:SizeToContents()
	self.MyDLabel8:SetPos(25,200)
	
	self.MyDLabel9 = vgui.Create("DLabel",self)
	self.MyDLabel9:SetText("9. Некротики.")
	self.MyDLabel9:SizeToContents()
	self.MyDLabel9:SetPos(25,225)
end
vgui.Register("VoiceMenu4",PANEL4,"DFrame")

local PANEL5 = {}
function PANEL5:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel1 = vgui.Create("DLabel",self)
	self.MyDLabel1:SetText("1. Зомби убит.")
	self.MyDLabel1:SizeToContents()
	self.MyDLabel1:SetPos(25,25)
	
	self.MyDLabel2 = vgui.Create("DLabel",self)
	self.MyDLabel2:SetText("2. Злоумышленник.")
	self.MyDLabel2:SizeToContents()
	self.MyDLabel2:SetPos(25,50)
	
	self.MyDLabel3 = vgui.Create("DLabel",self)
	self.MyDLabel3:SetText("3. Неизвестный.")
	self.MyDLabel3:SizeToContents()
	self.MyDLabel3:SetPos(25,75)
	
	self.MyDLabel4 = vgui.Create("DLabel",self)
	self.MyDLabel4:SetText("4. Объект подходит по ориентировке.")
	self.MyDLabel4:SizeToContents()
	self.MyDLabel4:SetPos(25,100)
	
	self.MyDLabel5 = vgui.Create("DLabel",self)
	self.MyDLabel5:SetText("5. Угроза обществу.")
	self.MyDLabel5:SizeToContents()
	self.MyDLabel5:SetPos(25,125)
	
	self.MyDLabel6 = vgui.Create("DLabel",self)
	self.MyDLabel6:SetText("6. Мятеж.")
	self.MyDLabel6:SizeToContents()
	self.MyDLabel6:SetPos(25,150)
	
	self.MyDLabel7 = vgui.Create("DLabel",self)
	self.MyDLabel7:SetText("7. Предписание о неповиновении.")
	self.MyDLabel7:SizeToContents()
	self.MyDLabel7:SetPos(25,175)
	
	self.MyDLabel8 = vgui.Create("DLabel",self)
	self.MyDLabel8:SetText("8. Восстанавливаю порядок.")
	self.MyDLabel8:SizeToContents()
	self.MyDLabel8:SetPos(25,200)
	
	self.MyDLabel9 = vgui.Create("DLabel",self)
	self.MyDLabel9:SetText("9. Приговор вынесен.")
	self.MyDLabel9:SizeToContents()
	self.MyDLabel9:SetPos(25,225)
end
vgui.Register("VoiceMenu5",PANEL5,"DFrame")

local PANEL6 = {}
function PANEL6:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel1 = vgui.Create("DLabel",self)
	self.MyDLabel1:SetText("1. Приступление присечено.")
	self.MyDLabel1:SizeToContents()
	self.MyDLabel1:SetPos(25,25)
	
	self.MyDLabel2 = vgui.Create("DLabel",self)
	self.MyDLabel2:SetText("2. Прикройте меня, отхожу.")
	self.MyDLabel2:SizeToContents()
	self.MyDLabel2:SetPos(25,50)
	
	self.MyDLabel3 = vgui.Create("DLabel",self)
	self.MyDLabel3:SetText("3. Боезапас на исходе, иду в укрытие.")
	self.MyDLabel3:SizeToContents()
	self.MyDLabel3:SetPos(25,75)
	
	self.MyDLabel4 = vgui.Create("DLabel",self)
	self.MyDLabel4:SetText("4. Что то есть.")
	self.MyDLabel4:SizeToContents()
	self.MyDLabel4:SetPos(25,100)
	
	self.MyDLabel5 = vgui.Create("DLabel",self)
	self.MyDLabel5:SetText("5. Осторожно.")
	self.MyDLabel5:SizeToContents()
	self.MyDLabel5:SetPos(25,125)
	
	self.MyDLabel6 = vgui.Create("DLabel",self)
	self.MyDLabel6:SetText("6. Ищешь неприятности.")
	self.MyDLabel6:SizeToContents()
	self.MyDLabel6:SetPos(25,150)
	
	self.MyDLabel7 = vgui.Create("DLabel",self)
	self.MyDLabel7:SetText("7. Хочешь в участок.")
	self.MyDLabel7:SizeToContents()
	self.MyDLabel7:SetPos(25,175)
	
	self.MyDLabel8 = vgui.Create("DLabel",self)
	self.MyDLabel8:SetText("8. Черт.")
	self.MyDLabel8:SizeToContents()
	self.MyDLabel8:SetPos(25,200)
	
	self.MyDLabel9 = vgui.Create("DLabel",self)
	self.MyDLabel9:SetText("9. Ха ха ха.")
	self.MyDLabel9:SizeToContents()
	self.MyDLabel9:SetPos(25,225)
end
vgui.Register("VoiceMenu6",PANEL6,"DFrame")

local PANEL7 = {}
function PANEL7:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel1 = vgui.Create("DLabel",self)
	self.MyDLabel1:SetText("1. Присечь.")
	self.MyDLabel1:SizeToContents()
	self.MyDLabel1:SetPos(25,25)
	
	self.MyDLabel2 = vgui.Create("DLabel",self)
	self.MyDLabel2:SetText("2. Проверить.")
	self.MyDLabel2:SizeToContents()
	self.MyDLabel2:SetPos(25,50)
	
	self.MyDLabel3 = vgui.Create("DLabel",self)
	self.MyDLabel3:SetText("3. Задержать.")
	self.MyDLabel3:SizeToContents()
	self.MyDLabel3:SetPos(25,75)
	
	self.MyDLabel4 = vgui.Create("DLabel",self)
	self.MyDLabel4:SetText("4. Фиксировать.")
	self.MyDLabel4:SizeToContents()
	self.MyDLabel4:SetPos(25,100)
	
	self.MyDLabel5 = vgui.Create("DLabel",self)
	self.MyDLabel5:SetText("5. Изолировать.")
	self.MyDLabel5:SizeToContents()
	self.MyDLabel5:SetPos(25,125)
	
	self.MyDLabel6 = vgui.Create("DLabel",self)
	self.MyDLabel6:SetText("6. Стерилизовать.")
	self.MyDLabel6:SizeToContents()
	self.MyDLabel6:SetPos(25,150)
	
	self.MyDLabel7 = vgui.Create("DLabel",self)
	self.MyDLabel7:SetText("7. Отсечь.")
	self.MyDLabel7:SizeToContents()
	self.MyDLabel7:SetPos(25,175)
end
vgui.Register("VoiceMenu7",PANEL7,"DFrame")

local PANEL8 = {}
function PANEL8:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel1 = vgui.Create("DLabel",self)
	self.MyDLabel1:SetText("1. Искать.")
	self.MyDLabel1:SizeToContents()
	self.MyDLabel1:SetPos(25,25)
	
	self.MyDLabel2 = vgui.Create("DLabel",self)
	self.MyDLabel2:SetText("2. Применить.")
	self.MyDLabel2:SizeToContents()
	self.MyDLabel2:SetPos(25,50)
	
	self.MyDLabel3 = vgui.Create("DLabel",self)
	self.MyDLabel3:SetText("3. Проверить численность.")
	self.MyDLabel3:SizeToContents()
	self.MyDLabel3:SetPos(25,75)
	
	self.MyDLabel4 = vgui.Create("DLabel",self)
	self.MyDLabel4:SetText("4. Патруль.")
	self.MyDLabel4:SizeToContents()
	self.MyDLabel4:SetPos(25,100)
	
	self.MyDLabel5 = vgui.Create("DLabel",self)
	self.MyDLabel5:SetText("5. Вмешаться.")
	self.MyDLabel5:SizeToContents()
	self.MyDLabel5:SetPos(25,125)
	
	self.MyDLabel6 = vgui.Create("DLabel",self)
	self.MyDLabel6:SetText("6. Расследовать.")
	self.MyDLabel6:SizeToContents()
	self.MyDLabel6:SetPos(25,150)
	
	self.MyDLabel7 = vgui.Create("DLabel",self)
	self.MyDLabel7:SetText("7. Оставаться на позиции.")
	self.MyDLabel7:SizeToContents()
	self.MyDLabel7:SetPos(25,175)
	
	self.MyDLabel8 = vgui.Create("DLabel",self)
	self.MyDLabel8:SetText("8. Всем назад!")
	self.MyDLabel8:SizeToContents()
	self.MyDLabel8:SetPos(25,200)
	
	self.MyDLabel9 = vgui.Create("DLabel",self)
	self.MyDLabel9:SetText("9. Отступаем!")
	self.MyDLabel9:SizeToContents()
	self.MyDLabel9:SetPos(25,225)
end
vgui.Register("VoiceMenu8",PANEL8,"DFrame")

local PANEL9 = {}
function PANEL9:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel1 = vgui.Create("DLabel",self)
	self.MyDLabel1:SetText("1. Выйти к назначенным точкам.")
	self.MyDLabel1:SizeToContents()
	self.MyDLabel1:SetPos(25,25)
	
	self.MyDLabel2 = vgui.Create("DLabel",self)
	self.MyDLabel2:SetText("2. Отряд вперед.")
	self.MyDLabel2:SizeToContents()
	self.MyDLabel2:SetPos(25,50)
	
	self.MyDLabel3 = vgui.Create("DLabel",self)
	self.MyDLabel3:SetText("3. Назад.")
	self.MyDLabel3:SizeToContents()
	self.MyDLabel3:SetPos(25,75)
	
	self.MyDLabel4 = vgui.Create("DLabel",self)
	self.MyDLabel4:SetText("4. Продолжаем.")
	self.MyDLabel4:SizeToContents()
	self.MyDLabel4:SetPos(25,100)
	
	self.MyDLabel5 = vgui.Create("DLabel",self)
	self.MyDLabel5:SetText("5. Выполнять.")
	self.MyDLabel5:SizeToContents()
	self.MyDLabel5:SetPos(25,125)
	
	self.MyDLabel6 = vgui.Create("DLabel",self)
	self.MyDLabel6:SetText("6. Всем выдвигаться.")
	self.MyDLabel6:SizeToContents()
	self.MyDLabel6:SetPos(25,150)
	
	self.MyDLabel7 = vgui.Create("DLabel",self)
	self.MyDLabel7:SetText("7. Набор рабочих.")
	self.MyDLabel7:SizeToContents()
	self.MyDLabel7:SetPos(25,175)
end
vgui.Register("VoiceMenu9",PANEL9,"DFrame")



local combpanel0 = {}
function combpanel0:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("1. Общие I")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,25)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("2. Общие II")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,50)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("3. Общие III")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,75)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("4. Приказы I")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,100)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("5. Приказы II")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,125)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("6. Жесты I")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,150)
end
vgui.Register("combVoiceMenu0",combpanel0,"DFrame")

local combpanel1 = {}
function combpanel1:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("1. Попадание.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,25)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("2. Нарушитель номер 1.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,50)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("3. Защита держит.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,75)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("4. Паразиты.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,100)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("5. В секторе опасные формы жизни.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,125)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("6. Чисто.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,150)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("7. Контакт.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,175)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("8. Преследую.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,200)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("9. Убит.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,225)
end
vgui.Register("combVoiceMenu1",combpanel1,"DFrame")

local combpanel2 = {}
function combpanel2:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("1. Кидаю гранату!")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,25)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("2. Граната!")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,50)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("3. Вижу.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,75)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("4. Не вижу.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,100)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("5. Некротики.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,125)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("6. Мятеж.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,150)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("7. В секторе опасность.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,175)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("8. Выдвигаюсь.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,200)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("9. Легко ранен.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,225)
end
vgui.Register("combVoiceMenu2",combpanel2,"DFrame")

local combpanel3 = {}
function combpanel3:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("1. Есть.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,25)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("2. Лидер.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,50)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("3. Требуются стимуляторы.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,75)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("4. Рота.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,100)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("5. Жду указаний.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,125)
end
vgui.Register("combVoiceMenu3",combpanel3,"DFrame")

local combpanel4 = {}
function combpanel4:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("1. Ложись, ложись!")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,25)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("2. Прикрой!")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,50)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("3. Уходим!")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,75)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("4. Держать позицию.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,100)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("5. Гранаты к бою.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,125)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("6. Оружие к бою.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,150)
end
vgui.Register("combVoiceMenu4",combpanel4,"DFrame")

local combpanel5 = {}
function combpanel5:Init()
	self:SetSize(250,250)
	self:SetTitle("Голосовые команды:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("1. Доложить об опасности.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,25)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("2. Внимательно докладывайте обо всём.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,50)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("3. Рота готова, прочесываем.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,75)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("4. Отлично, добей его.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,100)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("5. Не стрелять.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,125)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("6. Выполняй.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,150)
end
vgui.Register("combVoiceMenu5",combpanel5,"DFrame")

local combpanel6 = {}
function combpanel6:Init()
	self:SetSize(250,250)
	self:SetTitle("Жесты:")
	self:SetPos(ScrW() - 250,ScrH()/2)
	self:ShowCloseButton( false )
	self.Paint = function(s,w,h)
		draw.RoundedBox(5,0,0,w,h,Color(0,0,0, 210))
	end
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("1. Укрыться.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,25)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("2. Направо.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,50)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("3. Налево.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,75)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("4. Стоять.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,100)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("5. Группа.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,125)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("6. Вперед.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,150)
	
	self.MyDLabel = vgui.Create("DLabel",self)
	self.MyDLabel:SetText("7. Наступать.")
	self.MyDLabel:SizeToContents()
	self.MyDLabel:SetPos(25,175)
end
vgui.Register("combVoiceMenu6",combpanel6,"DFrame")