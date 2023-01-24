-- "lua\\autorun\\hlvr_combine_workers_player.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
player_manager.AddValidModel( "Combine Worker HLVR", "models/hlvr/characters/hazmat_worker/hazmat_worker_player.mdl" )
list.Set( "PlayerOptionsModel",  "Combine Worker HLVR", "models/hlvr/characters/hazmat_worker/hazmat_worker_player.mdl" )
player_manager.AddValidHands( "Combine Worker HLVR", "models/weapons/c_hlvr_hazmat_worker_arms.mdl", 0, "00000000" )

player_manager.AddValidModel( "Combine Hazmat Worker HLVR", "models/hlvr/characters/worker/worker_player.mdl" )
list.Set( "PlayerOptionsModel",  "Combine Hazmat Worker HLVR", "models/hlvr/characters/worker/worker_player.mdl" )
player_manager.AddValidHands( "Combine Hazmat Worker HLVR", "models/weapons/c_hlvr_combine_worker_arms.mdl", 0, "00000000" )