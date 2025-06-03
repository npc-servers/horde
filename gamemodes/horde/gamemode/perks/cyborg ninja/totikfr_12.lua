PERK.PrintName = "Cybernetic Arm"
PERK.Description = "Leech up to {1} health upon dealing melee damage. \nGain immunity to Bleeding. \nKills leech {2} armor while not in Blade Mode or Ripper Mode."
PERK.Icon = "materials/perks/berserk.png"
PERK.Params = {
    [1] = {value = 0.05, percent = true},
	[2] = {value = 2},
	[3] = {value = 1},
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
    if ply:Horde_GetPerk("totikfr_12") and HORDE:IsMeleeDamage(dmginfo) then
        local leech = math.min(5, dmginfo:GetDamage() * 0.10)
        HORDE:SelfHeal(ply, leech)
    end
end

PERK.Hooks.Horde_OnPlayerDebuffApply = function (ply, debuff, bonus)
    if ply:Horde_GetPerk("totikfr_12") and debuff == HORDE.Status_Bleeding then
        bonus.apply = 0
        return true
    end
end

PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, inflictor)
	if not killer:Horde_GetPerk("totikfr_12") then return end
	if killer.Horde_In_Frenzy_Mode then return end
	if killer.Horde_Ripper_Mode then return end
	killer:SetArmor(math.min(killer:GetMaxArmor(),killer:Armor()+2))
end

