-- "addons\\rised_sounds\\lua\\autorun\\client\\rs_sounds_client.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
net.Receive("Rised_Sounds:Client", function()
    local path = net.ReadString()
    surface.PlaySound(path)
end)