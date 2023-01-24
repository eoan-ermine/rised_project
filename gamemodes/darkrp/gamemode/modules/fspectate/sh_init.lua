-- "gamemodes\\darkrp\\gamemode\\modules\\fspectate\\sh_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not CAMI then return end

CAMI.RegisterPrivilege{
    Name = "FSpectate",
    MinAccess = "admin"
}

CAMI.RegisterPrivilege{
    Name = "FSpectateTeleport",
    MinAccess = "admin"
}
