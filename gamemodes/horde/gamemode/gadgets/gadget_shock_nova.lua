GADGET.PrintName = "Shock Nova"
GADGET.Description =
[[Warden Aura rapidly generates a series of shockwaves.
Each shockwave deals 50 Lightning damage.]]
GADGET.Icon = "items/gadgets/shock_nova.png"
GADGET.Duration = 5
GADGET.Cooldown = 10
GADGET.Active = true
GADGET.Params = {}
GADGET.Hooks = {}

local function AdjustZ(pos)
    local newpos = pos + Vector(0, 0, 15)
    return newpos
end

local function DoShockNova(ply, pos)
    local effectdata = EffectData()
    effectdata:SetOrigin(pos)
    util.Effect("explosion_shock", effectdata)
    local radius = ply:Horde_GetWardenAuraRadius()
    local dmg = DamageInfo()
    dmg:SetAttacker(ply)
    dmg:SetInflictor(ply)
    dmg:SetDamageType(DMG_SHOCK)
    dmg:SetDamage(50)
    util.BlastDamageInfo(dmg, pos, radius)
end

local function GetShockNovaTimerName(ply)
    return "Warden_ShocknovaTimer" .. ply:SteamID()
end

GADGET.Hooks.Horde_UseActiveGadget = function(ply)
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_shock_nova" then return end
    local timer_shocknova = GetShockNovaTimerName(ply)
    timer.Remove(timer_shocknova)
    timer.Create(timer_shocknova, 0.25, 5, function()
        if not IsValid(ply) then timer.Remove(timer_shocknova) return end

        local positions = { AdjustZ(ply:GetPos()) }

        if ply.Horde_GetPerk and ply:Horde_GetPerk("warden_ex_machina") then
            local towers = HORDE.player_drop_entities and HORDE.player_drop_entities[ply:SteamID()]
            if towers then
                for _, ent in pairs(towers) do
                    if IsValid(ent) and ent.Horde_WardenAura then
                        table.insert(positions, AdjustZ(ent:GetPos()))
                    end
                end
            end
            local extra = ply.Horde_Extra_Watchtower
            if extra and IsValid(extra) and extra.Horde_WardenAura then
                table.insert(positions, AdjustZ(extra:GetPos()))
            end
        end

        for _, pos in ipairs(positions) do
            DoShockNova(ply, pos)
        end
    end)
end

GADGET.Hooks.Horde_OnUnsetGadget = function(ply, gadget)
    if CLIENT then return end
    if gadget ~= "gadget_shock_nova" then return end
    timer.Remove(GetShockNovaTimerName(ply))
end