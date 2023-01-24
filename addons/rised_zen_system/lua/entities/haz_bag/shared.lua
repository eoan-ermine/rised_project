-- "addons\\rised_zen_system\\lua\\entities\\haz_bag\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"

ENT.Base = "base_gmodentity"

ENT.PrintName		= "Zet Bag"
ENT.Category 		= "A - Rised - [Заражение]"
ENT.Author			= "D-Rised"

ENT.Spawnable = true

game.AddParticles("particles/water_blood.pcf")
PrecacheParticleSystem("wasser_bloodcloud_yellow")