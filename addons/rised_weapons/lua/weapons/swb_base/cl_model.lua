-- "addons\\rised_weapons\\lua\\weapons\\swb_base\\cl_model.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

-----------------------------------------------------
SWEP.BlendPos = Vector(0, 0, 0)
SWEP.BlendAng = Vector(0, 0, 0)
SWEP.OldDelta = Angle(0, 0, 0)
SWEP.AngleDelta = Angle(0, 0, 0)
SWEP.FireMove = 0
SWEP.ViewModelMovementScale = 1
SWEP.Sequence = ""
SWEP.Cycle = 0
SWEP.NoStockShells = true
SWEP.NoStockMuzzle = true

local Vec0 = Vector(0, 0, 0)
local TargetPos, TargetAng, cos1, sin1, tan, ws, rs, mod, EA, delta, sin2, mul, vm, muz, muz2, tr, att
local td = {}

local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length
local Right = reg.Angle.Right
local Up = reg.Angle.Up
local Forward = reg.Angle.Forward
local RotateAroundAxis = reg.Angle.RotateAroundAxis

function SWEP:GetTracerOrigin()
	if self.dt.State == SWB_AIMING and self.SimulateCenterMuzzle then
		return self.CenterPos
	end
end

function SWEP:CreateShell(sh)
	if not IsValid(self.Owner) or self.Owner:ShouldDrawLocalPlayer() or self.NoShells then
		return
	end
	
	sh = self.Shell or sh
	vm = self.Owner:GetViewModel()
	
	if not IsValid(vm) then
		return
	end
	
	att = vm:GetAttachment(2)
	if att then

		if self:GetClass() == "swb_ak74" then
			dir = att.Ang:Forward() * -2 + att.Ang:Up() * math.random(6,7) + att.Ang:Right() * math.random(-1,1)
			SWB_MakeFakeShell(sh, att.Pos + dir, EyeAngles(), dir * 8, 0.6, 10, self.ShellScale)
		
		elseif self:GetClass() == "swb_akm" then
			dir = att.Ang:Forward() * math.random(3,5) + att.Ang:Up() * math.random(-3,-5) + att.Ang:Right() * math.random(-1,-1)
			SWB_MakeFakeShell(sh, att.Pos + dir, EyeAngles(), dir * 8, 0.6, 10, self.ShellScale)

		elseif self:GetClass() == "swb_rpk" then
			dir = att.Ang:Forward() * math.random(3,4) + att.Ang:Up() * math.random(-1,-1) + att.Ang:Right() * math.random(-1,-1)
			SWB_MakeFakeShell(sh, att.Pos + dir, EyeAngles(), dir * 8, 0.6, 10, self.ShellScale)
		
		elseif self:GetClass() == "swb_357" then
			dir = att.Ang:Forward() * -2 + att.Ang:Up() * -1 + att.Ang:Right() * math.random(3,5)
			SWB_MakeFakeShell(sh, att.Pos + dir, EyeAngles(), dir * 8, 0.6, 10, self.ShellScale)

		elseif self:GetClass() == "swb_m60" then
			dir = att.Ang:Forward() * math.random(3, 4) + att.Ang:Up() * -3 + att.Ang:Right() * math.random(-5, -6)
			SWB_MakeFakeShell(sh, att.Pos + dir, EyeAngles(), dir * 8, 0.6, 10, self.ShellScale)

		elseif self:GetClass() == "swb_toz" then
			timer.Simple(0.5, function() 
				att = vm:GetAttachment(2)
				dir = att.Ang:Forward() * -10 + att.Ang:Up() * 5 + att.Ang:Right() * 2
				SWB_MakeFakeShell(sh, att.Pos + dir, EyeAngles(), dir * 8, 0.6, 10, self.ShellScale)
			end)

		elseif self:GetClass() == "swb_mp5k" and self.dt.State == SWB_AIMING then
			dir = att.Ang:Forward() * 2
			ang = AngleRand()
			SWB_MakeFakeShell(sh, att.Pos + dir, ang, dir * 55, 1, 1, self.ShellScale)

		elseif self:GetClass() == "swb_tt" then
			dir = att.Ang:Forward() * 2 + att.Ang:Up() * 5
			SWB_MakeFakeShell(sh, att.Pos + dir, EyeAngles(), dir * 5, 0.6, 10, self.ShellScale)

		elseif self:GetClass() == "swb_mosin" then
			dir = att.Ang:Forward() * -30 + att.Ang:Up() * 12
			timer.Simple(0.8, function() SWB_MakeFakeShell(sh, att.Pos + dir, EyeAngles(), dir * 12, 0.6, 10, self.ShellScale * 2) end)

		elseif self:GetClass() == "swb_asval" then
			dir = att.Ang:Forward() * -17 + att.Ang:Up() * math.random(6, 8)
			SWB_MakeFakeShell(sh, att.Pos + dir, EyeAngles(), dir * 5, 0.6, 10, self.ShellScale)

		elseif self:GetClass() == "swb_357" then
			dir = att.Ang:Forward() * -10 + att.Ang:Up() * 0
			SWB_MakeFakeShell(sh, att.Pos + dir, EyeAngles(), dir * 10, 1, 1, self.ShellScale)

		elseif self:GetClass() == "swb_gsh18" then
			dir = att.Ang:Forward() * -2 + att.Ang:Up() * math.random(3, 4)
			SWB_MakeFakeShell(sh, att.Pos + dir, EyeAngles(), dir * 10, 1, 1, self.ShellScale)

		elseif self:GetClass() == "swb_smg" then
			dir = att.Ang:Forward() * -10 + att.Ang:Up() * 0
			SWB_MakeFakeShell(sh, att.Pos + dir, EyeAngles(), dir * 10, 1, 1, self.ShellScale)

		elseif self:GetClass() == "swb_shotgun" then
			timer.Simple(0.5, function()
				dir = att.Ang:Forward() * 2 + att.Ang:Up() * -3
				SWB_MakeFakeShell(sh, att.Pos + dir, EyeAngles(), dir * 8, 0.6, 10, self.ShellScale)
			end)
		end
	end
end

function SWEP:CreateMuzzle(pos, ang)

	if self.Owner:ShouldDrawLocalPlayer() then
		return
	end

	vm = self.Owner:GetViewModel()
	
	if IsValid(vm) then
		vm:StopParticles()

		muz = vm:LookupAttachment("1")

		if muz == 0 then muz = vm:LookupAttachment("muzzle") end
		
		if muz then
			muz2 = vm:GetAttachment(muz)
			
			if muz2 then
				EA = EyeAngles()
				
				if self.MuzzlePosMod then
					pos = pos + EA:Right() * self.MuzzlePosMod.x + EA:Forward() * self.MuzzlePosMod.y + EA:Up() * self.MuzzlePosMod.z
				end
					
				if self.dt.State == SWB_AIMING and self.SimulateCenterMuzzle then
					pos = self.Owner:GetShootPos() + EA:Forward() * 15 - EA:Up() * 6
					self.CenterPos = pos
				end
				
				if self.dt.Suppressed then
					if self.MuzzleEffectSupp then
						if not self.NoSilMuz then
							if self.dt.State == SWB_AIMING and self.SimulateCenterMuzzle then
								ParticleEffect(self.MuzzleEffectSupp, pos + self.Owner:GetVelocity() * 0.03, EA, vm)
							else
								ParticleEffectAttach(self.MuzzleEffectSupp, PATTACH_POINT_FOLLOW, vm, muz)
							end
						end
					end
				else
					if self.MuzzleEffect and self.dt.State != SWB_AIMING or (self.MuzzleEffect and !self.AimOverlay and self.dt.State == SWB_AIMING) then
						-- RISED KOSTYL --
						if self.dt.State == SWB_AIMING and self.RisedAimMuzzle then
							pos = self.Owner:GetShootPos() + EA:Forward() * 25 - EA:Up() * 1
							ParticleEffect("swb_silenced_small", pos + self.Owner:GetVelocity() * 0.03, EA, vm)
						else
							ParticleEffectAttach("swb_silenced_small", PATTACH_POINT_FOLLOW, vm, muz)
						end
					end
				end
			end
		end
	end
end

SWBShells = {}
SWBShells["mainshell"] = {m = "models/weapons/rifleshell.mdl", s = {"player/pl_shell1.wav", "player/pl_shell2.wav", "player/pl_shell3.wav"}}
SWBShells["shotshell"] = {m = "models/weapons/Shotgun_shell.mdl", s = {"weapons/fx/tink/shotgun_shell1.wav", "weapons/fx/tink/shotgun_shell2.wav", "weapons/fx/tink/shotgun_shell3.wav"}}
SWBShells["smallshell"] = {m = "models/weapons/shell.mdl", s = {"player/pl_shell1.wav", "player/pl_shell2.wav", "player/pl_shell3.wav"}}

function SWB_MakeFakeShell(shell, pos, ang, vel, time, removetime, shellscale)
	if not shell or not pos or not ang then
		return
	end

	local t = SWBShells[shell]
	
	if not t then
		return
	end

	vel = vel or Vector(0, 0, -100)
	vel = vel + VectorRand() * 5
	time = time or 0.5
	removetime = removetime or 5
	shellscale = shellscale or 1
	
	local ent = ClientsideModel(t.m, RENDERGROUP_BOTH) 
	ent:SetPos(pos)
	ent:PhysicsInitBox(Vector(-0.5, -0.15, -0.5), Vector(0.5, 0.15, 0.5))
	ent:SetAngles(ang)
	ent:SetModelScale(shellscale, 0)
	ent:SetMoveType(MOVETYPE_VPHYSICS) 
	ent:SetSolid(SOLID_VPHYSICS) 
	ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)
	
	local phys = ent:GetPhysicsObject()
	phys:SetMaterial("gmod_silent")
	phys:SetMass(10)
	phys:SetVelocity(vel)

	timer.Simple(time, function()
		if t.s then
			ent:EmitSound(table.Random(t.s), 35, 100)
		end
	end)
	
	SafeRemoveEntityDelayed(ent, removetime)
end

function SWEP:GetMuzzleAttachment()
	local vmod = self.OwnerViewModel
	local att = math.max(1, self.MuzzleAttachmentRaw or (sp and vmod or self):LookupAttachment("mizzle"))

	return att
end

function SWEP:FireAnimationEvent(pos, ang, ev, name)
	local retVal = hook.Run("TFA_MuzzleFlash",self)
	if retVal ~= nil then
		return retVal
	end
	local att = self:GetMuzzleAttachment()
	fx = EffectData()
	fx:SetOrigin(self:GetOwner():GetShootPos())
	fx:SetNormal(self:GetOwner():EyeAngles():Forward())
	fx:SetEntity(self)
	fx:SetAttachment(att)
	util.Effect( "MuzzleFlash", fx )

	if true then
		if self.MuzzleEffect then
			self:CreateMuzzle(pos, ang)
		end
	end

	if ev == 5001 then
		if self.MuzzleEffect then
			self:CreateMuzzle(pos, ang)
		end
		
		if self.NoStockMuzzle then
			return true
		end
		
		return self.dt.Suppressed
	end

	if ev == 20 then
		if self.Shell then
			self:CreateShell()
		end
		
		return self.NoStockShells
	elseif ev == 21 then
		if self.Shell then
			self:CreateShell()
		end
		
		return self.NoStockShells
	end
end

SWEP.ApproachSpeed = 10
local SP = game.SinglePlayer() 
local PosMod, AngMod = Vector(0, 0, 0), Vector(0, 0, 0)
local CurPosMod, CurAngMod = Vector(0, 0, 0), Vector(0, 0, 0)
local veldepend = {pitch = 0, yaw = 0, roll = 0}
local mod2 = 0
local EA2

function SWEP:PreDrawViewModel()
	CT = UnPredictedCurTime()
	vm = self.Owner:GetViewModel()
	
	self.Sequence = vm:GetSequenceName(vm:GetSequence())
	self.IsReloading = self.Sequence:find("reload")
	
	if not self.IsReloading then
		self.IsReloading = self.Sequence:find("insert")
	end
	
	if not self.IsReloading then
		self.IsFiddlingWithSuppressor = self.Sequence:find("silencer")
	end
	
	self.Cycle = vm:GetCycle()
	
	EA = EyeAngles()
	FT = FrameTime()
	
	delta = Angle(EA.p, EA.y, 0) - self.OldDelta
	delta.p = math.Clamp(delta.p, -10, 10)
		
	self.OldDelta = Angle(EA.p, EA.y, 0)
	self.AngleDelta = LerpAngle(math.Clamp(FT * 10, 0, 1), self.AngleDelta, delta)
	self.AngleDelta.y = math.Clamp(self.AngleDelta.y, -10, 10)

	vel = GetVelocity(self.Owner)
	len = Length(vel)
	ws = self.Owner:GetWalkSpeed()
	
	PosMod, AngMod = Vec0 * 1, Vec0 * 1
	mod2 = 1
	
	veldepend.roll = math.Clamp((vel:DotProduct(EA:Right()) * 0.04) * len / ws, -5, 5)
	
	if self.dt.State == SWB_AIMING then
		mod2 = 0.2
		TargetPos, TargetAng = self.AimPos * 1, self.AimAng * 1
		self.ApproachSpeed = math.Approach(self.ApproachSpeed, 8, FT * 100)
	elseif self.dt.State == SWB_ACTION then
		TargetPos, TargetAng = self.SwimPos * 1, self.SwimAng * 1
		self.ApproachSpeed = math.Approach(self.ApproachSpeed, 5, FT * 100)
	elseif self.dt.State == SWB_RUNNING or (((len > ws * 1.2 and self.Owner:KeyDown(IN_SPEED)) or len > ws * 3 or (self.ForceRunStateVelocity and len > self.ForceRunStateVelocity)) and self.Owner:OnGround()) then
		if self.IsReloading and self.Cycle < 0.9 then
			TargetPos, TargetAng = Vec0 * 1, Vec0 * 1
		else
			if self.SprintingEnabled then
				TargetPos, TargetAng = self.SprintPos * 1, self.SprintAng * 1
			else
				TargetPos, TargetAng = Vec0 * 1, Vec0 * 1
			end
		end
		
		rs = self.Owner:GetRunSpeed()
		mod = 7 + math.Clamp(rs / 100, 0, 6)
		mul = math.Clamp(len / rs, 0, 1)
		sin1 = math.sin(CT * mod) * mul
		cos1 = math.cos(CT * mod) * mul
		tan1 = math.tan(sin1 * cos1) * mul
		
		if (self.IsReloading or self.IsFiddlingWithSuppressor) and self.Cycle <= 0.9 then
			AngMod.x = AngMod.x + tan1 * 0.2 * self.ViewModelMovementScale * mul
			AngMod.y = AngMod.y - cos1 * 1.5 * self.ViewModelMovementScale * mul
			AngMod.z = AngMod.z + cos1 * 3 * self.ViewModelMovementScale * mul
			PosMod.x = PosMod.x - sin1 * 1.2 * self.ViewModelMovementScale * mul
			PosMod.y = PosMod.y + tan1 * 3 * self.ViewModelMovementScale * mul
			PosMod.z = PosMod.z + tan1 * 1.5 * self.ViewModelMovementScale * mul
			
			self.ApproachSpeed = math.Approach(self.ApproachSpeed, 4, FT * 100)
		else
			AngMod.x = AngMod.x + tan1 * 0.2 * self.ViewModelMovementScale * mul
			AngMod.y = AngMod.y - cos1 * 1.5 * self.ViewModelMovementScale * mul
			AngMod.z = AngMod.z + cos1 * 3 * self.ViewModelMovementScale * mul
			PosMod.x = PosMod.x - sin1 * 1.2 * self.ViewModelMovementScale * mul
			PosMod.y = PosMod.y + tan1 * 3 * self.ViewModelMovementScale * mul
			PosMod.z = PosMod.z + tan1 * 1.5 * self.ViewModelMovementScale * mul
			
			self.ApproachSpeed = math.Approach(self.ApproachSpeed, 6, FT * 100)
		end
	else
		if self.dt.Safe then
			TargetPos, TargetAng = self.SprintPos * 1, self.SprintAng * 1
		else
			TargetPos, TargetAng = Vec0 * 1, Vec0 * 1
		end

		self.ApproachSpeed = math.Approach(self.ApproachSpeed, 10, FT * 100)
		
		td.start = self.Owner:GetShootPos()
		td.endpos = td.start + self.Owner:EyeAngles():Forward() * 30
		td.filter = self.Owner
		
		tr = util.TraceLine(td)
		
		if tr.Hit then
			self.NearWall = true
			TargetPos.y = TargetPos.y - math.Clamp(30 * (1 - tr.Fraction), 0, 15)
		end
	end
	
	if len < 10 or not self.Owner:OnGround() then
		if self.dt.State != SWB_AIMING then
			cos1, sin1 = math.cos(CT), math.sin(CT)
			tan = math.atan(cos1 * sin1, cos1 * sin1)
			
			AngMod.x = AngMod.x + tan * 1.15
			AngMod.y = AngMod.y + cos1 * 0.4
			AngMod.z = AngMod.z + tan
			
			PosMod.y = PosMod.y + tan * 0.2 * mod2
		end
	elseif len > 10 and len < ws * 1.2 then
		mod = 6 + ws / 130
		mul = math.Clamp(len / ws, 0, 1)
		sin1 = math.sin(CT * mod) * mul
		cos1 = math.cos(CT * mod) * mul
		tan1 = math.tan(sin1 * cos1) * mul
		
		AngMod.x = AngMod.x + tan1 * self.ViewModelMovementScale * mod2
		AngMod.y = AngMod.y - cos1 * self.ViewModelMovementScale * mod2
		AngMod.z = AngMod.z + cos1 * self.ViewModelMovementScale * mod2
		PosMod.x = PosMod.x - sin1 * 0.4 * self.ViewModelMovementScale * mod2
		PosMod.y = PosMod.y + tan1 * 1 * self.ViewModelMovementScale * mod2
		PosMod.z = PosMod.z + tan1 * 0.5 * self.ViewModelMovementScale * mod2
	end
	
	FT = FrameTime()
	
	TargetAng.z = TargetAng.z + veldepend.roll
	self.BlendPos = LerpVector(FT * self.ApproachSpeed, self.BlendPos, TargetPos)
	self.BlendAng = LerpVector(FT * self.ApproachSpeed, self.BlendAng, TargetAng)
	
	CurPosMod = LerpVector(FT * 10, CurPosMod, PosMod)
	CurAngMod = LerpVector(FT * 10, CurAngMod, AngMod)
	
	self.FireMove = Lerp(FT * 15, self.FireMove, 0)
end

function SWEP:GetViewModelPosition(pos, ang)
	CT = UnPredictedCurTime()
	
	if self.InstantDissapearOnAim and self.dt.State == SWB_AIMING then
		self.ViewModelFOV = 90
		pos = pos - ang:Forward() * 100
		return pos, ang
	end
	
	if self.MoveWepAwayWhenAiming and CT > self.AimTime and self.dt.State == SWB_AIMING then
		self.ViewModelFOV = 90
		pos = pos - ang:Forward() * 100
		return pos, ang
	end
	
	self.ViewModelFOV = self.ViewModelFOV_Orig
	
	RotateAroundAxis(ang, Right(ang), CurAngMod.x + self.BlendAng.x + self.AngleDelta.p * mod2)
	
	if not self.ViewModelFlip then
		RotateAroundAxis(ang, Up(ang), CurAngMod.y + self.BlendAng.y + self.AngleDelta.y * 0.3 * mod2)
		RotateAroundAxis(ang, Forward(ang), CurAngMod.z + self.BlendAng.z + self.AngleDelta.y * 0.3 * mod2)
	else
		RotateAroundAxis(ang, Up(ang), CurAngMod.y + self.BlendAng.y - self.AngleDelta.y * 0.3 * mod2)
		RotateAroundAxis(ang, Forward(ang), CurAngMod.z - self.BlendAng.z - self.AngleDelta.y * 0.3 * mod2)
	end

	if not self.ViewModelFlip then
		pos = pos + (CurPosMod.x + self.BlendPos.x + self.AngleDelta.y * 0.1 * mod2) * Right(ang)
	else
		pos = pos + (CurPosMod.x + self.BlendPos.x - self.AngleDelta.y * 0.1 * mod2) * Right(ang)
	end
	
	pos = pos + (CurPosMod.y + self.BlendPos.y - self.FireMove) * Forward(ang)
	pos = pos + (CurPosMod.z + self.BlendPos.z - self.AngleDelta.p * 0.1) * Up(ang)
	
	return pos, ang
end

local wm, pos, ang

function SWEP:DrawWorldModel()
	if self.dt.Safe then
		if self.CHoldType != self.RunHoldType then
			self:SetHoldType(self.RunHoldType)
			self.CHoldType = self.RunHoldType
		end
	else
		if self.dt.State == SWB_RUNNING or self.dt.State == SWB_ACTION then
			if self.CHoldType != self.RunHoldType then
				self:SetHoldType(self.RunHoldType)
				self.CHoldType = self.RunHoldType
			end
		else
			if self.CHoldType != self.NormalHoldType then
				self:SetHoldType(self.NormalHoldType)
				self.CHoldType = self.NormalHoldType
			end
		end
	end
				
	if self.DrawTraditionalWorldModel then
		self:DrawModel()
	else
		wm = self.WMEnt
		
		if IsValid(wm) then
			if IsValid(self.Owner) then
				pos, ang = GetBonePosition(self.Owner, self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
				
				if pos and ang then
					RotateAroundAxis(ang, Right(ang), self.WMAng[1])
					RotateAroundAxis(ang, Up(ang), self.WMAng[2])
					RotateAroundAxis(ang, Forward(ang), self.WMAng[3])

					pos = pos + self.WMPos[1] * Right(ang) 
					pos = pos + self.WMPos[2] * Forward(ang)
					pos = pos + self.WMPos[3] * Up(ang)
					
					wm:SetRenderOrigin(pos)
					wm:SetRenderAngles(ang)
					wm:DrawModel()
				end
			else
				wm:SetRenderOrigin(self:GetPos())
				wm:SetRenderAngles(self:GetAngles())
				wm:DrawModel()
				wm:DrawShadow()
			end
		else
			self:DrawModel()
		end
	end
end