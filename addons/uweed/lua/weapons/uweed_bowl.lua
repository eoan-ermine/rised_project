-- "addons\\uweed\\lua\\weapons\\uweed_bowl.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.PrintName = "Bowl"
SWEP.Author = "Owain Owjo & Misfit"
SWEP.Category = "uWeed SWEPs"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true
SWEP.ViewModel = Model("models/base/weedbowlview.mdl")
SWEP.WorldModel = "models/base/weedbowl.mdl"
SWEP.ViewModelFOV = 85
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"

SWEP.Secondary.Ammo = "none"

SWEP.HoldType = ""

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	self.nextFlick = CurTime() + 30
	self.forceFlickCooldown = CurTime()
	self.smokeCooldown = CurTime()
end

function SWEP:PrimaryAttack()
	local ply = self.Owner
	if (ply:GetNWInt("uWeed_Gram_Counter") or 0) < 1 then return end
	self:SetNextPrimaryFire(CurTime()+8)
	self:SetNextSecondaryFire(CurTime()+8)
	if self.nextFlick < CurTime() + 8 then self.nextFlick = CurTime() + 30 end

	ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("pull"))
	timer.Simple(1.6, function()
		if !IsValid(self) then return end
		local vPoint = self:GetPos()
		local effectdata = EffectData()
		effectdata:SetOrigin( (self.Owner:GetViewModel():GetAttachment(1).Pos) )
		util.Effect( "MetalSpark", effectdata )
	end)
	timer.Simple(4, function()
		if !IsValid(self) then return end
		if self.Owner:GetActiveWeapon() != self then return end

		if SERVER then
			local counter = ply:GetNWInt("uWeed_Gram_Counter") or 0 
			ply:SetNWInt("uWeed_Gram_Counter", counter - 1)
		end
		if CLIENT then
			timer.Simple(1, function()
				if !IsValid(self) then return end
				for i=1, math.random(10,14) do
					timer.Simple(i/10, function()
						if !IsValid(self) then return end
						self:BlowSmoke()
					end)
				end
			end)

			hook.Add("RenderScreenspaceEffects", "uWeed_high", function()
				DrawBloom( 0.7, 4, 30, 30, 1, 1, 1, 1, 1 )
			end)
	
			if timer.Exists("uWeed_high") then
				timer.Remove("uWeed_high")
			end
		
			timer.Create("uWeed_high", UWeed.Config.HighTime, 1, function()
				hook.Remove("RenderScreenspaceEffects", "uWeed_high")
			end)
		end
		if (ply:GetNWInt("uWeed_Gram_Counter") or 0) <=0 then
			ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("putaway"))
			timer.Simple(3, function()
				if !IsValid(self) then return end
				self.Owner:StripWeapon(self:GetClass())
			end)
		else
			ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("smoking_back"))
			timer.Simple(3, function()
				if !IsValid(self) then return end
				if self.Owner:GetActiveWeapon() != self then return end
				ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("idle"))
			end)
		end
	end)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

if CLIENT then

	local emitter = ParticleEmitter(Vector(0,0,0))
	function SWEP:BlowSmoke()
		local ang = self.Owner:GetAngles()
		local pos = self.Owner:GetPos() + Vector(0, 0, 63) + (ang:Forward()*3)

		emitter:SetPos(pos)

		local particle = emitter:Add(string.format("particle/smokesprites_00%02d",math.random(1,16)), pos)
		if particle then
			particle:SetColor(255,255,255,255)
			particle:SetVelocity( ang:Forward()*15 )
			particle:SetGravity( ang:Up()*0.5 )
			particle:SetLifeTime(0)
			particle:SetDieTime(5)
			particle:SetStartSize(1)
			particle:SetEndSize(2)
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetCollide(true)
			particle:SetBounce(2)
			particle:SetRollDelta(0.01*math.Rand(-40,40))
			particle:SetAirResistance(50)
		end
	end

	function SWEP:DrawHUD()
		local weedCount = LocalPlayer():GetNWInt("uWeed_Gram_Counter") or 0
		draw.SimpleText(UWeed.Translation.Blunt.Text.." "..weedCount, "uweed_Gram_Font", ScrW()/2, ScrH(), Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	end
end
