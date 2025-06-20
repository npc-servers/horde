GADGET.PrintName = "Aerial Turret"
GADGET.Description = "Deploys a temporary aerial turret.\nTurret is destroyed when duration expires."
GADGET.Icon = "items/gadgets/turret_pack.png"
GADGET.Duration = 20
GADGET.Cooldown = 30
GADGET.Active = true
GADGET.Params = {
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_aerial_turret" then return end
    -- Refer to gadget_turret_pack to restore this code
end
