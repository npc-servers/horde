PERK.PrintName = "Grappendix"
PERK.Description =
[[Adds {1} maximum Hypertrophy stack.
Press RMB to use your appendix as a grapple hook. Drains health when used.
Multiplies your velocity based damage bonus by {2}, Multiplier Capped at 20x]]
PERK.Icon = "materials/perks/carcass/grappendix.png"
PERK.Params = {
  --  [1] = { value = 0.2, percent = true },
    [1] = { value = 2 },
    [2] = { value = 0.8, percent = true},
}
PERK.Hooks = {}

if not SERVER then return end

--[[PERK.Hooks.Horde_OnSetMaxHealth = function( ply, bonus )
    if not ply:Horde_GetPerk( "carcass_grappendix" ) then return end

    bonus.increase = bonus.increase + 0.2
end]]--

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if perk ~= "carcass_grappendix" then return end

    ply:Horde_SetMaxHypertrophyStack( ply:Horde_GetMaxHypertrophyStack() + 2 )
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if perk ~= "carcass_grappendix" then return end

    ply:Horde_SetMaxHypertrophyStack( ply:Horde_GetMaxHypertrophyStack() - 2 )
end