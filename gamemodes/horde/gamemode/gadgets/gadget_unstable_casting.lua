GADGET.PrintName = "Unstable Casting"
GADGET.Description = "You can cast without holding down the walk button \nand {1} increased Slashing and Blunt damage."
GADGET.Icon = "items/gadgets/blast_plating.png"
GADGET.Duration = 0
GADGET.Cooldown = 10
GADGET.Params = {
    [1] = { value = 0.05, percent = true },
}
GADGET.Hooks = {}

GADGET.Hooks.Horde_OnPlayerDamage = function( ply, _, bonus, _, dmginfo )
    if ply:Horde_GetGadget() ~= "gadget_unstable_casting" then return end
    if not HORDE:IsPhysicalDamage( dmginfo ) then return end

    bonus.increase = bonus.increase + 0.05
end