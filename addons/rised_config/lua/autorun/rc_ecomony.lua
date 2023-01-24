-- "addons\\rised_config\\lua\\autorun\\rc_ecomony.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if RISED == null then
	RISED = {}
	if RISED.Config == null then
		RISED.Config = {}
	end
end

----------========== Экономика ==========----------
RISED.Config.Economy = {}

-----===== ГСР =====-----
-- Уборка мусора
RISED.Config.Economy.RubbishCleanTime = 15
RISED.Config.Economy.RubbishRefreshTime = 150
RISED.Config.Economy.RubbishTokens = 10
RISED.Config.Economy.RubbishSodaTokens = 2
RISED.Config.Economy.RubbishFoodTokens = 5
RISED.Config.Economy.RubbishLP = 0.05

-- Доставка коробок с мясом
RISED.Config.Economy.DeliveryMeatTokens = 30
RISED.Config.Economy.DeliveryMeatBonusStep = 10
RISED.Config.Economy.DeliveryMeatBonusMax = 20
RISED.Config.Economy.DeliveryMeatLP = 0.08

-- Обработка мяса
RISED.Config.Economy.CookMeatTokens = 100
RISED.Config.Economy.CookMeatLP = 0.10

-- Доставка коробок с энзимами
RISED.Config.Economy.DeliveryEnzymesTokens = 38
RISED.Config.Economy.DeliveryEnzymesBonusStep = 10
RISED.Config.Economy.DeliveryEnzymesBonusMax = 20
RISED.Config.Economy.DeliveryEnzymesLP = 0.12

-- Сборка и доставка коробки с готовыми рационами
RISED.Config.Economy.CompileRationsNormalTokens = 125
RISED.Config.Economy.CompileRationsGoodTokens = 140
RISED.Config.Economy.CompileRationsPerfectTokens = 150
RISED.Config.Economy.CompileRationsLP_Good = 0.15
RISED.Config.Economy.CompileRationsLP_Perfect = 0.15

-- Доставщик металла
RISED.Config.Economy.DeliveryMetalBox 			= 52
RISED.Config.Economy.DeliveryMetalLP = 0.2

-- Прессовщик
RISED.Config.Economy.MetalPressor 			= 98
RISED.Config.Economy.PressorLP = 0.22
-- Сварщик
RISED.Config.Economy.MetalWelder 			= 148
RISED.Config.Economy.WelderLP = 0.24
-- Ионизатор
RISED.Config.Economy.MetalIonizator 			= 194
RISED.Config.Economy.IonizatorLP = 0.26

-- Врач
RISED.Config.Economy.MedCardCost 				= 150
RISED.Config.Economy.MedPatientDiseaseTimer 	= 480
RISED.Config.Economy.MedPatientDiseaseTokens 	= 150
RISED.Config.Economy.DoctorLP = 0.05

-- Бармен
RISED.Config.Economy.DrunkerTokens 				= 100
RISED.Config.Economy.DrunkerTimer 				= 300
RISED.Config.Economy.Cocktails = {
	["asylum"] = 125,
	["barbotage"] = 72,
	["blackvelvet"] = 112,
	["bloodymary"] = 129,
	["brandy"] = 130,
	["brandyfizz"] = 117,
	["caipirinha"] = 224,
	["capecodder"] = 192,
	["chicagofizz"] = 350,
	["cliquet"] = 370,
}

-----===== Утилизатор зена =====-----
RISED.Config.Economy.InfestationControl = 150
RISED.Config.Economy.InfestationLP = 0.5

-- Баланс травы
RISED.Config.Economy.WeedMinCost = 50
RISED.Config.Economy.WeedMaxCost = 500
RISED.Config.Economy.WeedGrowStageTime = 300

-- Плакаты повстанцы
RISED.Config.Economy.PosterChange = 10

-- Манипринтеры
RISED.Config.Economy.MoneyPrinterPrintOne = 50
RISED.Config.Economy.MoneyPrinterPrintTwo = 100
RISED.Config.Economy.MoneyPrinterPrintOne_Overclock = 250
RISED.Config.Economy.MoneyPrinterPrintTwo_Overclock = 500

-- Секторы
RISED.Config.Economy.SectorTokensCombine07 = 350
RISED.Config.Economy.SectorTokensCombine06 = 180
RISED.Config.Economy.SectorTokensCombine05 = 100
RISED.Config.Economy.SectorTokensCombine04 = 90
RISED.Config.Economy.SectorTokensCombine03 = 80
RISED.Config.Economy.SectorTokensCombine02 = 75
RISED.Config.Economy.SectorTokensCombine01 = 50

RISED.Config.Economy.SectorTokensRebel07 = 150
RISED.Config.Economy.SectorTokensRebel06 = 350
RISED.Config.Economy.SectorTokensRebel05 = 800
RISED.Config.Economy.SectorTokensRebel04 = 1050
RISED.Config.Economy.SectorTokensRebel03 = 1300
RISED.Config.Economy.SectorTokensRebel02 = 1550
RISED.Config.Economy.SectorTokensRebel01 = 1800


-----===== Сдача контрабанды =====-----
RISED.Config.Economy.Post_Tier1 = 15
RISED.Config.Economy.Post_Tier2 = 50

-----===== Сдача контрабанды =====-----
RISED.Config.Economy.Contraband_Tier1 = 50
RISED.Config.Economy.Contraband_Tier2 = 80
RISED.Config.Economy.Contraband_Tier3 = 99
RISED.Config.Economy.Contraband_Tier4 = 125


RISED.Config.Economy.TheifQuestReward1 = 150
RISED.Config.Economy.TheifQuestReward2 = 500


-----===== Профессии: цены и зарплаты =====-----

-- Цены на сертификаты
RISED.Config.Economy.SertificateCost_Trashman = 0
RISED.Config.Economy.SertificateCost_CourierMeat = 80
RISED.Config.Economy.SertificateCost_MeatCooker = 150
RISED.Config.Economy.SertificateCost_CourierEnzymes = 200
RISED.Config.Economy.SertificateCost_Compiler = 250
RISED.Config.Economy.SertificateCost_CourierMetal = 300
RISED.Config.Economy.SertificateCost_MetalPressor = 350
RISED.Config.Economy.SertificateCost_MetalWelder = 400
RISED.Config.Economy.SertificateCost_MetalIonizer = 450
RISED.Config.Economy.SertificateCost_Provisor = 550
RISED.Config.Economy.SertificateCost_Bartender = 600
RISED.Config.Economy.SertificateCost_Doctor = 900


---=== Гражданские ===---
-- RISED.Config.Economy.Trashman_exp_unlock_lvl = 0
-- RISED.Config.Economy.CourierMeat_exp_unlock_lvl = 1
-- RISED.Config.Economy.MeatCooker_exp_unlock_lvl = 3
-- RISED.Config.Economy.CourierEnzymes_exp_unlock_lvl = 7
-- RISED.Config.Economy.Compiler_exp_unlock_lvl = 11
-- RISED.Config.Economy.CourierMetal_exp_unlock_lvl = 16
-- RISED.Config.Economy.MetalPressor_exp_unlock_lvl = 21
-- RISED.Config.Economy.MetalWelder_exp_unlock_lvl = 26
-- RISED.Config.Economy.MetalIonizer_exp_unlock_lvl = 32
-- RISED.Config.Economy.Provisor_exp_unlock_lvl = 38
-- RISED.Config.Economy.Bartender_exp_unlock_lvl = 44
-- RISED.Config.Economy.Doctor_exp_unlock_lvl = 50
RISED.Config.Economy.Trashman_exp_unlock_lvl = 0

RISED.Config.Economy.CourierMeat_exp_unlock_lvl = 1
RISED.Config.Economy.MeatCooker_exp_unlock_lvl = 2
RISED.Config.Economy.CourierEnzymes_exp_unlock_lvl = 3
RISED.Config.Economy.Compiler_exp_unlock_lvl = 4
RISED.Config.Economy.CourierMetal_exp_unlock_lvl = 5
RISED.Config.Economy.MetalPressor_exp_unlock_lvl = 7
RISED.Config.Economy.MetalWelder_exp_unlock_lvl = 9
RISED.Config.Economy.MetalIonizer_exp_unlock_lvl = 10

RISED.Config.Economy.Provisor_exp_unlock_lvl = 11
RISED.Config.Economy.Bartender_exp_unlock_lvl = 13
RISED.Config.Economy.Doctor_exp_unlock_lvl = 15

-- RISED.Config.Economy.Courier_exp_unlock_lvl = 1
-- RISED.Config.Economy.FactoryWorker_exp_unlock_lvl = 3

RISED.Config.Economy.TEAM_THEIF = {}
RISED.Config.Economy.TEAM_THEIF.salary = 15
RISED.Config.Economy.TEAM_THEIF.exp_type = "Common"
RISED.Config.Economy.TEAM_THEIF.exp_unlock_lvl = 5

RISED.Config.Economy.TEAM_DRUGDEALER = {}
RISED.Config.Economy.TEAM_DRUGDEALER.salary = 25
RISED.Config.Economy.TEAM_DRUGDEALER.exp_type = "Common"
RISED.Config.Economy.TEAM_DRUGDEALER.exp_unlock_lvl = 7

RISED.Config.Economy.TEAM_UNGUN = {}
RISED.Config.Economy.TEAM_UNGUN.salary = 35
RISED.Config.Economy.TEAM_UNGUN.exp_type = "Common"
RISED.Config.Economy.TEAM_UNGUN.exp_unlock_lvl = 8

RISED.Config.Economy.TEAM_DOG = {}
RISED.Config.Economy.TEAM_DOG.salary = 5
RISED.Config.Economy.TEAM_DOG.exp_type = "Common"
RISED.Config.Economy.TEAM_DOG.exp_unlock_lvl = 0



---=== Партия ===---

RISED.Config.Economy.TEAM_PARTYCANDIDATE = {}
RISED.Config.Economy.TEAM_PARTYCANDIDATE.salary = 100
RISED.Config.Economy.TEAM_PARTYCANDIDATE.exp_type = "Common"
RISED.Config.Economy.TEAM_PARTYCANDIDATE.exp_unlock_lvl = 15

RISED.Config.Economy.TEAM_PARTYMEMBER = {}
RISED.Config.Economy.TEAM_PARTYMEMBER.salary = 200
RISED.Config.Economy.TEAM_PARTYMEMBER.exp_type = "Party"
RISED.Config.Economy.TEAM_PARTYMEMBER.exp_unlock_lvl = 20

RISED.Config.Economy.TEAM_PARTYSUPPORT = {}
RISED.Config.Economy.TEAM_PARTYSUPPORT.salary = 300
RISED.Config.Economy.TEAM_PARTYSUPPORT.exp_type = "Party"
RISED.Config.Economy.TEAM_PARTYSUPPORT.exp_unlock_lvl = 25

RISED.Config.Economy.TEAM_PARTYSUPPORTSUPERIOR = {}
RISED.Config.Economy.TEAM_PARTYSUPPORTSUPERIOR.salary = 400
RISED.Config.Economy.TEAM_PARTYSUPPORTSUPERIOR.exp_type = "Party"
RISED.Config.Economy.TEAM_PARTYSUPPORTSUPERIOR.exp_unlock_lvl = 35

RISED.Config.Economy.TEAM_PARTYWORKSUPERVISOR = {}
RISED.Config.Economy.TEAM_PARTYWORKSUPERVISOR.salary = 450
RISED.Config.Economy.TEAM_PARTYWORKSUPERVISOR.exp_type = "Party"
RISED.Config.Economy.TEAM_PARTYWORKSUPERVISOR.exp_unlock_lvl = 50

RISED.Config.Economy.TEAM_PARTYSUPERIORCOUNCILMEMBER = {}
RISED.Config.Economy.TEAM_PARTYSUPERIORCOUNCILMEMBER.salary = 500
RISED.Config.Economy.TEAM_PARTYSUPERIORCOUNCILMEMBER.exp_type = "Party"
RISED.Config.Economy.TEAM_PARTYSUPERIORCOUNCILMEMBER.exp_unlock_lvl = 75

RISED.Config.Economy.TEAM_PARTYCOUNCILCHAIRMAN = {}
RISED.Config.Economy.TEAM_PARTYCOUNCILCHAIRMAN.salary = 550
RISED.Config.Economy.TEAM_PARTYCOUNCILCHAIRMAN.exp_type = "Party"
RISED.Config.Economy.TEAM_PARTYCOUNCILCHAIRMAN.exp_unlock_lvl = 100

RISED.Config.Economy.TEAM_PARTYGENERALSECRETARY = {}
RISED.Config.Economy.TEAM_PARTYGENERALSECRETARY.salary = 600
RISED.Config.Economy.TEAM_PARTYGENERALSECRETARY.exp_type = "Party"
RISED.Config.Economy.TEAM_PARTYGENERALSECRETARY.exp_unlock_lvl = 175

RISED.Config.Economy.TEAM_CONSUL = {}
RISED.Config.Economy.TEAM_CONSUL.salary = 700
RISED.Config.Economy.TEAM_CONSUL.exp_type = "Party"
RISED.Config.Economy.TEAM_CONSUL.exp_unlock_lvl = 250



---=== Альянс ===---

RISED.Config.Economy.TEAM_HAZWORKER = {}
RISED.Config.Economy.TEAM_HAZWORKER.salary = 0
RISED.Config.Economy.TEAM_HAZWORKER.exp_type = "Common"
RISED.Config.Economy.TEAM_HAZWORKER.exp_unlock_lvl = 15

RISED.Config.Economy.TEAM_WORKER_UNIT = {}
RISED.Config.Economy.TEAM_WORKER_UNIT.salary = 0
RISED.Config.Economy.TEAM_WORKER_UNIT.exp_type = "Combine"
RISED.Config.Economy.TEAM_WORKER_UNIT.exp_unlock_lvl = 17

RISED.Config.Economy.TEAM_MPF_JURY_Conscript = {}
RISED.Config.Economy.TEAM_MPF_JURY_Conscript.salary = 0
RISED.Config.Economy.TEAM_MPF_JURY_Conscript.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_JURY_Conscript.exp_unlock_lvl = 20

RISED.Config.Economy.TEAM_MPF_JURY_PVT = {}
RISED.Config.Economy.TEAM_MPF_JURY_PVT.salary = 0
RISED.Config.Economy.TEAM_MPF_JURY_PVT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_JURY_PVT.exp_unlock_lvl = 22

RISED.Config.Economy.TEAM_MPF_JURY_CPL = {}
RISED.Config.Economy.TEAM_MPF_JURY_CPL.salary = 0
RISED.Config.Economy.TEAM_MPF_JURY_CPL.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_JURY_CPL.exp_unlock_lvl = 26

RISED.Config.Economy.TEAM_MPF_JURY_SGT = {}
RISED.Config.Economy.TEAM_MPF_JURY_SGT.salary = 0
RISED.Config.Economy.TEAM_MPF_JURY_SGT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_JURY_SGT.exp_unlock_lvl = 30

RISED.Config.Economy.TEAM_MPF_JURY_LT = {}
RISED.Config.Economy.TEAM_MPF_JURY_LT.salary = 0
RISED.Config.Economy.TEAM_MPF_JURY_LT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_JURY_LT.exp_unlock_lvl = 42

RISED.Config.Economy.TEAM_MPF_JURY_CPT = {}
RISED.Config.Economy.TEAM_MPF_JURY_CPT.salary = 0
RISED.Config.Economy.TEAM_MPF_JURY_CPT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_JURY_CPT.exp_unlock_lvl = 150

RISED.Config.Economy.TEAM_MPF_JURY_GEN = {}
RISED.Config.Economy.TEAM_MPF_JURY_GEN.salary = 0
RISED.Config.Economy.TEAM_MPF_JURY_GEN.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_JURY_GEN.exp_unlock_lvl = 250

RISED.Config.Economy.TEAM_MPF_ETHERNAL_SGT = {}
RISED.Config.Economy.TEAM_MPF_ETHERNAL_SGT.salary = 0
RISED.Config.Economy.TEAM_MPF_ETHERNAL_SGT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_ETHERNAL_SGT.exp_unlock_lvl = 45

RISED.Config.Economy.TEAM_MPF_ETHERNAL_LT = {}
RISED.Config.Economy.TEAM_MPF_ETHERNAL_LT.salary = 0
RISED.Config.Economy.TEAM_MPF_ETHERNAL_LT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_ETHERNAL_LT.exp_unlock_lvl = 65

RISED.Config.Economy.TEAM_MPF_ETHERNAL_CPT = {}
RISED.Config.Economy.TEAM_MPF_ETHERNAL_CPT.salary = 0
RISED.Config.Economy.TEAM_MPF_ETHERNAL_CPT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_ETHERNAL_CPT.exp_unlock_lvl = 165

RISED.Config.Economy.TEAM_MPF_PLUNGER_SGT = {}
RISED.Config.Economy.TEAM_MPF_PLUNGER_SGT.salary = 0
RISED.Config.Economy.TEAM_MPF_PLUNGER_SGT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_PLUNGER_SGT.exp_unlock_lvl = 54

RISED.Config.Economy.TEAM_MPF_PLUNGER_LT = {}
RISED.Config.Economy.TEAM_MPF_PLUNGER_LT.salary = 0
RISED.Config.Economy.TEAM_MPF_PLUNGER_LT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_PLUNGER_LT.exp_unlock_lvl = 67

RISED.Config.Economy.TEAM_MPF_PLUNGER_CPT = {}
RISED.Config.Economy.TEAM_MPF_PLUNGER_CPT.salary = 0
RISED.Config.Economy.TEAM_MPF_PLUNGER_CPT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_PLUNGER_CPT.exp_unlock_lvl = 132

RISED.Config.Economy.TEAM_MPF_WATCHER_SGT = {}
RISED.Config.Economy.TEAM_MPF_WATCHER_SGT.salary = 0
RISED.Config.Economy.TEAM_MPF_WATCHER_SGT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_WATCHER_SGT.exp_unlock_lvl = 45

RISED.Config.Economy.TEAM_MPF_WATCHER_LT = {}
RISED.Config.Economy.TEAM_MPF_WATCHER_LT.salary = 0
RISED.Config.Economy.TEAM_MPF_WATCHER_LT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_WATCHER_LT.exp_unlock_lvl = 57

RISED.Config.Economy.TEAM_MPF_WATCHER_CPT = {}
RISED.Config.Economy.TEAM_MPF_WATCHER_CPT.salary = 0
RISED.Config.Economy.TEAM_MPF_WATCHER_CPT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_WATCHER_CPT.exp_unlock_lvl = 124

RISED.Config.Economy.TEAM_MPF_SPIRE_SGT = {}
RISED.Config.Economy.TEAM_MPF_SPIRE_SGT.salary = 0
RISED.Config.Economy.TEAM_MPF_SPIRE_SGT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_SPIRE_SGT.exp_unlock_lvl = 110

RISED.Config.Economy.TEAM_MPF_SPIRE_LT = {}
RISED.Config.Economy.TEAM_MPF_SPIRE_LT.salary = 0
RISED.Config.Economy.TEAM_MPF_SPIRE_LT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_SPIRE_LT.exp_unlock_lvl = 132

RISED.Config.Economy.TEAM_MPF_SPIRE_CPT = {}
RISED.Config.Economy.TEAM_MPF_SPIRE_CPT.salary = 0
RISED.Config.Economy.TEAM_MPF_SPIRE_CPT.exp_type = "Combine"
RISED.Config.Economy.TEAM_MPF_SPIRE_CPT.exp_unlock_lvl = 175

RISED.Config.Economy.TEAM_OWUDISPATCH = {}
RISED.Config.Economy.TEAM_OWUDISPATCH.salary = 0
RISED.Config.Economy.TEAM_OWUDISPATCH.exp_type = "Combine"
RISED.Config.Economy.TEAM_OWUDISPATCH.exp_unlock_lvl = 50

RISED.Config.Economy.TEAM_OTA_Grunt = {}
RISED.Config.Economy.TEAM_OTA_Grunt.salary = 0
RISED.Config.Economy.TEAM_OTA_Grunt.exp_type = "Combine"
RISED.Config.Economy.TEAM_OTA_Grunt.exp_unlock_lvl = 45

RISED.Config.Economy.TEAM_OTA_Hammer = {}
RISED.Config.Economy.TEAM_OTA_Hammer.salary = 0
RISED.Config.Economy.TEAM_OTA_Hammer.exp_type = "Combine"
RISED.Config.Economy.TEAM_OTA_Hammer.exp_unlock_lvl = 64

RISED.Config.Economy.TEAM_OTA_Ordinal = {}
RISED.Config.Economy.TEAM_OTA_Ordinal.salary = 0
RISED.Config.Economy.TEAM_OTA_Ordinal.exp_type = "Combine"
RISED.Config.Economy.TEAM_OTA_Ordinal.exp_unlock_lvl = 85

RISED.Config.Economy.TEAM_OTA_Soldier = {}
RISED.Config.Economy.TEAM_OTA_Soldier.salary = 0
RISED.Config.Economy.TEAM_OTA_Soldier.exp_type = "Combine"
RISED.Config.Economy.TEAM_OTA_Soldier.exp_unlock_lvl = 45

RISED.Config.Economy.TEAM_OTA_Striker = {}
RISED.Config.Economy.TEAM_OTA_Striker.salary = 0
RISED.Config.Economy.TEAM_OTA_Striker.exp_type = "Combine"
RISED.Config.Economy.TEAM_OTA_Striker.exp_unlock_lvl = 75

RISED.Config.Economy.TEAM_OTA_Razor = {}
RISED.Config.Economy.TEAM_OTA_Razor.salary = 0
RISED.Config.Economy.TEAM_OTA_Razor.exp_type = "Combine"
RISED.Config.Economy.TEAM_OTA_Razor.exp_unlock_lvl = 100

RISED.Config.Economy.TEAM_OTA_Suppressor = {}
RISED.Config.Economy.TEAM_OTA_Suppressor.salary = 0
RISED.Config.Economy.TEAM_OTA_Suppressor.exp_type = "Combine"
RISED.Config.Economy.TEAM_OTA_Suppressor.exp_unlock_lvl = 125

RISED.Config.Economy.TEAM_OTA_Assassin = {}
RISED.Config.Economy.TEAM_OTA_Assassin.salary = 0
RISED.Config.Economy.TEAM_OTA_Assassin.exp_type = "Combine"
RISED.Config.Economy.TEAM_OTA_Assassin.exp_unlock_lvl = 0

RISED.Config.Economy.TEAM_OTA_Tech = {}
RISED.Config.Economy.TEAM_OTA_Tech.salary = 0
RISED.Config.Economy.TEAM_OTA_Tech.exp_type = "Combine"
RISED.Config.Economy.TEAM_OTA_Tech.exp_unlock_lvl = 45

RISED.Config.Economy.TEAM_OTA_Commander = {}
RISED.Config.Economy.TEAM_OTA_Commander.salary = 0
RISED.Config.Economy.TEAM_OTA_Commander.exp_type = "Combine"
RISED.Config.Economy.TEAM_OTA_Commander.exp_unlock_lvl = 125

RISED.Config.Economy.TEAM_OTA_Elite = {}
RISED.Config.Economy.TEAM_OTA_Elite.salary = 0
RISED.Config.Economy.TEAM_OTA_Elite.exp_type = "Combine"
RISED.Config.Economy.TEAM_OTA_Elite.exp_unlock_lvl = 0

RISED.Config.Economy.TEAM_OTA_Crypt = {}
RISED.Config.Economy.TEAM_OTA_Crypt.salary = 0
RISED.Config.Economy.TEAM_OTA_Crypt.exp_type = "Combine"
RISED.Config.Economy.TEAM_OTA_Crypt.exp_unlock_lvl = 155

RISED.Config.Economy.TEAM_SYNTH_CREMATOR = {}
RISED.Config.Economy.TEAM_SYNTH_CREMATOR.salary = 0
RISED.Config.Economy.TEAM_SYNTH_CREMATOR.exp_type = "Combine"
RISED.Config.Economy.TEAM_SYNTH_CREMATOR.exp_unlock_lvl = 25

RISED.Config.Economy.TEAM_SYNTH_GUARD = {}
RISED.Config.Economy.TEAM_SYNTH_GUARD.salary = 0
RISED.Config.Economy.TEAM_SYNTH_GUARD.exp_type = "Combine"
RISED.Config.Economy.TEAM_SYNTH_GUARD.exp_unlock_lvl = 100

RISED.Config.Economy.TEAM_SYNTH_ELITE = {}
RISED.Config.Economy.TEAM_SYNTH_ELITE.salary = 0
RISED.Config.Economy.TEAM_SYNTH_ELITE.exp_type = "Combine"
RISED.Config.Economy.TEAM_SYNTH_ELITE.exp_unlock_lvl = 350

RISED.Config.Economy.TEAM_SYNTH_ELITE2 = {}
RISED.Config.Economy.TEAM_SYNTH_ELITE2.salary = 0
RISED.Config.Economy.TEAM_SYNTH_ELITE2.exp_type = "Combine"
RISED.Config.Economy.TEAM_SYNTH_ELITE2.exp_unlock_lvl = 450



---=== Повстанцы ===---

RISED.Config.Economy.TEAM_REFUGEE = {}
RISED.Config.Economy.TEAM_REFUGEE.salary = 0
RISED.Config.Economy.TEAM_REFUGEE.exp_type = "Common"
RISED.Config.Economy.TEAM_REFUGEE.exp_unlock_lvl = 5

RISED.Config.Economy.TEAM_REBELNEWBIE = {}
RISED.Config.Economy.TEAM_REBELNEWBIE.salary = 0
RISED.Config.Economy.TEAM_REBELNEWBIE.exp_type = "Common"
RISED.Config.Economy.TEAM_REBELNEWBIE.exp_unlock_lvl = 15

RISED.Config.Economy.TEAM_REBELSOLDAT = {}
RISED.Config.Economy.TEAM_REBELSOLDAT.salary = 0
RISED.Config.Economy.TEAM_REBELSOLDAT.exp_type = "Rebel"
RISED.Config.Economy.TEAM_REBELSOLDAT.exp_unlock_lvl = 4

RISED.Config.Economy.TEAM_REBELENGINEER = {}
RISED.Config.Economy.TEAM_REBELENGINEER.salary = 0
RISED.Config.Economy.TEAM_REBELENGINEER.exp_type = "Rebel"
RISED.Config.Economy.TEAM_REBELENGINEER.exp_unlock_lvl = 25

RISED.Config.Economy.TEAM_REBELMEDIC = {}
RISED.Config.Economy.TEAM_REBELMEDIC.salary = 0
RISED.Config.Economy.TEAM_REBELMEDIC.exp_type = "Rebel"
RISED.Config.Economy.TEAM_REBELMEDIC.exp_unlock_lvl = 32

RISED.Config.Economy.TEAM_REBELSPY02 = {}
RISED.Config.Economy.TEAM_REBELSPY02.salary = 0
RISED.Config.Economy.TEAM_REBELSPY02.exp_type = "Rebel"
RISED.Config.Economy.TEAM_REBELSPY02.exp_unlock_lvl = 37

RISED.Config.Economy.TEAM_REBELSPY01 = {}
RISED.Config.Economy.TEAM_REBELSPY01.salary = 0
RISED.Config.Economy.TEAM_REBELSPY01.exp_type = "Rebel"
RISED.Config.Economy.TEAM_REBELSPY01.exp_unlock_lvl = 45

RISED.Config.Economy.TEAM_REBELJUGGER = {}
RISED.Config.Economy.TEAM_REBELJUGGER.salary = 0
RISED.Config.Economy.TEAM_REBELJUGGER.exp_type = "Rebel"
RISED.Config.Economy.TEAM_REBELJUGGER.exp_unlock_lvl = 50

RISED.Config.Economy.TEAM_REBEL_SPEC = {}
RISED.Config.Economy.TEAM_REBEL_SPEC.salary = 0
RISED.Config.Economy.TEAM_REBEL_SPEC.exp_type = "Rebel"
RISED.Config.Economy.TEAM_REBEL_SPEC.exp_unlock_lvl = 57

RISED.Config.Economy.TEAM_REBEL_VETERAN = {}
RISED.Config.Economy.TEAM_REBEL_VETERAN.salary = 0
RISED.Config.Economy.TEAM_REBEL_VETERAN.exp_type = "Rebel"
RISED.Config.Economy.TEAM_REBEL_VETERAN.exp_unlock_lvl = 65

RISED.Config.Economy.TEAM_REBEL_COMMANDER = {}
RISED.Config.Economy.TEAM_REBEL_COMMANDER.salary = 0
RISED.Config.Economy.TEAM_REBEL_COMMANDER.exp_type = "Rebel"
RISED.Config.Economy.TEAM_REBEL_COMMANDER.exp_unlock_lvl = 77

RISED.Config.Economy.TEAM_REBELLEADER = {}
RISED.Config.Economy.TEAM_REBELLEADER.salary = 0
RISED.Config.Economy.TEAM_REBELLEADER.exp_type = "Rebel"
RISED.Config.Economy.TEAM_REBELLEADER.exp_unlock_lvl = 100

RISED.Config.Economy.TEAM_LAMBDASOLDAT = {}
RISED.Config.Economy.TEAM_LAMBDASOLDAT.salary = 0
RISED.Config.Economy.TEAM_LAMBDASOLDAT.exp_type = "Rebel"
RISED.Config.Economy.TEAM_LAMBDASOLDAT.exp_unlock_lvl = 0

RISED.Config.Economy.TEAM_LAMBDASNIPER = {}
RISED.Config.Economy.TEAM_LAMBDASNIPER.salary = 0
RISED.Config.Economy.TEAM_LAMBDASNIPER.exp_type = "Rebel"
RISED.Config.Economy.TEAM_LAMBDASNIPER.exp_unlock_lvl = 0

RISED.Config.Economy.TEAM_LAMBDACOMMANDER = {}
RISED.Config.Economy.TEAM_LAMBDACOMMANDER.salary = 0
RISED.Config.Economy.TEAM_LAMBDACOMMANDER.exp_type = "Rebel"
RISED.Config.Economy.TEAM_LAMBDACOMMANDER.exp_unlock_lvl = 0