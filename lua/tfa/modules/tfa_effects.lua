-- "lua\\tfa\\modules\\tfa_effects.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
TFA.Effects = TFA.Effects or {}
local Effects = TFA.Effects

Effects.Overrides = Effects.Overrides or {}
local Overrides = Effects.Overrides

function Effects.AddOverride(target, override)
	assert(type(target) == "string", "No target effect name or not a string")
	assert(type(override) == "string", "No override effect name or not a string")

	Overrides[target] = override
end

function Effects.GetOverride(target)
	if Overrides[target] then
		return Overrides[target]
	end

	return target
end

local util_Effect = util.Effect

function Effects.Create(effectName, effectData, allowOverride, ignorePredictionOrRecipientFilter)
	effectName = Effects.GetOverride(effectName)

	util_Effect(effectName, effectData, allowOverride, ignorePredictionOrRecipientFilter)
end

if SERVER then
	AddCSLuaFile("tfa/muzzleflash_base.lua")
end
