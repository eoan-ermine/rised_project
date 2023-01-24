-- "addons\\rised_craft_system\\lua\\entities\\rcs_lootbox_env_closet_metal\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_gmodentity";
ENT.Type = "anim";

ENT.PrintName		= "Loot - Шкаф металлический"
ENT.Category 		= "A - Rised - [Крафт]"
ENT.Author			= "D-Rised"

ENT.Spawnable		= true
ENT.AdminSpawnable	= true

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "OpeningPlayer")
    self:NetworkVar("Bool", 0, "IsOpening")
    self:NetworkVar("Float", 0, "StartCheckTime")
    self:NetworkVar("Float", 1, "EndCheckTime")
    self:NetworkVar("Float", 2, "NextSoundTime")
end