-- "addons\\rised_inventory\\lua\\entities\\rised_cloth_armor_class3_medic\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_gmodentity";
ENT.Type = "anim";

ENT.PrintName		= "Бронежилет (III класса [Медика])"
ENT.Category 		= "A - Rised - [Одежда]"
ENT.Author			= "D-Rised"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

ENT.Clothes = "Armor"
ENT.Index = 2
ENT.Weight = 10.5
ENT.Armored = 125
ENT.MaxArmor = 125
ENT.ArmorClass = 3
ENT.ArmorCanUse = {TEAM_REBELMEDIC}