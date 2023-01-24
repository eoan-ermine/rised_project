-- "lua\\autorun\\hazmatconscripts_random.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local HAZM_models = {"models/player/hazmat/hazmat1980_npc.mdl",
                   "models/player/hazmat/hazmat1980_npc_combine.mdl"}
hook.Add("PlayerSpawnedNPC","RandomHazmatGuy",function(ply,npc)
    if table.HasValue( HAZM_models, npc:GetModel() )					
	       then 
		    npc:SetSkin( math.random(0,3) )
    end
end)


