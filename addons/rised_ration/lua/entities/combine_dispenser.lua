-- "addons\\rised_ration\\lua\\entities\\combine_dispenser.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-----------------------------------------------------
AddCSLuaFile()

ENT.Type = "anim"

ENT.PrintName = "Combine Dispenser"

ENT.Author = "D-Rised"

ENT.Category = "HL2 RP"

ENT.Spawnable = true

ENT.AdminOnly = true

ENT.PhysgunDisable = true

ENT.PhysgunAllowAdmin = true

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

if (CLIENT) then
	local x = 600
	local bool = false
	local cam, render, surface, draw, math = cam, render, surface, draw, math

	function ENT:Draw()

		local position, angles = self:GetPos(), self:GetAngles()

		angles:RotateAroundAxis(angles:Forward(), 90)

		angles:RotateAroundAxis(angles:Right(), 270)



		local col = Color( 255, 255, 255, 255 )

		if self:GetNWBool("DispenserOn") == true and self:GetNWInt("RemainRations") > 0 then
			col = Color( 155, 255, 155, 255 )
		elseif self:GetNWInt("RemainRations") <= 0 then
			col = Color( 255, 255, 255, 255 )
		elseif self:GetNWBool("DispenserOn") == false then
			col = Color( 255, 0, 0, 255 )
		end
		
		
		local pos = self:GetPos() + self:GetAngles():Forward() * 7 + self:GetAngles():Right() * -1.5 + self:GetAngles():Up() * 16.5
		local rand = math.Rand(1,1.5)
		render.SetMaterial( Material( "sprites/glow04_noz" ) )
		render.DrawSprite( pos, 2.5 + rand, 3 + rand, col )
	end
else

	function ENT:Initialize()
	
		self:SetNWInt("RemainRations", 10);
		SetGlobalInt("Factory_Rations_Dispenser", self:GetNWInt("RemainRations"))
		self:SetNWInt("RationsQuality", 1);
		
		for k, v in pairs (player.GetAll()) do 
			v:SetNWBool("Ration_Timer", false)
		end
		
		self:SetModel("models/props_junk/gascan001a.mdl")

		self:PhysicsInit(SOLID_VPHYSICS)

		self:SetSolid(SOLID_VPHYSICS)

		self:SetMoveType(MOVETYPE_VPHYSICS)

		self:SetUseType(SIMPLE_USE)

		self:SetText(1)

		self:DrawShadow(false)

		self:SetDispColor(COLOR_GREEN)

		self.canUse = true



		-- Use prop_dynamic so we can use entity:Fire("SetAnimation")

		self.dummy = ents.Create("prop_dynamic")

		self.dummy:SetModel("models/props_combine/combine_dispenser.mdl")

		self.dummy:SetPos(self:LocalToWorld(Vector(-2,0,0)))

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
		
		rationProp:SetModel("models/weapons/w_package.mdl")
		
		rationProp:SetPos(self:GetPos())
		
		rationProp:SetAngles(self:GetAngles())

		rationProp:Spawn()
		
		rationProp:SetNotSolid(true)

		rationProp:SetParent(self.dummy)
		
		rationProp:Fire("SetParentAttachment", "package_attachment")
		
		timer.Simple(1.7, function()
		
			if (IsValid(self) and IsValid(rationProp)) then
				if self:GetNWInt("RationsQuality") == 1 then
					activator:Give("weapon_ration1")
					activator:SelectWeapon("weapon_ration1")
				elseif self:GetNWInt("RationsQuality") == 2 then
					activator:Give("weapon_ration2")
					activator:SelectWeapon("weapon_ration2")
				elseif self:GetNWInt("RationsQuality") == 3 then
					activator:Give("weapon_ration3")
					activator:SelectWeapon("weapon_ration3")
				elseif self:GetNWInt("RationsQuality") == 4 then
					activator:Give("weapon_ration4")
					activator:SelectWeapon("weapon_ration4")
				elseif self:GetNWInt("RationsQuality") == 5 then
					activator:Give("weapon_ration5")
					activator:SelectWeapon("weapon_ration5")
				end
				
				self:SetNWInt("RemainRations", self:GetNWInt("RemainRations") - 1)
				DarkRP.notify(activator,2,7,"Осталось рационов питания в раздатчике: "..self:GetNWInt("RemainRations"))
				SetGlobalInt("Factory_Rations_Dispenser", self:GetNWInt("RemainRations"))

				rationProp:Remove()
			end

		end)

	end

	local worker
	function ENT:PhysicsCollide(data, phys)
		if data.HitEntity:GetClass() == "cuw_rationpoison" then
			self:SetNWInt("RationsQuality", 5)
			data.HitEntity:Remove()
		end
	
		-- if data.HitEntity:GetNWInt("BoxWater") <= 0 || data.HitEntity:GetNWInt("BoxMeat") <= 0 || data.HitEntity:GetNWInt("BoxEnzymes") <= 0 then
		-- 	return
		-- end


		if self:GetNWBool("Entity_CD") == true then return end
		self:SetNWBool("Entity_CD", true)
		timer.Simple(1, function() self:SetNWBool("Entity_CD", false) end)

		local salary_points = 0
		local loyalty_points = 0
		
		if data.HitEntity:GetNWInt("BoxWater") == 8 && data.HitEntity:GetNWInt("BoxMeat") == 3 && data.HitEntity:GetNWInt("BoxEnzymes") == 6 then
			self:SetNWInt("RationsQuality", 1)
			worker = data.HitEntity:GetNWEntity("CWU_Compiler_Owner")
			data.HitEntity:Remove()
			
			if IsValid(worker) then
				salary_points = RISED.Config.Economy.CompileRationsPerfectTokens
				loyalty_points = RISED.Config.Economy.CompileRationsLP_Perfect
				worker:SetNWFloat("Player_SalaryPoint", worker:GetNWFloat("Player_SalaryPoint") + RISED.Config.Economy.CompileRationsPerfectTokens)
				worker:SetNWFloat("Player_LoyaltyPoint", math.Round(worker:GetNWFloat("Player_LoyaltyPoint") + RISED.Config.Economy.CompileRationsLP_Perfect, 4))
			end
			
			self:SetNWInt("RemainRations", math.Clamp(self:GetNWInt("RemainRations") + 3, 0, 50));
			data.HitEntity:Remove()

			AddExperience(worker, RISED.Config.Experience.CompileRationsPerfectExp, "Common")

		elseif data.HitEntity:GetNWInt("BoxWater") < 4 || data.HitEntity:GetNWInt("BoxWater") > 12 || data.HitEntity:GetNWInt("BoxMeat") < 1 || data.HitEntity:GetNWInt("BoxMeat") > 6 || data.HitEntity:GetNWInt("BoxEnzymes") < 3 || data.HitEntity:GetNWInt("BoxEnzymes") > 9 then

		elseif data.HitEntity:GetNWInt("BoxWater") < 7 || data.HitEntity:GetNWInt("BoxWater") > 9 || data.HitEntity:GetNWInt("BoxMeat") < 2 || data.HitEntity:GetNWInt("BoxMeat") > 4 || data.HitEntity:GetNWInt("BoxEnzymes") < 5 || data.HitEntity:GetNWInt("BoxEnzymes") > 7 then
			self:SetNWInt("RationsQuality", 3)
			worker = data.HitEntity:GetNWEntity("CWU_Compiler_Owner")
			
			if IsValid(worker) then
				salary_points = RISED.Config.Economy.CompileRationsNormalTokens
				worker:SetNWFloat("Player_SalaryPoint", worker:GetNWFloat("Player_SalaryPoint") + RISED.Config.Economy.CompileRationsNormalTokens)
			end
			
			self:SetNWInt("RemainRations", math.Clamp(self:GetNWInt("RemainRations") + 3, 0, 50));
			data.HitEntity:Remove()

			AddExperience(worker, RISED.Config.Experience.CompileRationsNormalExp, "Common")

		elseif data.HitEntity:GetNWInt("BoxWater") < 8 || data.HitEntity:GetNWInt("BoxWater") > 8 || data.HitEntity:GetNWInt("BoxMeat") < 3 || data.HitEntity:GetNWInt("BoxMeat") > 3 || data.HitEntity:GetNWInt("BoxEnzymes") < 6 || data.HitEntity:GetNWInt("BoxEnzymes") > 6 then
			worker = data.HitEntity:GetNWEntity("CWU_Compiler_Owner")
			
			if IsValid(worker) then
				salary_points = RISED.Config.Economy.CompileRationsGoodTokens
				loyalty_points = RISED.Config.Economy.CompileRationsLP_Good
				worker:SetNWFloat("Player_SalaryPoint", worker:GetNWFloat("Player_SalaryPoint") + RISED.Config.Economy.CompileRationsGoodTokens)
				worker:SetNWFloat("Player_LoyaltyPoint", math.Round(worker:GetNWFloat("Player_LoyaltyPoint") + RISED.Config.Economy.CompileRationsLP_Good, 4))
			end
			
			self:SetNWInt("RationsQuality", 2)
			self:SetNWInt("RemainRations", math.Clamp(self:GetNWInt("RemainRations") + 3, 0, 50));
			data.HitEntity:Remove()

			AddExperience(worker, RISED.Config.Experience.CompileRationsGoodExp, "Common")
		end

		SetGlobalInt("Factory_Rations_Dispenser", self:GetNWInt("RemainRations"))

		if !PartyOnServer() then
			local money = worker:GetNWFloat("Player_SalaryPoint")
			worker:addMoney(money)
			worker:SetNWFloat("Player_SalaryPoint", 0)
			DarkRP.notify(worker,2,12,"Вы получили " .. money .. " Т.")
		else
			DarkRP.notify(worker,2,12,"Вы получили " .. salary_points .. " ЗЕ. и " .. loyalty_points .. " неподтвержденных ОЛ")
		end
		hook.Call("playerNotConfirmedTokensOL", GAMEMODE, worker)
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
		
		if ((self.nextUse or 0) >= CurTime()) then

			return

		end

		if (!self.canUse or self:GetDisabled()) then

			return

		end
		
		if !activator.rationPoints or activator.rationPoints and activator.rationPoints <= 0 and !activator:isCP() and !GAMEMODE.Rebels[activator:Team()] then 
			DarkRP.notify(activator,0,7,"У вас нет доступных пищевых единиц")
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
								activator.rationPoints = activator.rationPoints - 1
								DarkRP.notify(activator,0,7,"У вас осталось " .. activator.rationPoints .. " пищевых единиц от вашей дневной нормы.")
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

		--elseif (activator:IsCP()) then // TO DO RANG

		--	self:SetDisabled(!self:GetDisabled())

		--	self:EmitSound(self:GetDisabled() and "buttons/combine_button1.wav" or "buttons/combine_button2.wav")

		--	self.nextUse = CurTime() + 1

		--end

	end

end