-- "gamemodes\\darkrp\\entities\\entities\\microwave\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "lab_base"
ENT.PrintName = "Microwave"

function ENT:initVars()
    self.model = "models/props/cs_office/microwave.mdl"
    self.initialPrice = GAMEMODE.Config.microwavefoodcost
    self.labPhrase = DarkRP.getPhrase("microwave")
    self.itemPhrase = DarkRP.getPhrase("food")
end
