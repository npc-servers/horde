PERK.PrintName = "Ambush"
PERK.Description = "{1} increased headshot damage. {2} increased damage to everywhere but the head."
PERK.Icon = "materials/perks/ambush.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 0.15, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup)
    if not ply:Horde_GetPerk("assault_ambush") then return end
 --   if hitgroup ~= HITGROUP_HEAD then return end
    if hitgroup == HITGROUP_HEAD then
        bonus.increase = bonus.increase + 0.25
    else
        bonus.increase = bonus.increase + 0.15
    end
end