-- "lua\\autorun\\client_animation.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

hook.Add( "OnPlayerChat", "HelloCommand", function( ply, strText, bTeam, bDead )
    if ply:IsPlayer() then
        if GAMEMODE.CombineJobs[ply:Team()] then
            strText = string.lower( strText )
            local combine_anim = {
                ["Укрыться!"]   = "signal_takecover",
                ["Направо!"]    = "signal_right",
                ["Налево!"]     = "signal_left",
                ["Стоять!"]     = "signal_halt",
                ["Группа!"]     = "signal_group",
                ["Вперед!"]     = "signal_forward",
                ["Наступать!"]    = "signal_advance",
            }
            if combine_anim[strText] != nil then
                local seq = ply:LookupSequence(combine_anim[strText])
                ply:AddVCDSequenceToGestureSlot( GESTURE_SLOT_VCD, seq, 0, true )
            end
        end
    end
end )