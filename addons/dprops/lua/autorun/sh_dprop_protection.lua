-- "addons\\dprops\\lua\\autorun\\sh_dprop_protection.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
DPROP = DPROP or {}
function DPROP.GetOwner(ent) 
	local owner, _ = ent:CPPIGetOwner() or ent.FPPOwner or ent.dprop_owner or nil
    return owner
end 