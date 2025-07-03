PERK.PrintName = "Cyborg Ninja Base"
PERK.Description = [[
COMPLEXITY: HIGH

{1} increased melee damage while in Blade mode. ({7} base, {2} per level, up to {3})
{4} increased Global damage resistance. ({11} base, {5} per level, up to {6})

Press F to enter Blade Mode, replacing your flashlight.
Blade Mode reduces your speed by {14}.
Blade Mode uses Suit Power when active and requires 10 to activate.
Blade Mode disables Suit Armor gain from perks while active.

Enemies killed in Blade Mode performs Zandatsu, giving you a {9} chance to drop a Suit Battery.
Normal attacks leech up to 8 Suit Power if you are not in Blade Mode or Ripper Mode.]]
PERK.Icon = "materials/subclasses/cyborg_ninja.png"
PERK.Params = {
    [1] = { percent = true, base = 0.5, level = 0.025, max = 1, classname = "Cyborg Ninja" },
    [2] = { value = 0.025, percent = true },
    [3] = { value = 1.00, percent = true },
    [4] = { percent = true, base = 0, level = 0.008, max = 0.2, classname = "Cyborg Ninja" },
    [5] = { value = 0.008, percent = true },
    [6] = { value = 0.2, percent = true },
    [7] = { value = 0.50, percent = true },
    [8] = { value = 0.6, percent = true },
    [9] = { value = 0.50, percent = true },
    [10] = { percent = true, base = 0.5, level = 0.01, max = 0.75, classname = "Cyborg Ninja" },
    [11] = { value = 0, percent = true },
    [12] = { value = 0.5, percent = true },
    [13] = { value = 0.75, percent = true },
    [14] = { value = 0.40, percent = true },
}
PERK.Hooks = {}

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function( ply )
    if SERVER then
        ply:Horde_SetPerkLevelBonus( "cyborg_ninja_base", math.min( 0.2, 0.008 * ply:Horde_GetLevel( "Cyborg Ninja" ) ) )
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, _, bonus )
    if not ply:Horde_GetPerk( "cyborg_ninja_base" )  then return end

    bonus.resistance = bonus.resistance + ply:Horde_GetPerkLevelBonus( "cyborg_ninja_base" )
end

PERK.Hooks.Horde_OnPlayerDamage = function( ply, _, bonus, _, dmginfo )
    if not ply:Horde_GetPerk( "cyborg_ninja_base" ) then return end
    if not ply.Horde_In_Frenzy_Mode then return end
    if not HORDE:IsMeleeDamage( dmginfo ) then return end

    local base = 0.5
    local perLevel = 0.025
    local max = 0.5 -- not including base

    bonus.increase = bonus.increase + base + math.min( max, perLevel * ply:Horde_GetLevel( "Cyborg Ninja" ) )
    if ply:Horde_GetPerk( "cyborg_ninja_sharper_blade" ) then
        bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.PlayerTick = function( ply )
    if not SERVER then return end
    if not ply:Horde_GetPerk( "cyborg_ninja_base" ) then return end

    if ply.Horde_In_Frenzy_Mode and CurTime() >= ply.Horde_HealthDegenCurTime then
        ply:SetArmor( math.max( 0, ply:Armor() - 1 ) )
        ply.Horde_HealthDegenCurTime = CurTime() + 0.25
    end

    if ply:Armor() < 1 or not ply:Alive() then
        -- Disable Frenzy mode
        net.Start( "Horde_SyncStatus" )
            net.WriteUInt( HORDE.Status_HF_Mode, 8 )
            net.WriteUInt( 0, 8 )
        net.Send( ply )
        ply.Horde_In_Frenzy_Mode = nil
        ply:ScreenFade( SCREENFADE.PURGE, Color( 60, 60, 200, 0 ), 0.1, 0.1 )
    end
end

PERK.Hooks.PlayerSwitchFlashlight = function( ply, switchOn )
    if not ply:Horde_GetPerk( "cyborg_ninja_base" ) then return end
    if ply.Horde_Ripper_Mode then return end

    if switchOn and ply:Armor() >= 10 then
        -- Enable Frenzy mode
        ply:SetArmor( math.max( 0, ply:Armor() - 10 ) )
        sound.Play( "weapons/physcannon/superphys_launch4.wav", ply:GetPos() )
        net.Start( "Horde_SyncStatus" )
            net.WriteUInt( HORDE.Status_HF_Mode, 8 )
            net.WriteUInt( 1, 8 )
        net.Send( ply )
        ply.Horde_In_Frenzy_Mode = true
        ply.Horde_HealthDegenCurTime = CurTime()
        ply:ScreenFade( SCREENFADE.STAYOUT, Color( 60, 60, 200, 50 ), 0.2, 5 )
    else
        -- Disable Frenzy mode
        net.Start( "Horde_SyncStatus" )
            net.WriteUInt( HORDE.Status_HF_Mode, 8 )
            net.WriteUInt( 0, 8 )
        net.Send( ply )
        ply.Horde_In_Frenzy_Mode = nil
        ply:ScreenFade( SCREENFADE.PURGE, Color( 60, 60, 200, 0 ), 0.1, 0.1 )
    end
end

PERK.Hooks.Horde_PlayerMoveBonus = function( ply, bonus_walk, bonus_run )
    if not ply:Horde_GetPerk( "cyborg_ninja_base" ) then return end
    if not ply.Horde_In_Frenzy_Mode then return end

    local bladeModeSlow = 0.4

    bonus_walk.increase = bonus_walk.increase + -bladeModeSlow
    bonus_run.increase = bonus_run.increase + -bladeModeSlow
end

--Zandatsu
PERK.Hooks.Horde_OnEnemyKilled = function( victim, killer, inflictor )
    if not killer:Horde_GetPerk( "cyborg_ninja_base" ) then return end
    if not killer.Horde_In_Frenzy_Mode then return end
    if not inflictor:IsValid() or inflictor:IsNPC() then return end -- Prevent infinite chains
    local rand = math.random()
    local chance = 0.5

    if rand <= chance then
        local ent = ents.Create( "item_battery" )
        ent:SetPos( victim:GetPos() )
        ent:SetOwner( killer )
        ent.Owner = killer
        ent.Inflictor = victim
        ent:Spawn()
        ent:Activate()
        timer.Simple( 30, function()
            if not ent:IsValid() then return end
            ent:Remove()
        end )
    end
end

--Passive FC regen
PERK.Hooks.Horde_OnPlayerDamagePost = function( ply, npc, _, _, dmginfo )
    if not ply:Horde_GetPerk( "cyborg_ninja_base" ) then return end
    if ply.Horde_In_Frenzy_Mode then return end
    if ply.Horde_Ripper_Mode then return end
    if not HORDE:IsMeleeDamage( dmginfo ) then return end
    if HORDE:IsPlayerMinion( npc ) then return end

    local maxArmorLeech = 8
    local meleeDmgLeech = 0.05

    local leech = math.min( maxArmorLeech, dmginfo:GetDamage() * meleeDmgLeech )
    ply:SetArmor( math.min( ply:GetMaxArmor(), ply:Armor() + leech ) )
end