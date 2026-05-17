PERK.PrintName = "Arcane Deflection"
PERK.Icon = "materials/perks/gunslinger/elusive.png"
PERK.Description = [[
Reduce physical damage taken at the cost of mind.
Recover 3 mind per kill.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamageTakenPost = function( ply, dmginfo )
    if not ply:Horde_GetPerk( "spellsword_arcane_deflection" ) then return end

    local mind = ply:Horde_GetMind()
    if mind <= 0 then return end

    local dmg = dmginfo:GetDamage()

    ply:Horde_SetMind( math.max( 0, mind - dmg ) )
    dmginfo:SubtractDamage( mind )
end

PERK.Hooks.Horde_OnEnemyKilled = function( _, killer )
    if not killer:Horde_GetPerk( "spellsword_arcane_deflection" ) then return end

    local mind = killer:Horde_GetMind()
    local maxMind = killer:Horde_GetMaxMind()

    if mind >= maxMind then return end

    killer:Horde_SetMind( math.min( mind + 3, maxMind ) )
end