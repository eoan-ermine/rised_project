-- "addons\\combine_swep_pack\\lua\\effects\\pulsetracer.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

TRACER_FLAG_USEATTACHMENT	= 0x0002;
SOUND_FROM_WORLD			= 0;
CHAN_STATIC					= 6;

EFFECT.Speed				= 6500;
EFFECT.Length				= 64;
EFFECT.WhizSound			= Sound( "Weapon_StunStick.Melee_Miss" );
EFFECT.WhizDistance			= 72;

local MaterialGlow			= Material( "pulse/PulseGlow" );
local MaterialMuzzle		= Material( "pulse/PulseMuzzle" );

function EFFECT:GetTracerOrigin( data )

	-- this is almost a direct port of GetTracerOrigin in fx_tracer.cpp
	local start = data:GetStart();
	
	-- use attachment?
	if( bit.band( data:GetFlags(), TRACER_FLAG_USEATTACHMENT ) == TRACER_FLAG_USEATTACHMENT ) then

		local entity = data:GetEntity();
		
		if( not IsValid( entity ) ) then return start; end
		if( not game.SinglePlayer() and entity:IsEFlagSet( EFL_DORMANT ) ) then return start; end
		
		if( entity:IsWeapon() and entity:IsCarriedByLocalPlayer() ) then
			-- can't be done, can't call the real function
			-- local origin = weapon:GetTracerOrigin();
			-- if( origin ) then
			-- 	return origin, angle, entity;
			-- end
			
			-- use the view model
			local pl = entity:GetOwner();
			if( IsValid( pl ) ) then
				local vm = pl:GetViewModel();
				if( IsValid( vm ) and not LocalPlayer():ShouldDrawLocalPlayer() ) then
					entity = vm;
				else
					-- HACK: fix the model in multiplayer
					if( entity.WorldModel ) then
						entity:SetModel( entity.WorldModel );
					end
				end
			end
		end

		local attachment = entity:GetAttachment( data:GetAttachment() );
		if( attachment ) then
			start = attachment.Pos;
		end

	end
	
	return start;

end


function EFFECT:Init( data )

	self.StartPos = self:GetTracerOrigin( data );
	self.EndPos = data:GetOrigin();
	
	self.Entity:SetRenderBoundsWS( self.StartPos, self.EndPos );

	local diff = ( self.EndPos - self.StartPos );
	
	self.Normal = diff:GetNormal();
	self.StartTime = 0;
	self.LifeTime = ( diff:Length() + self.Length ) / self.Speed;
	
	-- whiz by sound
	local weapon = data:GetEntity();
	if( IsValid( weapon ) and ( not weapon:IsWeapon() or not weapon:IsCarriedByLocalPlayer() ) ) then

		local dist, pos, time = util.DistanceToLine( self.StartPos, self.EndPos, EyePos() );
		if( dist <= self.WhizDistance ) then
			EmitSound( self.WhizSound, pos, SOUND_FROM_WORLD, CHAN_STATIC, 1, 100, 0, math.random( 100, 150 ) );
		end

	end

end


function EFFECT:Think()

	self.LifeTime = self.LifeTime - FrameTime();
	self.StartTime = self.StartTime + FrameTime(); 

	return self.LifeTime > 0;

end


function EFFECT:Render()

	local endDistance = self.Speed * self.StartTime;
	local startDistance = endDistance - self.Length;
	
	startDistance = math.max( 0, startDistance );
	endDistance = math.max( 0, endDistance );

	local startPos = self.StartPos + self.Normal * startDistance;
	local endPos = self.StartPos + self.Normal * endDistance;
	
	render.SetMaterial( MaterialGlow );
	render.DrawSprite( endPos, 8, 8, color_white );

	render.SetMaterial( MaterialMuzzle );
	render.DrawBeam( startPos, endPos, 10, 0, 1, color_white );
	
end
