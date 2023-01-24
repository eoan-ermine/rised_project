-- "addons\\anvanced_hands\\lua\\autorun\\surrender.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local meta = FindMetaTable( 'Player' )
if not meta then Error( 'Failed to find player metatable' ) end

local animTable = {
    ["surrender"] = {
        ['ValveBiped.Bip01_Pelvis'] = { pos = Vector(0, 0, -23) },

        ['ValveBiped.Bip01_R_Calf'] = { ang = Angle( 0, 120, 0 ) },
        ['ValveBiped.Bip01_L_Calf'] = { ang = Angle( 0, 120, 0 ) },

        ['ValveBiped.Bip01_R_Thigh'] = { ang = Angle( 0, -30, 0 ) },
        ['ValveBiped.Bip01_L_Thigh'] = { ang = Angle( 0, -30, 0 ) },

        ['ValveBiped.Bip01_R_Foot'] = { ang = Angle( 0, 30, 0 ) },
        ['ValveBiped.Bip01_L_Foot'] = { ang = Angle( 0, 30, 0 ) },

        ['ValveBiped.Bip01_R_UpperArm'] = { ang = Angle( 30, 0, 90 ) },
        ['ValveBiped.Bip01_L_UpperArm'] = { ang = Angle( -30, 0, -90 ) },

        ['ValveBiped.Bip01_R_ForeArm'] = { ang = Angle( 0, -130, 0 ) },
        ['ValveBiped.Bip01_L_ForeArm'] = { ang = Angle(0, -120, 20 ) }
    } 
}
function meta:ResetBones()
    local bonecount = self:GetBoneCount()
    for i = 0, bonecount do
        self:ManipulateBonePosition( i, Vector( 0, 0, 0 ) )
        self:ManipulateBoneAngles( i, Angle( 0, 0, 0 ) )
    end
end

function meta:Surrender()
    for bone, params in pairs( animTable['surrender'] ) do
        local boneid = self:LookupBone( bone )
        if boneid then
            self:ManipulateBonePosition( boneid, params.pos or Vector( 0, 0, 0 ) )
            self:ManipulateBoneAngles( boneid, params.ang or Angle( 0, 0, 0 ) )
        end
    end
end


concommand.Add( "surrender", function( ply )
    ply:Surrender()
end )


concommand.Add( "resetanims", function ( ply )
  ply:ResetBones()
end )
