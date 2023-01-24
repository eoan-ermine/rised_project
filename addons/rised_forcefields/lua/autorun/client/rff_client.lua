-- "addons\\rised_forcefields\\lua\\autorun\\client\\rff_client.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
timer.Create("forcefieldUpdater", 250, 0, function()
	for k, v in pairs(ents.FindByClass("rised_forcefield")) do
		if (IsValid(v:GetDTEntity(0))) then
			local startPos = v:GetDTEntity(0):GetPos() - Vector(0, 0, 50)
			local verts = {
				{pos = Vector(0, 0, -35)},
				{pos = Vector(0, 0, 150)},
				{pos = v:WorldToLocal(startPos) + Vector(0, 0, 150)},
				{pos = v:WorldToLocal(startPos) + Vector(0, 0, 150)},
				{pos = v:WorldToLocal(startPos) - Vector(0, 0, 35)},
				{pos = Vector(0, 0, -35)},
			}

			v:PhysicsFromMesh(verts)
			v:EnableCustomCollisions(true)
			v:GetPhysicsObject():EnableCollisions(false)
		end
	end
end)

local function RisedFields_Print( data )
	local text = data:ReadString()
	chat.AddText( Color( 255, 165, 0 ), "[Rised Forcefields]", color_white, ": " .. text )
end

usermessage.Hook( "tool_forcefield_print", RisedFields_Print )