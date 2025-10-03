PERK.PrintName = "Overdrive"
PERK.Icon = "materials/perks/chain_reaction.png"
PERK.Description = [[
For each 1% health gained above 50% of base max health.
Increases damage and movement speed by 0.5%.
25% maximum increase.]]

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function( ply, npc, bonus, hitgroup, dmginfo )
    if not ply:Horde_GetPerk( "prototype_overdrive" ) then return end

    local hpFrac = ply:Health() / 100
    if hpFrac <= 0.5 then return end

	local dmgBonus = 0.25
	local dmgMult = math.min( dmgBonus, dmgBonus * hpFrac )

	bonus.increase = bonus.increase + dmgMult
end

PERK.Hooks.Horde_PlayerMoveBonus = function( ply, bonus_walk, bonus_run, bonus_jump )
    if not ply:Horde_GetPerk( "prototype_overdrive" ) then return end

    local hpFrac = ply:Health() / 100
    if hpFrac <= 0.5 then return end

	local speedBonus = 0.25
	local speedMult = math.min( speedBonus, speedBonus * hpFrac )

	bonus_walk.more = bonus_walk.more + speedMult
	bonus_run.more = bonus_run.more + speedMult
end
