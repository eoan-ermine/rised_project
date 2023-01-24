-- "addons\\handcuffs\\lua\\weapons\\weapon_cuff_shackles.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal


AddCSLuaFile()

SWEP.Base = "weapon_cuff_base"

SWEP.Category = "Handcuffs"
SWEP.Author = "my_hat_stinks"
SWEP.Instructions = "Strong metal shackles."

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.AdminSpawnable = true

SWEP.Slot = 3
SWEP.PrintName = "Shackles"

//
// Handcuff Vars
SWEP.CuffTime = 1.0 // Seconds to handcuff
SWEP.CuffSound = Sound( "buttons/lever7.wav" )

SWEP.CuffMaterial = "phoenix_storms/cube"
SWEP.CuffRope = "cable/cable2"
SWEP.CuffStrength = 1.4
SWEP.CuffRegen = 0.8
SWEP.RopeLength = 0
SWEP.CuffReusable = false

SWEP.CuffBlindfold = false
SWEP.CuffGag = false

SWEP.CuffStrengthVariance = 0.4 // Randomise strangth
SWEP.CuffRegenVariance = 0.1 // Randomise regen
