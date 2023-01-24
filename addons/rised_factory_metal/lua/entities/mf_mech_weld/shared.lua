-- "addons\\rised_factory_metal\\lua\\entities\\mf_mech_weld\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_gmodentity";
ENT.Type = "anim";

ENT.PrintName		= "Механизм сварки";
ENT.Category 		= "A - Rised - [ГСР Завод - металл]";
ENT.Author			= "D-Rised";

ENT.Contact    		= "";
ENT.Purpose 		= "";
ENT.Instructions 	= "" ;

ENT.Spawnable			= true;
ENT.AdminSpawnable		= true;

function ENT:Think()
	if SERVER then return end

	if self.Weld_Activated != "enabled" then return end
	local pos = self:GetPos() + self:GetForward() * 19 + self:GetUp() * -20 + self:GetRight() * -4.2
	local emitter = ParticleEmitter( pos ) -- Particle emitter in this position

	local part = emitter:Add( "effects/spark", pos ) -- Create a new particle at pos
	if ( part ) then
		part:SetDieTime( 0.25 ) -- How long the particle should "live"

		part:SetStartAlpha( 255 ) -- Starting alpha of the particle
		part:SetEndAlpha( 0 ) -- Particle size at the end if its lifetime

		part:SetStartSize( 1 ) -- Starting size
		part:SetEndSize( 0 ) -- Size when removed

		part:SetGravity( Vector( 0, 0, -100 ) ) -- Gravity of the particle
		part:SetVelocity( VectorRand() * 0 ) -- Initial velocity of the particle
	end	

	local pos2 = self:GetPos() + self:GetForward() * 19 + self:GetUp() * -23 + self:GetRight() * -4.2
	local part2 = emitter:Add( "effects/spark", pos2 ) -- Create a new particle at pos
	if ( part2 ) then
		part2:SetDieTime( 0.25 ) -- How long the particle should "live"

		part2:SetStartAlpha( 255 ) -- Starting alpha of the particle
		part2:SetEndAlpha( 0 ) -- Particle size at the end if its lifetime

		part2:SetStartSize( 0.5 ) -- Starting size
		part2:SetEndSize( 0 ) -- Size when removed

		part2:SetGravity( Vector( 0, 0, -100 ) ) -- Gravity of the particle
		part2:SetVelocity( VectorRand() * 20 ) -- Initial velocity of the particle
	end

	emitter:Finish()
end