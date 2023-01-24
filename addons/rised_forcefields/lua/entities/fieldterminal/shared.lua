-- "addons\\rised_forcefields\\lua\\entities\\fieldterminal\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_gmodentity";
ENT.Type = "anim";

ENT.PrintName		= "Терминал барьера";
ENT.Category 		= "A - Rised - [Альянс]";
ENT.Author			= "D-Rised";

ENT.Contact    		= "";
ENT.Purpose 		= "";
ENT.Instructions 	= "" ;

ENT.Spawnable			= true;
ENT.AdminSpawnable		= true;

function ENT:Draw()
	
	self:DrawModel()

	local position, angles = self:GetPos(), self:GetAngles()

	angles:RotateAroundAxis(angles:Forward(), 90)

	angles:RotateAroundAxis(angles:Right(), 270)

	local colStatus = Color( 255, 165, 0, 255 )
	
	if self:GetNWString("TERMIsBroken") then
		colStatus = Color( 255, 0, 0, 255 )
	end

	local pos = self:GetPos() + self:GetAngles():Forward() * 2.2 + self:GetAngles():Right() * 13 + self:GetAngles():Up() * 32.5
	local rand = math.Rand(1,1.5)

	render.SetMaterial( Material( "sprites/glow04_noz" ) )
	render.DrawSprite( pos, 5 + rand, 5 + rand, colStatus )
end