-- "addons\\atmos\\lua\\autorun\\client\\atmos_cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

local atmoshud = CreateClientConVar( "atmos_cl_hudeffects", 1, true, false );
local weathereffects = CreateClientConVar( "atmos_cl_weather", 1, true, false );
local RainRadius = CreateClientConVar( "atmos_cl_rainradius", 16, true, false );

AtmosStorming = false;
AtmosSnowing = false;

-- lightmap stuff
net.Receive( "atmos_lightmaps", function( len )

	render.RedownloadAllLightmaps();

end );

-- precache
hook.Add( "InitPostEntity", "atmosFirstJoinLightmaps", function()

	render.RedownloadAllLightmaps();

	util.PrecacheSound( "atmos/rain.wav" );
	util.PrecacheSound( "atmos/thunder/thunder_1.mp3" );
	util.PrecacheSound( "atmos/thunder/thunder_2.mp3" );
	util.PrecacheSound( "atmos/thunder/thunder_3.mp3" );
	util.PrecacheSound( "atmos/thunder/thunder_far_away_1.mp3" );
	util.PrecacheSound( "atmos/thunder/thunder_far_away_2.mp3" );

end );

local AtmosRainSound = nil;
local AtmosThunderSound = nil;
local AtmosRainSoundPlaying = false;
local AtmosThunderSoundPlaying = false;
local AtmosRainSoundLastVolume = 0;
local HUDRainDrops = {};
local HUDRainNextGenerate = 0;
local HUDRainMatID = surface.GetTextureID( "atmos/warp_ripple3" );
local nextThunder = 0;

local thunderSounds = {
	"atmos/thunder/thunder_1.mp3",
	"atmos/thunder/thunder_2.mp3",
	"atmos/thunder/thunder_3.mp3",
	"atmos/thunder/thunder_far_away_1.mp3",
	"atmos/thunder/thunder_far_away_2.mp3"
};

local RainEffect = false;
local SnowEffect = false;

local function StormThink()

	local origin = LocalPlayer():EyePos();

	-- rain sounds
	if ( AtmosRainSound == nil or !AtmosRainSoundPlaying ) then

		AtmosRainSound = CreateSound( LocalPlayer(), "atmos/rain.wav" );
		AtmosRainSound:PlayEx( 0, 100 );

		AtmosRainSoundPlaying = true;

	end

	if ( atmos_Outside( origin ) and AtmosRainSoundLastVolume != 0.4 ) then

		AtmosRainSound:ChangeVolume( 0.4, 1 );
		AtmosRainSoundLastVolume = 0.4;

	elseif ( !atmos_Outside( origin ) ) then

		if ( util.IsSkyboxVisibleFromPoint( origin ) and AtmosRainSoundLastVolume != 0.15 ) then

			AtmosRainSound:ChangeVolume( 0.15, 1 );
			AtmosRainSoundLastVolume = 0.15;

		elseif ( !util.IsSkyboxVisibleFromPoint( origin ) and AtmosRainSoundLastVolume != 0 ) then

			AtmosRainSound:ChangeVolume( 0, 1 );
			AtmosRainSoundLastVolume = 0;

		end

	end

	-- rain effect
	if ( !RainEffect ) then

		local pos = LocalPlayer():GetPos();

		local drop = EffectData();
		drop:SetOrigin( pos );
		drop:SetMagnitude( 512 );
		drop:SetRadius( RainRadius:GetInt() );

		util.Effect( "atmos_rain", drop );

		RainEffect = true;

	end

	-- thunder sounds
	if ( nextThunder < CurTime() ) then

		nextThunder = CurTime() + math.random( 15, 80 );

		local snd = Sound( table.Random( thunderSounds ) );

		AtmosThunderSound = CreateSound( LocalPlayer(), snd );
		AtmosThunderSoundPlaying = true;

		if ( atmos_Outside( origin ) ) then

			AtmosThunderSound:PlayEx( 1, 100 );

		else

			AtmosThunderSound:PlayEx( math.Rand( 0.3, 0.7 ), math.Rand( 60, 85 ) );

		end

	end

end

local function SnowThink()

	-- snow effect
	if ( !SnowEffect ) then

		local pos = LocalPlayer():GetPos();

		local drop = EffectData();
		drop:SetOrigin( pos );
		drop:SetMagnitude( 800 );

		util.Effect( "atmos_snow", drop );

		SnowEffect = true;

	end

end

hook.Add( "Think", "atmosStormThink", function()

	if ( !IsValid( LocalPlayer() ) ) then return end

	if ( AtmosStorming and weathereffects:GetInt() > 0 ) then

		StormThink();

	else

		if ( AtmosRainSound and AtmosRainSoundPlaying ) then

			AtmosRainSound:FadeOut( 3 );
			AtmosRainSoundPlaying = false;
			AtmosRainSoundLastVolume = 0;

		end

		if ( AtmosThunderSound and AtmosThunderSoundPlaying ) then

			AtmosThunderSound:FadeOut( 3 );
			AtmosThunderSoundPlaying = false;

		end

		if ( RainEffect ) then

			RainEffect = false;

		end

	end

	if ( AtmosSnowing and weathereffects:GetInt() > 0 ) then

		SnowThink();

	else

		if ( SnowEffect ) then

			SnowEffect = false;

		end

	end

end );

hook.Add( "HUDPaint", "atmosHUDPaint", function()

	if ( !IsValid( LocalPlayer() ) ) then return end
	if ( render.GetDXLevel() <= 90 ) then return end
	if ( LocalPlayer():InVehicle() or LocalPlayer():WaterLevel() > 1 ) then return end
	if ( atmoshud:GetInt() < 1 or weathereffects:GetInt() < 1 ) then return end

	local origin, angles = LocalPlayer():EyePos(), LocalPlayer():EyeAngles();

	if ( AtmosStorming and atmos_Outside( origin ) and angles.p < 15 ) then

		if ( CurTime() > HUDRainNextGenerate ) then

			HUDRainNextGenerate = CurTime() + math.Rand( 0.1, 0.4 );

			local t = { };
			t.x = math.random( 0, ScrW() );
			t.y = math.random( 0, ScrH() );
			t.r = math.random( 20, 40 );
			t.c = CurTime();

			table.insert( HUDRainDrops, t );

		end

	end

	for k, v in pairs( HUDRainDrops ) do

		if ( CurTime() - v.c > 1 ) then
			table.remove( HUDRainDrops, k );
			continue;
		end

		surface.SetDrawColor( 255, 255, 255, 255 * ( 1 - ( CurTime() - v.c ) ) );
		surface.SetTexture( HUDRainMatID );
		surface.DrawTexturedRect( v.x, v.y, v.r, v.r );

	end

end );

net.Receive( "atmos_storm", function( len )

	AtmosStorming = net.ReadBool();

end );

net.Receive( "atmos_snow", function( len )

	AtmosSnowing = net.ReadBool();

end );

net.Receive( "atmos_message", function( len )

	local tab = net.ReadTable();

	if ( #tab > 0 ) then

		chat.AddText( unpack( tab ) );

	end

end );

-- spawnmenu stuff
local function SaveValues( CPanel )

	if ( CPanel == nil ) then return end

	local tbl = {
		enabled = CPanel.enabled:GetChecked() and 1 or 0,
		paused = CPanel.paused:GetChecked() and 1 or 0,
		realtime = CPanel.realtime:GetChecked() and 1 or 0,
		weather = CPanel.weather:GetChecked() and 1 or 0,
		snowenabled = CPanel.snowenabled:GetChecked() and 1 or 0,
		dnclength_day = CPanel.length_day:GetValue(),
		dnclength_night = CPanel.length_night:GetValue(),
		weatherchance = CPanel.weatherchance:GetValue(),
		weatherlength = CPanel.weatherlength:GetValue(),
		weatherdelay = CPanel.weatherdelay:GetValue()
	};

	net.Start( "atmos_settings" );
		net.WriteTable( tbl );
	net.SendToServer();

end

local function UpdateValues( CPanel )

	if ( CPanel == nil ) then return end

	if ( CPanel.enabled ) then

		CPanel.enabled:SetValue( cvars.Number( "atmos_enabled" ) );

	end

	if ( CPanel.paused ) then

		CPanel.paused:SetValue( cvars.Number( "atmos_paused" ) );

	end

	if ( CPanel.realtime ) then

		CPanel.realtime:SetValue( cvars.Number( "atmos_realtime" ) );

	end

	if ( CPanel.weather ) then

		CPanel.weather:SetValue( cvars.Number( "atmos_weather" ) );

	end

	if ( CPanel.snowenabled ) then

		CPanel.snowenabled:SetValue( cvars.Number( "atmos_snowenabled" ) );

	end

	if ( CPanel.length_day ) then

		CPanel.length_day:SetValue( cvars.Number( "atmos_dnc_length_day" ) );

	end

	if ( CPanel.length_night ) then

		CPanel.length_night:SetValue( cvars.Number( "atmos_dnc_length_night" ) );

	end

	if ( CPanel.weatherchance ) then

		CPanel.weatherchance:SetValue( cvars.Number( "atmos_weather_chance" ) );

	end

	if ( CPanel.weatherlength ) then

		CPanel.weatherlength:SetValue( cvars.Number( "atmos_weather_length" ) );

	end

	if ( CPanel.weatherdelay ) then

		CPanel.weatherdelay:SetValue( cvars.Number( "atmos_weather_delay" ) );

	end

end

local function AtmosSettings( CPanel )

	-- logo
	local logo = vgui.Create( "DImageButton" );
	logo:SetImage( "atmos/logo.png" );
	logo:SetSize( 112, 112 );
	logo.DoClick = function()

		local snd = Sound( "items/suitchargeno1.wav" );

		surface.PlaySound( snd );

		gui.OpenURL( AtmosURL );

	end

	CPanel:AddPanel( logo );

	-- Version
	CPanel:AddControl( "Header", { Description = "Atmos Version " .. tostring( atmos_version ) } );

	-- atmos enabled
	language.Add( "atmos.enabled", "Enabled" );
	language.Add( "atmos.enabled.help", "Turn atmos on or off, requires map reload" );

	CPanel.enabled = CPanel:AddControl( "CheckBox", { Label = "#atmos.enabled", Command = "", Help = true } );

	-- atmos paused
	language.Add( "atmos.paused", "Paused" );
	language.Add( "atmos.paused.help", "Turn atmos time progression on or off" );

	CPanel.paused = CPanel:AddControl( "CheckBox", { Label = "#atmos.paused", Command = "", Help = true } );

	-- atmos realtime
	language.Add( "atmos.realtime", "Realtime" );
	language.Add( "atmos.realtime.help", "Whether or not atmos time progression is based on the servers local time zone" );

	CPanel.realtime = CPanel:AddControl( "CheckBox", { Label = "#atmos.realtime", Command = "", Help = true } );

	-- weather enabled
	language.Add( "atmos.weather", "Weather" );
	language.Add( "atmos.weather.help", "Turn weather on or off" );

	CPanel.weather = CPanel:AddControl( "CheckBox", { Label = "#atmos.weather", Command = "", Help = true } );

	-- snow enabled
	language.Add( "atmos.snowenabled", "Snow" );
	language.Add( "atmos.snowenabled.help", "Turn snow on or off" );

	CPanel.snowenabled = CPanel:AddControl( "CheckBox", { Label = "#atmos.snowenabled", Command = "", Help = true } );

	-- atmos dnc length day
	language.Add( "atmos.dnclength_day", "Day Length" );
	language.Add( "atmos.dnclength_day.help", "The duration modifier of daytime in seconds" );

	CPanel.length_day = CPanel:AddControl( "Slider", { Label = "#atmos.dnclength_day", Command = "", Type = "Int", Min = 30, Max = 7200, Help = true } );

	-- atmos dnc length night
	language.Add( "atmos.dnclength_night", "Night Length" );
	language.Add( "atmos.dnclength_night.help", "The duration modifier of nighttime in seconds" );

	CPanel.length_night = CPanel:AddControl( "Slider", { Label = "#atmos.dnclength_night", Command = "", Type = "Int", Min = 30, Max = 7200, Help = true } );

	-- atmos bad weather chance
	language.Add( "atmos.weatherchance", "Weather Chance" );
	language.Add( "atmos.weatherchance.help", "0-100% Chance that weather will occur" );

	CPanel.weatherchance = CPanel:AddControl( "Slider", { Label = "#atmos.weatherchance", Command = "", Type = "Int", Min = 0, Max = 100, Help = true } );

	-- atmos weather length
	language.Add( "atmos.weatherlength", "Weather Length" );
	language.Add( "atmos.weatherlength.help", "How long weather will last" );

	CPanel.weatherlength = CPanel:AddControl( "Slider", { Label = "#atmos.weatherlength", Command = "", Type = "Int", Min = 0, Max = 3600, Help = true } );

	-- atmos weather delay
	language.Add( "atmos.weatherdelay", "Weather Delay" );
	language.Add( "atmos.weatherdelay.help", "How often atmos will attempt to trigger weather" );

	CPanel.weatherdelay = CPanel:AddControl( "Slider", { Label = "#atmos.weatherdelay", Command = "", Type = "Int", Min = 60, Max = 3600, Help = true } );

	-- handle visually updating the values for settings
	timer.Simple( 0.1, function()

		UpdateValues( CPanel );

	end );

	concommand.Add( "atmos_cl_savesv", function( pl, cmd, args )

		if ( !pl:AtmosAdmin() ) then return end

		SaveValues( CPanel );

		timer.Simple( 0.1, function()

			UpdateValues( CPanel );

		end );

	end );

	concommand.Add( "atmos_cl_resetsv", function( pl, cmd, args )

		if ( !pl:AtmosAdmin() ) then return end

		RunConsoleCommand( "atmos_reset" );

		timer.Simple( 0.1, function()

			UpdateValues( CPanel );

		end );

	end );

	CPanel:AddControl( "Button", { Label = "Save Settings", Command = "atmos_cl_savesv" } );
	CPanel:AddControl( "Button", { Label = "Reset Settings", Command = "atmos_cl_resetsv" } );

end

local function AtmosClientSettings( CPanel )

	-- logo
	local logo = vgui.Create( "DImageButton" );
	logo:SetImage( "atmos/logo.png" );
	logo:SetSize( 112, 112 );
	logo.DoClick = function()

		local snd = Sound( "items/suitchargeno1.wav" );

		surface.PlaySound( snd );

		gui.OpenURL( AtmosURL );

	end

	CPanel:AddPanel( logo );

	-- Version
	CPanel:AddControl( "Header", { Description = "Atmos Version " .. tostring( atmos_version ) } );

	-- hud effects
	language.Add( "atmos.hudeffects", "HUD Effects" );
	language.Add( "atmos.hudeffects.help", "Turn rain drops on screen on or off" );

	CPanel:AddControl( "CheckBox", { Label = "#atmos.hudeffects", Command = "atmos_cl_hudeffects", Help = true } );

	-- weather
	language.Add( "atmos.weathereffects", "Weather Effects" );
	language.Add( "atmos.weathereffects.help", "Turn rain particles on or off" );

	CPanel:AddControl( "CheckBox", { Label = "#atmos.weathereffects", Command = "atmos_cl_weather", Help = true } );

	-- rain splashes
	language.Add( "atmos.splasheffects", "Rain Splashes" );
	language.Add( "atmos.splasheffects.help", "Turn rain splash particles on or off" );

	CPanel:AddControl( "CheckBox", { Label = "#atmos.splasheffects", Command = "atmos_cl_rainsplash", Help = true } );

	-- rain clouds
	language.Add( "atmos.cloudeffects", "Rain Clouds" );
	language.Add( "atmos.cloudeffects.help", "Turn rain cloud particles on or off" );

	CPanel:AddControl( "CheckBox", { Label = "#atmos.cloudeffects", Command = "atmos_cl_rainclouds", Help = true } );

	-- rain radius
	language.Add( "atmos.rainradius", "Rain Radius" );
	language.Add( "atmos.rainradius.help", "The distance around you rain particles will spawn" );

	CPanel:AddControl( "Slider", { Label = "#atmos.rainradius", Command = "atmos_cl_rainradius", Type = "Int", Min = 16, Max = 2000, Help = true } );

	-- raindrop per particle effect
	language.Add( "atmos.rainperparticle", "Raindrop Per Particle" );
	language.Add( "atmos.rainperparticle.help", "The amount of rain particles that will spawn in a raincloud" );

	CPanel:AddControl( "Slider", { Label = "#atmos.rainperparticle", Command = "atmos_cl_rainperparticle", Type = "Int", Min = 16, Max = 64, Help = true } );

	-- rain height ceiling
	language.Add( "atmos.maxrainheight", "Maximum Rain Height" );
	language.Add( "atmos.maxrainheight.help", "The max ceiling rain particle systems will spawn under, for fixing rain on maps with very small skybox heights" );

	CPanel:AddControl( "Slider", { Label = "#atmos.maxrainheight", Command = "atmos_cl_maxrainheight", Type = "Int", Min = 16, Max = 1024, Help = true } );

	-- rain life time
	language.Add( "atmos.raindietime", "Rain drop lifetime" );
	language.Add( "atmos.raindietime.help", "The amount of time until a rain particle dies" );

	CPanel:AddControl( "Slider", { Label = "#atmos.raindietime", Command = "atmos_cl_raindietime", Type = "Int", Min = 1, Max = 16, Help = true } );

	-- snow radius
	language.Add( "atmos.snowradius", "Snow Radius" );
	language.Add( "atmos.snowradius.help", "The distance around you snow particles will spawn" );

	CPanel:AddControl( "Slider", { Label = "#atmos.snowradius", Command = "atmos_cl_snowradius", Type = "Int", Min = 16, Max = 2000, Help = true } );

	-- snowdrop per particle effect
	language.Add( "atmos.snowperparticle", "Snowdrop Per Particle" );
	language.Add( "atmos.snowperparticle.help", "The amount of snow particles that will spawn in a raincloud" );

	CPanel:AddControl( "Slider", { Label = "#atmos.snowperparticle", Command = "atmos_cl_snowperparticle", Type = "Int", Min = 16, Max = 64, Help = true } );

	-- snow height ceiling
	language.Add( "atmos.maxsnowheight", "Maximum Snow Height" );
	language.Add( "atmos.maxsnowheight.help", "The max ceiling snow particle systems will spawn under, for fixing snow on maps with very small skybox heights" );

	CPanel:AddControl( "Slider", { Label = "#atmos.maxsnowheight", Command = "atmos_cl_maxsnowheight", Type = "Int", Min = 16, Max = 1024, Help = true } );

	-- snow life time
	language.Add( "atmos.snowdietime", "Snow drop lifetime" );
	language.Add( "atmos.snowdietime.help", "The amount of time until a snow particle dies" );

	CPanel:AddControl( "Slider", { Label = "#atmos.snowdietime", Command = "atmos_cl_snowdietime", Type = "Int", Min = 1, Max = 16, Help = true } );

	-- reset settings
	CPanel:AddControl( "Button", { Label = "Reset Settings", Command = "atmos_cl_reset" } );

end

local function AtmosControl( CPanel )

	-- logo
	local logo = vgui.Create( "DImageButton" );
	logo:SetImage( "atmos/logo.png" );
	logo:SetSize( 112, 112 );
	logo.DoClick = function()

		local snd = Sound( "items/suitchargeno1.wav" );

		surface.PlaySound( snd );

		gui.OpenURL( AtmosURL );

	end

	CPanel:AddPanel( logo );

	-- start storm
	CPanel:AddControl( "Button", { Label = "Start Storm", Command = "atmos_startstorm" } );

	-- stop storm
	CPanel:AddControl( "Button", { Label = "Stop Storm", Command = "atmos_stopstorm" } );

	-- start snow
	CPanel:AddControl( "Button", { Label = "Start Snow", Command = "atmos_startsnow" } );

	-- stop snow
	CPanel:AddControl( "Button", { Label = "Stop Snow", Command = "atmos_stopsnow" } );

end

hook.Add( "PopulateToolMenu", "PopulateAtmosMenus", function()

	spawnmenu.AddToolMenuOption( "Utilities", "Atmos", "AtmosClient", "Client", "", "", AtmosClientSettings );
	spawnmenu.AddToolMenuOption( "Utilities", "Atmos", "AtmosSettings", "Server", "", "", AtmosSettings );
	spawnmenu.AddToolMenuOption( "Utilities", "Atmos", "AtmosControl", "Control", "", "", AtmosControl );

end );

hook.Add( "AddToolMenuCategories", "CreateAtmosCategories", function()

	spawnmenu.AddToolCategory( "Utilities", "Atmos", "Atmos" );

end );

concommand.Add( "atmos_cl_reset", function( pl, cmd, args )

	RunConsoleCommand( "atmos_cl_hudeffects", 1 );
	RunConsoleCommand( "atmos_cl_weather", 1 );

	RunConsoleCommand( "atmos_cl_rainsplash", 1 );
	RunConsoleCommand( "atmos_cl_rainclouds", 1 );
	RunConsoleCommand( "atmos_cl_rainradius", 16 );
	RunConsoleCommand( "atmos_cl_rainperparticle", 16 );
	RunConsoleCommand( "atmos_cl_maxrainheight", 180 );
	RunConsoleCommand( "atmos_cl_raindietime", 5 );

	RunConsoleCommand( "atmos_cl_snowdietime", 6 );
	RunConsoleCommand( "atmos_cl_snowradius", 1200 );
	RunConsoleCommand( "atmos_cl_snowperparticle", 20 );
	RunConsoleCommand( "atmos_cl_maxsnowheight", 300 );

end );
