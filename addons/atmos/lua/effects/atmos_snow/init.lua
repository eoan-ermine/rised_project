-- "addons\\atmos\\lua\\effects\\atmos_snow\\init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

local dieTime = CreateClientConVar( "atmos_cl_snowdietime", 6, true, false );
local snowRadius = CreateClientConVar( "atmos_cl_snowradius", 1200, true, false );
local snowCount = CreateClientConVar( "atmos_cl_snowperparticle", 20, true, false );
local snowHeightMax = CreateClientConVar( "atmos_cl_maxsnowheight", 300, true, false );

local SnowMat = Material( "atmos/snow" );

local function snowCollide( part, partPos )

	part:SetDieTime( 0 );

end

function EFFECT:Init( data )

		if ( !self.em2D ) then

			self.em2D = ParticleEmitter( data:GetOrigin() );

		end

		self.Data = data;
		self.Live = true;
		
		--atmos_log( string.format( "EFFECT:Init() snow magnitude is %s\n", tostring( data:GetMagnitude() ) ) );

end

function EFFECT:Think()

	if ( !AtmosSnowing ) then

		self:Die();

	end

	local data = self.Data;
	local snowHeightMin = AtmosHeightMin or snowHeightMax:GetInt();

	--[[
	if ( !debugprintz ) then
		
		timer.Simple( 1, function()
			
			atmos_log( string.format( "snow data:GetMagnitude returned %s..\n", tostring( data:GetMagnitude() ) ) );
			
		end );
		
		debugprintz = true;
		
	end
	--]]
	
	data:SetOrigin( LocalPlayer():GetPos() );

	if ( self.em2D:GetPos() != data:GetOrigin() ) then

		self.em2D:SetPos( data:GetOrigin() );

	end

	for i = 1, snowCount:GetInt() do

		local r = math.random( 0, snowRadius:GetInt() );
		local s = math.random( -180, 180 );
		local pos = data:GetOrigin() + Vector( math.cos( s ) * r, math.sin( s ) * r, math.min( snowHeightMax:GetInt(), snowHeightMin ) );

		if ( atmos_Outside( pos ) ) then

			local p = self.em2D:Add( SnowMat, pos );
			p:SetVelocity( Vector( 20 + math.random( -5, 5 ), 20 + math.random( -5, 5 ), -80 ) );
			p:SetRoll( math.random( -360, 360 ) );
			p:SetDieTime( dieTime:GetInt() );
			p:SetStartAlpha( 200 );
			p:SetStartSize( 1 );
			p:SetEndSize( 1 );
			p:SetColor( 255, 255, 255 );
			p:SetCollide( true );
			p:SetCollideCallback( snowCollide );

		end

	end

	if ( !self.Live and self.em2D ) then

		self.em2D:Finish();

	end

	return self.Live;

end

function EFFECT:Die()

	self.Live = false;

end

function EFFECT:Render() end
