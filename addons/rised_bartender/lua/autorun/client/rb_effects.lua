-- "addons\\rised_bartender\\lua\\autorun\\client\\rb_effects.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function purl(t)
	sound.PlayURL(t, 'play', function(t) t:SetVolume(.4) end)
end

net.Receive("CocktailBloom", function(len, ply)
	
	cocktail = net.ReadString()
	
	if cocktail == "1" then
		local tab = {
			[ "$pp_colour_addr" ] = 0,
			[ "$pp_colour_addg" ] = 0,
			[ "$pp_colour_addb" ] = 0,
			[ "$pp_colour_brightness" ] = 0,
			[ "$pp_colour_contrast" ] = 1,
			[ "$pp_colour_colour" ] = 1,
			[ "$pp_colour_mulr" ] = 0,
			[ "$pp_colour_mulg" ] = 0,
			[ "$pp_colour_mulb" ] = 0
		}
		purl('https://cdn.discordapp.com/attachments/917913386942083144/940663251191103498/pianino-akkord-nejnyiy.wav')

		hook.Remove("RenderScreenspaceEffects", "cock1")
		local n = 0
		hook.Add("RenderScreenspaceEffects", "cock1", function()
			n = math.Approach(n, 2,.005)
			tab["$pp_colour_colour"] = n
			DrawColorModify( tab )
			DrawMotionBlur( 0.6, 0.6, 0.01 )
			DrawBloom( 0.35, 2, 9, 9, 1, 1, 1, 1, 1 )
		end)

		timer.Create("Cock1", 180, 1, function()
			hook.Remove("RenderScreenspaceEffects", "cock1")
		end)
	end
	if cocktail == "2" then
		local g = 0
		local view = {
				angles =Angle(0,0,g),
			}
		purl('https://cdn.discordapp.com/attachments/917913386942083144/940667700798181436/veselyiy-fortepiannyiy-zvuk-41791.wav')
		timer.Simple(.7, function()
			hook.Remove( "CalcView", "AlcFL")
			hook.Add( "CalcView", "AlcFL", function( ply, pos, angles, fov )	
				g = math.Approach(g, 720, .1)

				view.angles = angles - Angle(0,0,g)
				view.pos = pos
				view.fov = fov
				return view
			end )
			hook.Add("RenderScreenspaceEffects", "cock2", function()
				DrawMotionBlur( 0.5, 0.6, 0.01 )
			end)
			timer.Create('cock2b', 80, 1, function()
				hook.Remove( "CalcView", "AlcFL")
			end)

			timer.Create("Cock2", 180, 1, function()
				hook.Remove("RenderScreenspaceEffects", "cock2")
			end)
		end)
	end
	if cocktail == "3" then
		purl('https://cdn.discordapp.com/attachments/917913386942083144/940668805238112297/pianino-odinochnyiy-bass.wav')
		timer.Simple(.1, function()
			util.ScreenShake( LocalPlayer():GetPos(), 15, 5, 10, 5000 )
			local hfhf = 25

			hook.Add("RenderScreenspaceEffects", "cock3", function()
				DrawMotionBlur( 0.5, 0.6, 0.01 )
			end)
			timer.Create("cock3", 180, 1, function()
				hook.Remove("RenderScreenspaceEffects", "cock3")
			end)

			hook.Add("RenderScreenspaceEffects", "cock3_b", function()
				hfhf = math.Approach(hfhf, 0, .05)
				DrawSharpen( hfhf, hfhf )
			end)
			timer.Create('cock3b', 7, 1, function()
				hook.Remove("RenderScreenspaceEffects", "cock3_b")
			end)
		end)
	end
	if cocktail == "4" then
		local tab = {
			[ "$pp_colour_addr" ] = 0,
			[ "$pp_colour_addg" ] = 0,
			[ "$pp_colour_addb" ] = 0,
			[ "$pp_colour_brightness" ] = 0,
			[ "$pp_colour_contrast" ] = 1,
			[ "$pp_colour_colour" ] = 1,
			[ "$pp_colour_mulr" ] = 0,
			[ "$pp_colour_mulg" ] = 0,
			[ "$pp_colour_mulb" ] = 0
		}
		purl('https://cdn.discordapp.com/attachments/917913386942083144/940671428116774932/pianino-akkord-trevojnyiy.wav')

		local hf = 0
		local cur = CurTime() + 3
		hook.Add("RenderScreenspaceEffects", "blob", function()
			hf = math.Approach(hf, cur <= CurTime() and 0 or .5,.01)
			
			tab["$pp_colour_addr"] = hf
			-- tab["$pp_colour_addr"] = n
			DrawColorModify(tab)
		end)
		timer.Create('cock4b', 7, 1, function()
			hook.Remove("RenderScreenspaceEffects", "blob")
		end)
		local n = 0
		hook.Add("RenderScreenspaceEffects", "cock4", function()
			-- n = math.Approach(n, 0,.005)
			-- tab["$pp_colour_addr"] = n
			DrawMotionBlur( 0.5, 0.6, 0.01 )
		end)
	
		timer.Create("cock4", 180, 1, function()
			hook.Remove("RenderScreenspaceEffects", "cock4")
		end)
	end
	if cocktail == "5" then
		local tab = {
			[ "$pp_colour_addr" ] = 0,
			[ "$pp_colour_addg" ] = 0,
			[ "$pp_colour_addb" ] = 0,
			[ "$pp_colour_brightness" ] = 0,
			[ "$pp_colour_contrast" ] = 1,
			[ "$pp_colour_colour" ] = 1,
			[ "$pp_colour_mulr" ] = 0,
			[ "$pp_colour_mulg" ] = 0,
			[ "$pp_colour_mulb" ] = 0
		}
		purl('https://cdn.discordapp.com/attachments/917913386942083144/940673505949790238/dusha-sozertsatelnoy-fortepiannoy-sektsii-43196.wav')

		local cur = CurTime() + 7
		hf = 0
		hook.Add("RenderScreenspaceEffects", "cock5b", function()
			hf = math.Approach(hf, cur <= CurTime() and .5 or 1.5,.01)
			
			tab["$pp_colour_colour"] = hf
			-- tab["$pp_colour_addr"] = n
			DrawColorModify(tab)
		end)
		timer.Create('cock5b', 10, 1, function()
			hook.Remove("RenderScreenspaceEffects", "cock5b")
		end)

		hook.Add("RenderScreenspaceEffects", "cock5", function()
			DrawMotionBlur( 0.5, 0.6, 0.01 )
		end)
	
		timer.Create("cock5", 180, 1, function()
			hook.Remove("RenderScreenspaceEffects", "cock5")
		end)
	end
	if cocktail == "6" then
		purl('https://cdn.discordapp.com/attachments/917913386942083144/940674643856097290/pianino-akkord-umirotvoryayuschiy.wav')
		local tab = {
			[ "$pp_colour_addr" ] = 0,
			[ "$pp_colour_addg" ] = 0,
			[ "$pp_colour_addb" ] = 0,
			[ "$pp_colour_brightness" ] = 0,
			[ "$pp_colour_contrast" ] = 1,
			[ "$pp_colour_colour" ] = 1,
			[ "$pp_colour_mulr" ] = 0,
			[ "$pp_colour_mulg" ] = 0,
			[ "$pp_colour_mulb" ] = 0
		}
		local n = 0
		hook.Add("RenderScreenspaceEffects", "cock6b", function()
			n = math.Approach(n, math.random(-.5, .5), 0.07)
			tab[ "$pp_colour_contrast" ] = 1.2
			tab[ "$pp_colour_colour" ] = 1 + n
			DrawColorModify(tab)
		end)

		timer.Create('coc6kb', 10, 1, function()
			hook.Remove("RenderScreenspaceEffects", "cock6b")
		end)

		hook.Add("RenderScreenspaceEffects", "cock6", function()
			DrawMotionBlur( 0.5, 0.6, 0.01 )
		end)
	
		timer.Create("cock6Timer", 180, 1, function()
			hook.Remove("RenderScreenspaceEffects", "cock6")
		end)
	end
	if cocktail == "7" then
		hook.Add("RenderScreenspaceEffects", "cock7", function()
			DrawMotionBlur( 0.5, 0.6, 0.01 )
		end)
	
		timer.Create("CocktailBloomTimer", 180, 1, function()
			hook.Remove("RenderScreenspaceEffects", "cock7")
		end)
	end
	if cocktail == "8" then
		purl("https://cdn.discordapp.com/attachments/917913386942083144/940677678686699550/Kevin_MacLeod_-_Doh_De_Oh_WHATAUDIO.RU.mp3")

		local delay = 0

		hook.Add("RenderScreenspaceEffects", "cock8b", function()
			if delay <= CurTime() then
				delay = CurTime() + .3
				RunConsoleCommand('+forward')
				RunConsoleCommand('+moveleft')

				RunConsoleCommand('-forward')
				RunConsoleCommand('-moveleft')

				RunConsoleCommand('+moveright')
				RunConsoleCommand('-moveright')

				RunConsoleCommand('+back')
				RunConsoleCommand('-back')

				RunConsoleCommand('-forward')
				RunConsoleCommand('-moveleft')
			end	
		end)

		hook.Add("RenderScreenspaceEffects", "cock8", function()
			DrawMotionBlur( 0.3, 0.6, 0.01 )
		end)
		timer.Create("cock8b", 30, 1, function()
			hook.Remove("RenderScreenspaceEffects", "cock8b")
		end)
		timer.Create("cock8", 180, 1, function()
			hook.Remove("RenderScreenspaceEffects", "cock8")
		end)
	end
	if cocktail == "9" then
		purl('https://cdn.discordapp.com/attachments/917913386942083144/940680199555653652/fortepiano-igraet-perehod-audio-41285.wav')
		local cur = CurTime() + 1
		local tab = {
			[ "$pp_colour_addr" ] = 0,
			[ "$pp_colour_addg" ] = 0,
			[ "$pp_colour_addb" ] = 0,
			[ "$pp_colour_brightness" ] = 0,
			[ "$pp_colour_contrast" ] = 1,
			[ "$pp_colour_colour" ] = 1,
			[ "$pp_colour_mulr" ] = 0,
			[ "$pp_colour_mulg" ] = 0,
			[ "$pp_colour_mulb" ] = 0
		}
		local kontr = 0
		local sex = 0
		
		hook.Add("RenderScreenspaceEffects", "cock9b", function()
			kontr = math.Approach(kontr, cur > CurTime() and .2 or 4, .05)
		    sex = math.Approach(sex, cur > CurTime() and .3 or 1.1, .05)
			tab[ "$pp_colour_colour" ] = kontr
			tab[ "$pp_colour_contrast" ]  = sex
			DrawColorModify(tab)
		end)
		timer.Create('seduce', 80,1, function()
			hook.Remove("RenderScreenspaceEffects", "cock9b")
		end)

		hook.Add("RenderScreenspaceEffects", "cock9", function()
			DrawMotionBlur( 0.6, 0.6, 0.01 )
		end)
		timer.Create('reduce', 78, 1, function()
			cur = CurTime() + 4
		end)
		timer.Create("cock9", 180, 1, function()
			hook.Remove("RenderScreenspaceEffects", "cock9")
		end)
	end
	if cocktail == "10" then
		purl("https://cdn.discordapp.com/attachments/917913386942083144/940864934311493692/risedproject.wav") // special
		local tab = {
			[ "$pp_colour_addr" ] = 0,
			[ "$pp_colour_addg" ] = 0,
			[ "$pp_colour_addb" ] = 0,
			[ "$pp_colour_brightness" ] = 0,
			[ "$pp_colour_contrast" ] = 1,
			[ "$pp_colour_colour" ] = 1.5,
			[ "$pp_colour_mulr" ] = 0,
			[ "$pp_colour_mulg" ] = 0,
			[ "$pp_colour_mulb" ] = 0
		}
		
		hook.Add("RenderScreenspaceEffects", "cock10", function()
			DrawMotionBlur( 0.6, 0.6, 0.01 )
		end)

		hook.Add("RenderScreenspaceEffects", "cock10b", function()
			DrawColorModify(tab)
		end)
		
		timer.Create("cock10", 180, 1, function()
			hook.Remove("RenderScreenspaceEffects", "cock10")
			hook.Remove("RenderScreenspaceEffects", "cock10b")
		end)
	end
end)