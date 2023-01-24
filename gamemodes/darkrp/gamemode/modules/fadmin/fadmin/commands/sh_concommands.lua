-- "gamemodes\\darkrp\\gamemode\\modules\\fadmin\\fadmin\\commands\\sh_concommands.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
FAdmin.Commands = {}
FAdmin.Commands.List = {}

function FAdmin.Commands.AddCommand(name, callback, ...)
    FAdmin.Commands.List[string.lower(name)] = {callback = callback, ExtraArgs = {...}}
end
