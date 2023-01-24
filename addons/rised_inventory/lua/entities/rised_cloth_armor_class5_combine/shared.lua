-- "addons\\rised_inventory\\lua\\entities\\rised_cloth_armor_class5_combine\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_gmodentity";
ENT.Type = "anim";

ENT.PrintName		= "Бронежилет (V класса [Альянс])"
ENT.Category 		= "A - Rised - [Одежда]"
ENT.Author			= "D-Rised"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Clothes = "Armor"
ENT.Index = 5
ENT.Weight = 16.2
ENT.Armored = 175
ENT.MaxArmor = 175
ENT.ArmorClass = 5
ENT.ArmorCanUse = {TEAM_REBEL_VETERAN, TEAM_REBEL_COMMANDER, TEAM_REBELLEADER, TEAM_LAMBDACOMMANDER}