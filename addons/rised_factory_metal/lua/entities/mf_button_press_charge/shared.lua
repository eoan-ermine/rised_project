-- "addons\\rised_factory_metal\\lua\\entities\\mf_button_press_charge\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_gmodentity";
ENT.Type = "anim";

ENT.PrintName		= "Кнопка заряд пресса";
ENT.Category 		= "A - Rised - [ГСР Завод - металл]";
ENT.Author			= "D-Rised";

ENT.Contact    		= "";
ENT.Purpose 		= "";
ENT.Instructions 	= "" ;

ENT.Spawnable			= true;
ENT.AdminSpawnable		= true;
ENT.PosePosition = 0

function ENT:Think()
	if ( CLIENT ) then
		local TargetPos = 0.0
		if self.activated == "enabled" then TargetPos = 1.0 end

		self.PosePosition = math.Approach( self.PosePosition, TargetPos, FrameTime() * 5.0 )

		self:SetPoseParameter( "switch", self.PosePosition )
		self:InvalidateBoneCache()
	end
end
