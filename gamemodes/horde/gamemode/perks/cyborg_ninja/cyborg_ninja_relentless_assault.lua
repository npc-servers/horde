PERK.PrintName = "Relentless Assault"
PERK.Description = [[While in Blade Mode, gain {1} melee attack speed and {2} movement speed,
however, Blade Mode drains Suit Power {3} faster.]]
PERK.Icon = "materials/perks/samurai/blade_dance.png"
PERK.Params = {
    [1] = { value = 0.25, percent = true },
    [2] = { value = 0.25, percent = true },
    [3] = { value = 0.25, percent = true },
}

PERK.Hooks = {}

local function resetMeleeTime( wep )
    if not IsValid( wep ) then return end

    if wep.OldOnDrop then
        wep.OnDrop = wep.OldOnDrop
    else
        wep.OnDrop = nil
    end

    if wep.OldMeleeTime and wep.MeleeTime then
        wep.MeleeTime = wep.OldMeleeTime
        wep.OldMeleeTime = nil
    end
    if wep.OldMelee2Time and wep.Melee2Time then
        wep.Melee2Time = wep.OldMelee2Time
        wep.OldMelee2Time = nil
    end
end
local function setMeleeTime( wep, time )
    if not IsValid( wep ) then return end

    if wep.MeleeTime then
        wep.OldMeleeTime = wep.MeleeTime
        wep.MeleeTime = wep.MeleeTime * time
    end
    if wep.Melee2Time then
        wep.OldMelee2Time = wep.Melee2Time
        wep.Melee2Time = wep.Melee2Time * time
    end

    wep.OldOnDrop = wep.OnDrop or false
    wep.OnDrop = function()
        resetMeleeTime( wep )

        if OldOnDrop then
            wep:OldOnDrop()
        end
    end
end

PERK.Hooks.PlayerSwitchFlashlight = function( ply, switchOn )
    if not ply:Horde_GetPerk( "cyborg_ninja_relentless_assault" ) then return end

    if switchOn then
        for _, wep in ipairs( ply:GetWeapons() ) do
            setMeleeTime( wep, 0.75 )
        end
    else
        for _, wep in ipairs( ply:GetWeapons() ) do
            resetMeleeTime( wep )
        end
    end
end

PERK.Hooks.DoPlayerDeath = function( ply )
    if not ply:Horde_GetPerk( "cyborg_ninja_relentless_assault" ) then return end
    if not ply.Horde_In_Frenzy_Mode then return end

    for _, wep in ipairs( ply:GetWeapons() ) do
        resetMeleeTime( wep )
    end
end

PERK.Hooks.Horde_PlayerMoveBonus = function( ply, bonus_walk, bonus_run )
    if not ply:Horde_GetPerk( "cyborg_ninja_base" ) then return end
    if not ply.Horde_In_Frenzy_Mode then return end

    local movespeedIncrease = 0.25

    bonus_walk.increase = bonus_walk.increase + movespeedIncrease
    bonus_run.increase = bonus_run.increase + movespeedIncrease
end