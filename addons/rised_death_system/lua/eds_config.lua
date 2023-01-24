-- "addons\\rised_death_system\\lua\\eds_config.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
EDS = EDS or {}
-- Config (Restart the server after applying changes otherwise you'll encounter bugs.)
-- Main
EDS.MaxCorpses = 2 -- Max corpses per player
EDS.RespawnTimer = 1 -- Amount of time (in seconds) after which player can respawn.
EDS.EnableAutoWanted = false -- Wheter or not should the murderer get wanted after the body gets investigated.
EDS.DecayTime = 900 -- Time it takes for a corpse to decay.
EDS.EnableNotifications = true -- Should players get notifications after investigating corpses?
EDS.AllowSelfUse = false -- Should players receive money for investigating their own corpse?
EDS.DeathEffects = true -- Should the custom death screen be enabled?
EDS.LowHPEffects = true -- Should the low hp effects be enabled?
EDS.EnableBodyOutline = true -- Should an outline be displayed around the body when a player is looking at it?
EDS.HidePlayerNames = false -- Whether or not should the victim's name stay hidden.
EDS.NotWantedJobs = { "Зомби", "Быстрый зомби", "Комбайн-зомби", "Зараженный" } -- You don't need to include the default police jobs - they won't get wanted either.
EDS.BodyOutlineColor = Color(255,255,255,100) -- Body outline color
EDS.FontColor1 = Color(160,160,160,255) -- Main font color
EDS.FontColor2 = Color(255,255,225,255) -- Hint font color
EDS.FontColorDeath = Color(255,255,255,255) -- Death screen font color
EDS.BoxColor = Color(170,170,170,55)
EDS.BoxColor2 = Color(190,190,190,55)
EDS.StripeColor = Color(30,30,30,255)
EDS.OutlineColor = Color(0,0,0,255)
-- Detective
EDS.DetectiveJobs = { "C17I.MPF.WATCHER.SGT", "C17I.MPF.WATCHER.LT", "C17I.MPF.WATCHER.CPT" } -- Detective darkrp jobs
EDS.DetectivePay = 2 -- Amount of money detective gets after investigating a body
EDS.DetectiveTime = 5 -- Amount of time (in seconds) it takes for a detective to investigate a body
-- CP's
EDS.PoliceCanIvestigate = false -- Should police have the same mechanics as the detective
EDS.CPTime = 5 -- Amount of time (in seconds) it takes for a police officer to investigate a body
EDS.CPsPay = 1 -- Amount of money police officer gets after investigating a body
-- Medic
EDS.MedicJobs = { "MPF-HELIX.01" } -- Medic darkrp jobs
EDS.MedicTime = 200 -- Amount of time (in seconds) it takes for a medic to clean up a body
EDS.MedicCanCleanup = true -- Should medics be able to clean up the bodies
EDS.MedicPay = 2 -- Amount of money medic gets after cleaning up a corpse
-- Hobo 
EDS.HoboJobs = { "Зомби", "Быстрый зомби", "Комбайн-зомби" } -- Hobo darkrp jobs
EDS.HoboHPGain = 100 -- Amount of health hobo gets after consuming a body
EDS.HoboTime = 50 -- Amount of time (in seconds) it takes for a hobo to consume the body
EDS.CanHoboEat = true -- Whether or not hobos should be allowed to eat the bodies
-- Mafia Boss
EDS.MafiaJobs = { "Киллер" } -- Mafia darkrp jobs
EDS.BurnTime = 30 -- Amount of time it takes for a body to burn
EDS.BossCanBurn = false -- Should mafia be allowed to burn the bodies
EDS.SetOnFireTime = 200 -- Amount of time (in seconds) it takes for a mafia member to set the body on fire
EDS.BossRequiredMoney = 1 -- Amount of money that mafia member requires to set the body on fire
-- Texts
EDS.text1 = "Зажмите R чтобы убрать тело"
EDS.text2 = "Невозможно уточнить причину смерти"
EDS.text3 = "Зажмите R чтобы убрать тело в морг"
EDS.text4 = "Нажмите E чтобы тащить тело"
EDS.text5 = "Вы исследовали труп."
EDS.text6 = "Причина смерти:\n несчастный случай"
EDS.text7 = "Причина смерти:   самоубийство"
EDS.text8 = "Невозможно уточнить причину смерти"
EDS.text9 = "Зажмите R чтобы исследовать тело"
EDS.text10 = "Причина смерти: убийство"
EDS.text11 = "Вы убрали тело и получили "
EDS.text12 = "Убийство"
EDS.text13 = "Вы разыскиваетесь за убийство!"
EDS.text14 = "Вы умерли!"
EDS.text15 = "Нажмите любую кнопку чтобы возродиться"
EDS.text16 = "Зажмите R чтобы поглотить тело"
EDS.text17 = "Вы поглотили тело и восполнили "
EDS.text18 = " ед. здоровья"
EDS.text19 = "Зажмите R чтобы сжечь труп"
EDS.text20 = "Вам нужно Т"
EDS.text21 = "Вы подожгли тело!"
EDS.text22 = "У вас недостаточно денег"
EDS.text23 = "Исследование трупа..."
EDS.text24 = "Отправка трупа в морг..."
EDS.text25 = "Поджигание трупа..."
EDS.text26 = "Поглощение трупа..."
EDS.text27 = "Вы не получили денег, так как это ваш труп"
EDS.text28 = "Теперь вы можете сжечь труп!"
EDS.text29 = "Вы уже имеете канистру с бензином!"
EDS.text30 = "Вы не должны этим пользоваться!"
EDS.text31 = "Зажмите R чтобы сжечь труп"
EDS.text32 = "Канистра с бензином"
EDS.text33 = "Нажмите E чтобы взять"
EDS.text34 = "Зажмите R чтобы исследовать тело"
EDS.text35 = "Чей-то труп."
EDS.text36 = "Ждите "
EDS.text37 = "  секунд."
EDS.text38 = "Личность: "
EDS.text39 = "Орудие преступления: "
EDS.text40 = "Убийца: "
EDS.text41 = "Труп не исследован"

-- Fonts (don't edit the names)
if CLIENT then
	surface.CreateFont( "DeathScreenFont", {
		font = "Impact",    
		size = ScrH()/28,
	})
	surface.CreateFont( "DeathScreenFont2", {
		font = "Impact",    
		size = ScrH()/48,
	})
	surface.CreateFont( "CorpseInspectFont", {
		font = "Impact",    
		size = ScrH()/44,
		outline = true,
	})
	surface.CreateFont( "CorpseInspectFont2", {
		font = "Trebuchet MS",    
		size = ScrH()/48,
		strikeout = true,
		outline = true,
	})
end