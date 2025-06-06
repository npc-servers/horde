PERK.PrintName = "Supply Drop"
PERK.Description = "Press Shift + E to spawn a super ammo box. \nSuper ammo boxes will give you ammo for all of your weapons, \nalong with refilling your entire clip instantly. {2} second cooldown."
PERK.Icon = "materials/perks/specops/flare.png"
PERK.Params = {
    [1] = {value = 3, percent = true},
    [2] = {value = 20},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "juggernaut_supply_drop" then
            ply:Horde_SetPerkCooldown(20)
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Flare, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "juggernaut_supply_drop" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Flare, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_UseActivePerk = function (ply)
    if not ply:Horde_GetPerk("juggernaut_supply_drop") then return end
sound.Play("juggernaut_supply.wav", ply:GetPos())
    local ent = ents.Create("horde_super_ammo_box")
    local pos = ply:GetPos()
    local dir = (ply:GetEyeTrace().HitPos - pos)
    dir:Normalize()
    local drop_pos = pos + dir * 100
    drop_pos.z = pos.z + 15
    ent:SetPos(drop_pos)
    ent:SetAngles(Angle(0, ply:GetAngles().y, 0))
    ent:SetRenderMode(RENDERMODE_TRANSCOLOR)
    ent:Spawn()
	
end