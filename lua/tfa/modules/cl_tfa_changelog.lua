-- "lua\\tfa\\modules\\cl_tfa_changelog.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local changes = TFA_BASE_VERSION_CHANGES or ""
local cvar_changelog = GetConVar("sv_tfa_changelog")

local sp = game.SinglePlayer()
local pdatavar = "tfa_base_version_" .. util.CRC(game.GetIPAddress())

local function CheckAndDisplayChangeLog(ply)
	if not IsValid(ply) then return end

	if not cvar_changelog:GetBool() then return end

	if not sp or not ply:IsAdmin() then return end

	local version = tonumber(ply:GetPData(pdatavar))

	if not version or version < TFA_BASE_VERSION then
		chat.AddText("Updated to TFA Base Version: " .. TFA_BASE_VERSION_STRING)

		if changes ~= "" then
			chat.AddText(changes)
		end
	end

	ply:SetPData(pdatavar, TFA_BASE_VERSION)
end

hook.Add("HUDPaint", "TFA_DISPLAY_CHANGELOG", function()
	if not LocalPlayer():IsValid() then return end

	CheckAndDisplayChangeLog(LocalPlayer())

	hook.Remove("HUDPaint", "TFA_DISPLAY_CHANGELOG")
end)
