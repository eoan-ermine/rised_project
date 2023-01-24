-- "addons\\midi_setter\\lua\\autorun\\midiinit.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--===================================================
--= MIDI Funktion für das Playable Piano Addon
--= Init.script geschrieben von DerModMaster
--===================================================
local string = string
local table = table
local util = util
local concommand = concommand
local gui = gui

if SERVER then
	hook.Add( "PlayerSay", "MidiChatCommands", function( ply, chat )
		if string.StartWith( chat, '/' ) or string.StartWith( chat, '!' ) then
			local command = (string.StartWith( chat, '/' ) and string.match( chat, "/(.*)" )) or (string.StartWith( chat, '!' ) and string.match( chat, "!(.*)" )) local beep = "money"
			
			if command == "midi auswahl" then
				ply:ConCommand( "OpenMidiGui" )
				return ""
			elseif command == "midi selection" then
				ply:ConCommand( "OpenMidiGui" )
				return ""
			elseif command == "midi" then
				ply:ConCommand( "MidiInfo" )
				return ""
			elseif command == "midi debug 1" then
				ply:ConCommand( "MidiDebugon" )
				return ""
			elseif command == "midi debug 0" then
				ply:ConCommand( "MidiDebugoff" )
				return ""
			else
			end
			
		end
	end )
end
			

if CLIENT then
		print("===========DerModMaster's MIDI===========")
		print("DerModMaster's MIDI-Init: Modul versucht zu initalisieren...|Trying to initalize...")
	if file.Exists("lua/bin/gmcl_midi_win32.dll", "MOD") or file.Exists("lua/bin/gmcl_midi_linux.dll", "MOD") then 
		print("DerModMaster's MIDI-Init: GMCL-Modul erkannt!|GMCL-Module detected!")
		require("midi") --Ab hier wird initlaisiert
		print("DerModMaster's MIDI-Init: Erfolgreich initlaisiert!|successfully initalized")
		
			concommand.Add("MidiInfo", function(ply, cmd, args) 
		chat.AddText(Color(0,255,0), "DerModMaster's MIDI:", Color(255,255,255), " Mit '!midi auswahl' kannst du das Gerät auswählen. Mit '!midi debug 1' aktivierst du den Debugmodus und mit 0 deaktivierst du ihn.")
		chat.AddText(Color(0,255,0), "DerModMaster's MIDI:", Color(255,255,255), " With '!midi selection' you can choose your device. With '!midi debug 1' you can activate the debug mode and with 0 you can deactivate it.")
	end)
		
		concommand.Add("OpenMidiGui", function(ply, cmd, args)
		if table.Count(midi.GetPorts()) > 0 then
						Derma_Query("Welches Gerät möchtest du benutzen?|Which device you would like to use?" ..(table.Count(midi.GetPorts()) > 3 and " (Es können nur maximal 3 Geräte gelistet werden!|Max. 3 devices)" or ""), --Interface
							"DerModMaster's MIDI: Geräte-Auswahl|Device selection",
							"Kein Gerät benutzen|Dont use a device",
							function() if midi.IsOpened() then midi.Close() end end,
							midi.GetPorts()[0] or nil,
							function() if midi.GetPorts()[0] then midi.Open(0) end end,
							midi.GetPorts()[1] or nil,
							function() if midi.GetPorts()[1] then midi.Open(1) end end,
							midi.GetPorts()[2] or nil,
							function() if midi.GetPorts()[2] then midi.Open(2) end end
							)
					else
						chat.AddText(Color(0,255,0), "DerModMaster's MIDI:", Color(255,0,0), " Es scheint so als könne kein MIDI Gerät gefunden werden.")
						chat.AddText(Color(0,255,0), "DerModMaster's MIDI:", Color(255,0,0), " Seems that we can't find a MIDI device.")
					end	
		end)
		
		concommand.Add("MidiDebugon", function(ply, cmd, args)
		hook.Add( 'PlayerSay', 'Mididebug', function( ply, text, teamChat, isDead )
		  if ( text == '!midi debug 1' ) then
		  hook.Add("MIDI", "print midi events", function(time, code, par1, par2, ...)
			print("DerModMaster's MIDI-Test:")
			-- The code is a byte (number between 0 and 254).
			print("MIDI EVENT", code, par1, par2, ...)
			print("Event Code:", midi.GetCommandCode(code))
			print("Event Channel:", midi.GetCommandChannel(code))
			print("Event Name:", midi.GetCommandName(code))

			-- The parameters of the code
			print("Parameter", par1, par2, ...)
		end)
					chat.AddText(Color(0,255,0), "DerModMaster's MIDI:", Color(100,200,200), " Debugmodus aktiviert | Debugmode activated")
				return true
		  end
	end )
		end)
		
		concommand.Add("MidiDebugoff", function(ply, cmd, args)
		hook.Add( 'PlayerSay', 'Mididebugdis', function( ply, text, teamChat, isDead )
		  if ( text == '!midi debug 0' ) then
		  hook.Remove("MIDI", "print midi events")
					chat.AddText(Color(0,255,0), "DerModMaster's MIDI:", Color(100,200,200), " Debugmodus deaktiviert | Debugmode deactivated")
				return true
		  end
	end )
		end)
		
		concommand.Add("MidiTest", function(ply, cmd, args)
		print("Dies ist ein Test! :)")
		end)
		
		concommand.Add("MidiTest2", function(ply, cmd, args)
		print("Dies ist ein Test! :)")
		end)
		
		
		print("DerModMaster's MIDI-Init: Versuche ein Gerät zu finden... | Try to find a device")
		if table.Count(midi.GetPorts()) > 0 then -- use table.Count here, the first index is 0
		print("DerModMaster's MIDI-Init: Gerät(e) gefunden. | found some devices")
					chat.AddText(Color(0,255,0), "DerModMaster's MIDI:", Color(255,255,255), " Erfolgreich initalisiert und Gerät(e) gefunden! Schreibe !midi in den Chat für mehr Infos!")
					chat.AddText(Color(0,255,0), "DerModMaster's MIDI:", Color(255,255,255), " Successfully initialized and device(s) found! Write !midi in the chat for more informations!")
				else 
						print ("DerModMaster's MIDI-Init: Es konnte kein Gerät gefunden werden.") 
						chat.AddText(Color(0,255,0), "DerModMaster's MIDI:", Color(255,0,0), " Modul konnte nicht initlaisiert werden! | Module can't be initalized.")
						chat.AddText(Color(0,255,0), "DerModMaster's MIDI:", Color(255,0,0), " Es konnte kein Gerät gefunden werden. | We can't find a compatible device.")
						print("===========DerModMaster's MIDI===========")
				return
						
			end
			
			print("Ist der Port geöffnet?|Port open?:", midi.IsOpened())
			print("Du kannst nun loslegen! Alles ist bereit ;) | Everything is ready ;)")
			print("DerModMaster's MIDI-Init: !midi auswahl")
			print("===========DerModMaster's MIDI===========")

			local MIDIKeys = {
				[36] = { Sound = "a1"  }, -- C
				[37] = { Sound = "b1"  },
				[38] = { Sound = "a2"  },
				[39] = { Sound = "b2"  },
				[40] = { Sound = "a3"  },
				[41] = { Sound = "a4"  },
				[42] = { Sound = "b3"  },
				[43] = { Sound = "a5"  },
				[44] = { Sound = "b4"  },
				[45] = { Sound = "a6"  },
				[46] = { Sound = "b5"  },
				[47] = { Sound = "a7"  },
				[48] = { Sound = "a8"  }, -- c
				[49] = { Sound = "b6"  },
				[50] = { Sound = "a9"  },
				[51] = { Sound = "b7"  },
				[52] = { Sound = "a10" },
				[53] = { Sound = "a11" },
				[54] = { Sound = "b8"  },
				[55] = { Sound = "a12" },
				[56] = { Sound = "b9"  },
				[57] = { Sound = "a13" },
				[58] = { Sound = "b10" },
				[59] = { Sound = "a14" },
				[60] = { Sound = "a15" }, -- c'
				[61] = { Sound = "b11" },
				[62] = { Sound = "a16" },
				[63] = { Sound = "b12" },
				[64] = { Sound = "a17" },
				[65] = { Sound = "a18" },
				[66] = { Sound = "b13" },
				[67] = { Sound = "a19" },
				[68] = { Sound = "b14" },
				[69] = { Sound = "a20" },
				[70] = { Sound = "b15" },
				[71] = { Sound = "a21" },
				[72] = { Sound = "a22" }, -- c''
				[73] = { Sound = "b16" },
				[74] = { Sound = "a23" },
				[75] = { Sound = "b17" },
				[76] = { Sound = "a24" },
				[77] = { Sound = "a25" },
				[78] = { Sound = "b18" },
				[79] = { Sound = "a26" },
				[80] = { Sound = "b19" },
				[81] = { Sound = "a27" },
				[82] = { Sound = "b20" },
				[83] = { Sound = "a28" },
				[84] = { Sound = "a29" }, -- c'''
				[85] = { Sound = "b21" },
				[86] = { Sound = "a30" },
				[87] = { Sound = "b22" },
				[88] = { Sound = "a31" },
				[89] = { Sound = "a32" },
				[90] = { Sound = "b23" },
				[91] = { Sound = "a33" },
				[92] = { Sound = "b24" },
				[93] = { Sound = "a34" },
				[94] = { Sound = "b25" },
				[95] = { Sound = "a35" },
				[96] = { Sound = "a36" }, -- c''''
			}

			hook.Add("MIDI", "playablePiano", function(time, command, note, velocity)
				local instrument = LocalPlayer().Instrument
				if !IsValid( instrument ) then return end

				-- Zero velocity NOTE_ON substitutes NOTE_OFF
				if !midi || midi.GetCommandName( command ) != "NOTE_ON" || velocity == 0 || !MIDIKeys || !MIDIKeys[note] then return end

				 instrument:OnRegisteredKeyPlayed(MIDIKeys[note].Sound)

				net.Start("InstrumentNetwork")
					net.WriteEntity(instrument)
					net.WriteInt(INSTNET_PLAY, 3)
					net.WriteString(MIDIKeys[note].Sound)
				net.SendToServer()
			end)
		
	else
		print("DerModMaster's MIDI-Init: Initalisierung gescheitert... | initialization failed...")
		print("DerModMaster's MIDI-Init: GMCL-Modul konnte nicht gefunden werden! | Can't find the GMCL-Module!")
		print("Du besitzt wohl das GMCL-Modul nicht. Falls du doch mit deinem Keyboard spielen willst, informiere dich doch einfach in der Addon Beschreibung!")
		print("Seems that you don't have the GMCL-Module. If you want to play with your keyboard, look at the addon-description!")
		print("===========DerModMaster's MIDI===========")
	end
end

--AC Test
