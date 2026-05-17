PERK.PrintName = "Arcane Recovery"
PERK.Icon = "materials/perks/gunslinger/elusive.png"
PERK.Description = [[
Heal health by 15% of incantation's mind cost when casted.
Recover 5 mind when taking physical damage.]]
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo )
    if not ply:Horde_GetPerk( "spellsword_arcane_recovery" ) then return end
    if not HORDE:IsPhysicalDamage( dmginfo ) then return end

    local mind = ply:Horde_GetMind()
    local maxMind = ply:Horde_GetMaxMind()

    if mind >= maxMind then return end

    ply:Horde_SetMind( math.min( mind + 5, maxMind ) )
end