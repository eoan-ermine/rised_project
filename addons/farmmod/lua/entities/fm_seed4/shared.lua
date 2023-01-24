-- "addons\\farmmod\\lua\\entities\\fm_seed4\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "fm_baseseed"
ENT.PrintName = "Семена моркови"
ENT.Author = "D-Rised"
ENT.Category = "A - Rised - [Еда]"
ENT.Spawnable = true
ENT.AdminSpawnable = false

//Main Settings
ENT.model = "models/custom_models/sterling/ahshop_package_seeds_04.mdl"
ENT.plant = "models/custom_models/sterling/ahshop_single_carrot.mdl"
ENT.plantpos = 1.7
ENT.size = 13
ENT.farmcrop = 4
ENT.growtime = fastfarm2.CarrotGrowTime

ENT.Weight = 0.01