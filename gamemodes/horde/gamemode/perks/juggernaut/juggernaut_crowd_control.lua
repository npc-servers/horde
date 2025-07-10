PERK.PrintName = "Crowd Control"
PERK.Description = [[
Regenerate a Shrapnel Grenade every {1} seconds.
Shrapnel Grenades deal {2} more damage and inflict massive Stun.]]
PERK.Icon = "materials/perks/frag_impact.png"
PERK.Params = {
    [1] = { value = 10 },
    [2] = { value = 2, percent = true }
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "juggernaut_crowd_control" then return end

    timer.Create( "Horde_JuggernautCrowdControl" .. ply:SteamID64(), 10, 0, function()
        if not ply:IsValid() or not ply:Alive() then return end

        if HORDE.items["arccw_horde_nade_shrapnel"] then
            if not ply:HasWeapon( "arccw_horde_nade_shrapnel" ) then
                ply:Give( "arccw_horde_nade_shrapnel", ply:GetAmmoCount( "arccw_horde_nade_shrapnel" ) > 0 )
            end
        else
            -- Don't like m67 for some reason.
            if not ply:HasWeapon( "weapon_frag" ) then
                ply:Give( "weapon_frag", ply:GetAmmoCount( "Grenade" ) > 0 )
            end
        end
    end )
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if not SERVER then return end
    if perk ~= "juggernaut_crowd_control" then return end

    timer.Remove( "Horde_JuggernautCrowdControl" .. ply:SteamID64() )
end

PERK.Hooks.Horde_OnPlayerDamage = function( ply, npc, bonus, _, dmginfo )
    if not ply:Horde_GetPerk( "juggernaut_crowd_control" ) then return end

    if dmginfo:GetInflictor():GetClass() == "arccw_thr_shrapnel" then
        bonus.more = bonus.more * 3
        npc:Horde_AddDebuffBuildup( HORDE.Status_Stun, 500, ply, npc:GetPos() )
    end

    --bootleg shrapnel grenade conversion
    if dmginfo:GetInflictor():GetClass() == "npc_grenade_frag" then
        dmginfo:SetDamageType( DMG_BULLET )
        bonus.more = bonus.more * 3
        npc:Horde_AddDebuffBuildup( HORDE.Status_Stun, 500, ply, npc:GetPos() )
    end
end