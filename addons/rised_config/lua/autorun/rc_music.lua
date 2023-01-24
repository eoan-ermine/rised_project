-- "addons\\rised_config\\lua\\autorun\\rc_music.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if RISED == null then
	RISED = {}
	if RISED.Config == null then
		RISED.Config = {}
	end
end

----------========== Музыка ==========----------
RISED.Config.Music = {}

RISED.Config.InCombat = false
RISED.Config.CombatResetDelay = 25

RISED.Config.Music.Initial = {
	"music/hl2_song30.mp3",
	"music/hl2_song27_trainstation2.mp3",
	"music/hl2_song26_trainstation1.mp3",
	"music/hl2_song2.mp3",
	"music/hl2_song19.mp3",
	"music/hl2_song1.mp3"
}

RISED.Config.Music.Ambient = {
	{
		["SoundPath"] = "rised/music/ambient/valve - b3pbibonachoctb.mp3",
		["SoundDuration"] = 222
	},
	{
		["SoundPath"] = "rised/music/ambient/valve - extra-dimensional darkness.mp3",
		["SoundDuration"] = 414
	},
	{
		["SoundPath"] = "rised/music/ambient/valve - i love this gun.mp3",
		["SoundDuration"] = 453
	},
	{
		["SoundPath"] = "rised/music/ambient/valve - overload protocol.mp3",
		["SoundDuration"] = 193
	},
	{
		["SoundPath"] = "music/hl2_song30.mp3",
		["SoundDuration"] = 86,4
	},
	{
		["SoundPath"] = "music/hl2_song27_trainstation2.mp3",
		["SoundDuration"] = 67,2
	},
	{
		["SoundPath"] = "music/hl2_song26_trainstation1.mp3",
		["SoundDuration"] = 78,6
	},
	{
		["SoundPath"] = "music/hl2_song2.mp3",
		["SoundDuration"] = 151,8
	},
	{
		["SoundPath"] = "music/hl2_song17.mp3",
		["SoundDuration"] = 60,6
	},
	{
		["SoundPath"] = "music/hl2_song13.mp3",
		["SoundDuration"] = 32,4
	},
	{
		["SoundPath"] = "music/hl2_song10.mp3",
		["SoundDuration"] = 29
	},
	{
		["SoundPath"] = "music/hl2_song1.mp3",
		["SoundDuration"] = 82,8
	},
	{
		["SoundPath"] = "music/hl2_song0.mp3",
		["SoundDuration"] = 40
	},
	{
		["SoundPath"] = "music/hl1_song9.mp3",
		["SoundDuration"] = 79,8
	},
	{
		["SoundPath"] = "music/hl1_song26.mp3",
		["SoundDuration"] = 38
	},
	{
		["SoundPath"] = "music/hl1_song24.mp3",
		["SoundDuration"] = 70,2
	},
	{
		["SoundPath"] = "music/hl1_song20.mp3",
		["SoundDuration"] = 75
	},
	{
		["SoundPath"] = "music/hl1_song19.mp3",
		["SoundDuration"] = 93,6
	},
	{
		["SoundPath"] = "music/hl1_song14.mp3",
		["SoundDuration"] = 78
	},
	{
		["SoundPath"] = "music/hl2_song7.mp3",
		["SoundDuration"] = 51
	},
	{
		["SoundPath"] = "music/hl2_song8.mp3",
		["SoundDuration"] = 60
	},
	{
		["SoundPath"] = "music/hl2_song33.mp3",
		["SoundDuration"] = 74,4
	},
	{
		["SoundPath"] = "music/hl2_song32.mp3",
		["SoundDuration"] = 43
	},
	{
		["SoundPath"] = "music/hl2_song11.mp3",
		["SoundDuration"] = 35
	},
	{
		["SoundPath"] = "music/hl1_song6.mp3",
		["SoundDuration"] = 45
	},
	{
		["SoundPath"] = "music/hl2_song11.mp3",
		["SoundDuration"] = 35
	},
	{
		["SoundPath"] = "music/hl1_song5.mp3",
		["SoundDuration"] = 81,6
	},
	{
		["SoundPath"] = "music/hl1_song3.mp3",
		["SoundDuration"] = 127,2
	},
	{
		["SoundPath"] = "music/hl1_song21.mp3",
		["SoundDuration"] = 75
	},
}

RISED.Config.Music.Combat = {
	{
		["SoundPath"] = "rised/music/combat/valve - anti-citizen.mp3",
		["SoundDuration"] = 187
	},
	{
		["SoundPath"] = "rised/music/combat/valve - cauterizer.mp3",
		["SoundDuration"] = 285
	},
	{
		["SoundPath"] = "rised/music/combat/valve - outbreak is uncontained.mp3",
		["SoundDuration"] = 243
	},
	{
		["SoundPath"] = "rised/music/combat/valve - scanning hostile biodats.mp3",
		["SoundDuration"] = 152
	},
	{
		["SoundPath"] = "music/hl1_song10.mp3",
		["SoundDuration"] = 87
	},
	{
		["SoundPath"] = "music/hl2_song4.mp3",
		["SoundDuration"] = 60
	},
	{
		["SoundPath"] = "music/hl2_song31.mp3",
		["SoundDuration"] = 83,4
	},
	{
		["SoundPath"] = "music/hl2_song3.mp3",
		["SoundDuration"] = 78,6
	},
	{
		["SoundPath"] = "music/hl2_song29.mp3",
		["SoundDuration"] = 129,6
	},
	{
		["SoundPath"] = "music/hl2_song16.mp3",
		["SoundDuration"] = 150
	},
	{
		["SoundPath"] = "music/hl2_song20_submix4.mp3",
		["SoundDuration"] = 132
	},
	{
		["SoundPath"] = "music/hl2_song15.mp3",
		["SoundDuration"] = 65,4
	},
	{
		["SoundPath"] = "music/hl2_song14.mp3",
		["SoundDuration"] = 143,4
	},
	{
		["SoundPath"] = "music/hl2_song12_long.mp3",
		["SoundDuration"] = 67,8
	},
}