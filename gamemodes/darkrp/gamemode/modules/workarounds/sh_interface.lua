-- "gamemodes\\darkrp\\gamemode\\modules\\workarounds\\sh_interface.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
DarkRP.getAvailableVehicles = DarkRP.stub{
    name = "getAvailableVehicles",
    description = "Get the available vehicles that DarkRP supports.",
    parameters = {
    },
    returns = {
        {
            name = "vehicles",
            description = "Names, models and classnames of all supported vehicles.",
            type = "table"
        }
    },
    metatable = DarkRP
}
