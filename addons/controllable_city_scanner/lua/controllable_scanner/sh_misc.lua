-- "addons\\controllable_city_scanner\\lua\\controllable_scanner\\sh_misc.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

ControllableScanner.manhackEntityClassName = "sent_controllable_scanner"
ControllableScanner.manhackWeaponClassName = "weapon_controllable_city_scanner"
ControllableScanner.manhackAmmoName = "controllable_manhack"

function ControllableScanner.IsViewModelValidAfterDelay(swep, viewModel)
	return IsValid(swep) and IsValid(swep.Owner) and swep.Owner:Alive() and IsValid(swep.Owner:GetActiveWeapon()) and swep.Owner:GetActiveWeapon():GetClass() == ControllableScanner.manhackWeaponClassName and IsValid(viewModel)
end

--Get the surface property of a model
function ControllableScanner.UtilGetSurfaceProperty(model)
	local modelInfo = util.GetModelInfo(model)
	
	if modelInfo and modelInfo.KeyValues then
		local keyValues = util.KeyValuesToTable(modelInfo.KeyValues)
		
	 	if keyValues and keyValues.solid and keyValues.solid.surfaceprop then
			return keyValues.solid.surfaceprop
		end
	end
end

function ControllableScanner.IsPlayerGrounded(ply)
	local trace = util.TraceHull({
		start = ply:GetPos(),
		endpos = ply:GetPos(),
		maxs = ply:OBBMaxs(),
		mins = ply:OBBMins() + Vector(0, 0, -2),
		filter = ply
	})
	
	return trace.Hit
end

function ControllableScanner.OneOrZero(bool)
	return bool and 1 or 0
end
