-- "addons\\do_on_death\\lua\\autorun\\client\\setting.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--
-- Client cvars
--
CreateClientConVar("dod_player_gender", 0, true, true)
CreateClientConVar("dod_weapon_halo_enable", 1, true, true)
CreateClientConVar("dod_red_screen_on_death_enable", 0, true, true)

--
-- Language
--
local available_languages = { "en", "fr" }
local lang = GetConVar("gmod_language"):GetString()

if !table.contains(available_languages, lang) then lang = "en" end -- English is set by default.

--
-- GM:PopulateToolMenu()
--
-- Add the STOOLS to the tool menu. You want to call spawnmenu.AddToolMenuOption in this hook.
--
-- http://wiki.garrysmod.com/page/GM/PopulateToolMenu
--
hook.Add("PopulateToolMenu", "DOD_DeathSounds_PopulateToolMenu_cl", function()

    --
    -- spawnmenu.AddToolMenuOption( string tab, string category, string class, string name, string cmd, string config, function cpanel, table )
    --
    -- Adds an option to the right side of the spawnmenu
    --
    -- http://wiki.garrysmod.com/page/spawnmenu/AddToolMenuOption
    --

    spawnmenu.AddToolMenuOption("Options", "Do on Death", "DOD_DeathSounds_Settings", "#dod." .. lang .. ".settings", nil, nil, function(panel)

		panel:AddControl("Header", {
			Description = "#dod." .. lang .. ".death_sounds_settings"
		})

		if LocalPlayer():IsAdmin() then

			panel:AddControl("CheckBox", {
	            Label = "#dod." .. lang .. ".enable_death_sounds",
	            Command = "dod_death_sounds_enable",
	        })

	        panel:AddControl("CheckBox", {
	            Label = "#dod." .. lang .. ".enable_beep_sounds",
	            Command = "dod_beep_death_sound_enable",
	        })

		end

		panel:AddControl("ComboBox", {
            Label = "#dod." .. lang .. ".character_gender",
            Options = {
                ["#dod." .. lang .. ".character_gender.autodetection"] = { dod_player_gender = 0 },
                ["#dod." .. lang .. ".character_gender.male"]	       = { dod_player_gender = 1 },
                ["#dod." .. lang .. ".character_gender.female"]		   = { dod_player_gender = 2 },
                ["#dod." .. lang .. ".character_gender.zombie"]		   = { dod_player_gender = 3 }
            }
        })

		panel:AddControl("Label", {
			Text = ""
		})

		panel:AddControl("Label", {
			Text = "#dod." .. lang .. ".weapon_settings"
		})

		if LocalPlayer():IsAdmin() then

			panel:AddControl("CheckBox", {
	            Label = "#dod." .. lang .. ".enable_drop_weapons",
	            Command = "dod_drop_on_death_enable",
	        })

	        panel:AddControl("CheckBox",
	        {
	            Label = "#dod." .. lang .. ".allow_pickup_dropped_weapons",
	            Command = "dod_pickup_dropped_weapons_enable",
	        })

		end

		panel:AddControl("CheckBox",
        {
            Label = "#dod." .. lang .. ".weapon_halo_enable",
            Command = "dod_weapon_halo_enable",
        })

		if LocalPlayer():IsAdmin() then

	        panel:AddControl("ComboBox", {
	            Label = "#dod." .. lang .. ".drop_weapons_mode",
	            Options = {
	                ["#dod." .. lang .. ".drop_weapons_mode.drop_all"]        = { dod_drop_on_death_mode = 0 },
	                ["#dod." .. lang .. ".drop_weapons_mode.drop_current"]    = { dod_drop_on_death_mode = 1 }
	            }
	        })

	        panel:AddControl("ComboBox", {
	    		Label = "#dod." .. lang .. ".pickup_mode",
	    		Options = {
	    			["#dod." .. lang .. ".pickup_mode.use"]  = { dod_pickup_mode = 0 },
	    			["#dod." .. lang .. ".pickup_mode.walk"] = { dod_pickup_mode = 1 },
	    		}
	    	})

	    	panel:AddControl("Slider", {
	    		Label = "#dod." .. lang .. ".max_dropped_weapons",
	    		Command = "dod_max_dropped_weapons",
	    		Type = "Integer",
	    		Min = "1",
	    		Max = "25",
	    	})

	    	panel:AddControl("Slider",
	    	{
	    		Label = "#dod." .. lang .. ".weapon_stay_limit",
	    		Command = "dod_weapon_stay_duration",
	    		Type = "Integer",
	    		Min = "1",
	    		Max = "60",
	    	})

		end

        panel:AddControl("Label", {
            Text = ""
        })

        panel:AddControl("Label", {
            Text = "#dod." .. lang .. ".other_settings"
        })

        panel:AddControl("CheckBox", {
            Label = "#dod." .. lang .. ".red_screen_of_death_enable",
            Command = "dod_red_screen_on_death_enable",
        })

    end)

end)
