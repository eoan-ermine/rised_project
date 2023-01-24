-- "addons\\darkrpmodification\\lua\\darkrp_customthings\\shipments.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[---------------------------------------------------------------------------
DarkRP custom shipments and guns
---------------------------------------------------------------------------

This file contains your custom shipments and guns.
This file should also contain shipments and guns from DarkRP that you edited.

Note: If you want to edit a default DarkRP shipment, first disable it in darkrp_config/disabled_defaults.lua
    Once you've done that, copy and paste the shipment to this file and edit it.

The default shipments and guns can be found here:
https://github.com/FPtje/DarkRP/blob/master/gamemode/config/addentities.lua

For examples and explanation please visit this wiki page:
http://wiki.darkrp.com/index.php/DarkRP:CustomShipmentFields


Add shipments and guns under the following line:
---------------------------------------------------------------------------]]


DarkRP.createShipment("Документ", {
    model = "models/props_lab/clipboard.mdl",
    entity = "weapon_notepad",
    price = 150,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 1,
    separate = true,
    pricesep = 500,
    noship = true,
})

DarkRP.createShipment("Physics Gun", {
    model = "models/weapons/w_physics.mdl",
    entity = "weapon_physgun",
    price = 250,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 1,
    separate = true,
    pricesep = 250,
    noship = true
})
DarkRP.createShipment("Tool Gun", {
    model = "models/weapons/w_toolgun.mdl",
    entity = "gmod_tool",
    price = 250,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 1,
    separate = true,
    pricesep = 250,
    noship = true
})

-- Illegal ---

DarkRP.createShipment("Рация", {
    model = "models/radio/w_radio.mdl",
    entity = "wep_jack_job_drpradio",
    price = 25,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 2,
    separate = true,
    pricesep = 3,
    noship = true,
    allowed = {TEAM_REBELNEWBIE, TEAM_REBELSOLDAT, TEAM_REBELENGINEER, TEAM_REBELMEDIC, TEAM_REBELSPY02, TEAM_REBEL_VETERAN, TEAM_REBELSPY01, TEAM_REBELJUGGER, TEAM_REBELLEADER, TEAM_LAMBDASOLDAT, TEAM_LAMBDASNIPER, TEAM_LAMBDACOMMANDER}
})

DarkRP.createShipment("Beta-декриптор N-7", {
    model = "models/props_junk/cardboard_box004a.mdl",
    entity = "weapon_decryptor",
    price = 400,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 1,
    separate = true,
    pricesep = 5,
    noship = true,
    allowed = {TEAM_REBELENGINEER}
})

-- Ungun --
DarkRP.createShipment("Лом", {
    model = "models/weapons/w_crowbar.mdl",
    entity = "weapon_crowbar",
    price = 25,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 2,
    separate = false,
    noship = false,
    allowed = {TEAM_REBELLEADER}
})
DarkRP.createShipment("Pistol", {
    model = "models/weapons/w_pistol.mdl",
    entity = "swb_pistol",
    price = 4000,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 1,
    separate = false,
    noship = false,
    allowed = {TEAM_GMAN}
})
DarkRP.createShipment("Magnum", {
    model = "models/weapons/w_357.mdl",
    entity = "swb_357",
    price = 4000,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 1,
    separate = false,
    noship = false,
    allowed = {TEAM_GMAN}
})
DarkRP.createShipment("Shotgun", {
    model = "models/weapons/w_shotgun.mdl",
    entity = "swb_shotgun",
    price = 9000,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 1,
    separate = false,
    noship = false,
    allowed = {TEAM_GMAN}
})
DarkRP.createShipment("SMG", {
    model = "models/weapons/w_smg1.mdl",
    entity = "swb_smg",
    price = 9000,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 1,
    separate = false,
    noship = false,
    allowed = {TEAM_GMAN}
})
DarkRP.createShipment("I-Rifle", {
    model = "models/weapons/w_irifle.mdl",
    entity = "swb_irifle",
    price = 15000,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 1,
    separate = false,
    noship = false,
    allowed = {TEAM_GMAN}
})
DarkRP.createShipment("Crossbow", {
    model = "models/weapons/w_crossbow.mdl",
    entity = "weapon_crossbow",
    price = 25000,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 1,
    separate = false,
    noship = false,
    allowed = {TEAM_GMAN}
})
DarkRP.createShipment("RPG", {
    model = "models/weapons/w_rocket_launcher.mdl",
    entity = "weapon_rpg",
    price = 50000,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 1,
    separate = false,
    noship = false,
    allowed = {TEAM_GMAN}
})
DarkRP.createShipment("Combine Sniper", {
    model = "models/weapons/w_rocket_launcher.mdl",
    entity = "weapon_csniper",
    price = 50000,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 1,
    separate = false,
    noship = false,
    allowed = {TEAM_GMAN}
})

DarkRP.createShipment("Отмычка для взлома", {
    model = "models/props_c17/TrapPropeller_Lever.mdl",
    entity = "weapon_lockpick_shot",
    price = 100,
    pricesep = 250,
    getPrice = function(ply, price) return (ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") and price * 0.85 or price end,
    amount = 10,
    separate = true,
    noship = false,
    allowed = TEAM_THEIF
})
