-- "addons\\darkrpmodification\\lua\\darkrp_config\\settings.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[-------------------------------------------------------------------------
DarkRP config settings.
-----------------------------------------------------------------------------

This is the settings file of DarkRP. Every DarkRP setting is listed here.

Warning:
If this file is missing settings (because of e.g. an update), DarkRP will assume default values for these settings.
You need not worry about updating this file. If a new setting is added you can manually add them to this file.
---------------------------------------------------------------------------]]


--[[
Toggle settings.
Set to true or false.
]]

-- voice3D - Enable/disable 3DVoice is enabled.
GM.Config.voice3D                       = true
-- AdminsCopWeapons - Enable/disable admins spawning with cop weapons.
GM.Config.AdminsCopWeapons              = false
-- adminBypassJobCustomCheck - Enable/disable whether an admin can force set a job with whenever customCheck returns false.
GM.Config.adminBypassJobRestrictions    = false
-- allow people getting their own custom jobs.
GM.Config.allowjobswitch                = false
-- allowrpnames - Allow Players to Set their RP names using the /rpname command.
GM.Config.allowrpnames                  = true
-- allowsprays - Enable/disable the use of sprays on the server.
GM.Config.allowsprays                   = false
-- allowvehicleowning - Enable/disable whether people can own vehicles.
GM.Config.allowvehicleowning            = true
-- allowvnocollide - Enable/disable the ability to no-collide a vehicle (for security).
GM.Config.allowvnocollide               = false
-- alltalk - Enable for global chat, disable for local chat.
GM.Config.alltalk                       = false
-- antimultirun - Disallow people joining your server(s) twice on the same account.
GM.Config.antimultirun                  = true
-- autovehiclelock - Enable/Disable automatic locking of a vehicle when a player exits it.
GM.Config.autovehiclelock               = false
-- babygod - people spawn godded (prevent spawn killing).
GM.Config.babygod                       = true
-- canforcedooropen - whether players can force an unownable door open with lockpick or battering ram or w/e.
GM.Config.canforcedooropen              = true
-- chatsounds - sounds are played when some things are said in chat.
GM.Config.chatsounds                    = false
-- chiefjailpos - Allow the Chief to set the jail positions.
GM.Config.chiefjailpos                  = false
-- cit_propertytax - Enable/disable property tax that is exclusive only for citizens.
GM.Config.cit_propertytax               = false
-- copscanunfreeze - Enable/disable the ability of cops to unfreeze other people's props.
GM.Config.copscanunfreeze               = true
-- copscanunweld - Enable/disable the ability of cops to unweld other people's props.
GM.Config.copscanunweld                 = false
-- cpcanarrestcp - Allow/Disallow CPs to arrest other CPs.
GM.Config.cpcanarrestcp                 = false
-- currencyLeft - The position of the currency symbol. true for left, false for right.
GM.Config.currencyLeft                  = true
-- customjobs - Enable/disable the /job command (personalized job names).
GM.Config.customjobs                    = true
-- customspawns - Enable/disable whether custom spawns should be used.
GM.Config.customspawns                  = true
-- deathblack - Whether or not a player sees black on death.
GM.Config.deathblack                    = false
-- showdeaths - Display kill information in the upper right corner of everyone's screen.
GM.Config.showdeaths                    = false
-- deadtalk - Enable/disable whether people talk and use commands while dead.
GM.Config.deadtalk                      = true
-- deadvoice - Enable/disable whether people talk through the microphone while dead.
GM.Config.deadvoice                     = false
-- deathpov - Enable/disable whether people see their death in first person view.
GM.Config.deathpov                      = true
-- decalcleaner - Enable/Disable clearing ever players decals.
GM.Config.decalcleaner                  = false
-- disallowClientsideScripts - Clientside scripts can be very useful for customizing the HUD or to aid in building. This option bans those scripts.
GM.Config.disallowClientsideScripts     = false
-- doorwarrants - Enable/disable Warrant requirement to enter property.
GM.Config.doorwarrants                  = false
-- dropmoneyondeath - Enable/disable whether people drop money on death.
GM.Config.dropmoneyondeath              = false
-- droppocketarrest - Enable/disable whether people drop the stuff in their pockets when they get arrested.
GM.Config.droppocketarrest              = false
-- droppocketdeath - Enable/disable whether people drop the stuff in their pockets when they die.
GM.Config.droppocketdeath               = true
-- dropweapondeath - Enable/disable whether people drop their current weapon when they die.
GM.Config.dropweapondeath               = false
-- Whether players can drop the weapons they spawn with.
GM.Config.dropspawnedweapons            = true
-- dynamicvoice - Enable/disable whether only people in the same room as you can hear your mic.
GM.Config.dynamicvoice                  = true
-- earthquakes - Enable/disable earthquakes.
GM.Config.earthquakes                   = false
-- enablebuypistol - Turn /buy on of off.
GM.Config.enablebuypistol               = true
-- enforceplayermodel - Whether or not to force players to use their role-defined character models.
GM.Config.enforceplayermodel            = true
-- globalshow - Whether or not to display player info above players' heads in-game.
GM.Config.globalshow                    = false
-- ironshoot - Enable/disable whether people need iron sights to shoot.
GM.Config.ironshoot                     = true
-- showjob - Whether or not to display a player's job above their head in-game.
GM.Config.showjob                       = false
-- letters - Enable/disable letter writing / typing.
GM.Config.letters                       = true
-- license - Enable/disable People need a license to be able to pick up guns.
GM.Config.license                       = false
-- lockdown - Enable/Disable initiating lockdowns for mayors.
GM.Config.lockdown                      = true
-- lockpickfading - Enable/disable the lockpicking of fading doors.
GM.Config.lockpickfading                = true
-- logging - Enable/disable logging everything that happens.
GM.Config.logging                       = true
-- lottery - Enable/disable creating lotteries for mayors.
GM.Config.lottery                       = false
-- showname - Whether or not to display a player's name above their head in-game.
GM.Config.showname                      = false
-- showhealth - Whether or not to display a player's health above their head in-game.
GM.Config.showhealth                    = false
-- needwantedforarrest - Enable/disable Cops can only arrest wanted people.
GM.Config.needwantedforarrest           = false
-- noguns - Enabling this feature bans Guns and Gun Dealers.
GM.Config.noguns                        = false
-- norespawn - Enable/Disable that people don't have to respawn when they change job.
GM.Config.norespawn                     = true
-- npcarrest - Enable/disable arresting npc's.
GM.Config.npcarrest                     = true
-- ooc - Whether or not OOC tags are enabled.
GM.Config.ooc                           = true
-- propertytax - Enable/disable property tax.
GM.Config.propertytax                   = false
-- proppaying - Whether or not players should pay for spawning props.
GM.Config.proppaying                    = false
-- propspawning - Enable/disable props spawning. Applies to admins too.
GM.Config.propspawning                  = true
-- removeclassitems - Enable/disable shipments/microwaves/etc. removal when someone changes team.
GM.Config.removeclassitems              = false
-- removeondisconnect - Enable/disable shipments/microwaves/etc. removal when someone disconnects.
GM.Config.removeondisconnect            = true
-- respawninjail - Enable/disable whether people can respawn in jail when they die.
GM.Config.respawninjail                 = false
-- restrictallteams - Enable/disable Players can only be citizen until an admin allows them.
GM.Config.restrictallteams              = false
-- restrictbuypistol - Enabling this feature makes /buy available only to Gun Dealers.
GM.Config.restrictbuypistol             = false
-- restrictdrop - Enable/disable restricting the weapons players can drop. Setting this to true disallows weapons from shipments from being dropped.
GM.Config.restrictdrop                  = false
-- revokeLicenseOnJobChange - Whether licenses are revoked when a player changes jobs.
GM.Config.revokeLicenseOnJobChange      = true
-- shouldResetLaws - Enable/Disable resetting the laws back to the default law set when the mayor changes.
GM.Config.shouldResetLaws               = false
-- strictsuicide - Whether or not players should spawn where they suicided.
GM.Config.strictsuicide                 = false
-- telefromjail - Enable/disable teleporting from jail.
GM.Config.telefromjail                  = true
-- teletojail - Enable/disable teleporting to jail.
GM.Config.teletojail                    = false
-- unlockdoorsonstart - Enable/Disable unlocking all doors on map start.
GM.Config.unlockdoorsonstart            = true
-- voiceradius - Enable/disable local voice chat.
GM.Config.voiceradius                   = true
-- tax - Whether players pay taxes on their wallets.
GM.Config.wallettax                     = false
-- wantedsuicide - Enable/Disable suiciding while you are wanted by the police.
GM.Config.wantedsuicide                 = false
-- realisticfalldamage - Enable/Disable dynamic fall damage. Setting mp_falldamage to 1 will over-ride this.
GM.Config.realisticfalldamage           = true
-- printeroverheat - Whether the default money printer can overheat on its own.
GM.Config.printeroverheat               = true
-- weaponCheckerHideDefault - Hide default weapons when checking weapons.
GM.Config.weaponCheckerHideDefault      = true
-- weaponCheckerHideNoLicense - Hide weapons that do not require a license.
GM.Config.weaponCheckerHideNoLicense    = false

--[[
Value settings
]]
-- adminnpcs - Whether or not NPCs should be admin only. 0 = everyone, 1 = admin or higher, 2 = superadmin or higher, 3 = rcon only
GM.Config.adminnpcs                     = 2
-- adminsents - Whether or not SENTs should be admin only. 0 = everyone, 1 = admin or higher, 2 = superadmin or higher, 3 = rcon only
GM.Config.adminsents                    = 2
-- adminvehicles - Whether or not vehicles should be admin only. 0 = everyone, 1 = admin or higher, 2 = superadmin or higher, 3 = rcon only
GM.Config.adminvehicles                 = 2
-- adminweapons - Who can spawn weapons: 0: admins only, 1: supadmins only, 2: no one, 3: everyone
GM.Config.adminweapons                  = 1
-- arrestspeed - Sets the max arrest speed.
GM.Config.arrestspeed                   = 180
-- babygodtime - How long the babygod lasts.
GM.Config.babygodtime                   = 5
-- chatsoundsdelay - How long to wait before letting a player emit a sound from their chat again.
-- Leave this on at least a few seconds to prevent people from spamming sounds. Set to 0 to disable.
GM.Config.chatsoundsdelay               = 5
-- deathfee - the amount of money someone drops when dead.
GM.Config.deathfee                      = 30
-- decaltimer - Sets the time to clear clientside decals (in seconds).
GM.Config.decaltimer                    = 120
-- demotetime - Number of seconds before a player can rejoin a team after demotion from that team.
GM.Config.demotetime                    = 1200
-- doorcost - Sets the cost of a door.
GM.Config.doorcost                      = 10
-- entremovedelay - how long to wait before removing a bought entity after disconnect.
GM.Config.entremovedelay                = 1
-- gunlabweapon - The weapon that the gunlab spawns.
GM.Config.gunlabweapon                  = "weapon_p2282"
-- jailtimer - Sets the jailtimer (in seconds).
GM.Config.jailtimer                     = 120
-- lockdowndelay - The amount of time a mayor must wait before starting the next lockdown.
GM.Config.lockdowndelay                 = 10
-- maxadvertbillboards - The maximum number of /advert billboards a player can place.
GM.Config.maxadvertbillboards           = 0
-- maxdoors - Sets the max amount of doors one can own.
GM.Config.maxdoors                      = 20
-- maxdrugs - Sets max drugs.
GM.Config.maxdrugs                      = 2
-- maxfoods - Sets the max food cartons per Microwave owner.
GM.Config.maxfoods                      = 2
-- maxfooditems - Sets the max amount of food items a player can buy from the F4 menu.
GM.Config.maxfooditems                  = 20
-- maxlawboards - The maximum number of law boards the mayor can place.
GM.Config.maxlawboards                  = 2
-- maxletters - Sets max letters.
GM.Config.maxletters                    = 0
-- maxlotterycost - Maximum payment the mayor can set to join a lottery.
GM.Config.maxlotterycost                = 250
-- maxvehicles - Sets how many vehicles one can buy.
GM.Config.maxvehicles                   = 5
-- microwavefoodcost - Sets the sale price of Microwave Food.
GM.Config.microwavefoodcost             = 30
-- minlotterycost - Minimum payment the mayor can set to join a lottery.
GM.Config.minlotterycost                = 30
-- Money packets will get removed if they don't get picked up after a while. Set to 0 to disable.
GM.Config.moneyRemoveTime               = 600
-- mprintamount - Value of the money printed by the money printer.
GM.Config.mprintamount                  = 250
-- normalsalary - Sets the starting salary for newly joined players.
GM.Config.normalsalary                  = 45
-- npckillpay - Sets the money given for each NPC kill.
GM.Config.npckillpay                    = 0
-- paydelay - Sets how long it takes before people get salary.
GM.Config.paydelay                      = 600
-- pocketitems - Sets the amount of objects the pocket can carry.
GM.Config.pocketitems                   = 10
-- pricecap - The maximum price of items (using /price).
GM.Config.pricecap                      = 500
-- pricemin - The minimum price of items (using /price).
GM.Config.pricemin                      = 50
-- propcost - How much prop spawning should cost (prop paying must be enabled for this to have an effect).
GM.Config.propcost                      = 10
-- quakechance - Chance of an earthquake happening.
GM.Config.quakechance                   = 4000
-- respawntime - Minimum amount of seconds a player has to wait before respawning.
GM.Config.respawntime                   = 1
-- changejobtime - Minimum amount of seconds a player has to wait before changing job.
GM.Config.changejobtime                 = 0
-- runspeed - Sets the max running speed.
GM.Config.runspeed                      = 240
-- runspeed - Sets the max running speed for CP teams.
GM.Config.runspeedcp                    = 255
-- searchtime - Number of seconds for which a search warrant is valid.
GM.Config.searchtime                    = 30
-- ShipmentSpawnTime - Antispam time between spawning shipments.
GM.Config.ShipmentSpamTime              = 3
-- shipmenttime - The number of seconds it takes for a shipment to spawn.
GM.Config.shipmentspawntime             = 10
-- startinghealth - the health when you spawn.
GM.Config.startinghealth                = 50
-- startingmoney - your wallet when you join for the first time.
GM.Config.startingmoney                 = 100
-- vehiclecost - Sets the cost of a vehicle (To own it).
GM.Config.vehiclecost                   = 40
-- wallettaxmax - Maximum percentage of tax to be paid.
GM.Config.wallettaxmax                  = 5
-- wallettaxmin - Minimum percentage of tax to be paid.
GM.Config.wallettaxmin                  = 1
-- wallettaxtime - Time in seconds between taxing players. Requires server restart.
GM.Config.wallettaxtime                 = 600
-- wantedtime - Number of seconds for which a player is wanted for.
GM.Config.wantedtime                    = 86400
-- walkspeed - Sets the max walking speed.
GM.Config.walkspeed                     = 160
-- falldamagedamper - The damper on realistic fall damage. Default is 15. Decrease this for more damage.
GM.Config.falldamagedamper              = 11
-- falldamageamount - The base damage taken from falling for static fall damage. Default is 10.
GM.Config.falldamageamount              = 22
-- printeroverheatchance - The likelyhood of a printer overheating. The higher this number, the less likely (minimum 3, default 22).
GM.Config.printeroverheatchance         = 22
-- printerreward - Reward for destroying a money printer.
GM.Config.printerreward                 = 950

--[[---------------------------------------------------------------------------
Chat distance settings
Distance is in source units (similar to inches)
---------------------------------------------------------------------------]]
GM.Config.talkDistance    = 350
GM.Config.whisperDistance = 90
GM.Config.yellDistance    = 750
GM.Config.meDistance      = 250
GM.Config.voiceDistance   = 750

--[[---------------------------------------------------------------------------
Other settings
---------------------------------------------------------------------------]]

-- The classname of money packets. Use this to create your own money entity!
-- Note: the money packet must support the "Setamount" method (or the amount DTVar).
GM.Config.MoneyClass = "spawned_money"
-- In case you do wish to keep the default money, but change the model, this option is the way to go:
GM.Config.moneyModel = "models/bioshockinfinite/hext_coin.mdl"
-- You can set your own, custom sound to be played for all players whenever a lockdown is initiated.
-- Note: Remember to include the folder where the sound file is located.
GM.Config.lockdownsound = "hl2russian/combine/overwatch/cityvoice/f_anticivilevidence_3_spkr.wav"

-- The skin DarkRP uses. Set to "default" to use the GMod default derma theme.
GM.Config.DarkRPSkin = "DarkRP"
GM.Config.currency = "T. "
GM.Config.chatCommandPrefix = "/"
GM.Config.F1MenuHelpPage = "https://docs.google.com/document/d/10pvotowOA3EA7K5BMgdaKVOYjbrbx6dxrQn4LWxm30A/edit#heading=h.e5iaqteza8x7"
GM.Config.F1MenuHelpPageTitle = "Server tips"

-- Put Steam ID's and ranks in this list, and the players will have that rank when they join.
GM.Config.DefaultPlayerGroups = {
    ["STEAM_0:0:00000000"] = "superadmin",
    ["STEAM_0:0:11111111"] = "admin",
}

-- Custom modules in this addon that are disabled.
GM.Config.DisabledCustomModules = {
       ["hudreplacement"] = false,
       ["extraf4tab"] = false,
}

-- The list of weapons that players are not allowed to drop. Items set to true are not allowed to be dropped.
GM.Config.DisallowDrop = {
    ["weapon_physgun"] = true,
    ["gmod_tool"] = true,
    ["re_hands"] = true,
    ["arrest_stick"] = true,
    ["door_ram"] = true,
    ["keys"] = true,
    ["med_kit"] = true,
    ["weapon_medkit"] = true,
    ["pocket"] = true,
    ["stunstick"] = true,
    ["unarrest_stick"] = true,
    ["weapon_keypadchecker"] = true,
    ["weaponchecker"] = true,
	["weapon_r_handcuffs"] = true,
	["weapon_weapons_zombine"] = true,
	["weapon_weapons_fastzombie"] = true,
	["weapon_weapons_zombie"] = true,
	["id"] = true,
	["weapon_combinestunstick"] = true,
	["stungun"] = true,
	["swep_pickpocket"] = true,
	["weapon_spy"] = true,
	["weapon_hoboinfection"] = true,
	["weapon_stalkerisation"] = true,
	["fine_list"] = true,
	["weapon_demote"] = true,
	["weapon_fists"] = true,
	["weapon_controllable_city_scanner"] = true,
	["stalkerlaser"] = true,
	["weapon_suitcharger"] = true,
	["weapon_mpfofficerup"] = true,
	["weapon_mpfcommissarhelixup"] = true,
	["weapon_mpfcommissargridup"] = true,
	["weapon_mpfcommissarjudgeup"] = true,
	["weapon_mpfcuratorup"] = true,
	["weapon_mpfinfestationup"] = true,
	["med_reviver"] = true,
	["med_reviver_admin"] = true,
	["tbfy_surrendered"] = true,
	["weapon_r_cuffed"] = true,
	["weapon_r_handcuffs"] = true,
	["comlink_swep"] = true,
	["cross_arms_swep"] = true,
	["cross_arms_infront_swep"] = true,
	["high_five_swep"] = true,
	["hololink_swep"] = true,
	["middlefinger_animation_swep"] = true,
	["point_in_direction_swep"] = true,
	["salute_swep"] = true,
	["surrender_animation_swep"] = true,
	["weapon_cp_stick"] = true,
	["weapon_combine_config"] = true,
	["omnishield"] = true,
	["itemstore_pickup"] = true,
	["itemstore_checker"] = true,
	["weapon_slam"] = true,
	["weapon_frag"] = true,
	["weapon_rpg"] = true,
	["weapon_crossbow"] = true,
	["weapon_chipchipota"] = true,
	["bcs_storage"] = true,
	["bcs_axe"] = true,
	["bcs_pickaxe"] = true,
	["weapon_cwusalary"] = true,
	["wep_jack_job_drpradio"] = true,
	["weapon_rank_combine"] = true,
	["weapon_animal_crow"] = true,
	["weapon_weapons_jeff"] = true,
	["weapon_rebelup"] = true,
	["weapon_crafting_tool"] = true,
	["weapon_mafia"] = true,
	["weapon_synth_cremator"] = true,
	["weapon_synth_guard"] = true,
    ["weapon_medical_scanner"] = true,
}

-- The list of weapons people spawn with.
GM.Config.DefaultWeapons = {
    "keys",
}

-- Override categories.
-- NOTE: categories are to be set in the "category" field of the custom jobs/shipments/entities/ammo/pistols/vehicles.
-- Use this only to override the categories of _default_ things.
-- This will NOT work for your own custom stuff.
-- Make sure the category is created in the darkrp_customthings/categories.lua, otherwise it won't work!
GM.Config.CategoryOverride = {
    jobs = {
        ["Citizen"]                             = "Citizens",
        ["Hobo"]                                = "Citizens",
        ["Gun Dealer"]                          = "Citizens",
        ["Medic"]                               = "Citizens",
        ["Civil Protection"]                    = "Civil Protection",
        ["Gangster"]                            = "Gangsters",
        ["Mob boss"]                            = "Gangsters",
        ["Civil Protection Chief"]              = "Civil Protection",
        ["Mayor"]                               = "Civil Protection",
    },
    entities = {
        ["Drug lab"]                            = "Other",
        ["Money printer"]                       = "Other",
        ["Gun lab"]                             = "Other",

    },
    shipments = {
        ["AK47"]                                = "Rifles",
        ["MP5"]                                 = "Rifles",
        ["M4"]                                  = "Rifles",
        ["Mac 10"]                              = "Other",
        ["Pump shotgun"]                        = "Shotguns",
        ["Sniper rifle"]                        = "Snipers",

    },
    weapons = {
        ["Desert eagle"]                        = "Pistols",
        ["Fiveseven"]                           = "Pistols",
        ["Glock"]                               = "Pistols",
        ["P228"]                                = "Pistols",
    },
    vehicles = {}, -- There are no default vehicles.
    ammo = {
        ["Pistol ammo"]                         = "Other",
        ["Shotgun ammo"]                        = "Other",
        ["Rifle ammo"]                          = "Other",
    },
}

-- The list of weapons admins spawn with, in addition to the default weapons, a job's weapons and GM.Config.AdminsCopWeapons.
GM.Config.AdminWeapons = {
    "weapon_keypadchecker",
}

-- These are the default laws, they're unchangeable in-game.
GM.Config.DefaultLaws = {

}

GM.Config.PocketBlacklist = {
    ["fadmin_jail"] = true,
    ["meteor"] = true,
    ["door"] = true,
    ["func_"] = true,
    ["player"] = true,
    ["beam"] = true,
    ["worldspawn"] = true,
    ["env_"] = true,
    ["path_"] = true,
    ["prop_physics"] = true,
    ["money_printer"] = true,
    ["gunlab"] = true,
    ["prop_dynamic"] = true,
    ["prop_vehicle_prisoner_pod"] = true,
    ["keypad_wire"] = true,
    ["gmod_button"] = true,
    ["gmod_rtcameraprop"] = true,
    ["gmod_cameraprop"] = true,
    ["gmod_dynamite"] = true,
    ["gmod_thruster"] = true,
    ["gmod_light"] = true,
    ["gmod_lamp"] = true,
    ["gmod_emitter"] = true,
	["eml_redp"] = true,
	["eml_redp2"] = true,
	["eml_redp3"] = true,
	["eml_redp4"] = true,
	["eml_redp5"] = true,
	["eml_meth"] = true,
	["eml_rubbish01"] = true,
	["eml_rubbish02"] = true,
	["eml_rubbish03"] = true,
	["eml_rubbish04"] = true,
	["eml_rubbish05"] = true,
	["eml_rubbish06"] = true,
	["eml_rubbish07"] = true,
	["eml_rubbish08"] = true,
	["rrs_emptyfood"] = true,
	["combine_dispenser"] = true,
	["spawned_shipment"] = true,
	["empty_shipment"] = true,
	["ammoboxes_medium"] = true,
	["combine_armory"] = true,
	["combine_armory2"] = true,
	["changename_notebook"] = true,
	["combine_idcardsystemcore"] = true,
	["rebel_logoplacement"] = true,
	["gw_health_station"] = true,
	["hl2_fire"] = true,
	["npc_jailer"] = true,
	["npc_bailer"] = true,
	["clothes_wardrobe"] = true,
	["gas_canister"] = true,
	["keypad"] = true,
	["keypad_wire"] = true,
	["fm_crate"] = true,
	["fm_plant2"] = true,
	["rubbish_food"] = true,	
	["rubbish_food2"] = true,
	["rubbish_food3"] = true,
	["rubbish_food4"] = true,
	["rubbish_food5"] = true,
	["rubbish_food6"] = true,
	["stormfox_parklight"] = true,
	["stormfox_streetlight_invisible"] = true,
	["stormfox_streetlight"] = true,
	["stormfox_weekweather"] = true,
	["eml_spot"] = true,
	["uweed_light_big"] = true,
	["uweed_plant"] = true,
	["cuw_rationbox"] = true,
	["cuw_dispenser_button01"] = true,
	["cuw_dispenser_button02"] = true,
	["cuw_dispenser_button03"] = true,
	["cuw_dispenser_button04"] = true,
	["cuw_component_water"] = true,
	["cuw_component_meat"] = true,
	["cuw_component_enzymes"] = true,
	["cuw_component_meat_raw"] = true,
	["cuw_component_enzymes_raw"] = true,
	["cuw_component_meat_detoxin"] = true,
	["cuw_component_meat_stove"] = true,
	["lp2_shop_dev"] = true,
	["lp2_armor_1"] = true,
	["lp2_armor_2"] = true,
	["lp2_armor_3"] = true,
	["lp2_cooler_1"] = true,
	["lp2_cooler_2"] = true,
	["lp2_cooler_3"] = true,
	["lp2_overclocker_1"] = true,
	["lp2_overclocker_2"] = true,
	["lp2_overclocker_3"] = true,
	["lp2_power_1"] = true,
	["lp2_power_2"] = true,
	["lp2_power_3"] = true,
	["lp2_printer_1"] = true,
	["lp2_printer_2"] = true,
	["lp2_printer_3"] = true,
	["lp2_printer_4"] = true,
	["lp2_printer_5"] = true,
	["lp2_printer_6"] = true,
	["lp2_rack_armor_large"] = true,
	["lp2_rack_armor_small"] = true,
	["lp2_rack_fan"] = true,
	["lp2_rack_large"] = true,
	["lp2_rack_small"] = true,
	["lp2_rack_small_screen"] = true,
	["lp2_rack_storage"] = true,
	["lp2_shop"] = true,
	["lp2_shop_dev"] = true,
	["lp2_shop_pack"] = true,
	["lp2_shop_pack_small"] = true,
	["lp2_storage_1"] = true,
	["lp2_storage_2"] = true,
	["lp2_storage_3"] = true,
	["city_camera01"] = true,
	["city_camera02"] = true,
	["city_camera03"] = true,
	["camera_button01"] = true,
	["camera_button02"] = true,
	["camera_button03"] = true,
	["rupor_button01"] = true,
	["city_rupor01"] = true,
	["forcefield"] = true,
	["cardterminal"] = true,
	["fieldterminal"] = true,
	["city_miniclock"] = true,
	["city_clockoutdoors"] = true,
	["city_clock"] = true,
	["city_digitalclock"] = true,
	["rwc_materialsbox"] = true,
	["rwc_materials01"] = true,
	["rwc_materials02"] = true,
	["rwc_materials03"] = true,
	["rwc_materials04"] = true,
	["rwc_materials05"] = true,
	["rwc_materials06"] = true,
	["rwc_materials07"] = true,
	["rwc_materials08"] = true,
	["forcefieldrebel"] = true,
	["rwc_workbench"] = true,
	["fieldterminalrebel"] = true,
	["event01_strangesphere"] = true,
	["discord_link"] = true,
	["hoboinfection"] = true,
	["sammyservers_textscreen"] = true,
	["gb_rp_sign"] = true,
	["jukebox"] = true,
	["sent_spawnplatform"] = true,
	["weapon_dogswep"] = true,
}

-- These weapons are classed as 'legal' in the weapon checker and are not stripped when confiscating weapons.
-- This setting is used IN ADDITION to GM.Config.weaponCheckerHideDefault and GM.Config.weaponCheckerHideNoLicense.
-- You should use the former if you want to class the default weapons (GM.Config.DefaultWeapons and, if admin, GM.Config.AdminWeapons) and a player's job weapons as legal.
-- The latter takes GM.NoLicense weapons as legal (see licenseweapons.lua).
-- The format of this config is similar to GM.Config.DisallowDrop.
GM.Config.noStripWeapons = {

}

-- The entities listed here will not be removed when a player changes their job.
-- This only applies when removeclassitems is set to true.
-- Note: entities will only be removed when the player changes to a job that is not allowed to have the entity.
GM.Config.preventClassItemRemoval = {
    ["portable_printer"] = false,
    ["standard_printer"] = false,
    ["printer_repair_kit"] = false,
	["printer_battery_small"] = false,
	["ruby_storage"] = false,
	["printer_failsafe"] = false,
	["printer_silent"] = false,
}

-- Properties set to true are allowed to be used. Values set to false or are missing from this list are blocked.
GM.Config.allowedProperties = {
    remover = false,
    ignite = false,
    extinguish = false,
    keepupright = false,
    gravity = false,
    collision = false,
    skin = false,
    bodygroups = false,
}

--[[---------------------------------------------------------------------------
F4 menu
---------------------------------------------------------------------------]]
-- hide the items that you can't buy and the jobs you can't get (instead of graying them out).
-- this option hides items when you don't have enough money, when the maximum is reached for a job or any other reason.
GM.Config.hideNonBuyable = false

-- Hide only the items that you have the wrong job for (or for which the customCheck says no).
-- When you set this option to true and hideNonBuyable to false, you WILL see e.g. items that are too expensive for you to buy.
-- but you won't see gundealer shipments when you have the citizen job.
GM.Config.hideTeamUnbuyable = false

--[[---------------------------------------------------------------------------
AFK module
---------------------------------------------------------------------------]]
-- The time of inactivity before being demoted.
GM.Config.afkdemotetime = 900
-- Prevent people from spamming AFK.
GM.Config.AFKDelay = 300

--[[---------------------------------------------------------------------------
Hitmenu module
---------------------------------------------------------------------------]]
-- The minimum price for a hit.
GM.Config.minHitPrice = 200
-- The maximum price for a hit.
GM.Config.maxHitPrice = 50000
-- The minimum distance between a hitman and his customer when they make the deal.
GM.Config.minHitDistance = 150
-- The text that tells the player he can press use on the hitman to request a hit.
GM.Config.hudText = "I am a hitman.\nPress E on me to request a hit!"
-- The text above a hitman when he's got a hit.
GM.Config.hitmanText = "Hit\naccepted!"
-- The cooldown time for a hit target (so they aren't spam killed).
GM.Config.hitTargetCooldown = 120
-- How long a customer has to wait to be able to buy another hit (from the moment the hit is accepted).
GM.Config.hitCustomerCooldown = 240

--[[---------------------------------------------------------------------------
Hungermod module
---------------------------------------------------------------------------]]
-- hungerspeed <Amount> - Set the rate at which players will become hungry (2 is the default).
GM.Config.hungerspeed = 0.0925 -- 3 hours = 0.0925, 25 mins = 0.65
-- starverate <Amount> - How much health that is taken away every second the player is starving  (3 is the default).
GM.Config.starverate = 1


