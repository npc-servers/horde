PERK.PrintName = "Paladin Base"
PERK.Description = [[
Stats:
{1} Increased Sacred Aura's radius (1% per rank level, up to 25%)
{2} Increased Global damage resistance (0.8% per rank level, up to 20%)
- Increase health by 50.

Main Mechanics:

- "Sacred Aura"

You're surrounded with Sacred Aura, a yellow-colored zone. 
Whenever allies within the aura are healed by you, they gain Armor equal to 50% of your healing they receive.


- "Divine Shield"

Regenerate 1 Faith stack per 3 seconds. You can have up to 10 Faith stacks.
Faith stacks are used by "Divine Shield" ability, but doesn't do anything on their own.

Hold ALT (walk button) to use your "Divine Shield".
While shielding:
- You disable passive Faith stack regeneration, described above.
- Gain 5% Physical damage resistance per Faith stack.
- Lose 1 Faith stack upon taking Physical damage.

Has only access to melee weapons.]]
PERK.Params = {
    [1] = { percent = true, base = 0, level = 0.01, max = 0.25, classname = "Paladin" },
    [2] = { percent = true, base = 0, level = 0.008, max = 0.20, classname = "Paladin" },
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_base" then return end

    ply:Horde_AddPaladinAura()

    -- TODO: move into function
    local timerName = "SlowWalkHold_" .. ply:SteamID64()
    local secToStack = 3
    timer.Create( timerName, secToStack, 0, function()
        if not IsValid( ply ) then
            timer.Remove( timerName )

            return
        end

        ply:Horde_AddPaladinFaithStack()
    end )
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "paladin_base" then return end

    ply:Horde_RemovePaladinAura()

    local timerName = "SlowWalkHold_" .. ply:SteamID64()
    if timer.Exists( timerName ) then
        timer.Remove( timerName )
    end
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function( ply )
    if not SERVER then return end

    ply:Horde_SetPerkLevelBonus( "paladin_base", 1.5 + math.min( 0.25, 0.01 * ply:Horde_GetLevel( "Paladin" ) ) )
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "paladin_base" ) then return end

    local paladinResist = math.min( 0.20, 0.01 * ply:Horde_GetLevel( "Paladin" ) )
    local faithResist = 0

    if ply.Horde_PaladinShielding and HORDE:IsPhysicalDamage( dmginfo ) then
        faithResist = 0.05 * ply:Horde_GetPaladinFaithStack()
    end

    bonus.resistance = bonus.resistance + paladinResist + faithResist
end

PERK.Hooks.Horde_OnPlayerDamageTakenPost = function( ply, dmginfo )
    if not ply:Horde_GetPerk( "paladin_base" ) then return end
    if not ply.Horde_PaladinShielding then return end
    if dmginfo:GetDamage() <= 0 then return end
    if not HORDE:IsPhysicalDamage( dmginfo ) then return end

    ply:Horde_RemovePaladinFaithStack()
end

PERK.Hooks.Horde_OnSetMaxHealth = function( ply, bonus )
    if not SERVER then return end
    if not ply:Horde_GetPerk( "paladin_base" ) then return end

    bonus.increase = bonus.increase + 0.5
end

PERK.Hooks.PlayerButtonDown = function( ply, button )
    if not SERVER then return end
    if button ~= KEY_LALT then return end
    if not ply:Horde_GetPerk( "paladin_base" ) then return end
    ply.Horde_PaladinShielding = true

    local timerName = "SlowWalkHold_" .. ply:SteamID64()

    -- prevent regen
    if timer.Exists( timerName ) then
        timer.Remove( timerName )
    end
end

PERK.Hooks.PlayerButtonUp = function( ply, button )
    if not SERVER then return end
    if button ~= KEY_LALT then return end
    if not ply:Horde_GetPerk( "paladin_base" ) then return end
    ply.Horde_PaladinShielding = nil

    local timerName = "SlowWalkHold_" .. ply:SteamID64()
    local secToStack = 3

    -- TODO: move into function
    timer.Create( timerName, secToStack, 0, function()
        if not IsValid( ply ) then
            timer.Remove( timerName )

            return
        end

        ply:Horde_AddPaladinFaithStack()
    end )
end

-- Armor on heal
PERK.Hooks.Horde_PostOnPlayerHeal = function( ply, healinfo )
    local healer = healinfo.healer
    if not IsValid( healer ) then return end
    if not healer:Horde_GetPerk( "paladin_base" ) then return end

    -- Check if inside aura and if aura is owned by healer
    local paladinAuraProvider = ply.Horde_PaladinAuraProvider
    if not IsValid( paladinAuraProvider ) or paladinAuraProvider ~= healer then return end

    -- Give 50% of healing as armor
    if ply:Armor() == ply:GetMaxArmor() then return end
    ply:SetArmor( math.Min( ply:GetMaxArmor(), ply:Armor() + healinfo.amount / 2 ) )
end