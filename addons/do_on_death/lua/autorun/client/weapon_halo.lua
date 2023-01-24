-- "addons\\do_on_death\\lua\\autorun\\client\\weapon_halo.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--
-- GM:PreDrawHalos()
--
-- Called before rendering the halos. This is the place to call halo.Add.
--
-- http://wiki.garrysmod.com/page/GM/PreDrawHalos
--
hook.Add("PreDrawHalos", "DOD_PickupWeapons_DrawHalo_cl", function()

	if !GetConVar("dod_weapon_halo_enable"):GetBool() then return end

	local color = Color(255, 255, 255)
	local ent = LocalPlayer():GetEyeTrace().Entity

	if ent:IsValid() and LocalPlayer():Alive() then

		local distance = LocalPlayer():GetPos():Distance(ent:GetPos())

		if ent:IsWeapon() and distance <= 50 then

			local ents = {}
			table.insert(ents, ent)
			halo.Add(ents, color, 0.5, 0.5, 2, true, true)

		end

	end

end)
