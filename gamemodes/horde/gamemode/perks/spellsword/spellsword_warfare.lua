PERK.PrintName = "Warfare"
PERK.Icon = "materials/perks/gunslinger/elusive.png"
PERK.Description = [[
Increase Slashing and Blunt damage by 10%.
Increase Global damage resistance by 15%.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function( ply, _, bonus, _, dmginfo )
    if not ply:Horde_GetPerk( "spellsword_warfare" ) then return end
    if not dmginfo:IsDamageType( DMG_SLASH + DMG_CLUB ) then return end

    bonus.increase = bonus.increase + 0.1
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, _, bonus )
    if not ply:Horde_GetPerk( "spellsword_warfare" ) then return end

    bonus.resistance = bonus.resistance + 0.15
end