-- "lua\\weapons\\tfa_gun_base\\common\\skins.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
SWEP.MaterialTable = {}
SWEP.MaterialTable_V = {}
SWEP.MaterialTable_W = {}

function SWEP:InitializeMaterialTable()
	if not self.HasSetMaterialMeta then
		setmetatable(self.MaterialTable_V, {
			["__index"] = function(t,k) return self:GetStatL("MaterialTable")[k] end
		})

		setmetatable(self.MaterialTable_W, {
			["__index"] = function(t,k) return self:GetStatL("MaterialTable")[k] end
		})

		self.HasSetMaterialMeta = true
	end
end

--if both nil then we can just clear it all
function SWEP:ClearMaterialCache(view, world)
	if view == nil and world == nil then
		self.MaterialCached_V = nil
		self.MaterialCached_W = nil
		self.MaterialCached = nil
		self.SCKMaterialCached_V = nil
		self.SCKMaterialCached_W = nil
	else
		if view then
			self.MaterialCached_V = nil
			self.SCKMaterialCached_V = nil
		end

		if world then
			self.MaterialCached_W = nil
			self.SCKMaterialCached_W = nil
		end
	end
end
