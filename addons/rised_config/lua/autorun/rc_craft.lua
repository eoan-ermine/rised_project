-- "addons\\rised_config\\lua\\autorun\\rc_craft.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if RISED == null then
	RISED = {}
	if RISED.Config == null then
		RISED.Config = {}
	end
end

----------========== Крафт ==========----------
RISED.Config.DungeonBoxRefresh = 2000

RISED.Config.Loot = {
	['rcs_lootbox_env_nightstand'] = {
		['RefreshTime'] = 1200,
		['Size'] = 3,
		['Name'] = "Тумбочка",
		['Items'] = {
			{
				['Class'] = "rised_cloth",
				['Chance'] = 60,
				["Model"] = "models/rrp/citizen/clothing_items/beanie_green.mdl",
				["ClothSkin"] = 0,
				["ClothType"] = "Head",
				["ClothName"] = "Зеленая шапка",
				["ClothIndex"] = 2,
			},
			{
				['Class'] = "rised_cloth",
				['Chance'] = 10,
				["Model"] = "models/props_junk/cardboard_box004a.mdl",
				["ClothSkin"] = 0,
				["ClothType"] = "Mask",
				["ClothName"] = "Респиратор X-4",
				["ClothIndex"] = 2,
			},
			{
				['Class'] = "rised_cloth",
				['Chance'] = 80,
				["Model"] = "models/rrp/citizen/clothing_items/gloves_finger.mdl",
				["ClothSkin"] = 0,
				["ClothType"] = "Hands",
				["ClothName"] = "Открытые перчатки",
				["ClothIndex"] = 1,
			},
			{
				['Class'] = "cm_bread",
				['Chance'] = 40,
			},
			{ 
				['Class'] = "cm_apple",
				['Chance'] = 40,
			},
			{
				['Class'] = "cm_milk",
				['Chance'] = 30,
			},
			{
				['Class'] = "cm_cola",
				['Chance'] = 40,
			},
			{
				['Class'] = "med_health_vial",
				['Chance'] = 70,
			},
			{
				['Class'] = "ammo_9x19",
				['Chance'] = 20,
			},
			{
				['Class'] = "ammo_9x39",
				['Chance'] = 20,
			},
			{
				['Class'] = "ammo_12x70",
				['Chance'] = 20,
			},
			{
				['Class'] = "ammo_545x39",
				['Chance'] = 20,
			},
			{
				['Class'] = "ammo_762x25",
				['Chance'] = 20,
			},
			{
				['Class'] = "ammo_762x39",
				['Chance'] = 20,
			},
			{
				['Class'] = "ammo_762x54r",
				['Chance'] = 10,
			},
			{
				['Class'] = "rcs_ing_ammo_bullet",
				['Chance'] = 60,
			},
			{
				['Class'] = "schema_gsh18",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_sawedoff",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_toz",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_tt",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_ak74",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_rpk",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_asval",
				['Chance'] = 40,
			},
			{
				['Class'] = "rcs_ing_ammo_powder",
				['Chance'] = 50,
			},
            
		}
	},
	['rcs_lootbox_env_locker'] = {
		['RefreshTime'] = 1500,
		['Size'] = 3,
		['Name'] = "Шкафчики",
		['Items'] = {
			{
				['Class'] = "rised_cloth",
				['Chance'] = 15,
				["Model"] = "models/props_junk/cardboard_box004a.mdl",
				["ClothSkin"] = 0,
				["ClothType"] = "Mask",
				["ClothName"] = "Респиратор X-3",
				["ClothIndex"] = 1,
			},
			{
				['Class'] = "rised_cloth",
				['Chance'] = 5,
				["Model"] = "models/props_junk/cardboard_box004a.mdl",
				["ClothSkin"] = 0,
				["ClothType"] = "Mask",
				["ClothName"] = "Противогаз",
				["ClothIndex"] = 3,
			},
			{
				['Class'] = "rised_cloth_armor_class3",
				['Chance'] = 5,
			},
			{
				['Class'] = "rised_cloth_armor_class2",
				['Chance'] = 10,
			},
			{
				['Class'] = "cm_banana",
				['Chance'] = 15,
			},
			{
				['Class'] = "rp_soda",
				['Chance'] = 15,
			},
			{
				['Class'] = "rubbish_food",
				['Chance'] = 15,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "weapon_ration4",
				['Chance'] = 15,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "weapon_ration2",
				['Chance'] = 15,
			},
			{
				['Class'] = "ammo_9x19",
				['Chance'] = 5,
			},
			{
				['Class'] = "ammo_12x70",
				['Chance'] = 5,
			},
			{
				['Class'] = "ammo_9x39",
				['Chance'] = 5,
			},
			{
				['Class'] = "ammo_545x39",
				['Chance'] = 5,
			},
			{
				['Class'] = "rcs_ing_wep_spring",
				['Chance'] = 5,
			},
			{
				['Class'] = "rcs_ing_wep_gas_tube",
				['Chance'] = 5,
			},
			{
				['Class'] = "rcs_ing_ammo_bullet",
				['Chance'] = 5,
			},
			{
				['Class'] = "rcs_ing_wep_barrel9x19",
				['Chance'] = 5,
			},
			{
				['Class'] = "rcs_ing_wep_barrel9x39",
				['Chance'] = 5,
			},
			{
				['Class'] = "rcs_metal",
				['Chance'] = 5,
			},
			{
				['Class'] = "schema_gsh18",
				['Chance'] = 5,
			},
			{
				['Class'] = "schema_sawedoff",
				['Chance'] = 5,
			},
			{
				['Class'] = "schema_toz",
				['Chance'] = 5,
			},
			{
				['Class'] = "schema_tt",
				['Chance'] = 5,
			},
			{
				['Class'] = "schema_ak74",
				['Chance'] = 5,
			},
			{
				['Class'] = "schema_rpk",
				['Chance'] = 5,
			},
			{
				['Class'] = "schema_asval",
				['Chance'] = 5,
			},
		}
	},
	['rcs_lootbox_env_file'] = {
		['RefreshTime'] = 1200,
		['Size'] = 3,
		['Name'] = "Архивный шкаф",
		['Items'] = {
			{
				['Class'] = "rised_cloth",
				['Chance'] = 20,
				["Model"] = "models/rrp/citizen/clothing_items/beanie_green.mdl",
				["ClothSkin"] = 0,
				["ClothType"] = "Head",
				["ClothName"] = "Зеленая шапка",
				["ClothIndex"] = 2,
			},
			{
				['Class'] = "rised_cloth",
				['Chance'] = 20,
				["Model"] = "models/rrp/citizen/clothing_items/gloves_finger.mdl",
				["ClothSkin"] = 0,
				["ClothType"] = "Hands",
				["ClothName"] = "Открытые перчатки",
				["ClothIndex"] = 1,
			},
			{
				['Class'] = "cm_bread",
				['Chance'] = 20,
			},
			{
				['Class'] = "cm_apple",
				['Chance'] = 20,
			},
			{
				['Class'] = "cm_milk",
				['Chance'] = 20,
			},
			{
				['Class'] = "cm_cola",
				['Chance'] = 20,
			},
			{
				['Class'] = "med_health_vial",
				['Chance'] = 50,
			},
			{
				['Class'] = "ammo_9x19",
				['Chance'] = 20,
			},
			{
				['Class'] = "ammo_9x39",
				['Chance'] = 20,
			},
			{
				['Class'] = "ammo_12x70",
				['Chance'] = 20,
			},
			{
				['Class'] = "ammo_545x39",
				['Chance'] = 20,
			},
			{
				['Class'] = "ammo_762x25",
				['Chance'] = 20,
			},
			{
				['Class'] = "ammo_762x39",
				['Chance'] = 20,
			},
			{
				['Class'] = "ammo_762x54r",
				['Chance'] = 10,
			},
			{
				['Class'] = "rcs_ing_ammo_powder",
				['Chance'] = 30,
			},
			
		}
	},
	['rcs_lootbox_env_closet_wood'] = {
		['RefreshTime'] = 1700,
		['Size'] = 3,
		['Name'] = "Деревянный шкаф",
		['Items'] = {
			{
				['Class'] = "rised_cloth_armor_class2",
				['Chance'] = 25,
			},
			{
				['Class'] = "med_health_kit",
				['Chance'] = 25,
			},
			{
				['Class'] = "med_drug_amitriptyline",
				['Chance'] = 25,
			},
			{
				['Class'] = "rised_flashlight",
				['Chance'] = 25,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "weapon_lockpick_shot",
				['Chance'] = 35,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "weapon_ration1",
				['Chance'] = 15,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "weapon_ration5",
				['Chance'] = 15,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "weapon_ration4",
				['Chance'] = 15,
			},
			{
				['Class'] = "schema_akm",
				['Chance'] = 25,
			},
			{
				['Class'] = "schema_sks",
				['Chance'] = 25,
			},
			{
				['Class'] = "schema_smg",
				['Chance'] = 25,
			},
			{
				['Class'] = "schema_cheytac",
				['Chance'] = 5,
			},
			{
				['Class'] = "schema_ammo_12x70",
				['Chance'] = 25,
			},
			{
				['Class'] = "schema_ammo_545x39",
				['Chance'] = 25,
			},
			{
				['Class'] = "schema_ammo_9x19",
				['Chance'] = 25,
			},
			{
				['Class'] = "schema_ammo_762x39",
				['Chance'] = 25,
			},
			{
				['Class'] = "schema_ammo_9x39",
				['Chance'] = 25,
			},
			{
				['Class'] = "schema_ammo_103x77",
				['Chance'] = 25,
			},
			{
				['Class'] = "schema_ammo_762x54r",
				['Chance'] = 25,
			},
			{
				['Class'] = "schema_ammo_762x25",
				['Chance'] = 25,
			},
			{
				['Class'] = "rcs_ing_wep_spring",
				['Chance'] = 30,
			},
			{
				['Class'] = "rcs_ing_wep_gas_tube",
				['Chance'] = 30,
			},
			{
				['Class'] = "rcs_ing_ammo_powder",
				['Chance'] = 30,
			},
			{
				['Class'] = "rcs_ing_ammo_bullet",
				['Chance'] = 30,
			},
			{
				['Class'] = "rcs_ing_wep_barrel9x19",
				['Chance'] = 10,
			},
			{
				['Class'] = "rcs_ing_wep_barrel9x39",
				['Chance'] = 40,
			},
			
		}
	},
	['rcs_lootbox_env_closet_metal'] = {
		['RefreshTime'] = 1200,
		['Size'] = 3,
		['Name'] = "Металлический шкаф",
		['Items'] = {
			{
				['Class'] = "rp_soda",
				['Chance'] = 40,
			},
			{
				['Class'] = "rubbish_food",
				['Chance'] = 40,
			},
			{
				['Class'] = "cm_meat",
				['Chance'] = 15,
			},
			{
				['Class'] = "rised_flashlight",
				['Chance'] = 30,
			},
			{
				['Class'] = "med_health_vial",
				['Chance'] = 40,
			},
			{
				['Class'] = "med_health_kit",
				['Chance'] = 30,
			},
			{
				['Class'] = "watch",
				['Chance'] = 35,
			},
			{
				['Class'] = "med_drug_amitriptyline",
				['Chance'] = 35,
			},
			{
				['Class'] = "rms_capsule",
				['Chance'] = 25,
			},
			{
				['Class'] = "rcs_ing_ammo_sleeve",
				['Chance'] = 30,
			},
			{
				['Class'] = "rcs_ing_ammo_bullet",
				['Chance'] = 30,
			},
			{
				['Class'] = "rcs_ing_ammo_powder",
				['Chance'] = 30,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "weapon_ration3",
				['Chance'] = 50,
			},
			{
				['Class'] = "rcs_ing_wep_spring",
				['Chance'] = 30,
			},
			{
				['Class'] = "rcs_metal",
				['Chance'] = 40,
			},
			{
				['Class'] = "rcs_ing_wep_gas_tube",
				['Chance'] = 30,
			},
			{
				['Class'] = "rised_cloth_armor_class3",
				['Chance'] = 25,
			},
			{
				['Class'] = "rised_cloth",
				['Chance'] = 20,
				["Model"] = "models/props_junk/cardboard_box004a.mdl",
				["ClothSkin"] = 0,
				["ClothType"] = "Mask",
				["ClothName"] = "Респиратор X-3",
				["ClothIndex"] = 1,
			},
			{
				['Class'] = "rised_cloth",
				['Chance'] = 20,
				["Model"] = "models/props_junk/cardboard_box004a.mdl",
				["ClothSkin"] = 0,
				["ClothType"] = "Mask",
				["ClothName"] = "Респиратор X-4",
				["ClothIndex"] = 2,
			},
			{
				['Class'] = "rised_cloth",
				['Chance'] = 20,
				["Model"] = "models/props_junk/cardboard_box004a.mdl",
				["ClothSkin"] = 0,
				["ClothType"] = "Mask",
				["ClothName"] = "Противогаз",
				["ClothIndex"] = 3,
			},
		}
	},
	['rcs_lootbox_env_barrel'] = {
		['RefreshTime'] = 1200,
		['Size'] = 3,
		['Name'] = "Бочка",
		['Items'] = {
			{
				['Class'] = "rcs_metal",
				['Chance'] = 50,
			},
			{
				['Class'] = "rcs_ing_ammo_powder",
				['Chance'] = 40,
			},
			{
				['Class'] = "rcs_ing_wep_gas_tube",
				['Chance'] = 40,
			},
			{
				['Class'] = "rcs_ing_ammo_sleeve",
				['Chance'] = 40,
			},
			{
				['Class'] = "rcs_ing_ammo_bullet",
				['Chance'] = 40,
			},

			
		}
	},
	['rcs_lootbox_combine_crate_long'] = {
		['RefreshTime'] = 3000,
		['Size'] = 3,
		['Name'] = "Большой ящик Альянса",
		['Items'] = {
			{
				['Class'] = "turret_box_rebel",
				['Chance'] = 30,
			},
			{
				['Class'] = "rised_cloth_armor_class4",
				['Chance'] = 15,
			},
			{
				['Class'] = "rised_cloth_armor_class3",
				['Chance'] = 25,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "weapon_combinedoor_hacker",
				['Chance'] = 10,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "weapon_decryptor",
				['Chance'] = 10,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "weapon_decryptor",
				['Chance'] = 10,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "weapon_lockpick_shot",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_shotgun",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_pistol",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_357",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_ak74",
				['Chance'] = 40,
			},
		}
	},
	['rcs_lootbox_combine_crate_metal'] = {
		['RefreshTime'] = 1200,
		['Size'] = 3,
		['Name'] = "Металлический ящик Альянса",
		['Items'] = {
			{
				['Class'] = "ammo_9x19",
				['Chance'] = 50,
			},
			{
				['Class'] = "ammo_12x70",
				['Chance'] = 50,
			},
			{
				['Class'] = "ammo_545x39",
				['Chance'] = 50,
			},
			{
				['Class'] = "ammo_762x25",
				['Chance'] = 50,
			},
            {
				['Class'] = "schema_ammo_12x70",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_ammo_545x39",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_ammo_762x25",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_ammo_9x19",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_ammo_9x39",
				['Chance'] = 40,
			},
			{
				['Class'] = "schema_ammo_762x39",
				['Chance'] = 40,
			},
			{
				['Class'] = "rcs_ing_ammo_bullet",
				['Chance'] = 40,
			},

		}
	}, 
	['rcs_lootbox_combine_crate_short'] = {
		['RefreshTime'] = 2100,
		['Size'] = 3,
		['Name'] = "Ящик Альянса",
		['Items'] = {
			{
				['Class'] = "rcs_ing_wep_barrel10x33",
				['Chance'] = 20,
			},
			{
				['Class'] = "rcs_ing_wep_barrel5x45",
				['Chance'] = 30,
			},
			{
				['Class'] = "rcs_ing_wep_barrel7x62",
				['Chance'] = 30,
			},
			{
				['Class'] = "rcs_ing_wep_barrel9x19",
				['Chance'] = 30,
			},
			{
				['Class'] = "rcs_ing_wep_barrel9x39",
				['Chance'] = 20,
			},
			{
				['Class'] = "rcs_ing_wep_barrel18x5",
				['Chance'] = 50,
			},
			{
				['Class'] = "rcs_ing_ammo_bullet",
				['Chance'] = 50,
			},
			{
				['Class'] = "rcs_ing_ammo_powder",
				['Chance'] = 50,
			},
			{
				['Class'] = "rcs_ing_wep_usm_x2",
				['Chance'] = 35,
			},
			{
				['Class'] = "rcs_ing_wep_usm_x1",
				['Chance'] = 35,
			},
			{
				['Class'] = "rcs_ing_wep_shutter_pst",
				['Chance'] = 30,
			},
			{
				['Class'] = "rcs_ing_wep_shutter_bt",
				['Chance'] = 30,
			},
			{
				['Class'] = "rcs_ing_wep_shutter_rt",
				['Chance'] = 30,
			},
			{
				['Class'] = "rcs_ing_wep_forend_pst",
				['Chance'] = 45,
			},
			{
				['Class'] = "rcs_ing_wep_usm_c",
				['Chance'] = 45,
			},
			{
				['Class'] = "rcs_ing_wep_gas_cutoff_reflector",
				['Chance'] = 45,
			},
			{
				['Class'] = "rcs_ing_wep_block_trigger",
				['Chance'] = 45,
			},
			{
				['Class'] = "rcs_ing_wep_spring",
				['Chance'] = 45,
			},
			{
				['Class'] = "rcs_ing_wep_gas_tube",
				['Chance'] = 45,
			},
			{
				['Class'] = "rcs_ing_ammo_sleeve",
				['Chance'] = 45,
			},
			{
				['Class'] = "rcs_ing_wep_block_trigger",
				['Chance'] = 45,
			},
        
		}
	},
	['rcs_lootbox_combine_crate_ammo'] = {
		['RefreshTime'] = 3600,
		['Size'] = 3,
		['Name'] = "Ящик снабжения Альянса",
		['Items'] = {
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "swb_mp5k",
				['Chance'] = 10,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "swb_mp5a5",
				['Chance'] = 10,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "swb_akm",
				['Chance'] = 10,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "swb_shotgun",
				['Chance'] = 10,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "swb_smg",
				['Chance'] = 20,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "swb_pistol",
				['Chance'] = 20,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "swb_357",
				['Chance'] = 20,
			},
			{
				['Class'] = "spawned_weapon",
				['WeaponClass'] = "swb_ak74",
				['Chance'] = 10,
			},
			{
				['Class'] = "rised_flashlight",
				['Chance'] = 80,
			},
			{
				['Class'] = "schema_akm",
				['Chance'] = 85,
			},
			{
				['Class'] = "schema_pistol",
				['Chance'] = 90,
			},
			{
				['Class'] = "schema_smg",
				['Chance'] = 90,
			},
			{
				['Class'] = "schema_ak74",
				['Chance'] = 85,
			},
			{
				['Class'] = "schema_rpk",
				['Chance'] = 90,
			},
			{
				['Class'] = "schema_357",
				['Chance'] = 90,
			},
		}
	},
	['rcs_lootbox_combine_closet_metal'] = {
		['RefreshTime'] = 1500,
		['Size'] = 3,
		['Name'] = "Металлический шкаф",
		['Items'] = {
			{
				['Class'] = "med_drug_amitriptyline",
				['Chance'] = 60,
			},
			{
				['Class'] = "med_drug_cardionix_z2",
				['Chance'] = 40,
			},
			{
				['Class'] = "med_drug_combicillin",
				['Chance'] = 40,
			},
			{
				['Class'] = "med_drug_heptender",
				['Chance'] = 40,
			},
			{
				['Class'] = "med_drug_i306n",
				['Chance'] = 40,
			},
			{
				['Class'] = "med_drug_pulmonifer",
				['Chance'] = 40,
			},
			{
				['Class'] = "med_drug_qurantimycin",
				['Chance'] = 40,
			},
			{
				['Class'] = "med_drug_zenocillin",
				['Chance'] = 40,
			},
			{
				['Class'] = "med_drug_hrzs",
				['Chance'] = 40,
			},
			{
				['Class'] = "rms_capsule_loaded",
				['Chance'] = 50,
			},
			{
				['Class'] = "med_health_vial",
				['Chance'] = 75,
			},
			{
				['Class'] = "med_health_kit",
				['Chance'] = 70,
			},
			{
				['Class'] = "med_drug_tire",
				['Chance'] = 60,
			},
		}
	},
}

RISED.Config.CraftMachineItems = {
	{
		["ItemClass"] = "rcs_ing_wep_barrel5x45",
		["ItemName"] = "Ствол 5.45мм",
		["ItemCost"] = 4,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_barrel7x62",
		["ItemName"] = "Ствол 7.62мм",
		["ItemCost"] = 4,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_barrel9x19",
		["ItemName"] = "Ствол 9.19мм",
		["ItemCost"] = 2,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_barrel9x39",
		["ItemName"] = "Ствол 9.39мм",
		["ItemCost"] = 3,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_barrel10x33",
		["ItemName"] = "Ствол 10.33мм",
		["ItemCost"] = 15,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_barrel18x5",
		["ItemName"] = "Ствол 18.5мм",
		["ItemCost"] = 5,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_block_trigger",
		["ItemName"] = "Колодка от курковки",
		["ItemCost"] = 2,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_forend_pst",
		["ItemName"] = "Цевье продольно-скользящего типа",
		["ItemCost"] = 2,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_gas_cutoff_reflector",
		["ItemName"] = "Отсечка-отражатель",
		["ItemCost"] = 1,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_gas_tube",
		["ItemName"] = "Газовая трубка",
		["ItemCost"] = 2,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_shutter_bt",
		["ItemName"] = "Затвор болтового типа",
		["ItemCost"] = 1,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_shutter_ejector_trigger",
		["ItemName"] = "Эжектор от курковки",
		["ItemCost"] = 1,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_shutter_pst",
		["ItemName"] = "Продольно-скользящий затвор",
		["ItemCost"] = 2,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_shutter_rt",
		["ItemName"] = "Затвор рычажного типа",
		["ItemCost"] = 1,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_spring",
		["ItemName"] = "Возвратная пружина",
		["ItemCost"] = 1,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_usm_c",
		["ItemName"] = "УСМ куркового типа",
		["ItemCost"] = 2,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_usm_x1",
		["ItemName"] = "Однорежимный УСМ",
		["ItemCost"] = 2,
		["Blocked"] = true,
	},
	{
		["ItemClass"] = "rcs_ing_wep_usm_x2",
		["ItemName"] = "Двухрежимный УСМ",
		["ItemCost"] = 2,
		["Blocked"] = true,
	},
}