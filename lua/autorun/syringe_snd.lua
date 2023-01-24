-- "lua\\autorun\\syringe_snd.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
game.AddAmmoType({name = "Syringes", dmgtype = DMG_DIRECT})

if CLIENT then
    language.Add("Syringes_ammo", "Syringe")
end

if not istable(DARKY_RUST) then
	local mp3s = file.Find("sound/weapons/rust_mp3/*.mp3", "GAME")

	for i=1, #mp3s do
		local snd = string.sub(mp3s[i], 1, -5)
	    sound.Add({
            name = "darky_rust." .. snd,
            channel = CHAN_STATIC,
            volume = 1.0,
            soundlevel = 180,
            sound = "weapons/rust_mp3/" .. snd .. ".mp3"
        })
	end
end