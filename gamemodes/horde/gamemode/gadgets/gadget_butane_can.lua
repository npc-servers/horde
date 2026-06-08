GADGET.PrintName = "Butane Can"
GADGET.Description = "Drops a Butane Can that explodes when shot or when an enemy gets near.\nExplosion deals {1} Blast damage when shot or {2} Fire damage when an Enemy triggers it.\nup to 3 Butane Cans can be spawned at a time.\nleaves behind a small pool of fire.\nhas 3 charges that regenerate after 7 seconds when a can detonates."
GADGET.Icon = "items/gadgets/butane_can.png"
--GADGET.Duration = 0
--GADGET.Cooldown = 20
GADGET.Duration = 0
GADGET.Cooldown = 0.5
GADGET.Charges = 3
GADGET.Active = true
GADGET.Params = {
    [1] = { value = 200 },
    [2] = { value = 375 },
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_UseActiveGadget = function (ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_butane_can" then return end
       if not ply.Horde_Butane_Cans then ply.Horde_Butane_Cans = {} end
    if ply:Horde_GetGadgetCharges() <= 0 then return end
    if ply:Horde_GetGadgetCharges() == 3 then
        ply.Horde_Butane_Cans = {}
    end
    local ent = ents.Create("horde_butane_can")
    local pos = ply:EyePos()
    local dir = ply:GetAimVector()
    local drop_pos = pos + dir * 50
    drop_pos.z = pos.z
    ent:SetPos(drop_pos)
    ent.Horde_Owner = ply
    ent:SetAngles(Angle(0, ply:GetAngles().y, 0))
    ent:Spawn()
        table.insert( ply.Horde_Butane_Cans, ent )
    ply:Horde_SetGadgetCharges( ply:Horde_GetGadgetCharges() - 1 )
end


GADGET.Hooks.Horde_OnSetGadget = function ( ply, gadget )
    if CLIENT or gadget ~= "gadget_butane_can" then return end
    if not ply.Horde_Butane_Cans then ply.Horde_Butane_Cans = {} end
    ply:Horde_SetGadgetCharges( 3 )
end

GADGET.Hooks.Horde_OnUnsetGadget = function ( ply, gadget )
    if CLIENT or gadget ~= "gadget_butane_can" then return end
    if ( not ply.Horde_Butane_Cans ) or table.IsEmpty( ply.Horde_Butane_Cans ) then return end
    for _, cans in pairs( ply.Horde_Butane_Cans ) do
        if cans:IsValid() then
            cans:Detonate()
        end
    end
end