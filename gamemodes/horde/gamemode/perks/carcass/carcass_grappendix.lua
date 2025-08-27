PERK.PrintName = "Grappendix"
PERK.Description =
[[{1} increased maximum health.
Adds {2} maximum Hypertrophy stack.
Press RMB to use your appendix as a grapple hook.
Drains your health when in use.]]
PERK.Icon = "materials/perks/carcass/grappendix.png"
PERK.Params = {
    [1] = { value = 0.2, percent = true },
    [2] = { value = 1 },
}
PERK.Hooks = {}

if not SERVER then return end

PERK.Hooks.Horde_OnSetMaxHealth = function( ply, bonus )
    if not ply:Horde_GetPerk( "carcass_grappendix" ) then return end

    bonus.increase = bonus.increase + 0.2
end

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if perk ~= "carcass_grappendix" then return end

    ply:Horde_SetMaxHypertrophyStack( ply:Horde_GetMaxHypertrophyStack() + 1 )
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if perk ~= "carcass_grappendix" then return end

    ply:Horde_SetMaxHypertrophyStack( ply:Horde_GetMaxHypertrophyStack() - 1 )
end