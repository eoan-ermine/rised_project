-- "addons\\darkrpmodification\\lua\\entities\\rised_flashlight\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile("shared.lua")

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Фонарик"
ENT.Author = "D-Rised"
ENT.Category = "A - Rised - [Одежда]";

ENT.Spawnable = true;
ENT.AdminSpawnable = true;

ENT.Color = Color(0,0,255,255)
ENT.Model = "models/flashns/w_knife_t.mdl"

ENT.Clothes = "Flashlight"
ENT.Index = 0
ENT.Texture = ""
ENT.Weight = 0.35
ENT.ClothModel = "models/flashns/w_knife_t.mdl"