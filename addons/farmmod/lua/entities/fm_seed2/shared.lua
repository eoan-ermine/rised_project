-- "addons\\farmmod\\lua\\entities\\fm_seed2\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "fm_baseseed"
ENT.PrintName = "Семена томатов"
ENT.Author = "D-Rised"
ENT.Category = "A - Rised - [Еда]"
ENT.Spawnable = true
ENT.AdminSpawnable = false

//Main Settings
ENT.model = "models/custom_models/sterling/ahshop_package_seeds_02.mdl"
ENT.plant = "models/oldbill/tomatoplant.mdl"
ENT.plantpos = 1
ENT.size = 15
ENT.farmcrop = 2
ENT.growtime = fastfarm2.TomatoGrowTime

ENT.Weight = 0.01