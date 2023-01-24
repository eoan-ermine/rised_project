-- "addons\\rised_ration\\lua\\entities\\combine_dispenser2.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

ENT.Type = "anim"

ENT.PrintName = "Combine Dispenser"

-- function XyevoRabotaet()
-- 	return true
-- end

ENT.Author = "D-Rised"

ENT.Category = "HL2 RP"

ENT.Spawnable = true

ENT.AdminOnly = true

ENT.PhysgunDisable = true

ENT.PhysgunAllowAdmin = true
ENT.RenderGroup = 9

local COLOR_RED = 1

local COLOR_ORANGE = 2

local COLOR_BLUE = 3

local COLOR_GREEN = 4

local text = {[1] = "ОЖИДАНИЕ", [2] = "ЗАРЯДКА", [3] = "ПРОВЕРКА", [4] = "УСПЕШНО", [5] = 'ОШИБКА', [6] = "ЛИМИТ", [7] = "ВЫДАЧА"}

local colors = {

	[COLOR_RED] = Color(255, 50, 50),

	[COLOR_ORANGE] = Color(255, 80, 20),

	[COLOR_BLUE] = Color(50, 80, 230),

	[COLOR_GREEN] = Color(50, 240, 50)

}

local onoff = false

function ENT:SetupDataTables()

	self:NetworkVar("Int", 0, "DispColor")

	self:NetworkVar("Int", 1, "Text")

	self:NetworkVar("Bool", 0, "Disabled")

end

local bezmata = Material( "sprites/glow04_noz" )

if (CLIENT) then
	local file, Material, Fetch, find = file, Material, http.Fetch, string.find

	local errorMat = Material("error")
	local WebImageCache = {}
	if !file.IsDir('risedrp', 'DATA') then
		file.CreateDir('risedrp')
	end
	function http.DownloadMaterial(url, path, callback)
		if WebImageCache[url] then return callback(WebImageCache[url]) end

		local data_path = "data/risedrp/".. path
		if file.Exists('risedrp/'..path, "DATA") then
			WebImageCache[url] = Material(data_path, "smooth", "noclamp")
			callback(WebImageCache[url])
		else
			Fetch(url, function(img)
				if img == nil or find(img, "<!DOCTYPE HTML>", 1, true) then return callback(errorMat) end
				
				file.Write('risedrp/'..path, img)
				WebImageCache[url] = Material(data_path, "smooth", "noclamp")
				callback(WebImageCache[url])
			end, function()
				callback(errorMat)
			end)
		end
	end
	http.DownloadMaterial('https://media.discordapp.net/attachments/753003204932927548/940711562065371136/1524448510_preview_steamworkshop_webupload_previewfile_292603790_preview.png?width=714&height=702', "combi2nelogo.png", function(t)end)
	local x = 600
	local bool = false
	local cam, render, surface, draw, math = cam, render, surface, draw, math

	function ENT:Draw()
		http.DownloadMaterial('https://media.discordapp.net/attachments/753003204932927548/940711562065371136/1524448510_preview_steamworkshop_webupload_previewfile_292603790_preview.png?width=714&height=702', "combi2nelogo.png", function(t)
			local position, angles = self:GetPos(), self:GetAngles()
			dist = dist or EyePos():DistToSqr(self:GetPos())
			if LocalPlayer():GetPos():DistToSqr(self:GetPos()) < 60000 then

				local col = Color( 255, 255, 255, 255 )

				if self:GetNWBool("DispenserOn") == true and self:GetNWInt("RemainRations") > 0 then
					col = Color( 155, 255, 155, 255 )
				elseif self:GetNWInt("RemainRations") <= 0 then
					col = Color( 255, 255, 255, 255 )
				elseif self:GetNWBool("DispenserOn") == false then
					col = Color( 255, 0, 0, 255 )
				end
				
				local pos2 = self:GetPos() + self:GetAngles():Forward() * 7 + self:GetAngles():Right() * -1.5 + self:GetAngles():Up() * 16.5

				local pos = self:GetPos() + self:GetAngles():Forward() * 3.4 - self:GetAngles():Right() * -34 + self:GetAngles():Up() * 17.5
				local rand = math.Rand(1,1.5)
				render.SetMaterial( bezmata )
				render.DrawSprite( pos2, 2.5 + rand, 3 + rand, col )
				angles:RotateAroundAxis(angles:Up(), 90);
				angles:RotateAroundAxis(angles:Forward(), 90);

				local pos = self:GetPos() + self:GetAngles():Forward() * 5.5 + self:GetAngles():Right() * 34 + self:GetAngles():Up() * 16.5

				cam.Start3D2D(pos, angles, 0.13)
					surface.SetDrawColor(Color(0,0,0,255))
					surface.SetMaterial(t)
					surface.DrawTexturedRect(200,0,40,40)
				cam.End3D2D() 

				surface.SetAlphaMultiplier(1)
			end
		end)
	end
else

	function ENT:Initialize()
	
		self:SetNWInt("RemainRations", 10);
		self:SetNWInt("RationsQuality", 1);
		
		for k, v in pairs (player.GetAll()) do 
			v:SetNWBool("Ration_Timer", false)
		end
		
		self:SetModel("models/props_junk/gascan001a.mdl")

		self:PhysicsInit(SOLID_VPHYSICS)

		self:SetSolid(SOLID_VPHYSICS)

		self:SetMoveType(MOVETYPE_VPHYSICS)

		self:SetUseType(SIMPLE_USE)
		
		self:SetRenderMode(3)

		self:SetColor(Color(0, 0, 0))

		self:SetText(1)

		self:DrawShadow(false)

		self:SetDispColor(COLOR_GREEN)

		self.canUse = true



		-- Use prop_dynamic so we can use entity:Fire("SetAnimation")

		self.dummy = ents.Create("prop_dynamic")

		self.dummy:SetModel("models/props_combine/combine_dispenser.mdl")

		self.dummy:SetPos(self:LocalToWorld(Vector(-2,0,0)))

		self.dummy:SetColor(Color(255,200,100))

		self.dummy:SetAngles(self:GetAngles())

		self.dummy:SetParent(self)

		self.dummy:Spawn()

		self.dummy:DrawShadow(false)

		self.dummy:Activate()



		self:DeleteOnRemove(self.dummy)



		local physObj = self:GetPhysicsObject()


		if (IsValid(physObj)) then

			physObj:EnableMotion(false)

			physObj:Sleep()

		end

	end
	
	function ENT:setUseAllowed(state)

		if state then

			self:SetText(1)

			self:SetDispColor(COLOR_GREEN)

		end

		self.canUse = state

	end



	function ENT:error(text)

		self:EmitSound("buttons/combine_button_locked.wav")

		self:SetText(text)

		self:SetDispColor(COLOR_RED)



		timer.Create("nut_DispenserError"..self:EntIndex(), 1.5, 1, function()

			if (IsValid(self)) then

				self:SetText(1)

				self:SetDispColor(COLOR_GREEN)



				timer.Simple(0.5, function()

					if (!IsValid(self)) then return end



					self:setUseAllowed(true)

				end)

			end

		end)

	end



	function ENT:createRation(activator)
		
		local rationProp = ents.Create("prop_physics")
		
		rationProp:SetModel("models/weapons/w_packatm.mdl")
		
		rationProp:SetPos(self:GetPos())
		
		rationProp:SetAngles(self:GetAngles())

		rationProp:Spawn()
		
		rationProp:SetNotSolid(true)

		rationProp:SetParent(self.dummy)
		
		rationProp:Fire("SetParentAttachment", "package_attachment")
		
		timer.Simple(1.7, function()
		
			if (IsValid(self) and IsValid(rationProp)) then
				if self:GetNWInt("RationsQuality") == 1 then
					activator:Give("weapon_ration1m")
					activator:SelectWeapon("weapon_ration1m")
				elseif self:GetNWInt("RationsQuality") == 2 then
					activator:Give("weapon_ration2m")
					activator:SelectWeapon("weapon_ration2m")
				elseif self:GetNWInt("RationsQuality") == 3 then
					activator:Give("weapon_ration3m")
					activator:SelectWeapon("weapon_ration3m")
				elseif self:GetNWInt("RationsQuality") == 4 then
					activator:Give("weapon_ration4m")
					activator:SelectWeapon("weapon_ration4m")
				elseif self:GetNWInt("RationsQuality") == 5 then
					activator:Give("weapon_ration5m")
					activator:SelectWeapon("weapon_ration5m")
				end
				
				self:SetNWInt("RemainRations", self:GetNWInt("RemainRations") - 1)
				DarkRP.notify(activator,2,7,"Осталось рационов питания в раздатчике: "..self:GetNWInt("RemainRations"))
				rationProp:Remove()
			end

		end)

	end

	local playerCompiler
	function ENT:PhysicsCollide(data, phys)
		if data.HitEntity:GetClass() == "cuw_rationpoison" then
			self:SetNWInt("RationsQuality", 5)
			data.HitEntity:Remove()
		end



		if self:GetNWBool("Entity_CD") == true then return end
		self:SetNWBool("Entity_CD", true)
		timer.Simple(1, function() self:SetNWBool("Entity_CD", false) end)
		
		if data.HitEntity:GetNWInt("BoxWater") == 8 && data.HitEntity:GetNWInt("BoxMeat") == 3 && data.HitEntity:GetNWInt("BoxEnzymes") == 6 then
			self:SetNWInt("RationsQuality", 1)
			playerCompiler = data.HitEntity:GetNWEntity("CWU_Compiler_Owner")
			data.HitEntity:Remove()
			
			if IsValid(playerCompiler) then
				playerCompiler:SetNWFloat("Player_SalaryPoint", playerCompiler:GetNWFloat("Player_SalaryPoint") + RISED.Config.Economy.CompileRationsPerfectTokens)
				playerCompiler:SetNWFloat("Player_LoyaltyPoint", playerCompiler:GetNWFloat("Player_LoyaltyPoint") + RISED.Config.Economy.CompileRationsLoyalty)
			end
			
			self:SetNWInt("RemainRations", math.Clamp(self:GetNWInt("RemainRations") + 7, 0, 50));
			data.HitEntity:Remove()

			AddExperience(playerCompiler, RISED.Config.Experience.CompileRationsPerfectExp, "Common")
			
		elseif data.HitEntity:GetNWInt("BoxWater") < 4 || data.HitEntity:GetNWInt("BoxWater") > 12 || data.HitEntity:GetNWInt("BoxMeat") < 1 || data.HitEntity:GetNWInt("BoxMeat") > 6 || data.HitEntity:GetNWInt("BoxEnzymes") < 3 || data.HitEntity:GetNWInt("BoxEnzymes") > 9 then

		elseif data.HitEntity:GetNWInt("BoxWater") < 7 || data.HitEntity:GetNWInt("BoxWater") > 9 || data.HitEntity:GetNWInt("BoxMeat") < 2 || data.HitEntity:GetNWInt("BoxMeat") > 4 || data.HitEntity:GetNWInt("BoxEnzymes") < 5 || data.HitEntity:GetNWInt("BoxEnzymes") > 7 then
			self:SetNWInt("RationsQuality", 3)
			playerCompiler = data.HitEntity:GetNWEntity("CWU_Compiler_Owner")
			
			if IsValid(playerCompiler) then
				playerCompiler:SetNWFloat("Player_SalaryPoint", playerCompiler:GetNWFloat("Player_SalaryPoint") + RISED.Config.Economy.CompileRationsNormalTokens)
			end
			
			self:SetNWInt("RemainRations", math.Clamp(self:GetNWInt("RemainRations") + 7, 0, 50));
			data.HitEntity:Remove()

			AddExperience(playerCompiler, RISED.Config.Experience.CompileRationsNormalExp, "Common")

		elseif data.HitEntity:GetNWInt("BoxWater") < 8 || data.HitEntity:GetNWInt("BoxWater") > 8 || data.HitEntity:GetNWInt("BoxMeat") < 3 || data.HitEntity:GetNWInt("BoxMeat") > 3 || data.HitEntity:GetNWInt("BoxEnzymes") < 6 || data.HitEntity:GetNWInt("BoxEnzymes") > 6 then
			playerCompiler = data.HitEntity:GetNWEntity("CWU_Compiler_Owner")
			
			if IsValid(playerCompiler) then
				playerCompiler:SetNWFloat("Player_SalaryPoint", playerCompiler:GetNWFloat("Player_SalaryPoint") + RISED.Config.Economy.CompileRationsGoodTokens)
				playerCompiler:SetNWFloat("Player_LoyaltyPoint", playerCompiler:GetNWFloat("Player_LoyaltyPoint") + RISED.Config.Economy.CompileRationsLoyalty)
			end
			
			self:SetNWInt("RationsQuality", 2)
			self:SetNWInt("RemainRations", math.Clamp(self:GetNWInt("RemainRations") + 7, 0, 50));
			data.HitEntity:Remove()

			AddExperience(playerCompiler, RISED.Config.Experience.CompileRationsGoodExp, "Common")
		end

		local party = false
		for k,v in pairs(player.GetAll()) do
		   if GAMEMODE.SovietJobs[v:Team()] then
			   party = true
		   end
		end

		local money = playerCompiler:GetNWFloat("Player_SalaryPoint")
		local loyalty = math.floor(playerCompiler:GetNWFloat("Player_LoyaltyPoint"))

		if !party then
			playerCompiler:addMoney(money)
			DarkRP.notify(playerCompiler,2,12,"Вы получили " .. money .. " Т.")

			if loyalty >= 1 then
				playerCompiler:SetNWInt("LoyaltyTokens", math.Clamp(playerCompiler:GetNWInt("LoyaltyTokens", 0) + loyalty, -20, 100))
				hook.Call("playerLoyaltyChanged", GAMEMODE, playerCompiler, playerCompiler:GetNWInt("LoyaltyTokens"))
				playerCompiler:SetNWFloat("Player_LoyaltyPoint", playerCompiler:GetNWFloat("Player_LoyaltyPoint") - loyalty)

				DarkRP.notify(playerCompiler,2,12,"Вы получили " .. loyalty .. " ОЛ")
			end
			playerCompiler:SetNWFloat("Player_SalaryPoint", 0)
		else
			DarkRP.notify(playerCompiler,2,12,"Получите зарплату у партии в размере - " .. money .. " Т. и " .. loyalty .. " ОЛ")
		end
		hook.Call("playerNotConfirmedTokensOL", GAMEMODE, playerCompiler)
	end

	function ENT:dispense(amount, activator)

		if (amount < 1 || !IsValid(activator)) then

			self:setUseAllowed(true)
			
			return 

		end



		self:setUseAllowed(false)

		self:SetText(7)

		self:EmitSound("ambient/machines/combine_terminal_idle4.wav")

		self:createRation(activator)

		self.dummy:Fire("SetAnimation", "dispense_package", 0)



		timer.Simple(3.5, function()

			if (amount > 1) && IsValid(activator) then

				self:dispense(amount - 1, activator)

			else

				self:SetText(2)

				self:SetDispColor(COLOR_ORANGE)

				self:EmitSound("buttons/combine_button7.wav")



				timer.Simple(1, function()



					self:SetText(1)

					self:SetDispColor(COLOR_GREEN)

					self:EmitSound("buttons/combine_button1.wav")



					timer.Simple(0.75, function()

						self:setUseAllowed(true)

					end)

				end)

			end

		end)

	end

	local bool2 = false
	function ENT:Use(activator)
		
		if self:GetNWBool("DispenserOn") == false then
			self:EmitSound("buttons/combine_button_locked.wav")
			DarkRP.notify(activator,1,7,"Этот раздатчик выключен!")
			return
		end
		
		if self:GetNWInt("RemainRations") == 0 then
			self:EmitSound("buttons/combine_button_locked.wav")
			DarkRP.notify(activator,1,7,"Необходимо заправить раздатчик!")
			return
		end

		if !activator:isCP() then
			DarkRP.notify(activator,1,7,"Доступ запрещен.")
			return
		end
		
		if ((self.nextUse or 0) >= CurTime()) then

			return
		end

		if (!self.canUse or self:GetDisabled()) then

			return
		end
		
		if activator:GetNWInt("Player_RationsCombineCount") <= 0 then 
			DarkRP.notify(activator,0,7,"У вас нет доступных пищевых единиц.")
			return 
		end

		self:setUseAllowed(false)

		self:SetText(3)

		self:SetDispColor(COLOR_BLUE)

		self:EmitSound("ambient/machines/combine_terminal_idle2.wav")
		
		
		
		timer.Simple(1, function()

			if IsValid(activator) then

				local amount = 1

				if (amount < 0) then

					return self:error(5)

				--elseif (activator.nextUse or 0 > CurTime()) then

					--return self:error(6)

				else

					--activator.nextUse = CurTime() + 1

					self:SetText(4)

					self:EmitSound("buttons/button14.wav", 100, 50)

					timer.Simple(1, function()

						if IsValid(activator) then
						
							self:dispense(amount, activator)
							
							if GAMEMODE.LoyaltyJobs[activator:Team()] or GAMEMODE.CrimeJobs[activator:Team()] or activator:Team() == TEAM_CITIZENXXX then
								activator:SetNWInt("Player_RationsCombineCount", activator:GetNWInt("Player_RationsCombineCount") - 1)
								DarkRP.notify(activator,0,7,"У вас осталось " .. activator:GetNWInt("Player_RationsCombineCount") .. " пищевых единиц от вашей дневной нормы.")
							end
							
						else

							self:setUseAllowed(true)

						end

					end)

				end

			else

				self:setUseAllowed(true)

			end

		end)
	end
end