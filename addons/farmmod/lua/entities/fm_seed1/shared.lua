-- "addons\\farmmod\\lua\\entities\\fm_seed1\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "fm_baseseed"
ENT.PrintName = "Семена кукурузы"
ENT.Author = "D-Rised"
ENT.Category = "A - Rised - [Еда]"
ENT.Spawnable = true
ENT.AdminSpawnable = false

//Main Settings
ENT.model = "models/custom_models/sterling/ahshop_package_seeds_01.mdl"
ENT.plant = "models/oldbill/ahplantcorn.mdl"
ENT.plantpos = 1
ENT.size = 15
ENT.farmcrop = 1
ENT.growtime = fastfarm2.CornGrowTime

ENT.Weight = 0.01