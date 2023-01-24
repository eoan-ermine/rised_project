-- "addons\\rised_death_system\\lua\\autorun\\sv_eds.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if CLIENT then return end
 
AddCSLuaFile( "eds_config.lua" )
include( "eds_config.lua" )
util.AddNetworkString("SendRagInfo")

local Corpses = {} 
local NotRespawned = {}

function RisedProject_Initiate()
	if not file.Exists("risedproject", "DATA") then
		file.CreateDir("risedproject")
	end
end
RisedProject_Initiate()

local function RemoveCanister(ply)
	ply:SetNWBool('EDS.CanFireUp', false)
end
hook.Add("PlayerDeath","CanisterPlayerDeath", RemoveCanister)
hook.Add("PlayerSpawn","CanisterPlayerSpawn", RemoveCanister)

local function IsJob(ply, jobs)  
	if(!IsValid(ply)) then return end
	if(table.HasValue(jobs, team.GetName(ply:Team()))) then
		return true
	end
	return false
end

local function EDSendCustomMsg(ply, pay)
	if(!IsValid(ply)) then return end
	if EDS.EnableNotifications then
		DarkRP.notify(ply, 0, 4, EDS.text11..pay.." T.")
	end
end

local function EDSendCustomMsg2(ply, text)
	if(!IsValid(ply)) then return end
	if EDS.EnableNotifications then
		DarkRP.notify(ply, 0, 4, text)
	end
end

local function RemoveRagdoll(ent)
	if(!IsValid(ent)) then return end
	ent.EDSShouldDisappear = true
	ent:Remove()
end

local function SetOnFire(ent)
	if(!IsValid(ent)) then return end
	ent:Ignite(EDS.BurnTime, 1)
	ent:EmitSound("ambient/fire/ignite.wav", 65, 100, 0.5, CHAN_AUTO) 
	timer.Simple(EDS.BurnTime, function()
		if(IsValid(ent)) then
			RemoveRagdoll(ent)
		end
	end)
end

local function SetPWanted(victim, attacker)
	if(!IsValid(victim) or !IsValid(attacker) or EDS.EnableAutoWanted==false) then return end
	if(attacker:IsPlayer() and victim!=attacker and !attacker:isCP() and !IsJob(attacker,EDS.NotWantedJobs)) then
		attacker:setDarkRPVar("wanted", true)
		attacker:setDarkRPVar("wantedReason", EDS.text12)
		DarkRP.notify(attacker, 1, 4, EDS.text13)
	end
end

local function FixHealthAmt(ply)
	if(!IsValid(ply)) then return end
	if(ply:Health()>ply:GetMaxHealth() + 4900) then
		ply:SetHealth(ply:GetMaxHealth() + 4900)
	end
end

local function GetPaid(ply,ent,pay)
	if(!IsValid(ply) or !IsValid(ent) or pay==nil) then return end
	local Victim = ent:GetNWEntity('EDS.Victim', null)
	if(EDS.AllowSelfUse == false and Victim:IsPlayer() and Victim == ply) then
		EDSendCustomMsg2(ply, EDS.text27)
	else
		EDSendCustomMsg(ply, pay)
		ply:addMoney(pay)
	end
end

hook.Add("EntityTakeDamage", "BuuRagdollBloodEffect", function(corpse, dmginfo)
	if corpse:GetClass() == "prop_ragdoll" and corpse.IsCorpse and !corpse.IsDissolved and dmginfo:GetDamageType() == DMG_ENERGYBEAM then
		
		corpse.IsDissolved = true
		corpse:SetName("playerCorps")

		ED = ents.Create("env_entity_dissolver")
		ED:SetPos(Vector(0,0,0))
		ED:Spawn()
		ED:Activate()
		ED:Fire("Dissolve", "playerCorps")
		ED:Remove()

		local laser = dmginfo:GetAttacker()
		if laser != NULL then
			local cremator = laser:GetOwner()
			if IsValid(cremator) and cremator:IsPlayer() and cremator:Team() == TEAM_SYNTH_CREMATOR then
				local cleanCost = 50
				cremator:addMoney(cleanCost)
				DarkRP.notify(cremator,0,5,"Вы получили " .. cleanCost .. " токенов за сжигание трупа")
			end
		end

	end
end)

hook.Add("ShouldCollide", "DispatchScannerCollide", function(a, b)

	local dispatch
	local scanner

	if a:IsPlayer() and a:Team() == TEAM_OWUDISPATCH and b:GetClass() == "sent_controllable_scanner" then
		dispatch = a
		scanner = b
	elseif a:GetClass() == "sent_controllable_scanner" and b:IsPlayer() and b:Team() == TEAM_OWUDISPATCH then
		dispatch = b
		scanner = a
	end
	
	if IsValid(dispatch) and IsValid(scanner) then
		return false
	end
end)

hook.Add("ShouldCollide", "CorpseCollide", function(a, b)

	local prop
	local corpse

	if a:GetClass() == "prop_physics" and b:GetClass() == "prop_ragdoll" then
		prop = a
		corpse = b
	elseif a:GetClass() == "prop_ragdoll" and b:GetClass() == "prop_physics" then
		prop = b
		corpse = a
	end

	if IsValid(corpse) and IsValid(prop) and corpse.IsCorpse then
		return false
	end
end)

local function CorpseInfectedDecay(ent)
		
	if ent.DecayStage <= 100 then
		ent:SetColor(Color(200 - ent.DecayStage,255 - ent.DecayStage,200 - ent.DecayStage))
	end

	for k,v in pairs(ents.FindInSphere( ent:GetPos(), 250 )) do
		if v:IsPlayer() then

			if ent.DecayStage >= 600 then
				text = "/local_status Я чувствую запах, что-то поблизости явно стухло"
				SendMessageToPlayersChat(v, text, false)
				
			elseif ent.DecayStage >= 1200 then
				text = "/local_warning Я чувствую резкий запах тухлого мяса"
				SendMessageToPlayersChat(v, text, false)

			elseif ent.DecayStage >= 3600 then
				text = "/local_danger Смердная зловония сводит меня с ума, я скоро не выдержу"
				SendMessageToPlayersChat(v, text, false)

				if !v:GetNWBool("Player_Gasmask") and !v:isCP() and !v:Team() != TEAM_HAZWORKER and !v:Team() != TEAM_WORKER_UNIT then
					
					if v:Team() == TEAM_JEFF and v:Health() < 2000 then

						v:SetHealth(math.Clamp(v:Health() + math.random(75,125), 0, v:GetMaxHealth()))
						v:EmitSound("npc/barnacle/barnacle_tongue_pull"..math.random(1,3)..".wav", 35)
					
					elseif GAMEMODE.ZombieJobs[v:Team()] and v:Health() < 1000 then

						v:SetHealth(math.Clamp(v:Health() + math.random(25,75), 0, v:GetMaxHealth()))
						v:EmitSound("npc/barnacle/barnacle_tongue_pull"..math.random(1,3)..".wav", 35)

					elseif GAMEMODE.CitizensJobs[v:Team()] or GAMEMODE.AnimalJobs[v:Team()] or GAMEMODE.LoyaltyJobs[v:Team()] or GAMEMODE.CrimeJobs[v:Team()] or (GAMEMODE.Rebels[v:Team()] and v:Team() != TEAM_REBELSPY01 and v:Team() != TEAM_REBELJUGGER) then
						
						if v:GetNWString("Player_Sex") == "Мужской" then
							v:EmitSound("vo/npc/male01/moan0"..math.random(1,5)..".wav", 75, 100)
						else
							v:EmitSound("vo/npc/female01/moan0"..math.random(1,5)..".wav", 75, 100)
						end
						v:ScreenFade( SCREENFADE.IN, Color( 255, 0, 0, 128 ), 2, 1 )
						v:SetHealth(math.Clamp(v:Health() - math.random(5, 15), 0, v:GetMaxHealth()))
						v:TakeDamage(0, self, self)
					end
				end
			end
		end
	end
end

local function CreateRagdoll(ply, inf, att)

	if(!IsValid(ply)) then return end

	local DefaultRagdoll = ply:GetRagdollEntity()
	if ( DefaultRagdoll and DefaultRagdoll:IsValid() ) then DefaultRagdoll:Remove() end
	
	local Ragdoll = ents.Create("prop_ragdoll")
	Ragdoll:SetPos(ply:GetPos())
	Ragdoll:SetModel(ply:GetModel())
	Ragdoll:SetSkin(ply:GetSkin())
	for k, v in pairs(ply:GetBodyGroups()) do
		Ragdoll:SetBodygroup(v.id, ply:GetBodygroup(v.id))
	end
	
	Ragdoll:SetNWBool('EDS.UseableClient', true)
	Ragdoll:SetNWBool('EDS.Investigated', false)
	if IsValid(att) then
		Ragdoll:SetNWEntity('EDS.Attacker', att)
		if att:IsPlayer() then
			Ragdoll:SetNWEntity('EDS.AttackerWeapon', att:GetActiveWeapon())
		end
	else
		Ragdoll:SetNWEntity('EDS.Attacker', ply)
		Ragdoll:SetNWEntity('EDS.AttackerWeapon', nil)
	end
	Ragdoll:SetNWEntity('EDS.Victim', ply)
	Ragdoll:Spawn()
	Ragdoll:Activate()
	Ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	Ragdoll:SetCreator(ply)
	Ragdoll.IsCorpse = true
	Ragdoll.IsDissolved = false
	Ragdoll.DecayStage = 0
	Ragdoll:SetCustomCollisionCheck(true)
	Ragdoll:SetNWBool("Corpse_Static", false)

	timer.Create("RagdollCorpsePhysics"..Ragdoll:EntIndex(), 45, 0, function()
		if !IsValid(Ragdoll) then
			timer.Stop("RagdollCorpsePhysics"..Ragdoll:EntIndex())
			return
		end

		local canFreeze = true
		for i = 0, Ragdoll:GetPhysicsObjectCount() - 1 do
			local phys = Ragdoll:GetPhysicsObjectNum(i)
			if phys:GetVelocity() != Vector(0,0,0) then
				canFreeze = false
			end
		end

		if canFreeze then
			for i = 0, Ragdoll:GetPhysicsObjectCount() - 1 do
				local phys = Ragdoll:GetPhysicsObjectNum(i)
				if phys:GetVelocity() == Vector(0,0,0) then
					phys:EnableMotion(false)
					phys:Sleep()
					Ragdoll:SetNWBool("Corpse_Static", true)
				end
			end
		end

		Ragdoll.DecayStage = Ragdoll.DecayStage + 5

		CorpseInfectedDecay(Ragdoll)
	end)

	local invCorpsBlacklist = {
		[TEAM_ADMINISTRATOR] = true,
		[TEAM_GMAN] = true,
		[TEAM_SYNTH_CREMATOR] = true,
		[TEAM_SYNTH_GUARD] = true,
		[TEAM_SYNTH_ELITE] = true,
		[TEAM_SYNTH_ELITE2] = true,
		[TEAM_OWUDISPATCH] = true,
		[TEAM_DOG] = true,
		[TEAM_PIGEON] = true,
		[TEAM_RAT] = true,
		[TEAM_ZOMBIE] = true,
		[TEAM_ZOMBIECP] = true,
		[TEAM_FASTZOMBIE] = true,
		[TEAM_COMBINEZOMBIE] = true,
		[TEAM_JEFF] = true,
	}
	
	if !invCorpsBlacklist[ply:Team()] then
		Ragdoll.InvTable = ply.Inv
	end

	if ply:GetSubMaterial(4) != nil then
		Ragdoll:SetSubMaterial(4,ply:GetSubMaterial(4))
	end

	for i=0, Ragdoll:GetPhysicsObjectCount()-1 do
		local PhysBone = Ragdoll:GetPhysicsObjectNum(i)
		if(PhysBone:IsValid()) then
			local pos, ang = ply:GetBonePosition( Ragdoll:TranslatePhysBoneToBone(i) )
			PhysBone:SetAngles(ang)
			PhysBone:AddVelocity(ply:GetVelocity())
			PhysBone:SetPos(pos)
		end
	end
	
	local PlayerColor = ply:GetPlayerColor()
	Ragdoll.Color = Vector(PlayerColor.r, PlayerColor.g, PlayerColor.b)
	Ragdoll.DisappearTime = 0
	
	return Ragdoll
end

local function PlayerDeath(ply, inf, att)

	ply:SetNWBool("Player_Flashlight", false)
	ply:SetNWBool("Player_Watch", false)
	ply:SetNWBool("Player_Gasmask", false)

	NotRespawned[ply] = false

	local Corpse = CreateRagdoll(ply, inf, att)
	
	if(!IsValid(Corpse)) then return end

	if inf:GetClass() == "env_beam" then
		ED = ents.Create("env_entity_dissolver")
		ED:SetPos(Vector(0,0,0))
		ED:Spawn()
		ED:Activate()
		Corpse:SetName("playerCorps")
		ED:Fire("Dissolve", "playerCorps")
		ED:Remove()
	end
	
	Corpses[ply] = Corpses[ply] or {}
	MaxCorpses = math.max(EDS.MaxCorpses, 1)

	net.Start("SendRagInfo")
		net.WriteInt(Corpse:EntIndex(),32)
		net.WriteInt(ply:EntIndex(),32)
		net.WriteVector(Corpse.Color)
	net.Broadcast()
	
	while #Corpses[ply]>=MaxCorpses do
		local OldRag = Corpses[ply][1]
		if IsValid(OldRag) then RemoveRagdoll(OldRag) end
		table.remove(Corpses[ply],1)
	end

	if ply:isCP() then
		Corpse:EmitSound("npc/overwatch/radiovoice/on3.wav")
		timer.Simple(0.7, function()
			local rnd = math.random(1,3)
			if rnd == 1 then
				Corpse:EmitSound("npc/overwatch/radiovoice/lostbiosignalforunit.wav")
			elseif rnd == 2 then
				Corpse:EmitSound("npc/overwatch/radiovoice/unitdeserviced.wav")
			elseif rnd == 3 then
				Corpse:EmitSound("npc/overwatch/radiovoice/unitdownat.wav")
			end
		end)
	end
	
	Corpses[ply][#Corpses[ply]+1] = Corpse
end
hook.Add("PlayerDeath","CorpsePlayerDeath", PlayerDeath)

local function RemZeroCorpses(ply)
	NotRespawned[ply] = nil
	Corpses[ply] = Corpses[ply] or {}
	MaxCorpses = math.max(EDS.MaxCorpses, 0)
	if(MaxCorpses==0) then
		local OldCorpse = Corpses[ply][1]
		if(IsValid(OldCorpse)) then
			RemoveRagdoll(OldCorpse)
		end
		table.remove(Corpses[ply], 1)
	end
end
hook.Add("PlayerSpawn","CorpseZeroDeath", RemZeroCorpses)

hook.Add("Think","CorpseZeroSpawn",function()
	if #NotRespawned == 0 then return end
	for k,v in pairs(NotRespawned) do
		if k:Alive() then
			RemZeroCorpses(k)
		end
	end
end)

hook.Add( "PlayerDisconnected", "CorpseRemDisconnected", function(ply)
	NotRespawned[ply] = nil
	for k,v in pairs(Corpses[ply] or {}) do
		if IsValid(v) and v then
			RemoveRagdoll(v) 
		end
	end
	Corpses[ply] = nil
end)

local function CorpseDragging(ply,key)
	if(( key == IN_USE ) and IsValid(ply)) then
		local tr = ply:GetEyeTrace()
		local ent = tr.Entity
		if(!IsValid(ent)) then return end
		local Distance = ply:GetPos():Distance(ent:GetPos())
		
		if ent:GetModel() == "models/dpfilms/metropolice/playermodels/pm_zombie_police.mdl" or ent:GetModel() == "models/player/zombie_fast.mdl" or ent:GetModel() == "models/player/zombine/combine_zombie.mdl" then
			return
		end
		
		if(Distance > 70) then return end
		if constraint.HasConstraints( ent ) then
			if(Distance > 70) then return end
			if (ent:GetClass() == "prop_ragdoll" and ent:GetNWBool('EDS.UseableClient', false)) then
				constraint.RemoveConstraints( ply:GetEyeTrace().Entity, "Ballsocket" )
			return end
		return end
		if (ent:GetClass() == "prop_ragdoll" and ent:GetNWBool( 'EDS.UseableClient', false)) then 
			local EntityDrag = ents.Create ("drag_entity")
			EntityDrag:SetPos(ply:GetEyeTrace().HitPos)
			EntityDrag:DrawShadow(false)
			EntityDrag:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			EntityDrag:Spawn()
			constraint.Weld(EntityDrag,ent,0,tr.PhysicsBone,5000,true,false)
			if(IsValid(EntityDrag) and IsValid(ply)) then
				timer.Simple( 0.01, function()
					if(!IsValid(EntityDrag)) then return end
					ply:PickupObject(EntityDrag)
				end)
			end
		end
	end
end
hook.Add( "KeyPress", "CorpseDrag", CorpseDragging)

hook.Add("PlayerDeath", "PlayerRespawnTimer", function(ply, inf, att)

	// Удаление персонажа возле места казни
	for k,v in pairs(ents.FindByClass("execution_*")) do
		if ply:GetPos():Distance(v:GetPos()) <= 200 then
			CharacterDeleteServer(ply, ply:GetVar("CharacterCreatorIdSaveLoad", 50))
		end
	end

	// Удаление персонажа с тяжелой болезнью
	if table.HasValue(Medicine_Diseases, ply:GetNWString("MedicineDisease_01")) then
		CharacterDeleteServer(ply, ply:GetVar("CharacterCreatorIdSaveLoad", 50))
	end

	-- Система жизней --
	-- (ply:SteamID() != RISED.OwnerId)
	if !ply:GetNWBool("IsBanned") and ply:Team() != TEAM_RAT then
		ply:SetNWInt("PlayerLifes", math.Clamp(ply:GetNWInt("PlayerLifes") - 1, 0, 10))
		hook.Call("playerLifesChanged", GAMEMODE, ply, ply:GetNWInt("PlayerLifes"))
	end
	
	local RPLevel = tonumber(ply:GetNWInt("PersonalRPLevel", 0))
	if RPLevel >= 75 then
		ply:SetNWInt('EDS.RespawnTime', EDS.RespawnTimer * 30)
	elseif RPLevel >= 50 then
		ply:SetNWInt('EDS.RespawnTime', EDS.RespawnTimer * 60)
	elseif RPLevel >= 30 then
		ply:SetNWInt('EDS.RespawnTime', EDS.RespawnTimer * 120)
	else
		ply:SetNWInt('EDS.RespawnTime', EDS.RespawnTimer * 180)
	end
	
	if ply:Team() == TEAM_RAT then
		ply:SetNWInt('EDS.RespawnTime', EDS.RespawnTimer * 120)
	end

	if IsOwner(ply) then
		ply:SetNWInt('EDS.RespawnTime', EDS.RespawnTimer * 10)
	elseif ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube" then
		ply:SetNWInt('EDS.RespawnTime', EDS.RespawnTimer * 15)
	end
	
	ply:Freeze(true)
	
	ply:SetNWInt("player_rubbish", 0)
	ply:SetNWInt("player_meth", 0)
	
	local mp
	for k,v in pairs (ents.FindByClass("mediaplayer_tv")) do
		mp = v
	end
	
	if IsValid(mp) then
		local mp2 = mp:GetMediaPlayer()
		if mp2:HasListener(ply) then
			mp2:RemoveListener(ply)
		end
	end
end)

Medicine_Diseases = {
	"Сердечная недостаточность", -- Cadrionix Z-2
	"Хроническая обструктивная болезнь легких", -- Pulmonifer
	"Гнойный менингит", -- Zenocillin
	"СПИД", -- I306N
	"Пневмония", -- Combicillin
	"Эндокардит", -- Qurantimycin
	"Острый гломерулонефрит", -- Combicillin
	"Туберкулез", -- H+R+Z+S
	"Цирроз", -- Heptender
}

local Ticket_City = {
	"City01",
	"City02",
	"City03",
	"City04",
	"City05",
	"City06",
	"City07",
	"City08",
	"City09",
	"City10",
}

hook.Add("PlayerSpawn", "PlayerRespawnTimer", function(ply)

	Rised_DB_UserSync(ply)
	Rised_DB_TeamBansPlayerSpawnCheck(ply)

	-- Выключить возможность использования приближение костюма --
	ply:SetCanZoom(false)

	ply:SetNWBool("RebelCanWearArmor", false)
	ply:SetNWBool("rhc_haslockpick", false)
	ply:SetNWBool("RadioOn", false)
	ply:SetNWInt('EDS.RespawnTime', 0)
	ply:Freeze(false)

	-- Установка настроения --
	-- if ply:isCP() then
	-- 	ply:SetNWInt("Player_Mood", 100)
	-- end
	
	
	-- Проверка на реанимацию --
	if ply:GetNWBool("PlyDontLoseJobe") == true then return end
	

	-- Система жизней --
	local new_lifes = 1
	if !GAMEMODE.CitizensJobs[ply:Team()] and !GAMEMODE.LoyaltyJobs[ply:Team()] and !GAMEMODE.CrimeJobs[ply:Team()] then
		new_lifes = 1
	end
	if ply:HasPurchase("status_stronger") then
		new_lifes = new_lifes + 1
	end
	-- Плюс 1 жизнь, если есть квартира --
	local db = {}
	if file.Exists("risedproject/apartments.json", "DATA") then
		db = util.JSONToTable(file.Read("risedproject/apartments.json", "DATA") or {})
		local hasApartment = false
		for k, v in pairs(db) do
			if istable(db[k]["Владельцы"][1]) then
				for j,c in pairs(db[k]["Владельцы"]) do
					if c["SteamID"] == ply:SteamID() and ply:GetVar("CharacterCreatorIdSaveLoad") == c["Character"] then
						new_lifes = new_lifes + 1
						DarkRP.notify(ply,1,5,"Вам добавлена 1 жизнь, так как вы проживаете в квартире")
						hasApartment = true
					end
				end
			end
		end
	end
	ply:SetNWInt("PlayerLifesTimer", 0)
	ply:SetNWInt("PlayerLifesMax", new_lifes)

	if ply:GetNWInt("PlayerLifes") >= 0 then
		if ply:isCP() or ply:Team() == TEAM_STALKER then
			timer.Simple(1,function() SelectUnitNumber(ply) end)
		end
		return 
	end
end)

hook.Add("OnPlayerChangedTeam", "PlayerSetOldName", function(ply,t1,t2)

	local certs = {}
	local saveWeapons = {
		"medicalcard",
	}
	for k,v in pairs(ply:GetWeapons()) do
	   if table.HasValue(saveWeapons, v:GetClass()) then
		   table.insert(certs, v:GetClass())
	   end
	end

	timer.Simple(1, function()
		for k,v in pairs(certs) do
			ply:Give(v)
		end
	end)


	-- Лимитирование OTA в городе
	if GAMEMODE.CombineJobs[t2] then
		local ota_count = 0
		for k,v in pairs(player.GetAll()) do
			if GAMEMODE.CombineJobs[v:Team()] then
				ota_count = ota_count + 1
			end
		end
		if ota_count >= 7 then
			ply:changeTeam( TEAM_MPF_JURY_Conscript, true )
			DarkRP.notify(ply,0,5,"Превышен лимит OTA в секторе")
			return
		end
	end


	ply:SetNWBool("RebelCanWearArmor", false)
	ply:SetNWBool("RadioOn", false)
	ply:SetNWBool("Player_ChangedTeam", true)

	if ply:FlashlightIsOn() then
		ply:SetNWBool("Player_Flashlight", true)
		ply:Flashlight(false)
		ply:SetNWBool("Player_Flashlight", false)
	end

	if ply:isCP() or GAMEMODE.LoyaltyJobs[ply:Team()] or ply:Team() == TEAM_STALKER or ply:Team() == TEAM_REBELSPY01 then
		SelectUnitNumber(ply)
	end

	if (ply:Team() == TEAM_OWUDISPATCH) then
		ply:SetPos(Vector(2627.140625, 4554.666016, 2864.031250))
	end
	
	if GAMEMODE.ZombieJobs[ply:Team()] or ply:Team() == TEAM_ADMINISTRATOR or ply:Team() == TEAM_GMAN then
		local enemy = ents.FindByClass( "npc_zombie" )
		for k, v in pairs( enemy ) do
			if !v:IsNPC() then return end
			v:AddEntityRelationship( ply, D_LI, 99 )
		end
		
		local enemy2 = ents.FindByClass( "npc_headcrab" )
		for k, v in pairs( enemy2 ) do
			if !v:IsNPC() then return end
			v:AddEntityRelationship( ply, D_LI, 99 )
		end
		
		local enemy3 = ents.FindByClass( "npc_poisonzombie" )
		for k, v in pairs( enemy3 ) do
			if !v:IsNPC() then return end
			v:AddEntityRelationship( ply, D_LI, 99 )
		end
		
		local enemy4 = ents.FindByClass( "npc_fastzombie" )
		for k, v in pairs( enemy4 ) do
			if !v:IsNPC() then return end
			v:AddEntityRelationship( ply, D_LI, 99 )
		end
		
		local enemy5 = ents.FindByClass( "npc_headcrab_fast" )
		for k, v in pairs( enemy5 ) do
			if !v:IsNPC() then return end
			v:AddEntityRelationship( ply, D_LI, 99 )
		end
		
		local enemy6 = ents.FindByClass( "npc_headcrab_black" )
		for k, v in pairs( enemy6 ) do
			if !v:IsNPC() then return end
			v:AddEntityRelationship( ply, D_LI, 99 )
		end
		
		local enemy7 = ents.FindByClass( "npc_headcrab_poison" )
		for k, v in pairs( enemy7 ) do
			if !v:IsNPC() then return end
			v:AddEntityRelationship( ply, D_LI, 99 )
		end
	else
		local enemy = ents.FindByClass( "npc_zombie" )
		for k, v in pairs( enemy ) do
			if !v:IsNPC() then return end
			v:AddEntityRelationship( ply, D_HT, 99 )
		end
		
		local enemy2 = ents.FindByClass( "npc_headcrab" )
		for k, v in pairs( enemy2 ) do
			if !v:IsNPC() then return end
			v:AddEntityRelationship( ply, D_HT, 99 )
		end
		
		local enemy3 = ents.FindByClass( "npc_poisonzombie" )
		for k, v in pairs( enemy3 ) do
			if !v:IsNPC() then return end
			v:AddEntityRelationship( ply, D_HT, 99 )
		end
		
		local enemy4 = ents.FindByClass( "npc_fastzombie" )
		for k, v in pairs( enemy4 ) do
			if !v:IsNPC() then return end
			v:AddEntityRelationship( ply, D_HT, 99 )
		end
		
		local enemy5 = ents.FindByClass( "npc_headcrab_fast" )
		for k, v in pairs( enemy5 ) do
			if !v:IsNPC() then return end
			v:AddEntityRelationship( ply, D_HT, 99 )
		end
		
		local enemy6 = ents.FindByClass( "npc_headcrab_black" )
		for k, v in pairs( enemy6 ) do
			if !v:IsNPC() then return end
			v:AddEntityRelationship( ply, D_HT, 99 )
		end
		
		local enemy7 = ents.FindByClass( "npc_headcrab_poison" )
		for k, v in pairs( enemy7 ) do
			if !v:IsNPC() then return end
			v:AddEntityRelationship( ply, D_HT, 99 )
		end
	end
		
	-- Удаление брони повстанцев при смене профессии --
	ply.RebelHasArmor = false
end)

hook.Add("PlayerDisconnected", "PlayerSaveCharacterTime", function(ply)
	if file.Exists("clothesmod/"..ply:SteamID64(), "DATA") then
		local char_id = ply:GetVar("CharacterCreatorIdSaveLoad", 0)
		if char_id != 0 then
			file.Write("charactercreator/"..ply:SteamID64().."/kobra_character_"..char_id.."_time.txt", ply:GetNWInt("Character_"..char_id), true)
		end
	end 
end)

function SelectUnitNumber(ply)
	timer.Simple(1, function()
		if ply:isCP() then

			name = ""
			surname = tostring(ply:GetNWInt("Rised_Player_UnitNumber"))

			if ply:Team() == TEAM_MPF_JURY_Conscript then
				name = "C17I.MPF.JURY.Conscript#"
			elseif ply:Team() == TEAM_REBELSPY01 then
				name = "C17I.MPF.JURY.Conscript#"
			elseif ply:Team() == TEAM_MPF_JURY_PVT then
				name = "C17I.MPF.JURY.PVT#"
			elseif ply:Team() == TEAM_MPF_JURY_CPL then
				name = "C17I.MPF.JURY.CPL#"
			elseif ply:Team() == TEAM_MPF_JURY_SGT then
				name = "C17I.MPF.JURY.SGT#"
			elseif ply:Team() == TEAM_MPF_JURY_LT then
				name = "C17I.MPF.JURY.LT#"
			elseif ply:Team() == TEAM_MPF_JURY_CPT then
				name = "C17I.MPF.JURY.CPT#"
			elseif ply:Team() == TEAM_MPF_JURY_GEN then
				name = "C17I.MPF.JURY.GEN#"

			elseif ply:Team() == TEAM_MPF_ETHERNAL_SGT then 
				name = "C17I.MPF.ETHERNAL.SGT#"
			elseif ply:Team() == TEAM_MPF_ETHERNAL_LT then 
				name = "C17I.MPF.ETHERNAL.LT#"
			elseif ply:Team() == TEAM_MPF_ETHERNAL_CPT then 
				name = "C17I.MPF.ETHERNAL.CPT#"

			elseif ply:Team() == TEAM_MPF_PLUNGER_SGT then
				name = "C17I.MPF.PLUNGER.SGT#"
			elseif ply:Team() == TEAM_MPF_PLUNGER_LT then
				name = "C17I.MPF.PLUNGER.LT#"
			elseif ply:Team() == TEAM_MPF_PLUNGER_CPT then
				name = "C17I.MPF.PLUNGER.CPT#"

			elseif ply:Team() == TEAM_MPF_WATCHER_SGT then
				name = "C17I.MPF.WATCHER.SGT#"
			elseif ply:Team() == TEAM_MPF_WATCHER_LT then
				name = "C17I.MPF.WATCHER.LT#"
			elseif ply:Team() == TEAM_MPF_WATCHER_CPT then
				name = "C17I.MPF.WATCHER.CPT#"

			elseif ply:Team() == TEAM_MPF_SPIRE_SGT then
				name = "C17I.MPF.SPIRE.SGT#"
			elseif ply:Team() == TEAM_MPF_SPIRE_LT then
				name = "C17I.MPF.SPIRE.LT#"
			elseif ply:Team() == TEAM_MPF_SPIRE_CPT then
				name = "C17I.MPF.SPIRE.CPT#"

			elseif ply:Team() == TEAM_OWUDISPATCH then
				name = "I17.AI.DISPATCH#"

			elseif ply:Team() == TEAM_OTA_Grunt then
				name = "I17.OW.Grunt#"
			elseif ply:Team() == TEAM_OTA_Hammer then
				name = "I17.OW.Hammer#"
			elseif ply:Team() == TEAM_OTA_Ordinal then
				name = "I17.OW.Ordinal#"
			elseif ply:Team() == TEAM_OTA_Soldier then
				name = "I17.OW.Soldier#"
			elseif ply:Team() == TEAM_OTA_Striker then
				name = "I17.OW.Striker#"
			elseif ply:Team() == TEAM_OTA_Razor then
				name = "I17.OW.Razor#"
			elseif ply:Team() == TEAM_OTA_Suppressor then
				name = "I17.OW.Suppressor#"
			elseif ply:Team() == TEAM_OTA_Assassin then
				name = "I17.OW.Assassin#"
			elseif ply:Team() == TEAM_OTA_Tech then
				name = "I17.OW.Tech#"
			elseif ply:Team() == TEAM_OTA_Commander then
				name = "I17.OW.Commander#"
			elseif ply:Team() == TEAM_OTA_Elite then
				name = "I17.OW.Elite#"
			elseif ply:Team() == TEAM_OTA_Broken then
				name = "I17.OW.Elite#"
			elseif ply:Team() == TEAM_OTA_Crypt then
				name = "I17.OW.Crypt#"

			elseif ply:Team() == TEAM_STALKER then
				name = "Stalker#"

			elseif ply:Team() == TEAM_WORKER_UNIT then
				name = "I17.Work.Engineer Core#"
			elseif ply:Team() == TEAM_HAZWORKER then
				name = "I17.Work.Infestation Control#"
			elseif ply:Team() == TEAM_SYNTH_CREMATOR then
				name = "Synth.Cremator#"
			elseif ply:Team() == TEAM_SYNTH_GUARD then
				name = "Synth.Guard#"
			end
			
			timer.Simple(1, function()
				if ply:isCP() then
					ply:setRPName(name .. "" .. surname)
				end
			end)
		end
	end)
end

local baseModelToPartyModel = {
	["models/player/hl2rp/female_01.mdl"] = "models/player/humans/combine/female_01.mdl",
	["models/player/hl2rp/female_02.mdl"] = "models/player/humans/combine/female_02.mdl",
	["models/player/hl2rp/female_03.mdl"] = "models/player/humans/combine/female_03.mdl",
	["models/player/hl2rp/female_04.mdl"] = "models/player/humans/combine/female_04.mdl",
	["models/player/hl2rp/female_06.mdl"] = "models/player/humans/combine/female_06.mdl",
	["models/player/hl2rp/female_07.mdl"] = "models/player/humans/combine/female_07.mdl",
	["models/player/hl2rp/male_01.mdl"] = "models/player/humans/combine/male_01.mdl",
	["models/player/hl2rp/male_02.mdl"] = "models/player/humans/combine/male_02.mdl",
	["models/player/hl2rp/male_03.mdl"] = "models/player/humans/combine/male_03.mdl",
	["models/player/hl2rp/male_04.mdl"] = "models/player/humans/combine/male_04.mdl",
	["models/player/hl2rp/male_05.mdl"] = "models/player/humans/combine/male_05.mdl",
	["models/player/hl2rp/male_06.mdl"] = "models/player/humans/combine/male_06.mdl",
	["models/player/hl2rp/male_07.mdl"] = "models/player/humans/combine/male_07.mdl",
	["models/player/hl2rp/male_08.mdl"] = "models/player/humans/combine/male_08.mdl",
	["models/player/hl2rp/male_09.mdl"] = "models/player/humans/combine/male_09.mdl"
}

function BaseModelToPartyMemberModel(ply, baseModel)
	if ply:GetNWString("Character_BaseModel") and (ply:Team() == TEAM_PARTYSUPERIORCOUNCILMEMBER or ply:Team() == TEAM_PARTYCOUNCILCHAIRMAN or ply:Team() == TEAM_PARTYGENERALSECRETARY or ply:Team() == TEAM_CONSUL) then
		local baseModel = ply:GetNWString("Character_BaseModel")
		if baseModelToPartyModel[baseModel] then
			ply:SetModel(baseModelToPartyModel[baseModel])
		else
			ply:SetModel("models/player/humans/combine/male_01.mdl")
		end
		if baseModel == "models/player/hl2rp/male_07.mdl" or baseModel == "models/player/hl2rp/male_08.mdl" then
			ply:SetSkin(1)
		end

		local body = ply:FindBodygroupByName("Body")
		local helmet = ply:FindBodygroupByName("Helmet")
		local headset = ply:FindBodygroupByName("Headset")
		local epaulettes = ply:FindBodygroupByName("Epaulettes")

		if ply:Team() == TEAM_PARTYSUPERIORCOUNCILMEMBER then
			if ply:GetNWString("Player_Sex") == "Мужской" then
				ply:SetBodygroup(body, 3)
				ply:SetBodygroup(helmet, 2)
			else
				ply:SetBodygroup(headset, 1)
			end
		elseif ply:Team() == TEAM_PARTYCOUNCILCHAIRMAN then
			if ply:GetNWString("Player_Sex") == "Женский" then
				ply:SetBodygroup(body, 1)
			end
		elseif ply:Team() == TEAM_PARTYGENERALSECRETARY then
			ply:SetBodygroup(body, 1)
			ply:SetBodygroup(epaulettes, 1)
		end
	end
end

hook.Add("PlayerLoadout", "PlayerChangeModelBack", function(ply)
	
	SetTrueBodygroups(ply)

	if !ply:GetNWBool("IsBanned") then
		BaseModelToPartyMemberModel(ply)
	end
	
	if ((ply:isCP() and !GAMEMODE.SynthJobs[ply:Team()]) or GAMEMODE.Rebels[ply:Team()] )and (ply:GetNWString("usergroup") == "superadmin" or ply:GetNWString("usergroup") == "hand" or ply:HasPurchase("status_premium") or ply:GetNWString("usergroup") == "youtube") then
		ply:Give("cross_arms_swep")
		ply:Give("cross_arms_infront_swep")
		ply:Give("middlefinger_animation_swep")
		ply:Give("point_in_direction_swep")
		ply:Give("salute_swep")
	end
	
	if ply:Team() == TEAM_RAT then
		timer.Simple(1, function()
			if IsValid(ply) then
				ply:SetHull(Vector(-16* 0.2, -16* 0.2, 0), Vector(16* 0.2, 16* 0.2, 72 * 0.08))
				ply:SetCurrentViewOffset(Vector(0, 0, 5))
				ply:SetViewOffset(Vector(0, 0, 5))
			end
		end)
	else
		timer.Simple(1, function()
			if IsValid(ply) then
				ply:SetHull(Vector(-16, -16, 0), Vector(16, 16, 72 * 1))
				ply:SetCurrentViewOffset(Vector(0, 0, 64))
				ply:SetViewOffset(Vector(0, 0, 64))
			end
		end)
	end

	--ply:CharacterCreatorSave()
	
	if file.Exists("charactercreator/"..ply:SteamID64().."/kobra_character_1.txt", "DATA") then
		local CharacterCreatorFil1 = file.Read("charactercreator/"..ply:SteamID64().."/kobra_character_1.txt", "DATA") or ""
		CharacterCreatorTab1 = util.JSONToTable(CharacterCreatorFil1) or {}
		ply:SetNWString("CharacterCreator1","Player1Create")
	else 
		ply:SetNWString("CharacterCreator1","PlayerNotCreate")
	end 

	if file.Exists("charactercreator/"..ply:SteamID64().."/kobra_character_2.txt", "DATA") then
		local CharacterCreatorFil2 = file.Read("charactercreator/"..ply:SteamID64().."/kobra_character_2.txt", "DATA") or ""
		CharacterCreatorTab2 = util.JSONToTable(CharacterCreatorFil2) or {}
		ply:SetNWString("CharacterCreator2","Player2Create")
	else 
		ply:SetNWString("CharacterCreator2","PlayerNotCreate")
	end 

	if file.Exists("charactercreator/"..ply:SteamID64().."/kobra_character_3.txt", "DATA") then
		local CharacterCreatorFil3 = file.Read("charactercreator/"..ply:SteamID64().."/kobra_character_3.txt", "DATA") or ""
		CharacterCreatorTab3 = util.JSONToTable(CharacterCreatorFil3) or {}
		ply:SetNWString("CharacterCreator3","Player3Create")
	else
		ply:SetNWString("CharacterCreator3","PlayerNotCreate")
	end
end)

local newtime = 0
local newtime2 = 0
local newtime600 = 0
local opencpp = false
local Ref = 0
hook.Add("Think", "PlayerDeathTime", function()
	if CurTime() >= newtime then
		newtime = CurTime() + 1
		
		for k, v in pairs( player.GetAll() ) do
			if v:GetNWInt("Punish_Timer", 0) > 0 then
				v:SetNWInt("Punish_Timer", v:GetNWInt("Punish_Timer", 0) - 1)
				
				if v:Team() != TEAM_RAT and v:GetNWInt("Punish_Timer", 0) > 0 then
					v:changeTeam(TEAM_RAT, true)
					v:SetModel("models/tsbb/animals/rat.mdl")
				end
				if v:GetNWInt("Punish_Timer", 0) <= 0 then
					v:SetNWBool("IsBanned", false)
					v:SetNWInt("Punish_Timer", 0)
					v:Kill()
				end
			end
			if(v:Health()<=0 and v:GetNWInt('EDS.RespawnTime', 0)>0) then
				v:Lock()
				v:SetNWInt('EDS.RespawnTime', v:GetNWInt('EDS.RespawnTime', 0) - 1)
			elseif(v:Health()<=0 and v:GetNWInt('EDS.RespawnTime', 0)<=0) then
				v:UnLock()
			end

			if v:GetNWInt("PlayerLifesTimer") < 1200 then
				v:SetNWInt("PlayerLifesTimer",v:GetNWInt("PlayerLifesTimer") + 1)
			elseif v:GetNWInt("PlayerLifes") < v:GetNWInt("PlayerLifesMax", 1) and v:Alive() then
				if !table.HasValue(Medicine_Diseases, v:GetNWString("MedicineDisease_01")) then
					v:SetNWInt("PlayerLifes",v:GetNWInt("PlayerLifes") + 1)
					v:SetNWString("MedicineDisease_01", "")
					hook.Call("playerLifesChanged", GAMEMODE, v, v:GetNWInt("PlayerLifes"))
					v:SetNWInt("PlayerLifesTimer", 0)
					v:PrintMessage(HUD_PRINTTALK, "Вам стало лучше.")
				elseif GAMEMODE.CombineJobs[v:Team()] then
					v:SetNWInt("PlayerLifes",v:GetNWInt("PlayerLifes") + 1)
					v:SetNWString("MedicineDisease_01", "")
					hook.Call("playerLifesChanged", GAMEMODE, v, v:GetNWInt("PlayerLifes"))
					v:SetNWInt("PlayerLifesTimer", 0)
					v:PrintMessage(HUD_PRINTTALK, "Вам стало лучше.")
				else
					v:SetNWInt("PlayerLifesTimer", 0)
					v:PrintMessage(HUD_PRINTTALK, "Вам не становится лучше, вам стоит обратиться к врачу.")
				end
			else
				v:SetNWInt("PlayerLifesTimer", 0)
			end
			
			if v:GetNWInt("JailRoom_Timer", 0) != nil then
				v:SetNWInt("JailRoom_Timer", v:GetNWInt("JailRoom_Timer") - 1)
			end
		end
	end
	
	if CurTime() >= newtime2 then
		newtime2 = CurTime() + 30
		
		opencpp = false
		for k, v in pairs( player.GetAll() ) do
			if v:isCP() then
				if IsValid(ents.FindByName("Forcefield_close")[1]) then
					local cp_pos = v:GetPos()
					local relay_pos = ents.FindByName("Forcefield_close")[1]:GetPos()
					if cp_pos:Distance(relay_pos) <= 500 then
						opencpp = true
					end
				end
			end
		end
		
		if !opencpp then
			for k,v in pairs(ents.FindByName("Forcefield_open")) do
				v:Fire("Trigger")
			end
			for k,v in pairs(ents.FindByName("Forcefield2_open")) do
				v:Fire("Trigger")
			end
		end
	end

	if CurTime() >= newtime600 then
		newtime600 = CurTime() + 600
	end
end)

local Refresh = 0
hook.Add("Think", "Investigating", function()
	local Delay = 1
	local TimeLeft = Refresh - CurTime()
	if TimeLeft < 0 then
		local players = player.GetAll()
		for _, ply in ipairs( players ) do
			local tr = util.TraceLine({
			start  = ply:GetShootPos(),
			endpos = ply:GetShootPos() + ply:GetAimVector() * 100,
			filter = ply,
			})
			local ent = tr.Entity
			
			if (IsJob(ply, EDS.MedicJobs) and EDS.MedicCanCleanup) or IsJob(ply, EDS.DetectiveJobs) or (ply:isCP() and EDS.PoliceCanIvestigate) then
				ply:SetNWBool('EDS.CanFireUp', false)
			end
			
			if( IsValid(ply) and ply:Health()>0 and IsValid(ent) and ply:KeyDown(IN_RELOAD) and tr.Hit and ent:GetClass() == "prop_ragdoll" and ent:GetNWBool( 'EDS.UseableClient', false) ) then
				local Attacker = ent:GetNWEntity( 'EDS.Attacker', null)
				local Victim = ent:GetNWEntity( 'EDS.Victim', null)
				if(IsValid(Victim)) then ent.Vic = Victim end
				if(IsValid(Attacker)) then ent.Att = Attacker end
				
				if IsJob(ply, EDS.DetectiveJobs) then
					if ent:GetNWBool( 'EDS.Investigated', false) || Victim==Attacker then
						return
					end
				end
				
				if((IsJob(ply, EDS.HoboJobs) and EDS.CanHoboEat) or (IsJob(ply, EDS.MedicJobs) and EDS.MedicCanCleanup) or (IsJob(ply, EDS.MafiaJobs) and EDS.BossCanBurn) or (IsJob(ply, EDS.DetectiveJobs) and IsValid(Attacker)) or (ply:isCP() and EDS.PoliceCanIvestigate) or ply:GetNWBool('EDS.CanFireUp', false)) then
					ply:SetNWInt( 'InvProgress', ply:GetNWInt('InvProgress', 0) + 1 )
					
				end
				
				if IsJob(ply, EDS.DetectiveJobs) and (ply:GetNWInt("InvProgress") % 125) == 0 then
					ply:EmitSound( "physics/body/body_medium_impact_soft"..math.random(1,6)..".wav", 65, 100, 0.5, CHAN_AUTO ) 
				end
				
				if IsJob(ply, EDS.MedicJobs) and (ply:GetNWInt("InvProgress") % 150) == 0 then
					ply:EmitSound( "physics/body/body_medium_break"..math.random(2,4)..".wav", 65, 100, 0.5, CHAN_AUTO ) 
				end
				
				if(IsJob(ply, EDS.MedicJobs) and EDS.MedicCanCleanup and ply:GetNWInt('InvProgress', 1) > EDS.MedicTime and ent:GetNWBool( 'EDS.UseableClient', true)) then
					ent:SetNWBool('EDS.UseableClient', false)
					ply:SetNWInt('InvProgress', 0)	
					GetPaid(ply,ent,EDS.MedicPay)
					RemoveRagdoll(ent)
				elseif(Victim != Attacker and IsJob(ply, EDS.DetectiveJobs) and ply:GetNWInt('InvProgress', 1) > EDS.DetectiveTime and ent:GetNWBool( 'EDS.UseableClient', true) and !ent:GetNWBool( 'EDS.Investigated', false)) then
					--ent:SetNWBool('EDS.UseableClient', false)
					ent:SetNWBool( 'EDS.Investigated', true)
					ply:SetNWInt('InvProgress', 0)	
					GetPaid(ply,ent,EDS.DetectivePay)
					EDSendCustomMsg2(ply, EDS.text5)	
					SetPWanted(Victim, Attacker)
					
					AddTaskExperience(ply, "Исследование тела")
					
					--RemoveRagdoll(ent)
				elseif((ply:isCP() and EDS.PoliceCanIvestigate) and ply:GetNWInt('InvProgress', 1) > EDS.CPTime and ent:GetNWBool( 'EDS.UseableClient', true)) then
					ent:SetNWBool('EDS.UseableClient', false)
					ply:SetNWInt('InvProgress', 0)	
					GetPaid(ply,ent,EDS.CPsPay)
					SetPWanted(Victim, Attacker)
					RemoveRagdoll(ent)	
				elseif(IsJob(ply, EDS.MafiaJobs) or ply:GetNWBool('EDS.CanFireUp', false)) and ply:GetNWInt('InvProgress', 1) > 0.1 and ent:GetNWBool( 'EDS.UseableClient', true) then
					if(!ply:GetNWBool('EDS.CanFireUp', false)) then
						ent:SetNWBool('EDS.UseableClient', false)
						ply:SetNWInt('InvProgress', 0)
						ply:addMoney(50)
						EDSendCustomMsg2(ply, EDS.text21)	
						SetOnFire(ent)
					else
						ent:SetNWBool('EDS.UseableClient', false)
						ply:SetNWInt('InvProgress', 0)
						SetOnFire(ent)	
						if ply:GetNWString("Player_WorkStatus") == "Уборщик" then
							EDSendCustomMsg2(ply, "Вы сожгли труп и получили 150 T.")
							ply:addMoney(150)
							AddExperienceWithCD(ply, RISED.Config.Experience.RubbishBodyExp, "Common", "RubbishBody", 45)
						else
							EDSendCustomMsg2(ply, EDS.text21)	
						end
						ply:SetNWBool('EDS.CanFireUp', false)
					end
				elseif(IsJob(ply, EDS.HoboJobs) and ply:GetNWInt('InvProgress', 1) > EDS.HoboTime and ent:GetNWBool( 'EDS.UseableClient', true)) then
					ent:SetNWBool('EDS.UseableClient', false)
					ply:SetNWInt('InvProgress', 0)		
					ply:SetHealth( ply:Health() + EDS.HoboHPGain ) 
					ply:EmitSound( "npc/barnacle/barnacle_bark2.wav", 65, 100, 0.5, CHAN_AUTO ) 
					ply:EmitSound( "npc/barnacle/barnacle_digesting1.wav", 65, 100, 0.7, CHAN_AUTO )
					FixHealthAmt(ply)					
					EDSendCustomMsg2(ply, EDS.text17..EDS.HoboHPGain..EDS.text18)
					RemoveRagdoll(ent)
				else
					ent:SetNWBool( 'EDS.UseableClient', true)
				end	
			else
				ply:SetNWInt( 'InvProgress', 0 )
			end
			
		end
		
		local entities = ents.FindByClass("prop_ragdoll")
		for _, ent in ipairs( entities ) do
			if(IsValid(ent) and ent.EDSShouldDisappear == true) then
				ent.DisappearTime = ent.DisappearTime + 1
				local EntityColor = ent:GetColor()
				local mul = 1-ent.DisappearTime/16

				ent:SetColor(Color(EntityColor.r, EntityColor.g, EntityColor.b, EntityColor.a*mul))
				ent:SetRenderMode(RENDERMODE_TRANSALPHA)
				if(IsValid(ent) and ent.DisappearTime > 16) then
					ent:Remove()
				end
			end
		end

	Refresh = CurTime() + Delay
	end
end)