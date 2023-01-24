-- "addons\\zlib-1.3\\lua\\autorun\\zlib_auto.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--[[
    zlib - Autorun
    Developed by Zephruz
]]

zlib = (zlib or {})
zlib._version = "v1.3.4e"
zlib._debugMode = false
zlib._upToDate = false
zlib._repositoryParameters = {
    version = "tag_name",
    downloadUrl = "html_url"
}

function zlib:ConsoleMessage(...)
    MsgC(Color(125,255,0), "[zlib] ", Color(255,255,255), ...)
    Msg("\n")

    return true
end

function zlib:DebugMessage(...)
    if !(self._debugMode) then 
        return false 
    end

    return self:ConsoleMessage("", Color(255,127,80), "[debug] ", Color(255,255,255), ...)
end

function zlib:GetRepositoryInfo(cb)
    return 
        self.http:JSONFetch("https://api.github.com/repos/zephruz/zlib/releases/latest", 
        function(body)
            local data = {}

            for k,v in pairs(body) do
                if (table.HasValue(self._repositoryParameters, k)) then
                    data[k] = v
                end
            end

            if (cb) then cb(data) end
        end,
        function(data)
            if (cb) then cb(false) end
        end) == true
    
end

function zlib:Load()
    if !(IsValid(self)) then self = zlib end

    AddCSLuaFile("zlib/sh_init.lua")
    include("zlib/sh_init.lua")

    timer.Create("zlib_fetch_repo", 5, 1, 
    function()
        if (SERVER) then
            self:ConsoleMessage("Fetching repository information to compare versions...")

            local repoResult = self:GetRepositoryInfo(
                function(data)
                    if !(data) then return end

                    local version, url
                    version = data[self._repositoryParameters.version]
                    url = data[self._repositoryParameters.downloadUrl]

                    if (version != nil) then
                        if (version != self._version) then
                            url = (url != nil && url || "https://github.com/zephruz/zlib/releases")

                            self:ConsoleMessage(Color(255,125,25), string.format("ZLib is not up to date (yours: %s | new: %s), please download the latest version from %s.", zlib._version, version, url))
                        else
                            self._upToDate = true
                            self:ConsoleMessage(string.format("[%s] ZLib is up to date!", self._version))
                        end
                    else
                        self:ConsoleMessage("Unable to determine zlib verison, please verify you're up to date here: https://github.com/zephruz/zlib/releases")
                    end
                end
            ) 
        
            if !(repoResult) then
                self:DebugMessage("Failed to fetch ZLib repository info!")
            end
        end
    end)

    self:ConsoleMessage("Loaded successfully!")

    hook.Run("zlib.Loaded", self)
end
concommand.Add("zlib_reload", zlib.Load)

zlib:Load()