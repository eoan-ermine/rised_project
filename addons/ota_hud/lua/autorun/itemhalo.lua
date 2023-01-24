-- "addons\\ota_hud\\lua\\autorun\\itemhalo.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

local SciFiVersion = "Update 6 (v1.8) (beta)"

CreateConVar( "ihl_enable", "1", 128, "Enables item / weapon highlighting" )
CreateConVar( "ihl_enable_oncamera", "0", 128, "Renders itemhalos, even when the camera tool is currently selected." )
CreateConVar( "ihl_vis_ignoreworld", "0", 128, "Determins, if weapon names should be visible through walls." )
CreateConVar( "ihl_vis_shownames", "1", 128, "Enables name tags for weapons." )
CreateConVar( "ihl_vis_showpurpose", "1", 128, "Show purpose information (weapons only)." )
CreateConVar( "ihl_vis_showauthor", "1", 128, "Show the author's name underneath the weapon tag." )
CreateConVar( "ihl_lod_max", "1024", 128, "Sets the maximum distance, at which item should be detected and scheduled for highlighting." )
CreateConVar( "ihl_color_medical", "80 255 80 255", 128, "The color used for supply items, like item_healthkits." )
CreateConVar( "ihl_color_ammo", "120 160 255 255", 128, "The color used for ammo items." )
CreateConVar( "ihl_color_wep", "255 160 130 255", 128, "The color used for Half-Life 2 weapons." )
CreateConVar( "ihl_color_swep", "255 200 220 255", 128, "The color used for scripted weapons." )
CreateConVar( "ihl_color_sent", "180 225 255 255", 128, "The color used for scripted entities." )

resource.AddFile( "effects/ihalo_haze.vmt" )
resource.AddFile( "effects/blueflare1.vmt" )
local mat_laser = Material( "effects/ihalo_haze.vmt" )
local mat_flare = Material( "effects/blueflare1.vmt" )

concommand.Add( 
	"ihl_reset", 
	
	function( pl, cmd, args )
	RunConsoleCommand( "ihl_enable", "1" )
	RunConsoleCommand( "ihl_enable_oncamera", "0" )
	RunConsoleCommand( "ihl_vis_ignoreworld", "0" )
	RunConsoleCommand( "ihl_vis_shownames", "1" )
	RunConsoleCommand( "ihl_vis_showinfo", "1" )
	RunConsoleCommand( "ihl_vis_showpurpose", "1" )
	RunConsoleCommand( "ihl_vis_showauthor", "1" )
	RunConsoleCommand( "ihl_lod_max", "1024" )
	RunConsoleCommand( "ihl_color_medical", "80 255 80 255" )
	RunConsoleCommand( "ihl_color_ammo", "120 160 255 255" )
	RunConsoleCommand( "ihl_color_wep", "255 160 130 255" )
	RunConsoleCommand( "ihl_color_swep", "255 200 220 255" )
	RunConsoleCommand( "ihl_color_sent", "20 225 255 255" )
	MsgC( Color( 255, 80, 80 ), "@ItemHighLights : !Reset; All values have been restored to default.\n" )
	end, 

	"Resets all ihl convars to default values.",
	
	0 
)

function IhlSettings( CPanel )

	CPanel:AddControl( "CheckBox", { Label = "Enable item highlighting", Command = "ihl_enable" } )
	
	CPanel:AddControl( "Header", { Description = "" } )
	CPanel:AddControl( "Header", { Description = "Visibility settings" } )
	CPanel:AddControl( "CheckBox", { Label = "Show weapon names", Command = "ihl_vis_shownames" } )
--	CPanel:AddControl( "CheckBox", { Label = "Show SWEP information (requires the option above enabled)", Command = "ihl_vis_showinfo" } )
	CPanel:AddControl( "CheckBox", { Label = "Show weapon purpose", Command = "ihl_vis_showpurpose" } )
	CPanel:AddControl( "CheckBox", { Label = "Show weapon author names", Command = "ihl_vis_showauthor" } )
	CPanel:AddControl( "CheckBox", { Label = "Show weapon names through walls", Command = "ihl_vis_ignoreworld" } )
	CPanel:AddControl( "CheckBox", { Label = "Renders itemhalos, even when the camera tool is currently selected.", Command = "ihl_enable_oncamera" } )
	CPanel:NumSlider( "Maximum rendering distance", "ihl_lod_max", 0, 2048, 0 )
	
--	CPanel:AddControl( "Header", { Description = "" } )
--	CPanel:AddControl( "Header", { Description = "Color settings" } )
--	CPanel:AddControl( "Color", { Label = "#tool.lamp.color", Red = "lamp_r", Green = "lamp_g", Blue = "lamp_b" } )

	CPanel:AddControl( "Header", { Description = "" } )
	
	CPanel:AddControl( "Header", { Description = "Also check for 'ihl_' associated console commands." } )
	
	CPanel:AddControl( "Header", { Description = "" } )
	CPanel:AddControl( "Button", { Label = "Reset to default settings", Command = "ihl_reset" } )

	CPanel:AddControl( "Header", { Description = SciFiVersion } )
	
end

function IsVisibleToPlayer( ent1, player )

	local vistrace = util.TraceEntity( {
		start = ent1:GetPos() + Vector( 0, 0, 8 ),
		endpos = player:EyePos(),
		filter = function( ent ) if ( ent == ent1 ) or ( ent:GetClass() == "prop_ragdoll" ) then return false else return true end end,
		mask = MASK_SHOT,
		ignoreworld = false
	}, ent1 )

	if ( vistrace.Entity == player ) or ( vistrace.HitPos:Distance( player:EyePos() ) <= 1 ) then
		return true
	else
		return false
	end

end

local items_supplies = {
	"item_healthkit",
	"item_healthvial",
	"item_battery"
}

local items_ammo = {
	"item_ammo_357",
	"item_ammo_357_large",
	"item_ammo_ar2",
	"item_ammo_ar2_large",
	"item_ammo_ar2_altfire",
	"item_ammo_crossbow",
	"item_ammo_pistol",
	"item_ammo_pistol_large",
	"item_ammo_smg1",
	"item_ammo_smg1_large",
	"item_ammo_smg1_grenade",
	"item_box_buckshot",
	"item_rpg_round",
}

local panicents = {
	"bgo_gib",
	"sfi_sentinel"
}

local item_whitelist = {
	"ammo_103x77",
	"ammo_12x70",
	"ammo_545x39",
	"ammo_762x25",
	"ammo_762x39",
	"ammo_762x54r",
	"ammo_9x19",
	"ammo_9x39",

	"card",
	"combine_card",
	"med_card",
	"sertificate",

	"med_drug_amitriptyline",
	"med_drug_heptender",
	"med_drug_i306n",
	"med_drug_pulmonifer",
	"med_drug_qurantimycin",
	"med_drug_zenocillin",
	"med_drug_hrzs",
	"med_drug_cardionix_z2",
	"med_drug_combicillin",
	"med_drug_tire",
	"med_box_drugs",
	"med_box_grub",
	"med_health_vial",
	"med_health_kit",
	
	"stemulant",
	"rhc_lockpick",
	"craft_grub",
	"med_station_heal",
	"watch",
	"cuw_rationpoison",
	"cuw_component_meat_raw",
	"cuw_component_enzymes_raw",
	"cuw_component_enzymes",
	"cuw_component_meat",
	"cuw_component_water",

	"rised_cloth_armor_class2",
	"rised_cloth_armor_class3",
	"rised_cloth_armor_class3_medic",
	"rised_cloth_armor_class4",
	"rised_cloth_armor_class5_combine",

	"spawned_weapon",
}

local item_supply = {
	"ammo_103x77",
	"ammo_12x70",
	"ammo_545x39",
	"ammo_762x25",
	"ammo_762x39",
	"ammo_762x54r",
	"ammo_9x19",
	"ammo_9x39",
}

hook.Add( "PopulateToolMenu", "PopulateIhlMenus", function()

	spawnmenu.AddToolMenuOption( 
	"Utilities",
	"Darken217's Hud addons",
	"CustomMenu1",
	"Item Highlights",
	"",
	"",
	IhlSettings
	)

end )

hook.Add( "PostDrawTranslucentRenderables", "ItemHalo", function()
	
	-- Rised Kostyl
	if GAMEMODE.CombineJobs[LocalPlayer():Team()] and false then

		local ihl_enable = GetConVarNumber( "ihl_enable" )
		local ihl_enable_oncamera = GetConVarNumber( "ihl_enable_oncamera" )
		local ihl_vis_ignoreworld = GetConVarNumber( "ihl_vis_ignoreworld" )
		local ihl_vis_shownames = GetConVarNumber( "ihl_vis_shownames" )
		local ihl_vis_showauthor = GetConVarNumber( "ihl_vis_showauthor" )
		local ihl_vis_showpurpose = GetConVarNumber( "ihl_vis_showpurpose" )
		local ihl_lod_max = 256
		local ihl_color_medical = string.ToColor( GetConVarString( "ihl_color_medical" ) )
		local ihl_color_ammo = string.ToColor( GetConVarString( "ihl_color_ammo" ) )
		local ihl_color_wep = string.ToColor( GetConVarString( "ihl_color_wep" ) )
		local ihl_color_swep = string.ToColor( GetConVarString( "ihl_color_swep" ) )
		local ihl_color_sent = string.ToColor( GetConVarString( "ihl_color_sent" ) )
		local wep = LocalPlayer():GetActiveWeapon()
		
		if ( ihl_enable == 0 ) then return end
		if ( ihl_enable_oncamera == 0 && wep ~= NULL && wep:GetClass() == "gmod_camera" ) then return end
		
		for k,v in pairs ( ents.FindInSphere( LocalPlayer():GetPos(), ihl_lod_max ) ) do
			
			if (v:GetOwner() == NULL && !v:GetNWBool( "MobDrop" )) and 
			(!table.HasValue(panicents, v:GetClass())) and
			(v:IsWeapon() or table.HasValue(items_supplies, v:GetClass()) or table.HasValue(items_ammo, v:GetClass()) or table.HasValue(item_whitelist, v:GetClass())) then
				
				local laser_color = Color( 255, 255, 255, 225 )
				local distance = LocalPlayer():GetPos():Distance( v:GetPos() )
				local alpha = math.Clamp( 1024 - ( distance * 8 ) / 2, 0, 200 )
				local alpha2 = math.Clamp( 512 - ( LocalPlayer():GetEyeTrace().HitPos:Distance( v:GetPos() ) * 16 ), 0, 240 )
				local alpha3 = math.Clamp( ihl_lod_max - ( distance ), 0, 200 )
				local light_start = v:GetPos()
				local light_end = v:GetPos() + Vector( 0, 0, 32 )

	--			local poslight = util.TraceLine( {
	--				start = v:GetPos() + Vector( 0, 0, 0 ),
	--				endpos = v:GetPos() + Vector( 0, 0, 32 ),		
	--				filter = function( ent ) if ( ent == v ) then return false else return true end end,
	--				mask = MASK_SHOT
	--			} )

				if ( !v:IsWeapon() ) and ( v.PrintName ~= nil ) and ( v.Spawnable == true || v.AdminSpawnable == true ) then
					laser_color = ihl_color_sent
				end
				
				if ( table.HasValue( item_supply, v:GetClass() ) ) then
					laser_color = Color(100,200,100)
				end
				
				if ( v:GetClass() ~= "gmod_tool" ) then
					if ( distance <= 256 ) then
						render.SetMaterial( mat_flare )
						render.DrawSprite( light_start, 4, 4, Color( laser_color.r, laser_color.g, laser_color.b, alpha3 ) )
					end
					
					if ( distance <= 256 ) then
						render.SetMaterial( mat_laser )
						render.DrawBeam( light_start, light_end, 0.75, 0, 1, Color( laser_color.r, laser_color.g, laser_color.b, alpha3 ) )
					end

					local text_pos = light_end:ToScreen()

					if ( ihl_vis_ignoreworld == 0 && IsVisibleToPlayer( v, LocalPlayer() ) ) or ( ihl_vis_ignoreworld == 1 ) then
						if ( distance <= 256 ) and ( ihl_vis_shownames == 1 ) then
							cam.Start2D( light_end, Angle( 0, 0, 0 ), 0.25 )
								local textcolor = Color( laser_color.r + 35, laser_color.g + 35, laser_color.b + 35, alpha )
								offset = 32
								
								if ( v:IsWeapon() ) and ( ihl_vis_shownames == 1 ) then
									if ( v.Purpose ~= nil && v.Purpose ~= "" && ihl_vis_showpurpose == 1 ) then
										draw.WordBox( 4, text_pos.x, text_pos.y + offset, "Purpose: "..v.Purpose, "DermaDefault", Color( 50, 60, 70, alpha2 ), Color( 180, 180, 180, alpha2 ) )
										offset = offset + 24
									end
									
									if ( v.Author ~= nil && v.Author ~= "" && ihl_vis_showauthor == 1 ) then
										draw.WordBox( 4, text_pos.x, text_pos.y + offset, "Author: "..v.Author, "DermaDefault", Color( 50, 60, 70, alpha2 ), Color( 180, 180, 180, alpha2 ) )
										offset = offset + 24
									end
								end
								
								if ( ihl_vis_shownames == 1 ) then
									if v:GetClass() != "spawned_weapon" and v.PrintName != nil and v.PrintName != "" and ( !table.HasValue( items_supplies, v:GetClass() ) && !table.HasValue( items_ammo, v:GetClass() ) ) then
										draw.WordBox( 4, text_pos.x, text_pos.y, v.PrintName, "marske4", Color( 145, 255, 145, 5 ), Color( 255, 255, 255, 255 ) )
									elseif v:GetClass() == "spawned_weapon" then
										local weapon = weapons.Get(v:GetWeaponClass())
										local weaponName = "Неизвестное оружие"
										if weapon then
											weaponName = weapon.PrintName
										end
										draw.WordBox( 4, text_pos.x, text_pos.y, weaponName, "marske4", Color( 145, 255, 145, 5 ), Color( 255, 255, 255, 255 ) )
									end
								end
							cam.End2D()
						end
					end
				end
			end
		end
	end
end )
