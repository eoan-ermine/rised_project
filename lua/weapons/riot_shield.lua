-- "lua\\weapons\\riot_shield.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile();

SWEP.DrawWeaponInfoBox		= false

SWEP.PrintName 				= "Riot shield"
SWEP.Slot 					= 1
SWEP.SlotPos 				= 4

SWEP.Spawnable = true

SWEP.WorldModel = ""

SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip 	= -1
SWEP.Primary.Ammo			= ""
SWEP.Primary.Automatic		= false

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip 	= -1
SWEP.Secondary.Ammo			= ""
SWEP.Secondary.Automatic	= false

SWEP.Skin = 0

local function ToRGB(vec)
	local r = math.Remap(vec.x, 0, 1, 0, 255)
	local g = math.Remap(vec.y, 0, 1, 0, 255)
	local b = math.Remap(vec.z, 0, 1, 0, 255)

	return Color(r, g, b)
end

function SWEP:CanPrimaryAttack()
	return false
end

function SWEP:CanSecondaryAttack()
	return false
end

function SWEP:PreDrawViewModel()
	return true
end

function SWEP:Deploy()
	if SERVER then
		if(!self.ShieldColor) then
			self.ShieldColor = ToRGB(self.Owner:GetWeaponColor())
		end

		local Ent = ents.Create("prop_physics")
		Ent:SetModel("models/pg_props/pg_weapons/pg_cp_shield_w.mdl")
		Ent:SetOwner(self.Owner)
		Ent:Spawn()

		Ent:SetColor(self.ShieldColor)
		Ent:SetSkin(self.Skin)

		local Phys = Ent:GetPhysicsObject()
		Phys:AddGameFlag(FVPHYSICS_NO_PLAYER_PICKUP)
		Phys:EnableMotion(false)

		self.Shield = Ent
	end
	self:SetHoldType("normal")
end

function SWEP:Reload()
	if(game.SinglePlayer()) then
		self:CallOnClient("Reload")
	end

	if(CLIENT and !IsValid(self.Frame)) then
		local PlyCol = ToRGB(self.Owner:GetPlayerColor())
		local WepCol = ToRGB(self.Owner:GetWeaponColor())

		PrintTable(WepCol)
		PrintTable(PlyCol)

		local Frame = vgui.Create("DFrame")
		Frame:SetSize(270, 221)
		Frame:Center()
		Frame:MakePopup()

		self.Frame = Frame

		local Mixer = vgui.Create("DColorMixer", Frame)
		Mixer:SetSize(270, 165)
		Mixer:Dock(TOP)

		local PlayCol = vgui.Create("DButton", Frame)
		PlayCol:SetPos(5, 200)
		PlayCol:SetSize(86, 16)
		PlayCol:SetText("Player Color")
		function PlayCol:DoClick()
			Mixer:SetColor(PlyCol)
		end

		local Skin = vgui.Create("DButton", Frame)
		Skin:SetPos(92, 200)
		Skin:SetSize(86, 16)
		Skin:SetText("Swap Skin")
		Skin.Target = self
		function Skin:DoClick()
			net.Start("cn_riot_skin")
				net.WriteEntity(self.Target)
			net.SendToServer()
		end

		local Apply = vgui.Create("DButton", Frame)
		Apply:SetPos(179, 200)
		Apply:SetSize(86, 16)
		Apply:SetText("Apply Changes")
		Apply.Target = self
		function Apply:DoClick()
			net.Start("cn_riot_color")
				net.WriteEntity(self.Target)
				net.WriteTable(Mixer:GetColor())
			net.SendToServer()
		end
	end
end

if(SERVER) then
	util.AddNetworkString("cn_riot_color")
	util.AddNetworkString("cn_riot_skin")

	net.Receive("cn_riot_color", function()
		local ent = net.ReadEntity()
		local tbl = net.ReadTable()

		local col = Color(tbl.r, tbl.g, tbl.b, tbl.a)

		ent.ShieldColor = col

		if(IsValid(ent.Shield)) then
			ent.Shield:SetColor(col)
		end
	end)

	net.Receive("cn_riot_skin", function()
		local ent = net.ReadEntity()

		if(ent.Skin == 0) then
			ent.Skin = 1
		else
			ent.Skin = 0
		end

		if(IsValid(ent.Shield)) then
			ent.Shield:SetSkin(ent.Skin)
		end
	end)

	function SWEP:Holster()
		if(self.Shield and self.Shield:IsValid()) then
				self.Shield:Remove()
				return true
		end
	end

	function SWEP:Think()
		if(self.Shield and self.Shield:IsValid()) then
			local Offset = Vector(3,-4,0)
			if(self.Owner:Crouching()) then
				Offset.z = Offset.z - 20
				Offset.x = Offset.x + 5
			end
			local Pos, Ang = LocalToWorld(Offset,Angle(5,0,0),self.Owner:GetPos(),Angle(0,self.Owner:GetAngles().y,0))
			self.Shield:SetAngles(Ang)
			self.Shield:SetPos(Pos)
		end
	end
end