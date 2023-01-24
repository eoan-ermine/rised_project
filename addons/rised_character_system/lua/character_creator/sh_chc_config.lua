-- "addons\\rised_character_system\\lua\\character_creator\\sh_chc_config.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[

 _____ _                          _                   _____                _             
|  __ \ |                        | |                 |  __ |              | |            
| /  \/ |__   __ _ _ __ __ _  ___| |_ ___ _ __ ______| /  \|_ __ ___  __ _| |_ ___  _ __ 
| |   | '_ \ / _` | '__/ _` |/ __| __/ _ \ '__|______| |   | '__/ _ \/ _` | __/ _ \| '__|
| \__/\ | | | (_| | | | (_| | (__| ||  __/ |         | \__/\ | |  __/ (_| | || (_) | |   
|_____/_| |_|\__,_|_|  \__,_|\___|\__\___|_|         |_____/_|  \___|\__,_|\__\___/|_|   
                                                                                                                                                                                  

]]
-----------------------------------------------------------------------------
---------------------------Main Configuration--------------------------------
-----------------------------------------------------------------------------

CharacterCreator = CharacterCreator or {}

CharacterCreator.CharacterLang = "ru" -- You can Choose fr , en , es , ru , de

CharacterCreator.NameServer = "Rised Project" -- The name of your server

CharacterCreator.BackImage = "materials/beta_background.png"
CharacterCreator.BackImageCWU = "materials/cwu_backgroung.png"
CharacterCreator.BackImageMetropolice = "materials/metropolice_background.png"
CharacterCreator.BackImageOTA = "materials/ota_background.png"
CharacterCreator.BackImageDispatch = "materials/dispatch_background.png"
CharacterCreator.BackImageLoyalty = "materials/cwu_background.png"
CharacterCreator.BackImageRebels = "materials/rebels_background.png"
CharacterCreator.BackImageZen = "materials/zen_background.png"
CharacterCreator.BackImageUbh = "materials/ubh_background.jpg"

CharacterCreator.Description = "Добро пожаловать. В данном меню вы можете выбрать персонажа. По любым вопросам обращайтесь к администрации сервера. Обязательно прочитайте правила."

CharacterCreator.MoneyOnStartCharacter = 0 -- The starting money of the Character (If you have ATM set this value to 0)

CharacterCreator.CharacterNotify = true -- Notify when Character was Saved

CharacterCreator.SaveChangingName = true -- If when you change your name it was saved . 

CharacterCreator.CharacterRpNameDisable = false -- RpName Command Enabled/Disable 

CharacterCreator.CharacterSetTeamNoRespawn = false -- If When you change job you don't respawn 

CharacterCreator.CharacterDisableBodyGroup = true -- If you want disable Bodygroup 

CharacterCreator.CharacterDisableDeathOpenMenu = false -- If you want disable the menu when the player death 

CharacterCreator.CharacterAccountLinked = false -- If you want the account of the three character are linked

CharacterCreator.NpcName = "Выбор персонажа" -- The name of the npc 

CharacterCreator.RankToOpenAdmin = { -- Who can acces to the Admin Menu
	["superadmin"] = true, 
	["hand"] = true,
}

CharacterCreator.Character2VIP = false -- If Character2 requiered a rank 

CharacterCreator.Character2VIPRank = { -- Who can acces to the Character 2
	["superadmin"] = true, 
	["hand"] = true,
}

CharacterCreator.Character3VIP = true -- If Character3 requiered a rank 

CharacterCreator.Character3VIPRank = { -- Who can acces to the Character 3 
	["superadmin"] = true, 
	["hand"] = true,
	["retinue"] = true,
	["builder"] = true,
	["manager"] = true,
	["admin_III"] = true,
	["admin_II"] = true,
	["admin_I"] = true,
	["event_manager"] = true,
	["sup_eventer"] = true,
	["inf_eventer"] = true,
	["rec_eventer"] = true,
	["sup_moderator"] = true,
	["inf_moderator"] = true,
	["candidate"] = true,
}

CharacterCreator.FacialHairModelsSupport = {
	"models/player/hl2rp/male_01.mdl",
	"models/player/hl2rp/male_02.mdl",
	"models/player/hl2rp/male_03.mdl",
	"models/player/hl2rp/male_04.mdl",
	"models/player/hl2rp/male_05.mdl",
	"models/player/hl2rp/male_06.mdl",
	"models/player/hl2rp/male_07.mdl",
	"models/player/hl2rp/male_08.mdl",
	"models/player/hl2rp/male_09.mdl",
}

CharacterCreator.ClothesJobs = {
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
}

-----------------------------------------------------------------------------
---------------------------Music Configuration-------------------------------
-----------------------------------------------------------------------------

-- You can upload your sound mp3 here https://vocaroo.com/ and take the link like :
-- "https://vocaroo.com//media/download_temp/Vocaroo_s08bqIR6mgzh.mp3" 

CharacterCreator.MusicMenuActivate = false -- If you want music in the menu 

CharacterCreator.MusicMenu = ""

CharacterCreator.MusicMenuVolume = 1 -- 1 = 100 % / 0.5 = 50%  

CharacterCreator.MusicCreatedActivate = false -- If you want music when the character are created

CharacterCreator.MusicCreated = ""

CharacterCreator.MusicCreatedVolume = 1 -- 1 = 100 % / 0.5 = 50% 

-----------------------------------------------------------------------------
---------------------------Load Configuration--------------------------------
-----------------------------------------------------------------------------

CharacterCreator.CharacterLoadHealth = true -- Load Health of the Character

CharacterCreator.CharacterLoadArmor = true -- Load Armor of the Character

CharacterCreator.CharacterLoadMoney = false -- Load Money of the Character

CharacterCreator.CharacterLoadLoyalty = true -- Load Loyalty of the Character

CharacterCreator.CharacterLoadLifes = true -- Load Lifes of the Character

CharacterCreator.CharacterLoadJob = true -- Load Job of the Character

CharacterCreator.CharacterLoadLicense = true -- Load license of the Character

CharacterCreator.CharacterLoadWanted = true -- Load Wanted of the Character

CharacterCreator.CharacterLoadPosition = true -- Load the Position of the Character

CharacterCreator.CharacterLoadWeapons = true -- Load the Weapons of the Character

-----------------------------------------------------------------------------
---------------------------Table Configuration-------------------------------
-----------------------------------------------------------------------------

-- When you set a job in this configuration the money and the job will not be saved 
-- Example : You don't want there to be two mayors on your server 

CharacterCreator.CharacterJobNotSave = {
	["Арестант"] = true,
}

-- When you set a job in this configuration the Model of the character will not be applied
-- Example : In the Police Job you have custom model and you don't want the model of your character was applied

CharacterCreator.CharacterJobModelNotSave = { 
	["Hobo"] = true, 
	["Civil Protection"] = true,
}

-----------------------------------------------------------------------------
----------------------- Compatibility Configuration--------------------------
-----------------------------------------------------------------------------

CharacterCreator.CompatibilityItemStore = false -- Compatibility with ItemStore 

CharacterCreator.CompatibilityMedicMod = false -- Compatibility with MedicMod

CharacterCreator.CompatibilityClothesMod = false -- Compatibility with Clothes Mod 

-----------------------------------------------------------------------------
-------------------------- Button Configuration------------------------------
-----------------------------------------------------------------------------

CharacterCreator.Bouttons = {}
CharacterCreator.Bouttons[1] = { -- ( Five Max )

	NameButton = "Правила", -- Name of the button 
	UrlButton = "https://wiki.risedproject.com/ru/rules" -- Url of the button 	

}

CharacterCreator.Bouttons[2] = { -- ( Five Max )

	NameButton = "Discord", -- Name of the button 
	UrlButton = "https://discord.gg/9Fr2EyDta6" -- Url of the button 
}

CharacterCreator.Bouttons[3] = { -- ( Five Max )

	NameButton = "Контент", -- Name of the button 
	UrlButton = "https://steamcommunity.com/sharedfiles/filedetails/?id=748865400" -- Url of the button 

}

-----------------------------------------------------------------------------
---------------------------- Table Configuration ----------------------------
-----------------------------------------------------------------------------

CharacterCreator.Nationality = { -- Name of the Nationality
	"Человек",
	"Вортигонт",
}

CharacterCreator.CharacterName = { -- Random Name 
	"Ethan",
	"Robert",
	"Adrien",
	"William",
	"Mickael",
	"Emillie",
	"Sarah",
	"Jack",
	"David",
	"Vladimir",
}

CharacterCreator.CharacterSurName = { -- Random SurName 
	"Adam",
	"Austin",
	"Lincoln",
	"Murfy",
	"Gran",
	"Edouards",
	"Anderson",
	"Boswell",
	"Roswell",
	"Guthember",
}

-----------------------------------------------------------------------------
--------------------------- Model Configuration------------------------------
-----------------------------------------------------------------------------

CharacterCreator.Models = {}

CharacterCreator.Models[1] = { -- Boys Models Configuration
	"models/player/hl2rp/male_01.mdl",
	"models/player/hl2rp/male_02.mdl",
	"models/player/hl2rp/male_03.mdl",
	"models/player/hl2rp/male_04.mdl",
	"models/player/hl2rp/male_05.mdl",
	"models/player/hl2rp/male_06.mdl",
	"models/player/hl2rp/male_07.mdl",
	"models/player/hl2rp/male_08.mdl",
	"models/player/hl2rp/male_09.mdl",
}

CharacterCreator.Models[2] = { -- Girls Models Configuration
	"models/player/hl2rp/female_01.mdl",
	"models/player/hl2rp/female_02.mdl",
	"models/player/hl2rp/female_03.mdl",
	"models/player/hl2rp/female_04.mdl",
	"models/player/hl2rp/female_06.mdl",
	"models/player/hl2rp/female_07.mdl",
}

-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------