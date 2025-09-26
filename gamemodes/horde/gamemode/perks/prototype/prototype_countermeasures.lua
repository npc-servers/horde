PERK.PrintName = "Countermeasures"
PERK.Icon = "materials/perks/breathing_technique.png"
PERK.Description = "30% resistance to Poison. 15% less Bleed and Decay buildup."

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDebuffApply = function( ply, debuff, bonus, inflictor )
    if not ply:Horde_GetPerk( "prototype_countermeasures" ) then return end
    
    if debuff == HORDE.Status_Bleeding or debuff == HORDE.Status_Decay then
        bonus.less = bonus.less * 0.85
        return true
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "prototype_countermeasures" ) then return end
    
    if HORDE:IsPoisonDamage( dmginfo ) then
        bonus.resistance = bonus.resistance + 0.30
    end
end
