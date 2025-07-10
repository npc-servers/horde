PERK.PrintName = "Shockproof"
PERK.Description = [[
Gain {1} damage resist to non-physical damage and immunity to poison damage.
{4} less debuff buildup.]]
PERK.Icon = "materials/perks/ballistic_shock.png"
PERK.Params = {
    [1] = { value = 0.25, percent = true },
    [2] = { value = 2 },
    [3] = { value = 50 },
    [4] = { value = 0.5, percent = true },
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "juggernaut_shockproof" ) then return end

    if HORDE:IsPoisonDamage( dmginfo ) then
       bonus.resistance = bonus.resistance + 1
    elseif HORDE:IsFireDamage( dmginfo ) or HORDE:IsLightningDamage( dmginfo ) or HORDE:IsColdDamage( dmginfo ) or HORDE:IsBlastDamage( dmginfo ) then
        bonus.resistance = bonus.resistance + 0.25
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function( ply, debuff, bonus )
    if not ply:Horde_GetPerk( "juggernaut_shockproof" ) then return end

    bonus.less = bonus.less * 0.5

    if debuff == HORDE.Status_Break then
        bonus.apply = 0
    end
end