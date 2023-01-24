-- "addons\\rised_combine_entities\\lua\\entities\\combine_ammo_box\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Base = "base_gmodentity";
ENT.Type = "anim";

ENT.PrintName		= "Ящик с патронами";
ENT.Category 		= "A - Rised - [Альянс]";
ENT.Author			= "D-Rised";

ENT.Contact    		= "";
ENT.Purpose 		= "";
ENT.Instructions 	= "" ;

ENT.Spawnable			= true;
ENT.AdminSpawnable		= true;

local combine_weapons_ammo = {
    ["swb_pistol"] = 60,
    ["swb_smg"] = 186,
    ["swb_mp5a5"] = 120,
    ["swb_shotgun"] = 40,
    ["swb_hammer"] = 40,
    ["swb_ismg"] = 155,
    ["swb_irifle"] = 170,
    ["swb_357"] = 36,
    ["weapon_csniper"] = 48,
    ["swb_lmg"] = 500,
    ["swb_snipercombine_assault"] = 74,
    ["swb_snipercombine_heavy"] = 52,
    ["swb_slk789"] = 38,
    ["swb_mp5k"] = 150,
    ["swb_oicw"] = 214,
}

function ENT:Use(ply)
	if self.useblock then return end

	if self:GetNWInt("Entity_Cooldown") < CurTime() then
		local activeWeapon = ply:GetActiveWeapon()
		local maxAmmoForWeapon = combine_weapons_ammo[activeWeapon:GetClass()]
		if (ply:isCP() || ply:Team() == TEAM_REBELSPY01) and maxAmmoForWeapon then
			if ply:GetAmmoCount(activeWeapon:GetPrimaryAmmoType()) < maxAmmoForWeapon then
				self:SetBodygroup(1, 1)
				self:AmmoBoxAnimate(ply)
				timer.Simple(0.7, function()
					ply:SetAmmo(maxAmmoForWeapon, activeWeapon:GetPrimaryAmmoType(), false)
				end)
				self:SetNWInt("Entity_Cooldown", CurTime() + 15)
				DarkRP.notify(ply,1,1,"Вы подобрали патроны")
			else
				DarkRP.notify(ply,1,1,"Вы достигли лимита патронов на данное оружие")
			end
		end
	else
		DarkRP.notify(ply,1,1,"Время до следующей выдачи патронов: " .. math.Round(self:GetNWInt("Entity_Cooldown") - CurTime()))
	end
	self.useblock = true
	timer.Simple(1, function() self.useblock = false end)
end

function ENT:AmmoBoxAnimate(ply)
	self:EmitSound("items/ammocrate_open.wav")
	self:ResetSequence(self:LookupSequence("close"))
	timer.Simple(0.7, function()
		ply:EmitSound("items/ammo_pickup.wav")
		if IsValid(self) then
			self:SetBodygroup(1, 0)
		end
	end)
	timer.Simple(1.4, function()
		if IsValid(self) then
			self:EmitSound("items/ammocrate_close.wav")
			self:ResetSequence(self:LookupSequence("open"))
		end
	end)
end