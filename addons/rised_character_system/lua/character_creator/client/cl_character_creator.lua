-- "addons\\rised_character_system\\lua\\character_creator\\client\\cl_character_creator.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[

 _____ _                          _                   _____                _             
|  __ \ |                        | |                 |  __ |              | |            
| /  \/ |__   __ _ _ __ __ _  ___| |_ ___ _ __ ______| /  \|_ __ ___  __ _| |_ ___  _ __ 
| |   | '_ \ / _` | '__/ _` |/ __| __/ _ \ '__|______| |   | '__/ _ \/ _` | __/ _ \| '__|
| \__/\ | | | (_| | | | (_| | (__| ||  __/ |         | \__/\ | |  __/ (_| | || (_) | |   
|_____/_| |_|\__,_|_|  \__,_|\___|\__\___|_|         |_____/_|  \___|\__,_|\__\___/|_|   
                                                                                                                                                                                  

]]

local CharacterCreatorInitialJob = 1
local CharacterCreatorSaveSexe = Configuration_Chc_Lang[12][CharacterCreator.CharacterLang]
local CharacterCreatorModelCreate = "models/player/hl2rp/male_01.mdl"
local CharacterCreatorMaterials = Material( "materials/CharacterCreatorPlus.png" ) 

local supported_clothes_model = {
	"models/player/hl2rp/male_01.mdl",
	"models/player/hl2rp/male_02.mdl",
	"models/player/hl2rp/male_03.mdl",
	"models/player/hl2rp/male_04.mdl",
	"models/player/hl2rp/male_05.mdl",
	"models/player/hl2rp/male_06.mdl",
	"models/player/hl2rp/male_07.mdl",
	"models/player/hl2rp/male_08.mdl",
	"models/player/hl2rp/male_09.mdl",

	"models/player/hl2rp/female_01.mdl",
	"models/player/hl2rp/female_02.mdl",
	"models/player/hl2rp/female_03.mdl",
	"models/player/hl2rp/female_04.mdl",
	"models/player/hl2rp/female_06.mdl",
	"models/player/hl2rp/female_07.mdl",
}

local supported_dotante_jobs = {
	"models/player/vortigauntslave.mdl",
	"models/rised_project/combine/rised_combine.mdl",
}

function UpdateCharacterModel(char_id, panel)
	if table.HasValue(supported_clothes_model, CharacterCreatorTab[char_id]["CharacterCreatorModelJob"]) then
		panel:SetModel( CharacterCreatorTab[char_id]["CharacterCreatorModel"] )
		
		if istable(CharacterCreatorTab[char_id]["CharacterCreatorRisedInventory"].Wear) then
			for i = 1, #CharacterCreatorTab[char_id]["CharacterCreatorRisedInventory"].Wear do
				if istable(CharacterCreatorTab[char_id]["CharacterCreatorRisedInventory"].Wear[1][i]) then
					local cloth = CharacterCreatorTab[char_id]["CharacterCreatorRisedInventory"].Wear[1][i].Clothes
					local cloth_index = CharacterCreatorTab[char_id]["CharacterCreatorRisedInventory"].Wear[1][i].Index
					local cloth_texture = CharacterCreatorTab[char_id]["CharacterCreatorRisedInventory"].Wear[1][i].Texture

					if cloth_texture != "" then
						panel.Entity:SetSubMaterial(4,cloth_texture)
						panel.Entity:SetSubMaterial(5,cloth_texture)
					else
						panel.Entity:SetBodygroup(i,cloth_index)
					end
				end
			end
		end

		if CharacterCreatorTab[char_id]["Character_FacialHair"] != nil and CharacterCreatorTab[char_id]["CharacterCreatorSaveSexe"] == "Мужской" then
			panel.Entity:SetBodygroup(14,CharacterCreatorTab[char_id]["Character_FacialHair"])
		end
	else
		panel:SetModel( CharacterCreatorTab[char_id]["CharacterCreatorModelJob"] )

		for k,v in pairs(RPExtraTeams) do
		   	if v.name == CharacterCreatorTab[char_id]["CharacterCreatorSaveJob"] then
				if k == TEAM_OTA_Soldier then
					panel.Entity:SetSkin(11)
				elseif k == TEAM_OTA_Striker then
					panel.Entity:SetSkin(10)
					panel.Entity:SetBodygroup(2,1)
					panel.Entity:SetBodygroup(3,1)
				elseif k == TEAM_OTA_Suppressor then
					panel.Entity:SetBodygroup(2,1)
					panel.Entity:SetBodygroup(3,1)
				elseif k == TEAM_OTA_Commander then
					panel.Entity:SetSkin(12)
				elseif k == TEAM_OTA_Razor then
					panel.Entity:SetSkin(1)
				elseif k == TEAM_SYNTH_GUARD then
					panel.Entity:SetBodygroup(1,1)
				elseif k == TEAM_ZOMBIE then
					panel.Entity:SetBodygroup(1,1)
				elseif k == TEAM_ZOMBIECP then
					panel.Entity:SetBodygroup(1,1)
				elseif k == TEAM_REBELJUGGER then
					panel.Entity:SetModel("models/humans/hev_mark2.mdl")
					panel.Entity:SetSkin(2)
					panel.Entity:SetBodygroup(2,1)
				elseif k == TEAM_MPF_JURY_Conscript || k == TEAM_REBELSPY01 then
					panel.Entity:SetBodyGroups("00000000")
				elseif k == TEAM_MPF_JURY_PVT then
					panel.Entity:SetBodyGroups("01000000")
				elseif k == TEAM_MPF_JURY_CPL then
					panel.Entity:SetBodyGroups("01030000")
				elseif k == TEAM_MPF_JURY_SGT then
					panel.Entity:SetBodyGroups("01030060")
				elseif k == TEAM_MPF_JURY_LT then
					panel.Entity:SetBodyGroups("01020061")
				elseif k == TEAM_MPF_JURY_CPT then
					panel.Entity:SetBodyGroups("04110190")
				elseif k == TEAM_MPF_JURY_GEN then
					panel.Entity:SetBodyGroups("061101a0")
				elseif k == TEAM_MPF_ETHERNAL_SGT then
					panel.Entity:SetBodyGroups("01031010")
				elseif k == TEAM_MPF_ETHERNAL_LT then
					panel.Entity:SetBodyGroups("03021070")
				elseif k == TEAM_MPF_ETHERNAL_CPT then
					panel.Entity:SetBodyGroups("04021070")
				elseif k == TEAM_MPF_PLUNGER_SGT then
					panel.Entity:SetBodyGroups("02030320")
				elseif k == TEAM_MPF_PLUNGER_LT then
					panel.Entity:SetBodyGroups("02020380")
				elseif k == TEAM_MPF_PLUNGER_CPT then
					panel.Entity:SetBodyGroups("04020380")
				elseif k == TEAM_MPF_WATCHER_SGT then
					panel.Entity:SetBodyGroups("07031050")
				elseif k == TEAM_MPF_WATCHER_LT then
					panel.Entity:SetBodyGroups("070210b0")
				elseif k == TEAM_MPF_WATCHER_CPT then
					panel.Entity:SetBodyGroups("060210b0")
				elseif k == TEAM_MPF_SPIRE_SGT then
					panel.Entity:SetBodyGroups("021102b0")
				elseif k == TEAM_MPF_SPIRE_LT then
					panel.Entity:SetBodyGroups("071101b0")
				elseif k == TEAM_MPF_SPIRE_CPT then
					panel.Entity:SetBodyGroups("080001c1")
				end
		   	end
		end
	end
end

function GetBackgroundImage(char_team)
	if false then
		return CharacterCreator.BackImageCWU
	elseif GAMEMODE.MetropoliceJobs[char_team] then
		return CharacterCreator.BackImageMetropolice
	elseif GAMEMODE.CombineJobs[char_team] then
		return CharacterCreator.BackImageOTA
	elseif char_team == TEAM_OWUDISPATCH then
		return CharacterCreator.BackImageDispatch
	elseif GAMEMODE.LoyaltyJobs[char_team] then
		return  CharacterCreator.BackImageLoyalty
	elseif GAMEMODE.ZombieJobs[char_team] then
		return CharacterCreator.BackImageZen
	elseif GAMEMODE.Rebels[char_team] then
		return CharacterCreator.BackImageRebels
	else
		return CharacterCreator.BackImage
	end
end

function GetLifesAmount(life_amount)
	if tonumber(life_amount) == 0 then
		return "♥"
	elseif tonumber(life_amount) == 1 then
		return "♥♥"
	elseif tonumber(life_amount) == 2 then
		return "♥♥♥"
	elseif tonumber(life_amount) == 3 then
		return "♥♥♥♥"
	elseif tonumber(life_amount) == 4 then
		return "♥♥♥♥♥"
	else
		return "?"
	end
end

function IsJobLimitReached(char_team)

	local job_limits = {
		[TEAM_CONSUL] = true,
		[TEAM_PARTYGENERALSECRETARY] = true,
		[TEAM_PARTYCOUNCILCHAIRMAN] = true,
		[TEAM_PARTYWORKSUPERVISOR] = true,
		[TEAM_MPF_JURY_GEN] = true,
		[TEAM_MPF_JURY_CPT] = true,
		[TEAM_OWUDISPATCH] = true,
		[TEAM_REBELLEADER] = true,
		[TEAM_REBELJUGGER] = true,
		[TEAM_LAMBDACOMMANDER] = true,
		[TEAM_LAMBDASNIPER] = true,
	}

	if job_limits[char_team] then
		for k, v in pairs(player.GetAll()) do
			if job_limits[v:Team()] then 
				return true
			end
		end
	end
	-- if GAMEMODE.Rebels[char_team] then
	-- 	local combines = 1
	-- 	local rebels = 0
	-- 	for k, v in pairs(player.GetAll()) do
	-- 		if v:isCP() then
	-- 			combines = combines + 1
	-- 		end

	-- 		if GAMEMODE.Rebels[v:Team()] then
	-- 			rebels = rebels + 1
	-- 		end
	-- 	end

	-- 	if combines - rebels < 1 and rebels >= 1 then
	-- 		return true
	-- 	end
	-- end

	return false
end

function CharacterCreator.MenuSpawn()
	RunConsoleCommand("stopsound")
	if CharacterCreator.MusicMenuActivate then 
		sound.PlayURL( CharacterCreator.MusicMenu, "", 
		function( station )
			if IsValid( station ) then
				station:Play()
				station:SetVolume(CharacterCreator.MusicMenuVolume)
			end 
		end )
	end 
	local CharacterCreatorRemoveConfirmation1 = nil
	local CharacterCreatorRemoveConfirmation2 = nil
	local CharacterCreatorRemoveConfirmation3 = nil
	local CharacterCreatorIdSave = nil

	if IsValid(CharacterFrameBaseParent) then return false end 

	local CharacterFrameBaseParent = vgui.Create("DFrame")
	CharacterFrameBaseParent:SetSize(ScrW()*1, ScrH()*1)
	CharacterFrameBaseParent:SetPos(0,0)
	CharacterFrameBaseParent:ShowCloseButton(false)
	CharacterFrameBaseParent:SetDraggable(false)
	CharacterFrameBaseParent:SetTitle("")
	CharacterFrameBaseParent:MakePopup()
	gui.EnableScreenClicker(true)
	CharacterFrameBaseParent.Paint = function(self,w,h) end 

	local CharacterCreatorFrameBlack = vgui.Create( "DPanel", CharacterFrameBaseParent )
	CharacterCreatorFrameBlack:SetSize( ScrW()*1, ScrH()*1 )
	CharacterCreatorFrameBlack:SetPos(0,0)
	CharacterCreatorFrameBlack:SetBackgroundColor( CharacterCreator.Colors["black"] )

	local CharacterCreatorImage = vgui.Create( "Material", CharacterCreatorFrameBlack )
	CharacterCreatorImage:SetPos( 0, 0 )
	CharacterCreatorImage:SetSize( ScrW()*1, ScrH()*1 )
	CharacterCreatorImage:SetMaterial( CharacterCreator.BackImage )
	CharacterCreatorImage.AutoSize = false

	local CharacterCreatorMenuSpawn = vgui.Create("DPanel", CharacterFrameBaseParent)
	CharacterCreatorMenuSpawn:SetSize(ScrW()*1, ScrH()*1)
	CharacterCreatorMenuSpawn:SetPos(0,0)
	CharacterCreatorMenuSpawn.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(0,0,0,120))
		draw.DrawText("R I S E D   P R O J E C T", "marske8",ScrW()*0.035, ScrH()*0.93, Color(0,0,0,120), TEXT_ALIGN_LEFT)
	end 

	local CharacterCreatorEntete = vgui.Create("DPanel", CharacterFrameBaseParent)
	CharacterCreatorEntete:SetSize(ScrW()*0.95, ScrH()*0.1)
	CharacterCreatorEntete:SetPos(ScrW()*0.03,ScrH()*0.03)
	CharacterCreatorEntete.Paint = function(self, w, h)
	end

	local CharacterCreatorModel = vgui.Create( "DModelPanel", CharacterFrameBaseParent )
	CharacterCreatorModel:SetPos(  ScrW() * 0.7, ScrH() * 0.2 )
	CharacterCreatorModel:SetSize( ScrW() * 0.2, ScrH() * 0.7 )
	CharacterCreatorModel:SetFOV( 6.4 )
	CharacterCreatorModel:SetCamPos( Vector( 310, 100, 45 ) )
	CharacterCreatorModel:SetLookAt( Vector( 0, 0, 36 ) )
	function CharacterCreatorModel:LayoutEntity( ent ) end

	for i=1,3 do 
		local CharacterCreatorButton = vgui.Create("DButton", CharacterFrameBaseParent)
		CharacterCreatorButton:SetText("\n \n "..Configuration_Chc_Lang[13][CharacterCreator.CharacterLang])
		CharacterCreatorButton:SetFont("marske6")
		CharacterCreatorButton:SetTextColor(CharacterCreator.Colors["white"])
		CharacterCreatorButton:SetSize(ScrW()*0.2, ScrH()*0.5)
		
		if i == 1 then
			if LocalPlayer():GetNWString("CharacterCreator1") == "Player1Create" then 
				
				local CharacterCreatorTeam = 0
				CharacterCreatorButton:Remove()
				local CharacterCreatorDPanelInfo1 = vgui.Create("DPanel", CharacterFrameBaseParent)
				CharacterCreatorDPanelInfo1:SetPos(ScrW()*0.03, ScrH()*0.3)
				CharacterCreatorDPanelInfo1:SetSize(ScrW()*0.2, ScrH()*0.5)
				CharacterCreatorDPanelInfo1.Paint = function(self,w,h)
					if !CharacterCreatorTab then return end
					draw.RoundedBox(5, 0, 0, w, h, CharacterCreator.Colors["black180"])
					if isstring(CharacterCreatorTab[1]["CharacterCreatorName"]) and isstring(CharacterCreatorTab[1]["CharacterCreatorSaveJob"]) then 
						draw.DrawText(CharacterCreatorTab[1]["CharacterCreatorName"], "marske5",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.01, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
						draw.DrawText(CharacterCreatorTab[1]["CharacterCreatorSaveJob"], "marske4",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.04, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
						
						local LifesText = GetLifesAmount(CharacterCreatorTab[1]["CharacterCreatorSaveLifes"])
						
						for k,v in pairs(RPExtraTeams) do
							if v.name == CharacterCreatorTab[1]["CharacterCreatorSaveJob"] then
								CharacterCreatorTeam = k
								break
							end
						end 
						
						if IsJobLimitReached(CharacterCreatorTeam) then
							draw.DrawText("Лимит профессии", "marske4",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.472, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
							draw.DrawText("Вы станете ниже рангом", "marske4",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.487, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
						else
							draw.DrawText("  [  " .. LifesText .. "  ]  ", "marske4",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.475, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
						end
					else 
						draw.DrawText("NILL NILL", "chc_kobralost_2",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.03, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
					end 
				end 
				local CharacterCreatorRemove = vgui.Create("DButton", CharacterCreatorDPanelInfo1)
				CharacterCreatorRemove:SetPos(CharacterCreatorDPanelInfo1:GetWide()*0.91, 0 ) 
				CharacterCreatorRemove:SetSize(ScrW()*0.02, ScrH()*0.03)
				CharacterCreatorRemove:SetText("")
				CharacterCreatorRemove:SetImage( "icon16/cancel.png" )
				CharacterCreatorRemove.Paint = function() end 
				CharacterCreatorRemove.DoClick = function()
					CharacterCreatorRemove:SetImage( "icon16/accept.png" )
					timer.Simple(0.1, function()
						CharacterCreatorRemoveConfirmation1 = 1 
					end ) 
					if CharacterCreatorRemoveConfirmation1 == 1 then
						net.Start("CharacterCreator:DeleteCharacterClient")
						net.WriteInt(i, 8)
						net.SendToServer()
						CharacterFrameBaseParent:Remove()
					end 
				end 
				local CharacterCreatorModelLoad1 = vgui.Create( "DModelPanel", CharacterFrameBaseParent )
				CharacterCreatorModelLoad1:SetPos(ScrW()*0.03, ScrH()*0.32)
				CharacterCreatorModelLoad1:SetSize(ScrW()*0.2, ScrH()*0.5)
				CharacterCreatorModelLoad1:SetFOV( 12 )
				CharacterCreatorModelLoad1:SetCamPos( Vector( 310, 10, 45 ) )
				CharacterCreatorModelLoad1:SetLookAt( Vector( 0, 0, 36 ) )
				timer.Simple(0.2, function()
					UpdateCharacterModel(1, CharacterCreatorModelLoad1)
				end)

				function CharacterCreatorModelLoad1:LayoutEntity( ent ) end
				CharacterCreatorModelLoad1.DoClick = function()
					CharacterCreatorIdSave = 1

					UpdateCharacterModel(1, CharacterCreatorModel)
					
					if isstring(CharacterCreatorTab[1]["CharacterCreatorModel"]) then
						CharacterCreatorImage:SetMaterial( GetBackgroundImage(CharacterCreatorTeam) )
					end
					
					CharacterCreatorDPanelInfo1.Paint = function(self,w,h)
						if !CharacterCreatorTab then return end
						if CharacterCreatorIdSave == 1 then 
							draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
							if isstring(CharacterCreatorTab[1]["CharacterCreatorName"]) and isstring(CharacterCreatorTab[1]["CharacterCreatorSaveJob"]) then 
								draw.DrawText(CharacterCreatorTab[1]["CharacterCreatorName"], "marske5",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.01, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
								draw.DrawText(CharacterCreatorTab[1]["CharacterCreatorSaveJob"], "marske4",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.04, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
						
								local LifesText = GetLifesAmount(CharacterCreatorTab[1]["CharacterCreatorSaveLifes"])
								
								local CharacterCreatorTeam = 0
								for k,v in pairs(RPExtraTeams) do
									if v.name == CharacterCreatorTab[1]["CharacterCreatorSaveJob"] then
										CharacterCreatorTeam = k
										break
									end
								end 
						
								if IsJobLimitReached(CharacterCreatorTeam) then
									draw.DrawText("Лимит профессии", "marske4",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.472, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
									draw.DrawText("Вы станете ниже рангом", "marske4",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.487, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
								else
									draw.DrawText("  [  " .. LifesText .. "  ]  ", "marske4",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.475, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
								end
							else 
								draw.DrawText("NILL NILL", "chc_kobralost_2",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.03, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
							end 
							surface.SetDrawColor(CharacterCreator.Colors["whitegray"])
							surface.DrawOutlinedRect( 0, 0, w, h )
						else 
							draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
							if isstring(CharacterCreatorTab[1]["CharacterCreatorName"]) and isstring(CharacterCreatorTab[1]["CharacterCreatorSaveJob"]) then 
								draw.DrawText(CharacterCreatorTab[1]["CharacterCreatorName"], "marske5",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.01, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
								draw.DrawText(CharacterCreatorTab[1]["CharacterCreatorSaveJob"], "marske4",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.04, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)						
								
								local LifesText = GetLifesAmount(CharacterCreatorTab[1]["CharacterCreatorSaveLifes"])

								local CharacterCreatorTeam = 0
								for k,v in pairs(RPExtraTeams) do
									if v.name == CharacterCreatorTab[1]["CharacterCreatorSaveJob"] then
										CharacterCreatorTeam = k
										break
									end
								end
                                
								if IsJobLimitReached(CharacterCreatorTeam) then
									draw.DrawText("Лимит профессии", "marske4",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.472, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
									draw.DrawText("Вы станете ниже рангом", "marske4",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.487, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
								else
									draw.DrawText("  [  " .. LifesText .. "  ]  ", "marske4",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.475, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
								end
							else
								draw.DrawText("NILL NILL", "chc_kobralost_2",CharacterCreatorDPanelInfo1:GetWide()/2, ScrH()*0.03, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
							end
						end
					end
				end
			else
				CharacterCreatorButton:SetPos(ScrW()*0.03*i, ScrH()*0.3)
				CharacterCreatorButton.DoClick = function()
					CharacterFrameBaseParent:Remove()
					CharacterCreator.CreateCharacter(i)
					surface.PlaySound( "UI/buttonclick.wav" )
				end
				CharacterCreatorButton.Paint = function(self,w,h)
					if self:IsHovered() then
						draw.RoundedBox(10, 0, 0, w, h, CharacterCreator.Colors["blackgray240"])
						surface.SetDrawColor( CharacterCreator.Colors["white"] )
						surface.SetMaterial( CharacterCreatorMaterials ) 
						surface.DrawTexturedRect( ScrW()*0.082, ScrH()*0.15, 75, 75 )
					else
						draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
						surface.SetDrawColor( CharacterCreator.Colors["white"] )
						surface.SetMaterial( CharacterCreatorMaterials )
						surface.DrawTexturedRect( ScrW()*0.082, ScrH()*0.15, 75, 75 )
					end
				end			
			end
		elseif i == 2 then
			
			-- if !LocalPlayer():GetNWBool("Rised_SecondSlot") then
			-- 	CharacterCreatorButton:Remove()
			-- end

			if LocalPlayer():GetNWString("CharacterCreator2") == "Player2Create" then
				CharacterCreatorButton:Remove()
				local CharacterCreatorDPanelInfo2 = vgui.Create("DPanel", CharacterFrameBaseParent)
				local CharacterCreatorTeam = 0
				CharacterCreatorDPanelInfo2:SetPos(ScrW()*0.234, ScrH()*0.3)
				CharacterCreatorDPanelInfo2:SetSize(ScrW()*0.2, ScrH()*0.5)
				CharacterCreatorDPanelInfo2.Paint = function(self,w,h)
					if !CharacterCreatorTab then return end
					draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
					if isstring(CharacterCreatorTab[2]["CharacterCreatorName"]) and isstring(CharacterCreatorTab[2]["CharacterCreatorSaveJob"]) then 
						draw.DrawText(CharacterCreatorTab[2]["CharacterCreatorName"], "marske5",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.01, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
						draw.DrawText(CharacterCreatorTab[2]["CharacterCreatorSaveJob"], "marske4",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.04, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)						
						
						local LifesText = GetLifesAmount(CharacterCreatorTab[2]["CharacterCreatorSaveLifes"])
						
						for k,v in pairs(RPExtraTeams) do
							if v.name == CharacterCreatorTab[2]["CharacterCreatorSaveJob"] then
								CharacterCreatorTeam = k
								break
							end
						end 
						
						
						if IsJobLimitReached(CharacterCreatorTeam) then
							draw.DrawText("Лимит профессии", "marske4",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.472, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
							draw.DrawText("Вы станете ниже рангом", "marske4",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.487, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
						else
							draw.DrawText("  [  " .. LifesText .. "  ]  ", "marske4",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.475, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
						end
					else 
						draw.DrawText("NILL NILL", "chc_kobralost_2",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.03, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
					end 
				end 	
				local CharacterCreatorRemove = vgui.Create("DButton", CharacterCreatorDPanelInfo2)
				CharacterCreatorRemove:SetPos(CharacterCreatorDPanelInfo2:GetWide()*0.91, 0 ) 
				CharacterCreatorRemove:SetSize(ScrW()*0.02, ScrH()*0.03)
				CharacterCreatorRemove:SetText("")
				CharacterCreatorRemove:SetImage( "icon16/cancel.png" )
				CharacterCreatorRemove.Paint = function() end 
				CharacterCreatorRemove.DoClick = function()
					CharacterCreatorRemove:SetImage( "icon16/accept.png" )
					timer.Simple(0.1, function()
						CharacterCreatorRemoveConfirmation2 = 1 
					end ) 
					if CharacterCreatorRemoveConfirmation2 == 1 then
						net.Start("CharacterCreator:DeleteCharacterClient")
						net.WriteInt(i, 8)
						net.SendToServer()
						CharacterFrameBaseParent:Remove()
					end 
				end 
				local CharacterCreatorModelLoad2 = vgui.Create( "DModelPanel", CharacterFrameBaseParent )
				CharacterCreatorModelLoad2:SetPos(ScrW()*0.234, ScrH()*0.32)
				CharacterCreatorModelLoad2:SetSize(ScrW()*0.2, ScrH()*0.5)
				CharacterCreatorModelLoad2:SetFOV( 12 )
				CharacterCreatorModelLoad2:SetCamPos( Vector( 310, 10, 45 ) )
				CharacterCreatorModelLoad2:SetLookAt( Vector( 0, 0, 36 ) )
				
				timer.Simple(0.2, function()
					UpdateCharacterModel(2, CharacterCreatorModelLoad2)
				end)
				
				function CharacterCreatorModelLoad2:LayoutEntity( ent ) end
				CharacterCreatorModelLoad2.DoClick = function()
					CharacterCreatorIdSave = 2
					
					UpdateCharacterModel(2, CharacterCreatorModel)
					
					if isstring(CharacterCreatorTab[2]["CharacterCreatorModel"]) then
						CharacterCreatorImage:SetMaterial( GetBackgroundImage(CharacterCreatorTeam) )
					end
					
					CharacterCreatorDPanelInfo2.Paint = function(self,w,h)
						if !CharacterCreatorTab then return end
						if CharacterCreatorIdSave == 2 then 
							draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
							if isstring(CharacterCreatorTab[2]["CharacterCreatorName"]) and isstring(CharacterCreatorTab[2]["CharacterCreatorSaveJob"]) then 
								draw.DrawText(CharacterCreatorTab[2]["CharacterCreatorName"], "marske5",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.01, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
								draw.DrawText(CharacterCreatorTab[2]["CharacterCreatorSaveJob"], "marske4",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.04, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)						
								
								local LifesText = GetLifesAmount(CharacterCreatorTab[2]["CharacterCreatorSaveLifes"])
								
								for k,v in pairs(RPExtraTeams) do
									if v.name == CharacterCreatorTab[2]["CharacterCreatorSaveJob"] then
										CharacterCreatorTeam = k
										break
									end
								end 
                                
								
								if IsJobLimitReached(CharacterCreatorTeam) then
									draw.DrawText("Лимит профессии", "marske4",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.472, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
									draw.DrawText("Вы станете ниже рангом", "marske4",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.487, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
								else
								draw.DrawText("  [  " .. LifesText .. "  ]  ", "marske4",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.475, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
								end
							else 
								draw.DrawText("NILL NILL", "chc_kobralost_2",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.03, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
							end 
							surface.SetDrawColor(CharacterCreator.Colors["whitegray"])
							surface.DrawOutlinedRect( 0, 0, w, h )
						else 
							draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
							if isstring(CharacterCreatorTab[2]["CharacterCreatorName"]) and isstring(CharacterCreatorTab[2]["CharacterCreatorSaveJob"]) then 
								draw.DrawText(CharacterCreatorTab[2]["CharacterCreatorName"], "marske5",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.01, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
								draw.DrawText(CharacterCreatorTab[2]["CharacterCreatorSaveJob"], "marske4",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.04, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)						
								
								local LifesText = GetLifesAmount(CharacterCreatorTab[2]["CharacterCreatorSaveLifes"])
						
								local CharacterCreatorTeam = 0
								for k,v in pairs(RPExtraTeams) do
									if v.name == CharacterCreatorTab[2]["CharacterCreatorSaveJob"] then
										CharacterCreatorTeam = k
										break
									end
								end 
						
								
								if IsJobLimitReached(CharacterCreatorTeam) then
									draw.DrawText("Лимит профессии", "marske4",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.472, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
									draw.DrawText("Вы станете ниже рангом", "marske4",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.487, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
								else
									draw.DrawText("  [  " .. LifesText .. "  ]  ", "marske4",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.475, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
								end
							else 
								draw.DrawText("NILL NILL", "chc_kobralost_2",CharacterCreatorDPanelInfo2:GetWide()/2, ScrH()*0.03, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
							end 
						end 
					end 
				end 
			else 
				CharacterCreatorButton:SetPos(ScrW()*0.234, ScrH()*0.3)
				CharacterCreatorButton.DoClick = function()
					CharacterFrameBaseParent:Remove()	
					CharacterCreator.CreateCharacter(i)
					surface.PlaySound( "UI/buttonclick.wav" )
				end 
				CharacterCreatorButton.Paint = function(self, w,h )
					if self:IsHovered() then	
						draw.RoundedBox(10, 0, 0, w, h, CharacterCreator.Colors["blackgray240"])
						surface.SetDrawColor( CharacterCreator.Colors["white"] )	
						surface.SetMaterial( CharacterCreatorMaterials ) 
						surface.DrawTexturedRect( ScrW()*0.082, ScrH()*0.15, 75, 75 )
					else
						draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
						surface.SetDrawColor( CharacterCreator.Colors["white"] )	
						surface.SetMaterial( CharacterCreatorMaterials ) 
						surface.DrawTexturedRect( ScrW()*0.082, ScrH()*0.15, 75, 75 )
					end 
				end
			end  
		elseif i == 3 then
			
			if !CharacterCreator.Character3VIPRank[LocalPlayer():GetNWString("usergroup")] then
				CharacterCreatorButton:Remove()
			end
		
			CharacterCreatorButton:SetText("\n \n Создать")
			local CharacterCreatorDPanelInfo3Premium = vgui.Create("DPanel", CharacterCreatorButton)
			CharacterCreatorDPanelInfo3Premium:SetPos(0, 260)
			CharacterCreatorDPanelInfo3Premium:SetSize(ScrW()*0.2, 75)
			CharacterCreatorDPanelInfo3Premium.Paint = function(self,w,h)
				draw.DrawText("для выполнения работ по серверу", "marske3", CharacterCreatorDPanelInfo3Premium:GetWide()/2, 50, Color(255,255,255), TEXT_ALIGN_CENTER)
			end

			if LocalPlayer():GetNWString("CharacterCreator3") == "Player3Create" then 
				CharacterCreatorButton:Remove()
				local CharacterCreatorDPanelInfo3 = vgui.Create("DPanel", CharacterFrameBaseParent)
				local CharacterCreatorTeam = 0
				CharacterCreatorDPanelInfo3:SetPos(ScrW()*0.438, ScrH()*0.3)
				CharacterCreatorDPanelInfo3:SetSize(ScrW()*0.2, ScrH()*0.5)
				CharacterCreatorDPanelInfo3.Paint = function(self,w,h)
					if !CharacterCreatorTab then return end
					draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
					if isstring(CharacterCreatorTab[3]["CharacterCreatorName"]) and isstring(CharacterCreatorTab[3]["CharacterCreatorSaveJob"]) then 
						draw.DrawText(CharacterCreatorTab[3]["CharacterCreatorName"], "marske5",CharacterCreatorDPanelInfo3:GetWide()/2, ScrH()*0.01, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
						draw.DrawText(CharacterCreatorTab[3]["CharacterCreatorSaveJob"], "marske4",CharacterCreatorDPanelInfo3:GetWide()/2, ScrH()*0.04, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)						
					else 
						draw.DrawText("NILL NILL", "chc_kobralost_2",CharacterCreatorDPanelInfo3:GetWide()/2, ScrH()*0.03, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
					end 
				end 
				local CharacterCreatorRemove = vgui.Create("DButton", CharacterCreatorDPanelInfo3)
				CharacterCreatorRemove:SetPos(CharacterCreatorDPanelInfo3:GetWide()*0.91, 0 ) 
				CharacterCreatorRemove:SetSize(ScrW()*0.02, ScrH()*0.03)
				CharacterCreatorRemove:SetText("")
				CharacterCreatorRemove:SetImage( "icon16/cancel.png" )
				CharacterCreatorRemove.Paint = function() end 
				CharacterCreatorRemove.DoClick = function()
					CharacterCreatorRemove:SetImage( "icon16/accept.png" )
					timer.Simple(0.1, function()
						CharacterCreatorRemoveConfirmation3 = 1 
					end ) 
					if CharacterCreatorRemoveConfirmation3 == 1 then
						net.Start("CharacterCreator:DeleteCharacterClient")
						net.WriteInt(3, 8)
						net.SendToServer()
						CharacterFrameBaseParent:Remove()
					end
				end 
				local CharacterCreatorModelLoad3 = vgui.Create( "DModelPanel", CharacterFrameBaseParent )
				CharacterCreatorModelLoad3:SetPos(ScrW()*0.438, ScrH()*0.32)
				CharacterCreatorModelLoad3:SetSize(ScrW()*0.2, ScrH()*0.5)
				CharacterCreatorModelLoad3:SetFOV( 12 )
				CharacterCreatorModelLoad3:SetCamPos( Vector( 310, 10, 45 ) )
				CharacterCreatorModelLoad3:SetLookAt( Vector( 0, 0, 36 ) )
				timer.Simple(0.2, function()
					UpdateCharacterModel(3, CharacterCreatorModelLoad3)
				end)
				
				function CharacterCreatorModelLoad3:LayoutEntity( ent ) end
				CharacterCreatorModelLoad3.DoClick = function()
					if !CharacterCreator.Character3VIPRank[LocalPlayer():GetNWString("usergroup")] then
						if !LocalPlayer():GetNWBool("Rised_Premium") then surface.PlaySound( "buttons/combine_button1.wav" ) return end
					end
					CharacterCreatorIdSave = 3
					
					UpdateCharacterModel(3, CharacterCreatorModel)
					
					if isstring(CharacterCreatorTab[3]["CharacterCreatorModel"]) then
						CharacterCreatorImage:SetMaterial( GetBackgroundImage(CharacterCreatorTeam) )
					end
					
					CharacterCreatorDPanelInfo3.Paint = function(self,w,h)
						if !CharacterCreatorTab then return end
						if CharacterCreatorIdSave == 3 then 
							draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
							if isstring(CharacterCreatorTab[3]["CharacterCreatorName"]) and isstring(CharacterCreatorTab[3]["CharacterCreatorSaveJob"]) then 
								draw.DrawText(CharacterCreatorTab[3]["CharacterCreatorName"], "marske5",CharacterCreatorDPanelInfo3:GetWide()/2, ScrH()*0.01, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
								draw.DrawText(CharacterCreatorTab[3]["CharacterCreatorSaveJob"], "marske4",CharacterCreatorDPanelInfo3:GetWide()/2, ScrH()*0.04, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)						
							else 
								draw.DrawText("NILL NILL", "chc_kobralost_2",CharacterCreatorDPanelInfo3:GetWide()/2, ScrH()*0.03, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
							end 
							surface.SetDrawColor(CharacterCreator.Colors["whitegray"])
							surface.DrawOutlinedRect( 0, 0, w, h )
						else 
							draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
							if isstring(CharacterCreatorTab[3]["CharacterCreatorName"]) and isstring(CharacterCreatorTab[3]["CharacterCreatorSaveJob"]) then 
								draw.DrawText(CharacterCreatorTab[3]["CharacterCreatorName"], "marske5",CharacterCreatorDPanelInfo3:GetWide()/2, ScrH()*0.01, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
								draw.DrawText(CharacterCreatorTab[3]["CharacterCreatorSaveJob"], "marske4",CharacterCreatorDPanelInfo3:GetWide()/2, ScrH()*0.04, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)						
							else 
								draw.DrawText("NILL NILL", "chc_kobralost_2",CharacterCreatorDPanelInfo3:GetWide()/2, ScrH()*0.03, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER)
							end 
						end
					end 
				end 			
			else
				CharacterCreatorButton:SetPos(ScrW()*0.438, ScrH()*0.3)
				CharacterCreatorButton.DoClick = function()
					CharacterFrameBaseParent:Remove()
					CharacterCreator.CreateWorker()
					surface.PlaySound( "UI/buttonclick.wav" )
				end
				CharacterCreatorButton.Paint = function(self, w,h )
					if self:IsHovered() then	
						draw.RoundedBox(10, 0, 0, w, h, CharacterCreator.Colors["blackgray240"])
						surface.SetDrawColor(CharacterCreator.Colors["white"])	
						surface.SetMaterial( CharacterCreatorMaterials ) 
						surface.DrawTexturedRect( ScrW()*0.082, ScrH()*0.15, 75, 75 )
					else
						draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
						surface.SetDrawColor(CharacterCreator.Colors["white"])	
						surface.SetMaterial( CharacterCreatorMaterials ) 
						surface.DrawTexturedRect( ScrW()*0.082, ScrH()*0.15, 75, 75 )
					end
				end
			end
		end
	end

	local CharacterCreatorPlaceText = vgui.Create("DPanel", CharacterFrameBaseParent)
	CharacterCreatorPlaceText:SetSize(ScrW()*0.405, ScrH()*0.16)
	CharacterCreatorPlaceText:SetPos(ScrW()*0.03, ScrH()*0.83)
	CharacterCreatorPlaceText.Paint = function(self, w, h)
	end 

	local CharacterCreatorText = vgui.Create( "DLabel", CharacterCreatorPlaceText )
	CharacterCreatorText:SetPos( ScrW()*0.01, ScrH()*0.06 )
	CharacterCreatorText:SetSize( ScrW()*0.40, ScrH()*0.1 )
	CharacterCreatorText:SetFont( "chc_kobralost_4" )
	CharacterCreatorText:SetText( "" )	
	CharacterCreatorText:SetTextColor(CharacterCreator.Colors["white150"])
	CharacterCreatorText:SetContentAlignment( 7 ) 
	CharacterCreatorText:SetWrap( true )

	local CharacterCreatorDscrollPanel = vgui.Create("DScrollPanel", CharacterFrameBaseParent)
	CharacterCreatorDscrollPanel:SetSize(ScrW()*0.7, ScrH()*0.1)
	CharacterCreatorDscrollPanel:SetPos(ScrW()*0.03,ScrH()*0.87)
	CharacterCreatorDscrollPanel.Paint = function(self,w,h) end

	CharacterCreator.FrameButton = {}

	for k,v in pairs(CharacterCreator.Bouttons) do

		CharacterCreator.FrameButton[k] = vgui.Create("DPanel", CharacterCreatorDscrollPanel)
		CharacterCreator.FrameButton[k]:SetSize(ScrW()*0.134, ScrH()*0.05)
		CharacterCreator.FrameButton[k]:Dock(LEFT)
		CharacterCreator.FrameButton[k]:DockMargin(0, 0, 4, 0)
		CharacterCreator.FrameButton[k].Paint = function(self,w,h) end
		local CharacterCreatorButtonInfo = vgui.Create("DButton", CharacterCreator.FrameButton[k] )
		CharacterCreatorButtonInfo:SetText(v.NameButton)
		CharacterCreatorButtonInfo:SetFont("marske4")
		CharacterCreatorButtonInfo:SetTextColor(CharacterCreator.Colors["white"])
		CharacterCreatorButtonInfo:SetSize(ScrW()*0.14, ScrH()*0.05)
		CharacterCreatorButtonInfo.Paint = function(self,w,h)
			if self:IsHovered() then
				draw.RoundedBox(0, 0, 0, w, h, CharacterCreator.Colors["black160"])
			else
				draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
			end 
		end 
		CharacterCreatorButtonInfo.DoClick = function()
			gui.OpenURL(v.UrlButton)
			surface.PlaySound( "UI/buttonclick.wav" )
		end 
	end

	local CharacterCreatorButtonQuit = vgui.Create("DButton", CharacterCreatorEntete )
	CharacterCreatorButtonQuit:SetFont("marske6")
	CharacterCreatorButtonQuit:SetTextColor(CharacterCreator.Colors["white"])
	CharacterCreatorButtonQuit:SetSize(ScrW()*0.12, ScrH()*0.05)
	CharacterCreatorButtonQuit:SetPos(ScrW()*0.83, 0)
	CharacterCreatorButtonQuit:SetText("Меню")
	CharacterCreatorButtonQuit.Paint = function(self,w,h)
		if self:IsHovered() then		
			draw.RoundedBox(4, 0, 0, w, h, CharacterCreator.Colors["black160"])
		else
			draw.RoundedBox(0, 0, 0, w, h, CharacterCreator.Colors["black110"])
		end 
	end 
	CharacterCreatorButtonQuit.DoClick = function()
		gui.HideGameUI()
		OpenEscape()
		gui.HideGameUI()

		timer.Simple(0.4, function()
			surface.PlaySound( "buttons/combine_button1.wav" )
			gui.EnableScreenClicker(false)
			CharacterFrameBaseParent:Remove()
		end)
	end 
	local CharacterCreatorButtonAccept = vgui.Create("DButton", CharacterFrameBaseParent)
	CharacterCreatorButtonAccept:SetSize(ScrW()*0.2, ScrH()*0.1)
	CharacterCreatorButtonAccept:SetPos(ScrW()*0.44, ScrH()*0.83)
	CharacterCreatorButtonAccept:SetText("Выбрать")
	CharacterCreatorButtonAccept:SetFont("marske6")
	CharacterCreatorButtonAccept:SetTextColor(CharacterCreator.Colors["white"])
	CharacterCreatorButtonAccept.DoClick = function()
		if CharacterCreatorIdSave == 1 or CharacterCreatorIdSave == 2 or CharacterCreatorIdSave == 3 then 
			
			LocalPlayer():ScreenFade(SCREENFADE.IN, color_black, 7, 2)
			timer.Simple(0.1, function()
				net.Start("CharacterCreator:LoadCharacter")
				net.WriteInt(CharacterCreatorIdSave, 8)
				net.SendToServer()
				if LocalPlayer():GetNWBool("Player_InitialSpawn") then
					LocalPlayer():EmitSound(table.Random(RISED.Config.Music.Initial), 35)
					LocalPlayer():SetNWInt("Rised_Music_StopTime", CurTime() + 600)
				end

				LoadRadialMenu()
			end)

			timer.Simple(0.3, function()
				-- net.Start("CharacterCreator:SaveCharacter")
				-- net.WriteInt(CharacterCreatorIdSave, 8)
				-- net.SendToServer()
			end)
			
			gui.EnableScreenClicker(false)
			RunConsoleCommand("stopsound")
			CharacterFrameBaseParent:Remove()
			
		else 
			surface.PlaySound( "buttons/combine_button1.wav" )
		end 
	end 
	CharacterCreatorButtonAccept.Paint = function(self,w,h)		
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
	end
end

function CharacterCreator.CreateWorker()
	local CharacterCreatorTable = {
		CharacterCreatorName = "[Rised_Admin] - " .. LocalPlayer():SteamName(),
		CharacterCreatorSaveInitialJob = 1,
		CharacterCreatorModel = "models/player/police.mdl",
		CharacterCreatorSaveSexe = "Мужской",
		CharacterCreatorHeadId = 0,
		CharacterCreatorTorseId = 0,
		CharacterCreatorGlovesId = 0,
		CharacterCreatorTrousersId = 0,
	}

	RunConsoleCommand("stopsound")
	net.Start("CharacterCreator:SaveFirst")
	net.WriteTable(CharacterCreatorTable)
	net.WriteInt(3, 8)
	net.SendToServer()

	timer.Simple(1, function()
		RunConsoleCommand("stopsound")
		net.Start("CharacterCreator:LoadCharacter")
		net.WriteInt(3, 8)
		net.SendToServer()

		LoadRadialMenu()
	end )
	gui.EnableScreenClicker(false)
end

function CharacterCreator.CreateCharacter(id)
	CharacterCreatorSexe = 1
	CharacterCreatorHeadId = 0 
	CharacterCreatorTorseId = 0 
	CharacterCreatorGlovesId = 0 
	CharacterCreatorTrousersId = 0 

	local CharacterFrameBaseParent = vgui.Create("DFrame")
	CharacterFrameBaseParent:SetSize(ScrW()*1, ScrH()*1)
	CharacterFrameBaseParent:SetPos(0,0)
	CharacterFrameBaseParent:ShowCloseButton(true)
	CharacterFrameBaseParent:SetDraggable(false)
	CharacterFrameBaseParent:SetTitle("")
	CharacterFrameBaseParent:MakePopup()
	gui.EnableScreenClicker(true)
	CharacterFrameBaseParent.Paint = function(self,w,h) end 

	local CharacterCreatorFrameBlack = vgui.Create( "DPanel", CharacterFrameBaseParent )
	CharacterCreatorFrameBlack:SetSize( ScrW()*1, ScrH()*1 )
	CharacterCreatorFrameBlack:SetPos(0,0)
	CharacterCreatorFrameBlack:SetBackgroundColor( CharacterCreator.Colors["black"] )

	local CharacterCreatorImage = vgui.Create( "Material", CharacterCreatorFrameBlack )
	CharacterCreatorImage:SetPos( 0, 0 )
	CharacterCreatorImage:SetSize( ScrW()*1, ScrH()*1 )
	CharacterCreatorImage:SetMaterial( CharacterCreator.BackImage )
	CharacterCreatorImage.AutoSize = false

	local CharacterCreatorMenuSpawn = vgui.Create("DPanel", CharacterFrameBaseParent)
	CharacterCreatorMenuSpawn:SetSize(ScrW()*1, ScrH()*1)
	CharacterCreatorMenuSpawn:SetPos(0,0)
	CharacterCreatorMenuSpawn.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, CharacterCreator.Colors["black160"])
		draw.DrawText("Создание персонажа", "marske12",ScrW()*0.115, ScrH()*0.22, Color(255, 255, 255, 155), TEXT_ALIGN_LEFT)
		draw.DrawText("", "marske5",ScrW()*0.034, ScrH()*0.16, CharacterCreator.Colors["white"], TEXT_ALIGN_LEFT)
	end 

	local CharacterCreatorEntete = vgui.Create("DPanel", CharacterFrameBaseParent)
	CharacterCreatorEntete:SetSize(ScrW()*0.3, ScrH()*0.08)
	CharacterCreatorEntete:SetPos(ScrW()*0.1,ScrH()*0.2)
	CharacterCreatorEntete.Paint = function(self, w, h)
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
		surface.SetDrawColor(CharacterCreator.Colors["black160"])
		surface.DrawOutlinedRect( 0, 0, w, h )
	end

	local CharacterCreatorPanelSex = vgui.Create("DPanel", CharacterFrameBaseParent)
	CharacterCreatorPanelSex:SetPos(ScrW()*0.035, ScrH()*0.4)
	CharacterCreatorPanelSex:SetSize(ScrW()*0.21, ScrH()*0.08)
	CharacterCreatorPanelSex.Paint = function(self,w,h)
		surface.SetDrawColor(CharacterCreator.Colors["black180"])
		surface.DrawOutlinedRect( 0, 0, w, h )
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
		if CharacterCreatorSexe == 1 then 
			draw.DrawText(Configuration_Chc_Lang[5][CharacterCreator.CharacterLang], "marske5",CharacterCreatorPanelSex:GetWide()/2, CharacterCreatorPanelSex:GetTall()*0.4, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		elseif CharacterCreatorSexe == 2 then 
			draw.DrawText(Configuration_Chc_Lang[6][CharacterCreator.CharacterLang], "marske5",CharacterCreatorPanelSex:GetWide()/2, CharacterCreatorPanelSex:GetTall()*0.4, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end 
	end 

	local CharacterCreatorPanelJob = vgui.Create("DPanel", CharacterFrameBaseParent)
	CharacterCreatorPanelJob:SetPos(ScrW()*0.035, ScrH()*0.51)
	CharacterCreatorPanelJob:SetSize(ScrW()*0.21, ScrH()*0.08)
	CharacterCreatorPanelJob.Paint = function(self,w,h)
		surface.SetDrawColor(CharacterCreator.Colors["black180"])
		surface.DrawOutlinedRect( 0, 0, w, h )
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
		draw.DrawText(DB_Whitelist[CharacterCreatorInitialJob],  "marske5",CharacterCreatorPanelJob:GetWide()/2, CharacterCreatorPanelJob:GetTall()*0.35, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP) 
	end 

	local CharacterCreatorDscrollPanel = vgui.Create("DScrollPanel", CharacterFrameBaseParent)
	CharacterCreatorDscrollPanel:SetSize(ScrW()*0.7, ScrH()*0.1)
	CharacterCreatorDscrollPanel:SetPos(ScrW()*0.03,ScrH()*0.03)
	CharacterCreatorDscrollPanel.Paint = function(self,w,h) end

	CharacterCreator.FrameButton = {}

	local CharacterCreatorButtonQuit = vgui.Create("DButton", CharacterCreatorEntete )
	CharacterCreatorButtonQuit:SetFont("chc_kobralost_2")
	CharacterCreatorButtonQuit:SetTextColor(CharacterCreator.Colors["white"])
	CharacterCreatorButtonQuit:SetSize(ScrW()*0.12, ScrH()*0.1)
	CharacterCreatorButtonQuit:SetPos(ScrW()*0.83, 0)
	CharacterCreatorButtonQuit:SetText("")
	CharacterCreatorButtonQuit.Paint = function(self,w,h)
	end
	CharacterCreatorButtonQuit.DoClick = function()
	end

	local CharacterCreatorDtextEntryName = vgui.Create( "DTextEntry", CharacterFrameBaseParent )
	CharacterCreatorDtextEntryName:SetPos( ScrW()*0.035, ScrH()*0.3 )
	CharacterCreatorDtextEntryName:SetSize( ScrW()*0.21, ScrH()*0.08 )
	CharacterCreatorDtextEntryName:SetText( "Имя" )
	CharacterCreatorDtextEntryName:SetFont("marske6")
	CharacterCreatorDtextEntryName:SetDrawLanguageID( false )
	if CharacterCreator.CompatibilityClothesMod then 
		local CharacterCreatorRandomName = table.Random(CharacterCreator.CharacterName)
		CharacterCreatorDtextEntryName:SetEditable ( false ) 
		CharacterCreatorDtextEntryName:SetText(CharacterCreatorRandomName)
	else 
		CharacterCreatorDtextEntryName:SetEditable ( true ) 
	end 
	CharacterCreatorDtextEntryName:SetEnterAllowed( false )
	CharacterCreatorDtextEntryName.OnGetFocus = function(self) CharacterCreatorDtextEntryName:SetText("") end 
	CharacterCreatorDtextEntryName.OnLoseFocus = function(self)
		if CharacterCreatorDtextEntryName:GetText() == "" then  
			CharacterCreatorDtextEntryName:SetText("Имя")
		end
	end 
	CharacterCreatorDtextEntryName.Paint = function(self,w,h)
		surface.SetDrawColor(CharacterCreator.Colors["black160"])
		surface.DrawOutlinedRect( 0, 0, w, h )
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
		self:DrawTextEntryText(CharacterCreator.Colors["white"], CharacterCreator.Colors["white"], CharacterCreator.Colors["white"])
	end

	local CharacterCreatorDtextEntrySurName = vgui.Create( "DTextEntry", CharacterFrameBaseParent ) 
	CharacterCreatorDtextEntrySurName:SetPos( ScrW()*0.26, ScrH()*0.3 )
	CharacterCreatorDtextEntrySurName:SetSize( ScrW()*0.21, ScrH()*0.08 )
	CharacterCreatorDtextEntrySurName:SetText( "Фамилия" )
	CharacterCreatorDtextEntrySurName:SetFont("marske6")
	CharacterCreatorDtextEntrySurName:SetDrawLanguageID( false )
	if CharacterCreator.CompatibilityClothesMod then 
		local CharacterCreatorRandomSurName = table.Random(CharacterCreator.CharacterSurName)
		CharacterCreatorDtextEntrySurName:SetEditable ( false ) 
		CharacterCreatorDtextEntrySurName:SetText(CharacterCreatorRandomSurName)
	else 
		CharacterCreatorDtextEntrySurName:SetEditable ( true ) 
	end 
	CharacterCreatorDtextEntrySurName:SetEnterAllowed( false )
	CharacterCreatorDtextEntrySurName.OnGetFocus = function(self) CharacterCreatorDtextEntrySurName:SetText("") end 
	CharacterCreatorDtextEntrySurName.OnLoseFocus = function(self)
		if CharacterCreatorDtextEntrySurName:GetText() == "" then  
			CharacterCreatorDtextEntrySurName:SetText("Фамилия")
		end
	end 
	CharacterCreatorDtextEntrySurName.Paint = function(self,w,h)
		surface.SetDrawColor(CharacterCreator.Colors["black160"])
		surface.DrawOutlinedRect( 0, 0, w, h )	
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
		self:DrawTextEntryText(CharacterCreator.Colors["white"], CharacterCreator.Colors["white"], CharacterCreator.Colors["white"])
	end

	local CharacterCreatorModel = vgui.Create( "DModelPanel", CharacterFrameBaseParent )
	CharacterCreatorModel:SetPos(  ScrW() * 0.7, ScrH() * 0.2 )
	CharacterCreatorModel:SetSize( ScrW() * 0.2, ScrH() * 0.7 )
	CharacterCreatorModel:SetFOV( 6.4 )
	CharacterCreatorModel:SetCamPos( Vector( 310, 100, 45 ) )
	CharacterCreatorModel:SetLookAt( Vector( 0, 0, 36 ) )
	CharacterCreatorModelCreate = "models/player/hl2rp/male_01.mdl"
	CharacterCreatorInitialJob = 1
	CharacterCreatorModel:SetModel( CharacterCreatorModelCreate )
	function CharacterCreatorModel:LayoutEntity( ent ) end

	if not CharacterCreator.CharacterDisableBodyGroup then 
		local CharacterCreatorButtonHeadNext = vgui.Create("DButton", CharacterFrameBaseParent)
		CharacterCreatorButtonHeadNext:SetPos(  ScrW() * 0.88, ScrH() * 0.23 )
		CharacterCreatorButtonHeadNext:SetSize(ScrW()*0.021, ScrH()*0.05)
		CharacterCreatorButtonHeadNext:SetText("⧁")
		CharacterCreatorButtonHeadNext:SetFont("chc_kobralost_3")
		CharacterCreatorButtonHeadNext.DoClick = function()
			local ent = CharacterCreatorModel.Entity
			if CharacterCreatorHeadId < ent:GetBodygroupCount(5) then 
				CharacterCreatorHeadId = CharacterCreatorHeadId + 1 
			elseif CharacterCreatorHeadId > ent:GetBodygroupCount(5) - 1 then 
				CharacterCreatorHeadId = 0 
			end 
			ent:SetBodygroup( 5, CharacterCreatorHeadId )
		end 
		CharacterCreatorButtonHeadNext:SetTextColor(CharacterCreator.Colors["white"])
		CharacterCreatorButtonHeadNext.Paint = function() end 

		local CharacterCreatorButtonTorseBext = vgui.Create("DButton", CharacterFrameBaseParent)
		CharacterCreatorButtonTorseBext:SetPos(  ScrW() * 0.88, ScrH() * 0.4 )
		CharacterCreatorButtonTorseBext:SetSize(ScrW()*0.021, ScrH()*0.05)
		CharacterCreatorButtonTorseBext:SetText("⧁")
		CharacterCreatorButtonTorseBext:SetFont("chc_kobralost_3")
		CharacterCreatorButtonTorseBext.DoClick = function()
			local ent = CharacterCreatorModel.Entity
			if CharacterCreatorTorseId < ent:GetBodygroupCount(1) then 
				CharacterCreatorTorseId = CharacterCreatorTorseId + 1 
			elseif CharacterCreatorTorseId > ent:GetBodygroupCount(1) - 1 then 
				CharacterCreatorTorseId = 0 
			end 
			ent:SetBodygroup( 1, CharacterCreatorTorseId )
		end 
		CharacterCreatorButtonTorseBext:SetTextColor(CharacterCreator.Colors["white"])
		CharacterCreatorButtonTorseBext.Paint = function() end 

		local CharacterCreatorButtonGlovesNext = vgui.Create("DButton", CharacterFrameBaseParent)
		CharacterCreatorButtonGlovesNext:SetPos(  ScrW() * 0.88, ScrH() * 0.7 )
		CharacterCreatorButtonGlovesNext:SetSize(ScrW()*0.021, ScrH()*0.15)
		CharacterCreatorButtonGlovesNext:SetText("⧁")
		CharacterCreatorButtonGlovesNext:SetFont("chc_kobralost_3")
		CharacterCreatorButtonGlovesNext.DoClick = function()
			local ent = CharacterCreatorModel.Entity
			if CharacterCreatorGlovesId < ent:GetBodygroupCount(2) then 
				CharacterCreatorGlovesId = CharacterCreatorGlovesId + 1 
			elseif CharacterCreatorGlovesId > ent:GetBodygroupCount(2) - 1 then 
				CharacterCreatorGlovesId = 0 
			end 
			ent:SetBodygroup( 2, CharacterCreatorGlovesId )
		end 
		CharacterCreatorButtonGlovesNext:SetTextColor(CharacterCreator.Colors["white"])
		CharacterCreatorButtonGlovesNext.Paint = function() end 

		local CharacterCreatorButtonTrousersNext = vgui.Create("DButton", CharacterFrameBaseParent)
		CharacterCreatorButtonTrousersNext:SetPos(  ScrW() * 0.88, ScrH() * 0.52 )
		CharacterCreatorButtonTrousersNext:SetSize(ScrW()*0.021, ScrH()*0.15)
		CharacterCreatorButtonTrousersNext:SetText("⧁")
		CharacterCreatorButtonTrousersNext:SetFont("chc_kobralost_3")
		CharacterCreatorButtonTrousersNext.DoClick = function()
			local ent = CharacterCreatorModel.Entity
			if CharacterCreatorTrousersId < ent:GetBodygroupCount(3) then 
				CharacterCreatorTrousersId = CharacterCreatorTrousersId + 1 
			elseif CharacterCreatorTrousersId > ent:GetBodygroupCount(3) - 1 then 
				CharacterCreatorTrousersId = 0 
			end 
			ent:SetBodygroup( 3, CharacterCreatorTrousersId )
		end 
		CharacterCreatorButtonTrousersNext:SetTextColor(CharacterCreator.Colors["white"])
		CharacterCreatorButtonTrousersNext.Paint = function() end 

		local CharacterCreatorButtonHeadBefore = vgui.Create("DButton", CharacterFrameBaseParent)
		CharacterCreatorButtonHeadBefore:SetPos(  ScrW() * 0.69, ScrH() * 0.23 )
		CharacterCreatorButtonHeadBefore:SetSize(ScrW()*0.021, ScrH()*0.05)
		CharacterCreatorButtonHeadBefore:SetText("⧀")
		CharacterCreatorButtonHeadBefore:SetFont("chc_kobralost_3")
		CharacterCreatorButtonHeadBefore.DoClick = function()
			local ent = CharacterCreatorModel.Entity
			if CharacterCreatorHeadId != 0 then 
				CharacterCreatorHeadId = CharacterCreatorHeadId - 1 
			elseif CharacterCreatorHeadId == 0 then 
				CharacterCreatorHeadId = ent:GetBodygroupCount(5)
			end 
			ent:SetBodygroup( 5, CharacterCreatorHeadId )
		end 
		CharacterCreatorButtonHeadBefore:SetTextColor(CharacterCreator.Colors["white"])
		CharacterCreatorButtonHeadBefore.Paint = function() end 

		local CharacterCreatorButtonTorseBefore = vgui.Create("DButton", CharacterFrameBaseParent)
		CharacterCreatorButtonTorseBefore:SetPos(  ScrW() * 0.69, ScrH() * 0.4 )
		CharacterCreatorButtonTorseBefore:SetSize(ScrW()*0.021, ScrH()*0.05)
		CharacterCreatorButtonTorseBefore:SetText("⧀")
		CharacterCreatorButtonTorseBefore:SetFont("chc_kobralost_3")
		CharacterCreatorButtonTorseBefore.DoClick = function()
			local ent = CharacterCreatorModel.Entity
			if CharacterCreatorTorseId != 0 then 
				CharacterCreatorTorseId = CharacterCreatorTorseId - 1
			elseif CharacterCreatorTorseId == 0 then 
				CharacterCreatorTorseId = ent:GetBodygroupCount(1) 
			end 
			ent:SetBodygroup( 1, CharacterCreatorTorseId )
		end 
		CharacterCreatorButtonTorseBefore:SetTextColor(CharacterCreator.Colors["white"])
		CharacterCreatorButtonTorseBefore.Paint = function() end 

		local CharacterCreatorButtonGlovesBefore = vgui.Create("DButton", CharacterFrameBaseParent)
		CharacterCreatorButtonGlovesBefore:SetPos(  ScrW() * 0.69, ScrH() * 0.7 )
		CharacterCreatorButtonGlovesBefore:SetSize(ScrW()*0.021, ScrH()*0.15)
		CharacterCreatorButtonGlovesBefore:SetText("⧀")
		CharacterCreatorButtonGlovesBefore:SetFont("chc_kobralost_3")
		CharacterCreatorButtonGlovesBefore.DoClick = function()
			local ent = CharacterCreatorModel.Entity
			if CharacterCreatorGlovesId != 0 then 
				CharacterCreatorGlovesId = CharacterCreatorGlovesId - 1 
			elseif CharacterCreatorGlovesId == 0 then 
				CharacterCreatorGlovesId = ent:GetBodygroupCount(2) 
			end 
			ent:SetBodygroup( 2, CharacterCreatorGlovesId )
		end 
		CharacterCreatorButtonGlovesBefore:SetTextColor(CharacterCreator.Colors["white"])
		CharacterCreatorButtonGlovesBefore.Paint = function() end 

		local CharacterCreatorButtonTrousersBefore = vgui.Create("DButton", CharacterFrameBaseParent)
		CharacterCreatorButtonTrousersBefore:SetPos(  ScrW() * 0.69, ScrH() * 0.52 )
		CharacterCreatorButtonTrousersBefore:SetSize(ScrW()*0.021, ScrH()*0.15)
		CharacterCreatorButtonTrousersBefore:SetText("⧀")
		CharacterCreatorButtonTrousersBefore:SetFont("chc_kobralost_3")
		CharacterCreatorButtonTrousersBefore.DoClick = function()
			local ent = CharacterCreatorModel.Entity
			if CharacterCreatorTrousersId != 0 then 
				CharacterCreatorTrousersId = CharacterCreatorTrousersId - 1 
			elseif CharacterCreatorTrousersId == 0 then 
				CharacterCreatorTrousersId = ent:GetBodygroupCount(3)  
			end 
			ent:SetBodygroup( 3, CharacterCreatorTrousersId )
		end 
		CharacterCreatorButtonTrousersBefore:SetTextColor(CharacterCreator.Colors["white"])
		CharacterCreatorButtonTrousersBefore.Paint = function() end 
	end 

	local CharacterCreatorScrollModel = vgui.Create( "DScrollPanel", CharacterFrameBaseParent )
	CharacterCreatorScrollModel:SetPos( ScrW()*0.26, ScrH()*0.4 )
	CharacterCreatorScrollModel:SetSize( CharacterCreatorDtextEntrySurName:GetWide(), ScrH()*0.4 )
	CharacterCreatorScrollModel.Paint = function(self,w,h)
		surface.SetDrawColor(CharacterCreator.Colors["black160"])
		surface.DrawOutlinedRect( 0, 0, w, h )
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
	end 

	local KobraCharacterCreatorModel = vgui.Create( "DIconLayout", CharacterCreatorScrollModel )
	KobraCharacterCreatorModel:Dock(FILL)
	KobraCharacterCreatorModel:SetSpaceY( 5 )
	KobraCharacterCreatorModel:SetSpaceX( 5 )

	for k, v in pairs(CharacterCreator.Models[1]) do 
		local CharacterCreatorListItem = KobraCharacterCreatorModel:Add( "SpawnIcon" ) 
		CharacterCreatorListItem:SetSize( ScrW()*0.04, ScrH()*0.07 )
		CharacterCreatorListItem:SetModel(v)
		CharacterCreatorListItem.DoClick = function()
			CharacterCreatorModel:SetModel( v )
			CharacterCreatorModelCreate = v
			CharacterCreatorModelChoose = true
		end
	end

	local CharacterCreatorButton1 = vgui.Create("DButton", CharacterFrameBaseParent)
	CharacterCreatorButton1:SetFont("chc_kobralost_9")
	CharacterCreatorButton1:SetTextColor(CharacterCreator.Colors["white"])
	CharacterCreatorButton1:SetSize(ScrW()*0.02, ScrH()*0.05)
	CharacterCreatorButton1:SetPos(ScrW()*0.035, ScrH()*0.4132)
	CharacterCreatorButton1:SetText("◄")
	CharacterCreatorButton1.DoClick = function()
		if CharacterCreatorInitialJob == 1 then
			KobraCharacterCreatorModel:Clear()
			if CharacterCreatorSexe == 1 then
				CharacterCreatorSexe = 2
				CharacterCreatorModel:SetModel( "models/player/hl2rp/female_01.mdl" )
				CharacterCreatorModelCreate = "models/player/hl2rp/female_01.mdl"
				CharacterCreatorModelChoose = true
			elseif CharacterCreatorSexe == 2 then
				CharacterCreatorSexe = 1
				CharacterCreatorModel:SetModel( "models/player/hl2rp/male_01.mdl" )
				CharacterCreatorModelCreate = "models/player/hl2rp/male_01.mdl"
				CharacterCreatorModelChoose = true
			end 

			for k, v in pairs(CharacterCreator.Models[CharacterCreatorSexe]) do
				local CharacterCreatorListItem = KobraCharacterCreatorModel:Add( "SpawnIcon" )
				CharacterCreatorListItem:SetSize( ScrW()*0.04, ScrH()*0.07 )
				CharacterCreatorListItem:SetModel(v)
				CharacterCreatorListItem.DoClick = function()
					CharacterCreatorModel:SetModel( v )
					CharacterCreatorModelCreate = v
					CharacterCreatorModelChoose = true
				end 
			end
			surface.PlaySound( "UI/buttonclick.wav" )
		end
	end
	CharacterCreatorButton1.Paint = function(self, w,h ) end

	local CharacterCreatorButton2 = vgui.Create("DButton", CharacterFrameBaseParent)
	CharacterCreatorButton2:SetFont("chc_kobralost_9")
	CharacterCreatorButton2:SetTextColor(CharacterCreator.Colors["white"])
	CharacterCreatorButton2:SetSize(ScrW()*0.02, ScrH()*0.05)
	CharacterCreatorButton2:SetPos(ScrW()*0.223, ScrH()*0.4132)
	CharacterCreatorButton2:SetText("►")
	CharacterCreatorButton2.DoClick = function()	
		if CharacterCreatorInitialJob == 1 then
			KobraCharacterCreatorModel:Clear()
			if CharacterCreatorSexe == 1 then 
				CharacterCreatorSexe = 2
				CharacterCreatorModel:SetModel( "models/player/hl2rp/female_01.mdl" )
				CharacterCreatorModelCreate = "models/player/hl2rp/female_01.mdl"
				CharacterCreatorModelChoose = true
			elseif CharacterCreatorSexe == 2 then 
				CharacterCreatorSexe = 1
				CharacterCreatorModel:SetModel( "models/player/hl2rp/male_01.mdl" )
				CharacterCreatorModelCreate = "models/player/hl2rp/male_01.mdl"
				CharacterCreatorModelChoose = true
			end	
			for k, v in pairs(CharacterCreator.Models[CharacterCreatorSexe]) do 
				local CharacterCreatorListItem = KobraCharacterCreatorModel:Add( "SpawnIcon" ) 
				CharacterCreatorListItem:SetSize( ScrW()*0.04, ScrH()*0.07 )
				CharacterCreatorListItem:SetModel(v)
				CharacterCreatorListItem.DoClick = function()
					CharacterCreatorModel:SetModel( v )
					CharacterCreatorModelCreate = v
					CharacterCreatorModelChoose = true 
				end 
			end
			surface.PlaySound( "UI/buttonclick.wav" )
		end
	end 
	CharacterCreatorButton2.Paint = function(self, w,h ) end

	local CharacterCreatorButton3 = vgui.Create("DButton", CharacterFrameBaseParent)
	CharacterCreatorButton3:SetFont("chc_kobralost_9")
	CharacterCreatorButton3:SetTextColor(CharacterCreator.Colors["white"])
	CharacterCreatorButton3:SetSize(ScrW()*0.02, ScrH()*0.05)
	CharacterCreatorButton3:SetPos(ScrW()*0.035, ScrH()*0.522)
	CharacterCreatorButton3:SetText("◄")
	CharacterCreatorButton3.DoClick = function()
		KobraCharacterCreatorModel:Clear()
		if CharacterCreatorInitialJob > 1  then 
			CharacterCreatorInitialJob = CharacterCreatorInitialJob - 1
		elseif CharacterCreatorInitialJob == 1 then 
			CharacterCreatorInitialJob = table.Count(DB_Whitelist)
		end

		for k, v in pairs(RPExtraTeams) do
			if v.name == DB_Whitelist[CharacterCreatorInitialJob] then
				for _,mdl in pairs(v.model) do
					if CharacterCreatorSexe == 1 and table.HasValue(GAMEMODE.MaleModels, mdl) or table.HasValue(supported_dotante_jobs, mdl) then
						local CharacterCreatorListItem = KobraCharacterCreatorModel:Add( "SpawnIcon" )
						CharacterCreatorListItem:SetSize( ScrW()*0.04, ScrH()*0.07 )
						CharacterCreatorListItem:SetModel(mdl)
						CharacterCreatorListItem.DoClick = function()
							CharacterCreatorModel:SetModel(mdl)
							CharacterCreatorModelCreate = mdl
							CharacterCreatorModelChoose = true
						end
						CharacterCreatorModel:SetModel(mdl)
						CharacterCreatorModelCreate = mdl
						CharacterCreatorModelChoose = true
					elseif CharacterCreatorSexe == 2 and table.HasValue(GAMEMODE.FemaleModels, v.model) then
						local CharacterCreatorListItem = KobraCharacterCreatorModel:Add( "SpawnIcon" )
						CharacterCreatorListItem:SetSize( ScrW()*0.04, ScrH()*0.07 )
						CharacterCreatorListItem:SetModel(mdl)
						CharacterCreatorListItem.DoClick = function()
							CharacterCreatorModel:SetModel(mdl)
							CharacterCreatorModelCreate = mdl
							CharacterCreatorModelChoose = true
						end
						CharacterCreatorModel:SetModel(mdl)
						CharacterCreatorModelCreate = mdl
						CharacterCreatorModelChoose = true
					end
				end
			end
		end

		surface.PlaySound( "UI/buttonclick.wav" )
	end 
	CharacterCreatorButton3.Paint = function(self, w,h ) end

	local CharacterCreatorButton4 = vgui.Create("DButton", CharacterFrameBaseParent)
	CharacterCreatorButton4:SetFont("chc_kobralost_9")
	CharacterCreatorButton4:SetTextColor(CharacterCreator.Colors["white"])
	CharacterCreatorButton4:SetSize(ScrW()*0.02, ScrH()*0.05)
	CharacterCreatorButton4:SetPos(ScrW()*0.223, ScrH()*0.522)
	CharacterCreatorButton4:SetText("►")
	CharacterCreatorButton4.DoClick = function()
		KobraCharacterCreatorModel:Clear()
		if CharacterCreatorInitialJob != table.Count(DB_Whitelist) then
			CharacterCreatorInitialJob = CharacterCreatorInitialJob + 1
		elseif CharacterCreatorInitialJob == table.Count(DB_Whitelist) then
			CharacterCreatorInitialJob = 1
		end

		for k, v in pairs(RPExtraTeams) do
			if v.name == DB_Whitelist[CharacterCreatorInitialJob] then
				for _,mdl in pairs(v.model) do
					if CharacterCreatorSexe == 1 and table.HasValue(GAMEMODE.MaleModels, mdl) or table.HasValue(supported_dotante_jobs, mdl) then
						local CharacterCreatorListItem = KobraCharacterCreatorModel:Add( "SpawnIcon" )
						CharacterCreatorListItem:SetSize( ScrW()*0.04, ScrH()*0.07 )
						CharacterCreatorListItem:SetModel(mdl)
						CharacterCreatorListItem.DoClick = function()
							CharacterCreatorModel:SetModel(mdl)
							CharacterCreatorModelCreate = mdl
							CharacterCreatorModelChoose = true
						end
						CharacterCreatorModel:SetModel(mdl)
						CharacterCreatorModelCreate = mdl
						CharacterCreatorModelChoose = true
					elseif CharacterCreatorSexe == 2 and table.HasValue(GAMEMODE.FemaleModels, v.model) then
						local CharacterCreatorListItem = KobraCharacterCreatorModel:Add( "SpawnIcon" )
						CharacterCreatorListItem:SetSize( ScrW()*0.04, ScrH()*0.07 )
						CharacterCreatorListItem:SetModel(mdl)
						CharacterCreatorListItem.DoClick = function()
							CharacterCreatorModel:SetModel(mdl)
							CharacterCreatorModelCreate = mdl
							CharacterCreatorModelChoose = true
						end
						CharacterCreatorModel:SetModel(mdl)
						CharacterCreatorModelCreate = mdl
						CharacterCreatorModelChoose = true
					end
				end
			end
		end
		surface.PlaySound( "UI/buttonclick.wav" )
	end 
	CharacterCreatorButton4.Paint = function(self, w,h ) end

	local CharacterCreatorButtonBefore = vgui.Create("DButton", CharacterFrameBaseParent)
	CharacterCreatorButtonBefore:SetSize(ScrW()*0.21, ScrH()*0.1)
	CharacterCreatorButtonBefore:SetPos(ScrW()*0.035, ScrH()*0.83)
	CharacterCreatorButtonBefore:SetText(Configuration_Chc_Lang[10][CharacterCreator.CharacterLang])
	CharacterCreatorButtonBefore:SetFont("marske6")
	CharacterCreatorButtonBefore:SetTextColor(CharacterCreator.Colors["white"])
	CharacterCreatorButtonBefore.Paint = function(self,w,h)
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
		surface.SetDrawColor(CharacterCreator.Colors["black160"])
		surface.DrawOutlinedRect( 0, 0, w, h )
	end 
	CharacterCreatorButtonBefore.DoClick = function()
		CharacterFrameBaseParent:Remove()
		CharacterCreator.MenuSpawn()
		surface.PlaySound( "UI/buttonclick.wav" )
	end

	local CharacterCreatorButtonAccept2 = vgui.Create("DButton", CharacterFrameBaseParent)
	CharacterCreatorButtonAccept2:SetSize(ScrW()*0.21, ScrH()*0.1)
	CharacterCreatorButtonAccept2:SetPos(ScrW()*0.26, ScrH()*0.83)
	CharacterCreatorButtonAccept2:SetText(Configuration_Chc_Lang[9][CharacterCreator.CharacterLang])
	CharacterCreatorButtonAccept2:SetFont("marske6")
	CharacterCreatorButtonAccept2:SetTextColor(CharacterCreator.Colors["white"])
	CharacterCreatorButtonAccept2.Paint = function(self,w,h)
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
		surface.SetDrawColor(CharacterCreator.Colors["black160"])
		surface.DrawOutlinedRect( 0, 0, w, h )
	end 

	local CharacterCreatorButtonRandom = vgui.Create("DButton", CharacterFrameBaseParent)
	CharacterCreatorButtonRandom:SetSize(ScrW()*0.04, ScrH()*0.03)
	CharacterCreatorButtonRandom:SetPos(ScrW()*0.458, ScrH()*0.27)
	CharacterCreatorButtonRandom:SetImage("icon16/arrow_refresh.png")
	CharacterCreatorButtonRandom:SetText("")
	CharacterCreatorButtonRandom.Paint = function() end 
	CharacterCreatorButtonRandom.DoClick = function()
		local CharacterCreatorRandomName = table.Random(CharacterCreator.CharacterName)
		local CharacterCreatorRandomSurName = table.Random(CharacterCreator.CharacterSurName)
		CharacterCreatorDtextEntryName:SetText(CharacterCreatorRandomName)
		CharacterCreatorDtextEntrySurName:SetText(CharacterCreatorRandomSurName)
	end 

	CharacterCreatorButtonAccept2.DoClick = function()
		if CharacterCreatorDtextEntryName:GetText() == "Имя" or CharacterCreatorDtextEntrySurName:GetText() == "Фамилия" then
			surface.PlaySound( "buttons/combine_button1.wav" )
			return false
		else
			if CharacterCreatorSexe == 2 then
				CharacterCreatorSaveSexe = Configuration_Chc_Lang[11][CharacterCreator.CharacterLang]
			end

			local CharacterCreatorTable = {
				CharacterCreatorName = CharacterCreatorDtextEntryName:GetValue():gsub("^%l", string.upper).." "..CharacterCreatorDtextEntrySurName:GetValue():gsub("^%l", string.upper),
				CharacterCreatorSaveInitialJob = DB_Whitelist[CharacterCreatorInitialJob],
				CharacterCreatorModel = CharacterCreatorModelCreate,
				CharacterCreatorSaveSexe = CharacterCreatorSaveSexe,
				CharacterCreatorHeadId = CharacterCreatorHeadId,
				CharacterCreatorTorseId = CharacterCreatorTorseId,
				CharacterCreatorGlovesId = CharacterCreatorGlovesId,
				CharacterCreatorTrousersId = CharacterCreatorTrousersId,
			}	
			if CharacterCreatorModelChoose == true then
				RunConsoleCommand("stopsound")
				if CharacterCreator.MusicCreatedActivate then
					sound.PlayURL( CharacterCreator.MusicCreated, "",
					function( station )
						if IsValid( station ) then
							station:Play()
							station:SetVolume(CharacterCreator.MusicCreatedVolume)
						end
					end )
				end
				CharacterCreatorModelChoose = false
				
				if CharacterCreatorInitialJob == 1 then
					CharacterFrameBaseParent:SlideUp(0.7)
					CharacterCreator.CreateCharacterPage2(id, CharacterCreatorTable)
				else
					net.Start("CharacterCreator:SaveFirst")
					net.WriteTable(CharacterCreatorTable)
					net.WriteInt(id, 8)
					net.SendToServer()
					CharacterFrameBaseParent:SlideUp(0.7)
					surface.PlaySound( "UI/buttonclick.wav" )
					timer.Simple(1, function()
						net.Start("CharacterCreator:LoadCharacter")
						net.WriteInt(id, 8)
						net.SendToServer()

						if CharacterCreatorInitialJob == 1 then
							CreateCharacterIntro()
						end
						LoadRadialMenu()
					end)
				end
				gui.EnableScreenClicker(false)
			else
				surface.PlaySound( "buttons/combine_button1.wav" )
			end
		end
	end
end

function CharacterCreator.CreateCharacterPage2(id, char_table)

	Character_Height = 170

	local Сonstitutions = {
		"Толстое",
		"Обычное",
		"Худое",
		"Атлетичное",
	}
	Character_Сonstitution = "Обычное"

	local EyeColors = {
		"Черный",
		"Карий",
		"Зеленый",
		"Серо-зеленый",
		"Серый",
		"Голубой",
	}
	Character_EyeColor = "Зеленый" 

	Character_FacialHair = 0

	Character_PhysicalDescription = ""



	local CharacterFrameBaseParent = vgui.Create("DFrame")
	CharacterFrameBaseParent:SetSize(ScrW()*1, ScrH()*1)
	CharacterFrameBaseParent:SetPos(0,0)
	CharacterFrameBaseParent:ShowCloseButton(true)
	CharacterFrameBaseParent:SetDraggable(false)
	CharacterFrameBaseParent:SetTitle("")
	CharacterFrameBaseParent:MakePopup()
	gui.EnableScreenClicker(true)
	CharacterFrameBaseParent.Paint = function(self,w,h) end 

	local CharacterCreatorFrameBlack = vgui.Create( "DPanel", CharacterFrameBaseParent )
	CharacterCreatorFrameBlack:SetSize( ScrW()*1, ScrH()*1 )
	CharacterCreatorFrameBlack:SetPos(0,0)
	CharacterCreatorFrameBlack:SetBackgroundColor( CharacterCreator.Colors["black"] )

	local CharacterCreatorImage = vgui.Create( "Material", CharacterCreatorFrameBlack )
	CharacterCreatorImage:SetPos( 0, 0 )
	CharacterCreatorImage:SetSize( ScrW()*1, ScrH()*1 )
	CharacterCreatorImage:SetMaterial( CharacterCreator.BackImage )
	CharacterCreatorImage.AutoSize = false

	local CharacterCreatorMenuSpawn = vgui.Create("DPanel", CharacterFrameBaseParent)
	CharacterCreatorMenuSpawn:SetSize(ScrW()*1, ScrH()*1)
	CharacterCreatorMenuSpawn:SetPos(0,0)
	CharacterCreatorMenuSpawn.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, CharacterCreator.Colors["black160"])
		draw.DrawText("Описание внешности", "marske12",ScrW()*0.115, ScrH()*0.22, Color(255, 255, 255, 155), TEXT_ALIGN_LEFT)
		draw.DrawText("", "marske5",ScrW()*0.034, ScrH()*0.16, CharacterCreator.Colors["white"], TEXT_ALIGN_LEFT)
	end 

	local CharacterCreatorEntete = vgui.Create("DPanel", CharacterFrameBaseParent)
	CharacterCreatorEntete:SetSize(ScrW()*0.3, ScrH()*0.08)
	CharacterCreatorEntete:SetPos(ScrW()*0.1,ScrH()*0.2)
	CharacterCreatorEntete.Paint = function(self, w, h)
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
		surface.SetDrawColor(CharacterCreator.Colors["black160"])
		surface.DrawOutlinedRect( 0, 0, w, h )
	end

	local CharacterCreatorDscrollPanel = vgui.Create("DScrollPanel", CharacterFrameBaseParent)
	CharacterCreatorDscrollPanel:SetSize(ScrW()*0.7, ScrH()*0.1)
	CharacterCreatorDscrollPanel:SetPos(ScrW()*0.03,ScrH()*0.03)
	CharacterCreatorDscrollPanel.Paint = function(self,w,h) end

	CharacterCreator.FrameButton = {}

	local main_pos_x = ScrW()*0.035
	local main_pos_y = ScrH()*0.3
	local DermaNumSlider = vgui.Create( "DNumSlider", CharacterFrameBaseParent )
	DermaNumSlider:SetPos( main_pos_x, main_pos_y )
	DermaNumSlider:SetSize( ScrW()*0.21, ScrH()*0.08 )
	DermaNumSlider:SetText( "" )
	DermaNumSlider:SetMin( 140 )
	DermaNumSlider:SetMax( 210 )
	DermaNumSlider:SetValue(170)
	DermaNumSlider:SetDecimals( 0 )
	DermaNumSlider.OnValueChanged = function( self, value )
		Character_Height = self:GetValue()
	end
	DermaNumSlider.Paint = function(self,w,h)
		surface.SetDrawColor(CharacterCreator.Colors["black160"])
		surface.DrawOutlinedRect( 0, 0, w, h )
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
		draw.SimpleText("Рост:", "marske5", 50, 40, Color(255,255,255), 0, 0)
		self:DrawTextEntryText(CharacterCreator.Colors["white"], CharacterCreator.Colors["white"], CharacterCreator.Colors["white"])
	end


	local CharacterCreatorModel = vgui.Create( "DModelPanel", CharacterFrameBaseParent )
	CharacterCreatorModel:SetPos(  ScrW() * 0.7, ScrH() * 0.2 )
	CharacterCreatorModel:SetSize( ScrW() * 0.2, ScrH() * 0.7 )
	CharacterCreatorModel:SetFOV( 6.4 )
	CharacterCreatorModel:SetCamPos( Vector( 310, 100, 45 ) )
	CharacterCreatorModel:SetLookAt( Vector( 0, 0, 36 ) )
	CharacterCreatorModelCreate = char_table["CharacterCreatorModel"]
	CharacterCreatorModel:SetModel( CharacterCreatorModelCreate )
	function CharacterCreatorModel:LayoutEntity( ent ) end


	local Сonstitution_Selected = vgui.Create("DPanel", CharacterFrameBaseParent)
	Сonstitution_Selected:SetPos(main_pos_x, main_pos_y + 100)
	Сonstitution_Selected:SetSize(ScrW()*0.25, ScrH()*0.08)
	Сonstitution_Selected.Paint = function(self,w,h)
		surface.SetDrawColor(CharacterCreator.Colors["black180"])
		surface.DrawOutlinedRect( 0, 0, w, h )
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
		draw.SimpleText("Телосложение", "marske5", 50, 35, Color(255,255,255), 0, 0)
		draw.DrawText(Character_Сonstitution, "marske5",Сonstitution_Selected:GetWide()/1.4, Сonstitution_Selected:GetTall()*0.4, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end 

	local Сonstitution_Prev = vgui.Create("DButton", CharacterFrameBaseParent)
	Сonstitution_Prev:SetFont("chc_kobralost_9")
	Сonstitution_Prev:SetTextColor(CharacterCreator.Colors["white"])
	Сonstitution_Prev:SetPos(main_pos_x + 225, main_pos_y + 115)
	Сonstitution_Prev:SetSize(ScrW()*0.02, ScrH()*0.05)
	Сonstitution_Prev:SetText("◄")
	Сonstitution_Prev.DoClick = function()
		local key = table.KeyFromValue( Сonstitutions, Character_Сonstitution )
		if key > 1 then 
			Character_Сonstitution = Сonstitutions[key-1]
		else
			Character_Сonstitution = Сonstitutions[#Сonstitutions]
		end
		surface.PlaySound( "UI/buttonclick.wav" )
	end
	Сonstitution_Prev.Paint = function(self, w,h ) end

	local Сonstitution_Next = vgui.Create("DButton", CharacterFrameBaseParent)
	Сonstitution_Next:SetFont("chc_kobralost_9")
	Сonstitution_Next:SetTextColor(CharacterCreator.Colors["white"])
	Сonstitution_Next:SetPos(main_pos_x + 425, main_pos_y + 115)
	Сonstitution_Next:SetSize(ScrW()*0.02, ScrH()*0.05)
	Сonstitution_Next:SetText("►")
	Сonstitution_Next.DoClick = function()
		local key = table.KeyFromValue( Сonstitutions, Character_Сonstitution )
		if key < #Сonstitutions then 
			Character_Сonstitution = Сonstitutions[key+1]
		else
			Character_Сonstitution = Сonstitutions[1]
		end
		surface.PlaySound( "UI/buttonclick.wav" )
	end 
	Сonstitution_Next.Paint = function(self, w,h ) end

	

	local EyeColor_Selected = vgui.Create("DPanel", CharacterFrameBaseParent)
	EyeColor_Selected:SetPos(main_pos_x, main_pos_y + 200)
	EyeColor_Selected:SetSize(ScrW()*0.25, ScrH()*0.08)
	EyeColor_Selected.Paint = function(self,w,h)
		surface.SetDrawColor(CharacterCreator.Colors["black180"])
		surface.DrawOutlinedRect( 0, 0, w, h )
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
		draw.SimpleText("Цвет глаз", "marske5", 50, 35, Color(255,255,255), 0, 0)
		draw.DrawText(Character_EyeColor, "marske5",EyeColor_Selected:GetWide()/1.4, EyeColor_Selected:GetTall()*0.4, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
	end 

	local EyeColor_Prev = vgui.Create("DButton", CharacterFrameBaseParent)
	EyeColor_Prev:SetFont("chc_kobralost_9")
	EyeColor_Prev:SetTextColor(CharacterCreator.Colors["white"])
	EyeColor_Prev:SetPos(main_pos_x + 225, main_pos_y + 215)
	EyeColor_Prev:SetSize(ScrW()*0.02, ScrH()*0.05)
	EyeColor_Prev:SetText("◄")
	EyeColor_Prev.DoClick = function()
		local key = table.KeyFromValue( EyeColors, Character_EyeColor )
		if key > 1 then 
			Character_EyeColor = EyeColors[key-1]
		else
			Character_EyeColor = EyeColors[#EyeColors]
		end
		surface.PlaySound( "UI/buttonclick.wav" )
	end
	EyeColor_Prev.Paint = function(self, w,h ) end

	local EyeColor_Next = vgui.Create("DButton", CharacterFrameBaseParent)
	EyeColor_Next:SetFont("chc_kobralost_9")
	EyeColor_Next:SetTextColor(CharacterCreator.Colors["white"])
	EyeColor_Next:SetPos(main_pos_x + 425, main_pos_y + 215)
	EyeColor_Next:SetSize(ScrW()*0.02, ScrH()*0.05)
	EyeColor_Next:SetText("►")
	EyeColor_Next.DoClick = function()	
		local key = table.KeyFromValue( EyeColors, Character_EyeColor )
		if key < #EyeColors then 
			Character_EyeColor = EyeColors[key+1]
		else
			Character_EyeColor = EyeColors[1]
		end
		surface.PlaySound( "UI/buttonclick.wav" )
	end 
	EyeColor_Next.Paint = function(self, w,h ) end



	local FacialHair_Selected = vgui.Create("DPanel", CharacterFrameBaseParent)
	FacialHair_Selected:SetPos(main_pos_x, main_pos_y + 300)
	FacialHair_Selected:SetSize(ScrW()*0.25, ScrH()*0.08)
	FacialHair_Selected.Paint = function(self,w,h)
		surface.SetDrawColor(CharacterCreator.Colors["black180"])
		surface.DrawOutlinedRect( 0, 0, w, h )
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
		draw.SimpleText("Борода и усы", "marske5", 50, 35, Color(255,255,255), 0, 0)
		if Character_FacialHair == 0 then
			draw.DrawText("Отсутствуют", "marske5",FacialHair_Selected:GetWide()/1.4, FacialHair_Selected:GetTall()*0.4, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		else
			draw.DrawText("Вариант " .. Character_FacialHair, "marske5",FacialHair_Selected:GetWide()/1.4, FacialHair_Selected:GetTall()*0.4, CharacterCreator.Colors["white"], TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
		end
	end 

	local FacialHair_Prev = vgui.Create("DButton", CharacterFrameBaseParent)
	FacialHair_Prev:SetFont("chc_kobralost_9")
	FacialHair_Prev:SetTextColor(CharacterCreator.Colors["white"])
	FacialHair_Prev:SetPos(main_pos_x + 225, main_pos_y + 315)
	FacialHair_Prev:SetSize(ScrW()*0.02, ScrH()*0.05)
	FacialHair_Prev:SetText("◄")
	if char_table["CharacterCreatorSaveSexe"] != "Мужской" then
		FacialHair_Prev:SetDisabled(true)
	end
	FacialHair_Prev.DoClick = function()

		local ent = CharacterCreatorModel.Entity
		if Character_FacialHair > 0 then 
			Character_FacialHair = Character_FacialHair - 1 
		else
			Character_FacialHair = ent:GetBodygroupCount(14) 
		end 
		ent:SetBodygroup( 14, Character_FacialHair )
		surface.PlaySound( "UI/buttonclick.wav" )
	end
	FacialHair_Prev.Paint = function(self, w,h ) end

	local FacialHair_Next = vgui.Create("DButton", CharacterFrameBaseParent)
	FacialHair_Next:SetFont("chc_kobralost_9")
	FacialHair_Next:SetTextColor(CharacterCreator.Colors["white"])
	FacialHair_Next:SetPos(main_pos_x + 425, main_pos_y + 315)
	FacialHair_Next:SetSize(ScrW()*0.02, ScrH()*0.05)
	FacialHair_Next:SetText("►")
	if char_table["CharacterCreatorSaveSexe"] != "Мужской" then
		FacialHair_Next:SetDisabled(true)
	end
	FacialHair_Next.DoClick = function()	
		local ent = CharacterCreatorModel.Entity
		if Character_FacialHair < ent:GetBodygroupCount(14) then 
			Character_FacialHair = Character_FacialHair + 1 
		else
			Character_FacialHair = 0
		end 
		ent:SetBodygroup( 14, Character_FacialHair )
		surface.PlaySound( "UI/buttonclick.wav" )
	end 
	FacialHair_Next.Paint = function(self, w,h ) end



	local PhysicalDescription_Panel = vgui.Create("DPanel", CharacterFrameBaseParent)
	PhysicalDescription_Panel:SetPos(main_pos_x, main_pos_y + 400)
	PhysicalDescription_Panel:SetSize(ScrW()*0.25, ScrH()*0.08)
	PhysicalDescription_Panel.Paint = function(self,w,h)
		surface.SetDrawColor(CharacterCreator.Colors["black180"])
		surface.DrawOutlinedRect( 0, 0, w, h )
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
	end 

	local PhysicalDescription_Selected = vgui.Create("DTextEntry", CharacterFrameBaseParent)
	PhysicalDescription_Selected:SetPos(main_pos_x+50, main_pos_y + 425)
	PhysicalDescription_Selected:SetSize(ScrW()*0.25, ScrH()*0.08)
	PhysicalDescription_Selected:SetMultiline(true)
	PhysicalDescription_Selected:SetFont("marske4")
	PhysicalDescription_Selected:SetValue("")
	PhysicalDescription_Selected:SetTextColor(Color(255,255,255))
	PhysicalDescription_Selected:SetPaintBackground(false)
	PhysicalDescription_Selected:SetCursorColor(Color(200,100,0))
	PhysicalDescription_Selected:SetText( "Особенности внешности | писать строго про внешность, либо оставить поле пустым . . ." )
	PhysicalDescription_Selected.OnGetFocus = function(self) PhysicalDescription_Selected:SetText(Character_PhysicalDescription) end 
	PhysicalDescription_Selected.OnChange = function( self )
		Character_PhysicalDescription = self:GetValue()
	end


	local CharacterCreatorButtonBefore = vgui.Create("DButton", CharacterFrameBaseParent)
	CharacterCreatorButtonBefore:SetSize(ScrW()*0.21, ScrH()*0.1)
	CharacterCreatorButtonBefore:SetPos(ScrW()*0.035, ScrH()*0.83)
	CharacterCreatorButtonBefore:SetText(Configuration_Chc_Lang[10][CharacterCreator.CharacterLang])
	CharacterCreatorButtonBefore:SetFont("marske6")
	CharacterCreatorButtonBefore:SetTextColor(CharacterCreator.Colors["white"])
	CharacterCreatorButtonBefore.Paint = function(self,w,h)
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
		surface.SetDrawColor(CharacterCreator.Colors["black160"])
		surface.DrawOutlinedRect( 0, 0, w, h )
	end 
	CharacterCreatorButtonBefore.DoClick = function()
		CharacterFrameBaseParent:Remove()
		CharacterCreator.CreateCharacter(id)
		surface.PlaySound( "UI/buttonclick.wav" )
	end

	local CharacterCreatorButtonAccept2 = vgui.Create("DButton", CharacterFrameBaseParent)
	CharacterCreatorButtonAccept2:SetSize(ScrW()*0.21, ScrH()*0.1)
	CharacterCreatorButtonAccept2:SetPos(ScrW()*0.26, ScrH()*0.83)
	CharacterCreatorButtonAccept2:SetText(Configuration_Chc_Lang[9][CharacterCreator.CharacterLang])
	CharacterCreatorButtonAccept2:SetFont("marske6")
	CharacterCreatorButtonAccept2:SetTextColor(CharacterCreator.Colors["white"])
	CharacterCreatorButtonAccept2.Paint = function(self,w,h)
		draw.RoundedBox(CharacterCreator.Round, 0, 0, w, h, CharacterCreator.Colors["black180"])
		surface.SetDrawColor(CharacterCreator.Colors["black160"])
		surface.DrawOutlinedRect( 0, 0, w, h )
	end
	CharacterCreatorButtonAccept2.DoClick = function()
		
		char_table["Character_Height"] = Character_Height
		char_table["Character_Сonstitution"] = Character_Сonstitution
		char_table["Character_EyeColor"] = Character_EyeColor
		char_table["Character_FacialHair"] = Character_FacialHair
		char_table["Character_PhysicalDescription"] = Character_PhysicalDescription

		RunConsoleCommand("stopsound")
		
		if CharacterCreator.MusicCreatedActivate then
			sound.PlayURL( CharacterCreator.MusicCreated, "",
			function( station )
				if IsValid( station ) then
					station:Play()
					station:SetVolume(CharacterCreator.MusicCreatedVolume)
				end
			end )
		end
		
		net.Start("CharacterCreator:SaveFirst")
		net.WriteTable(char_table)
		net.WriteInt(id, 8)
		net.SendToServer()
		CharacterFrameBaseParent:SlideUp(0.7)

		timer.Simple(1, function()
			net.Start("CharacterCreator:LoadCharacter")
			net.WriteInt(id, 8)
			net.SendToServer()

			CreateCharacterIntro()
			LoadRadialMenu()

			gui.EnableScreenClicker(false)
		end)

		surface.PlaySound( "UI/buttonclick.wav" )
		gui.EnableScreenClicker(false)
	end
end

function CreateCharacterIntro()

	ply = LocalPlayer()
	ply:ScreenFade(SCREENFADE.IN, color_black, 10, 10)
	ply:SetNWInt("Rised_Music_StopTime", CurTime() + 600)

	local msg = "« В ы | п р и б ы в а е т е | в | и н д у с т р и а л ь н ы й | с е к т о р | г о р о д а | 1 7 . . . » ."
	local letterPhrase = ""

	local i = 1
	for s in string.gmatch(msg, "[^%s,]+") do
		timer.Simple(i * 0.1, function()
			if s == "|" then
				letterPhrase = letterPhrase .. " "
			else
				ply:PrintMessage(HUD_PRINTCENTER, letterPhrase)
				letterPhrase = letterPhrase .. s
				ply:EmitSound("ambient/machines/keyboard"..math.random(1,6).."_clicks.wav", 35)
			end

		end)

		i = i + 1
	end

	timer.Simple(5, function()
		ply:ScreenFade(SCREENFADE.IN, color_black, 10, 6)
		ply:EmitSound("ambient/machines/station_train_squeel.wav", 35)

		timer.Simple(1, function()

			msg = "« Д о б р о | п о ж а л о в а т ь . . . » ."
			letterPhrase = ""

			local i = 1
			for s in string.gmatch(msg, "[^%s,]+") do
				timer.Simple(i * 0.1, function()
					if s == "|" then
						letterPhrase = letterPhrase .. " "
					else
						ply:PrintMessage(HUD_PRINTCENTER, letterPhrase)
						letterPhrase = letterPhrase .. s
						ply:EmitSound("ambient/machines/keyboard"..math.random(1,6).."_clicks.wav", 35)
					end
				end)

				i = i + 1
			end

			timer.Simple(1, function()
				LocalPlayer():EmitSound(table.Random(RISED.Config.Music.Initial), 35)
			end)
		end)
	end)
end

hook.Add("OnPlayerChangedTeam", "CharacterCreator:OnPlayerChangedTeam", function(ply)
	net.Start("CharacterCreator:ChangeTeam")
	net.SendToServer()

	timer.Simple(2, LoadRadialMenu)
end)

net.Receive("CharacterCreator:InformationClient", function()
	CharacterCreatorTab = net.ReadTable()

	local length = net.ReadInt(32)
	local data = net.ReadData(length)
	local whitelist = util.Decompress(data)

	DB_Whitelist = util.JSONToTable(whitelist)
end ) 

net.Receive("CharacterCreator:OpenMenu", CharacterCreator.MenuSpawn)


function ReturnAnimationPackAfter()

    local commands = {}
    local anims = {}

    local models = { 
        "models/hl2rp/female_01.mdl",
        "models/hl2rp/female_02.mdl",
        "models/hl2rp/female_03.mdl",
        "models/hl2rp/female_04.mdl",
        "models/hl2rp/female_06.mdl",
        "models/hl2rp/female_07.mdl",
        "models/humans/combine/female_01.mdl",
        "models/humans/combine/female_02.mdl",
        "models/humans/combine/female_03.mdl",
        "models/humans/combine/female_04.mdl",
        "models/humans/combine/female_06.mdl",
        "models/humans/combine/female_07.mdl",
        "models/humans/combine/female_08.mdl",
        "models/humans/combine/female_08.mdl",
        "models/humans/combine/female_09.mdl",
        "models/humans/combine/female_10.mdl",
        "models/humans/combine/female_11.mdl",
        "models/humans/combine/female_ga.mdl",
		"models/player/hl2rp/female_01.mdl",
		"models/player/hl2rp/female_02.mdl",
		"models/player/hl2rp/female_03.mdl",
		"models/player/hl2rp/female_04.mdl",
		"models/player/hl2rp/female_06.mdl",
		"models/player/hl2rp/female_07.mdl",
    }

    local models1 = { 
        "models/hl2rp/male_01.mdl",
        "models/hl2rp/male_02.mdl",
        "models/hl2rp/male_03.mdl",
        "models/hl2rp/male_04.mdl",
        "models/hl2rp/male_05.mdl",
        "models/hl2rp/male_06.mdl",
        "models/hl2rp/male_07.mdl",
        "models/hl2rp/male_08.mdl",
        "models/hl2rp/male_09.mdl",
		"models/player/hl2rp/male_01.mdl",
		"models/player/hl2rp/male_02.mdl",
		"models/player/hl2rp/male_03.mdl",
		"models/player/hl2rp/male_04.mdl",
		"models/player/hl2rp/male_05.mdl",
		"models/player/hl2rp/male_06.mdl",
		"models/player/hl2rp/male_07.mdl",
		"models/player/hl2rp/male_08.mdl",
		"models/player/hl2rp/male_09.mdl",
    }

    if !IsValid(LocalPlayer()) then return end

    if GAMEMODE.MetropoliceJobs[LocalPlayer():Team()] then
        anims = RISED.Animations["Metropolice"]
    elseif GAMEMODE.CombineJobs[LocalPlayer():Team()] then
        anims = RISED.Animations["Combine"]
    elseif table.HasValue(models, LocalPlayer():GetModel()) then
        anims = RISED.Animations["Models"]
    elseif table.HasValue(models1, LocalPlayer():GetModel()) then
        anims = RISED.Animations["Models1"]
    end

    for k,v in pairs(anims) do
        table.insert(commands, {
            ["Name"] = v["AnimationName"],
            ["IsDraggable"] = 0,
            ["Function"] = function()
                LocalPlayer():SetNWBool("anim", true)
                net.Start( "anim_ris_server" )
                net.WriteInt(v["AnimationID"], 32)
                net.WriteBool(v["AutoKill"])
                net.SendToServer()

                if !v["Simple"] then
                    timer.Simple(v["Delay"], function()
                        LocalPlayer():SetNWBool("anim", true)
                        net.Start( "anim_ris_server" )
                        net.WriteInt(v["SecondAnimationID"], 32)
                        net.WriteBool(v["SecondAutoKill"])
                        net.SendToServer()
                    end)
                end
            end
        })
    end
    return commands
end

function LoadRadialMenu()

	--Основные #1
	local otavoice_01 = {
		"Есть.",
		"Понял.",
		"Вас понял.",
		"Работаю.",
		"Готов.",
		"Жду указаний.",
		"Выдвигаюсь.",
		"Всё чисто в квадрате.",
		"Чисто.",
	}
	--Контакт #2
	local otavoice_02 = {
		"Контакт!",
		"Есть контакт!",
		"Активный перехват.",
		"Видимость есть.",
		"Защита, сдерживаем!",
		"Подавление!",
		"В секторе опасность.",
		"Наступать, наступать!",
		"Сдерживание.",
	}
	--Ведение боя #3
	local otavoice_03 = {
		"Один на земле!",
		"Нейтрализован.",
		"Прикрой!",
		"Есть попадание!",
		"Продолжаю зачистку!",
		"Отряд в атаке.",
		"Пошла граната!",
		"Ложись, ложись!",
		"Цель поражена, преследуем!",
	}
	--Кодовые #4
	local otavoice_04 = {
		"Ехо.",
		"Молот.",
		"Ударник.",
		"Бритва.",
		"Хеликс.",
		"Судья.",
		"Лидер.",
		"Меч.",
		"Кинжал.",
	}
	--Лидер #5
	local otavoice_05 = {
		"Цель в тени, прочесать местность.",
		"Внимательно, оставаться на чеку.",
		"Цель #1.",
		"Цель #1 переместилась в зону сдерживания.",
		"Команда стабилизации на позициях.",
		"Команда стабилизации контролирует сектор.",
		"Закругляйся с ним.",
		"Центр докладывает, возможно опасность.",
		"Движение! Проверить сектора.",
	}
	--Центру #6
	local otavoice_06 = {
		"Сильное сопротивление.",
		"Прошу поддержки!",
		"Прошу поддержки резерва.",
		"Прошу воздушной поддержки.",
		"Центр, сектор захвачен!",
		"Центр, цель уничтожена.",
		"Нарушитель нейтрализован.",
		"Рота уничтожена!",
		"Цель #1 уничтожена.",
	}
	--Инфекция #7
	local otavoice_07 = {
		"Дезинфекция.",
		"Контакт с паразитами.",
		"У нас свободные паразиты.",
		"Опасные формы жизни в секторе.",
		"Нежить.",
		"Нежить вступает.",
		"Мы в зоне инфекции.",
		"У нас вирусное загрязнение.",
		"Зараженный.",
	}
	--Прочее #8
	local otavoice_08 = {
		"Заряды к бою.",
		"Приготовить оружие, неприятели.",
		"Приготовить оружие.",
		"Полная активность!",
		"Внимательно.",
		"Нет движения.",
		"Требуется мед. помощь.",
		"Требуются стимуляторы.",
		"Назначен лидером отделения.",
		"Нарушитель номер 1.",
		"В секторе опасные формы жизни.",
		"Чисто.",
		"Преследую.",
		"Убит.",
		"Кидаю гранату!",
		"Граната!",
		"Не вижу.",
		"Легко ранен.",
		"Рота.",
		"Уходим!",
		"Держать позицию.",
		"Гранаты к бою.",
		"Оружие к бою.",
		"Доложить об опасности.",
		"Рота готова, прочесываем.",
		"Не стрелять.",
		"Выполняй.",
	}

	start_operations = {
		{
			["Name"] = "Денежные операции",
			["IsDraggable"] = 0,
			["Function"] = RebuildRadialMenu({
				{
					["Name"] = "Бросить деньги",
					["IsDraggable"] = 1,
					["Function"] = function(value)
						if value and value > 0 then
							RunConsoleCommand("darkrp", "dropmoney", value)
						else
							Derma_StringRequest("", "Сколько хотите бросить денег?", nil, function(s)
								RunConsoleCommand("darkrp", "dropmoney", s)
							end)
						end
					end
				},
				{
					["Name"] = "Передать деньги",
					["IsDraggable"] = 1,
					["Function"] = function(value)
						if value and value > 0 then
							RunConsoleCommand("darkrp", "give", value)
						else
							Derma_StringRequest("", "Сколько хотите передать денег?", nil, function(s)
								RunConsoleCommand("darkrp", "give", s)
							end)
						end
					end
				}
			})
		},
		{
			["Name"] = "Режим разговора",
			["IsDraggable"] = 0,
			["Function"] = RebuildRadialMenu({
				{
					["Name"] = "Шёпот",
					["IsDraggable"] = 0,
					["Function"] = function(value)
						RunConsoleCommand("number_of_voice_system", "3")
						RunConsoleCommand("rised_voice_type")
					end
				},
				{
					["Name"] = "Обычная речь",
					["IsDraggable"] = 0,
					["Function"] = function(value)
						RunConsoleCommand("number_of_voice_system", "1")
						RunConsoleCommand("rised_voice_type")
					end
				},
				{
					["Name"] = "Крик",
					["IsDraggable"] = 0,
					["Function"] = function(value)
						RunConsoleCommand("number_of_voice_system", "2")
						RunConsoleCommand("rised_voice_type")
					end
				}
			})
		},
		{
			["Name"] = "Экипировка",
			["Function"] = RebuildRadialMenu({
				{
					["Name"] = "Выбросить оружие",
					["Function"] = function(value)
						RunConsoleCommand("darkrp", "dropweapon")
					end
				},
				{
					["Name"] = "Маска",
					["Disabled"] = function() return !isMetropolice() end,
					["Function"] = RebuildRadialMenu({
						{
							["Name"] = "Снять маску",
							["Disabled"] = function() return !IsCombineMask() end,
							["Function"] = function(value)
								RunConsoleCommand("combine_mask")
								BuildRadialMenu(current_operations)
							end
						},
						{
							["Name"] = "Надеть маску",
							["Disabled"] = function() return IsCombineMask() end,
							["Function"] = function(value)
								RunConsoleCommand("combine_mask")
								BuildRadialMenu(current_operations)
							end
						},
						{
							["Name"] = "Включить вокодер",
							["Disabled"] = function() return IsCombineVocoder() or !IsCombineMask() end,
							["Function"] = function(value)
								RunConsoleCommand("combine_vox")
								BuildRadialMenu(current_operations)
							end
						},
						{
							["Name"] = "Выключить вокодер",
							["Disabled"] = function() return !IsCombineVocoder() or !IsCombineMask() end,
							["Function"] = function(value)
								RunConsoleCommand("combine_vox")
								BuildRadialMenu(current_operations)
							end
						}
					})
				},
				{
					["Name"] = "Включить маскировку",
					["Disabled"] = function() return !IsRazor() or !IsGhosted() end,
					["Function"] = function(value)
						RunConsoleCommand("otaghost")
						BuildRadialMenu(current_operations)
					end
				},
				{
					["Name"] = "Выключить маскировку",
					["Disabled"] = function() return !IsRazor() or IsGhosted() end,
					["Function"] = function(value)
						RunConsoleCommand("otaghost")
						BuildRadialMenu(current_operations)
					end
				}
			})
		},
		{
			["Name"] = "Запросы",
			["Disabled"] = function() return !isMetropolice() end,
			["Function"] = RebuildRadialMenu({
				{
					["Name"] = "Выдача ОЛ",
					["Disabled"] = function() return !isMetropoliceCanOL() end,
					["Function"] = function(value)
						RunConsoleCommand("say", "/add_ol")
					end
				},
				{
					["Name"] = "Снятие ОЛ",
					["Disabled"] = function() return !isMetropoliceCanOL() end,
					["Function"] = function(value)
						RunConsoleCommand("say", "/remove_ol")
					end
				},
				{
					["Name"] = "Заступить на пост",
					["Function"] = function(value)
						RunConsoleCommand("say", "/mpf_getpost")
					end
				},
			})
		},
		{
			["Name"] = "Объявления",
			["Disabled"] = function() return !CanAnnouncement() end,
			["Function"] = RebuildRadialMenu({
				{
					["Name"] = "Рабочая фаза",
					["Disabled"] = function() return !CanAnnouncementCityStatuses() and !CanAnnouncementWorkPhase() end,
					["Function"] = function(value)
						RunConsoleCommand("say", "/codeworkphase")
					end
				},
				{
					["Name"] = "КОД: Красный",
					["Disabled"] = function() return !CanAnnouncementCityStatuses() end,
					["Function"] = function(value)
						RunConsoleCommand("say", "/coder")
					end
				},
				{
					["Name"] = "КОД: Оранжевый",
					["Disabled"] = function() return !CanAnnouncementCityStatuses() end,
					["Function"] = function(value)
						RunConsoleCommand("say", "/codeo")
					end
				},
				{
					["Name"] = "КОД: Желтый",
					["Disabled"] = function() return !CanAnnouncementCityStatuses() end,
					["Function"] = function(value)
						RunConsoleCommand("say", "/codey")
					end
				},
				{
					["Name"] = "КОД: Зеленый",
					["Disabled"] = function() return !CanAnnouncementCityStatuses() end,
					["Function"] = function(value)
						RunConsoleCommand("say", "/codeg")
					end
				},
				{
					["Name"] = "Биологическая угроза",
					["Disabled"] = function() return !CanAnnouncementCityStatuses() end,
					["Function"] = function(value)
						RunConsoleCommand("say", "/codebiohazard")
					end
				},
				{
					["Name"] = "Инспекционная фаза",
					["Disabled"] = function() return !CanAnnouncementCityStatuses() end,
					["Function"] = function(value)
						RunConsoleCommand("say", "/codehome")
					end
				}
			})
		},
		{
			["Name"] = "РП операции",
			["Function"] = RebuildRadialMenu({
				{
					["Name"] = "Повысить RP игроку",
					["Function"] = function(value)
						RunConsoleCommand("uprp")
					end
				},
				{
					["Name"] = "Понизить RP игроку",
					["Function"] = function(value)
						RunConsoleCommand("downrp")
					end
				},
				{
					["Name"] = "Принять отчет",
					["Disabled"] = function() return !isMetropoliceCMD() end,
					["Function"] = function(value)
						RunConsoleCommand("rised_accept_report")
					end
				},
				{
					["Name"] = "Описание персонажа",
					["Function"] = function(value)
						local ply = LocalPlayer()
						local height = math.Round(ply:GetNWString("Character_Height", 170))
						local constitution = ply:GetNWString("Character_Сonstitution", "Обычное")
						local eye_color = string.lower(ply:GetNWString("Character_EyeColor", "Зеленый"))
						local facial_hair = ply:GetNWInt("Character_FacialHair", 0)
						local physical_description = ply:GetNWString("Character_PhysicalDescription", "")
				
						if physical_description != "" then
							physical_description = ", " .. physical_description
						end
						
						if facial_hair != nil and facial_hair > 0 then
							facial_hair = "присутствует"
						else
							facial_hair = "отсутствует"
						end
				
						local text = "Рост: " .. height .. " см., телосложение " .. constitution .. ", цвет глаз " .. eye_color .. ", растительность на лице " .. facial_hair .. physical_description
				
						chat.AddText( Color( 255, 195, 0 ), ply, text)
					end
				},
				{
					["Name"] = "Самоубийство",
					["Function"] = function(value)
						RunConsoleCommand("suicide")
					end
				}
			})
		},
		{
			["Name"] = "Голосовые команды",
			["Disabled"] = function() return !IsCombine() end,
			["Function"] = RebuildRadialMenu({
				{
					["Name"] = "Основные",
					["Disabled"] = function() return !IsCombine() end,
					["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_01))
				},
				{
					["Name"] = "Контакт",
					["Disabled"] = function() return !IsCombine() end,
					["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_02))
				},
				{
					["Name"] = "Ведение боя",
					["Disabled"] = function() return !IsCombine() end,
					["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_03))
				},
				{
					["Name"] = "Кодовые",
					["Disabled"] = function() return !IsCombine() end,
					["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_04))
				},
				{
					["Name"] = "Лидер",
					["Disabled"] = function() return !IsCombine() end,
					["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_05))
				},
				{
					["Name"] = "Центру",
					["Disabled"] = function() return !IsCombine() end,
					["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_06))
				},
				{
					["Name"] = "Инфекция",
					["Disabled"] = function() return !IsCombine() end,
					["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_07))
				},
				{
					["Name"] = "Прочее",
					["Disabled"] = function() return !IsCombine() end,
					["Function"] = RebuildRadialMenu(ReturnVoicesPack(otavoice_08))
				},
			})
		},
		{
			["Name"] = "Анимации",
			["Function"] = RebuildRadialMenu(ReturnAnimationPackAfter())
		},
		{
			["Name"] = "Разное",
			["Function"] = RebuildRadialMenu({
				{
					["Name"] = "Остановить звуки",
					["Function"] = function(value)
						RunConsoleCommand("stopsound")
					end
				},
				{
					["Name"] = "Убрать метки",
					["Function"] = function(value)
						local i = 0
						while i <= 1000 do
							i = i + 1
							hook.Remove( "HUDPaint", "CallCPHudIconDraw"..i )
							hook.Remove( "HUDPaint", "DeadCPHudIconDraw"..i )
							hook.Remove( "HUDPaint", "DisturbCPHudIconDraw"..i )
							hook.Remove( "RenderScreenspaceEffects", "DispachMovepoint01CPHudIconDraw" )
							hook.Remove( "RenderScreenspaceEffects", "DispachClear01CPHudIconDraw" )
							hook.Remove( "HUDPaint", "DestroyFieldCPHudIconDraw"..i )
							hook.Remove( "HUDPaint", "CaptureSectorCPHudIconDraw"..i )
					
							hook.Remove( "HUDPaint", "RubbishInfoMarkerHudIconDraw"..i )
									
							hook.Remove( "HUDPaint", "MeatInfoMarkerHudIconDraw"..i )
							hook.Remove( "HUDPaint", "EnzymesInfoMarkerHudIconDraw"..i )
							hook.Remove( "HUDPaint", "MeatTableInfoMarkerHudIconDraw"..i )
							hook.Remove( "HUDPaint", "ResourceInfoMarkerHudIconDraw"..i )
							hook.Remove( "HUDPaint", "EnzymesContainerInfoMarkerHudIconDraw"..i )
									
							hook.Remove( "HUDPaint", "MeatWorkInfoMarkerHudIconDraw"..i )
									
							hook.Remove( "HUDPaint", "RationWorkInfoMarkerHudIconDraw"..i )
							hook.Remove( "HUDPaint", "RationFillInfoMarkerHudIconDraw"..i )
									
							hook.Remove( "HUDPaint", "DoctorInfoMarkerHudIconDraw"..i )
							hook.Remove( "HUDPaint", "ExtraFoodInfoMarkerHudIconDraw"..i )
							hook.Remove( "HUDPaint", "BarInfoMarkerHudIconDraw"..i )
							hook.Remove( "HUDPaint", "FilmInfoMarkerHudIconDraw"..i )
					
							hook.Remove( "HUDPaint", "ContrabandInfoMarkerHudIconDraw"..i )
					
							hook.Remove( "HUDPaint", "CaptureSectorCPHudIconDraw"..i )
						end
						
						hook.Remove( "HUDPaint", "HUDInfoMarker01" )
						hook.Remove( "HUDPaint", "HUDInfoMarker02" )
						hook.Remove( "HUDPaint", "HUDInfoMarker03" )
						hook.Remove( "HUDPaint", "HUDInfoMarker04" )
						hook.Remove( "HUDPaint", "HUDInfoMarker05" )
						hook.Remove( "HUDPaint", "HUDInfoMarker06" )
					
						hook.Remove( "HUDPaint", "ApartmentInfoMarkerHudIconDraw" )
						hook.Remove( "HUDPaint", "NewPatientInfoMarkerHudIconDraw" )
						hook.Remove( "HUDPaint", "NewCWUInfoMarkerHudIconDraw" )
						hook.Remove( "HUDPaint", "MPF_PostMarker" )
					end
				},
				{
					["Name"] = "Награды",
					["Function"] = function(value)
						RunConsoleCommand("say", "!zrew_main")
					end
				}
			})
		}
	}

	BuildRadialMenu(start_operations)
end
