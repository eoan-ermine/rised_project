-- "addons\\hoboinfection\\lua\\entities\\hoboinfection\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile("shared.lua")

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Инфекция"
ENT.Author = "D-Rised"
ENT.Category = "A - Rised - [Другое]";

ENT.Spawnable = true;
ENT.AdminSpawnable = true;

ENT.Color = Color(0,0,255,255)
ENT.Model = "models/weapons/w_bugbait.mdl"