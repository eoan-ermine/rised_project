-- "addons\\uweed\\lua\\weapons\\uweed_joint.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.PrintName = "Косяк"
SWEP.Author = "Owain Owjo & Misfit"
SWEP.Category = "uWeed SWEPs"

SWEP.Slot = 0
SWEP.SlotPos = 4

SWEP.Spawnable = true
SWEP.ViewModel = Model("models/base/bluntview.mdl")
SWEP.WorldModel = "models/base/bluntroll4.mdl"
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
SWEP.Weight = 0.05

SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"

SWEP.Secondary.Ammo = "none"

SWEP.HoldType = ""

SWEP.WepSelectFont		= "HL2MPTypeDeath"
SWEP.WepSelectLetter	= "K"

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )

	surface.SetDrawColor( color_transparent )
	surface.SetTextColor( 75, 75, 75, alpha )
	surface.SetFont( self.WepSelectFont )
	local w, h = surface.GetTextSize( self.WepSelectLetter )

	surface.SetTextPos( x + ( wide / 2 ) - ( w / 2 ),
						y + ( tall / 2 ) - ( h / 2 ) )
	surface.DrawText( self.WepSelectLetter )
end

function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
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

	ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("smoking_in"))
	timer.Simple(3, function()
		if !IsValid(self) then return end
		if self.Owner:GetActiveWeapon() != self then return end
		self.smokeCooldown = CurTime() + 3
	end)
	timer.Simple(5, function()
		if !IsValid(self) then return end
		if self.Owner:GetActiveWeapon() != self then return end

		if SERVER then
			local counter = ply:GetNWInt("uWeed_Gram_Counter") or 0 
			if ply:Health() <= 150 then
				ply:SetNWInt("uWeed_Gram_Counter", counter - 1)
				ply:SetHealth(ply:Health() + 5)
				hook.Call("playerMoodChanged", GAMEMODE, ply, 50)
			else
				timer.Create("Overdose", 5, 10, function() ply:SetHealth(ply:Health() - math.random(1,5)) util.ScreenShake( Vector( 0, 0, 0 ), 5, 50, 5, 4000 ) end)
			end
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
			timer.Simple(1.9, function()
				if !IsValid(self) then return end
				for i=1, 5 do
					self:Ash()
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
			ply:GetViewModel():SendViewModelMatchingSequence(ply:GetViewModel():LookupSequence("toss"))
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

function SWEP:Think()
	if self.nextFlick < CurTime() then
		self.nextFlick = CurTime() + 30
		self:FlickAsh()
	end
end

function SWEP:FlickAsh()
	self:SetNextPrimaryFire(CurTime()+5)
	self:SetNextSecondaryFire(CurTime()+5)
	self.Owner:GetViewModel():SendViewModelMatchingSequence(self.Owner:GetViewModel():LookupSequence("smoking_ash"))
	if CLIENT then
		timer.Simple(0.5, function()
			if !IsValid(self) then return end
			for i=1, 5 do
				self:Ash()
			end
		end)
	end
	timer.Simple(4, function()
		if !IsValid(self) then return end
		self.Owner:GetViewModel():SendViewModelMatchingSequence(self.Owner:GetViewModel():LookupSequence("idle"))
	end)
end

function SWEP:SecondaryAttack()
	if self.forceFlickCooldown > CurTime() then return end

	self.forceFlickCooldown = CurTime() + 5
	self.nextFlick = CurTime() + 30

	self:FlickAsh()
end

function SWEP:Reload()
end

if CLIENT then

	local emitter = ParticleEmitter(Vector(0,0,0))
	local function newSmoke(position, angle)
		local pos = position
		local ang = angle
		emitter:SetPos(pos)

		local particle = emitter:Add(string.format("particle/smokesprites_00%02d",math.random(1,16)), pos-(ang:Forward()*0.4)+(ang:Right()*-0.2))
		if particle then
			particle:SetColor(200,200,200,200)
			particle:SetVelocity(ang:Forward()*1.5)
			particle:SetGravity( Vector(0,0,15) )
			particle:SetLifeTime(0)
			particle:SetDieTime(1.5)
			particle:SetStartSize(0.75)
			particle:SetEndSize(1)
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetCollide(true)
			particle:SetBounce(2)
			particle:SetRoll(math.Rand(0,360))
			particle:SetRollDelta(0.01*math.Rand(-40,40))
			particle:SetAirResistance(50)
		end
	end

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

	local ashMaterial = Material("uweed/ash.png")
	function SWEP:Ash()
		mdl = self.Owner:GetViewModel()
		local pos = mdl:GetAttachment(1).Pos
		local ang = mdl:GetAttachment(1).Ang
		emitter:SetPos(pos)

		local particle = emitter:Add( ashMaterial, pos-(ang:Forward()*0.4)+(ang:Right()*-0.2) )
		if particle then
			particle:SetColor(255,255,255,255)
			particle:SetVelocity(ang:Forward()*(math.random(-1, 1)))
			particle:SetGravity( Vector(0,0,math.random(-10, -20)) )
			particle:SetLifeTime(0)
			particle:SetDieTime(1.5)
			particle:SetStartSize(1)
			particle:SetEndSize(1)
			particle:SetStartAlpha(200)
			particle:SetEndAlpha(0)
			particle:SetCollide(true)
			particle:SetBounce(2)
			particle:SetRollDelta(0.01*math.Rand(-40,40))
			particle:SetAirResistance(50)
		end
	end

	function SWEP:PostDrawViewModel(mdl)
		if self.smokeCooldown+math.random(0.05, 0.07) > CurTime() then return end
		self.smokeCooldown = CurTime()
		local pos = mdl:GetAttachment(1).Pos
		local ang = mdl:GetAttachment(1).Ang
		newSmoke(pos, ang)
	end

	function SWEP:DrawHUD()
		local weedCount = LocalPlayer():GetNWInt("uWeed_Gram_Counter") or 0
		draw.SimpleText(UWeed.Translation.Blunt.Text.." "..weedCount, "uweed_Gram_Font", ScrW()/2, ScrH()/1.1, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
	end

	hook.Add("PostPlayerDraw", "uWeed_3rdPerson_Joint", function(ply)
		-- Some basic checks
		if ply == LocalPlayer() then return end
		if !IsValid(ply) then if ply.uWeed_Joint then ply.uWeed_Joint:Remove() ply.uWeed_Joint = nil end return end
		if !ply:Alive()  then if ply.uWeed_Joint then ply.uWeed_Joint:Remove() ply.uWeed_Joint = nil end return end
		if !ply:GetActiveWeapon() then if ply.uWeed_Joint then ply.uWeed_Joint:Remove() ply.uWeed_Joint = nil end return end
		if ply:GetActiveWeapon() == NULL then if ply.uWeed_Joint then ply.uWeed_Joint:Remove() ply.uWeed_Joint = nil end return end
		if ply:GetActiveWeapon():GetClass() != "uweed_joint" then if ply.uWeed_Joint then ply.uWeed_Joint:Remove() ply.uWeed_Joint = nil end return end
		if LocalPlayer():GetPos():Distance( ply:GetPos() ) > 750 then if ply.uWeed_Joint then ply.uWeed_Joint:Remove() ply.uWeed_Joint = nil end return end

		if !ply.uWeed_Joint then
			ply.uWeed_Joint = ClientsideModel("models/base/bluntmodel.mdl")
			ply.uWeed_Joint:SetBodygroup(4, 1)
			ply.uWeed_Joint:SetBodygroup(3, 1)
			ply.uWeed_Joint:SetBodygroup(2, 1)
		end

    	local ang = ply:GetAngles()
    	local pos

    	if ply:LookupBone("ValveBiped.Bip01_Head1") then
    		b_pos, b_ang = ply:GetBonePosition(ply:LookupBone("ValveBiped.Bip01_Head1"))
    		pos = b_pos + (b_ang:Right()*4) + (b_ang:Forward()) + (b_ang:Up()*-0.3)
    		ang = b_ang
    		ang:RotateAroundAxis( ang:Up(), 90 )
    	else 
    		pos = ply:GetPos() + Vector(0,0,70)
    	end
    	ply.uWeed_Joint:SetPos(pos)
    	ply.uWeed_Joint:SetAngles(ang)

    	ply.uWeed_Smoke_Cooldown = ply.uWeed_Smoke_Cooldown or CurTime()

    	if ply.uWeed_Smoke_Cooldown+math.random(0.05, 0.07) > CurTime() then return end
		ply.uWeed_Smoke_Cooldown = CurTime()
		newSmoke(pos+(b_ang:Forward()*-5), ang)
	end)

end
