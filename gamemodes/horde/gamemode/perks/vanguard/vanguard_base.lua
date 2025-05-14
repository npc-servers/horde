PERK.PrintName = "Vanguard Base"
PERK.Description = [[
Warden subclass.
A powerful combatant capable of controlling individual threats using biotic powers.
Complexity: MEDIUM

{1} increased Shotgun damage. ({2} per level, up to {3}).

Press SHIFT+E to apply Stasis on an enemy.
Stasis lasts for 5 seconds with a cooldown of 10 seconds.
You can apply Stasis to one target at a time.
]]
PERK.Icon = "materials/subclasses/vanguard.png"

PERK.Params = {
    [1] = { percent = true, level = 0.008, max = 0.20, classname = HORDE.Class_Vanguard },
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnSetPerk = function(ply, perk)
    if SERVER and perk == "vanguard_base" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Vanguard_Stasis, 8)
            net.WriteUInt(1, 3)
        net.Send(ply)
    end
end

PERK.Hooks.Horde_OnUnsetPerk = function(ply, perk)
    if SERVER and perk == "vanguard_base" then
        net.Start("Horde_SyncActivePerk")
            net.WriteUInt(HORDE.Status_Vanguard_Stasis, 8)
            net.WriteUInt(0, 3)
        net.Send(ply)

        if ply.Horde_Vanguard_Stasis_Target and ply.Horde_Vanguard_Stasis_Target:IsValid() then
            local target = ply.Horde_Vanguard_Stasis_Target
            net.Start("Horde_RemoveVanguardStasisHighlight")
                net.WriteEntity(target)
            net.Broadcast()
            target.Horde_Has_Vanguard_Stasis = nil
            ply.Horde_Vanguard_Stasis_Target = nil
        end
    end
end

PERK.Hooks.Horde_UseActivePerk = function(ply)
    if CLIENT or not ply:Horde_GetPerk("vanguard_base") then return end

    local ent = util.TraceLine(util.GetPlayerTrace(ply)).Entity

    if ent:IsValid() and ent:IsNPC() and (not ent:GetNWEntity("HordeOwner"):IsValid()) then
        local range = 500000
        if ent:GetPos():DistToSqr(ply:GetPos()) > range then
            return true
        end

        if ent.Horde_Has_Vanguard_Stasis and ent.Horde_Has_Vanguard_Stasis ~= ply then
            return true
        end

        local id = ent:GetCreationID()
        timer.Remove("Horde_VanguardStasisExpire" .. id)

        if ply.Horde_Vanguard_Stasis_Target and ply.Horde_Vanguard_Stasis_Target:IsValid() and ply.Horde_Vanguard_Stasis_Target ~= ent then
            timer.Remove("Horde_VanguardStasisExpire" .. ply.Horde_Vanguard_Stasis_Target:GetCreationID())
            net.Start("Horde_RemoveVanguardStasisHighlight")
                net.WriteEntity(ply.Horde_Vanguard_Stasis_Target)
            net.Broadcast()
            if ply.Horde_Vanguard_Stasis_Target.Horde_Has_Vanguard_Stasis then
                ply.Horde_Vanguard_Stasis_Target.Horde_Has_Vanguard_Stasis = nil
            end
            ply.Horde_Vanguard_Stasis_Target = nil
        end

        ent.Horde_Has_Vanguard_Stasis = ply
        net.Start("Horde_VanguardStasisHighlight")
            net.WriteEntity(ent)
        net.Broadcast()
        ply.Horde_Has_Vanguard_Stasis = ent
        sound.Play("horde/player/hunter_mark.ogg", ply:GetPos(), 70, 100)

        timer.Create("Horde_VanguardStasisExpire" .. id, 5, 1, function ()
            net.Start("Horde_RemoveVanguardStasisHighlight")
                net.WriteEntity(ent)
            net.Broadcast()
            ent.Horde_Has_Vanguard_Stasis = nil
        end)
    else
        return true
    end
end