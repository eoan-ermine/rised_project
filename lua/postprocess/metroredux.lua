-- "lua\\postprocess\\metroredux.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

--[[---------------------------------------------------------
   Register the convars that will control this effect
-----------------------------------------------------------]]
local pp_mat_overlay 				= CreateClientConVar( "pp_mat_overlay", "", false, false )
local pp_mat_overlay_refractamount	= CreateClientConVar( "pp_mat_overlay_refractamount", "0.3", true, false )

local lastTexture = nil
local mat_Overlay = nil

function DrawMaterialOverlay( texture, refractamount )

	if ( texture ~= lastTexture or mat_Overlay == nil ) then
		mat_Overlay = Material( texture )
		lastTexture = texture
	end
	
	if ( mat_Overlay == nil ) then return end

	render.UpdateScreenEffectTexture()

	// FIXME: Changing refract amount affects textures used in the map/models.
	mat_Overlay:SetFloat( "$envmap", 0 )
	mat_Overlay:SetFloat( "$envmaptint", 0 )
	mat_Overlay:SetFloat( "$refractamount", refractamount )
	mat_Overlay:SetInt( "$ignorez", 1 )

	render.SetMaterial( mat_Overlay )
	render.DrawScreenQuad()
	
end

local function DrawInternal()

	local overlay = pp_mat_overlay:GetString()

	if ( overlay == "" ) then return end
	if ( !GAMEMODE:PostProcessPermitted( "material overlay" ) ) then return end

	DrawMaterialOverlay( overlay, pp_mat_overlay_refractamount:GetFloat() )

end
hook.Add( "RenderScreenspaceEffects", "RenderMaterialOverlay", DrawInternal )

list.Set( "OverlayMaterials", "#MetroReduxMask1",	{ Material = "Morganicism/MetroRedux/gasmask/metromask1", Icon = "Morganicism/MetroRedux/gasmask/metromask1" } )
list.Set( "OverlayMaterials", "#MetroReduxMask2",	{ Material = "Morganicism/MetroRedux/gasmask/metromask2", Icon = "Morganicism/MetroRedux/gasmask/metromask2" } )
list.Set( "OverlayMaterials", "#MetroReduxMask3",	{ Material = "Morganicism/MetroRedux/gasmask/metromask3", Icon = "Morganicism/MetroRedux/gasmask/metromask3" } )
list.Set( "OverlayMaterials", "#MetroReduxMask4",	{ Material = "Morganicism/MetroRedux/gasmask/metromask4", Icon = "Morganicism/MetroRedux/gasmask/metromask4" } )
list.Set( "OverlayMaterials", "#MetroReduxMask5",	{ Material = "Morganicism/MetroRedux/gasmask/metromask5", Icon = "Morganicism/MetroRedux/gasmask/metromask5" } )
list.Set( "OverlayMaterials", "#MetroReduxMask6",	{ Material = "Morganicism/MetroRedux/gasmask/metromask6", Icon = "Morganicism/MetroRedux/gasmask/metromask6" } )

list.Set( "PostProcess", "#overlay_pp", {

	category = "#overlay_pp",
	
	func = function( content )
	
		for k, overlay in pairs( list.Get( "OverlayMaterials" ) ) do
		
			spawnmenu.CreateContentIcon( "postprocess", content, {
				name	= "#overlay_pp",
				label	= k,
				icon	= overlay.Icon,
				convars = {
					pp_mat_overlay = {
						on = overlay.Material,
						off = ""
					}
				}
			} )
			
		end
	
	end,

	cpanel = function( CPanel )

		CPanel:AddControl( "Header", { Description = "#overlay_pp.desc" } )
		
		local params = { Options = {}, CVars = {}, MenuButton = "1", Folder = "overlay" }
		params.Options[ "#preset.default" ] = { pp_mat_overlay_refractamount = "0.3" }
		params.CVars = table.GetKeys( params.Options[ "#preset.default" ] )
		CPanel:AddControl( "ComboBox", params )
		
		CPanel:AddControl( "Slider", { Label = "#overlay_pp.refract", Command = "pp_mat_overlay_refractamount", Type = "Float", Min = "-1", Max = "1" } )
		
	end

} )
