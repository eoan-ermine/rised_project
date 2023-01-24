-- "addons\\rised_permissions\\lua\\autorun\\rp_permissions.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if RISED == null then
	RISED = {}
end

RISED.StuffRanks = {
	["admin_III"] 		= true,
	["admin_II"] 		= true,
	["admin_I"] 		= true,
	["builder"] 		= true,
	["cerber"] 			= true,
	["candidate"] 		= true,
	["sup_moderator"] 	= true,
	["inf_moderator"] 	= true,
	["rec_eventer"] 	= true,
	["inf_eventer"] 	= true,
	["sup_eventer"] 	= true,
	["retinue"] 		= true,
	["hand"] 			= true,
	["superadmin"] 		= true,
	["guard"] 		= true,
}

RISED.AdminRanks = {
	["admin_III"] 	= true,
	["admin_II"] 	= true,
	["admin_I"] 	= true,
	["rec_eventer"] = true,
	["inf_eventer"] = true,
	["sup_eventer"] = true,
	["retinue"] 	= true,
	["hand"] 		= true,
	["superadmin"] 	= true,
}

RISED.EventerRanks = {
	["builder"] 	= true,
	["rec_eventer"] = true,
	["inf_eventer"] = true,
	["sup_eventer"] = true,
	["retinue"] 	= true,
	["hand"] 		= true,
	["superadmin"] 	= true,
}

RISED.TesterRanks = {
	["sup_eventer"] 	= true,
	["tester"] 	= true,
	["hand"] 		= true,
	["superadmin"] 	= true,
}

RISED.ConfigPermission = {
	"STEAM_0:1:38606392",
	"STEAM_0:0:94879790",
	"STEAM_0:0:531433893",
	"STEAM_0:0:81333538",
}

RISED.ConfigPermission = {
	["STEAM_0:1:38606392"] = {"All"},
}

RISED.JobPermission = {
	["STEAM_0:1:38606392"] = {TEAM_PARTYMEMBER, TEAM_MPF_JURY_Conscript, TEAM_REBELSPY02},
	["STEAM_0:0:94879790"] = {TEAM_THEIF},
	["STEAM_0:0:81333538"] = {TEAM_THEIF},

	["STEAM_0:0:509941133"] = {TEAM_PARTYWORKSUPERVISOR, TEAM_WORKER_UNIT, TEAM_REFUGEE, TEAM_MPF_JURY_PVT}, -- Errorkovich
	["STEAM_0:1:96569283"] = {TEAM_PARTYWORKSUPERVISOR}, -- netwalker2014
	["STEAM_0:1:448139875"] = {TEAM_PARTYMEMBER}, -- Microwave
	["STEAM_0:0:456006269"] = {TEAM_PARTYCANDIDATE}, -- Rain
	["STEAM_0:1:37187117"] = {TEAM_PARTYCANDIDATE}, -- Джонни
	["STEAM_0:1:51938417"] = {TEAM_PARTYCANDIDATE}, -- Добрый
	["STEAM_0:0:158747674"] = {TEAM_PARTYCANDIDATE}, -- Gabriell Mirsch

	["STEAM_0:0:40955496"] = {TEAM_MPF_JURY_Conscript}, -- OnePerson
	["STEAM_0:0:458048765"] = {TEAM_MPF_JURY_Conscript}, -- cлендик
	["STEAM_0:1:196695456"] = {TEAM_MPF_JURY_Conscript}, -- Де-фужь
	["STEAM_0:1:128162346"] = {TEAM_MPF_JURY_Conscript}, -- FroGen

	["STEAM_0:0:86080963"] = {TEAM_OWUDISPATCH}, -- Crit
	["STEAM_0:0:531433893"] = {TEAM_MPF_JURY_GEN}, -- Shadow Killer
	["STEAM_0:1:172977823"] = {TEAM_MPF_WATCHER_CPT}, -- Комиссар
	["STEAM_0:1:505742152"] = {TEAM_MPF_ETHERNAL_CPT}, -- CatFireBt
	["STEAM_0:0:179328109"] = {TEAM_MPF_PLUNGER_CPT}, -- GordonFGG
	["STEAM_0:0:187556436"] = {TEAM_MPF_SPIRE_CPT}, -- Brain
	["STEAM_0:1:442398779"] = {TEAM_MPF_JURY_CPT}, -- White Wolf

	["STEAM_0:0:439423231"] = {TEAM_REBEL_COMMANDER}, -- Heinkel
	["STEAM_0:1:162551581"] = {TEAM_REBELNEWBIE}, -- Marauder
	["STEAM_0:1:510301439"] = {TEAM_REBELNEWBIE}, -- PeJlbMeLLLKa
	["STEAM_0:0:18181435"] = {TEAM_REBELSPY02}, -- NOMAD
	["STEAM_0:1:164976119"] = {TEAM_REBELSPY02}, -- Morozilka
	["STEAM_0:0:245939561"] = {TEAM_REBELSPY02}, -- Snaffy

	["STEAM_0:0:19261618"] = {TEAM_REBELENGINEER}, -- Ютубер
	["STEAM_0:1:94289162"] = {TEAM_REBELMEDIC}, -- Его друг
}

function SetJobPermissions()
	RISED.JobPermission = {
		["STEAM_0:1:38606392"] = {TEAM_PARTYMEMBER, TEAM_MPF_JURY_Conscript, TEAM_REBELSPY02},
		["STEAM_0:0:94879790"] = {TEAM_THEIF},
		["STEAM_0:0:81333538"] = {TEAM_THEIF},

		["STEAM_0:0:509941133"] = {TEAM_PARTYWORKSUPERVISOR, TEAM_WORKER_UNIT, TEAM_REFUGEE, TEAM_MPF_JURY_PVT}, -- Errorkovich
		["STEAM_0:1:96569283"] = {TEAM_PARTYWORKSUPERVISOR}, -- netwalker2014
		["STEAM_0:1:448139875"] = {TEAM_PARTYMEMBER}, -- Microwave
		["STEAM_0:0:456006269"] = {TEAM_PARTYCANDIDATE}, -- Rain
		["STEAM_0:1:37187117"] = {TEAM_PARTYCANDIDATE}, -- Джонни
		["STEAM_0:1:51938417"] = {TEAM_PARTYCANDIDATE}, -- Добрый
		["STEAM_0:0:158747674"] = {TEAM_PARTYCANDIDATE}, -- Gabriell Mirsch

		["STEAM_0:0:40955496"] = {TEAM_MPF_JURY_Conscript}, -- OnePerson
		["STEAM_0:0:458048765"] = {TEAM_MPF_JURY_Conscript}, -- cлендик
		["STEAM_0:1:196695456"] = {TEAM_MPF_JURY_Conscript}, -- Де-фужь
		["STEAM_0:1:128162346"] = {TEAM_MPF_JURY_Conscript}, -- FroGen

		["STEAM_0:0:86080963"] = {TEAM_OWUDISPATCH}, -- Crit
		["STEAM_0:0:531433893"] = {TEAM_MPF_JURY_GEN}, -- Shadow Killer
		["STEAM_0:1:172977823"] = {TEAM_MPF_WATCHER_CPT}, -- Комиссар
		["STEAM_0:1:505742152"] = {TEAM_MPF_ETHERNAL_CPT}, -- CatFireBt
		["STEAM_0:0:179328109"] = {TEAM_MPF_PLUNGER_CPT}, -- GordonFGG
		["STEAM_0:0:187556436"] = {TEAM_MPF_SPIRE_CPT}, -- Brain
		["STEAM_0:1:442398779"] = {TEAM_MPF_JURY_CPT}, -- White Wolf

		["STEAM_0:1:175870539"] = {TEAM_REBELLEADER}, -- ynb
		["STEAM_0:0:439423231"] = {TEAM_REBEL_COMMANDER}, -- Heinkel
		["STEAM_0:1:162551581"] = {TEAM_REBELNEWBIE}, -- Marauder
		["STEAM_0:1:510301439"] = {TEAM_REBELNEWBIE}, -- PeJlbMeLLLKa
		["STEAM_0:0:18181435"] = {TEAM_REBELSPY02}, -- NOMAD
		["STEAM_0:1:164976119"] = {TEAM_REBELSPY02}, -- Morozilka
		["STEAM_0:0:245939561"] = {TEAM_REBELSPY02}, -- Snaffy

		["STEAM_0:0:19261618"] = {TEAM_REBELENGINEER}, -- Ютубер
		["STEAM_0:1:94289162"] = {TEAM_REBELMEDIC}, -- Его друг

		["STEAM_0:0:61874033"] = {TEAM_MPF_WATCHER_LT, TEAM_MPF_JURY_CPT, TEAM_MPF_JURY_SGT}, -- Ютубер 2
	}
end

function IsRised_ConfigPermission(ply, config_type)
	if !ply:IsPlayer() then return false end
	if !RISED.ConfigPermission[ply:SteamID()] then return false end
	return table.HasValue(RISED.ConfigPermission[ply:SteamID()], config_type) or table.HasValue(RISED.ConfigPermission[ply:SteamID()], "All") or (RISED.ConfigPermission[ply:SteamID()] and (!config_type or config_type == ""))
end

function IsRisedStuff(ply)
	if !ply:IsPlayer() then return false end
	return RISED.StuffRanks[ply:GetNWString("usergroup")]
end

function IsRisedAdmin(ply)
	if !ply:IsPlayer() then return false end
	return RISED.AdminRanks[ply:GetNWString("usergroup")]
end

function IsRisedEventer(ply)
	if !ply:IsPlayer() then return false end
	return RISED.EventerRanks[ply:GetNWString("usergroup")]
end

	-- DISABLED --
function IsRisedTester(ply)
	if true then return false end
	if !ply:IsPlayer() then return false end
	return RISED.TesterRanks[ply:GetNWString("usergroup")]
end

function HasJobPermisson(ply, team)
	if !ply:IsPlayer() then return false end
	if !istable(RISED.JobPermission[ply:SteamID()]) then return false end
	return table.HasValue(RISED.JobPermission[ply:SteamID()], team) 
end

function RebelsCombinePermission()
	local combines = 1
	local rebels = 0
	for k, v in pairs(player.GetAll()) do
		if v:isCP() then
			combines = combines + 1
		end
		
		if GAMEMODE.Rebels[v:Team()] then
			rebels = rebels + 1
		end
	end
	
	if combines - rebels < 1 then 
		return false
	end
	return true
end

function PartyOnServer()
	local party = false
	for k,v in pairs(player.GetAll()) do
		if GAMEMODE.WorkersPartyJobs[v:Team()] then
			party = true
		end
	end
	return party
end

RISED.OwnerItems = {
	"rdt_tester_sa",
	"rp_dontdesturbrised",
	"furniture_placer",
	"med_reviver",
	"med_reviver_admin",
}

function IsOwner(ply)
	if !ply:IsPlayer() then return end
	return ply:SteamID() == RISED.OwnerId or ply:SteamID() == "STEAM_0:1:38606392"
end

-- Блокировка дюпа тулганом

RISED.ToolBlockEntities = {
	"spawned_money",
	"ent_igs",
}

hook.Add( "CanTool", "DupeBlock", function( ply, tr, toolname, tool, button )
	if (toolname == "advdupe2" or toolname == "duplicator") and IsValid( tr.Entity ) and table.HasValue(RISED.ToolBlockEntities, tr.Entity:GetClass()) then
		return false
	end
end )

CONNECTION_WHITELIST = {
	"STEAM_0:1:38606392", -- Rised
	"STEAM_0:0:1254433", -- HEKP
	"STEAM_0:1:505992859", -- Прокопнев
	"STEAM_0:0:531433893", -- Shadow Killer
	"STEAM_0:0:509941133", -- Errorkovich
	"STEAM_0:0:596424730", -- Errorkovich 2
	"STEAM_0:0:94879790", -- 7Jus
	"STEAM_0:0:149116600", -- Ubh
	"STEAM_0:1:172731275", -- Demid
	"STEAM_0:0:81333538", -- Shpigun
	"STEAM_0:0:245939561", -- Snaffi
	"STEAM_0:0:147184876", -- Onichan
	"STEAM_0:1:224999957", -- Avokado
	"STEAM_0:0:40955496", -- OnePerson
	"STEAM_0:1:505742152", -- CatFireBattle
	"STEAM_0:0:86080963", -- Crit
}

CONNCTION_BLACKLIST = {
	"STEAM_0:0:125666220", -- Fallen
}

hook.Add( "CheckPassword", "Rised_Connection_Whitelist", function( steamid64 )

	local steamid = util.SteamIDFrom64(steamid64)
	
	if table.HasValue(CONNCTION_BLACKLIST, steamid) then
		return false, "Error status: 804."
	end

	-- if !table.HasValue(CONNECTION_WHITELIST, steamid) then
	-- 	return false, "Вас нет в списке ЗБТ!"
	-- end
end)

if SERVER then
	util.AddNetworkString("RisedPermissions_SpawnEntity:Client")
	util.AddNetworkString("RisedPermissions_SpawnEntity:Server")

	DANGEROUS_ENTITIES = {
		"ammo_103x77",
		"swb_ak74",
		"cm_foodburger2",
		"rised_cloth_armor_class2",
		"blackvelvet",
		"medicalcard",
		"weapon_combinedoor_hacker",
		"rebel_turret_placer",
		"weapon_lockpick_shot",
		"combineidcard",
		"cm_orange",
		"cm_can1",
		"cm_can3",
		"cm_can2",
		"cm_banana",
		"cm_bread_sandwich",
		"cm_sandwich",
		"cm_water",
		"cm_pear",
		"rp_soda",
		"cm_foodburger2",
		"cm_foodbacon2",
		"cm_fishcooked",
		"cm_fish1",
		"rubbish_food",
		"cm_cabbage",
		"fm_crop3",
		"cm_cola",
		"cm_cola2",
		"cm_bread_slice",
		"cm_toast1",
		"cm_milk",
		"cm_meat",
		"cm_flour",
		"cm_pancake",
		"cm_beer",
		"cm_pie",
		"cm_pizza",
		"cm_tomato",
		"cm_cookedmeat",
		"cm_cookedmeat2",
		"cm_fish3",
		"cm_meat2",
		"cm_cheese",
		"cm_foodbacon1",
		"cm_dough",
		"cm_toast2",
		"cm_cake",
		"cm_bread_toast",
		"cm_bread",
		"cm_foodburger",
		"cm_tortilla",
		"cm_apple",
		"cm_foodegg2",
		"cm_foodegg1",
		"swb_ak74",
		"swb_akm",
		"swb_snipercombine_assault",
		"swb_cheytac",
		"swb_357",
		"swb_deagle",
		"swb_hammer",
		"swb_snipercombine_heavy",
		"swb_irifle",
		"swb_ismg",
		"swb_lmg",
		"swb_m60",
		"swb_mp5a5",
		"swb_mp5k",
		"swb_smg",
		"swb_oicw",
		"swb_slk789",
		"swb_shotgun",
		"swb_pistol",
		"swb_asval",
		"swb_mosin",
		"swb_gsh18",
		"swb_sawedoff",
		"swb_tt",
		"swb_rpk",
		"swb_sks",
		"swb_toz",
		"ammo_103x77",
		"ammo_12x70",
		"ammo_545x39",
		"ammo_762x25",
		"ammo_762x39",
		"ammo_762x54r",
		"ammo_9x19",
		"ammo_9x39",
		"rised_flashlight",
		"watch",
		"rised_cloth_armor_class2",
		"rised_cloth_armor_class3_medic",
		"rised_cloth_armor_class3",
		"rised_cloth_armor_class4",
		"rised_cloth_armor_class5_combine",
		"rcs_metal",
		"med_drug_amitriptyline",
		"med_drug_combicillin",
		"med_drug_cardionix_z2",
		"med_drug_heptender",
		"med_drug_i306n",
		"med_drug_pulmonifer",
		"med_drug_qurantimycin",
		"med_drug_zenocillin",
		"med_drug_hrzs",
		"med_health_vial",
		"med_health_kit",
		"med_drug_tire",
	}
end

if CLIENT then
	net.Receive("RisedPermissions_SpawnEntity:Client", function(len, ply)

		local entity_class = net.ReadString()

		local frame = vgui.Create( "DFrame" )
		frame:SetSize( 400, 100 )
		frame:Center()
		frame:SetTitle("Ввидете причину спавна:")
		frame:MakePopup()
		frame.Paint = function(self, w, h)
			draw.RoundedBox(4, 0, 0, w, h, Color(25,25,25,50))
		end
		frame.OnClose = function()
			net.Start("RisedPermissions_SpawnEntity:Server")
			net.WriteString(entity_class)
			net.WriteString("абуз")
			net.SendToServer(ply)
		end

		local reasonEntry = vgui.Create( "DTextEntry", frame )
		reasonEntry:Dock( TOP )
		reasonEntry.OnEnter = function( self )
			chat.AddText( self:GetValue() )
		end

		local DermaButton = vgui.Create( "DButton", frame )
		DermaButton:SetText( "Отправить отчет" )
		DermaButton:SetPos( 25, 58 )
		DermaButton:SetSize( 200, 30 )
		DermaButton.DoClick = function()
			net.Start("RisedPermissions_SpawnEntity:Server")
			net.WriteString(entity_class)
			net.WriteString(reasonEntry:GetValue())
			net.SendToServer(ply)
			frame:Remove()
		end

	end)
end

if SERVER then
	net.Receive("RisedPermissions_SpawnEntity:Server", function(len, ply)
		
		if !IsRisedStuff(ply) then return end
		
		local entity_class = net.ReadString()
		local reason = net.ReadString()

		if table.HasValue(DANGEROUS_ENTITIES, entity_class) then
			discordSpawnEntity(ply, entity_class, reason)
		end
	end)

	function Rised_CanSpawnProp(ply, model, ent)
		return true
	end

	function Rised_CanSpawnEnt(ply, class)
		if table.HasValue(RISED.OwnerItems, class) and !IsOwner(ply) then
			return false
		end

		if ply:isArrested() then return false end

		if ply:GetNWString("usergroup") != "retinue" and ply:GetNWString("usergroup") != "builder" and ply:GetNWString("usergroup") != "youtube" and ply:GetNWString("usergroup") != "tester" and ply:GetNWString("usergroup") != "hand" and ply:GetNWString("usergroup") != "superadmin" then
			if ply:Team() == TEAM_GMAN then
				if table.HasValue(DANGEROUS_ENTITIES, class) and !IsOwner(ply) then
					net.Start("RisedPermissions_SpawnEntity:Client")
					net.WriteString(class)
					net.Send(ply)
				end
				return true
			else
				DarkRP.notify(ply, 1, 5, "Необходима профессия GMAN для спавна энтити.")
			end
			return false
		end

		if table.HasValue(DANGEROUS_ENTITIES, class) and !IsOwner(ply) then
			net.Start("RisedPermissions_SpawnEntity:Client")
			net.WriteString(class)
			net.Send(ply)
		end
		return true
	end

	function Rised_CanSpawnWeapon(ply, class)
		if table.HasValue(RISED.OwnerItems, class) and !IsOwner(ply) then
			return false
		end

		if ply:isArrested() then return false end

		if table.HasValue(RISED.OwnerItems, class) and !IsOwner(ply) then
			return false
		end

		if ply:Team() == TEAM_GMAN or ply:Team() == TEAM_ADMINISTRATOR or ply:GetNWString("usergroup") == "retinue" or ply:GetNWString("usergroup") == "builder" or ply:GetNWString("usergroup") == "youtube" or ply:GetNWString("usergroup") == "tester" or ply:GetNWString("usergroup") == "hand" or ply:GetNWString("usergroup") == "superadmin" then
			return true
		end
		
		DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("cant_spawn_weapons"))
		return false
	end

	function Rised_CanChangeJob(ply, t, force)
		
		local TEAM = RPExtraTeams[t]
		if not TEAM then return false end

		if ply:isArrested() and not force then	return false end

		if t ~= TEAM_CITIZENXXX and not ply:changeAllowed(t) and not force then return false end

		if ply:GetVar("CharacterCreatorIdSaveLoad") == 3 and !IsOwner(ply) and t != TEAM_ADMINISTRATOR and t != TEAM_GMAN then return false end

		if ply.LastJob and GAMEMODE.Config.changejobtime - (CurTime() - ply.LastJob) >= 0 and not force then
			DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("have_to_wait",  math.ceil(GAMEMODE.Config.changejobtime - (CurTime() - ply.LastJob)), "/job"))
			return false
		end

		if ply:GetNWBool("Player_TeamBan_Team_"..t) then
			return false
		end

		if ply:GetNWBool("IsBanned") and t != TEAM_RAT then
			return false
		end

		if t == TEAM_OTA_Elite and ply:HasPurchase("job_ota_elite") then
			return true
		end

		if t == TEAM_OTA_Broken and ply:HasPurchase("job_ota_broken") then
			return true
		end

		if IsOwner(ply) then
			return true
		end

		if TEAM == TEAM_MPF_JURY_Conscript && (LevelCheck(ply, TEAM.exp_unlock_lvl, TEAM.exp_type) || LevelCheck(ply, 17, "Party")) then
			
		end

		if TEAM.exp_type && TEAM.exp_unlock_lvl && !LevelCheck(ply, TEAM.exp_unlock_lvl, TEAM.exp_type) 
			and !IsRisedTester(ply) 
			and !HasJobPermisson(ply, t) then
			DarkRP.notify(ply, 0, 2, "Недостаточный уровень фракции, нужен " .. TEAM.exp_unlock_lvl)
			return false
		end
		
		return true
	end
end
