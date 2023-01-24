-- "addons\\realistichandcuffs\\lua\\weapons\\weapon_r_handcuffs\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Наручники"
	SWEP.Slot = 2
	SWEP.SlotPos = 8
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "ToBadForYou"
SWEP.Instructions = "Left Click: Restrain/Release. \nRight Click: Force Players out of vehicle. \nReload: Inspect."
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.HoldType = "melee";
SWEP.ViewModel = "models/tobadforyou/c_hand_cuffs.mdl";
SWEP.WorldModel = "models/tobadforyou/c_hand_cuffs.mdl";
SWEP.UseHands = true

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "melee"
SWEP.Category = "ToBadForYou"
SWEP.UID = 76561198208634281

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.WepSelectFont		= "HL2MPTypeDeath"
SWEP.WepSelectLetter	= "H"

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	surface.SetDrawColor( color_transparent )
	surface.SetTextColor( 0, 0, 100, alpha )
	surface.SetFont( self.WepSelectFont )
	local w, h = surface.GetTextSize( self.WepSelectLetter )

	surface.SetTextPos( x + ( wide / 2 ) - ( w / 2 ),
						y + ( tall / 2 ) - ( h / 2 ) )
	surface.DrawText( self.WepSelectLetter )

end

local LangTbl = RHandcuffsConfig.Language[RHandcuffsConfig.LanguageToUse]

function SWEP:Initialize() self:SetWeaponHoldType("melee") end
function SWEP:CanPrimaryAttack ( ) return true; end

function SWEP:PlayCuffSound(Time)
	timer.Simple(Time, function() if IsValid(self) then self:EmitSound(RHandcuffsConfig.CuffSound) end end)
	timer.Simple(Time+1, function() if IsValid(self) then self:EmitSound(RHandcuffsConfig.CuffSound) end end)
end

function SWEP:Think()
	local PlayerToCuff = self.AttemptToCuff
	if IsValid(PlayerToCuff) then
	
		local vm = self.Owner:GetViewModel();
		local ResetSeq, Time1 = vm:LookupSequence("Reset")
		
		if self.CuffingRagdoll then
			if PlayerToCuff:GetPos():Distance(self.Owner:GetPos()) > 400 then
				PlayerToCuff = nil
				vm:SendViewModelMatchingSequence(ResetSeq)	
				vm:SetPlaybackRate(2)	
			elseif CurTime() >= self.AttemptCuffFinish then
				if SERVER then
					PlayerToCuff.tazeplayer.LastRHCCuffed = self.Owner
					PlayerToCuff.tazeplayer.TazedRHCRestrained = true
				end
				PlayerToCuff.RagdollCuffed = true
				self.AttemptToCuff = nil
				vm:SendViewModelMatchingSequence(ResetSeq)	
				vm:SetPlaybackRate(2)		
			end
		else
			local TraceEnt = self.Owner:GetEyeTrace().Entity
			if !IsValid(TraceEnt) or TraceEnt != PlayerToCuff or TraceEnt:GetPos():Distance(self.Owner:GetPos()) > RHandcuffsConfig.CuffRange then
				self.AttemptToCuff = nil
				vm:SendViewModelMatchingSequence(ResetSeq)	
				vm:SetPlaybackRate(2)	
			elseif CurTime() >= self.AttemptCuffFinish then
				if SERVER then
					PlayerToCuff:RHCRestrain(self.Owner)
				end
				self.AttemptToCuff = nil	
				vm:SendViewModelMatchingSequence(ResetSeq)	
				vm:SetPlaybackRate(2)
			end	
		end	
	end	
end

function SWEP:PrimaryAttack()
	self.Weapon:EmitSound("npc/vort/claw_swing" .. math.random(1, 2) .. ".wav")
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	
	local Trace = self.Owner:GetEyeTrace()
		
	self.Weapon:SetNextPrimaryFire(CurTime() + 3)
		
	local TPlayer = Trace.Entity
	
	if TPlayer:IsPlayer() then
		if GAMEMODE.ZombieJobs[TPlayer:Team()] then return false end
	end
	if !IsValid(TPlayer) then return false end
	local Distance = self.Owner:EyePos():Distance(TPlayer:GetPos());
	if Distance > 400 then return false; end
	
	if TPlayer:GetNWBool("rks_restrained", false) then
		if SERVER then
			DarkRP.notify(self.Owner, 1, 4, LangTbl.CantCuffRestrained)
		end
		return
	end	
	if TPlayer:IsPlayer() and !GAMEMODE.CombineJobs[TPlayer:Team()] and !IsValid(self.AttemptToCuff) then
		if TPlayer:GetNWBool("rhc_cuffed", false) then
			if SERVER then
				TPlayer:RHCRestrain(self.Owner)
			end
		else
			self.CuffingRagdoll = false
			self.AttemptToCuff = TPlayer
			self.AttemptCuffFinish = CurTime() + RHandcuffsConfig.CuffTime
			self.AttemptCuffStart = CurTime()
			local vm = self.Owner:GetViewModel();
			local DeploySeq, Time = vm:LookupSequence("Deploy")
	
			vm:SendViewModelMatchingSequence(DeploySeq)	
			vm:SetPlaybackRate(2)
			self:PlayCuffSound(.3)
		end
	elseif !TPlayer.RagdollCuffed and TPlayer:GetNWBool("CanRHCArrest", false) then
		self.CuffingRagdoll = true
		self.AttemptToCuff = TPlayer
		self.AttemptCuffFinish = CurTime() + RHandcuffsConfig.CuffTime
		self.AttemptCuffStart = CurTime()
		local vm = self.Owner:GetViewModel();
		local DeploySeq, Time = vm:LookupSequence("Deploy")
	
		vm:SendViewModelMatchingSequence(DeploySeq)	
		vm:SetPlaybackRate(2)
		self:PlayCuffSound(.3)
	end
end

function SWEP:Reload()
/*
	if self.NextRPress and self.NextRPress > CurTime() then return end
	self.NextRPress = CurTime() + 1
	if CLIENT then return end
	
	if !self.Owner:IsRHCWhitelisted() then return end
	
	local Trace = self.Owner:GetEyeTrace()
		
	self.Weapon:SetNextPrimaryFire(CurTime() + 3)
		
	local TPlayer = Trace.Entity
	local Distance = self.Owner:EyePos():Distance(TPlayer:GetPos());
	if Distance > 100 then return false; end	
	
	if TPlayer.Restrained then	
		self.Owner:RHCInspect(TPlayer)
	end
*/
end	

function SWEP:SecondaryAttack()
	if SERVER then 
		self.Weapon:SetNextSecondaryFire(CurTime() + 1)
		local Player = self.Owner
		local Trace = Player:GetEyeTrace()
	
		local TVehicle = Trace.Entity
		local Distance = Player:GetPos():Distance(TVehicle:GetPos());
		if Distance > 300 then return false; end	
		if IsValid(TVehicle) and TVehicle:IsVehicle() then
			if vcmod1 then
				if !Player.Dragging then
					for k,v in pairs(TVehicle:VC_GetPlayers()) do
						if v.Restrained then 
							local DraggedByP = v.DraggedBy
							if IsValid(DraggedByP) then
								DraggedByP.Dragging = nil
							end
							v.DraggedBy = nil
							v:ExitVehicle()
						end
					end
				elseif Player.Dragging then
					local PlayerDragged = Player.Dragging
					if IsValid(PlayerDragged) then
						local SeatsTBL = TVehicle:VC_GetSeatsAvailable()
						if #SeatsTBL < 1 then DarkRP.notify(Player, 1, 4, LangTbl.NoSeats) if !IsValid(TVehicle:GetDriver()) then PlayerDragged:EnterVehicle(TVehicle) DarkRP.notify(Player, 1, 4, LangTbl.PlayerPutInDriver) end return end
						for k,v in pairs(SeatsTBL) do
							local SeatsDist = Player:GetPos():Distance(v:GetPos())
							if SeatsDist < 80 then
								PlayerDragged:EnterVehicle(v)
								break
							end
						end
					end				
				end
			elseif NOVA_Config then
				if !Player.Dragging then
					local Passengers = TVehicle:CMGetAllPassengers()
					for k,v in pairs(Passengers) do
						if v and v:IsPlayer() and v.Restrained then
							local DraggedByP = v.DraggedBy
							if IsValid(DraggedByP) then
								DraggedByP.Dragging = nil
							end
							v.DraggedBy = nil
							v:ExitVehicle()	
						end	
					end
				elseif Player.Dragging then
					local PlayerDragged = Player.Dragging
					if IsValid(PlayerDragged) then
						local SeatsTBL = table.Copy(TVehicle.CmodSeats)
						for k,v in pairs(SeatsTBL) do
							local Driver = v:GetDriver()
							if IsValid(Driver) and Driver:IsPlayer() then
								SeatsTBL[k] = nil
							end
						end
						if table.Count(SeatsTBL) < 1 then DarkRP.notify(Player, 1, 4, LangTbl.NoSeats) if !IsValid(TVehicle:GetDriver()) then PlayerDragged:EnterVehicle(TVehicle) DarkRP.notify(Player, 1, 4, LangTbl.PlayerPutInDriver) end return end
						for k,v in pairs(SeatsTBL) do
							local SeatsDist = Player:GetPos():Distance(v:GetPos())
							if SeatsDist < 80 then
								PlayerDragged:EnterVehicle(v)
								break
							end
						end
					end				
				end
			elseif TVehicle.Seats then
				if !Player.Dragging then
					local Seats = TVehicle.Seats
					for k,v in pairs(Seats) do
						local Passenger = v:GetDriver()
						if IsValid(Passenger) and Passenger.Restrained then
							local DraggedByP = Passenger.DraggedBy
							if IsValid(DraggedByP) then
								DraggedByP.Dragging = nil
							end
							Passenger.DraggedBy = nil
							Passenger:ExitVehicle()	
						end	
					end				
				elseif Player.Dragging then
					local PlayerDragged = Player.Dragging
					if IsValid(PlayerDragged) then
						local SeatsTBL = TVehicle.Seats
						SeatsTBL[1] = nil
						for k,v in pairs(SeatsTBL) do
							local Driver = v:GetDriver()
							if IsValid(Driver) and Driver:IsPlayer() then
								SeatsTBL[k] = nil
							end
						end
						if #SeatsTBL < 1 then DarkRP.notify(Player, 1, 4, LangTbl.NoSeats) return end
						for k,v in pairs(SeatsTBL) do
							local SeatsDist = Player:GetPos():Distance(v:GetPos())
							if SeatsDist < 150 then
								PlayerDragged:EnterVehicle(v)
								break
							end
						end
					end					
				end	
			elseif Player.Dragging and !vcmod1 then
				local DragPlayer = Player.Dragging
				if IsValid(DragPlayer) then
					if	TVehicle:GetPos():Distance(self.Owner:GetPos()) < 85 then
						DragPlayer:EnterVehicle(TVehicle)
					end
				end	
			elseif IsValid(TVehicle:GetDriver()) and TVehicle:GetDriver().Restrained then
				if TVehicle:GetDriver():GetModel() != "models/beta stalker/beta_stalker.mdl" then
					if	TVehicle:GetPos():Distance(self.Owner:GetPos()) < 85 then
						TVehicle:GetDriver():ExitVehicle()
					end
				end
			end
		end
	end
end

if CLIENT then
function SWEP:DrawHUD()
    local PlayerToCuff = self.AttemptToCuff
	if !IsValid(PlayerToCuff) then return end

    local time = self.AttemptCuffFinish - self.AttemptCuffStart
    local curtime = CurTime() - self.AttemptCuffStart
    local percent = math.Clamp(curtime / time, 0, 1)	
    local w = ScrW()
    local h = ScrH()
	local Nick = ""
	if self.CuffingRagdoll then
		Nick = LangTbl.TazedPlayer
	else 
		Nick = PlayerToCuff:Nick()
	end

	local TPercent = math.Round(percent*100)
	local TextToDisplay = string.format(LangTbl.CuffingText, Nick)
    draw.DrawNonParsedSimpleText(TextToDisplay .. " (" .. TPercent .. "%)", "Trebuchet24", w/2, h/2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)	
end
end