-- "addons\\midi_setter\\lua\\autorun\\midichat.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if SERVER then
	AddCSLuaFile("autorun/midichat.lua")
end

if CLIENT then
	print( "MIDI V1.0.27" )
end

MidiSay = {} --Start

MidiSay.WordList = {
["mbatman"] = "miditaunts/batman.mp3";
["mcentury"] = "miditaunts/century.mp3";
["mgay"] = "miditaunts/gay.mp3";
["mhyper"] = "miditaunts/gethyper.mp3";
["mfuck yeah"] = "miditaunts/imcool.mp3";
["minception"] = "miditaunts/inception.mp3";
["mception"] = "miditaunts/inceptionlang.mp3";
["mverloren"] = "miditaunts/lose.mp3";
["mzirpen"] = "miditaunts/zirpen.mp3";
["mcrazy"] = "miditaunts/crazy.mp3";
["msax"] = "miditaunts/dew_dew_dew.mp3";
["mdrop1"] = "miditaunts/drop.mp3";
["mdrop2"] = "miditaunts/tsunami.mp3";
["mdrop3"] = "miditaunts/oilspill.mp3";
["mmlg"] = "miditaunts/mlg.mp3";
["mfalldown"] = "miditaunts/falldown.mp3";
["mjihad"] = "miditaunts/jihad.mp3";
["mhit"] = "miditaunts/mlghit.wav";
}
function MidiSay.ChatFunction( ply, text )
   if ply:IsValid() then
      for k,v in pairs(MidiSay.WordList) do
         if string.find( text, k ) then
ply:EmitSound(MidiSay.WordList[k])
			return ""
         end
      end
   end
end
hook.Add("PlayerSay", "MidiSay.ChatFunction_Hook", MidiSay.ChatFunction) --Ende