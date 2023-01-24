-- "lua\\entities\\tfa_thrown_blade\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "anim"
ENT.PrintName = "Thrown Blade"
ENT.Author = ""
ENT.Contact = ""
ENT.Purpose = ""
ENT.Instructions = ""
ENT.DoNotDuplicate = true

ENT.HitSounds = {
	[MAT_DIRT] = {Sound("physics/metal/metal_grenade_impact_hard1.wav"), Sound("physics/metal/metal_grenade_impact_hard2.wav"), Sound("physics/metal/metal_grenade_impact_hard3.wav")},
	[MAT_FLESH] = {Sound("physics/flesh/flesh_impact_bullet1.wav"), Sound("physics/flesh/flesh_impact_bullet2.wav"), Sound("physics/flesh/flesh_impact_bullet3.wav")}
}

ENT.ImpactSound = Sound("weapons/blades/impact.mp3")