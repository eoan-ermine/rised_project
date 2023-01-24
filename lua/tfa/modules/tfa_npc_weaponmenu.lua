-- "lua\\tfa\\modules\\tfa_npc_weaponmenu.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- AI Options
if CLIENT then
	hook.Add("PopulateMenuBar", "NPCOptions_MenuBar_TFA", function(menubarV)
		local m = menubarV:AddOrGetMenu("#menubar.npcs")
		local wpns = m:AddSubMenu("#tfa.menubar.npcs.weapon")
		wpns:SetDeleteSelf(false)

		wpns:AddCVar("#menubar.npcs.defaultweapon", "gmod_npcweapon", "")
		wpns:AddCVar("#menubar.npcs.noweapon", "gmod_npcweapon", "none")
		wpns:AddSpacer()

		local weaponCats = {}

		for _, wep in pairs(weapons.GetList()) do
			if wep and wep.Spawnable and weapons.IsBasedOn(wep.ClassName, "tfa_gun_base") then
				local cat = wep.Category or "Other"
				weaponCats[cat] = weaponCats[cat] or {}

				table.insert(weaponCats[cat], {
					["class"] = wep.ClassName,
					["title"] = wep.PrintName or wep.ClassName
				})
			end
		end

		local catKeys = table.GetKeys(weaponCats)
		table.sort(catKeys, function(a, b) return a < b end)

		for _, k in ipairs(catKeys) do
			local v = weaponCats[k]
			local wpnSub = wpns:AddSubMenu(k)
			wpnSub:SetDeleteSelf(false)
			table.SortByMember(v, "title", true)

			for _, b in ipairs(v) do
				wpnSub:AddCVar(b.title, "gmod_npcweapon", b.class)
			end
		end
	end)
else
	local npcWepList = list.GetForEdit("NPCUsableWeapons")

	hook.Add("PlayerSpawnNPC", "TFACheckNPCWeapon", function(plyv, npcclassv, wepclassv)
		if type(wepclassv) ~= "string" or wepclassv == "" then return end

		if not npcWepList[wepclassv] then -- do not copy the table
			local wep = weapons.GetStored(wepclassv)

			if wep and (wep.Spawnable and not wep.AdminOnly) and weapons.IsBasedOn(wep.ClassName, "tfa_gun_base") then
				npcWepList[wepclassv] = {
					["class"] = wep.ClassName,
					["title"] = wep.PrintName or wep.ClassName
				}
			end
		end
	end)
end
