ENT.Type = "anim"
ENT.Base = "base_anim"

if SERVER then
    util.AddNetworkString("PrintSkullNotify")
end

if CLIENT then
    net.Receive("PrintSkullNotify", function ()
        chat.AddText(Color(255,0,255), "You found a skull token!")
    end)
end
