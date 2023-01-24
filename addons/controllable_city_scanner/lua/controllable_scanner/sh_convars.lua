-- "addons\\controllable_city_scanner\\lua\\controllable_scanner\\sh_convars.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal

ControllableScanner.conVarPrefix = "controllable_manhack_"

function ControllableScanner.CreateConvar(...)
    local convarTable = ...
    
    CreateConVar(ControllableScanner.conVarPrefix .. convarTable.convarName, convarTable.value, convarTable.flags, convarTable.helpText)
    
    ControllableScanner["ConVar" .. convarTable.functionName] = function()
        local conVar = GetConVar(ControllableScanner.conVarPrefix .. convarTable.convarName)
        
        return  conVar["Get" .. convarTable.type](conVar)
    end
end

ControllableScanner.CreateConvar{
    convarName = "ammoinfinite",
    functionName = "AmmoInfinite",
    type = "Bool",
    value = 0,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Enable infinite ammo"
}

ControllableScanner.CreateConvar{
    convarName = "ammoamount",
    functionName = "AmmoAmount",
    type = "Int",
    value = 3,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Amount of ammo you start with"
}

ControllableScanner.CreateConvar{
    convarName = "ammoretrieve",
    functionName = "AmmoRetrieve",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Enable getting ammo back when retrieving a manhack"
}

ControllableScanner.CreateConvar{
    convarName = "selfdestructdeath",
    functionName = "SelfDestructDeath",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Enable self destructing when owner dies"
}

ControllableScanner.CreateConvar{
    convarName = "selfdestructexplosion",
    functionName = "SelfDestructExplosion",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Enable explosion when a manhack selfdestructs"
}

ControllableScanner.CreateConvar{
    convarName = "selfdestructinstant",
    functionName = "SelfDestructInstant",
    type = "Bool",
    value = 0,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Enable instant self destructing"
}

ControllableScanner.CreateConvar{
    convarName = "haterebel",
    functionName = "HateRebel",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Enable rebels hating controllable manhacks by default"
}

ControllableScanner.CreateConvar{
    convarName = "hatecombine",
    functionName = "HateCombine",
    type = "Bool",
    value = 0,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Enable combines hating controllable manhacks by default"
}

ControllableScanner.CreateConvar{
    convarName = "hudoverlay",
    functionName = "HUDOverlay",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Enable red overlay when controlling a manhack"
}

ControllableScanner.CreateConvar{
    convarName = "hudtargets",
    functionName = "HUDTargets",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Enable HUD targets when controlling a manhack"
}

ControllableScanner.CreateConvar{
    convarName = "hudtexts",
    functionName = "HUDTexts",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Enable HUD texts when controlling a manhack"
}

ControllableScanner.CreateConvar{
    convarName = "thirdpersonallowed",
    functionName = "ThirdPersonAllowed",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Allow third person when controlling a manhack"
}

ControllableScanner.CreateConvar{
    convarName = "thirdpersonhud",
    functionName = "ThirdPersonHUD",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Show HUD texts in third person"
}

ControllableScanner.CreateConvar{
    convarName = "retrieveallowed",
    functionName = "RetrieveAllowed",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Allow players to retrieve their manhack with the use key"
}

ControllableScanner.CreateConvar{
    convarName = "collideuse",
    functionName = "CollideUse",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Enable manhacks to use buttons, doors, etc by hitting them"
}

ControllableScanner.CreateConvar{
    convarName = "bladesound",
    functionName = "BladeSound",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Enable annoying blade loop sound"
}

ControllableScanner.CreateConvar{
    convarName = "multiglowcolor",
    functionName = "MultiGlowColor",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Enable different glow colors for the different manhack states"
}

ControllableScanner.CreateConvar{
    convarName = "health",
    functionName = "Health",
    type = "Int",
    value = 50,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Amount of health that controllable manhacks spawn with"
}

ControllableScanner.CreateConvar{
    convarName = "collideusewhitelist",
    functionName = "CollideUseWhitelist",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Enable whitelist (defined in a Lua file) of entities that can be used by hitting them with the manhack"
}

ControllableScanner.CreateConvar{
    convarName = "fixconflicts",
    functionName = "FixConflicts",
    type = "Bool",
    value = 1,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Fix various conflicts with addons. Turn this off if you are getting errors or having problems (requires restart)"
}

ControllableScanner.CreateConvar{
    convarName = "hideheadmodel",
    functionName = "HideHeadModel",
    type = "Bool",
    value = 0,
    flags = FCVAR_ARCHIVE + FCVAR_REPLICATED,
    helpText = "Hides the model on the head when controlling a manhack, and changes the idle animation."
}
