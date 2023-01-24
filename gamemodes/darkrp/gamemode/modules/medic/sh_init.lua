-- "gamemodes\\darkrp\\gamemode\\modules\\medic\\sh_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local plyMeta = FindMetaTable("Player")
plyMeta.isMedic = fn.Compose{fn.Curry(fn.GetValue, 2)("medic"), plyMeta.getJobTable}
