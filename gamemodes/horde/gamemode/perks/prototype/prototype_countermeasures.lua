PERK.PrintName = "Countermeasures"
PERK.Icon = "materials/perks/breathing_technique.png"
PERK.Description = "50% resistance to Poison. 25% less Decay buildup."

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDebuffApply = function( ply, debuff, bonus, inflictor )
    if not ply:Horde_GetPerk( "prototype_countermeasures" ) then return end
    
    if debuff == HORDE.Status_Decay then
        bonus.less = bonus.less * 0.75
        return true
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "prototype_countermeasures" ) then return end
    
    if HORDE:IsPoisonDamage( dmginfo ) then
        bonus.resistance = bonus.resistance + 0.50
    end
end
