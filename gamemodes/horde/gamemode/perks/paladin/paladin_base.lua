PERK.PrintName = "Paladin Base"
PERK.Description = [[
{1} Increased Sacred Aura's radius (1% per rank level, up to 25%)
{2} Increased Global damage resistance (0.8% per rank level, up to 20%)
Health increased by 50.

- "Sacred Aura"
You're surrounded with Sacred Aura, a yellow-colored zone. 
Whenever allies within the aura are healed by you, they gain Armor equal to 50% of your healing they receive.

- "Divine Shield"
Regenerate 1 Faith stack per 3 seconds. You can have up to 10 Faith stacks.
Faith stacks are used by "Divine Shield" ability, but doesn't do anything on their own.

Hold ALT (walk button) to use your "Divine Shield".
While shielding:
- You disable passive Faith stack regeneration, described above.
- You cannot sprint.
- Gain 5% Physical damage resistance per Faith stack.
- Lose 1 Faith stack upon taking Physical damage.

Has only access to melee weapons.]]
PERK.Params = {
    [1] = { percent = true, base = 0, level = 0.01, max = 0.25, classname = "Paladin" },
    [2] = { percent = true, base = 0, level = 0.008, max = 0.20, classname = "Paladin" },
}
PERK.Hooks = {}

if not SERVER then return end

local secondsToStackFaith = 3
local SHIELDING_TIMER_NAME = "Horde_PaladinShielding"

local shieldCooldown = 0.15

local function createFaithTimer( ply )
    local timerName = SHIELDING_TIMER_NAME .. ply:SteamID64()
    timer.Create( timerName, secondsToStackFaith, 0, function()
        if not IsValid( ply ) then
            timer.Remove( timerName )

            return
        end

        ply:Horde_AddPaladinFaithStack()
    end )
end

local function removeFaithTimer( ply )
    local timerName = SHIELDING_TIMER_NAME .. ply:SteamID64()
    if timer.Exists( timerName ) then
        timer.Remove( timerName )
    end
end

local function addShieldingStatus( ply, recursive )
    net.Start( "Horde_SyncStatus" )
        net.WriteUInt( HORDE.Status_PaladinShielding, 8 )
        net.WriteUInt( 1, 8 )
    net.Send( ply )

    if recursive then return end

    ply:ScreenFade( SCREENFADE.STAYOUT, Color( 255, 255, 0, 10 ), 0.2, 5 )
    ply:EmitSound( "horde/spells/negative_burst.ogg" )

    if ply:Horde_GetPerk( "paladin_providence" ) then
        local aura = ply.Horde_PaladinAura
        if not aura then return end

        for ent, _ in pairs( ply.Horde_PaladinAura.Entities ) do
            if ent:IsPlayer() and ply:Horde_GetCurrentSubclass() ~= "Paladin" then
                addShieldingStatus( ent, true )
            end
        end
    end
end

local function removeShieldingStatus( ply, recursive )
    net.Start( "Horde_SyncStatus" )
        net.WriteUInt( HORDE.Status_PaladinShielding, 8 )
        net.WriteUInt( 0, 8 )
    net.Send( ply )

    if recursive then return end

    ply:ScreenFade( SCREENFADE.PURGE, Color( 255, 255, 0, 0 ), 0.1, 0.1 )

    if ply:Horde_GetPerk( "paladin_providence" ) then
        local aura = ply.Horde_PaladinAura
        if not aura then return end

        for ent, _ in pairs( ply.Horde_PaladinAura.Entities ) do
            if ent:IsPlayer() and ply:Horde_GetCurrentSubclass() ~= "Paladin" then
                removeShieldingStatus( ent, true )
            end
        end
    end
end

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if perk ~= "paladin_base" then return end

    ply:Horde_AddPaladinAura()
    createFaithTimer( ply )
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if perk ~= "paladin_base" then return end

    ply:Horde_RemovePaladinAura()
    removeFaithTimer( ply )
    removeShieldingStatus( ply )
end

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function( ply )
    ply:Horde_SetPerkLevelBonus( "paladin_base_auraradius", 1.5 + math.min( 0.25, 0.01 * ply:Horde_GetLevel( "Paladin" ) ) )
    ply:Horde_SetPerkLevelBonus( "paladin_base_globalresist", math.min( 0.20, 0.01 * ply:Horde_GetLevel( "Paladin" ) ) )
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply:Horde_GetPerk( "paladin_base" ) then return end

    local faithResist = 0

    if ply.Horde_PaladinShielding and HORDE:IsPhysicalDamage( dmginfo ) then
        faithResist = 0.05 * ply:Horde_GetPaladinFaithStack()

        if dmginfo:GetDamage() > 0 then
            ply:Horde_RemovePaladinFaithStack()
        end
    end

    bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus( "paladin_base_globalresist" ) + faithResist
end

PERK.Hooks.StartCommand = function( ply, cmd )
    if not ply:Alive() then return end
    if not ply:Horde_GetPerk( "paladin_base" ) then return end
    if not ply.Horde_PaladinShielding then return end

    cmd:RemoveKey( IN_SPEED )
end

PERK.Hooks.Horde_OnSetMaxHealth = function( ply, bonus )
    if not ply:Horde_GetPerk( "paladin_base" ) then return end

    bonus.add = bonus.add + 50
end

PERK.Hooks.PlayerButtonDown = function( ply, button )
    if button ~= KEY_LALT then return end
    if not ply:Horde_GetPerk( "paladin_base" ) then return end

    local curTime = CurTime()

    if ply.Horde_PaladinLastShielding and ply.Horde_PaladinLastShielding > curTime then
        HORDE:SendNotification( "Stop Spamming!", 1, ply )
        ply.Horde_PaladinLastShielding = curTime + shieldCooldown

        return
    end

    ply.Horde_PaladinShielding = true
    ply.Horde_PaladinLastShielding = curTime + shieldCooldown

    removeFaithTimer( ply )
    addShieldingStatus( ply )
end

PERK.Hooks.PlayerButtonUp = function( ply, button )
    if button ~= KEY_LALT then return end
    if not ply:Horde_GetPerk( "paladin_base" ) then return end
    if not ply.Horde_PaladinShielding then return end

    ply.Horde_PaladinShielding = nil

    createFaithTimer( ply )
    removeShieldingStatus( ply )
end

-- Armor on heal
PERK.Hooks.Horde_PostOnPlayerHeal = function( ply, healinfo )
    local healer = healinfo.healer
    if not IsValid( healer ) then return end
    if not healer:Horde_GetPerk( "paladin_base" ) then return end

    -- Check if inside aura and if aura is owned by healer
    if ply ~= healer then
        local aura = healer.Horde_PaladinAura
        if not IsValid( aura ) then return end

        local entities = aura.Entities
        if not entities or not entities[ent] then return end
    end

    -- Give 50% of healing as armor
    local armor = ply:Armor()
    local maxArmor = ply:GetMaxArmor()

    if armor == maxArmor then return end
    ply:SetArmor( math.Min( maxArmor, armor + healinfo.amount / 2 ) )
end