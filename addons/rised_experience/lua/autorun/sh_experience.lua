-- "addons\\rised_experience\\lua\\autorun\\sh_experience.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
function GetLevelByExp(player_exp)
    return player_exp / 100
end

function GetNextLevelTotalExp(player_exp)
    return player_exp * 100
end

function LevelCheck(ply, lvl, type)
    return (ply["Player_Level"..type] or 0) >= lvl
end