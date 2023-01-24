-- "lua\\autorun\\eyeview.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal


-- Eye View is a addon that sets the player's view to any attachment on the playermodel.

function EYEVIEW_Initialize()

	if ( CLIENT ) then
	
		EYEVIEW_THINK_DELAY = 0
		CreateClientConVar( "eyeview_enabled", "0", true, true )
		CreateClientConVar( "eyeview_full", "0", true, true )
		CreateClientConVar( "eyeview_aimhelper", "1", true, true )
		CreateClientConVar( "eyeview_attachment", "eyes", false, true )
		CreateClientConVar( "eyeview_headresize", "0", true, true )
		CreateClientConVar( "eyeview_crouchdisable", "0", true, true )
	
	end

end
hook.Add( "Initialize", "EYEVIEW_Initialize", EYEVIEW_Initialize )

local notEyeWeapons = {
	"weapon_physgun",
	"gmod_tool",
	"weapon_csniper",
	"weapon_crossbow",
	"swb_awp",
	"swb_g3sg1",
	"swb_sg550",
	"swb_sg552",
	"swb_aug",
	"swb_scout",
	"weapon_slam",
}

local trueEyeWeapons = {
	"swb_ar1",
	"swb_ar2",
	"swb_ar3",
	"swb_shotgun_charge",
}

function EYEVIEW_Think()

	if ( CLIENT ) then

		if EYEVIEW_THINK_DELAY < CurTime() then

			if ( LocalPlayer():LookupBone( "ValveBiped.Bip01_Head1" ) ) then
			
				local thirdpersonview_enable2 = GetConVar( "rised_thirdpersonview_enable" )

				if IsValid(LocalPlayer():GetActiveWeapon()) then
				
					if ( GetConVar( "eyeview_enabled" ):GetBool() && ( LocalPlayer():IsValid() && LocalPlayer():Alive() ) && !thirdpersonview_enable2:GetBool() ) || table.HasValue(trueEyeWeapons, LocalPlayer():GetActiveWeapon():GetClass()) && !thirdpersonview_enable2:GetBool() then

						LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Bip01_Head1" ), Vector( 0, 0, 0 ) )
						LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Bip01_Spine" ), Vector( 1, 1, 1 ) )
						LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Anim_Attachment_RH" ), Vector( 1, 1, 1 ) )
						LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Bip01_R_Hand" ), Vector( 1, 1, 1 ) )
						LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Bip01_R_Forearm" ), Vector( 1, 1, 1 ) )
						LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Bip01_R_Foot" ), Vector( 1, 1, 1 ) )
						LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Bip01_R_Thigh" ), Vector( 1, 1, 1 ) )
						LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Bip01_R_Calf" ), Vector( 1, 1, 1 ) )
					
					else
					
						LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Bip01_Head1" ), Vector( 1, 1, 1 ) )
					
					end
					
				end
				
			end
			EYEVIEW_THINK_DELAY = CurTime() + 0.1
		
		end
	
	end

end
hook.Add( "Think", "EYEVIEW_Think", EYEVIEW_Think )


if ( CLIENT ) then

function EYEVIEW_CalcView( ply, origin, angles, fov, near, far )

	if ply:GetNWBool("Dispatch_CPView_Enabled") then
		
		cp = ply:GetNWEntity("Dispatch_CPView_Player")
		
		local eyeview = {}
		
		if ( cp:LookupAttachment( GetConVarString( "eyeview_attachment" ) ) ) then
		
			eyeview.origin = cp:GetAttachment( cp:LookupAttachment( GetConVarString( "eyeview_attachment" ) ) ).Pos
		
		else
		
			eyeview.origin = origin
		
		end
		
		eyeview.angles = cp:GetAttachment( cp:LookupAttachment( GetConVarString( "eyeview_attachment" ) ) ).Ang
		
		eyeview.fov = fov
	
		return eyeview
	end

	if ( GetConVar( "eyeview_enabled" ):GetBool() && ( ply:IsValid() && ply:Alive() && ( !GetConVar( "eyeview_crouchdisable" ):GetBool() || !ply:Crouching() ) ) ) then
	
		if IsValid(ply:GetActiveWeapon()) then
			if table.HasValue(notEyeWeapons, ply:GetActiveWeapon():GetClass()) then return end
		end
		
		local eyeview = {}
		
		if ( ply:LookupAttachment( GetConVarString( "eyeview_attachment" ) ) ) then
		
			eyeview.origin = ply:GetAttachment( ply:LookupAttachment( GetConVarString( "eyeview_attachment" ) ) ).Pos
		
		else
		
			eyeview.origin = origin
		
		end
		
		if ( GetConVar( "eyeview_full" ):GetBool() && ply:LookupAttachment( GetConVarString( "eyeview_attachment" ) ) ) then
		
			eyeview.angles = ply:GetAttachment( ply:LookupAttachment( GetConVarString( "eyeview_attachment" ) ) ).Ang
		
		else
		
			eyeview.angles = angles
		
		end
		
		eyeview.fov = fov
	
		return eyeview
	
	end
	
	if IsValid(ply:GetActiveWeapon()) then
	
		if table.HasValue(trueEyeWeapons, ply:GetActiveWeapon():GetClass()) then
		
			if IsValid(ply:GetActiveWeapon()) then
				if table.HasValue(notEyeWeapons, ply:GetActiveWeapon():GetClass()) then return end
			end
			
			local eyeview = {}
			
			if ( ply:LookupAttachment( GetConVarString( "eyeview_attachment" ) ) ) then
			
				eyeview.origin = ply:GetAttachment( ply:LookupAttachment( GetConVarString( "eyeview_attachment" ) ) ).Pos
			
			else
			
				eyeview.origin = origin
			
			end
			
			if ( GetConVar( "eyeview_full" ):GetBool() && ply:LookupAttachment( GetConVarString( "eyeview_attachment" ) ) ) then
			
				eyeview.angles = ply:GetAttachment( ply:LookupAttachment( GetConVarString( "eyeview_attachment" ) ) ).Ang
			
			else
			
				eyeview.angles = angles
			
			end
			
			eyeview.fov = fov
		
			return eyeview
		
		end
		
	end

end
hook.Add( "CalcView", "EYEVIEW_CalcView", EYEVIEW_CalcView )


function EYEVIEW_HUDPaint()

	if ( ( GetConVar( "eyeview_enabled" ):GetBool() && GetConVar( "eyeview_aimhelper" ):GetBool() ) && ( LocalPlayer():IsValid() && LocalPlayer():Alive() && ( !GetConVar( "eyeview_crouchdisable" ):GetBool() || !LocalPlayer():Crouching() ) ) ) then
		
		if IsValid(ply:GetActiveWeapon()) then
			if table.HasValue(notEyeWeapons, ply:GetActiveWeapon():GetClass()) then return end
		end
		
		surface.SetDrawColor( Color( 0, 0, 0, 255 ) )
		surface.DrawRect( LocalPlayer():GetEyeTrace().HitPos:ToScreen().x - 2, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y - 2, 6, 6 )
		surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
		surface.DrawRect( LocalPlayer():GetEyeTrace().HitPos:ToScreen().x - 1, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y - 1, 4, 4 )
	
	end
	
	if IsValid(ply:GetActiveWeapon()) then
	
		if table.HasValue(trueEyeWeapons, ply:GetActiveWeapon():GetClass()) then
		
			if IsValid(ply:GetActiveWeapon()) then
				if table.HasValue(notEyeWeapons, ply:GetActiveWeapon():GetClass()) then return end
			end
			
			surface.SetDrawColor( Color( 0, 0, 0, 255 ) )
			surface.DrawRect( LocalPlayer():GetEyeTrace().HitPos:ToScreen().x - 2, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y - 2, 6, 6 )
			surface.SetDrawColor( Color( 255, 255, 255, 255 ) )
			surface.DrawRect( LocalPlayer():GetEyeTrace().HitPos:ToScreen().x - 1, LocalPlayer():GetEyeTrace().HitPos:ToScreen().y - 1, 4, 4 )
		
		end
	
	end
	
end
hook.Add( "HUDPaint", "EYEVIEW_HUDPaint", EYEVIEW_HUDPaint )


function EYEVIEW_ShouldDrawLocalPlayer( ply )

	if ( GetConVar( "eyeview_enabled" ):GetBool() && ( ply:IsValid() && ply:Alive() && ( !GetConVar( "eyeview_crouchdisable" ):GetBool() || !ply:Crouching() )) ) then
		 
		if IsValid(ply:GetActiveWeapon()) then
			if table.HasValue(notEyeWeapons, ply:GetActiveWeapon():GetClass()) then return end
		end
		
		return true
	
	end
	
	if IsValid(ply:GetActiveWeapon()) then
	
		if table.HasValue(trueEyeWeapons, ply:GetActiveWeapon():GetClass()) then
			 
			if IsValid(ply:GetActiveWeapon()) then
				if table.HasValue(notEyeWeapons, ply:GetActiveWeapon():GetClass()) then return end
			end
			
			return true
		
		end
	
	end
end
hook.Add( "ShouldDrawLocalPlayer", "EYEVIEW_ShouldDrawLocalPlayer", EYEVIEW_ShouldDrawLocalPlayer )


list.Set( "DesktopWindows", "EyeViewAttachment", {

	title		= "Eye View Menu",
	icon		= "icon64/tool.png",
	width		= 256,
	height		= 168,
	onewindow	= true,
	init		= function( icon, window )
	
		window:ShowCloseButton( false )
		window:SetBackgroundBlur( true )
	
		local DButton = window:Add( "DButton" )
		DButton:SetPos( 3, 25 )
		DButton:SetText( "View" )
		DButton:SetSize( 250, 40 )
		DButton.DoClick = function()
		
			if ( GetConVar( "eyeview_enabled" ):GetBool() ) then
			
				RunConsoleCommand( "eyeview_enabled", "0" )
			
			else
			
				RunConsoleCommand( "eyeview_enabled", "1" )
			
			end
			window:Close()
		
		end
	
		local DLabel = DButton:Add( "DLabel" )
		DLabel:SetFont( "BudgetLabel" )
		if ( GetConVar( "eyeview_enabled" ):GetBool() ) then
		
			DLabel:SetText( "ON" )
			DLabel:SetTextColor( Color( 0, 255, 0, 255 ) )
		
		else
		
			DLabel:SetText( "OFF" )
			DLabel:SetTextColor( Color( 255, 0, 0, 255 ) )
		
		end
		DLabel:SizeToContents()
	
		local DButton = window:Add( "DButton" )
		DButton:SetPos( 3, 65 )
		DButton:SetText( "Full View" )
		DButton:SetSize( 250, 40 )
		DButton.DoClick = function()
		
			if ( GetConVar( "eyeview_full" ):GetBool() ) then
			
				RunConsoleCommand( "eyeview_full", "0" )
			
			else
			
				RunConsoleCommand( "eyeview_full", "1" )
			
			end
			window:Close()
		
		end
	
		local DLabel = DButton:Add( "DLabel" )
		DLabel:SetFont( "BudgetLabel" )
		if ( GetConVar( "eyeview_full" ):GetBool() ) then
		
			DLabel:SetText( "ON" )
			DLabel:SetTextColor( Color( 0, 255, 0, 255 ) )
		
		else
		
			DLabel:SetText( "OFF" )
			DLabel:SetTextColor( Color( 255, 0, 0, 255 ) )
		
		end
		DLabel:SizeToContents()
	
		local DButton = window:Add( "DButton" )
		DButton:SetPos( 3, 105 )
		DButton:SetText( "Aim Helper" )
		DButton:SetSize( 250, 40 )
		DButton.DoClick = function()
		
			if ( GetConVar( "eyeview_aimhelper" ):GetBool() ) then
			
				RunConsoleCommand( "eyeview_aimhelper", "0" )
			
			else
			
				RunConsoleCommand( "eyeview_aimhelper", "1" )
			
			end
			window:Close()
		
		end
	
		local DLabel = DButton:Add( "DLabel" )
		DLabel:SetFont( "BudgetLabel" )
		if ( GetConVar( "eyeview_aimhelper" ):GetBool() ) then
		
			DLabel:SetText( "ON" )
			DLabel:SetTextColor( Color( 0, 255, 0, 255 ) )
		
		else
		
			DLabel:SetText( "OFF" )
			DLabel:SetTextColor( Color( 255, 0, 0, 255 ) )
		
		end
		DLabel:SizeToContents()
	
		local DButton = window:Add( "DButton" )
		DButton:SetPos( 3, 145 )
		DButton:SetText( "Head Resize" )
		DButton:SetSize( 125, 20 )
		DButton.DoClick = function()
		
			if ( GetConVar( "eyeview_headresize" ):GetBool() ) then
			
				RunConsoleCommand( "eyeview_headresize", "0" )
				if ( LocalPlayer():LookupBone( "ValveBiped.Bip01_Head1" ) ) then
				
					LocalPlayer():ManipulateBoneScale( LocalPlayer():LookupBone( "ValveBiped.Bip01_Head1" ), Vector( 1, 1, 1 ) )
				
				end
			
			else
			
				RunConsoleCommand( "eyeview_headresize", "1" )
			
			end
			window:Close()
		
		end
	
		local DLabel = DButton:Add( "DLabel" )
		DLabel:SetFont( "BudgetLabel" )
		if ( GetConVar( "eyeview_headresize" ):GetBool() ) then
		
			DLabel:SetText( "ON" )
			DLabel:SetTextColor( Color( 0, 255, 0, 255 ) )
		
		else
		
			DLabel:SetText( "OFF" )
			DLabel:SetTextColor( Color( 255, 0, 0, 255 ) )
		
		end
		DLabel:SizeToContents()
	
		local DButton = window:Add( "DButton" )
		DButton:SetPos( 128, 145 )
		DButton:SetText( "Close" )
		DButton:SetSize( 125, 20 )
		DButton.DoClick = function()
		
			window:Close()
		
		end
	
	end

} )

end
