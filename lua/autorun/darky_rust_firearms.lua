-- "lua\\autorun\\darky_rust_firearms.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not DARKY_RUST then DARKY_RUST = {} end

DARKY_RUST.firearms = true

local gunshots = file.Find( "sound/weapons/rust_distant/*", "GAME" )
local mp3s = file.Find( "sound/weapons/rust_mp3/*.mp3", "GAME" )
local wavs = file.Find( "sound/weapons/rust/*.wav", "GAME" )

for i=1, #mp3s do
    local snd = string.sub(mp3s[i],1,-5)
    sound.Add(
        {
            name = "darky_rust."..snd,
            channel = CHAN_STATIC,
            volume = 1.0,
            soundlevel = 180,
            sound = "weapons/rust_mp3/"..snd..".mp3"
        }
    )	
end

for i=1, #wavs do
    local snd = string.sub(wavs[i],1,-5)
    sound.Add(
        {
            name = "darky_rust."..snd,
            channel = CHAN_STATIC,
            volume = 1.0,
            soundlevel = 180,
            sound = "weapons/rust/"..snd..".wav"
        }
    )	
end

for i=1, #gunshots do
    local snd = string.sub(gunshots[i],1,-5)
    sound.Add(
        {
            name = "darky_rust."..snd,
            channel = CHAN_STATIC,
            volume = 15.0,
            soundlevel = 511,
            sound = "^weapons/rust_distant/"..snd..".mp3"
        }
    )	
end