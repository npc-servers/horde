PERK.PrintName = "Smuggle"
PERK.Description = [[
25% more cash on kill.
Allows you to open the shop at anytime and anywhere.
Kills grant you ammo for all of your weapons.]]
PERK.Icon = "materials/perks/gunslinger/smuggle.png"
PERK.Params = {
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "gunslinger_smuggle" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Smuggle, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
        ply.Horde_Smuggle_Active = true
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "gunslinger_smuggle" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Smuggle, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
        ply.Horde_Smuggle_Active = nil
    end
end

PERK.Hooks.Horde_OnPlayerOpenShop = function (ply)
    if ply:Horde_GetPerk("gunslinger_smuggle") and ply.Horde_Smuggle_Active then
        if HORDE.has_buy_zone and ply:Horde_GetInBuyZone() then
            return
        end
        if HORDE.current_break_time > 0 then
            return
        end
        ply.Horde_Smuggle_Active = nil
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Smuggle, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
        timer.Simple(1, function ()
            if ply:IsValid() then
                ply.Horde_Smuggle_Active = true
                net.Start("Horde_SyncActivePerk")
                    net.WriteUInt(HORDE.Status_Smuggle, 8)
                    net.WriteUInt(1, 3)
                net.Send(ply)
            end
        end)
        return true
    end
end

PERK.Hooks.Horde_OnEnemyKilled = function(victim, killer, wpn)
    if not killer:Horde_GetPerk("gunslinger_smuggle") then return end
        local given_ammo = false
        local given_ammo2 = false
        for _, wpn in pairs(killer:GetWeapons()) do
            local ammo_id = wpn:GetPrimaryAmmoType()
            local ammo_id2 = wpn:GetSecondaryAmmoType()
            local clip_size2 = wpn:GetMaxClip2()
            
            -- Secondary Magazine size check
            if clip_size2 > 0 then
                clip_size2 = clip_size2
            elseif ammo_id2 >= 1 then
                clip_size2 = 1
            end
            
            -- Primary ammo
            if wpn.Primary and wpn.Primary.MaxAmmo then
                if wpn.Primary.MaxAmmo > killer:GetAmmoCount(ammo_id) and killer:GetAmmoCount(ammo_id) >= 0 then
                    local given = HORDE:GiveAmmo(killer, wpn, 2)
                    given_ammo = given_ammo or given
                end
            elseif killer:GetAmmoCount(ammo_id) < 9999 then
                local given = HORDE:GiveAmmo(killer, wpn, 2)
                given_ammo = given_ammo or given
            end
            
            -- Secondary ammo and ArcCW underbarrels
            if wpn.Secondary and wpn.Secondary.MaxAmmo then
                if wpn.Secondary.MaxAmmo > killer:GetAmmoCount(ammo_id2) and ammo_id2 >= 0 then
                    local given2 = killer:GiveAmmo(clip_size2, ammo_id2, false)
                    given_ammo2 = given_ammo2 or given2
                end
            elseif killer:GetAmmoCount(ammo_id2) < 9999 then
                local given2 = killer:GiveAmmo(clip_size2, ammo_id2, false)
                given_ammo2 = given_ammo2 or given2
            end
        end
end