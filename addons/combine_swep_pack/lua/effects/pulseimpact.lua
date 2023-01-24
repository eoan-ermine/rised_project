-- "addons\\combine_swep_pack\\lua\\effects\\pulseimpact.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

EFFECT.Duration			= 0.25;
EFFECT.Size				= 32;

local MaterialGlow		= Material( "pulse/PulseGlow" );

function EFFECT:Init( data )

	self.Position = data:GetOrigin();
	self.Normal = data:GetNormal();
	self.LifeTime = self.Duration;

	-- particles
	local emitter = ParticleEmitter( self.Position );
	if( emitter ) then
		
		for i = 1, 32 do

			local particle = emitter:Add( "pulse/PulseGlow", self.Position + self.Normal * 2 );
			particle:SetVelocity( ( self.Normal + VectorRand() * 0.75 ):GetNormal() * math.Rand( 75, 125 ) );
			particle:SetDieTime( math.Rand( 0.5, 1.25 ) );
			particle:SetStartAlpha( 255 );
			particle:SetEndAlpha( 0 );
			particle:SetStartSize( math.Rand( 1, 2 ) );
			particle:SetEndSize( 0 );
			particle:SetRoll( 0 );
			particle:SetColor( 25, 192, 255 );
			particle:SetGravity( Vector( 0, 0, -250 ) );
			particle:SetCollide( true );
			particle:SetBounce( 0.3 );
			particle:SetAirResistance( 5 );

		end

		emitter:Finish();

	end
	
	-- light
	local light = DynamicLight( 0 );
	if( light ) then

		light.Pos = self.Position;
		light.Size = 64;
		light.Decay = 256;
		light.R = 25;
		light.G = 192;
		light.B = 255;
		light.Brightness = 2;
		light.DieTime = CurTime() + self.Duration;

	end

end


function EFFECT:Think()

	self.LifeTime = self.LifeTime - FrameTime();
	return self.LifeTime > 0;

end


function EFFECT:Render()

	local frac = math.max( 0, self.LifeTime / self.Duration );
	local rgb = 255 * frac;
	local color = Color( rgb, rgb, rgb, 255 );

	render.SetMaterial( MaterialGlow );
	render.DrawQuadEasy( self.Position + self.Normal, self.Normal, self.Size, self.Size, color );

end
