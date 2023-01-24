-- "lua\\tfa\\modules\\tfa_envcheck.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local EmptyFunc = function() end

local debugInfoTbl = debug.getinfo(EmptyFunc)

local function checkEnv(plyIn)
	local printFunc = chat and chat.AddText or print

	if game.SinglePlayer() then
		if CLIENT then
			local found = false
			for _, wepDefTable in ipairs(weapons.GetList()) do
				if wepDefTable.Spawnable and weapons.IsBasedOn(wepDefTable.ClassName, "tfa_gun_base") then
					found = true

					break
				end
			end

			if not found then
				printFunc("[TFA Base] Thank you for installing our weapons base! It appears that you have installed only the base itself, which does not include any weapons by default. Please install some weapons/packs that utilize TFA Base for full experience!")
			end
		end

		local shortsrc = debugInfoTbl.short_src

		if shortsrc:StartWith("addons") then -- legacy/unpacked addon
			local addonRootFolder = shortsrc:GetPathFromFilename():Replace("lua/tfa/modules/", "")

			if not file.Exists(addonRootFolder .. ".git", "GAME") and not file.Exists(addonRootFolder .. "LICENSE", "GAME") then -- assume unpacked version by missing both .git and LICENSE files, which are ignored by gmad.exe
				printFunc("[TFA Base] You are using unpacked version of TFA Base.\nWe only provide support for Workshop and Git versions.")
			end
		end
	else
		local activeGamemode = engine.ActiveGamemode()
		local isRP = activeGamemode:find("rp")
				or activeGamemode:find("roleplay")
				or activeGamemode:find("serious")

		if isRP and (SERVER or (IsValid(plyIn) and (plyIn:IsAdmin() or plyIn:IsSuperAdmin()))) then
			print("[TFA Base] You are running the base on DarkRP or DarkRP-derived gamemode. We can't guarantee that it will work correctly with any possible addons the server might have installed (especially the paid ones), so we don't provide support for RP gamemodes/servers. If you've encountered a conflict error with another addon, it's most likely that addon's fault. DO NOT CONTACT US ABOUT THAT!")

			if TFA_BASE_VERSION <= 4.034 then -- seems to be common problem with SWRP servers
				printFunc("[TFA Base] You have installed both SV/SV2 and Reduxed versions of the base. Make sure you are using only one version at the same time.")
			end
		end
	end
end

if CLIENT then
	hook.Add("HUDPaint", "TFA_CheckEnv", function()
		local ply = LocalPlayer()

		if not IsValid(ply) then return end

		hook.Remove("HUDPaint", "TFA_CheckEnv")

		checkEnv(ply)
	end)
else
	hook.Add("InitPostEntity", "TFA_CheckEnv", checkEnv)
end
