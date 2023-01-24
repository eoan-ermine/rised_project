-- "gamemodes\\darkrp\\entities\\entities\\spawned_money\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Spawned Money"
ENT.Author = "FPtje"
ENT.Spawnable = false
ENT.IsSpawnedMoney = true

function ENT:SetupDataTables()
    self:NetworkVar("Int",0,"amount")
end