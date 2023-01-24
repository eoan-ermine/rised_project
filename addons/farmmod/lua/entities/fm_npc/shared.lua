-- "addons\\farmmod\\lua\\entities\\fm_npc\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_ai" 
ENT.Type = "ai"
ENT.PrintName = "Фермер"
ENT.Author = "D-Rised"
ENT.Category = "A - Rised - [Еда]"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.AutomaticFrameAdvance = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "WeedValue")
	self:NetworkVar("Int", 2, "WeedCountShop")
	self:NetworkVar("Int", 3, "WeedGramShop")
	self:NetworkVar("Int", 4, "EntIndexs")
	self:NetworkVar("Int", 5, "TotalGram")
	self:NetworkVar("Bool", 0, "SpamCoolDown")
end