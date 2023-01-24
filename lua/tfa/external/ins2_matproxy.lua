-- "lua\\tfa\\external\\ins2_matproxy.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
if not matproxy then return end

matproxy.Add({
	name = "TFA_INS2_Scope", -- renamed proxy to avoid breaking SOME SIMILAR MOD on SOME BASE
	init = function(self, mat, values)
		self.RTMaterial = Material("!tfa_rtmaterial")
	end,
	bind = function(self, mat, ent)
		if not self.RTMaterial then
			self.RTMaterial = Material("!tfa_rtmaterial")
		end
		mat:SetTexture("$basetexture", self.RTMaterial:GetTexture("$basetexture"))
	end
})

matproxy.Add({
	name = "TFA_INS2_IronsightVectorResult",
	init = function(self, mat, values)
		self.resultVar = values.resultvar
		self.ResultDefault = Vector(values.resultdefault) -- original overreflective value
		self.ResultZoomed = Vector(values.resultzoomed) * .25
	end,
	bind = function(self, mat, ent)
		local ply = LocalPlayer()
		if IsValid(ply) then
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) and wep.CLIronSightsProgress then
				local newVector = LerpVector(math.Clamp(wep.CLIronSightsProgress, 0, 1), self.ResultDefault, self.ResultZoomed)
				mat:SetVector(self.resultVar, newVector)
			end
		end
	end
})

--[[matproxy.Add({
	name = "ScopeGeometry",
	init = function(self, mat, val)
		self.textureScrollVar = val.texturescrollvar

		self.scopeGeometry = val.scopegeometry
		self.scopeGeometryZoomed = val.scopegeometryzoomed

		self.textureScale = Vector(val.texturescale, val.texturescale, val.texturescale)
		self.textureScaleZoomed = Vector(val.texturescalezoomed, val.texturescalezoomed, val.texturescalezoomed)

		self.parallaxAngleX = val.parallaxanglex
		self.parallaxAngleY = val.parallaxangley

		self.parallaxExponent = val.parallaxexponent
	end,
	bind = function(self, mat, ent)
		local matrix = mat:GetMatrix(self.textureScrollVar)
		local ply = LocalPlayer()
		if matrix and IsValid(ply) then
			local wep = ply:GetActiveWeapon()
			if IsValid(wep) and wep.CLIronSightsProgress then
				local newScale = LerpVector(wep.CLIronSightsProgress, self.textureScale, self.textureScaleZoomed)
				matrix:SetScale(newScale)
				mat:SetMatrix(self.textureScrollVar, matrix)
			end
		end
	end
})]] -- soon i'll figure this out