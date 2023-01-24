-- "addons\\darkrpmodification\\lua\\darkrp_customthings\\jobs.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
Цвета профессий:
	Гражданин - B3B3B3
	Все ГСР - B3B3B3
	Криминал
	Альянс - 9999FF
	Партия - C7C777
	Беженец
	Сопротивление

--]]


----- Default ---

TEAM_CONNECTOR = DarkRP.createJob("Прибывший", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[]],
	weapons = {"re_hands"},
	command = "connecter",
	category = "Гражданские",
	type = "useless",
	max = 0,
	salary = 0,
	admin = 0,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetSlowWalkSpeed( 75 )
		ply:SetRunSpeed(200)
	end
})

TEAM_CITIZENXXX = DarkRP.createJob("Гражданин", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[]],
	weapons = {"re_hands", "weapon_fists", "citizenidcard"},
	command = "citizenxxx",
	category = "Гражданские",
	type = "Job_NPC_Party",
	max = 0,
	salary = 0,
	admin = 0,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetSlowWalkSpeed( 75 )
		ply:SetRunSpeed(200)
	end
})



----- Party -----

TEAM_PARTYCANDIDATE = DarkRP.createJob("Кандидат на членство в партии", {
	color = Color(175, 175, 235, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Стандартное рядовое звания, сотрудник подчиняется сотрудникам партии выше по званию, имеет некоторые блага, предоставляемые Альянсом и Партией. Не имеет права проводить ОР.]],
	specification = {
		"Более доверенный человек Альянса.",
		"Имеет не маленькую зарплату за счёт своего статуса.",
	},
	weapons = {"re_hands", "citizenidcard", "weapon_fists"},
	command = "partycandidate",
	salary = RISED.Config.Economy.TEAM_PARTYCANDIDATE.salary,
	exp_type = RISED.Config.Economy.TEAM_PARTYCANDIDATE.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_PARTYCANDIDATE.exp_unlock_lvl,
	loyaltyLevel = 10,
	category = "Партия",
	type = "Job_NPC_Party",
	max = 0,
	admin = 0,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_PARTYMEMBER = DarkRP.createJob("Утвержденный член партии", {
	color = Color(175, 175, 235, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Стандартное рядовое звания, сотрудник подчиняется сотрудникам партии выше по званию, имеет некоторые блага, предоставляемые Альянсом и Партией. Не имеет права проводить ОР.]],
	specification = {
		"Более доверенный человек Альянса.",
		"Имеет не маленькую зарплату за счёт своего статуса.",
	},
	weapons = {"re_hands", "citizenidcard", "weapon_fists"},
	command = "partymember",
	salary = RISED.Config.Economy.TEAM_PARTYMEMBER.salary,
	exp_type = RISED.Config.Economy.TEAM_PARTYMEMBER.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_PARTYMEMBER.exp_unlock_lvl,
	loyaltyLevel = 15,
	category = "Партия",
	type = "Job_NPC_Party",
	max = 0,
	admin = 0,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_PARTYSUPPORT = DarkRP.createJob("Помощник партии", {
	color = Color(175, 175, 235, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Сотрудник партии, получивший звание выше, за стаж, либо за хорошие заслуги. Имеет хороший потенциал к продвижению по карьерной лестнице, имеет те же блага, которые предоставляются и Члену Партии. Подчиняется Старшему Помощнику, Руководителю Работ и Высшим Чинам. Не имеет права проводить ОР.]],
	specification = {
		"",
		"",
		"",
		"",
	},
	weapons = {"re_hands", "citizenidcard", "weapon_fists", "weapon_partyup"},
	command = "partysupport",
	salary = RISED.Config.Economy.TEAM_PARTYSUPPORT.salary,
	exp_type = RISED.Config.Economy.TEAM_PARTYSUPPORT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_PARTYSUPPORT.exp_unlock_lvl,
	loyaltyLevel = 20,
	category = "Партия",
	type = "Job_NPC_Party",
	max = 0,
	admin = 0,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_PARTYSUPPORTSUPERIOR = DarkRP.createJob("Старший помощник партии", {
	color = Color(175, 175, 235, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Сотрудник партии, получивший звание только за его отличные заслуги. С этого звания есть шанс стать Руководителем работ. Имеет право проводить ОР. Получает все те же блага, но денежное довольствие выше. Имеет хорошую репутацию среди состава партии. Подчиняется Руководителю работ и Высшим Чинам.]],
	specification = {
		"",
		"",
		"",
		"",
	},
	weapons = {"re_hands", "citizenidcard", "weapon_fists", "weapon_cwusalary", "weapon_partyup"},
	command = "partysupportsuperior",
	salary = RISED.Config.Economy.TEAM_PARTYSUPPORTSUPERIOR.salary,
	exp_type = RISED.Config.Economy.TEAM_PARTYSUPPORTSUPERIOR.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_PARTYSUPPORTSUPERIOR.exp_unlock_lvl,
	loyaltyLevel = 25,
	category = "Партия",
	type = "Job_NPC_Party",
	max = 0,
	admin = 0,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_PARTYWORKSUPERVISOR = DarkRP.createJob("Руководитель работ", {
	color = Color(175, 175, 235, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Является Нач. ГСР . Его обязанность проводить ОР, выполнять приказы выше стоящих и принимать отчёты от подчинённых о состоянии города, следить за Рабочими. Подчиняется Членам Верховного Совета (Если идут противоречия, обращаться к Пред. Совета/Ген. Секретарю) , Председателю Совета, Генеральному Секретарю.]],
	specification = {
		"Может увольнять неугодных рабочих.",
		"Может запрашивать сертификаты и документы у рабочих.",
		"Может объявлять общественные работы.",
	},
	weapons = {"re_hands", "citizenidcard", "weapon_fists", "weapon_cwusalary", "weapon_partyup"},
	command = "partyworksupervisor",
	salary = RISED.Config.Economy.TEAM_PARTYWORKSUPERVISOR.salary,
	exp_type = RISED.Config.Economy.TEAM_PARTYWORKSUPERVISOR.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_PARTYWORKSUPERVISOR.exp_unlock_lvl,
	loyaltyLevel = 30,
	category = "Партия",
	type = "Job_NPC_Party",
	max = 1,
	admin = 0,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_PARTYSUPERIORCOUNCILMEMBER = DarkRP.createJob("Член верховного совета", {
	color = Color(175, 175, 235, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Сотрудник партии, получивший самое высокое звание. Получает больше благ, а также право на охрану. Является частью Верховного Совета Альянса. Подчиняется Председателю Совета и Генеральному Секретарю.]],
	specification = {
		"Может находиться в ПУ но с причиной.",
		"Имеет право запрашивать до 3-х Сотрудников Альянса.",
	},
	weapons = {"re_hands", "weapon_fists", "citizenidcard", "combineidcard", "weapon_cwusalary", "weapon_partyup"},
	command = "partysuperiorcouncilmember",
	salary = RISED.Config.Economy.TEAM_PARTYSUPERIORCOUNCILMEMBER.salary,
	exp_type = RISED.Config.Economy.TEAM_PARTYSUPERIORCOUNCILMEMBER.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_PARTYSUPERIORCOUNCILMEMBER.exp_unlock_lvl,
	category = "Партия",
	type = "Job_NPC_PartyHead",
	max = 5,
	admin = 0,
	loyaltyLevel = 35,
	maxhealth = 85,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(85)
		ply:SetMaxHealth(85)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_PARTYCOUNCILCHAIRMAN = DarkRP.createJob("Председатель совета", {
	color = Color(175, 175, 235, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Председатель Совета - Сотрудник партии, заместитель Генерального Секретаря, возглавляет Верховный Совет Партии. Имеет право командовать всеми сотрудниками партии ниже по званию, ссылаясь на Закон о положении Партии, Гражданскому кодексу и Законам Города, Района. Подчиняется только Генеральному Секретарю.]],
	specification = {
		"Может находиться в ПУ без причины, передвижение ограничено.",
		"Имеет право запрашивать до 4-х Сотрудников Альянса для охраны.",
		"Замещает Генерального Секретаря в его отсутствии.",
	},
	weapons = {"re_hands", "weapon_fists", "citizenidcard", "combineidcard", "weapon_cwusalary", "weapon_partyup"},
	command = "partycouncilchairman",
	salary = RISED.Config.Economy.TEAM_PARTYCOUNCILCHAIRMAN.salary,
	exp_type = RISED.Config.Economy.TEAM_PARTYCOUNCILCHAIRMAN.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_PARTYCOUNCILCHAIRMAN.exp_unlock_lvl,
	loyaltyLevel = 40,
	category = "Партия",
	type = "Job_NPC_PartyHead",
	max = 1,
	admin = 0,
	maxhealth = 85,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(85)
		ply:SetMaxHealth(85)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_PARTYGENERALSECRETARY = DarkRP.createJob("Генеральный секретарь", {
	color = Color(175, 175, 235, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Бывший Председатель Совета Главного района Сити 17. Посланник из Цитадели, выбранный Консулом. Имеет право руководить всеми сотрудниками Партии, также все должны подчиняться его приказам.]],
	specification = {
		"Максимально лоялен к Альянсу.",
		"Имеет право запрашивать до 4-х Сотрудников Альянса на защиту. При красном коде, жёлтом коде, оранжевом коде и комендантском часе может запрашивать до 6-и Сотрудников Альянса.",
		"Может находиться в ПУ и НН передвигаясь в любом его месте без причины.",
	},
	weapons = {"re_hands", "weapon_fists", "citizenidcard", "combineidcard", "weapon_cwusalary", "weapon_partyup"},
	command = "partygeneralsekretary",
	salary = RISED.Config.Economy.TEAM_PARTYGENERALSECRETARY.salary,
	exp_type = RISED.Config.Economy.TEAM_PARTYGENERALSECRETARY.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_PARTYGENERALSECRETARY.exp_unlock_lvl,
	loyaltyLevel = 50,
	category = "Партия",
	type = "Job_NPC_PartyHead",
	max = 1,
	admin = 0,
	mayor = true,
	maxhealth = 85,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(85)
		ply:SetMaxHealth(85)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_CONSUL = DarkRP.createJob("Консул", {
	color = Color(175, 175, 235, 225),
	model = {
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[]],
	specification = {
		"Консул Альянса.",
	},
	weapons = {"re_hands", "weapon_fists", "citizenidcard", "combineidcard", "weapon_partyup"},
	command = "consul",
	salary = RISED.Config.Economy.TEAM_CONSUL.salary,
	exp_type = RISED.Config.Economy.TEAM_CONSUL.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_CONSUL.exp_unlock_lvl,
	loyaltyLevel = 50,
	category = "Партия",
	type = "Job_NPC_PartyHead",
	max = 1,
	admin = 0,
	mayor = true,
	maxhealth = 100,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})


----- Combine Utils -----

TEAM_STALKER = DarkRP.createJob("Сталкер", {
	color = Color(25, 25, 25, 225),
	model = {"models/beta stalker/beta_stalker.mdl",},
	description = [[Продукт биотехнологической инженерии Альянса. Люди, прошедшие через множество жестоких операций, полностью подконтрольные Альянсу рабы, лишённые инстинктов и способности испытывать эмоции. Не является частью Солдат Надзора. Многие органы сталкера были удалены, а руки заменены протезами. Это “творение” Альянса снабжено лазером невысокой мощности, с помощью которого оно способно осуществлять ремонт.]],
	specification = {
		"Имеет лазер"
	},
	weapons = {"re_hands", "stalkerlaser"},
	command = "stalker",
	max = 0,
	salary = 0,
	admin = 0,
	type = "useless",
	category = "Альянс",
    candemote = false,
	maxhealth = 50,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(50)
		ply:SetMaxHealth(50)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(100)
		ply:SetAmmo(5000, "AR2")
		return true
	end
})

TEAM_HAZWORKER = DarkRP.createJob("Infestation Control", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/hlvr/characters/hazmat_worker/hazmat_worker_player.mdl",
	},
	description = [[Дезинфекторы, очистители. Часть структуры Anti-Bodyprotection Force, отвечающая за очистку остатков флоры мира XEN. Обычные люди, что выбрали опасную работу ради прибыли и улучшенных рационов.]],
	specification = {
		"Может очищать сектора от флоры XEN",
		"Может запрашивать отдел Soldier в количестве 1 единицы для охраны (если дезинфекторов один или два)",
		"Может запрашивать отдел SUPPRESSOR/STRIKER в количестве 1 единицы для охраны (если дезинфекторов три и больше).",
	},
	weapons = {"re_hands", "combineidcard", "weapon_fists"},
	command = "hazworker",
	salary = RISED.Config.Economy.TEAM_HAZWORKER.salary,
	exp_type = RISED.Config.Economy.TEAM_HAZWORKER.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_HAZWORKER.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_Worker",
	max = 5,
	admin = 0,
	maxhealth = 100,
	maxarmor = 30,
	maxwalk = 100,
	maxrun = 200,
	armorJobClass = 2,
	premiumjob = false,
	donatejob = false,
	exclusivejob = false,
	-- customCheck = function(ply) return ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "rp_curator" or ply:GetNWString("usergroup") == "youtube" or ply:IsAdmin() end,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(30)
		ply:SetMaxArmor(30)
		ply:SetSlowWalkSpeed(75)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
	end
})

TEAM_WORKER_UNIT = DarkRP.createJob("Worker", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/hlvr/characters/worker/worker_player.mdl",
	},
	description = [[Рабочие Альянса. Это сотрудники Engineer Core, небоевой инженерной группы Альянса. Занимается возведением разных построек а также помощь Сотрудникам Инженерного и Технического Отдела Надзора.]],
	specification = {
		"Может запрашивать отдел Soldier в количестве 1 единицы для охраны.",
		"Может ставить турели и локеры.",
		"Может возводить постройки Альянса.",
	},
	weapons = {"re_hands", "citizenidcard" , "combineidcard", "weapon_fists", "weapon_physgun", "gmod_tool", "weapon_suitcharger", "weapon_combine_config"},
	command = "worker_unit",
	salary = RISED.Config.Economy.TEAM_WORKER_UNIT.salary,
	exp_type = RISED.Config.Economy.TEAM_WORKER_UNIT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_WORKER_UNIT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_Worker",
	max = 8,
	admin = 0,
	maxhealth = 100,
	maxarmor = 100,
	maxwalk = 100,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(100)
		ply:SetMaxArmor(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
	end
})



----- Metropolice -----

TEAM_MPF_JURY_Conscript = DarkRP.createJob("C17I.MPF.JURY.Conscript", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[I17-MPF.Conscript - поступивший в ряды гражданской обороны человек, главная цель которого - скорейшее прохождение начальной аттестации.]],
	specification = {
		"Снабжен неполным комплектом униформы СГО.",
		"Ввиду своей неопытности проходит обучение у старших рангов.",
		"Не имеет табельного оружия, вооружен дубинкой с 3-мя режимами.",
	},
	weapons = {"re_hands", "weapon_cp_stick", "combineidcard", "weapon_fists", "itemstore_checker", "wep_jack_job_drpradio"},
	command = "mpf_jury_conscript",
	salary = RISED.Config.Economy.TEAM_MPF_JURY_Conscript.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_JURY_Conscript.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_JURY_Conscript.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 50,
	admin = 0,
	maxhealth = 100,
	maxarmor = 100,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 2,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(50)
		ply:SetMaxArmor(50)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_MPF_JURY_PVT = DarkRP.createJob("C17I.MPF.JURY.PVT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Сотрудник гражданской обороны ранга "Рядовой", прошедший начальную аттестацию и получивший опыт работы для полноценной службы в роли сотрудника Метрополиции.]],
	specification = {
		"Может работать в патрульных группах",
		"На вооружении USP",
		"Имеет опыт в работе СГО",
		"Прямое руководство - C17I.MPF.JURY.CPL",
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "itemstore_checker"},
	command = "mpf_jury_pvt",
	salary = RISED.Config.Economy.TEAM_MPF_JURY_PVT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_JURY_PVT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_JURY_PVT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 25,
	admin = 0,
	maxhealth = 100,
	maxarmor = 100,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 2,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(100)
		ply:SetMaxArmor(100)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_MPF_JURY_CPL = DarkRP.createJob("C17I.MPF.JURY.CPL", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Сотрудник гражданской обороны ранга “Капрал”, имеющий базовые навыки для командования регулярным составом. В виде табельного основного вооружения имеет П-П MP5k.]],
	specification = {
		"Может выступать лидером в патрульной группе",
		"На вооружении USP и MP5k",
		"Может проводить допрос",
		"Большой опыт в работе СГО",
		"Прямое руководство - C17I.MPF.JURY.SGT",
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "itemstore_checker"},
	command = "mpf_jury_cpl",
	salary = RISED.Config.Economy.TEAM_MPF_JURY_CPL.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_JURY_CPL.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_JURY_CPL.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 25,
	admin = 0,
	maxhealth = 100,
	maxarmor = 100,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(100)
		ply:SetMaxArmor(100)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_MPF_JURY_SGT = DarkRP.createJob("C17I.MPF.JURY.SGT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Сотрудник гражданской обороны ранга “Сержант”, являющийся первостепенной должностью в младшем офицерском составе, занимаясь вводной частью обучения регулярного состава, предоставляя самые необходимые, но поверхностные понятия о службе в рядах гражданской обороны. Также может заниматься обучением членов ополчения для их дальнейшего поступления в ГО]],
	specification = {
		"Может отдавать приказы по формированию патрульной группы",
		"На вооружении USP и MP7",
		"Может проводить рабочие фазы, выдавать гражданским занятость",
		"Имеет опыт в управлении сотрудниками СГО",
		"Прямое руководство - C17I.MPF.JURY.CPT",
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "itemstore_checker"},
	command = "mpf_jury_sgt",
	salary = RISED.Config.Economy.TEAM_MPF_JURY_SGT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_JURY_SGT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_JURY_SGT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 25,
	admin = 0,
	maxhealth = 100,
	maxarmor = 100,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(100)
		ply:SetMaxArmor(100)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_MPF_JURY_LT = DarkRP.createJob("C17I.MPF.JURY.LT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[]],
	specification = {
		"Является непосредственным начальником глав всех отделов СГО",
		"Может проводить мероприятиях для всех подконтрольных Альянсу структур",
		"На вооружении CZ-75 и OICW",
		"Прямое руководство - I17.MPF.Primary.Maj",
	},
	weapons = {"re_hands", "weapon_rank_combine", "weapon_mpfcuratorup", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "itemstore_checker"},
	command = "mpf_jury_lt",
	salary = RISED.Config.Economy.TEAM_MPF_JURY_LT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_JURY_LT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_JURY_LT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 2,
	admin = 0,
	maxhealth = 125,
	maxarmor = 125,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(125)
		ply:SetMaxHealth(125)
		ply:SetArmor(125)
		ply:SetMaxArmor(100)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_MPF_JURY_CPT = DarkRP.createJob("C17I.MPF.JURY.CPT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Сотрудник гражданской обороны ранга “Капитан”, является чем-то средним между офицером и лейтенантом. Занимается как слежкой за службой гражданской обороны, так и деятельностью, направленной на взаимодействие с гражданскими. Под ответственность сотрудника этого ранга попадает весь жилой сектор, за которым ему поручено следить.]],
	specification = {
		"Является непосредственным начальником глав всех отделов СГО",
		"Может проводить мероприятиях для всех подконтрольных Альянсу структур",
		"На вооружении CZ-75 и OICW",
		"Прямое руководство - I17.MPF.Primary.Maj",
	},
	weapons = {"re_hands", "weapon_rank_combine", "weapon_mpfcuratorup", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "itemstore_checker"},
	command = "mpf_jury_cpt",
	salary = RISED.Config.Economy.TEAM_MPF_JURY_CPT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_JURY_CPT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_JURY_CPT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 1,
	admin = 0,
	maxhealth = 125,
	maxarmor = 150,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(125)
		ply:SetMaxHealth(125)
		ply:SetArmor(150)
		ply:SetMaxArmor(150)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_MPF_JURY_GEN = DarkRP.createJob("C17I.MPF.JURY.GEN", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Сотрудник гражданской обороны ранга “Генерал”. Занимается как слежкой за службой гражданской обороны, так и деятельностью, направленной на взаимодействие с гражданскими. Под ответственность сотрудника этого ранга попадает весь жилой сектор, за которым ему поручено следить.]],
	specification = {
		"Является главнокомандующим всех подразделений Альянса",
		"На вооружении CZ-75",
		"Прямое руководство - I17.AI.DISPATCH",
	},
	weapons = {"re_hands", "weapon_rank_combine", "weapon_mpfcuratorup", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "itemstore_checker"},
	command = "mpf_jury_gen",
	salary = RISED.Config.Economy.TEAM_MPF_JURY_GEN.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_JURY_GEN.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_JURY_GEN.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 1,
	admin = 0,
	mayor = true,
	maxhealth = 150,
	maxarmor = 165,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(150)
		ply:SetMaxHealth(150)
		ply:SetArmor(165)
		ply:SetMaxArmor(165)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})


TEAM_MPF_ETHERNAL_SGT = DarkRP.createJob("C17I.MPF.ETHERNAL.SGT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",	
	},
	description = [[Санитар гражданской обороны, прошедший базовое мед. обучение. Большую часть службы проводит либо в П.У, либо в лазарете. В основном ведет очень ограниченную патрульную службу, по сравнению с обычным сотрудником соответствующего ранга.]],
	specification = {
		"Может проводить базовую медицинскую помощь СГО, лоялистам и гражданским",
		"На вооружении USP и MP5k",
		"Прямое руководство - C17I.MPF.ETHERNAL.LT",
		"Может производить операции чипирования и сталкеризации"
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "weapon_medical_scanner", "itemstore_checker"},
	command = "mpf_ethernal_sgt",
	salary = RISED.Config.Economy.TEAM_MPF_ETHERNAL_SGT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_ETHERNAL_SGT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_ETHERNAL_SGT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 2,
	admin = 0,
	maxhealth = 100,
	maxarmor = 100,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(100)
		ply:SetMaxArmor(100)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_MPF_ETHERNAL_LT = DarkRP.createJob("C17I.MPF.ETHERNAL.LT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",	
	},
	description = [[Командир мед. отдела гражданской обороны, занимается профессиональным лечением всевозможных недугов, возникающих в течение службы у сотрудников ГО, а также оказывает мед. помощь работникам важных для альянса структур. В отличии от капрала, сержант имеет право на постановление диагноза о хронологических заболеваниях и прописывать курсы лекарств для избавления от них.]],
	specification = {
		"Может проводить полный мед. осмотр сотрудников ГО, с использованием спец. оборудования",
		"Может командовать C17I.MPF.ETHERNAL.SGT",
		"На вооружении USP и MP7",
		"Прямое руководство - C17I.MPF.JURY.CPT",
		"Может производить операции чипирования и сталкеризации",
		"Может производить сложные реанимационные операции"
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "weapon_medical_scanner", "itemstore_checker"},
	command = "mpf_ethernal_lt",
	salary = RISED.Config.Economy.TEAM_MPF_ETHERNAL_LT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_ETHERNAL_LT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_ETHERNAL_LT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 2,
	admin = 0,
	maxhealth = 100,
	maxarmor = 100,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(100)
		ply:SetMaxArmor(100)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_MPF_ETHERNAL_CPT = DarkRP.createJob("C17I.MPF.ETHERNAL.CPT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",	
	},
	description = [[Командир мед. отдела гражданской обороны, занимается профессиональным лечением всевозможных недугов, возникающих в течение службы у сотрудников ГО, а также оказывает мед. помощь работникам важных для альянса структур. В отличии от капрала, сержант имеет право на постановление диагноза о хронологических заболеваниях и прописывать курсы лекарств для избавления от них.]],
	specification = {
		"Может проводить полный мед. осмотр сотрудников ГО, с использованием спец. оборудования",
		"Может командовать C17I.MPF.ETHERNAL.LT",
		"На вооружении USP и MP7",
		"Прямое руководство - C17I.MPF.JURY.GEN",
		"Может производить операции чипирования и сталкеризации",
		"Может производить сложные реанимационные операции"
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "weapon_medical_scanner", "itemstore_checker"},
	command = "mpf_ethernal_cpt",
	salary = RISED.Config.Economy.TEAM_MPF_ETHERNAL_CPT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_ETHERNAL_CPT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_ETHERNAL_CPT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 1,
	admin = 0,
	maxhealth = 100,
	maxarmor = 150,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(150)
		ply:SetMaxArmor(150)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})


TEAM_MPF_PLUNGER_SGT = DarkRP.createJob("C17I.MPF.PLUNGER.SGT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Сотрудник гражданской обороны, рядовой среди инженерного отдела.]],
	specification = {
		"Может проводить проверку работоспособности техники альянса",
		"Может устанавливать Combine-замки и турели",
		"На вооружении USP и MP5k",
		"Может чинить поломанную технику",
		"Прямое руководство - C17I.MPF.PLUNGER.LT",
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "weapon_physgun", "gmod_tool", "itemstore_checker", "weapon_suitcharger", "weapon_combine_config"},
	command = "mpf_plunger_sgt",
	salary = RISED.Config.Economy.TEAM_MPF_PLUNGER_SGT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_PLUNGER_SGT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_PLUNGER_SGT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 4,
	admin = 0,
	maxhealth = 100,
	maxarmor = 100,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(100)
		ply:SetMaxArmor(100)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_MPF_PLUNGER_LT = DarkRP.createJob("C17I.MPF.PLUNGER.LT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Сотрудник гражданской обороны, командир инженерного отдела, является не только инженером но и пилотом среди Гражданской Обороны.]],
	specification = {
		"Командует над инженерным отделом ГО",
		"На вооружении USP и MP7",
		"Может устанавливать Combine-замки и турели",
		"Может выступать пилотом транспорта",
		"Прямое руководство - C17I.MPF.JURY.CPT",
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "weapon_physgun", "gmod_tool", "itemstore_checker", "weapon_suitcharger", "weapon_combine_config"},
	command = "mpf_plunger_lt",
	salary = RISED.Config.Economy.TEAM_MPF_PLUNGER_LT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_PLUNGER_LT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_PLUNGER_LT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 2,
	admin = 0,
	maxhealth = 100,
	maxarmor = 100,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(100)
		ply:SetMaxArmor(100)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_MPF_PLUNGER_CPT = DarkRP.createJob("C17I.MPF.PLUNGER.CPT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Сотрудник гражданской обороны, командир инженерного отдела, является не только инженером но и пилотом среди Гражданской Обороны.]],
	specification = {
		"Командует над инженерным отделом ГО",
		"На вооружении USP и MP7",
		"Может устанавливать Combine-замки и турели",
		"Может выступать пилотом транспорта",
		"Прямое руководство - C17I.MPF.JURY.CPT",
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "weapon_physgun", "gmod_tool", "itemstore_checker", "weapon_suitcharger", "weapon_combine_config"},
	command = "mpf_plunger_cpt",
	salary = RISED.Config.Economy.TEAM_MPF_PLUNGER_CPT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_PLUNGER_CPT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_PLUNGER_CPT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 1,
	admin = 0,
	maxhealth = 100,
	maxarmor = 150,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(150)
		ply:SetMaxArmor(150)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})


TEAM_MPF_WATCHER_SGT = DarkRP.createJob("C17I.MPF.WATCHER.SGT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Сотрудник судебно-детективного отдел Гражданской Обороны, основной деятельностью которого является раскрытие преступлений. Также в основные задачи входит проведение допросов с целью выявить причастность вины у определённых лиц.]],
	specification = {
		"Может возглавлять ход расследования в каком-либо преступлении",
		"На вооружении USP и SPAS-12",
		"Прямое руководство - C17I.MPF.WATCHER.LT",
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "itemstore_checker"},
	command = "mpf_watcher_sgt",
	salary = RISED.Config.Economy.TEAM_MPF_WATCHER_SGT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_WATCHER_SGT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_WATCHER_SGT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 4,
	admin = 0,
	maxhealth = 100,
	maxarmor = 100,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(100)
		ply:SetMaxArmor(100)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_MPF_WATCHER_LT = DarkRP.createJob("C17I.MPF.WATCHER.LT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Лейтенант судебно-детективного отдела Гражданской Обороны, основной деятельностью которого является раскрытие преступлений. Также в основные задачи входит проведение допросов с целью выявить причастность вины у определённых лиц.]],
	specification = {
		"Командует над судебным отделом ГО",
		"Может возглавлять ход расследования в каком-либо преступлении",
		"На вооружении USP и OICW",
		"Может сканировать тела на причину смерти",
		"Прямое руководство - C17I.MPF.JURY.CPT",
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "itemstore_checker"},
	command = "mpf_watcher_lt",
	salary = RISED.Config.Economy.TEAM_MPF_WATCHER_LT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_WATCHER_LT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_WATCHER_LT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 2,
	admin = 0,
	maxhealth = 100,
	maxarmor = 100,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(100)
		ply:SetMaxArmor(100)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_MPF_WATCHER_CPT = DarkRP.createJob("C17I.MPF.WATCHER.CPT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Лейтенант судебно-детективного отдела Гражданской Обороны, основной деятельностью которого является раскрытие преступлений. Также в основные задачи входит проведение допросов с целью выявить причастность вины у определённых лиц.]],
	specification = {
		"Командует над судебным отделом ГО",
		"Может возглавлять ход расследования в каком-либо преступлении",
		"На вооружении USP и OICW",
		"Может сканировать тела на причину смерти",
		"Прямое руководство - C17I.MPF.JURY.CPT",
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "itemstore_checker"},
	command = "mpf_watcher_cpt",
	salary = RISED.Config.Economy.TEAM_MPF_WATCHER_CPT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_WATCHER_CPT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_WATCHER_CPT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 1,
	admin = 0,
	maxhealth = 100,
	maxarmor = 150,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(150)
		ply:SetMaxArmor(150)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})


TEAM_MPF_SPIRE_SGT = DarkRP.createJob("C17I.MPF.SPIRE.SGT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Тяжеловооруженный сотрудник гражданской обороны, чаще всего занимается охраной определенных лиц, лояльных альянсу, а также зон повышенной опасности. Во время восстания, под командованием лейтенанта подразделения, выступает в качестве первой линии обороны, стараясь либо подавить бунт, либо защитить гражданское население от противника, вторгшегося в жилой сектор.]],
	specification = {
		"Может вести патруль в одиночку с докладом",
		"На вооружении CZ-75 и SPAS-12",
		"Обязан принимать участие в штурмовых миссиях",
		"Прямое руководство - C17I.MPF.SPIRE.LT",
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "itemstore_checker"},
	command = "mpf_spire_sgt",
	salary = RISED.Config.Economy.TEAM_MPF_SPIRE_SGT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_SPIRE_SGT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_SPIRE_SGT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 4,
	admin = 0,
	maxhealth = 100,
	maxarmor = 130,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(130)
		ply:SetMaxArmor(130)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_MPF_SPIRE_LT = DarkRP.createJob("C17I.MPF.SPIRE.LT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Командир штурмового отряда. Также занимается штурмом помещений. Вооружён крупнокалиберной штурмовой винтовкой АКМ, для поражения большого кол-ва противников, а также для точечной стрельбы по одиночным целям на достаточном расстоянии. Оснащен “Мэнхэком” для разведки местности.]],
	specification = {
		"Командует штурмовым отделом ГО",
		"На вооружении CZ-75 и OICW",
		"Cнаряжен усиленной броней",
		"Прямое руководство - C17I.MPF.JURY.CPT",
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "itemstore_checker"},
	command = "mpf_spire_lt",
	salary = RISED.Config.Economy.TEAM_MPF_SPIRE_LT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_SPIRE_LT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_SPIRE_LT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 2,
	admin = 0,
	maxhealth = 100,
	maxarmor = 140,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(140)
		ply:SetMaxArmor(140)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_MPF_SPIRE_CPT = DarkRP.createJob("C17I.MPF.SPIRE.CPT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Командир штурмового отряда. Также занимается штурмом помещений. Вооружён крупнокалиберной штурмовой винтовкой АКМ, для поражения большого кол-ва противников, а также для точечной стрельбы по одиночным целям на достаточном расстоянии. Оснащен “Мэнхэком” для разведки местности.]],
	specification = {
		"Командует штурмовым отделом ГО",
		"На вооружении CZ-75 и OICW",
		"Cнаряжен усиленной броней",
		"Прямое руководство - C17I.MPF.JURY.CPT",
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "itemstore_checker"},
	command = "mpf_spire_cpt",
	salary = RISED.Config.Economy.TEAM_MPF_SPIRE_CPT.salary,
	exp_type = RISED.Config.Economy.TEAM_MPF_SPIRE_CPT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_MPF_SPIRE_CPT.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	type = "Job_NPC_MPF",
	max = 1,
	admin = 0,
	maxhealth = 100,
	maxarmor = 170,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 3,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(170)
		ply:SetMaxArmor(170)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})



----- OTA -----

TEAM_OTA_Grunt = DarkRP.createJob("OW-I17.Grunt", {
	color = Color(55, 55, 255, 225),
	model = {"models/rised_project/combine/rised_combine.mdl",},
	description = [[]],
	weapons = {"re_hands", "combineidcard", "wep_jack_job_drpradio", "weapon_fists", "door_ram", "itemstore_checker"},
	command = "ota_grunt",
	salary = RISED.Config.Economy.TEAM_OTA_Grunt.salary,
	exp_type = RISED.Config.Economy.TEAM_OTA_Grunt.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_OTA_Grunt.exp_unlock_lvl,
	category = "Альянс",
	type = "useless",
	max = 4,
	admin = 0,
    candemote = false,
	maxhealth = 150,
	maxarmor = 125,
	maxwalk = 100,
	maxrun = 200,
	armorJobClass = 4,
	PlayerLoadout = function(ply)
		ply:SetHealth(150)
		ply:SetMaxHealth(150)
		ply:SetArmor(125)
		ply:SetMaxArmor(125)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
		ply:SetAmmo(138, "SMG1")
	end
})

TEAM_OTA_Hammer = DarkRP.createJob("OW-I17.Hammer", {
	color = Color(55, 55, 255, 225),
	model = {"models/rised_project/combine/rised_combine.mdl",},
	description = [[]],
	weapons = {"re_hands", "combineidcard", "wep_jack_job_drpradio", "weapon_fists", "door_ram", "itemstore_checker", "omnishield"},
	command = "ota_hammer",
	salary = RISED.Config.Economy.TEAM_OTA_Hammer.salary,
	exp_type = RISED.Config.Economy.TEAM_OTA_Hammer.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_OTA_Hammer.exp_unlock_lvl,
	category = "Альянс",
	type = "useless",
	max = 2,
	admin = 0,
    candemote = false,
	maxhealth = 200,
	maxarmor = 400,
	maxwalk = 100,
	maxrun = 140,
	armorJobClass = 6,
	PlayerLoadout = function(ply)
		ply:SetHealth(200)
		ply:SetMaxHealth(200)
		ply:SetArmor(400)
		ply:SetMaxArmor(400)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(140)
		ply:SetAmmo(24, "12x70_ammo")
	end
})

TEAM_OTA_Ordinal = DarkRP.createJob("OW-I17.Ordinal", {
	color = Color(55, 55, 255, 225),
	model = {"models/rised_project/combine/rised_combine.mdl",},
	description = [[]],
	weapons = {"re_hands", "combineidcard", "wep_jack_job_drpradio", "weapon_fists", "door_ram", "itemstore_checker"},
	command = "ota_ordinal",
	salary = RISED.Config.Economy.TEAM_OTA_Ordinal.salary,
	exp_type = RISED.Config.Economy.TEAM_OTA_Ordinal.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_OTA_Ordinal.exp_unlock_lvl,
	category = "Альянс",
	type = "useless",
	max = 1,
	admin = 0,
    candemote = false,
	maxhealth = 200,
	maxarmor = 250,
	maxwalk = 100,
	maxrun = 200,
	armorJobClass = 5,
	PlayerLoadout = function(ply)
		ply:SetHealth(200)
		ply:SetMaxHealth(200)
		ply:SetArmor(250)
		ply:SetMaxArmor(250)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
		ply:SetAmmo(90, "AR2")
	end
})



TEAM_OTA_Soldier = DarkRP.createJob("OW-I17.Soldier", {
	color = Color(55, 55, 255, 225),
	model = {"models/rised_project/combine/rised_combine.mdl",},
	description = [[Универсальный солдат альянса, вооружённый пистолетом-пулемётом МП7 и предназначенный для ведения боя в городских и приближённых к ним условиях, облачен в прочный кевларовый бронежилет, спасающий от многих видов вооружения и из-за стимуляторов и других вмешательств в организм носителя - не стесняющий движения солдата.]],
	specification = {
		"Имеет на вооружении MP7 и гранаты",
		"Основная боевая единица Альянса",
	},
	weapons = {"re_hands", "combineidcard", "wep_jack_job_drpradio", "weapon_fists", "door_ram", "itemstore_checker"},
	command = "ota_soldier",
	salary = RISED.Config.Economy.TEAM_OTA_Soldier.salary,
	-- exp_type = RISED.Config.Economy.TEAM_OTA_Soldier.exp_type,
	-- exp_unlock_lvl = RISED.Config.Economy.TEAM_OTA_Soldier.exp_unlock_lvl,
	-- type = "useless",
	category = "Альянс",
	max = 4,
	admin = 0,
    candemote = false,
	maxhealth = 125, 
	maxarmor = 175,
	maxwalk = 100,
	maxrun = 200,
	armorJobClass = 5,
	PlayerLoadout = function(ply)
		ply:SetHealth(125)
		ply:SetMaxHealth(125)
		ply:SetArmor(175)
		ply:SetMaxArmor(175)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
	end
})

TEAM_OTA_Striker = DarkRP.createJob("OW-I17.Striker", {
	color = Color(55, 55, 255, 225),
	model = {"models/rised_project/combine/rised_combine.mdl",},
	description = [[Является подтипом стандартного солдата альянса, что имеет на вооружении дробовик спас-12 и небольшое кол-во взрывчатки, используемой для штурма и/или обороны, а также всё то же снаряжение что и стандартный солдат надзора, за исключение небольшого усиления бронежилета, для минимизирования урона полученного в ближнем бою.]],
	specification = {
		"Имеет при себе кучу взрывчатки",
		"Имеет на вооружении SPAS-12",
	},
	weapons = {"re_hands", "combineidcard", "wep_jack_job_drpradio", "weapon_fists", "door_ram", "itemstore_checker"},
	command = "ota_striker",
	salary = RISED.Config.Economy.TEAM_OTA_Striker.salary,
	exp_type = RISED.Config.Economy.TEAM_OTA_Striker.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_OTA_Striker.exp_unlock_lvl,
	category = "Альянс",
	type = "Job_NPC_OTA",
	max = 2,
	admin = 0,
    candemote = false,
	maxhealth = 135, 
	maxarmor = 180,
	maxwalk = 100,
	maxrun = 200,
	armorJobClass = 5,
	premiumjob = false,
	donatejob = false,
	exclusivejob = false,
	PlayerLoadout = function(ply)
		ply:SetHealth(135)
		ply:SetMaxHealth(135)
		ply:SetArmor(180)
		ply:SetMaxArmor(180)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
	end
})

TEAM_OTA_Razor = DarkRP.createJob("OW-I17.Razor", {
	color = Color(55, 55, 255, 225),
	model = {"models/combine_overwatch_soldier.mdl",},
	description = [[Снайпер сверхчеловеческого отдела, что вооружён снайперской винтовкой на основе тёмной энергии, что позволяет вести огонь на огромных расстояниях и наносить ужасные повреждения, но при этом расплачиваясь скоростью снаряда, что летит чуть медленнее пули. Большую часть временим проводит на крышах и мостиках индустриального сектора.]],
	specification = {
		"На вооружении имеет Assault Sniper Rifle",
		"Может становиться невидимым жертвуя скоростью передвижения",
		"Считается максимально скрытой боевой единицей Альянса",
	},
	weapons = {"re_hands", "combineidcard", "wep_jack_job_drpradio", "weapon_fists", "door_ram", "itemstore_checker"},
	command = "ota_razor",
	salary = RISED.Config.Economy.TEAM_OTA_Razor.salary,
	exp_type = RISED.Config.Economy.TEAM_OTA_Razor.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_OTA_Razor.exp_unlock_lvl,
	category = "Альянс",
	type = "Job_NPC_OTA",
	max = 2,
	admin = 0,
    candemote = false,
	maxhealth = 100,
	maxarmor = 75,
	maxwalk = 100,
	maxrun = 200,
	armorJobClass = 4,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(75)
		ply:SetMaxArmor(75)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
	end
})

TEAM_OTA_Suppressor = DarkRP.createJob("OW-I17.Suppressor", {
	color = Color(55, 55, 255, 225),
	model = {"models/rised_project/combine/rised_combine.mdl",},
	description = [[Тяжеловооруженный сотрудник надзора, активно используемый для ведения подавляющего огня, а также уничтожения большого кол-ва слабо защищённых сил противника. За счет тяжелого станкового пулемёта АР1 на вооружении, а также усиленного бронежилета - не способен на быстрое передвижение, поэтому его задачей чаще всего стоит оборона какой либо точки или же подавление сил противника, во время которого остальные солдаты надзора направляются в атаку.]],
	specification = {
		"Имеет на вооружении импульсный LMG.",
		"Вооружён тяжёлой бронёй.",
		"Медлителен.",
	},
	weapons = {"re_hands", "combineidcard", "wep_jack_job_drpradio", "weapon_fists", "door_ram", "itemstore_checker"},
	command = "ota_suppressor",
	salary = RISED.Config.Economy.TEAM_OTA_Suppressor.salary,
	exp_type = RISED.Config.Economy.TEAM_OTA_Suppressor.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_OTA_Suppressor.exp_unlock_lvl,
	category = "Альянс",
	type = "Job_NPC_OTA",
	max = 1,
	admin = 0,
    candemote = false,
	maxhealth = 150,
	maxarmor = 250,
	maxwalk = 100,
	maxrun = 140,
	armorJobClass = 6,
	PlayerLoadout = function(ply)
		ply:SetHealth(150)
		ply:SetMaxHealth(150)
		ply:SetArmor(250)
		ply:SetMaxArmor(250)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(100)
		ply:SetAmmo(138, "SMG1")
	end
})

TEAM_OTA_Assassin = DarkRP.createJob("OW-I17.Assassin", {
	color = Color(55, 55, 255, 225),
	model = {"models/sirgibs/ragdolls/vance/combine_assassin_player.mdl",},
	description = [[Разведочная-Снайперская единица Сверхчеловеческого Отдела. Обладает высокой скоростью, ловкостью и точностью. Имеет “Женскую” форму тела. Используется в качестве разведки местности или охоты на определённую цель или же группу людей. Её задача проста, разведать/найти и убить. Большую часть времени проводит в ЗС на разведке.]],
	specification = {
		"Повышенная ловкость",
		"Минует урон от падения",
		"На вооружении SL-K-789",
	},
	weapons = {"re_hands", "combineidcard", "wep_jack_job_drpradio", "weapon_fists", "door_ram", "itemstore_checker"},
	command = "ota_assassin",
	salary = RISED.Config.Economy.TEAM_OTA_Assassin.salary,
	exp_type = RISED.Config.Economy.TEAM_OTA_Assassin.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_OTA_Assassin.exp_unlock_lvl,
	category = "Альянс",
	type = "Job_NPC_OTA",
	max = 1,
	admin = 0,
    candemote = false,
	maxhealth = 115,
	maxarmor = 100,
	maxwalk = 100,
	maxrun = 250,
	armorJobClass = 4,
	premiumjob = false,
	donatejob = true,
	exclusivejob = false,
	customCheck = function(ply) 
		if !ply:HasPurchase("job_ota_assassin") then
			DarkRP.notify(ply,5,5,"У вас не куплена данная профессия")
		end
		return ply:HasPurchase("job_ota_assassin")
	end,
	PlayerLoadout = function(ply)
		ply:SetHealth(115)
		ply:SetMaxHealth(115)
		ply:SetArmor(100)
		ply:SetMaxArmor(100)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(250)
	end
})

TEAM_OTA_Tech = DarkRP.createJob("OW-I17.Tech", {
	color = Color(55, 55, 255, 225),
	model = {"models/rised_project/combine/rised_combine.mdl",},
	description = [[Сотрудник технического отдела надзора, чьей целью служит починка всевозможной техники альянса, по типу: Ограничителей периметра, терминалов, полей. А также установки турелей и развёртывания контрольных пунктов на территории Запретных Секторов и прилегающих территориях, управление различной техникой альянса, требующей специальных навыков или же напросто недоверенной альянсом для сотрудников ГО. Вооружен пистолетом-пулеметом МП5к, а также бронежилетом сопоставимым по защищающим свойствам с аналогичным у ударника, но выдаваемый с иной целью, а именно - защитить ценного бойца во время починки техники альянса.]],
	specification = {
		"Может ставить турели",
		"Вооружён MP5k",
		"Может водить транспорт Альянса",
	},
	weapons = {"re_hands", "combineidcard", "wep_jack_job_drpradio", "weapon_fists", "door_ram", "itemstore_checker", "weapon_combine_config", "weapon_combinedoor_hacker"},
	command = "ota_tech",
	salary = RISED.Config.Economy.TEAM_OTA_Tech.salary,
	exp_type = RISED.Config.Economy.TEAM_OTA_Tech.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_OTA_Tech.exp_unlock_lvl,
	category = "Альянс",
	type = "Job_NPC_OTA",
	max = 2,
	admin = 0,
    candemote = false,
	maxhealth = 130,
	maxarmor = 180,
	maxwalk = 100,
	maxrun = 200,
	armorJobClass = 4,
	PlayerLoadout = function(ply)
		ply:SetHealth(130)
		ply:SetMaxHealth(130)
		ply:SetArmor(180)
		ply:SetMaxArmor(180)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
	end
})

TEAM_OTA_Commander = DarkRP.createJob("OW-I17.Commander", {
	color = Color(55, 55, 255, 225),
	model = {"models/rised_project/combine/rised_combine.mdl",},
	description = [[Командир команд стабилизации сверхчеловеческого отдела, до начала действий элитного отряда, имеет улучшенное снаряжение и небольшое усиление био-данных, из-за увеличения кол-ва принимаемых стимуляторов, во время вылазок и других действий команды стабилизации - принимает командование над всем отрядом, на каждый отряд не может быть более одного командира, подчиняется исключительно Crypt’у и элитному отряду, если тот берет командование над остальными солдатами в экстренных ситуациях.]],
	specification = {
		"Может командовать отрядом солдат из трёх бойцов",
		"Имеет на вооружении OICW",
	},
	weapons = {"re_hands", "combineidcard", "wep_jack_job_drpradio", "weapon_fists", "door_ram", "itemstore_checker"},
	command = "ota_commander",
	salary = RISED.Config.Economy.TEAM_OTA_Commander.salary,
	exp_type = RISED.Config.Economy.TEAM_OTA_Commander.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_OTA_Commander.exp_unlock_lvl,
	category = "Альянс",
	type = "Job_NPC_OTA",
	max = 1,
	admin = 0,
    candemote = false,
	maxhealth = 150,
	maxarmor = 200,
	maxwalk = 100,
	maxrun = 200,
	armorJobClass = 4,
	PlayerLoadout = function(ply)
		ply:SetHealth(150)
		ply:SetMaxHealth(150)
		ply:SetArmor(200)
		ply:SetMaxArmor(200)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
	end
})

TEAM_OTA_Elite = DarkRP.createJob("OW-I17.Elite", {
	color = Color(55, 55, 255, 225),
	model = {"models/rised_project/combine/rised_combine.mdl",},
	description = [[Элитные солдаты надзора, что используется крайне редко, из-за риска потерять данных сотрудников, поэтому почти всё время они находятся на охране важных для альянса объектов или же лиц. Вооружены импульсной винтовкой второго поколения, а также сверх-тяжёлым бронежилетом, но из-за неизвестных препаратов используемых ими в качестве стимуляторов, превышающих норму для человека, но это та цена, что приходится выплачивать им ради того чтобы иметь возможность легкого и свободного передвижения в своём снаряжении.]],
	specification = {
		"Элитный солдат",
		"Вооружён OICW",
		"Имеет улучшенную броню",
	},
	weapons = {"re_hands", "combineidcard", "wep_jack_job_drpradio", "weapon_fists", "door_ram", "itemstore_checker"},
	command = "ota_elite",
	salary = RISED.Config.Economy.TEAM_OTA_Elite.salary,
	exp_type = RISED.Config.Economy.TEAM_OTA_Elite.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_OTA_Elite.exp_unlock_lvl,
	category = "Альянс",
	type = "Job_NPC_OTA",
	max = 1,
	admin = 0,
    candemote = false,
	maxhealth = 140, 
	maxarmor = 225,
	maxwalk = 100,
	maxrun = 200,
	armorJobClass = 5,
	premiumjob = false,
	donatejob = true,
	exclusivejob = false,
	customCheck = function(ply) 
		if !ply:HasPurchase("job_ota_elite") then
			DarkRP.notify(ply,5,5,"У вас не куплена данная профессия")
		end
		return ply:HasPurchase("job_ota_elite")
	end,
	PlayerLoadout = function(ply)
		ply:SetHealth(140)
		ply:SetMaxHealth(140)
		ply:SetArmor(225)
		ply:SetMaxArmor(225)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
	end
})

TEAM_OTA_Crypt = DarkRP.createJob("OW-I17.Crypt", {
	color = Color(55, 55, 255, 225),
	model = {"models/rised_project/combine/rised_combine.mdl",},
	description = [[Лидер всего сверхчеловеческого отдела, очень редко выходит на зачистки или миссии так как имеет очень большую важность. Является самым главным в структуре сверхчеловеческого отдела и принимает полное командование над всеми Солдатами.]],
	specification = {
		"Может командовать всеми Солдатами Патруля Альянса",
	},
	weapons = {"re_hands", "combineidcard", "wep_jack_job_drpradio", "weapon_fists", "door_ram", "itemstore_checker"},
	command = "ota_crypt",
	salary = RISED.Config.Economy.TEAM_OTA_Crypt.salary,
	exp_type = RISED.Config.Economy.TEAM_OTA_Crypt.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_OTA_Crypt.exp_unlock_lvl,
	category = "Альянс",
	type = "useless",
	max = 1,
	admin = 0,
    candemote = false,
	maxhealth = 500, 
	maxarmor = 115,
	maxwalk = 100,
	maxrun = 200,
	armorJobClass = 5,
	premiumjob = true,
	donatejob = false,
	exclusivejob = false,
	customCheck = function(ply) 
		if !ply:HasPurchase("status_premium") then
			DarkRP.notify(ply,5,5,"У вас не куплена Premium подписка")
		end
		return ply:HasPurchase("status_premium")
	end,
	PlayerLoadout = function(ply)
		ply:SetHealth(500)
		ply:SetMaxHealth(500)
		ply:SetArmor(115)
		ply:SetMaxArmor(115)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
	end
})

TEAM_OTA_Broken = DarkRP.createJob("OW-I17.Elite", {
	color = Color(55, 55, 255, 225),
	model = {"models/rised_project/combine/rised_combine.mdl",},
	description = [[Солдат патруля Альянса со сломанным чипом.]],
	specification = {
		"Бракованный ОТА",
		"Вооружён OICW",
		"Имеет улучшенную броню",
	},
	weapons = {"re_hands", "combineidcard", "wep_jack_job_drpradio", "weapon_fists", "door_ram", "itemstore_checker", "swb_oicw", "swb_smg"},
	command = "ota_broken",
	salary = 0,
	category = "Альянс",
	type = "Job_NPC_OTA",
	max = 1,
	admin = 0,
    candemote = false,
	maxhealth = 140, 
	maxarmor = 225,
	maxwalk = 100,
	maxrun = 200,
	armorJobClass = 5,
	premiumjob = false,
	donatejob = false,
	exclusivejob = true,
	customCheck = function(ply) 
		if !ply:HasPurchase("job_ota_broken") then
			DarkRP.notify(ply,5,5,"У вас не куплена данная профессия")
		end
		return ply:HasPurchase("job_ota_broken")
	end,
	PlayerLoadout = function(ply)
		ply:SetHealth(140)
		ply:SetMaxHealth(140)
		ply:SetArmor(225)
		ply:SetMaxArmor(225)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
		ply:SetAmmo( 250, "5,45x39_ammo" )
		ply:SetAmmo( 250, "SMG1" )
	end
})


TEAM_OWUDISPATCH = DarkRP.createJob("I17.AI.DISPATCH", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/player/soldier_stripped.mdl",
	},
	description = [[Диспетчер, ЦЕНТР. Искусственный интеллект Альянса, основной задачей которого является контроль секторов, координирование действий патрульных и стабилизирующих групп.]],
	specification = {
		"Является искусственным интеллектом Альянса",
		"Имеет функционал по наблюдению за городом через камеры и сканнеры",
	},
	weapons = {"weapon_controllable_city_scanner", "wep_jack_job_drpradio"},
	command = "owudispatch",
	max = 1,
	salary_rank = dispatch_salary,
	admin = 0,
	type = "Job_NPC_OTA",
	salary = RISED.Config.Economy.TEAM_OWUDISPATCH.salary,
	exp_type = RISED.Config.Economy.TEAM_OWUDISPATCH.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_OWUDISPATCH.exp_unlock_lvl,
	loyaltyLevel = 0,
	category = "Альянс",
	maxhealth = 100,
	maxarmor = 100,
	maxwalk = 60,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(100)
		ply:SetMaxArmor(100)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

----- Synth Beta -----

TEAM_SYNTH_CREMATOR = DarkRP.createJob("SYNTH.CREMATOR", {
	color = Color(55, 55, 255, 225),
	model = {"models/cremator.mdl"},
	description = [[Автономная единица, по названию которой понятно, что она занимается патрулём жилого сектора, в котором находится в постоянном поиске биологического мусора, по типу трупов, а также проникшей из каналов или пустошей фауны зена, уничтожение которой также входит в приоритетные задачи.]],
	specification = {
		"Имеет при себе иммулятор которым он может наносить большой и постоянный урон",
		"Основная деятельность расщепление трупов с улиц города",
	},
	weapons = {"weapon_synth_cremator"},
	command = "synth_cremator",
	salary = RISED.Config.Economy.TEAM_SYNTH_CREMATOR.salary,
	exp_type = RISED.Config.Economy.TEAM_SYNTH_CREMATOR.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_SYNTH_CREMATOR.exp_unlock_lvl,
	category = "Альянс",
	type = "Job_Terminal_Synth",
	max = 1,
	admin = 0,
    candemote = false,
	maxhealth = 700, 
	maxarmor = 325,
	maxwalk = 100,
	maxrun = 100,
	armorJobClass = 5,
	premiumjob = false,
	donatejob = false,
	exclusivejob = false,
	PlayerLoadout = function(ply)
		ply:SetHealth(700)
		ply:SetMaxHealth(700)
		ply:SetArmor(325)
		ply:SetMaxArmor(325)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(100)
		return true
	end
})

TEAM_SYNTH_GUARD = DarkRP.createJob("SYNTH.GUARD", {
	color = Color(55, 55, 255, 225),
	model = {"models/orion/combine_guard.mdl"},
	description = [[Тяжеловооружённый синтет, а конкретнее - человек облачённый в огромный экзоскелет, помогающий изнеможённому от многочисленных механических вмешательств в организм телу стать идеальным “мозгом” гвардейца. Являясь чем-то средним между тяжёлой пехотой и военным транспортом, большую часть времени проводит в гараже П.У, ожидая своего выхода для мощной и стремительной атаки.]],
	specification = {
		"Владеет крайне мощным оружием, напоминающим пушку страйдера, которое способно аннигилировать противников.",
		"Имеет хорошие показатели защиты, но является медленным юнитом на поле боя.",
	},
	weapons = {"weapon_synth_guard"},
	command = "synth_guard",
	salary = RISED.Config.Economy.TEAM_SYNTH_GUARD.salary,
	exp_type = RISED.Config.Economy.TEAM_SYNTH_GUARD.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_SYNTH_GUARD.exp_unlock_lvl,
	category = "Альянс",
	type = "Job_Terminal_Synth",
	max = 1,
	admin = 0,
    candemote = false,
	maxhealth = 1200, 
	maxarmor = 725,
	maxwalk = 100,
	maxrun = 100,
	armorJobClass = 5,
	premiumjob = false,
	donatejob = true,
	exclusivejob = false,
	customCheck = function(ply) 
		if !ply:HasPurchase("job_synth_guard") then
			DarkRP.notify(ply,5,5,"У вас не куплена данная профессия")
		end
		return ply:HasPurchase("job_synth_guard")
	end,
	PlayerLoadout = function(ply)
		ply:SetHealth(1200)
		ply:SetMaxHealth(1200)
		ply:SetArmor(725)
		ply:SetMaxArmor(725)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(100)
		return true
	end
})

TEAM_SYNTH_ELITE = DarkRP.createJob("SYNTH.KEEN", {
	color = Color(55, 55, 255, 225),
	model = {"models/synth/elite_brown.mdl"},
	description = [[Пехотинец завоевательной армии альянса, не столь часто используемый в боях непосредственно при контакте с инопланетной расой, но служащий последней и самой действенной силой альянса после захвата иных миров. Вооружён винтовкой на основе тёмной материей, что при попадании в противника разрушает его ткани на молекулярном уровне. Является полностью автономной единицей, но всегда подчиняется И.И альянса, использующийся в качестве координатора и командира.]],
	specification = {
		"Является основной боевой единицей Синтетического отдела, что делает его лучше чем Солдаты Патруля Альянса.",
		"Вооружён винтовкой на основе тёмной материей, что при попадании в противника разрушает его ткани на молекулярном уровне.",
	},
	weapons = {},
	command = "synth_elite",
	salary = RISED.Config.Economy.TEAM_SYNTH_ELITE.salary,
	exp_type = RISED.Config.Economy.TEAM_SYNTH_ELITE.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_SYNTH_ELITE.exp_unlock_lvl,
	category = "Альянс",
	type = "Job_Terminal_Synth",
	max = 4,
	admin = 0,
    candemote = false,
	maxhealth = 200, 
	maxarmor = 300,
	maxwalk = 100,
	maxrun = 200,
	armorJobClass = 5,
	premiumjob = false,
	donatejob = true,
	exclusivejob = false,
	customCheck = function(ply) 
		if !ply:HasPurchase("job_synth_keen") then
			DarkRP.notify(ply,5,5,"У вас не куплена данная профессия")
		end
		return ply:HasPurchase("job_synth_keen")
	end,
	PlayerLoadout = function(ply)
		ply:SetHealth(200)
		ply:SetMaxHealth(200)
		ply:SetArmor(300)
		ply:SetMaxArmor(300)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
		return true
	end
})

TEAM_SYNTH_ELITE2 = DarkRP.createJob("SYNTH.CRUDE", {
	color = Color(55, 55, 255, 225),
	model = {"models/synth/elite_green.mdl"},
	description = [[Основная пехота завоевательной армии альянса. За счет портативного генератора щита, встроенного в руку, а также импульсному копью, отлично справляющегося как для уничтожения противника на расстоянии, так и на ближних дистанциях, данная боевая единица эффективна в самых разных условиях, в которых придется вести боевые действия. Благодаря своему щиту, используется в качестве разведчика в густо населенных фауной из зена, а также другими неприятелями, каналах.]],
	specification = {
		"Является боевой единицей поддержки Синтетического отдела.",
		"Эффективный в узких так и в обширных пространствах.",
	},
	weapons = {},
	command = "synth_elite2",
	salary = RISED.Config.Economy.TEAM_SYNTH_ELITE2.salary,
	exp_type = RISED.Config.Economy.TEAM_SYNTH_ELITE2.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_SYNTH_ELITE2.exp_unlock_lvl,
	category = "Альянс",
	type = "Job_Terminal_Synth",
	max = 4,
	admin = 0,
    candemote = false,
	maxhealth = 200, 
	maxarmor = 250,
	maxwalk = 100,
	maxrun = 200,
	armorJobClass = 5,
	premiumjob = false,
	donatejob = true,
	exclusivejob = false,
	customCheck = function(ply) 
		if !ply:HasPurchase("job_synth_crude") then
			DarkRP.notify(ply,5,5,"У вас не куплена данная профессия")
		end
		return ply:HasPurchase("job_synth_crude")
	end,
	PlayerLoadout = function(ply)
		ply:SetHealth(200)
		ply:SetMaxHealth(200)
		ply:SetArmor(250)
		ply:SetMaxArmor(250)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(200)
		return true
	end
})



----- Rebels -----

TEAM_REBELNEWBIE = DarkRP.createJob("Новобранец", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Является новобранцев в структуре Сопротивления, имеет очень слабые возможности, только начал осваиватся в структуре Сопротивления.]],
	specification = {
		"Имеет опыт в использовании одноручного оружия.",
		"Может носить броню 2-го класса.",
	},
	weapons = {"re_hands", "weapon_fists", "wep_jack_job_drpradio", "itemstore_checker"},
	command = "rebel_newbie",
	salary = RISED.Config.Economy.TEAM_REBELNEWBIE.salary,
	exp_type = RISED.Config.Economy.TEAM_REBELNEWBIE.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_REBELNEWBIE.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_Rebel",
	max = 4,
	admin = 0,
    candemote = false,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_REBELSOLDAT = DarkRP.createJob("Солдат", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Полноценный член Сопротивления, хоть всё ещё и слабо вооруженный, по сравнению со своими противниками. Из-за скрытной деятельности сопротивления, старается не особо показываться вне базы, дабы не выдавать её местоположение и не ставить под угрозу всю ячейку.]],
	specification = {
		"Имеет опыт в использовании всего возможного оружия, кроме тяжёлого и снайперского.",
		"Может носить броню до 4-го класса.",
	},
	weapons = {"re_hands", "weapon_fists", "wep_jack_job_drpradio", "itemstore_checker"},
	command = "rebel_soldat",
	salary = RISED.Config.Economy.TEAM_REBELSOLDAT.salary,
	exp_type = RISED.Config.Economy.TEAM_REBELSOLDAT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_REBELSOLDAT.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_Rebel",
	max = 4,
	admin = 0,
    candemote = false,
	maxhealth = 100,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_REBELENGINEER = DarkRP.createJob("Инженер", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Техник Сопротивления, обладающий знаниями в области инженерий, а также немного в технологиях Альянса. Может устанавливать созданные турели и ремонтировать броню солдат Сопротивления. Разбирается в постройках баррикад, возведении каких-либо больших построек. Выступает в сопротивлении как и бойцом, так и солдатом поддержки. Поддерживая стабильность бронижелетов союзников, турелями в тылу или на передовых, а также как освободитель вортигонтов от оков.]],
	specification = {
		"Может освобождать Вортигонтов от оков.",
		"Чинить броню и перепрограммировать турели.",
		"Создавать вещи на столе крафта.",
		"Возводить укрепления и баррикады.",
	},
	weapons = {"re_hands", "weapon_fists", "wep_jack_job_drpradio", "weapon_suitcharger", "itemstore_checker", "weapon_crafting_tool"},
	command = "rebel_engireer",
	salary = RISED.Config.Economy.TEAM_REBELENGINEER.salary,
	exp_type = RISED.Config.Economy.TEAM_REBELENGINEER.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_REBELENGINEER.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_Rebel",
	max = 2,
	admin = 0,
    candemote = false,
	maxhealth = 100,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_REBELMEDIC = DarkRP.createJob("Медик", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Полевой врач, который ни раз вытаскивал своих бойцов с того света, оперируя их на базе подручными средствами. Из-за дефицита лекарственных средств, медики Сопротивления не оказывают никакой мед. помощи людям извне. Достаточно слабо вооружён, но учитывая род занятий, ему это не слишком мешает.]],
	specification = {
		"Может закупать таблетки.",
		"Может лечить союзников.",
		"Имеет доступ к медицинской броне 3-го класса.",
	},
	weapons = {"re_hands", "weapon_medkit", "weapon_fists", "wep_jack_job_drpradio", "weapon_medical_scanner", "itemstore_checker"},
	command = "rebel_medic",
	salary = RISED.Config.Economy.TEAM_REBELMEDIC.salary,
	exp_type = RISED.Config.Economy.TEAM_REBELMEDIC.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_REBELMEDIC.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_Rebel",
	max = 2,
	admin = 0,
    candemote = false,
	maxhealth = 100,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_REBELSPY02 = DarkRP.createJob("Лазутчик", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Член сопротивления, являющийся глазами и ушами Сопротивления, пытаясь скрытно проникнуть в жилой сектор и поставлять информацию командирам и ветеранам. При себе не имеет никакого оружия, для того чтобы не вызывать никаких подозрения в жилом секторе.]],
	specification = {
		"Имеет доступ к дверям ГСР и некоторым дверям Альянса.",
		"Может находиться в городе, в любое время.",
		"Имеет идентификационную карточку гражданина.",
	},
	weapons = {"re_hands", "citizenidcard", "weapon_cuff_rope", "combineidcard", "wep_jack_job_drpradio", "weapon_fists", "itemstore_checker"},
	command = "rebel_spy02",
	salary = RISED.Config.Economy.TEAM_REBELSPY02.salary,
	exp_type = RISED.Config.Economy.TEAM_REBELSPY02.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_REBELSPY02.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_Rebel",
	max = 5,
	admin = 0,
    candemote = false,
	maxhealth = 100,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_REBEL_SPEC = DarkRP.createJob("Специалист-подрывник", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Специалист-Подрывник - Своеобразный “Диверсант” Сопротивления, неплохо разбирается в взрывчатых веществах, потому управляется с ней и является важным членом который может организовать отступление или же ловушку.]],
	specification = {
		"Может закупать взрывчатку у продавцов нпс, находящиеся в Запретном Секторе.",
		"Имеет доступ к облегченной броне 4-го класса.",
	},
	weapons = {"re_hands", "weapon_fists", "wep_jack_job_drpradio", "itemstore_checker"},
	command = "rebel_spec",
	salary = RISED.Config.Economy.TEAM_REBEL_SPEC.salary,
	exp_type = RISED.Config.Economy.TEAM_REBEL_SPEC.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_REBEL_SPEC.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_Rebel",
	max = 2,
	admin = 0,
    candemote = false,
	maxhealth = 100,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_REBEL_VETERAN = DarkRP.createJob("Ветеран", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Закаленный в боях солдат, получивший авторитет среди других солдат, а также командиров, поэтому является своеобразным сержантом, в структуре сопротивления, потому занимается боевой подготовкой остального состава, руководит отдельными отрядами. Вооружён чуть лучше чем обыкновенный солдат, но всё ещё не выдерживает сравнения с солдатами надзора.]],
	specification = {
		"Может выступать в качестве командующего если на базе нету Лидера и Командира. (Кроме Отряда Лямбды)",
		"Имеет доступ к снайперским винтовкам.",
		"Может закупать редкое вооружение у продавцов.",
		"Имеет доступ к броне 5-го класса.",
	},
	weapons = {"re_hands", "weapon_rebelup", "weapon_fists", "wep_jack_job_drpradio", "itemstore_checker"},
	command = "rebel_veteran",
	salary = RISED.Config.Economy.TEAM_REBEL_VETERAN.salary,
	exp_type = RISED.Config.Economy.TEAM_REBEL_VETERAN.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_REBEL_VETERAN.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_Rebel",
	max = 2,
	admin = 0,
    candemote = false,
	maxhealth = 100,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_REBELSPY01 = DarkRP.createJob("Дезертир MPF.RECRUIT", {
	color = Color(55, 55, 255, 225),
	model = {
		"models/rised_project/metropolice/rised_mpf_01.mdl",
		"models/rised_project/metropolice/rised_mpf_02.mdl",
		"models/rised_project/metropolice/rised_mpf_03.mdl",
		"models/rised_project/metropolice/rised_mpf_04.mdl",
		"models/rised_project/metropolice/rised_mpf_05.mdl",
		"models/rised_project/metropolice/rised_mpf_06.mdl",
		"models/rised_project/metropolice/rised_mpf_07.mdl",
		"models/rised_project/metropolice/rised_mpf_08.mdl",
		"models/rised_project/metropolice/rised_mpf_09.mdl",
	},
	description = [[Сбежавший из регулярной армии альянса призывник, захвативший с собой большую часть своего снаряжения, что не отслеживается альянсом, а также достаточно неплохой бронежилет, скрывающийся под формой. Среди членов сопротивления обладает большим авторитетом, потому является тем же ветераном, хоть и неофициально, всегда имея возможность отказаться от соучастия с ними.]],
	specification = {
		"Может проходить сквозь силовые поля.",
		"Может воровать оружие и еду со складов Альянса.",
		"Может находиться в городе, но это не желательно.",
	},
	weapons = {"re_hands", "weapon_cp_stick", "wep_jack_job_drpradio", "combineidcard", "weapon_fists", "itemstore_checker"},
	command = "rebel_spy01",
	exp_type = RISED.Config.Economy.TEAM_REBELSPY01.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_REBELSPY01.exp_unlock_lvl,
	category = "Альянс",
	type = "useless",
	max = 25,
	salary = 0,
	admin = 0,
    candemote = false,
	maxhealth = 100,
	maxarmor = 100,
	maxwalk = 60,
	maxrun = 200,
	armorJobClass = 2,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(100)
		ply:SetMaxArmor(100)
		ply:SetWalkSpeed(60)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_REBELJUGGER = DarkRP.createJob("Джаггернаут", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/humans/hev_mark2.mdl",
	},
	description = [[Тяжеловес - “Джаггернаут” Сопротивления, облачен в лучшую броню, сравнимую с бронежилетом солдата надзора, из которого, частично, и была сделана броня Тяжеловеса. Вооружение также находится на высшем уровне, среди всего сопротивления, потому крайне не рекомендуется пускать этих бойцов как одиночную боевую единицу, так как это приведёт к большим трудностям в дальнейшем.]],
	specification = {
		"Является самым устойчивым и сильным среди Сопротивления",
	 	"Может выступать в качестве командира отряда.",
	 	"Имеет доступ к использованию тяжелого оружия.",
	},
	weapons = {"re_hands", "weapon_fists", "wep_jack_job_drpradio", "itemstore_checker"},
	command = "rebel_jugger",
	exp_type = RISED.Config.Economy.TEAM_REBELJUGGER.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_REBELJUGGER.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_Rebel",
	max = 1,
	salary = 0,
	admin = 0,
    candemote = false,
	maxhealth = 250,
	maxarmor = 285,
	maxwalk = 100,
	maxrun = 135,
	armorJobClass = 6,
	premiumjob = true,
	donatejob = false,
	exclusivejob = false,
	customCheck = function(ply) 
		if !ply:HasPurchase("status_premium") then
			DarkRP.notify(ply,5,5,"У вас не куплена Premium подписка")
		end
		return ply:HasPurchase("status_premium")
	end,
	PlayerLoadout = function(ply)
		ply:SetHealth(250)
		ply:SetMaxHealth(250)
		ply:SetArmor(285)
		ply:SetMaxArmor(285)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(60)
		ply:SetRunSpeed(135)
	end
})

TEAM_REBEL_COMMANDER = DarkRP.createJob("Командир", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Член Сопротивления, командующей всеми участниками движения в регионе, и не важно, основатель ли это всей ячейки или же просто пользующийся большим авторитетом среди всего Сопротивления человек. Вооружён на уровне Ветерана, за исключением укрепленного броне-элементами бронежилета.]],
	specification = {
		"Может принимать полное командование над всем Сопротивлением при отсутствии Лидера. (Кроме Отрядом Лямбды)",
		"Имеет доступ ко всей возможной броне.",
		"Может использовать всё возможное оружие.",
		"Может принимать в Сопротивление или же выгонять повстанцев.",
	},
	weapons = {"re_hands", "weapon_rebelup", "weapon_cuff_rope", "weapon_fists", "wep_jack_job_drpradio", "itemstore_checker"},
	command = "rebel_commander",
	salary = RISED.Config.Economy.TEAM_REBEL_COMMANDER.salary,
	exp_type = RISED.Config.Economy.TEAM_REBEL_COMMANDER.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_REBEL_COMMANDER.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_Rebel",
	max = 2,
	admin = 0,
    candemote = false,
	maxhealth = 115,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(115)
		ply:SetMaxHealth(115)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_REBELLEADER = DarkRP.createJob("Лидер сопротивления", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Самый авторитетный член Сопротивления, мнение которого решает в каждом принимаемом решении. По факту является тем же командиром, за исключением того что остальные Командиры прислушиваются его мнения, а также условно подчиняясь ему.]],
	specification = {
		"Может командовать всем Сопротивлением, включая отряд Лямбды.",
		"Может принимать в Сопротивление или же выгонять бездельников.",
		"Может использовать любое оружие и броню.",
		"У продавцов может быть скидка, также ему могут продавать самые ценные вещи.",
	},
	weapons = {"re_hands", "weapon_rebelup", "weapon_cuff_rope", "weapon_crowbar", "wep_jack_job_drpradio", "weapon_fists", "weapon_crowbar", "itemstore_checker"},
	command = "rebel_leader",
	salary = RISED.Config.Economy.TEAM_REBELLEADER.salary,
	exp_type = RISED.Config.Economy.TEAM_REBELLEADER.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_REBELLEADER.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_Rebel",
	max = 1,
	admin = 0,
    candemote = false,
	maxhealth = 125,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(125)
		ply:SetMaxHealth(125)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})



----- Lambda -----

TEAM_LAMBDASOLDAT = DarkRP.createJob("Боец Лямбды", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Повстанец, доказавший свою значимость в деле сопротивления, из-за чего был допущен в отряд Лямбды.]],
	specification = {
		"Имеет доступ ко всему оружию, кроме тяжёлой и снайперской.",
		"Имеет доступ ко всей броне.",
		"Намного сильнее и вынослевее, чем простые повстанцы.",
	},
	weapons = {"re_hands", "weapon_fists", "weapon_cuff_tactical", "wep_jack_job_drpradio", "itemstore_checker"},
	command = "lambda_soldat",
	exp_type = RISED.Config.Economy.TEAM_LAMBDASOLDAT.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_LAMBDASOLDAT.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_RebelLambda",
	max = 2,
	salary = 0,
	admin = 0,
    candemote = false,
	maxhealth = 125,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	premiumjob = true,
	donatejob = false,
	exclusivejob = false,
	customCheck = function(ply) 
		if !ply:HasPurchase("status_premium") then
			DarkRP.notify(ply,5,5,"У вас не куплена Premium подписка")
		end
		return ply:HasPurchase("status_premium")
	end,
	PlayerLoadout = function(ply)
		ply:SetHealth(125)
		ply:SetMaxHealth(125)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_LAMBDASNIPER = DarkRP.createJob("Снайпер Лямбды", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Повстанец, являющийся лучшим снайпером Сопротивления, из-за чего и был допущен в отряд Лямбды.]],
	specification = {
		"Очень быстрый и выносливый.",
		"Имеет большой опыт в использовании Снайперских винтовок.",
		"Действует на дальних расстояниях.",
	},
	weapons = {"re_hands", "weapon_fists", "weapon_cuff_tactical", "wep_jack_job_drpradio", "itemstore_checker"},
	command = "lambda_sniper",
	exp_type = RISED.Config.Economy.TEAM_LAMBDASNIPER.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_LAMBDASNIPER.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_RebelLambda",
	max = 1,
	salary = 0,
	admin = 0,
    candemote = false,
	maxhealth = 100,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 245,
	premiumjob = true,
	donatejob = false,
	exclusivejob = false,
	customCheck = function(ply) 
		if !ply:HasPurchase("status_premium") then
			DarkRP.notify(ply,5,5,"У вас не куплена Premium подписка")
		end
		return ply:HasPurchase("status_premium")
	end,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(245)
	end
})

TEAM_LAMBDACOMMANDER = DarkRP.createJob("Командир отряда Лямбды", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Повстанец, что руководит деятельностью отряда Лямбды. Выступает в роли руководителя повстанческого движения.]],
	specification = {
		"Может командовать всем отрядом лямбды.",
		"Умеет использовать всё оружие которое имеется.",
		"Может носить любую броню.",
		"По силе, почти равен Лидеру Сопротивления.",
	},
	weapons = {"re_hands", "weapon_fists", "weapon_cuff_tactical", "wep_jack_job_drpradio", "itemstore_checker"},
	command = "lambda_commander",
	exp_type = RISED.Config.Economy.TEAM_LAMBDACOMMANDER.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_LAMBDACOMMANDER.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_RebelLambda",
	max = 1,
	salary = 0,
	admin = 0,
    candemote = false,
	maxhealth = 125,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	premiumjob = true,
	donatejob = false,
	exclusivejob = false,
	customCheck = function(ply) 
		if !ply:HasPurchase("status_premium") then
			DarkRP.notify(ply,5,5,"У вас не куплена Premium подписка")
		end
		return ply:HasPurchase("status_premium")
	end,
	PlayerLoadout = function(ply)
		ply:SetHealth(125)
		ply:SetMaxHealth(125)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})



----- Vortigaunts -----

TEAM_VORTIGAUNTSLAVE = DarkRP.createJob("Вортигонт-раб", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/vortigauntslave.mdl",
	},
	description = [[]],
	weapons = {"re_hands", "weapon_fists"},
	command = "vortigauntslave",
	category = "Гражданские",
	type = "useless",
	max = 5,
	salary = 0,
	admin = 0,
    candemote = false,
	maxhealth = 300,
	maxarmor = 300,
	maxwalk = 100,
	maxrun = 200,
	premiumjob = false,
	donatejob = true,
	exclusivejob = false,
	customCheck = function(ply) 
		if !ply:HasPurchase("job_vort_slave") then
			DarkRP.notify(ply,5,5,"У вас не куплена данная профессия")
		end
		return ply:HasPurchase("job_vort_slave")
	end,
	PlayerLoadout = function(ply)
		ply:SetHealth(300)
		ply:SetMaxHealth(300)
		ply:SetArmor(0)
		ply:SetMaxArmor(300)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
		return true
	end
})

TEAM_VORTIGAUNT = DarkRP.createJob("Вортигонт", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/vortigaunt.mdl",
	},
	description = [[Освободившейся от рабства Альянса вортигонт, который помогает Сопротивлению и уже является для повстанцев своим.]],
	weapons = {"re_hands", "weapon_fists", "itemstore_checker", "weapon_vortbeam"},
	command = "vortigaunt",
	category = "Гражданские",
	type = "useless",
	max = 5,
	salary = 0,
	admin = 0,
    candemote = false,
	maxhealth = 300,
	maxarmor = 300,
	maxwalk = 100,
	maxrun = 200,
	premiumjob = false,
	donatejob = true,
	exclusivejob = false,
	customCheck = function(ply) 
		if !ply:HasPurchase("job_vort_slave") then
			DarkRP.notify(ply,5,5,"У вас не куплена данная профессия")
		end
		return ply:HasPurchase("job_vort_slave")
	end,
	PlayerLoadout = function(ply)
		ply:SetHealth(300)
		ply:SetMaxHealth(300)
		ply:SetArmor(0)
		ply:SetMaxArmor(300)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})


----- Crime -----

TEAM_JAILEDCITIZEN = DarkRP.createJob("Арестант", {
	color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[]],
	weapons = {"re_hands", "weapon_fists"},
	command = "jailedcitizen",
	category = "Гражданские",
	type = "useless",
	max = 0,
	salary = 0,
	admin = 0,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
		if math.random(1,5) == 1 then
			ply:Give("weapon_combinedoor_hacker")
		end
		return true
	end
})

TEAM_HOBOMAN = DarkRP.createJob("Изгой", {
	color = Color(45, 175, 85, 225),
	model = {"models/player/corpse1.mdl",},
	description = [[]],
	weapons = {"re_hands", "weapon_physgun", "gmod_tool", "weapon_fists", "weapon_hoboinfection"},
	command = "hoboman",
	category = "Гражданские",
	type = "useless",
	max = 0,
	salary = 0,
	admin = 0,
    candemote = false,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
		return
	end
})

TEAM_THEIF = DarkRP.createJob("Вор", {
	color = Color(255, 0, 0, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Анти-гражданин, промышляющий воровством и кражами. Некрупный преступник, пытающиеся улучшить условия своей жизни за счёт других. Умеет незаметно воровать вещи из кармана граждан.]],
	specification = {
		"Может воровать токены.",
	},
	weapons = {"re_hands", "citizenidcard", "swep_pickpocket", "weapon_fists", "itemstore_checker"},
	command = "theif",
	salary = RISED.Config.Economy.TEAM_THEIF.salary,
	exp_type = RISED.Config.Economy.TEAM_THEIF.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_THEIF.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_Crime",
	max = 0,
	admin = 0,
    candemote = false,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_DRUGDEALER = DarkRP.createJob("Наркоторговец", {
	color = Color(255, 0, 0, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Анти-гражданин, промышляющий созданием наркотиков и их сбытом специальным заказчикам и обычным гражданам.]],
	specification = {
		"Имеет доступ к покупке нужных приборов для выращивания травки.",
	},
	weapons = {"re_hands", "citizenidcard", "weapon_fists"},
	command = "dealer",
	salary = RISED.Config.Economy.TEAM_DRUGDEALER.salary,
	exp_type = RISED.Config.Economy.TEAM_DRUGDEALER.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_DRUGDEALER.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_Crime",
	max = 0,
	admin = 0,
    candemote = false,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_UNGUN = DarkRP.createJob("Контрабандист", {
	color = Color(255, 0, 0, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Анти-гражданин, промышляющий продажей различных услуг: от контрабанды разного уровня до информации. Не выбирает стороны, ищет лишь выгоду для себя.]],
	specification = {
		"Может закупать контрабанду у торговцев.",
	},
	weapons = {"re_hands", "citizenidcard", "weapon_fists"},
	command = "gundealer",
	salary = RISED.Config.Economy.TEAM_UNGUN.salary,
	exp_type = RISED.Config.Economy.TEAM_UNGUN.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_UNGUN.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_Crime",
	max = 2,
	admin = 0,
    candemote = false,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_REFUGEE = DarkRP.createJob("Беженец", {
	color = Color(255, 0, 0, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[Беженец - это лицо, покинувшее территорию города, в связи с чрезвычайной ситуацией, что угрожала его жизни. В частности, это жители городов, сбежавшие от правительства Альянса, что могли присоединиться к другим беженцам, организовывая общины или другие объединения. Большинство выступает против тирании Альянса, но не показывают этого явно, за исключением людей, что сотрудничают с сопротивление и даже активно помогают ему, вплоть до присоединения к нему.]],
	specification = {
		"Более опытен в использовании оружия.",
		"Знает Запретный Сектор вдоль и поперёк.",
	},
	weapons = {"re_hands", "weapon_fists", "itemstore_checker"},
	command = "refugee",
	salary = RISED.Config.Economy.TEAM_REFUGEE.salary,
	exp_type = RISED.Config.Economy.TEAM_REFUGEE.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_REFUGEE.exp_unlock_lvl,
	category = "Гражданские",
	type = "Job_NPC_Refugee",
	max = 0,
	admin = 0,
    candemote = false,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})



----- Zombie -----

TEAM_ZOMBIE = DarkRP.createJob("Зомби", {
	color = Color(0, 0, 0, 225),
	model = {"models/player/zombie_classic.mdl",},
	description = [[]],
	weapons = {"weapon_weapons_zombie"},
	command = "zombie",
	max = 100,
	salary = 0,
	admin = 0,
	type = "zombie",
	category = "Некротики",
    candemote = false,
	maxhealth = 100,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 100,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(100)
		return true
	end
})

TEAM_ZOMBIECP = DarkRP.createJob("Зомби ГО", {
	color = Color(0, 0, 0, 225),
	model = {"models/player/zombie_classic.mdl",},
	description = [[]],
	weapons = {"weapon_weapons_zombie"},
	command = "zombiecp",
	max = 100,
	salary = 0,
	admin = 0,
	type = "zombie",
	category = "Некротики",
    candemote = false,
	maxhealth = 550,
	maxarmor = 80,
	maxwalk = 125,
	maxrun = 125,
	PlayerLoadout = function(ply)
		ply:SetHealth(550)
		ply:SetArmor(80)
		ply:SetMaxArmor(80)
		ply:SetWalkSpeed(125)
		ply:SetRunSpeed(125)
		return true
	end
})

TEAM_FASTZOMBIE = DarkRP.createJob("Быстрый зомби", {
	color = Color(0, 0, 0, 225),
	model = {"models/player/zombie_fast.mdl",},
	description = [[]],
	weapons = {"weapon_weapons_fastzombie"},
	command = "fastzombie",
	max = 100,
	salary = 0,
	admin = 0,
	type = "zombie",
	category = "Некротики",
    candemote = false,
	maxhealth = 400,
	maxarmor = 0,
	maxwalk = 235,
	maxrun = 360,
	PlayerLoadout = function(ply)
		ply:SetHealth(400)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(235)
		ply:SetRunSpeed(360)
		return true
	end
})

TEAM_COMBINEZOMBIE = DarkRP.createJob("Комбайн-зомби", {
	color = Color(0, 0, 0, 225),
	model = {"models/player/zombine/combine_zombie.mdl",},
	description = [[]],
	weapons = {"weapon_weapons_zombine"},
	command = "combinezombie",
	max = 100,
	salary = 0,
	admin = 0,
	type = "zombie",
	category = "Некротики",
    candemote = false,
	maxhealth = 600,
	maxarmor = 150,
	maxwalk = 70,
	maxrun = 70,
	armorJobClass = 4,
	PlayerLoadout = function(ply)
		ply:SetHealth(600)
		ply:SetArmor(150)
		ply:SetMaxArmor(150)
		ply:SetWalkSpeed(70)
		ply:SetRunSpeed(70)
		return true
	end
})



----- Animals -----

TEAM_DOG = DarkRP.createJob("Пёс", {
	color = Color(255, 255, 255, 225),
	model = {"models/falloutdog/falloutdog.mdl",},
	description = [[Лучший друг человека в это тяжелое время.]],
	specification = {
		"Возможность кусать и рычать",
		"Не может открывать двери",
		"Не может кусать всех подряд без причины",
	},
	weapons = {"re_hands", "weapon_dogswep"},
	command = "dog",
	salary = RISED.Config.Economy.TEAM_DOG.salary,
	exp_type = RISED.Config.Economy.TEAM_DOG.exp_type,
	exp_unlock_lvl = RISED.Config.Economy.TEAM_DOG.exp_unlock_lvl,
	category = "Животные",
	type = "Job_NPC_Crime",
	max = 3,
	admin = 0,
	maxhealth = 65,
	maxarmor = 0,
	maxwalk = 235,
	maxrun = 360,
	premiumjob = true,
	donatejob = false,
	exclusivejob = false,
	customCheck = function(ply) 
		if !ply:HasPurchase("status_premium") then
			DarkRP.notify(ply,5,5,"У вас не куплена Premium подписка")
		end
		return ply:HasPurchase("status_premium")
	end,
	PlayerLoadout = function(ply)
		ply:SetHealth(65)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(235)
		ply:SetRunSpeed(360)
		return true
	end
})

TEAM_PIGEON = DarkRP.createJob("Ворон", {
	color = Color(255, 255, 255, 225),
	model = {"models/crow.mdl",},
	description = [[]],
	weapons = {"weapon_animal_crow"},
	command = "pigeon",
	max = 0,
	salary = 0,
	admin = 0,
	type = "useless",
	category = "Животные",
    candemote = false,
	maxhealth = 25,
	maxarmor = 0,
	maxwalk = 235,
	maxrun = 360,
	PlayerLoadout = function(ply)
		ply:SetHealth(25)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(235)
		ply:SetRunSpeed(360)
		return true
	end
})

TEAM_RAT = DarkRP.createJob("Мышь", {
	color = Color(255, 255, 255, 225),
	model = {"models/tsbb/animals/rat.mdl",},
	description = [[]],
	weapons = {},
	command = "rat",
	max = 0,
	salary = 0,
	admin = 0,
	type = "useless",
	category = "Животные",
    candemote = false,
	maxhealth = 10,
	maxarmor = 0,
	maxwalk = 235,
	maxrun = 360,
	PlayerLoadout = function(ply)
		ply:SetHealth(10)
		ply:SetArmor(0)
		ply:SetMaxHealth(10)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(235)
		ply:SetRunSpeed(360)
		return true
	end
})



----- Special -----

TEAM_GMAN = DarkRP.createJob("G-Man", {
	color = Color(0, 0, 0, 225),
	model = {"models/player/gman_high.mdl",},
	description = [[]],
	weapons = {"re_hands", "weapon_physgun", "gmod_tool"},
	command = "gman",
	max = 1,
	salary = 0,
	admin = 0,
	type = "useless",
	category = "Секретно",
    candemote = false,
	maxhealth = 100,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	customCheck = function(ply) return ply:GetNWString("usergroup") == "hand" or ply:GetNWString("usergroup") == "retinue" or ply:GetNWString("usergroup") == "admin_II" or ply:GetNWString("usergroup") == "admin_II" or ply:GetNWString("usergroup") == "admin_I" or ply:GetNWString("usergroup") == "inf_eventer" or ply:GetNWString("usergroup") == "sup_eventer" or ply:GetNWString("usergroup") == "event_manager" or ply:GetNWString("usergroup") == "meister" or ply:IsSuperAdmin() end,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_ADMINISTRATOR = DarkRP.createJob("Administrator", {
	color = Color(255, 255, 255, 225),
	model = {"models/player/police.mdl",},
	description = [[]],
	weapons = {"re_hands", "weapon_physgun", "gmod_tool"},
	command = "administrator",
	max = 0,
	salary = 0,
	admin = 0,
	type = "useless",
	category = "Секретно",
    candemote = false,
	maxhealth = 100,
	maxarmor = 100,
	maxwalk = 120,
	maxrun = 400,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(100)
		ply:SetMaxArmor(100)
		ply:SetWalkSpeed(120)
		ply:SetRunSpeed(400)
	end
})



----- Event -----

TEAM_MURDER = DarkRP.createJob("Маньяк", {
    color = Color(45, 175, 85, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
    description = [[]],
    weapons = {"re_hands", "weapon_fists"},
    command = "murder",
    max = 0,
    salary = 0,
    admin = 0,
    type = "useless",
    category = "Гражданские",
    maxhealth = 75,
    maxarmor = 15,
    maxwalk = 100,
    maxrun = 200,
    PlayerLoadout = function(ply)
        ply:SetHealth(75)
        ply:SetMaxHealth(75)
        ply:SetArmor(0)
		ply:SetMaxArmor(0)
        ply:SetWalkSpeed(100)
        ply:SetSlowWalkSpeed(75)
        ply:SetSlowWalkSpeed(75)
        ply:SetRunSpeed(200)
    end,
    PlayerSpawn = function(ply)

        DarkRP.notifyAll(0, 4, "В городе начали пропадать люди.")

    end,
    PlayerDeath = function(ply, weapon, killer)
		ply:teamBan()
		ply:changeTeam(GAMEMODE.DefaultTeam, true)
		DarkRP.notifyAll(0, 4, "Маньяк покинул город.")
	end
})

TEAM_JEFF = DarkRP.createJob("Зараженный", {
	color = Color(0, 0, 0, 225),
	model = {"models/hlvr/zombie/blind/zombie_blind_player.mdl",},
	description = [[]],
	weapons = {"weapon_weapons_jeff"},
	command = "jeff",
	max = 1,
	salary = 0,
	admin = 0,
	type = "zombie",
	category = "Некротики",
    candemote = false,
	maxhealth = 2000,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 100,
	armorJobClass = 6,
	PlayerLoadout = function(ply)
		ply:SetHealth(2000)
		ply:SetMaxHealth(2000)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetRunSpeed(100)
		return true
	end
})

TEAM_NPC = DarkRP.createJob("Неизвестный", {
	color = Color(255, 255, 255, 225),
	model = {"models/Humans/Group02/male_02.mdl",},
	description = [[]],
	weapons = {"re_hands", "weapon_physgun", "gmod_tool"},
	command = "unknown",
	max = 0,
	salary = 0,
	admin = 0,
	type = "useless",
	category = "Гражданские",
    candemote = false,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_TESTER = DarkRP.createJob("Тестер", {
	color = Color(255, 255, 255, 225),
	model = {"models/player/bonemale/male.mdl",},
	description = [[]],
	weapons = {"re_hands", "weapon_physgun", "gmod_tool"},
	command = "tester",
	max = 0,
	salary = 0,
	admin = 0,
	type = "useless",
	category = "Гражданские",
    candemote = false,
	maxhealth = 75,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	PlayerLoadout = function(ply)
		ply:SetHealth(75)
		ply:SetMaxHealth(75)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})


--- Syndicate ---

TEAM_SYNDICATE_AGENT = DarkRP.createJob("Агент синдиката", {
	color = Color(200, 0, 0, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[]],
	weapons = {"re_hands", "weapon_fists", "itemstore_checker", "wep_jack_job_drpradio"},
	command = "syndicate_agent",
	category = "Гражданские",
	type = "useless",
	max = 20,
	salary = 0,
	admin = 0,
    candemote = false,
	maxhealth = 125,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	customCheck = function(ply) return IsOwner(ply) end,
	premiumjob = false,
	donatejob = false,
	exclusivejob = true,
	PlayerLoadout = function(ply)
		ply:SetHealth(125)
		ply:SetMaxHealth(125)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_SYNDICATE_MEMBER = DarkRP.createJob("Член синдиката", {
	color = Color(200, 0, 0, 225),
	model = {
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
	},
	description = [[]],
	weapons = {"re_hands", "weapon_fists", "itemstore_checker", "wep_jack_job_drpradio"},
	command = "syndicate_member",
	category = "Гражданские",
	type = "useless",
	max = 20,
	salary = 0,
	admin = 0,
    candemote = false,
	maxhealth = 100,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	customCheck = function(ply) return IsOwner(ply) end,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})

TEAM_SYNDICATE_LEADER = DarkRP.createJob("Лидер синдиката", {
	color = Color(200, 0, 0, 225),
	model = {
		"models/humans/mafia/male_02.mdl",
		"models/humans/mafia/male_04.mdl",
		"models/humans/mafia/male_06.mdl",
		"models/humans/mafia/male_07.mdl",
		"models/humans/mafia/male_08.mdl",
		"models/humans/mafia/male_09.mdl",
	},
	description = [[]],
	weapons = {"re_hands", "weapon_fists", "itemstore_checker", "wep_jack_job_drpradio"},
	command = "syndicate_leader",
	category = "Гражданские",
	type = "useless",
	max = 2,
	salary = 0,
	admin = 0,
    candemote = false,
	maxhealth = 100,
	maxarmor = 0,
	maxwalk = 100,
	maxrun = 200,
	premiumjob = false,
	donatejob = false,
	exclusivejob = true,
	customCheck = function(ply) return IsOwner(ply) end,
	PlayerLoadout = function(ply)
		ply:SetHealth(100)
		ply:SetMaxHealth(100)
		ply:SetArmor(0)
		ply:SetMaxArmor(0)
		ply:SetWalkSpeed(100)
		ply:SetSlowWalkSpeed(75)
		ply:SetRunSpeed(200)
	end
})


/*---------------------------------------------------------------------------
Define which team joining players spawn into and what team you change to if demoted
---------------------------------------------------------------------------*/
GAMEMODE.DefaultTeam = TEAM_CITIZENXXX


/*---------------------------------------------------------------------------
Define which teams belong to civil protection
Civil protection can set warrants, make people wanted and do some other police related things
---------------------------------------------------------------------------*/

GAMEMODE.CitizensJobs = {
	[TEAM_CONNECTOR] = true,
	[TEAM_CITIZENXXX] = true,
	[TEAM_JAILEDCITIZEN] = true,
	[TEAM_HOBOMAN] = true,
	[TEAM_REFUGEE] = true,
}

GAMEMODE.CivilJobs = {
	[TEAM_CITIZENXXX] = true,
	[TEAM_THEIF] = true,
	[TEAM_DRUGDEALER] = true,
	[TEAM_UNGUN] = true,
	[TEAM_MURDER] = true,
	[TEAM_PARTYCANDIDATE] = true,
	[TEAM_PARTYMEMBER] = true,
	[TEAM_PARTYSUPPORT] = true,
}

GAMEMODE.LoyaltyJobs = {
	[TEAM_PARTYCANDIDATE] = true,
	[TEAM_PARTYMEMBER] = true,
	[TEAM_PARTYSUPPORT] = true,
	[TEAM_PARTYSUPPORTSUPERIOR] = true,
	[TEAM_PARTYWORKSUPERVISOR] = true,
	[TEAM_PARTYSUPERIORCOUNCILMEMBER] = true,
	[TEAM_PARTYCOUNCILCHAIRMAN] = true,
	[TEAM_PARTYGENERALSECRETARY] = true,
	[TEAM_CONSUL] = true,
}

GAMEMODE.WorkersPartyJobs = {
	[TEAM_PARTYSUPPORTSUPERIOR] = true,
	[TEAM_PARTYWORKSUPERVISOR] = true,
	[TEAM_PARTYSUPERIORCOUNCILMEMBER] = true,
	[TEAM_PARTYCOUNCILCHAIRMAN] = true,
	[TEAM_PARTYGENERALSECRETARY] = true,
}

GAMEMODE.SovietJobs = {
	[TEAM_PARTYSUPERIORCOUNCILMEMBER] = true,
	[TEAM_PARTYCOUNCILCHAIRMAN] = true,
	[TEAM_PARTYGENERALSECRETARY] = true,
	[TEAM_CONSUL] = true,
}

GAMEMODE.CrimeJobs = {
	[TEAM_THEIF] = true,
	[TEAM_DRUGDEALER] = true,
	[TEAM_UNGUN] = true,
	[TEAM_MURDER] = true,
	[TEAM_SYNDICATE_AGENT] = true,
	[TEAM_SYNDICATE_MEMBER] = true,
	[TEAM_SYNDICATE_LEADER] = true,
}

GAMEMODE.Syndicate = {
	[TEAM_SYNDICATE_AGENT] = true,
	[TEAM_SYNDICATE_MEMBER] = true,
	[TEAM_SYNDICATE_LEADER] = true,
}

GAMEMODE.CivilProtection = {
	[TEAM_MPF_JURY_Conscript] = true,
	[TEAM_MPF_JURY_PVT] = true,
	[TEAM_MPF_JURY_CPL] = true,
	[TEAM_MPF_JURY_SGT] = true,
	[TEAM_MPF_JURY_LT] = true,
	[TEAM_MPF_JURY_CPT] = true,
	[TEAM_MPF_JURY_GEN] = true,
	[TEAM_MPF_ETHERNAL_SGT] = true,
	[TEAM_MPF_ETHERNAL_LT] = true,
	[TEAM_MPF_ETHERNAL_CPT] = true,
	[TEAM_MPF_PLUNGER_SGT] = true,
	[TEAM_MPF_PLUNGER_LT] = true,
	[TEAM_MPF_PLUNGER_CPT] = true,
	[TEAM_MPF_WATCHER_SGT] = true,
	[TEAM_MPF_WATCHER_LT] = true,
	[TEAM_MPF_WATCHER_CPT] = true,
	[TEAM_MPF_SPIRE_SGT] = true,
	[TEAM_MPF_SPIRE_LT] = true,
	[TEAM_MPF_SPIRE_CPT] = true,
	[TEAM_OWUDISPATCH] = true,
	[TEAM_OTA_Grunt] = true,
	[TEAM_OTA_Hammer] = true,
	[TEAM_OTA_Ordinal] = true,
	[TEAM_OTA_Suppressor] = true,
	[TEAM_OTA_Soldier] = true,
	[TEAM_OTA_Striker] = true,
	[TEAM_OTA_Razor] = true,
	[TEAM_OTA_Assassin] = true,
	[TEAM_OTA_Tech] = true,
	[TEAM_OTA_Commander] = true,
	[TEAM_OTA_Elite] = true,
	[TEAM_OTA_Crypt] = true,
	[TEAM_OTA_Broken] = true,
	[TEAM_HAZWORKER] = true,
	[TEAM_WORKER_UNIT] = true,
	[TEAM_SYNTH_CREMATOR] = true,
	[TEAM_SYNTH_GUARD] = true,
}

GAMEMODE.MetropoliceJobs = {
	[TEAM_MPF_JURY_Conscript] = true,
	[TEAM_MPF_JURY_PVT] = true,
	[TEAM_MPF_JURY_CPL] = true,
	[TEAM_MPF_JURY_SGT] = true,
	[TEAM_MPF_JURY_LT] = true,
	[TEAM_MPF_JURY_CPT] = true,
	[TEAM_MPF_JURY_GEN] = true,
	[TEAM_MPF_ETHERNAL_SGT] = true,
	[TEAM_MPF_ETHERNAL_LT] = true,
	[TEAM_MPF_ETHERNAL_CPT] = true,
	[TEAM_MPF_PLUNGER_SGT] = true,
	[TEAM_MPF_PLUNGER_LT] = true,
	[TEAM_MPF_PLUNGER_CPT] = true,
	[TEAM_MPF_WATCHER_SGT] = true,
	[TEAM_MPF_WATCHER_LT] = true,
	[TEAM_MPF_WATCHER_CPT] = true,
	[TEAM_MPF_SPIRE_SGT] = true,
	[TEAM_MPF_SPIRE_LT] = true,
	[TEAM_MPF_SPIRE_CPT] = true,
}

GAMEMODE.MetropoliceCmdJobs = {
	[TEAM_MPF_JURY_CPT] = true,
	[TEAM_MPF_ETHERNAL_CPT] = true,
	[TEAM_MPF_PLUNGER_CPT] = true,
	[TEAM_MPF_WATCHER_CPT] = true,
	[TEAM_MPF_SPIRE_CPT] = true,
	[TEAM_MPF_JURY_GEN] = true,
}

GAMEMODE.MetropoliceEthernal = {
	[TEAM_MPF_ETHERNAL_SGT] = true,
	[TEAM_MPF_ETHERNAL_LT] = true,
	[TEAM_MPF_ETHERNAL_CPT] = true,
}

GAMEMODE.MetropolicePlunger = {
	[TEAM_MPF_PLUNGER_SGT] = true,
	[TEAM_MPF_PLUNGER_LT] = true,
	[TEAM_MPF_PLUNGER_CPT] = true,
}

GAMEMODE.MetropoliceWatcher = {
	[TEAM_MPF_WATCHER_SGT] = true,
	[TEAM_MPF_WATCHER_LT] = true,
	[TEAM_MPF_WATCHER_CPT] = true,
}

GAMEMODE.CombineJobs = {
	[TEAM_OTA_Grunt] = true,
	[TEAM_OTA_Hammer] = true,
	[TEAM_OTA_Ordinal] = true,
	[TEAM_OTA_Soldier] = true,
	[TEAM_OTA_Striker] = true,
	[TEAM_OTA_Razor] = true,
	[TEAM_OTA_Suppressor] = true,
	[TEAM_OTA_Assassin] = true,
	[TEAM_OTA_Tech] = true,
	[TEAM_OTA_Commander] = true,
	[TEAM_OTA_Elite] = true,
	[TEAM_OTA_Crypt] = true,
	[TEAM_OTA_Broken] = true,
}

GAMEMODE.OTANN = {
	[TEAM_OTA_Grunt] = true,
	[TEAM_OTA_Hammer] = true,
	[TEAM_OTA_Ordinal] = true,
	[TEAM_OTA_Soldier] = true,
	[TEAM_OTA_Striker] = true,
	[TEAM_OTA_Razor] = true,
	[TEAM_OTA_Suppressor] = true,
	[TEAM_OTA_Assassin] = true,
	[TEAM_OTA_Tech] = true,
	[TEAM_OTA_Commander] = true,
	[TEAM_OTA_Elite] = true,
	[TEAM_OTA_Crypt] = true,
	[TEAM_OTA_Broken] = true,
}

GAMEMODE.SynthJobs = {
	[TEAM_SYNTH_CREMATOR] = true,
	[TEAM_SYNTH_GUARD] = true,
}

GAMEMODE.OTAREV = {
	[TEAM_OTA_Grunt] = true,
	[TEAM_OTA_Hammer] = true,
	[TEAM_OTA_Ordinal] = true,
	[TEAM_OTA_Soldier] = true,
	[TEAM_OTA_Striker] = true,
	[TEAM_OTA_Razor] = true,
	[TEAM_OTA_Suppressor] = true,
	[TEAM_OTA_Assassin] = true,
	[TEAM_OTA_Tech] = true,
	[TEAM_OTA_Commander] = true,
	[TEAM_OTA_Elite] = true,
	[TEAM_OTA_Crypt] = true,
	[TEAM_OTA_Broken] = true,
}

GAMEMODE.Rebels = {
	[TEAM_REBELNEWBIE] = true,
	[TEAM_REBELSOLDAT] = true,
	[TEAM_REBELENGINEER] = true,
	[TEAM_REBELMEDIC] = true,
	[TEAM_REBELSPY02] = true,
	[TEAM_REBEL_SPEC] = true,
	[TEAM_REBEL_VETERAN] = true,
	[TEAM_REBELSPY01] = true,
	[TEAM_REBELJUGGER] = true,
	[TEAM_REBEL_COMMANDER] = true,
	[TEAM_REBELLEADER] = true,
	[TEAM_LAMBDASOLDAT] = true,
	[TEAM_LAMBDASNIPER] = true,
	[TEAM_LAMBDACOMMANDER] = true,
}

GAMEMODE.ZombieJobs = {
	[TEAM_ZOMBIE] = true,
	[TEAM_ZOMBIECP] = true,
	[TEAM_FASTZOMBIE] = true,
	[TEAM_COMBINEZOMBIE] = true,
	[TEAM_JEFF] = true,
}

GAMEMODE.AnimalJobs = {
	[TEAM_DOG] = true,
	[TEAM_PIGEON] = true,
	[TEAM_RAT] = true,
}

GAMEMODE.InventoryBlacklistJobs = {
	[TEAM_SYNTH_CREMATOR] = true,
	[TEAM_SYNTH_GUARD] = true,
	[TEAM_OWUDISPATCH] = true,
	[TEAM_DOG] = true,
	[TEAM_PIGEON] = true,
	[TEAM_RAT] = true,
	[TEAM_ZOMBIE] = true,
	[TEAM_ZOMBIECP] = true,
	[TEAM_FASTZOMBIE] = true,
	[TEAM_COMBINEZOMBIE] = true,
	[TEAM_JEFF] = true,
}

GAMEMODE.MaleModels = {
	"models/player/hl2rp/male_01.mdl",
	"models/player/hl2rp/male_02.mdl",
	"models/player/hl2rp/male_03.mdl",
	"models/player/hl2rp/male_04.mdl",
	"models/player/hl2rp/male_05.mdl",
	"models/player/hl2rp/male_06.mdl",
	"models/player/hl2rp/male_07.mdl",
	"models/player/hl2rp/male_08.mdl",
	"models/player/hl2rp/male_09.mdl",

	"models/lenoax/cavejohnson_pm.mdl",
	"models/player/admin/male_05.mdl",
	"models/player/combine/male_01.mdl",
	"models/player/combine/male_02.mdl",
	"models/player/combine/male_03.mdl",
	"models/player/combine/male_04.mdl",
	"models/player/combine/male_05.mdl",
	"models/player/combine/male_06.mdl",
	"models/player/combine/male_07.mdl",
	"models/player/combine/male_08.mdl",
	"models/player/combine/male_09.mdl",
	"models/player/dr_schwaiger.mdl",
	"models/player/breen.mdl",
	"models/dizcordum/rebel.mdl",

	-- Бесполые --
	"models/metropolice/c08.mdl",
	"models/player/combine_soldier.mdl",
	"models/player/combine_shotgun.mdl",
	"models/player/combine_soldier_prisonguard.mdl",
	"models/player/combine_super_soldier.mdl",
	"models/player/soldier_stripped.mdl",
	"models/humans/hev_mark2.mdl",
	"models/cultist/hl_a/worker/hazmat_2/hazmat_2.mdl",
	"models/falloutdog/falloutdog.mdl",
	"models/jq/hlvr/characters/combine/suppressor/combine_suppressor_hlvr_player.mdl",
	"models/jq/hlvr/characters/combine/heavy/combine_heavy_hlvr_player.mdl",
	"models/jq/hlvr/characters/combine/combine_captain/combine_captain_hlvr_player.mdl",
            
    "models/player/male/cp.mdl",
    "models/player/female/cp.mdl",
    "models/combine_soldier_prisonguard.mdl",
    "models/cultist/hl_a/vannila_combine/npc/combine_soldier.mdl",
    "models/jq/hlvr/characters/combine/combine_captain/combine_captain_hlvr_npc.mdl",
    "models/jq/hlvr/characters/combine/heavy/combine_heavy_hlvr_npc.mdl",
    "models/jq/hlvr/characters/combine/suppressor/combine_suppressor_hlvr_npc.mdl",
	"models/jq/hlvr/characters/combine/grunt/combine_grunt_hlvr_npc.mdl",
	"models/humans/mafia/male_02.mdl",
	"models/humans/mafia/male_04.mdl",
	"models/humans/mafia/male_06.mdl",
	"models/humans/mafia/male_07.mdl",
	"models/humans/mafia/male_08.mdl",
	"models/humans/mafia/male_09.mdl",

	"models/jq/hlvr/characters/combine/grunt/combine_grunt_hlvr_npc.mdl",
	"models/plummy_sh_civ_pro/krasivii_malechik_npc_cmb.mdl",
	"models/jq/hlvr/characters/combine/heavy/combine_heavy_hlvr_npc.mdl",
	"models/jq/hlvr/characters/combine/combine_captain/combine_captain_hlvr_npc.mdl",
	"models/combine_overwatch_soldier.mdl",
	"models/combine_overwatch_soldier.mdl",
	"models/beta_combine_elite_sniper.mdl",
	"models/sirgibs/ragdolls/vance/combine_assassin_player.mdl",
	"models/wickhex/jambo/combine/2000_combine_soldier.mdl",
	"models/combine_overwatch_soldier.mdl",
	"models/hlvr/characters/worker/worker_player.mdl",
	"models/hlvr/characters/hazmat_worker/hazmat_worker_player.mdl",

	"models/rised/metropolice/cp_male_01.mdl",
	"models/rised/metropolice/cp_male_02.mdl",
	"models/rised/metropolice/cp_male_03.mdl",
	"models/rised/metropolice/cp_male_04.mdl",
	"models/rised/metropolice/cp_male_05.mdl",
	"models/rised/metropolice/cp_male_06.mdl",
	"models/rised/metropolice/cp_male_07.mdl",
	"models/rised/metropolice/cp_male_08.mdl",
	"models/rised/metropolice/cp_male_09.mdl",
	
	"models/rised_project/metropolice/rised_mpf_01.mdl",
	"models/rised_project/metropolice/rised_mpf_02.mdl",
	"models/rised_project/metropolice/rised_mpf_03.mdl",
	"models/rised_project/metropolice/rised_mpf_04.mdl",
	"models/rised_project/metropolice/rised_mpf_05.mdl",
	"models/rised_project/metropolice/rised_mpf_06.mdl",
	"models/rised_project/metropolice/rised_mpf_07.mdl",
	"models/rised_project/metropolice/rised_mpf_08.mdl",
	"models/rised_project/metropolice/rised_mpf_09.mdl",
}

GAMEMODE.FemaleModels = {
	"models/player/hl2rp/female_01.mdl",
	"models/player/hl2rp/female_02.mdl",
	"models/player/hl2rp/female_03.mdl",
	"models/player/hl2rp/female_04.mdl",
	"models/player/hl2rp/female_06.mdl",
	"models/player/hl2rp/female_07.mdl",

	"models/player/humans/suitfem/female_02.mdl",
	"models/player/bobert/aovicki.mdl",
	"models/dizcordum/female_rebel.mdl",

	-- Бесполые --
	"models/metropolice/c08.mdl",
	"models/player/combine_soldier.mdl",
	"models/player/combine_shotgun.mdl",
	"models/player/combine_soldier_prisonguard.mdl",
	"models/player/combine_super_soldier.mdl",
	"models/player/soldier_stripped.mdl",
	"models/humans/hev_mark2.mdl",
	"models/cultist/hl_a/worker/hazmat_2/hazmat_2.mdl",
	"models/falloutdog/falloutdog.mdl",
	"models/jq/hlvr/characters/combine/suppressor/combine_suppressor_hlvr_player.mdl",
	"models/jq/hlvr/characters/combine/heavy/combine_heavy_hlvr_player.mdl",
	"models/jq/hlvr/characters/combine/combine_captain/combine_captain_hlvr_player.mdl",
            
    "models/player/male/cp.mdl",
    "models/player/female/cp.mdl",
    "models/combine_soldier_prisonguard.mdl",
    "models/cultist/hl_a/vannila_combine/npc/combine_soldier.mdl",
    "models/jq/hlvr/characters/combine/combine_captain/combine_captain_hlvr_npc.mdl",
    "models/jq/hlvr/characters/combine/heavy/combine_heavy_hlvr_npc.mdl",
    "models/jq/hlvr/characters/combine/suppressor/combine_suppressor_hlvr_npc.mdl",
	"models/jq/hlvr/characters/combine/grunt/combine_grunt_hlvr_npc.mdl",
	"models/hlvr/characters/worker/worker_player.mdl",
	"models/hlvr/characters/hazmat_worker/hazmat_worker_player.mdl",

	"models/jq/hlvr/characters/combine/grunt/combine_grunt_hlvr_npc.mdl",
	"models/plummy_sh_civ_pro/krasivii_malechik_npc_cmb.mdl",
	"models/jq/hlvr/characters/combine/heavy/combine_heavy_hlvr_npc.mdl",
	"models/jq/hlvr/characters/combine/combine_captain/combine_captain_hlvr_npc.mdl",
	"models/combine_overwatch_soldier.mdl",
	"models/combine_overwatch_soldier.mdl",
	"models/beta_combine_elite_sniper.mdl",
	"models/sirgibs/ragdolls/vance/combine_assassin_player.mdl",
	"models/wickhex/jambo/combine/2000_combine_soldier.mdl",
	"models/combine_overwatch_soldier.mdl",
}

GAMEMODE.Rised_Clothes_Jobs = {
	[TEAM_CONNECTOR] = true,
	[TEAM_CITIZENXXX] = true,
	[TEAM_JAILEDCITIZEN] = true,
	[TEAM_PARTYCANDIDATE] = true,
	[TEAM_PARTYMEMBER] = true,
	[TEAM_PARTYSUPPORT] = true,
	[TEAM_PARTYSUPPORTSUPERIOR] = true,
	[TEAM_REBELNEWBIE] = true,
	[TEAM_REBELSOLDAT] = true,
	[TEAM_REBELENGINEER] = true,
	[TEAM_REBELMEDIC] = true,
	[TEAM_REBELSPY02] = true,
	[TEAM_REBEL_VETERAN] = true,
	[TEAM_REBELLEADER] = true,
	[TEAM_LAMBDASOLDAT] = true,
	[TEAM_LAMBDACOMMANDER] = true,
	[TEAM_THEIF] = true,
	[TEAM_DRUGDEALER] = true,
	[TEAM_UNGUN] = true,
	[TEAM_MURDER] = true,
	[TEAM_REFUGEE] = true,
}

GAMEMODE.OL_Cooldowns = {
	[TEAM_MPF_JURY_Conscript] = 1800,
	[TEAM_MPF_JURY_PVT] = 1800,
	[TEAM_MPF_JURY_CPL] = 1200,
	[TEAM_MPF_JURY_SGT] = 1200,
	[TEAM_MPF_JURY_LT] = 800,
	[TEAM_MPF_JURY_CPT] = 600,
	[TEAM_MPF_JURY_GEN] = 300,
	[TEAM_MPF_ETHERNAL_SGT] = 1200,
	[TEAM_MPF_ETHERNAL_LT] = 800,
	[TEAM_MPF_ETHERNAL_CPT] = 800,
	[TEAM_MPF_PLUNGER_SGT] = 1200,
	[TEAM_MPF_PLUNGER_LT] = 800,
	[TEAM_MPF_PLUNGER_CPT] = 800,
	[TEAM_MPF_WATCHER_SGT] = 1200,
	[TEAM_MPF_WATCHER_LT] = 800,
	[TEAM_MPF_WATCHER_CPT] = 800,
	[TEAM_MPF_SPIRE_SGT] = 1200,
	[TEAM_MPF_SPIRE_LT] = 800,
	[TEAM_MPF_SPIRE_CPT] = 800,
}

GAMEMODE.CanChangeMetropoliceJobs = {
	[TEAM_MPF_JURY_Conscript] = true,
	[TEAM_MPF_JURY_PVT] = true,
	[TEAM_MPF_JURY_CPL] = true,
	[TEAM_MPF_JURY_SGT] = true,
	[TEAM_MPF_JURY_LT] = true,
	[TEAM_MPF_JURY_CPT] = true,
	[TEAM_MPF_JURY_GEN] = false,
	[TEAM_MPF_ETHERNAL_SGT] = true,
	[TEAM_MPF_ETHERNAL_LT] = true,
	[TEAM_MPF_ETHERNAL_CPT] = true,
	[TEAM_MPF_PLUNGER_SGT] = true,
	[TEAM_MPF_PLUNGER_LT] = true,
	[TEAM_MPF_PLUNGER_CPT] = true,
	[TEAM_MPF_WATCHER_SGT] = true,
	[TEAM_MPF_WATCHER_LT] = true,
	[TEAM_MPF_WATCHER_CPT] = true,
	[TEAM_MPF_SPIRE_SGT] = true,
	[TEAM_MPF_SPIRE_LT] = true,
	[TEAM_MPF_SPIRE_CPT] = true,
	[TEAM_CITIZENXXX] = true,
}


/*---------------------------------------------------------------------------
Jobs that are hitmen (enables the hitman menu)
---------------------------------------------------------------------------*/
DarkRP.addHitmanTeam(TEAM_MOB)

RISED.IsLoaded = true

if SERVER then
	ExperienceInit()
	SetJobPermissions()
end