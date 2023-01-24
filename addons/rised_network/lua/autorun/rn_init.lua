-- "addons\\rised_network\\lua\\autorun\\rn_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

rnet = {}

if (SERVER) then
    include("risednetwork/sv_risednetwork.lua")
end

AddCSLuaFile("risednetwork/cl_risednetwork.lua")
if (CLIENT) then
    include("risednetwork/cl_risednetwork.lua")
end