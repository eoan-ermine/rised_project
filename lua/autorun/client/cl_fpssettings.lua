-- "lua\\autorun\\client\\cl_fpssettings.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local antilag = false
local antilagConvar = CreateClientConVar("bucket_mcore", 1, true)

local function antilagOn()
	RunConsoleCommand("gmod_mcore_test", "1")
	RunConsoleCommand("mat_queue_mode", "-1")
	RunConsoleCommand("cl_threaded_bone_setup", "1")
	RunConsoleCommand("cl_threaded_client_leaf_system", "1")
	RunConsoleCommand("r_threaded_client_shadow_manager", "1")
	RunConsoleCommand("r_threaded_particles", "1")
	RunConsoleCommand("r_threaded_renderables", "1")
	RunConsoleCommand("r_queued_ropes", "1")
	RunConsoleCommand("studio_queue_mode", "1")
	
	hook.Remove("RenderScreenspaceEffects", "RenderColorModify")
    hook.Remove("RenderScreenspaceEffects", "RenderBloom")
 	hook.Remove("RenderScreenspaceEffects", "RenderToyTown")
 	hook.Remove("RenderScreenspaceEffects", "RenderTexturize")
 	hook.Remove("RenderScreenspaceEffects", "RenderSunbeams")
 	hook.Remove("RenderScreenspaceEffects", "RenderSobel")
 	hook.Remove("RenderScreenspaceEffects", "RenderSharpen")
 	hook.Remove("RenderScreenspaceEffects", "RenderMaterialOverlay")
 	hook.Remove("RenderScreenspaceEffects", "RenderMotionBlur")
 	hook.Remove("RenderScene", "RenderStereoscopy")
 	hook.Remove("RenderScene", "RenderSuperDoF")
 	hook.Remove("GUIMousePressed", "SuperDOFMouseDown")
 	hook.Remove("GUIMouseReleased", "SuperDOFMouseUp")
 	hook.Remove("PreventScreenClicks", "SuperDOFPreventClicks")
 	hook.Remove("PostRender", "RenderFrameBlend")
 	hook.Remove("PreRender", "PreRenderFrameBlend")
 	hook.Remove("Think", "DOFThink")
 	hook.Remove("RenderScreenspaceEffects", "RenderBokeh")
 	hook.Remove("NeedsDepthPass", "NeedsDepthPass_Bokeh")
 	hook.Remove("PostDrawEffects", "RenderWidgets")
 	hook.Remove("PostDrawEffects", "RenderHalos")
end

local function antilagOff()
	RunConsoleCommand("gmod_mcore_test", "0")
	RunConsoleCommand("mat_queue_mode", "0")
	RunConsoleCommand("cl_threaded_bone_setup", "0")
	RunConsoleCommand("cl_threaded_client_leaf_system", "0")
	RunConsoleCommand("r_threaded_client_shadow_manager", "0")
	RunConsoleCommand("r_threaded_particles", "0")
	RunConsoleCommand("r_threaded_renderables", "0")
	RunConsoleCommand("r_queued_ropes", "0")
	RunConsoleCommand("studio_queue_mode", "0")
	
	hook.Add("RenderScreenspaceEffects", "RenderColorModify")
    hook.Add("RenderScreenspaceEffects", "RenderBloom")
 	hook.Add("RenderScreenspaceEffects", "RenderToyTown")
 	hook.Add("RenderScreenspaceEffects", "RenderTexturize")
 	hook.Add("RenderScreenspaceEffects", "RenderSunbeams")
 	hook.Add("RenderScreenspaceEffects", "RenderSobel")
 	hook.Add("RenderScreenspaceEffects", "RenderSharpen")
 	hook.Add("RenderScreenspaceEffects", "RenderMaterialOverlay")
 	hook.Add("RenderScreenspaceEffects", "RenderMotionBlur")
 	hook.Add("RenderScene", "RenderStereoscopy")
 	hook.Add("RenderScene", "RenderSuperDoF")
 	hook.Add("GUIMousePressed", "SuperDOFMouseDown")
 	hook.Add("GUIMouseReleased", "SuperDOFMouseUp")
 	hook.Add("PreventScreenClicks", "SuperDOFPreventClicks")
 	hook.Add("PostRender", "RenderFrameBlend")
 	hook.Add("PreRender", "PreRenderFrameBlend")
 	hook.Add("Think", "DOFThink")
 	hook.Add("RenderScreenspaceEffects", "RenderBokeh")
 	hook.Add("NeedsDepthPass", "NeedsDepthPass_Bokeh")
 	hook.Add("PostDrawEffects", "RenderWidgets")
 	hook.Add("PostDrawEffects", "RenderHalos")
end

local function runWhenValid()
	timer.Simple(5, function()
		if antilagConvar:GetInt() >= 1 then
			--chat.AddText(Color(0, 161, 255), "Загрузка системы оптимизации! (!opt 0 чтобы выключить)") 
			antilagOn()
			antilag = true
		else
			--chat.AddText(Color(0, 161, 255), "Напиши '!opt 1' чтобы включить оптимизацию") 
		end
	end)
end

hook.Add("OnEntityCreated","WidgetInit",function(ent) -- C+P from Facepunch
	if ent:IsWidget() then
		hook.Add( "PlayerTick", "TickWidgets", function( pl, mv ) widgets.PlayerTick( pl, mv ) end ) 
		hook.Remove("OnEntityCreated","WidgetInit") -- calls it only once
	end
end)

local function loopUntilValid()
	if !IsValid(LocalPlayer()) then
		timer.Simple(1, loopUntilValid)
	else
		runWhenValid()
	end
end
loopUntilValid()
antilagOn() 

local chatCommands = {
	["!opt"] = function() 
		if !antilag then
			antilag = true
			antilagOn() 
			chat.AddText(Color(255, 195, 87), "Оптимизация включена!") 
		else
			chat.AddText(Color(255, 195, 87), "Отпимизация итак включена!") 
		end
	end,
	["!opt 1"] = function() 
		if !antilag then 
			antilag = true 
			antilagOn()
		end 
		RunConsoleCommand("bucket_mcore", "1")
		chat.AddText(Color(255, 195, 87), "Оптимизация включена!")
	end,
	["!opt 0"] = function()
		if antilag then
			antilagOff()
			antilag = false
		end
		RunConsoleCommand("bucket_mcore", "0")
		chat.AddText(Color(255, 195, 87), "Отпимизация выключена!")
	end,
}
hook.Add("OnPlayerChat", "bucketMcore", function( ply, strText, bTeam, bDead )
	if ply == LocalPlayer() then
		strText = string.lower( strText )
		if chatCommands[strText] != nil then
			chatCommands[strText]()
			return true
		end
	end
end)
