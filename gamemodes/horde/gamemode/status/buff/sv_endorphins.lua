
local plymeta = FindMetaTable("Player")

function plymeta:Horde_AddEndorphins(override_max)
    if not override_max or self:Horde_GetMaxEndorphins() > 0 then
        self.Horde_Endorphins = math.min(self:Horde_GetMaxEndorphins(), self.Horde_Endorphins + 1)
    else
        self.Horde_Endorphins = math.min(2, self.Horde_Endorphins + 1)
    end
    self.Horde_EndorphinsAdded = true
    timer.Remove("Horde_EndorphinsTracker" .. self:SteamID())
    timer.Create("Horde_EndorphinsTracker" .. self:SteamID(), self:Horde_GetEndorphinsDuration(), 1, function()
        if not self:IsValid() then return end
        self.Horde_EndorphinsAdded = nil
        self:Horde_RemoveEndorphins()
    end)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Endorphins, 8)
        net.WriteUInt(self.Horde_Endorphins, 8)
    net.Send(self)
end

function plymeta:Horde_RemoveEndorphins()
    if not self:IsValid() then return end
    if self.Horde_Endorphins <= 0 then return end
    if self.Horde_EndorphinsAdded then return end
    self.Horde_Endorphins = math.max(0, self.Horde_Endorphins - 1)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(HORDE.Status_Endorphins, 8)
        net.WriteUInt(self.Horde_Endorphins, 8)
    net.Send(self)
    timer.Create("Horde_EndorphinsTracker" .. self:SteamID(), self:Horde_GetEndorphinsDuration(), 1, function()
        self:Horde_RemoveEndorphins()
    end)
end

function plymeta:Horde_GetEndorphins()
    return self.Horde_Endorphins or 0
end

function plymeta:Horde_SetMaxEndorphins(stack)
    self.Horde_MaxEndorphins = math.max(0, stack)
end

function plymeta:Horde_GetMaxEndorphins()
    return self.Horde_MaxEndorphins or 0
end

function plymeta:Horde_SetEndorphinsDuration(duration)
    self.Horde_EndorphinsDuration = duration
end

function plymeta:Horde_GetEndorphinsDuration()
    return self.Horde_EndorphinsDuration or 4
end

function plymeta:Horde_GetEndorphinsEnabled()
    return self.Horde_EndorphinsEnabled
end

function plymeta:Horde_SetEndorphinsEnabled(enabled)
    self.Horde_EndorphinsEnabled = enabled
end

function plymeta:Horde_GetEndorphicResonanceEnabled()
    if not self:IsValid() then return end
    return self.Horde_EndorphicResonanceEnabled
end

function plymeta:Horde_SetEndorphicResonanceEnabled(enabled)
    self.Horde_EndorphicResonanceEnabled = enabled
end

--evasion is defined in sh_damage and is not a status, and does not have a status script dedicated to it
hook.Add("Horde_OnPlayerDamageTaken", "Horde_EndorphinsDamageTaken", function(ply, dmginfo, bonus)
    if ply:Horde_GetEndorphins() > 0  then
        bonus.evasion = bonus.evasion + ply:Horde_GetEndorphins() * 0.1
    end
end)


hook.Add("Horde_OnEnemyKilled", "Horde_EndorphinsApply", function(victim, killer, wpn)
    if killer:Horde_GetMaxEndorphins() <= 0 then return end
    killer:Horde_AddEndorphins()
    if killer:Horde_GetEndorphicResonanceEnabled() then
        for _, ent in pairs(ents.FindInSphere(killer:GetPos(), 200)) do
            if ent:IsValid() and ent:IsPlayer() and ent:Alive() and not (ent:IsBot()) and (ent ~= killer) then
                ent:Horde_AddEndorphins(true)
            end
        end
    end
end)

hook.Add("Horde_ResetStatus", "Horde_EndorphinsReset", function(ply)
    ply.Horde_Endorphins = 0
    ply.Horde_MaxEndorphins = 0
    ply.Horde_EndorphinsDuration = 4
    ply.Horde_EndorphinsAdded = nil
end)