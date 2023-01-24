-- "addons\\controllable_city_scanner\\lua\\controllable_scanner\\sh_hook_override.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
hook.Add("PostGamemodeLoaded", "ControllableScanner.HookOverride", function()
    ControllableScanner.overriddenHooks = {}
    ControllableScanner.hookBackups = {}

    ControllableScanner.RealHookAdd = ControllableScanner.RealHookAdd or hook.Add
    ControllableScanner.RealHookRemove = ControllableScanner.RealHookRemove or hook.Remove
    
    --hook.Add reroute
    function hook.Add(...)
        local eventName, identifier, Func = ...
        
        if ControllableScanner.overriddenHooks[eventName] then
            ControllableScanner.hookBackups[eventName][identifier] = Func
        else
            return ControllableScanner.RealHookAdd(...)
        end
    end
    
    --hook.Remove reroute
    function hook.Remove(...)
        local eventName, identifier = ...
        
        if ControllableScanner.overriddenHooks[eventName] then
            ControllableScanner.hookBackups[eventName][identifier] = nil
        else
            return ControllableScanner.RealHookRemove(...)
        end
    end
    
    if ControllableScanner.ConVarFixConflicts() then
        --Add a function to a hook and surpress all other functions in that hook
        function ControllableScanner.AddOverrideHook(eventName, identifier, Func)
            ControllableScanner.overriddenHooks[eventName] = Func
            ControllableScanner.hookBackups[eventName] = {}
            
            for eventName2, funcs in pairs(hook.GetTable()) do
                if eventName2 == eventName then
                    for identifier2, Func2 in pairs(funcs) do
                        ControllableScanner.hookBackups[eventName][identifier2] = Func2
                        
                        ControllableScanner.RealHookRemove(eventName, identifier2)
                    end
                end
            end
            
            ControllableScanner.RealHookAdd(eventName, identifier, Func)
        end
        
        --Remove a hook override
        function ControllableScanner.RemoveOverrideHook(eventName, identifier)
            ControllableScanner.overriddenHooks[eventName] = nil
            
            for eventName2, funcs in pairs(ControllableScanner.hookBackups) do
                if eventName2 == eventName then
                    for identifier2, Func2 in pairs(funcs) do
                        ControllableScanner.RealHookAdd(eventName, identifier2, Func2)
                    end
                end
            end
            
            ControllableScanner.hookBackups[eventName] = nil
            
            ControllableScanner.RealHookRemove(eventName, identifier)
        end
    else
        --These just use hook.Add and hook.Remove since command controllable_manhack_fixconflicts is off
        
        function ControllableScanner.AddOverrideHook(eventName, identifier, Func)
            ControllableScanner.RealHookAdd(eventName, identifier, Func)
        end
        
        function ControllableScanner.RemoveOverrideHook(eventName, identifier)
            ControllableScanner.RealHookRemove(eventName, identifier)
        end
    end
end)
