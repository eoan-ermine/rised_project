-- "addons\\atmos\\lua\\autorun\\atmos_shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

atmos_enabled = CreateConVar( "atmos_enabled", "1", bit.bor( FCVAR_ARCHIVE, FCVAR_GAMEDLL, FCVAR_REPLICATED, FCVAR_NOTIFY ), "Atmos enabled." );
atmos_paused = CreateConVar( "atmos_paused", "0", bit.bor( FCVAR_ARCHIVE, FCVAR_GAMEDLL, FCVAR_REPLICATED, FCVAR_NOTIFY ), "Atmos time progression enabled." );
atmos_realtime = CreateConVar( "atmos_realtime", "0", bit.bor( FCVAR_ARCHIVE, FCVAR_GAMEDLL, FCVAR_REPLICATED, FCVAR_NOTIFY ), "Whether or not atmos progresses based on the servers time zone." );
atmos_logging = CreateConVar( "atmos_log", "0", bit.bor( FCVAR_ARCHIVE, FCVAR_GAMEDLL, FCVAR_REPLICATED, FCVAR_NOTIFY ), "Turn atmos logging to console on or off." );

atmos_dnc_length_day = CreateConVar( "atmos_dnc_length_day", "10080", bit.bor( FCVAR_ARCHIVE, FCVAR_GAMEDLL, FCVAR_REPLICATED ), "The duration modifier of daytime in seconds." );
atmos_dnc_length_night = CreateConVar( "atmos_dnc_length_night", "4320", bit.bor( FCVAR_ARCHIVE, FCVAR_GAMEDLL, FCVAR_REPLICATED ), "The duration modifier of nighttime in seconds." );

atmos_weather = CreateConVar( "atmos_weather", "0", bit.bor( FCVAR_ARCHIVE, FCVAR_GAMEDLL, FCVAR_REPLICATED, FCVAR_NOTIFY ), "Atmos Weather enabled." );
atmos_weather_chance = CreateConVar( "atmos_weather_chance", "20", bit.bor( FCVAR_ARCHIVE, FCVAR_GAMEDLL, FCVAR_REPLICATED ), "Chance for bad weather to occur between 1-100." );
atmos_weather_length = CreateConVar( "atmos_weather_length", "480", bit.bor( FCVAR_ARCHIVE, FCVAR_GAMEDLL, FCVAR_REPLICATED ), "The duration of a storm in seconds." );
atmos_weather_delay = CreateConVar( "atmos_weather_delay", "3600", bit.bor( FCVAR_ARCHIVE, FCVAR_GAMEDLL, FCVAR_REPLICATED ), "How many seconds it takes for atmos to do a dice roll for weather, default is 600 (10 minutes), which means atmos will attempt to trigger a storm every 10 minutes using the chance value." );
atmos_weather_lightstyle = CreateConVar( "atmos_weather_lighting", "0", bit.bor( FCVAR_ARCHIVE, FCVAR_GAMEDLL, FCVAR_REPLICATED, FCVAR_NOTIFY ), "Allow weather to change the lighting (can be buggy?)." );

atmos_snowenabled = CreateConVar( "atmos_snowenabled", "0", bit.bor( FCVAR_ARCHIVE, FCVAR_GAMEDLL, FCVAR_REPLICATED, FCVAR_NOTIFY ), "Atmos Snow enabled." );

atmos_version = 1.91;
atmos_dev = false;
AtmosURL = "http://steamcommunity.com/sharedfiles/filedetails/?id=185609021";

AtmosHeightMin = 300;

function atmos_log( ... )

	if ( atmos_logging:GetInt() < 1 ) then return end

end

function atmos_Outside( pos )

	if ( pos != nil ) then

		local trace = { };
		trace.start = pos;
		trace.endpos = trace.start + Vector( 0, 0, 32768 );
		trace.mask = MASK_BLOCKLOS;

		local tr = util.TraceLine( trace );

		AtmosHeightMin = ( tr.HitPos - trace.start ):Length(); -- thanks to SW for this improvement

		if ( tr.StartSolid ) then return false end
		if ( tr.HitSky ) then return true end

	end

	return false;

end

function atmos_outside( pos )

	return atmos_Outside( pos );

end

-- usergroup support
local meta = FindMetaTable( "Player" )

function meta:AtmosAdmin()

	return self:IsSuperAdmin() or self:IsAdmin();

end
