-- "lua\\tfa\\external\\cl_ins2_pmhands.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TFA.INS2 = TFA.INS2 or {}

local rigmdl = "models/weapons/tfa_ins2/c_ins2_pmhands.mdl"

local function CleanINS2ProxyHands()
	local HandsEnt = TFA.INS2.HandsEnt

	if IsValid(HandsEnt) then
		HandsEnt:RemoveEffects(EF_BONEMERGE)
		HandsEnt:RemoveEffects(EF_BONEMERGE_FASTCULL)
		HandsEnt:SetParent(NULL)

		HandsEnt:Remove()
	end
end

local function tryParentHands(Hands, ViewModel, Player, Weapon) -- hey look no more drawmodel
	if not IsValid(ViewModel) or not IsValid(Weapon) or not Weapon.IsTFAWeapon then
		CleanINS2ProxyHands()

		return
	end

	if not IsValid(Hands) then return end -- Hi Gmod Can Hands ????

	if ViewModel:LookupBone("R ForeTwist") and not ViewModel:LookupBone("ValveBiped.Bip01_R_Hand") then -- assuming we are ins2 only skeleton
		local HandsEnt = TFA.INS2.HandsEnt

		if not IsValid(HandsEnt) then
			TFA.INS2.HandsEnt = ClientsideModel(rigmdl)
			TFA.INS2.HandsEnt:SetNoDraw(true)

			HandsEnt = TFA.INS2.HandsEnt
		end

		HandsEnt:SetParent(ViewModel)
		HandsEnt:SetPos(ViewModel:GetPos())
		HandsEnt:SetAngles(ViewModel:GetAngles())

		if not HandsEnt:IsEffectActive(EF_BONEMERGE) then
			HandsEnt:AddEffects(EF_BONEMERGE)
			HandsEnt:AddEffects(EF_BONEMERGE_FASTCULL)
		end

		Hands:SetParent(HandsEnt)
	else
		CleanINS2ProxyHands()
	end
end

hook.Add("PreDrawPlayerHands", "TFA_INS2_HandsWhatTheFuck", tryParentHands)

hook.Add("VManipVMEntity", "TFA_INS2_VManipCompat", function(ply, wep)
	local HandsEnt = TFA.INS2.HandsEnt

	if IsValid(HandsEnt) then
		return HandsEnt
	end
end)