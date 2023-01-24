-- "addons\\rised_inventory\\lua\\entities\\rised_cloth_armor_class4\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_gmodentity";
ENT.Type = "anim";

ENT.PrintName		= "Бронежилет (IV класса)"
ENT.Category 		= "A - Rised - [Одежда]"
ENT.Author			= "D-Rised"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Clothes = "Armor"
ENT.Index = 4
ENT.Weight = 14.4
ENT.Armored = 150
ENT.MaxArmor = 150
ENT.ArmorClass = 4
ENT.ArmorCanUse = {TEAM_REBELSOLDAT, TEAM_REBELENGINEER, TEAM_REBEL_SPEC, TEAM_REBEL_VETERAN, TEAM_REBEL_COMMANDER, TEAM_REBELLEADER, TEAM_LAMBDASOLDAT, TEAM_LAMBDACOMMANDER}