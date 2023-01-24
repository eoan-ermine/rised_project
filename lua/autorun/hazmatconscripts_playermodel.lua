-- "lua\\autorun\\hazmatconscripts_playermodel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function AddPlayerModel( name, model )

    list.Set( "PlayerOptionsModel", name, model )
    player_manager.AddValidModel( name, model )

end

AddPlayerModel( "HL2 Hazmat Conscript", "models/player/hazmat/hazmat1980.mdl" )
player_manager.AddValidModel( "HL2 Hazmat Conscript", "models/player/hazmat/hazmat1980.mdl" );
player_manager.AddValidHands( "HL2 Hazmat Conscript",	"models/weapons/c_ddok_hazmat_arms.mdl",	1,	"00000000" )
list.Set( "PlayerOptionsAnimations", "Hazmat Conscript", 	{ "menu_combine" } )
util.PrecacheModel( "models/player/hazmat/hazmat1980.mdl" )
util.PrecacheModel( "models/weapons/c_ddok_hazmat_arms.mdl" )