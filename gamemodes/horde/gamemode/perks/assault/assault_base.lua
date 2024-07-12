PERK.PrintName = "Assault Base"
PERK.Description = [[
The Assault class is an all-purpose fighter with high mobility and a focus on Adrenaline stacks.
Complexity: EASY

{1} more movement speed. ({2} per level, up to {3}).
{5} increased Ballistic damage. ({6} per level, up to {7}).

Gain Adrenaline and Endorphins when you kill an enemy.
Adrenaline increases damage and speed by {4} per stack.
Endorphins raise Evasion by {8} per stack. ]]


--looking at sh_rank shows that reaching rank 25 (champion, yellow rank) is when you get your maximum stat bonus
--calculating bonuses looks like this, say you want 30% max movespeed, well 30% = 0.3 so 0.3 / 25 = 0.012% per level and so on
--remember to scroll down to the Horde_PrecomputePerkLevelBonus hook and update your values there as well
PERK.Params = {
    [1] = {percent = true, level = 0.012, max = 0.30, classname = HORDE.Class_Assault}, --current movespeed bonus
    [2] = {value = 0.012, percent = true},--movespeed bonus increase per level
    [3] = {value = 0.3, percent = true}, --total movespeed bonus
    [4] = {value = 0.06, percent = true}, --adrenaline stack bonus speed/damage
    [5] = {percent = true, level = 0.004, max = 0.1, classname = HORDE.Class_Assault},--current ballistic damage bonus
    [6] = {value = 0.004, percent = true},--ballistic damage bonus increase per level
    [7] = {value = 0.1, percent = true}, --total ballistic damage bonus
    [8] = {value = 0.1, percent = true}, --endorphin evasion value per stack
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "assault_base" then
        --this adds to the maximum amount of adrenaline stacks when this class is equipped
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() + 6)
        --this adds to the maximum amount of endorphins when this class is equipped
        ply:Horde_SetMaxEndorphins(ply:Horde_GetMaxEndorphins() + 4)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "assault_base" then
        --this subtracts from the maximum amount of adrenaline stacks added when the class is unequipped
        ply:Horde_SetMaxAdrenalineStack(ply:Horde_GetMaxAdrenalineStack() - 6)
        --this subtracts from the max amount of endorphins added when the class is unequipped
        ply:Horde_SetMaxEndorphins(ply:Horde_GetMaxEndorphins() - 4)
    end
end

PERK.Hooks.Horde_PlayerMoveBonus = function(ply, bonus_walk, bonus_run)
    if not ply:Horde_GetPerk("assault_base") then return end
    --this is where movespeed bonuses are calculated and applied
    bonus_walk.more = bonus_walk.more * ply:Horde_GetPerkLevelBonus("assault_base")
    bonus_run.more = bonus_run.more * ply:Horde_GetPerkLevelBonus("assault_base")
end

--perk level bonuses get computed down here, make sure to update values here as well
PERK.Hooks.Horde_PrecomputePerkLevelBonus = function (ply)
    if SERVER then
        --movespeed bonus
        ply:Horde_SetPerkLevelBonus("assault_base", 1 + math.min(0.3, 0.012 * ply:Horde_GetLevel(HORDE.Class_Assault)))
        --ballistic damage bonus
        ply:Horde_SetPerkLevelBonus("assault_base2", math.min(0.10, 0.004 * ply:Horde_GetLevel(HORDE.Class_Assault)))
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("assault_base") then return end
    --this is obviously where the ballistic damage bonus gets calculated and applied
    if HORDE:IsBallisticDamage(dmginfo) then
        bonus.increase = bonus.increase + ply:Horde_GetPerkLevelBonus("assault_base2")
    end
end