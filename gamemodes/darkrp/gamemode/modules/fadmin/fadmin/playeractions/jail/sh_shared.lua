-- "gamemodes\\darkrp\\gamemode\\modules\\fadmin\\fadmin\\playeractions\\jail\\sh_shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
FAdmin.PlayerActions.JailTypes = {}
FAdmin.PlayerActions.JailTypes[1] = "Small"
FAdmin.PlayerActions.JailTypes[2] = "Normal"
FAdmin.PlayerActions.JailTypes[3] = "Big"
FAdmin.PlayerActions.JailTypes[4] = "Unjail"

hook.Add("CanTool", "FAdmin_jailed", function(ply) -- shared so it doesn't look like you can use tool
    if ply:FAdmin_GetGlobal("fadmin_jailed") then
        return false
    end
end)

hook.Add("PlayerNoClip", "FAdmin_jail", function(ply)
    if ply:FAdmin_GetGlobal("fadmin_jailed") then
        return false
    end
end)

FAdmin.StartHooks["Jailing"] = function()

end
