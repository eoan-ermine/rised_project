-- "lua\\autorun\\tfa_ent_atts.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
    include("tfa_ent_atts/server/sv_ent_atts.lua")
end

AddCSLuaFile("tfa_ent_atts/sh_ent_atts.lua")
include("tfa_ent_atts/sh_ent_atts.lua")

AddCSLuaFile("tfa_ent_atts/client/cl_ent_atts.lua")

if CLIENT then
    include("tfa_ent_atts/client/cl_ent_atts.lua")
end