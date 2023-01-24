-- "lua\\tfa\\modules\\tfa_keybinds.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TFA._KeyBindTable = TFA._KeyBindTable or {}
local KeyBindTable = TFA._KeyBindTable

local cv_prefix = "cl_tfa_keys_"

local sp = game.SinglePlayer()

if sp then -- THANK YOU GARRY FOR HIGH QUALITY PREDICTION IN SINGLEPLAYER
	if SERVER then
		util.AddNetworkString("TFA_KB_State")
		util.AddNetworkString("TFA_KB_Think")
	end

	if CLIENT then
		net.Receive("TFA_KB_State", function()
			local ply = LocalPlayer()

			local bind = net.ReadString()
			local state = net.ReadBool()

			local data = KeyBindTable[bind]

			if data and data.state ~= state then
				data.state = state

				if state then
					data.onpress(ply)
				else
					data.onrelease(ply)
				end
			end
		end)

		net.Receive("TFA_KB_Think", function()
			local ply = LocalPlayer()

			local bind = net.ReadString()

			local data = KeyBindTable[bind]

			if data and data.think and data.state then
				data.think(ply)
			end
		end)
	end
end

local function empty()
end

function TFA.RegisterKeyBind(data_in)
	assert(type(data_in) == "table", "Data must be a table!")
	assert(data_in.bind and type(data_in.bind) == "string", "Invalid bind name!")
	-- assert(not TFA._KeyBindTable[data.bind], "Keybind already registered!")

	local data = table.Copy(data_in)

	if not data.onpress then
		data.onpress = empty
	elseif type(data.onpress) ~= "function" then
		error("data.onpress - function expected, got " .. type(data.onpress))
	end

	if not data.onrelease then
		data.onrelease = empty
	elseif type(data.onrelease) ~= "function" then
		error("data.onrelease - function expected, got " .. type(data.onrelease))
	end

	data.state = false

	if CLIENT and GetConVar(cv_prefix .. data.bind) == nil then
		CreateClientConVar(cv_prefix .. data.bind, 0, true, true, data.desc)
	end

	hook.Add("PlayerButtonDown", "TFA_KB_KeyDown_" .. data.bind, function(ply, button)
		if not IsFirstTimePredicted() then return end
		local cv_key = ply:GetInfoNum(cv_prefix .. data.bind, 0)

		if cv_key > 0 and cv_key == button and not data.state then
			data.state = true
			data.onpress(ply)

			if sp and SERVER then
				net.Start("TFA_KB_State", true)
				net.WriteString(data.bind)
				net.WriteBool(data.state)
				net.Send(ply)
			end
		end
	end)

	hook.Add("PlayerButtonUp", "TFA_KB_KeyUp_" .. data.bind, function(ply, button)
		if not IsFirstTimePredicted() then return end
		local cv_key = ply:GetInfoNum(cv_prefix .. data.bind, 0)

		if cv_key > 0 and cv_key == button and data.state then
			data.state = false
			data.onrelease(ply)

			if sp and SERVER then
				net.Start("TFA_KB_State", true)
				net.WriteString(data.bind)
				net.WriteBool(data.state)
				net.Send(ply)
			end
		end
	end)

	hook.Remove("PlayerPostThink", "TFA_KB_Think_" .. data.bind)

	if data.think and type(data.think) == "function" then
		hook.Add("PlayerPostThink", "TFA_KB_Think_" .. data.bind, function(ply)
			if data.state then
				data.think(ply)

				if sp and SERVER then
					net.Start("TFA_KB_Think", true)
					net.WriteString(data.bind)
					net.Send(ply)
				end
			end
		end)
	end

	KeyBindTable[data.bind] = data
end

if CLIENT then -- Populate spawnmenu settings with registered keybinds
	local function tfaOptionKeys(panel)
		panel:Help("#tfa.keybinds.help.bind")
		panel:Help("#tfa.keybinds.help.bound")
		panel:Help("#tfa.keybinds.help.unbind")
		panel:Help("")

		for _, data in pairs(KeyBindTable) do
			local cv = GetConVar(cv_prefix .. data.bind)

			if cv then
				panel:Help("#tfa.keybind." .. data.bind)

				local binder = vgui.Create("DBinder")

				binder:SetValue(cv:GetInt())

				function binder:OnChange(newcode)
					cv:SetInt(newcode)
				end

				panel:AddItem(binder)
				panel:Help("")
			end
		end
	end

	hook.Add("PopulateToolMenu", "TFA_AddKeyBinds", function()
		spawnmenu.AddToolMenuOption("Utilities", "TFA SWEP Base Settings", "TFASwepBaseKeybinds", "#tfa.smsettings.keybinds", "", "", tfaOptionKeys)
	end)
end

-- Default keybinds
TFA.RegisterKeyBind({
	bind = "bash",

	onpress = function(plyv)
		if not plyv:IsValid() then return end

		plyv.tfa_bash_hack = true
	end,

	onrelease = function(plyv)
		if not plyv:IsValid() then return end

		plyv.tfa_bash_hack = false
	end
})

TFA.RegisterKeyBind({
	bind = "customize",
	onpress = CLIENT and function(plyv)
		if not plyv:IsValid() then return end

		RunConsoleCommand("impulse", TFA.INSPECTION_IMPULSE_STRING)
	end
})

TFA.RegisterKeyBind({
	bind = "inspect",
	onpress = function(plyv)
		local wepv = plyv:GetActiveWeapon()

		if (IsValid(wepv) and wepv.GetStat) and (wepv:GetActivityEnabled(ACT_VM_FIDGET) or wepv.InspectionActions) and wepv:GetStatus() == TFA.Enum.STATUS_IDLE then
			local _, tanim = wepv:ChooseInspectAnim()
			wepv:ScheduleStatus(TFA.Enum.STATUS_FIDGET, wepv:GetActivityLength(tanim))
		end
	end
})

TFA.RegisterKeyBind({
	bind = "firemode",
	onpress = CLIENT and function(plyv)
		local wepv = plyv:GetActiveWeapon()

		if IsValid(wepv) and wepv.GetStat then
			if wepv:GetStatL("SelectiveFire") and not wepv:GetOwner():KeyDown(IN_SPEED) then
				RunConsoleCommand("impulse", TFA.CYCLE_FIREMODE_IMPULSE_STRING)
			elseif wepv:GetOwner():KeyDown(IN_SPEED) then
				RunConsoleCommand("impulse", TFA.CYCLE_SAFETY_IMPULSE_STRING)
			end
		end
	end
})

TFA.RegisterKeyBind({
	bind = "silencer",
	onpress = function(plyv)
		local wepv = plyv:GetActiveWeapon()

		if (IsValid(wepv) and wepv.GetStat) and wepv:GetStatRawL("CanBeSilenced") and TFA.Enum.ReadyStatus[wepv:GetStatus()] then
			local _, tanim = wepv:ChooseSilenceAnim(not wepv:GetSilenced())
			wepv:ScheduleStatus(TFA.Enum.STATUS_SILENCER_TOGGLE, wepv:GetActivityLength(tanim, true))
		end
	end
})

-- EXAMPLE KEYBIND:
--[[
	TFA.RegisterKeyBind({
		bind = "whatever", -- bind id, cvar is cl_tfa_keys_whatever
		onpress = function(ply) end, -- function called on key press
		onrelease = function(ply) end, -- function called on key release
		think = function(ply) end, -- called from PlayerPostThink when key is held down
	})
]]
