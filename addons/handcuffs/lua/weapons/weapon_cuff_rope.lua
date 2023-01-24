-- "addons\\handcuffs\\lua\\weapons\\weapon_cuff_rope.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal


AddCSLuaFile()

SWEP.Base = "weapon_cuff_base"

SWEP.Category = "Handcuffs"
SWEP.Author = "my_hat_stinks"
SWEP.Instructions = "A weak restraint."

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.AdminSpawnable = true

SWEP.Slot = 3
SWEP.PrintName = "Rope Restraint"

//
// Handcuff Vars
SWEP.CuffTime = 0.8 // Seconds to handcuff
SWEP.CuffSound = Sound( "buttons/lever7.wav" )

SWEP.CuffMaterial = "models/props_foliage/tree_deciduous_01a_trunk"
SWEP.CuffRope = "cable/rope"
SWEP.CuffStrength = 0.85
SWEP.CuffRegen = 0.8
SWEP.RopeLength = 100
SWEP.CuffReusable = false

SWEP.CuffBlindfold = true
SWEP.CuffGag = true

SWEP.CuffStrengthVariance = 0.1 // Randomise strangth
SWEP.CuffRegenVariance = 0.2 // Randomise regen
