-- "addons\\rised_debug_tools\\lua\\weapons\\rdt_tester_sa\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

if CLIENT then
	SWEP.PrintName			= "Тестер (owner only)"			
	SWEP.Slot				= 3
	SWEP.SlotPos			= 14
	SWEP.DrawCrosshair		= true
end

SWEP.Author = "D-Rised";
SWEP.Contact = "";
SWEP.Instructions	= ""
SWEP.Category = "A - Rised - [Админ]"

SWEP.ViewModel			= "models/weapons/c_pistol.mdl";
SWEP.WorldModel			= "models/weapons/w_Pistol.mdl";

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false
SWEP.HoldType			= "normal"
SWEP.AnimPrefix 		= "normal"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

function SWEP:Initialize()
	self:SetHoldType( "pistol" );
	self.can_tp = true
end

function SWEP:Deploy()
	if SERVER then
		-- if IsOwner(self.Owner) then
		-- 	self.Owner:StripWeapon("rdt_tester_sa")
		-- end
	end
end

function SWEP:Holster()
	if CLIENT then
		if IsValid(LocalPlayer()) then
   	   		local Viewmodel = LocalPlayer():GetViewModel()

			if IsValid(Viewmodel) then
				Viewmodel:SetMaterial("")
			end
		end
	end
	return true
end

if SERVER then
	function TestOne2(arr)
		local cost = 0
		local day = 2
		local week = 7
		local month = 25

		local contina = {}
		local cur_contina = 0
		local cur_day = 0
		for i = 1, #arr do
			local day = arr[i]
			local next = arr[i+1]

			if (arr[i+1] && (arr[i+1] - arr[i]) == 1) then
				print(day)
				cur_contina = cur_contina + 1
			else
				cur_day = arr[i]
				if arr[i-1] && (cur_day - arr[i-1]) == 1 then
					cur_contina = cur_contina + 1
					print("cur_contina", cur_contina)
					print("Broken")
					table.insert(contina, cur_contina)
					cur_contina = 0
				elseif (arr[i-1] && (cur_day - arr[i-1]) != 1) || (arr[i+1] && (arr[i+1] - cur_day) != 1) then
					table.insert(contina, 1)
				end
			end
		end

		local days = 0
		for k,v in pairs(contina) do
		   days = days + v
		end


		-- Days --
		cost = days * 2


		-- Weeks --
		local weeks = 0
		for k,v in pairs(contina) do
		  	if (v / 7 >= 1) then
				weeks = math.floor(v / 7)
			end
		end

		if weeks > 0 then
			cost = cost - (weeks * 7)
		end



		-- Month --
		if days >= 25 then
			cost = 25
		end

		rprint(contina)
		rprint(days)
		rprint(weeks)
		rprint(cost)

		return cost
	end

	-- TestOne2({1,2,3,4,5,6,7,8,9,10,11,12,13})
end
-- local en = ents.GetByIndex(398)

function SWEP:PrimaryAttack()

	if !IsOwner(self.Owner) then return end

	self:SetHoldType( "pistol" )

	if CLIENT then
		for k,v in pairs(ents.FindByClass("prop_physics")) do
			v:DrawModel()
			v:DrawShadow(false)
		end
		
		-- Описание персонажа
		-- local ent = self.Owner
		-- local height = math.Round(ent:GetNWString("Character_Height", 170))
		-- local constitution = ent:GetNWString("Character_Сonstitution", "Обычное")
		-- local eye_color = string.lower(ent:GetNWString("Character_EyeColor", "Зеленый"))
		-- local facial_hair = ent:GetNWInt("Character_FacialHair", 0)
		-- local physical_description = ent:GetNWString("Character_PhysicalDescription", "")

		-- if physical_description != "" then
		-- 	physical_description = ", " .. physical_description
		-- end
		
		-- if facial_hair != nil and facial_hair > 0 then
		-- 	facial_hair = "присутствует"
		-- else
		-- 	facial_hair = "отсутствует"
		-- end

		-- local text = "Рост: " .. height .. " см., телосложение " .. constitution .. ", цвет глаз " .. eye_color .. ", растительность на лице " .. facial_hair .. physical_description

		-- chat.AddText( Color( 255, 195, 0 ), ply, text)
	end

	local tr = self.Owner:GetEyeTrace()
	local ent = tr.Entity

	-- Созданеи обломков
	-- if SERVER then
	-- 	ent:PrecacheGibs()
	-- end
	-- ent:GibBreakClient( self.Owner:GetEyeTrace().HitNormal * 1 ) -- Break in some direction



	if SERVER then
		local ent = self.Owner:GetEyeTrace().Entity
    	local Distance = self.Owner:EyePos():Distance(ent:GetPos())
		local a = self.Owner:GetEyeTrace().HitPos
		local b = ent:GetPos() + ent:GetAngles():Right() * -40 + ent:GetAngles():Up() * -40
		local ply = self.Owner
		
		-- ply:SetModel("models/player/hl2rp/female_04.mdl")

		-- ply:SetNWInt("Player_LoyaltyPoint", 10)
		-- rprint(ply:GetNWInt("Player_LoyaltyPoint"))
		-- rprint(ply:GetNWInt("LoyaltyTokens"))

		-- rprint(TEAM_MPF_JURY_CPT)
		-- ply:SetNWInt("CombineJob_Value", TEAM_MPF_JURY_CPT)
		-- GetAllStats()

		-- AddExperience(ply, 10, "Combine")


		-- local det = GetJobsExpData(TEAM_OTA_Elite)
    	-- Rised_Log_Any("test", det)

		--=== Узнать какой лвл по кол-ву опыта ===---
		-- local exp_total = 150000
		-- local level = math.floor((-900 + 10 * math.sqrt((8100 + 4 * exp_total))) / 200)

		-- rprint(ply:HasPurchase("job_ota_elite"))
		-- AddTaskExperience(ply, "Время работы")

		-- ply:SetNWInt("PersonalRPLevel", 55)

		--=== Выдача характеристик ===---
		-- ply:SetHealth(1000)
		-- ply:SetArmor(1000)
		-- ply:SetNWInt("Player_Mood", 1000)
		-- ply:setDarkRPVar("Energy", 1000)

		-- MapExperienceToDatabase()
		
		
		-- ply:SetNWInt("LoyaltyTokens", 0)
		-- hook.Call("playerLoyaltyChanged", GAMEMODE, ply, ply:GetNWInt("LoyaltyTokens"))
		-- ply:StripWeapon("rdt_tester_sa")

		-- AddTaskExperience(ply, "Дежурство на посту")

		-- rnet.sendS(ply, 'tesst', 'cat')

		-- ResetAllIterations()


		-- ply.PrevHealth = 35
		-- ply.NotDead = true
		-- Toggle_Conc(ply)

		--=== Удалить энтити по Id ===---
		-- local ent_to_delete = 646
		-- ents.GetByIndex(ent_to_delete):Remove()



		--=== Энтити в области ===---
		-- local class = 'mf_trigger_press'
		-- for k,v in pairs(ents.FindByClass(class)) do
		--    rprint(v)
		-- end

		ply:ChatPrint(tostring(ent)) -- Энтити
		ply:ChatPrint(ent:GetName()) -- Имя энтити

		
    	
		

		-- AddTaskExperience(ent, "Дежурство на посту")
		-- AddTaskExperience(ent, "Получение снаряжения")

		-- rprint(PartyOnServer())

		-- rprint(ent.Metal_Complete_Press)
		-- rprint(ent.Metal_Complete_Weld)
		-- rprint(ent.Metal_Complete_Crystalyse)

		-- AddExperienceWithCD(ent, RISED.Config.Experience.RubbishExp, "Common", "RubbishSimple", 15)

		-- Rised_Log(tostring(ent))

		-- AddExperience(ply, 1, "Combine")

		-- SetExperience(ply, 100000000, "Common")
		-- SetExperience(ply, 100000000, "Party")
		-- SetExperience(ply, 100000000, "Combine")
		-- SetExperience(ply, 100000000, "Rebel")

		-- AddExperience(ent, 40000, "Combine")

		-- SetExperience(ent, 100000000, "Common")
		-- SetExperience(ent, 100000000, "Party")
		-- SetExperience(ent, 100000000, "Combine")
		-- SetExperience(ent, 100000000, "Rebel")

		-- ply:syncRole(ply:GetNWString("usergroup"))
		-- ply:addRole("premium")
		-- ply:removeRole("premium")


		-- RefreshTasksExperience()
		-- ResetAllIterations()
		-- SendCurrentTasks(ply)

		-- rprint(GetTaskAmountForJob(TEAM_HAZWORKER))
		-- SetupIterations(ply)
		-- GetCurrentTeamTaskList(ply)

		-- SetExperience(ent, 41434322, "Party")
		-- SetExperience(ply, 1, "Combine")

		-- local light = ents.FindByName("nexus_light")[1]
		-- local point_spotlight = ents.FindByName("nexus_interrogation_spotlight")[1]
		-- local light_spot = ents.FindByName("nexus_interrogation_light")[1]



		-- timer.Create("Light_Broken_Effect", 2, 0, function()
		-- 	light:Fire("TurnOn")
		-- 	point_spotlight:Fire("LightOn")
		-- 	light_spot:Fire("TurnOn")
			
		-- 	timer.Simple(math.random(0.1,0.4), function()
		-- 		light:Fire("TurnOff")
		-- 		point_spotlight:Fire("LightOff")
		-- 		light_spot:Fire("TurnOff")

		-- 		local effectdata = EffectData()
		-- 		effectdata:SetOrigin(light_spot:GetPos())
		-- 		effectdata:SetMagnitude(2.5)
		-- 		effectdata:SetScale(2)
		-- 		effectdata:SetRadius(3)
		-- 		util.Effect("Sparks", effectdata, true, true)

		-- 		light_spot:EmitSound("ambient/energy/spark"..math.random(1,6)..".wav")
		-- 	end)
		-- end)

		-- net.Start("jobinfomarkers")
		-- net.WriteInt(12, 10)
		-- net.WriteVector(light:GetPos())
		-- net.Send(ply)

			
			-- for k,v in pairs(ents.FindByName("day_lamp")) do
				-- v:Fire("Disable")
			-- end
			
			-- for k,v in pairs(ents.FindByName("night_lamp")) do
				-- v:Fire("Enable")
			-- end
			
			-- for k,v in pairs(ents.FindByName("street_light_prop")) do
				-- v:SetSkin(1)
			-- end
			
			-- for k,v in pairs(ents.FindByName("street_light_prop2")) do
				-- v:SetSkin(0)
			-- end
		-- else
			-- self.Owner:SetNWBool("asd", true)
			-- -- Включение света --
			-- for k,v in pairs(ents.FindByName("spot_test")) do
				-- v:Fire("TurnOn")
			-- end
			
			-- for k,v in pairs(ents.FindByName("street_sprite")) do
				-- v:Fire("ShowSprite")
			-- end
			
			-- for k,v in pairs(ents.FindByName("street_spotlight")) do
				-- v:Fire("LightOn")
			-- end
			
			-- for k,v in pairs(ents.FindByName("day_lamp")) do
				-- v:Fire("Enable")
			-- end
			
			-- for k,v in pairs(ents.FindByName("night_lamp")) do
				-- v:Fire("Disable")
			-- end
			
			-- for k,v in pairs(ents.FindByName("street_light_prop")) do
				-- v:SetSkin(0)
			-- end
			
			-- for k,v in pairs(ents.FindByName("street_light_prop2")) do
				-- v:SetSkin(1)
			-- end
		-- end





		-- ResetAllIterations()








		-- ply:ChatPrint(ent:GetModel()) -- Модель энтити

		-- btn:Fire("Press")

		-- rprint(door:GetSaveTable().m_toggle_state)

		-- rprint(ent.dt.owning_ent)

		-- ply:Give("sm_weapon_cyclops")
		
		-- UpdateExperience(ply)
		-- SetExperience(ply, 41434322, "Party")
		-- SetExperience(ply, 232, "Common")
		
		-- rprint(GetCurrentIterationForTask(ply, "Норма избиений"))


		-- ent:SetNWString("Door_OwnerName", "123")

		-- rprint(ApartmentOwner(ply))
		-- rprint(ply:GetModel())

		-- UpdateApartmentsForUser(ply)
		-- UpdateAllApartments()
		
		-- ent:keysUnOwn(ply)

		-- Rised_Apartment_System_Refresh("D-1.1")
		-- UpdateApartmentsForUser(ply)
		-- ply:SetNWString("Rised_Owned_Apartment", "")

		-- local player_id = ply:SteamID()
		-- ply:SetNWInt("Player_OL_Cooldown", 0)
		
		-- rprint(QueryValidator({"Де-ф-ужь"}))
		-- Rised_DB_PunishmentsSync(ply)
		-- Rised_DB_PunishPlayer(player_id, player_id, 1220, "Потому что")
		-- Rised_DB_UserSync(ply)
		
		-- hook.Call("playerFaceMemoryChanged", GAMEMODE, ply, "remove")

		-- rprint(game.GetAmmoTypes())
    	-- ply:SetNWFloat("Player_SalaryPoint", 123)
		-- rprint(ply:GetNWFloat("Player_SalaryPoint"))

		-- hook.Call("playerFaceMemoryChanged", GAMEMODE, ply, "add", ent)

		-- hook.Call("playerNotConfirmedTokensOL", GAMEMODE, ply)

		-- SaveRisedConfigs('Tutorial')

		-- SetupRisedConfig(ply)

		-- ply.NotDead = true
		-- Toggle_Conc(ply)


		-- ply:SetBodygroup(6,10)

		-- ply:setDarkRPVar("Energy", 100)

		-- ply:LoadFromDatabase()
		
		-- rprint(ply:GetNWString("Player_WorkStatus"))

		-- if ent:IsPlayer() then
		-- 	constraint.RemoveConstraints( ent, "EasyBonemerge" )
		-- 	constraint.RemoveConstraints( ent, "EasyBonemergeParent" )

		-- 	for i=0, 15 do
		-- 		local bonemerge = ents.Create("prop_effect")
		-- 		bonemerge:SetModel(table.Random(RandomBonemerge_Torso))
		-- 		bonemerge:SetPos(ent:GetPos())
		-- 		bonemerge:Spawn()
		-- 		ApplyBonemerge(bonemerge, ent)
		-- 	end

		-- 	for i=0, 15 do
		-- 		local bonemerge = ents.Create("prop_effect")
		-- 		bonemerge:SetModel(table.Random(RandomBonemerge_Hands))
		-- 		bonemerge:SetPos(ent:GetPos())
		-- 		bonemerge:Spawn()
		-- 		ApplyBonemerge(bonemerge, ent)
		-- 	end

		-- 	for i=0, 15 do
		-- 		local bonemerge = ents.Create("prop_effect")
		-- 		bonemerge:SetModel(table.Random(RandomBonemerge_Legs))
		-- 		bonemerge:SetPos(ent:GetPos())
		-- 		bonemerge:Spawn()
		-- 		ApplyBonemerge(bonemerge, ent)
		-- 	end

		-- 	for i=0, 25 do
		-- 		local bonemerge = ents.Create("prop_effect")
		-- 		bonemerge:SetModel(table.Random(RandomBonemerge_Random))
		-- 		bonemerge:SetPos(ent:GetPos())
		-- 		bonemerge:Spawn()
		-- 		ApplyBonemerge(bonemerge, ent)
		-- 	end
		-- end


		-- hook.Call("Player_InventoryChecks", GAMEMODE, self.Owner, ent)


		-- discordAdminLeave(ply)

		-- ent:SetMaterial("models/zombie/clothes/bag1")

		-- ply:SetSubMaterial(3, "models/eyes/eyes/amber_l")

		-- ply:setDarkRPVar("Energy", 100)

		-- ply:SetNWFloat("Player_SalaryPoint", 100)

		-- ply:SetModel("models/player/hl2rp/male_07.mdl")
		-- ply:SetSkin(2)
		-- ply:SetSubMaterial(4,"models/debug/debugwhite")


		-- ply:SetSubMaterial(4,"models/props_lab/xencrystal_sheet")
		-- ply:SetSubMaterial(4,"debug/env_cubemap_model")

		-- net.Start("jobinfomarkers")
		-- net.WriteInt(14,10)
		-- net.Send(ply)

		-- local char = ply:GetVar("CharacterCreatorIdSaveLoad")
		-- local steamid = ply:SteamID()
		-- rprint(GetCitizenLastRecord(steamid, char))



		-- local history = {}

		-- local recordTime = os.date("%d/%m/%Y", os.time())

		-- local recordId = 1
		-- local historyCount = 3

		-- for i = 1, historyCount do
		-- 	for _,r in pairs(history) do
		-- 		if r["Номер записи"] >= recordId then
		-- 			recordId = r["Номер записи"] + 1
		-- 		end
		-- 	end
		-- 	local randomHistory = table.Random(RISED.Config.History.Usual)
		-- 	local newRecord = {
		-- 		["Номер записи"] = recordId,
		-- 		["Дата"] = randomHistory["Дата"],
		-- 		["Тип записи"] = randomHistory["Тип записи"],
		-- 		["Текст"] = randomHistory["Текст"],
		-- 		["Цвет"] = randomHistory["Цвет"],
		-- 	}
		-- 	table.insert(history, newRecord)
		-- end

		-- ent:CreateNewPersonData(history)

		-- UpdateApartmentsForUser(ply)
		-- UpdateAllApartments()

		-- if file.Exists("risedproject/apartments.json", "DATA") then
		-- 	local db = util.JSONToTable(file.Read("risedproject/apartments.json", "DATA") or {})

		-- 	for id, apart in pairs(db) do
		-- 		if apart["Класс"] == "Квартира" then
		-- 			for m, t in pairs(apart["Владельцы"]) do
		-- 				if t.SteamID == ply:SteamID() and t.Character == ply:GetVar("CharacterCreatorIdSaveLoad") then

		-- 					local coowners = {}
		-- 					local main_door = ents.FindByName(RISED.Config.Apartments[id]["Входная дверь"])[1]
        --  					local mark_pos = main_door:GetPos()

		-- 					if IsValid(main_door:getDoorOwner()) then
		-- 						main_door:keysUnOwn(main_door:getDoorOwner())
		-- 					end

		-- 					net.Start("jobinfomarkers")
		-- 					net.WriteInt(12, 10)
		-- 					net.WriteVector(mark_pos)
		-- 					net.Send(ply)

		-- 					main_door:removeAllKeysExtraOwners()
		-- 					main_door:removeAllKeysAllowedToOwn()
		-- 					main_door:removeAllKeysDoorTeams()
		-- 					main_door:setDoorGroup(nil)
		-- 					main_door:setKeysTitle(id)

		-- 					main_door:keysOwn(ply)
		-- 					main_door:setKeysNonOwnable(true)

		-- 					for k, v in pairs(RISED.Config.Apartments[id]["Дополнительные двери"]) do
		-- 						local sub_door = ents.FindByName(v)[1]

		-- 						if IsValid(sub_door:getDoorOwner()) then
		-- 							sub_door:keysUnOwn(sub_door:getDoorOwner())
		-- 						end

		-- 						sub_door:removeAllKeysExtraOwners()
		-- 						sub_door:removeAllKeysAllowedToOwn()
		-- 						sub_door:removeAllKeysDoorTeams()
		-- 						sub_door:setDoorGroup(nil)
		-- 						sub_door:setKeysTitle("")

		-- 						sub_door:keysOwn(ply)
		-- 						sub_door:setKeysNonOwnable(true)
		-- 					end
		-- 				end
		-- 			end
		-- 		end
		-- 	end
		-- end

		--self.Owner:Rised_ItemPickUp(ent)
		--PrintTable(ent.Inv)


		--ply:SetSubMaterial(5, "models/hl2rp/citizens/cwu_male_factory" )

		--self.Owner:SetBodygroup(2, 2)

		--ent:SetMaterial("materials/models/hl2rp/citizens/male_citizensheep3.vtf")

		--self.Owner:ChatPrint( tostring(a) )
		
		-- for k,v in pairs(ents.FindByName("Forcefield_close")) do
			-- v:Fire("Trigger")
		-- end
		-- for k,v in pairs(ents.FindByName("Forcefield_open")) do
			-- v:Fire("Trigger")
		-- end
		-- for k,v in pairs(ents.FindByName("Forcefield2_close")) do
			-- v:Fire("Trigger")
		-- end
		-- for k,v in pairs(ents.FindByName("Forcefield2_open")) do
			-- v:Fire("Trigger")
		-- end
 		
		-- self.Owner:ChatPrint( tostring(a:Distance(b)) )
				
		-- trEntity:SetPData("Player_CombineRank", trEntity:GetPData("Player_CombineRank", 0) + 1)
		-- trEntity:SetNWInt('Player_CombineRank', trEntity:GetPData("Player_CombineRank", 0))
		-- self.Owner:ChatPrint( tostring(trEntity:GetPData("Player_CombineRank", 0)) )
		
		-- -- Radio
		-- local newMainRad = math.random(51,99)
		-- local newSubRad = math.random(1,50)
		-- SetGlobalString("Rised_MainRadioChannel", newMainRad)
		-- SetGlobalString("Rised_SubRadioChannel", newSubRad)
		
		-- for k,v in pairs(player.GetAll()) do
			-- if((v:IsPlayer())and(v:Alive())and(v.HasWeapon)and(v:HasWeapon("wep_jack_job_drpradio")) and GAMEMODE.Rebels[v:Team()])then
				-- local Wep=v:GetWeapon("wep_jack_job_drpradio")
				-- Wep:SetChannel(math.Clamp(newMainRad,1,100))
			-- end
		-- end
		
		--self.Owner:SetModel("models/player/metropolice/c08.mdl")
		--self.Owner:SetModel("models/metropolice/c08.mdl")
		
		-- if self.Owner:GetNWBool("asd") then
			-- self.Owner:SetNWBool("asd", false)
			-- -- Выключение света --
			-- for k,v in pairs(ents.FindByName("spot_test")) do
				-- v:Fire("TurnOff")
			-- end
			
			-- for k,v in pairs(ents.FindByName("street_sprite")) do
				-- v:Fire("HideSprite")
			-- end
			
			-- for k,v in pairs(ents.FindByName("street_spotlight")) do
				-- v:Fire("LightOff")
			-- end
			
			-- for k,v in pairs(ents.FindByName("day_lamp")) do
				-- v:Fire("Disable")
			-- end
			
			-- for k,v in pairs(ents.FindByName("night_lamp")) do
				-- v:Fire("Enable")
			-- end
			
			-- for k,v in pairs(ents.FindByName("street_light_prop")) do
				-- v:SetSkin(1)
			-- end
			
			-- for k,v in pairs(ents.FindByName("street_light_prop2")) do
				-- v:SetSkin(0)
			-- end
		-- else
			-- self.Owner:SetNWBool("asd", true)
			-- -- Включение света --
			-- for k,v in pairs(ents.FindByName("spot_test")) do
				-- v:Fire("TurnOn")
			-- end
			
			-- for k,v in pairs(ents.FindByName("street_sprite")) do
				-- v:Fire("ShowSprite")
			-- end
			
			-- for k,v in pairs(ents.FindByName("street_spotlight")) do
				-- v:Fire("LightOn")
			-- end
			
			-- for k,v in pairs(ents.FindByName("day_lamp")) do
				-- v:Fire("Enable")
			-- end
			
			-- for k,v in pairs(ents.FindByName("night_lamp")) do
				-- v:Fire("Disable")
			-- end
			
			-- for k,v in pairs(ents.FindByName("street_light_prop")) do
				-- v:SetSkin(0)
			-- end
			
			-- for k,v in pairs(ents.FindByName("street_light_prop2")) do
				-- v:SetSkin(1)
			-- end
		-- end
		
		
		--self.Owner:ChatPrint( tostring(trEntity:GetOwner()) )
		
		
		
		--local user = MySQLite.query("SELECT * FROM darkrp_player WHERE uid =" .. self.Owner:UniqueID())
		--local Players = MySQLite.query("SELECT * FROM darkrp_player")
		
		-- for k,v in pairs(Players) do
			-- local _amount = 50
			-- local _id = v.uid
			-- if tonumber(v.wallet) >= 3000 then
				-- _amount = 50
				-- PrintTable(v)
			-- end
				-- PrintTable(v)
			-- MySQLite.query([[UPDATE darkrp_player SET wallet = ]] .. _amount .. [[ WHERE uid = ]] .. _id)
		-- end
		
		--self.Owner:SetWalkSpeed(60)

		--self.Owner:ChatPrint( "Дистанция - " .. Distance )
		--self.Owner:ChatPrint( "Дистанция - " .. Distance )
		--self.Owner:ChatPrint( "________________________________" )
		
		--local ent = ents.GetByIndex(1149)
		--self.Owner:ChatPrint( trEntity:GetClass() )

		--self.Owner:SetModel("models/tnb/citizens/female_17.mdl")
		--self.Owner:SetBodygroup(1,8)
		--self.Owner:SetBodygroup(2,5)
		--self.Owner:SetBodygroup(3,1)
		--self.Owner:SetBodygroup(4,2)
		
		-- local EnvSun = ents.FindByClass( "env_sun" )
		-- for k,v in pairs(EnvSun) do
			-- self.Owner:ChatPrint( tostring(v) )
			-- v:Remove()
		-- end
		
		
		--EnvSun:SetKeyValue( "fogstart", 2050)
		--EnvSun:SetKeyValue( "fogend", 3500)
		--EnvSun:SetKeyValue( "farz", 4500)
		
	end
end

function SWEP:SecondaryAttack()	
	if SERVER then
		local trEntity = self.Owner:GetEyeTrace().Entity
    	local Distance = self.Owner:EyePos():Distance(trEntity:GetPos());		
		
		self.Owner:ChatPrint( tostring(trEntity) )
		self.Owner:ChatPrint( tostring(self.Owner:GetAimVector()) )
		self.Owner:ChatPrint( self.Owner:GetModel() )



		local ply = self.Owner


		-- if trEntity:IsPlayer() then
		-- 	constraint.RemoveConstraints( trEntity, "EasyBonemerge" )
		-- 	constraint.RemoveConstraints( trEntity, "EasyBonemergeParent" )
		-- end

		-- for k,v in pairs(ents.FindInSphere(ply:GetPos(), 500)) do
		-- 	if v:GetClass() == 'prop_effect' then
		-- 		v:Remove()
		-- 	end
		-- end

		-- for k,v in pairs(ents.FindByClass("npc_antlion")) do
		-- 	v:Remove()
		-- end
	end
end

function SWEP:Reload()
	local ply = self.Owner
	local rised_room = Vector(-12630.729492, 3405.847412, -365.771790)
	local city = Vector(3851.244141, 2720.205566, 1525.335327)

	if self.can_tp then
		self.can_tp = false
		timer.Simple(1, function() self.can_tp = true end)

		if ply:GetPos():Distance(rised_room) > 1000 then
			ply:SetPos(rised_room)
		else
			ply:SetPos(city)
		end
	end
end
