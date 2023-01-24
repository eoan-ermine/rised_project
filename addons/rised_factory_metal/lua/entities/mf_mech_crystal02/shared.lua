-- "addons\\rised_factory_metal\\lua\\entities\\mf_mech_crystal02\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_gmodentity";
ENT.Type = "anim";

ENT.PrintName		= "Механизм кристализации 02";
ENT.Category 		= "A - Rised - [ГСР Завод - металл]";
ENT.Author			= "D-Rised";

ENT.Contact    		= "";
ENT.Purpose 		= "";
ENT.Instructions 	= "" ;

ENT.Spawnable			= true;
ENT.AdminSpawnable		= true;

function ENT:Initialize()
	self.activated = false
	self.Overload = 0
	self.OverloadMax = 0
end

function ENT:Think()
	if SERVER then return end
	if !self.activated then return end

	local pos = self:GetPos()
	local emitter = ParticleEmitter( pos ) -- Particle emitter in this position

	local part = emitter:Add( "effects/tool_tracer", pos ) -- Create a new particle at pos
	if ( part ) then
		part:SetDieTime( 1 ) -- How long the particle should "live"

		part:SetStartAlpha( 5 ) -- Starting alpha of the particle
		part:SetEndAlpha( 0 ) -- Particle size at the end if its lifetime

		part:SetStartSize( 3 ) -- Starting size
		part:SetEndSize( 0 ) -- Size when removed

		part:SetGravity( Vector( 0, 0, -50 ) ) -- Gravity of the particle
		part:SetVelocity( VectorRand() * 0 ) -- Initial velocity of the particle
	end

	if self.Overload > self.OverloadMax then
		pos = self:GetPos() + self:GetUp() * 6
		local part = emitter:Add( "effects/redflare", pos ) -- Create a new particle at pos
		if ( part ) then
			part:SetDieTime( 1 ) -- How long the particle should "live"

			part:SetStartAlpha( 255 ) -- Starting alpha of the particle
			part:SetEndAlpha( 0 ) -- Particle size at the end if its lifetime

			part:SetStartSize( 0 ) -- Starting size
			part:SetEndSize( 3 ) -- Size when removed

			part:SetGravity( Vector( 0, 0, 0 ) ) -- Gravity of the particle
			part:SetVelocity( VectorRand() * 0 ) -- Initial velocity of the particle
		end
	else
		pos = self:GetPos() + self:GetUp() * 5.5
		local part = emitter:Add( "effects/ar2ground2", pos ) -- Create a new particle at pos
		if ( part ) then
			part:SetDieTime( 2 ) -- How long the particle should "live"

			part:SetStartAlpha( 100 ) -- Starting alpha of the particle
			part:SetEndAlpha( 0 ) -- Particle size at the end if its lifetime

			part:SetStartSize( 3 ) -- Starting size
			part:SetEndSize( 0 ) -- Size when removed

			part:SetGravity( Vector( 0, 0, -30 ) ) -- Gravity of the particle
			part:SetVelocity( VectorRand() * 0 ) -- Initial velocity of the particle
		end
	end

	emitter:Finish()
end