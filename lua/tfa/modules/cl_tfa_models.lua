-- "lua\\tfa\\modules\\cl_tfa_models.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TFA.ClientsideModels = TFA.ClientsideModels or {}

timer.Create("TFA_UpdateClientsideModels", 0.1, 0, function()
	local i = 1

	while i <= #TFA.ClientsideModels do
		local t = TFA.ClientsideModels[i]

		if not t then
			table.remove(TFA.ClientsideModels, i)
		elseif not IsValid(t.wep) then
			t.mdl:Remove()
			table.remove(TFA.ClientsideModels, i)
		elseif IsValid(t.wep:GetOwner()) and t.wep:GetOwner().GetActiveWeapon and t.wep ~= t.wep:GetOwner():GetActiveWeapon() then
			t.mdl:Remove()
			table.remove(TFA.ClientsideModels, i)
		elseif t.wep.IsHidden and t.wep:IsHidden() then
			t.mdl:Remove()
			table.remove(TFA.ClientsideModels, i)
		else
			i = i + 1
		end
	end

	if #TFA.ClientsideModels == 0 then
		timer.Stop("TFA_UpdateClientsideModels")
	end
end)

if #TFA.ClientsideModels == 0 then
	timer.Stop("TFA_UpdateClientsideModels")
end

function TFA.RegisterClientsideModel(cmdl, wepv) -- DEPRECATED
	-- don't use please
	-- pleaz
	TFA.ClientsideModels[#TFA.ClientsideModels + 1] = {
		["mdl"] = cmdl,
		["wep"] = wepv
	}

	timer.Start("TFA_UpdateClientsideModels")
end

local function NotifyShouldTransmit(ent, notdormant)
	if notdormant or not ent.IsTFAWeapon then return end
	if ent:GetOwner() == LocalPlayer() then return end

	ent:CleanModels(ent:GetStatRaw("ViewModelElements", TFA.LatestDataVersion))
	ent:CleanModels(ent:GetStatRaw("WorldModelElements", TFA.LatestDataVersion))
end

local function EntityRemoved(ent)
	if not ent.IsTFAWeapon then return end

	ent:CleanModels(ent:GetStatRaw("ViewModelElements", TFA.LatestDataVersion))
	ent:CleanModels(ent:GetStatRaw("WorldModelElements", TFA.LatestDataVersion))
end

hook.Add("NotifyShouldTransmit", "TFA_ClientsideModels", NotifyShouldTransmit)
hook.Add("EntityRemoved", "TFA_ClientsideModels", EntityRemoved)
