-- "addons\\farmmod\\lua\\entities\\fm_seed3\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "fm_baseseed"
ENT.PrintName = "Семена капусты"
ENT.Author = "D-Rised"
ENT.Category = "A - Rised - [Еда]"
ENT.Spawnable = true
ENT.AdminSpawnable = false

//Main Settings
ENT.model = "models/custom_models/sterling/ahshop_package_seeds_03.mdl"
ENT.plant = "models/custom_models/sterling/ahshop_cabbage.mdl"
ENT.plantpos = 1.6
ENT.size = 15
ENT.farmcrop = 3
ENT.growtime = fastfarm2.CabageGrowTime

ENT.Weight = 0.01