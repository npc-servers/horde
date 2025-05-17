PERK.PrintName = "Exorcism"
PERK.Description = [[
Hunter's Mark removes mutations from enemies.
Hunter's Mark deals {2} damage for each mutation removed.
Hunter's Mark makes you instantly kill enemies at {3} of their max health.]]
PERK.Icon = "materials/perks/gunslinger/exorcism.png"
PERK.Params = {
    [1] = {value = 10},
    [2] = {value = 0.05, percent = true},
    [3] = {value = 0.1, percent = true},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not IsValid(npc.Horde_Has_Hunter_Mark) then return end
    if not npc.Horde_Has_Hunter_Mark:Horde_GetPerk("gunslinger_exorcism") then return end

    if (npc:Health() <= 0.1 * npc:GetMaxHealth()) then
        dmginfo:SetDamage(0.1 * npc:GetMaxHealth() + 1)
        dmginfo:SetDamageType(DMG_DIRECT)
    end
end