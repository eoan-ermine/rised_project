-- "addons\\atmos\\lua\\effects\\atmos_rain\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

local fancyrain = CreateClientConVar( "atmos_cl_rainsplash", 1, true, false );
local clouds = CreateClientConVar( "atmos_cl_rainclouds", 1, true, false );
local maxrain = CreateClientConVar( "atmos_cl_rainperparticle", 16, true, false );
local maxrainheight = CreateClientConVar( "atmos_cl_maxrainheight", 180, true, false );
local dieTime = CreateClientConVar( "atmos_cl_raindietime", 5, true, false );

function EFFECT:Init( data )

	self.Data = data;

	self.em3D = ParticleEmitter( data:GetOrigin(), true );
	self.em2D = ParticleEmitter( data:GetOrigin() );

	self.Live = true;

	--atmos_log( string.format( "EFFECT:Init() rain magnitude is %s\n", tostring( data:GetMagnitude() ) ) );

end

local data, m, p, pos, ed;

function EFFECT:Think()

	if ( !AtmosStorming ) then

		self:Die();

	end
	
	data = self.Data;
	m = 512; --data:GetMagnitude();
	n = data:GetRadius();

	data:SetOrigin( LocalPlayer():GetPos() );

	--[[
	if ( !debugprint ) then
		
		timer.Simple( 1, function()
			
			atmos_log( string.format( "rain data:GetMagnitude returned %s..\n", tostring( data:GetMagnitude() ) ) );
			
		end );
		
		debugprint = true;
		
	end
	--]]
	
	if ( self.em3D ) then

		self.em3D:SetPos( data:GetOrigin() );

		for i = 1, maxrain:GetInt() do

			pos = data:GetOrigin() + Vector( math.random( -m, m ), math.random( -m, m ), math.min( maxrainheight:GetInt(), math.random( m, 2 * m ) ) );

			if ( atmos_Outside( pos ) ) then

				p = self.em3D:Add( "atmos/water_drop", pos );

				p:SetAngles( Angle( 0, 0, -90 ) );
				p:SetVelocity( Vector( 0, 0, -1000 ) );
				p:SetDieTime( dieTime:GetInt() );
				p:SetStartAlpha( 230 );
				p:SetStartSize( 4 );
				p:SetEndSize( 4 );
				p:SetColor( 255, 255, 255 );

				if ( fancyrain:GetInt() >= 1 ) then

					p:SetCollide( true );
					p:SetCollideCallback( function( p, pos, norm )

						if ( render.GetDXLevel() > 90 and fancyrain:GetInt() >= 1 and math.random( 1, 10 ) == 1 ) then

							ed = EffectData();
							ed:SetOrigin( pos );
							util.Effect( "atmos_rainsplash", ed );

						end

						p:SetDieTime( 0 );

					end );

				end

			end

		end

	end

	if ( self.em2D ) then

		self.em2D:SetPos( data:GetOrigin() );

		if ( clouds:GetInt() >= 1 and math.random() < 0.5 ) then

			pos = data:GetOrigin() + Vector( math.random( -m, m ), math.random( -m, m ), math.min( maxrainheight:GetInt(), math.random( m, 2 * m ) ) );

			if ( atmos_Outside( pos ) ) then

				p = self.em2D:Add( "atmos/rainsmoke", pos );

				p:SetVelocity( Vector( 0, 0, -1000 ) );
				p:SetDieTime( 5 );
				p:SetStartAlpha( 6 );
				p:SetStartSize( 166 );
				p:SetEndSize( 166 );
				p:SetColor( 150, 150, 200 );

				p:SetCollide( true );
				p:SetCollideCallback( function( p, pos, norm )

					p:SetDieTime( 0 );

				end );

			end

		end

	end

	if ( !self.Live ) then

		if ( self.em3D ) then

			self.em3D:Finish();

		end

		if ( self.em2D ) then

			self.em2D:Finish();

		end

		atmos_log( "RainEffect killed" );

		return self.Live;

	end

	return true;

end

function EFFECT:Die()

	self.Live = false;

end

function EFFECT:Render()

end
