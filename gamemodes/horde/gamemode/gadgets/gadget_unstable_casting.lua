GADGET.PrintName = "Unstable Casting"
GADGET.Description = "..."
GADGET.Icon = "items/gadgets/blast_plating.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Params = {}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamage = function( ply, _, bonus, _, dmginfo )
    if ply:Horde_GetGadget() ~= "gadget_unstable_casting" then return end
    if not HORDE:IsPhysicalDamage( dmginfo ) then return end

    bonus.increase = bonus.increase + 0.1
end