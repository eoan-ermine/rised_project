-- "addons\\darkrpmodification\\lua\\darkrp_customthings\\entities.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- Альянс --
DarkRP.createEntity("Турель", {
	ent = "turret_box_combine",
	model = "models/combine_turrets/floor_turret.mdl",
	price = 5,
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buyturretcombine",
	allowed = {TEAM_WORKER_UNIT, TEAM_MPF_PLUNGER_SGT, TEAM_MPF_PLUNGER_LT, TEAM_MPF_PLUNGER_CPT, TEAM_OTA_Tech}
})
DarkRP.createEntity("Combine Lock", {
	ent = "combine_doorlock",
	model = "models/props_combine/combine_lock01.mdl",
	price = 5,
	max = 10,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buylock",
	allowed = {TEAM_WORKER_UNIT, TEAM_MPF_PLUNGER_SGT, TEAM_MPF_PLUNGER_LT, TEAM_MPF_PLUNGER_CPT, TEAM_OTA_Tech}
})

-- Повстанцы --
-- DarkRP.createEntity("Турель повстанцев", {
	-- ent = "turret_box_rebel",
	-- model = "models/combine_turrets/floor_turret.mdl",
	-- price = 450,
	-- max = 3,
    -- getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	-- cmd = "buyturretrebel",
	-- allowed = TEAM_REBELENGINEER
-- })

-- DarkRP.createEntity("Мешок с землей", {
-- 	ent = "fm_plant2",
-- 	model = "models/custom_models/sterling/ahshop_plant_sack.mdl",
-- 	price = 10,
-- 	max = 3,
--     getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
-- 	cmd = "buyplant2",
-- 	allowed = {TEAM_REBELNEWBIE, TEAM_REBELSOLDAT, TEAM_REBELENGINEER, TEAM_REBELMEDIC, TEAM_REBEL_VETERAN}
-- })

-- DarkRP.createEntity("Семена кукурузы", {
-- 	ent = "fm_seed1",
-- 	model = "models/custom_models/sterling/ahshop_package_seeds_01.mdl",
-- 	price = 15,
-- 	max = 1,
--     getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
-- 	cmd = "buyseed1",
-- 	allowed = {TEAM_REBELNEWBIE, TEAM_REBELSOLDAT, TEAM_REBELENGINEER, TEAM_REBELMEDIC, TEAM_REBEL_VETERAN}
-- })

-- DarkRP.createEntity("Семена томатов", {
-- 	ent = "fm_seed2",
-- 	model = "models/custom_models/sterling/ahshop_package_seeds_02.mdl",
-- 	price = 20,
-- 	max = 1,
--     getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
-- 	cmd = "buyseed2",
-- 	allowed = {TEAM_REBELNEWBIE, TEAM_REBELSOLDAT, TEAM_REBELENGINEER, TEAM_REBELMEDIC, TEAM_REBEL_VETERAN}
-- })

-- DarkRP.createEntity("Семена капусты", {
-- 	ent = "fm_seed3",
-- 	model = "models/custom_models/sterling/ahshop_package_seeds_03.mdl",
-- 	price = 25,
-- 	max = 1,
--     getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
-- 	cmd = "buyseed3",
-- 	allowed = {TEAM_REBELNEWBIE, TEAM_REBELSOLDAT, TEAM_REBELENGINEER, TEAM_REBELMEDIC, TEAM_REBEL_VETERAN}
-- })

-- DarkRP.createEntity("Семена моркови", {
-- 	ent = "fm_seed4",
-- 	model = "models/custom_models/sterling/ahshop_package_seeds_04.mdl",
-- 	price = 15,
-- 	max = 1,
--     getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
-- 	cmd = "buyseed4",
-- 	allowed = {TEAM_REBELNEWBIE, TEAM_REBELSOLDAT, TEAM_REBELENGINEER, TEAM_REBELMEDIC, TEAM_REBEL_VETERAN}
-- })

-- Патроны --


-- Врач / HELIX / Медик --
DarkRP.createEntity("Cadrionix Z-2", {
	ent = "med_drug_cardionix_z2",
	model = "models/props_lab/jar01b.mdl",
	price = 300,
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buycadrionixz2",
	allowed = {TEAM_MPF_ETHERNAL_SGT, TEAM_MPF_ETHERNAL_LT, TEAM_MPF_ETHERNAL_CPT, TEAM_REBELMEDIC}
})

DarkRP.createEntity("Combicillin", {
	ent = "med_drug_combicillin",
	model = "models/props_lab/jar01b.mdl",
	price = 250,
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buycombicillin",
	allowed = {TEAM_MPF_ETHERNAL_SGT, TEAM_MPF_ETHERNAL_LT, TEAM_MPF_ETHERNAL_CPT, TEAM_REBELMEDIC}
})

DarkRP.createEntity("Heptender", {
	ent = "med_drug_heptender",
	model = "models/props_lab/jar01b.mdl",
	price = 250,
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buyheptender",
	allowed = {TEAM_MPF_ETHERNAL_SGT, TEAM_MPF_ETHERNAL_LT, TEAM_MPF_ETHERNAL_CPT, TEAM_REBELMEDIC}
})

DarkRP.createEntity("Схема H+R+Z+S", {
	ent = "med_drug_hrzs",
	model = "models/props_lab/jar01b.mdl",
	price = 350,
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buyhrzs",
	allowed = {TEAM_MPF_ETHERNAL_SGT, TEAM_MPF_ETHERNAL_LT, TEAM_MPF_ETHERNAL_CPT, TEAM_REBELMEDIC}
})

DarkRP.createEntity("I306N", {
	ent = "med_drug_i306n",
	model = "models/props_lab/jar01b.mdl",
	price = 700,
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buyi306n",
	allowed = {TEAM_MPF_ETHERNAL_SGT, TEAM_MPF_ETHERNAL_LT, TEAM_MPF_ETHERNAL_CPT, TEAM_REBELMEDIC}
})

DarkRP.createEntity("Pulmonifer", {
	ent = "med_drug_pulmonifer",
	model = "models/props_lab/jar01b.mdl",
	price = 300,
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buypulmonifer",
	allowed = {TEAM_MPF_ETHERNAL_SGT, TEAM_MPF_ETHERNAL_LT, TEAM_MPF_ETHERNAL_CPT, TEAM_REBELMEDIC}
})

DarkRP.createEntity("Qurantimycin", {
	ent = "med_drug_qurantimycin",
	model = "models/props_lab/jar01b.mdl",
	price = 400,
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buyqurantimycin",
	allowed = {TEAM_MPF_ETHERNAL_SGT, TEAM_MPF_ETHERNAL_LT, TEAM_MPF_ETHERNAL_CPT, TEAM_REBELMEDIC}
})

DarkRP.createEntity("Zenocillin", {
	ent = "med_drug_zenocillin",
	model = "models/props_lab/jar01b.mdl",
	price = 500,
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buyzenocillin",
	allowed = {TEAM_MPF_ETHERNAL_SGT, TEAM_MPF_ETHERNAL_LT, TEAM_MPF_ETHERNAL_CPT, TEAM_REBELMEDIC}
})

DarkRP.createEntity("Amitriptyline", {
	ent = "med_drug_amitriptyline",
	model = "models/props_lab/jar01b.mdl",
	price = 200,
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buyamitriptyline",
	allowed = {TEAM_MPF_ETHERNAL_SGT, TEAM_MPF_ETHERNAL_LT, TEAM_MPF_ETHERNAL_CPT, TEAM_REBELMEDIC}
})

DarkRP.createEntity("Шина", {
	ent = "med_drug_tire",
	model = "models/gibs/metal_gib2.mdl",
	price = 200,
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buytire",
	allowed = {TEAM_MPF_ETHERNAL_SGT, TEAM_MPF_ETHERNAL_LT, TEAM_MPF_ETHERNAL_CPT, TEAM_REBELMEDIC}
})

--- Bartender ---
DarkRP.createEntity("Убежище", {
	ent = "asylum",
	model = "models/asylum/asylum.mdl",
	price = RISED.Config.Economy.Cocktails["asylum"],
	workstatus = "Бармен",
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buycocktail1",
	allowed = TEAM_GMAN
})
DarkRP.createEntity("Барботаж", {
	ent = "barbotage",
	model = "models/barbotage/barbotage.mdl",
	price = RISED.Config.Economy.Cocktails["barbotage"],
	workstatus = "Бармен",
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buycocktail2",
	allowed = TEAM_GMAN
})
DarkRP.createEntity("Чернвый бархат", {
	ent = "blackvelvet",
	model = "models/black velvet/black velvet.mdl",
	price = RISED.Config.Economy.Cocktails["blackvelvet"],
	workstatus = "Бармен",
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buycocktail3",
	allowed = TEAM_GMAN
})
DarkRP.createEntity("Кровавая Мэри", {
	ent = "bloodymary",
	model = "models/bloody mary/bloody mary.mdl",
	price = RISED.Config.Economy.Cocktails["bloodymary"],
	workstatus = "Бармен",
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buycocktail4",
	allowed = TEAM_GMAN
})
DarkRP.createEntity("Бренди", {
	ent = "brandy",
	model = "models/brandy/brandy.mdl",
	price = RISED.Config.Economy.Cocktails["brandy"],
	workstatus = "Бармен",
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buycocktail5",
	allowed = TEAM_GMAN
})
DarkRP.createEntity("Бренди физ", {
	ent = "brandyfizz",
	model = "models/brandy fizz/brandy fizz.mdl",
	price = RISED.Config.Economy.Cocktails["brandyfizz"],
	workstatus = "Бармен",
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buycocktail6",
	allowed = TEAM_GMAN
})
DarkRP.createEntity("Кайпиринья", {
	ent = "caipirinha",
	model = "models/caipirinha/caipirinha.mdl",
	price = RISED.Config.Economy.Cocktails["caipirinha"],
	workstatus = "Бармен",
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buycocktail7",
	allowed = TEAM_GMAN
})
DarkRP.createEntity("Кейп-кодер", {
	ent = "capecodder",
	model = "models/cape codder/cape codder.mdl",
	price = RISED.Config.Economy.Cocktails["capecodder"],
	workstatus = "Бармен",
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buycocktail8",
	allowed = TEAM_GMAN
})
DarkRP.createEntity("Чикаго физ", {
	ent = "chicagofizz",
	model = "models/chicago fizz/chicago fizz.mdl",
	price = RISED.Config.Economy.Cocktails["chicagofizz"],
	workstatus = "Бармен",
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buycocktail9",
	allowed = TEAM_GMAN
})
DarkRP.createEntity("Кликет", {
	ent = "cliquet",
	model = "models/cliquet/cliquet.mdl",
	price = RISED.Config.Economy.Cocktails["cliquet"],
	workstatus = "Бармен",
	max = 3,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buycocktail10",
	allowed = TEAM_GMAN
})

-- Наркотики -- 
DarkRP.createEntity("Горшок", {
	ent = "uweed_plant",
	model = "models/base/weedplant.mdl",
	price = 15,
	max = 2,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buydrug01",
	allowed = TEAM_DRUGDEALER
})
DarkRP.createEntity("Коробка семян", {
	ent = "uweed_seed_box",
	model = "models/base/weedbox.mdl",
	price = 40,
	max = 1,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buydrug02",
	allowed = TEAM_DRUGDEALER
})
DarkRP.createEntity("Лампа", {
	ent = "uweed_light",
	model = "models/base/lamp1.mdl",
	price = 30,
	max = 2,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buydrug03",
	allowed = TEAM_DRUGDEALER
})
DarkRP.createEntity("Батарейка для лампы", {
	ent = "uweed_battery",
	model = "models/base/battery.mdl",
	price = 5,
	max = 2,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buydrug04",
	allowed = TEAM_DRUGDEALER
})
DarkRP.createEntity("Весы", {
	ent = "uweed_scale",
	model = "models/base/scale.mdl",
	price = 25,
	max = 1,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buydrug05",
	allowed = TEAM_DRUGDEALER
})
DarkRP.createEntity("Пакет", {
	ent = "uweed_bag",
	model = "models/base/weedbag.mdl",
	price = 10,
	max = 4,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buydrug06",
	allowed = TEAM_DRUGDEALER
})
DarkRP.createEntity("Пачка листов", {
	ent = "uweed_frontwoods",
	model = "models/base/frontwoods.mdl",
	price = 10,
	max = 1,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buydrug07",
	allowed = TEAM_DRUGDEALER
})

-- ГСР --
DarkRP.createEntity("Канистра с бензином", {
	ent = "gas_canister",
	model = "models/props_junk/gascan001a.mdl",
	price = 100,
	workstatus = "Уборщик",
	max = 1,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buygascan",
	allowed = {TEAM_CUWRUBBISH}
})

DarkRP.createEntity("Наушники", {
	ent = "mediaplayer_headphones",
	model = "models/props/cs_office/phone_p2.mdl",
	price = 100,
	workstatus = "Киномеханик",
	max = 10,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buyheadphones",
	allowed = {TEAM_FILMMAKER}
})

-- Кантробанда --

DarkRP.createEntity("Яд", {
	ent = "cuw_rationpoison",
	model = "models/props_junk/glassjug01.mdl",
	price = 300,
	max = 1,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
	cmd = "buyrationpoison",
	allowed = TEAM_REBELSPY02
})
