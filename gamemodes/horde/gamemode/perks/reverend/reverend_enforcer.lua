PERK.PrintName = "Enforcer"
PERK.Description = "{1} increased headshot damage. \n{1} increased Ballistic damage."
PERK.Icon = "materials/perks/reverend/enforcer.png"
PERK.Params = {
    [1] = { value = 0.10, percent = true },
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function( ply, _, bonus, hitgroup, dmginfo )
    if not ply:Horde_GetPerk( "reverend_enforcer" ) then return end
    if not HORDE:IsBallisticDamage( dmginfo ) then return end
    bonus.increase = bonus.increase + 0.1
    if hitgroup ~= HITGROUP_HEAD then return end
    bonus.increase = bonus.increase + 0.1
end