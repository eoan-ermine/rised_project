-- "addons\\rised_job_system\\lua\\autorun\\client\\rjs_client.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local SELECTED_TYPE

net.Receive("Job.OpenMenu", function()
	
	if Job:GetMenu() then return end

	Job.Menu = vgui.Create("MPanelList")

	SELECTED_TYPE = net.ReadString()

	hook.Add("PlayerBindPress", "Job.PlayerBindPress", function() Job:RemoveMenu() end)
	hook.Add("OnPlayerChangedTeam", "Job.PlayerChangeTeam", function() Job:RemoveMenu() end)
	
	Job:Rebuild()

	gui.EnableScreenClicker(true)
	
	Job.Menu:FadeIn(FADE_DELAY*1.5, function()
		
	end)
end)

function Job:RemoveMenu()
	if !IsValid(Job.Menu) then return end
	Job.Menu:FadeOut(FADE_DELAY, true)
	gui.EnableScreenClicker(false)
	hook.Remove("PlayerBindPress", "Job.PlayerBindPress")
end

function Job:GetMenu()
	return Job.Menu && Job.Menu:IsValid()
end

local modelChanger = {
	["models/kerry/player/citizen/male_01.mdl"] = "models/player/tnb/citizens/male_01.mdl",
	["models/kerry/player/citizen/male_02.mdl"] = "models/player/tnb/citizens/male_02.mdl",
	["models/kerry/player/citizen/male_03.mdl"] = "models/player/tnb/citizens/male_03.mdl",
	["models/kerry/player/citizen/male_04.mdl"] = "models/player/tnb/citizens/male_04.mdl",
	["models/kerry/player/citizen/male_05.mdl"] = "models/player/tnb/citizens/male_05.mdl",
	["models/kerry/player/citizen/male_06.mdl"] = "models/player/tnb/citizens/male_06.mdl",
	["models/kerry/player/citizen/male_07.mdl"] = "models/player/tnb/citizens/male_07.mdl",
	["models/kerry/player/citizen/male_08.mdl"] = "models/player/tnb/citizens/male_08.mdl",
	["models/kerry/player/citizen/male_09.mdl"] = "models/player/tnb/citizens/male_09.mdl",
	
	["models/kerry/player/citizen/female_01.mdl"] = "models/player/tnb/citizens/female_01.mdl",
	["models/kerry/player/citizen/female_02.mdl"] = "models/player/tnb/citizens/female_02.mdl",
	["models/kerry/player/citizen/female_03.mdl"] = "models/player/tnb/citizens/female_03.mdl",
	["models/kerry/player/citizen/female_04.mdl"] = "models/player/tnb/citizens/female_04.mdl",
	["models/kerry/player/citizen/female_05.mdl"] = "models/player/tnb/citizens/female_05.mdl",
	["models/kerry/player/citizen/female_06.mdl"] = "models/player/tnb/citizens/female_06.mdl",
}

function Job:Rebuild()

	Job.Menu:Clear()

	for k, job in pairs(RPExtraTeams) do
		if job.type == SELECTED_TYPE or (k == TEAM_CITIZENXXX and SELECTED_TYPE == "Job_NPC_MPF") then
			
			if !istable(job.model) then continue end
			
			local ply_model = LocalPlayer():GetModel()
			local ply_sex = LocalPlayer():GetNWString("Player_Sex")
			local panel_mdl = vgui.Create("MModelPanel")
			
			if ( modelChanger[ply_model] != nil and table.HasValue(job.model, modelChanger[ply_model]) ) then
				panel_mdl:SetModel(modelChanger[ply_model])
			else
				local random_mdl = table.Random(job.model)
				if ply_sex == "Мужской" and table.HasValue(GAMEMODE.MaleModels, random_mdl) then
					panel_mdl:SetModel(random_mdl)
				elseif ply_sex == "Женский" and table.HasValue(GAMEMODE.FemaleModels, random_mdl) then
					panel_mdl:SetModel(random_mdl)
				else
					panel_mdl:SetModel(random_mdl)
				end
			end
			
			panel_mdl:SetHeaderText(job.name)
			
			local isCPplayers = false
			local price_text = ""
			
			for k, ply in pairs (player.GetAll()) do
				isCPplayers = false
				if ply:isCP() then
					isCPplayers = true
				end
			end

			local loyalty_unlock = true
			if job.loyaltyLevel && tonumber(LocalPlayer():GetNWInt("LoyaltyTokens", 0)) < job.loyaltyLevel then
				loyalty_unlock = false
				price_text = "Требуется ОЛ - " .. job.loyaltyLevel .. " "
			end
			
			local exp_unlock_lvl = true
			if job.exp_type && job.exp_unlock_lvl && !LevelCheck(LocalPlayer(), job.exp_unlock_lvl, job.exp_type) then
				exp_unlock_lvl = false
				local ext_type = job.exp_type == "Common" and "Обычный" or job.exp_type == "Combine" and "Альянс" or job.exp_type == "Party" and "Партия" or job.exp_type == "Rebel" and "Сопротивление"
				price_text = "Требуется уровень - " .. job.exp_unlock_lvl .. " | " .. ext_type
			end

			if loyalty_unlock && exp_unlock_lvl then
				panel_mdl:OnClick(function() LocalPlayer():ConCommand("say /"..job.command) end)
			end

			panel_mdl:SetDescText(job.description)
			panel_mdl:SetPriceText(price_text)
			panel_mdl:SetSpecText(job.specification)
			panel_mdl:SetPremiumJob(job.premiumjob)
			panel_mdl:SetDonateJob(job.donatejob)
			panel_mdl:SetExclusiveJob(job.exclusivejob)
			panel_mdl:SetJobIndex(k)
			panel_mdl:SetHeaderColor(job.color)

			local firstPositionBlacklist = {
				"models/falloutdog/falloutdog.mdl",
			}

			local jobBodygroups = {
				[TEAM_REBELNEWBIE] = {0,0,0,4,0,0,0,0,0,0,1,0,0,1},
				[TEAM_REBELSOLDAT] = {32,12,0,2,0,0,0,0,0,0,0,0,0,0},
				[TEAM_REBELENGINEER] = {33,14,1,4,0,0,0,0,0,3,0,0,0,0},
				[TEAM_REBELMEDIC] = {26,12,1,4,0,0,0,0,0,4,0,0,0,0},
				[TEAM_REBELSPY02] = {1,1,0,4,0,0,0,0,0,4,0,0,0,0},
				[TEAM_REBEL_SPEC] = {35,13,2,3,0,0,0,0,0,0,0,0,0,0},
				[TEAM_REBEL_VETERAN] = {30,15,2,7,0,0,0,0,0,0,4,0,0,0},
				[TEAM_REBELSPY01] = {},
				[TEAM_REBELJUGGER] = {},
				[TEAM_REBEL_COMMANDER] = {31,13,2,5,0,0,0,0,0,0,4,0,0,0},
				[TEAM_REBELLEADER] = {34,15,2,5,0,0,0,0,0,3,5,8,0,0},
				[TEAM_LAMBDASOLDAT] = {},
				[TEAM_LAMBDASNIPER] = {},
				[TEAM_LAMBDACOMMANDER] = {},
				[TEAM_MPF_JURY_Conscript] = {0,0,0,0,0,0,0},
				[TEAM_MPF_JURY_PVT] = {1,0,0,0,0,0,0},
				[TEAM_MPF_JURY_CPL] = {1,0,3,0,0,0,0},
				[TEAM_MPF_JURY_SGT] = {2,0,3,0,0,6,0},
				[TEAM_MPF_JURY_LT] = {2,0,3,0,0,6,0},
				[TEAM_MPF_JURY_CPT] = {4,2,0,0,1,10,0},
				[TEAM_MPF_JURY_GEN] = {6,1,1,0,2,10,0},
				[TEAM_MPF_ETHERNAL_SGT] = {1,0,3,1,0,1,0},
				[TEAM_MPF_ETHERNAL_LT] = {3,0,2,1,0,7,0},
				[TEAM_MPF_ETHERNAL_CPT] = {3,0,2,1,0,7,0},
				[TEAM_MPF_PLUNGER_SGT] = {3,0,3,0,3,2,0},
				[TEAM_MPF_PLUNGER_LT] = {2,0,2,0,1,8,0},
				[TEAM_MPF_PLUNGER_CPT] = {2,0,2,0,1,8,0},
				[TEAM_MPF_WATCHER_SGT] = {5,0,2,1,0,3,0},
				[TEAM_MPF_WATCHER_LT] = {7,0,2,1,0,11,0},
				[TEAM_MPF_WATCHER_CPT] = {7,0,2,1,0,11,0},
				[TEAM_MPF_SPIRE_SGT] = {2,1,1,0,2,11,0},
				[TEAM_MPF_SPIRE_LT] = {7,1,1,0,1,11,0},
				[TEAM_MPF_SPIRE_CPT] = {8,0,0,0,1,12,1},
			}

			if jobBodygroups[k] then
				for index,bodygroup in pairs(jobBodygroups[k]) do
					panel_mdl.Model.Entity:SetBodygroup(index, bodygroup)
				end
			end

			if panel_mdl.Model.Entity:LookupSequence("idle_all_01") != -1 and !table.HasValue(firstPositionBlacklist, panel_mdl.Model:GetModel()) then
				panel_mdl.Model.Entity:SetSequence(panel_mdl.Model.Entity:LookupSequence("idle_all_01"))
			elseif panel_mdl.Model.Entity:LookupSequence("idle_passive") != -1 then
				panel_mdl.Model.Entity:SetSequence(panel_mdl.Model.Entity:LookupSequence("idle_passive"))
			elseif panel_mdl.Model.Entity:LookupSequence("WalkUnarmed_all") != -1 then
				panel_mdl.Model.Entity:SetSequence(panel_mdl.Model.Entity:LookupSequence("WalkUnarmed_all"))
			end
			
			panel_mdl.Model:SetRotation(false)
			
			Job.Menu:AddItem(panel_mdl)
		end
	end
end