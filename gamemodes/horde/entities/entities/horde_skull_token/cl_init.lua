include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

ENT.ColorModulation = Color(1, 0, 1)

if CLIENT then
    net.Receive("PrintSkullNotify", function ()
        chat.AddText(Color(255,0,255), "You found a skull token!")
    end)
end
