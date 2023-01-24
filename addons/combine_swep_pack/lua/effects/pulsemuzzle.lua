-- "addons\\combine_swep_pack\\lua\\effects\\pulsemuzzle.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

EFFECT.Size				= 16;
EFFECT.Duration			= 0.125;

local MaterialGlow = Material( "pulse/PulseGlow" );
local MaterialMuzzle = Material( "pulse/PulseGlow" );

function EFFECT:GetMuzzle()

	-- this is almost a direct port of GetTracerOrigin in fx_tracer.cpp
	local position = self.Position;
	local angle = self.Angle;
	local entity = self.Weapon;
	
	if( not IsValid( entity ) ) then return position, angle; end
	if( not game.SinglePlayer() and entity:IsEFlagSet( EFL_DORMANT ) ) then return position, angle; end
	
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
	
	local attachment = entity:GetAttachment( self.Attachment );

	if( attachment ) then
		position = attachment.Pos;
		angle = attachment.Ang;
	end

	return position, angle;

end


function EFFECT:Init( data )

	self.Weapon = data:GetEntity();
	self.Attachment = data:GetAttachment();
	self.Position = data:GetOrigin();
	self.Angle = data:GetAngles();
	
	self.LifeTime = self.Duration;
	
	self.Entity:SetRenderBounds( Vector( -16, -16, -16 ), Vector( 16, 16, 16 ) );
	self.Entity:SetParent( self.Weapon );
	
	local pos, ang = self:GetMuzzle();
	
	-- a bright flash of light
	local light = DynamicLight( 0 );
	if( light ) then
		
		light.Pos = pos;
		light.Size = 200;
		light.Decay = 400;
		light.R = 25;
		light.G = 192;
		light.B = 255;
		light.Brightness = 2;
		light.DieTime = CurTime() + 0.35;

	end

end


function EFFECT:Think()

	self.LifeTime = self.LifeTime - FrameTime();
	return self.LifeTime > 0;

end


function EFFECT:Render()

	local pos, ang = self:GetMuzzle();
	local dir = ang:Forward();
	
	local frac = math.max( 0, self.LifeTime / self.Duration );
	local size = self.Size * frac;

	render.SetMaterial( MaterialMuzzle );
	render.DrawBeam( pos, pos + dir * 48 * frac, size, 1, 0, color_white );
	
	render.SetMaterial( MaterialGlow );
	render.DrawSprite( pos, size, size, color_white );

end
