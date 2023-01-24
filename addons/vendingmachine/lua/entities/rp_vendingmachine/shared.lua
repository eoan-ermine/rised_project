-- "addons\\vendingmachine\\lua\\entities\\rp_vendingmachine\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Vending Machine"
ENT.Author = ""
ENT.Category = "A - Rised - [Еда]"

ENT.Spawnable			= true
ENT.AdminOnly			= true

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0 , "price" )
	self:NetworkVar( "Entity", 1, "owning_ent" )
end

function ENT:Draw()
	
	self:DrawModel()

	local position, angles = self:GetPos(), self:GetAngles()

	angles:RotateAroundAxis(angles:Forward(), 90)

	angles:RotateAroundAxis(angles:Right(), 270)



	local colStage = Color( 255, 255, 255, 255 )
	local colError = Color( 255, 0, 0, 255 )

	if self:GetNWString("VendingMachine_Stage") == "Ready" then
		colStage = Color( 125, 255, 125, 125 )
	elseif self:GetNWString("VendingMachine_Stage") == "Process" then
		colStage = Color( 125, 125, 125, 125 )
	elseif self:GetNWString("VendingMachine_Stage") == "Busy" then
		colStage = Color( 175, 175, 125, 125 )
	end
	
	local pos1 = self:GetPos() + self:GetAngles():Forward() * 17.8 + self:GetAngles():Right() * -24.3 + self:GetAngles():Up() * 5.2
	local pos2 = self:GetPos() + self:GetAngles():Forward() * 17.8 + self:GetAngles():Right() * -24.3 + self:GetAngles():Up() * 3.2
	local pos3 = self:GetPos() + self:GetAngles():Forward() * 17.8 + self:GetAngles():Right() * -24.3 + self:GetAngles():Up() * 1.2
	local pos4 = self:GetPos() + self:GetAngles():Forward() * 17.8 + self:GetAngles():Right() * -24.3 + self:GetAngles():Up() * -0.8
	local pos5 = self:GetPos() + self:GetAngles():Forward() * 17.8 + self:GetAngles():Right() * -24.3 + self:GetAngles():Up() * -2.8
	local pos6 = self:GetPos() + self:GetAngles():Forward() * 17.8 + self:GetAngles():Right() * -24.3 + self:GetAngles():Up() * -4.8
	local pos7 = self:GetPos() + self:GetAngles():Forward() * 17.8 + self:GetAngles():Right() * -24.3 + self:GetAngles():Up() * -6.8
	local pos8 = self:GetPos() + self:GetAngles():Forward() * 17.8 + self:GetAngles():Right() * -24.3 + self:GetAngles():Up() * -8.8
	local rand = math.Rand(1,1.5)
	render.SetMaterial( Material( "sprites/glow04_noz" ) )
	render.DrawSprite( pos1, 1 + rand, 1.5 + rand, colStage )
	render.DrawSprite( pos2, 2.5 + rand, 3 + rand, colError )
	render.DrawSprite( pos3, 2.5 + rand, 3 + rand, colError )
	render.DrawSprite( pos4, 2.5 + rand, 3 + rand, colError )
	render.DrawSprite( pos5, 2.5 + rand, 3 + rand, colError )
	render.DrawSprite( pos6, 2.5 + rand, 3 + rand, colError )
	render.DrawSprite( pos7, 2.5 + rand, 3 + rand, colError )
	render.DrawSprite( pos8, 2.5 + rand, 3 + rand, colError )
end