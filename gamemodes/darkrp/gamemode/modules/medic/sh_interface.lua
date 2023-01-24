-- "gamemodes\\darkrp\\gamemode\\modules\\medic\\sh_interface.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
DarkRP.PLAYER.isMedic = DarkRP.stub{
    name = "isMedic",
    description = "Whether this player is a medic.",
    parameters = {
    },
    returns = {
        {
            name = "answer",
            description = "Whether this player is a medic.",
            type = "boolean"
        }
    },
    metatable = DarkRP.PLAYER
}
