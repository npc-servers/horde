PERK.PrintName = "Countermeasures"
PERK.Icon = "materials/perks/breathing_technique.png"
PERK.Description = "Immune to Poison, Bleed, and Necrosis."

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDebuffApply = function( ply, debuff, bonus, inflictor )
    if not ply:Horde_GetPerk( "prototype_countermeasures" ) then return end
    
    if debuff == HORDE.Status_Bleeding or debuff == HORDE.Status_Necrosis then
        bonus.apply = 0
        return true
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "prototype_countermeasures" ) then return end
    
    if HORDE:IsPoisonDamage( dmginfo ) then
        bonus.resistance = bonus.resistance + 1.0
    end
end
