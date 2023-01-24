-- "lua\\tfa\\external\\cl_ins2_sightanims.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TFA.INS2 = TFA.INS2 or {}

local function SightRenderOverride(wep, ent, idleseqname, zoomseqname)
	if not IsValid(wep) or not IsValid(ent) or not idleseqname or not zoomseqname then return end
	local idleseq, zoomseq = ent:LookupSequence(idleseqname), ent:LookupSequence(zoomseqname)
	if idleseq == -1 or zoomseq == -1 then return end

	local newseq = wep:IronSights() and zoomseq or idleseq

	if newseq ~= ent:GetSequence() then
		ent:ResetSequence(newseq)
	end

	ent:FrameAdvance()
end

local function AnimateSight(wep, noblacklist)
	local activeelem = wep:GetStatL("INS2_SightVElement")

	if activeelem and wep:GetStatL("ViewModelElements." .. activeelem) then
		if noblacklist then
			if wep.StatCache_Blacklist["ViewModelElements." .. activeelem .. ".active"] then
				return
			end
		else
			wep.StatCache_Blacklist["ViewModelElements." .. activeelem .. ".active"] = true
			wep.StatCache_Blacklist["ViewModelElements." .. activeelem .. ".curmodel"] = true -- JUST TO MAKE SURE IT FUCKING WORKS
		end

		local ent = wep:GetStatL("ViewModelElements." .. activeelem .. ".curmodel")
		local idleseqname = wep:GetStatL("ViewModelElements." .. activeelem .. ".ins2_sightanim_idle")
		local zoomseqname = wep:GetStatL("ViewModelElements." .. activeelem .. ".ins2_sightanim_iron")

		if ent and idleseqname and zoomseqname then -- isvalid check is in line 4 so dont worry
			SightRenderOverride(wep, ent, idleseqname, zoomseqname)
		end
	end
end

TFA.INS2.AnimateSight = AnimateSight

hook.Add("PostDrawViewModel", "TFA_INS2_AnimateSights", function(vm, ply, wep)
	if not IsValid(wep) or not wep.IsTFAWeapon then return end

	AnimateSight(wep, true)
end)

--[[
	To use these animations on your sight, you need to add "ins2_sightanim_idle" and "ins2_sightanim_iron" sequence names to your VElement and add its name to the "INS2_SightVElement" value in WeaponTable.
	
	Example WeaponTable:
	ATTACHMENT.WeaponTable = {
		["ViewModelElements"] = {
			["sight_eotech"] = {
				["active"] = true,
				["ins2_sightanim_idle"] = "idle", -- sight idle animation (unscoped)
				["ins2_sightanim_iron"] = "zoom", -- sight zoom animation - starts playing right when player aims down sights
			},
		},
		["INS2_SightVElement"] = "sight_eotech", -- the name of the VElement
	}
]]