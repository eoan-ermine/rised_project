-- "addons\\rised_craft_system\\lua\\entities\\rcs_craftmachine_panel\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName= "Станок панель"
ENT.Author= "D-Rised"
ENT.Purpose		= ""
ENT.Instructions= ""
ENT.Category		= "A - Rised - [Крафт]"

ENT.Editable		= true
ENT.Spawnable		= true
ENT.AdminOnly		= true

local recycleItems = {
    "rcs_ing_wep_barrel5x45",
    "rcs_ing_wep_barrel7x62",
    "rcs_ing_wep_barrel9x19",
    "rcs_ing_wep_barrel9x39",
    "rcs_ing_wep_barrel10x33",
    "rcs_ing_wep_barrel18x5",
    "rcs_ing_wep_block_trigger",
    "rcs_ing_wep_forend_pst",
    "rcs_ing_wep_gas_cutoff_reflector",
    "rcs_ing_wep_gas_tube",
    "rcs_ing_wep_shutter_bt",
    "rcs_ing_wep_shutter_ejector_trigger",
    "rcs_ing_wep_shutter_pst",
    "rcs_ing_wep_shutter_rt",
    "rcs_ing_wep_spring",
    "rcs_ing_wep_usm_c",
    "rcs_ing_wep_usm_x1",
    "rcs_ing_wep_usm_x2",
    "rcs_ing_ammo_bullet",
    "rcs_ing_ammo_sleeve",
    "rcs_ing_ammo_powder",
}