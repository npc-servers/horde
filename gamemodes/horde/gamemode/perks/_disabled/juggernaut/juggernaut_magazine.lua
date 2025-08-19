PERK.PrintName = "Luxury Magazine"
PERK.Description = "{1} increase in magazine size and {1} faster reload speed. \nWeapon overheating is removed."
PERK.Icon = "materials/perks/pioneer.png"
PERK.Hooks = {}
PERK.Params = {
    [1] = {value = 0.5, percent = true},
}

local recalc = function(ply, perk)
    if perk == "juggernaut_reload" then
        for _, wpn in pairs(ply:GetWeapons()) do
            if wpn.ArcCW then
                wpn:RecalcAllBuffs()
            end
        end
    end
end
PERK.Hooks.Horde_OnSetPerk = recalc
PERK.Hooks.Horde_OnUnsetPerk = recalc

-- You can modify ArcCW weapon stats with specially named hooks.
-- Specifically: O_Hook_STAT for overrides, M_Hook_STAT for multipliers and A_Hook_STAT for addition.
-- Edit the value in data.current
PERK.Hooks.M_Hook_Mult_ReloadTime = function(wpn, data)
    local ply = wpn:GetOwner()
	
	if IsValid(ply) and ply:IsPlayer() and ply:Horde_GetPerk("juggernaut_magazine")
            and (wpn.RegularClipSize or wpn.Primary.ClipSize) >= 1 then
        data.mult = (data.mult or 1) - 0.5
    end
end

PERK.Hooks.Hook_GetCapacity = function(wpn, data)
    local ply = wpn:GetOwner()
	if IsValid(ply) and ply:IsPlayer() and ply:Horde_GetPerk("juggernaut_magazine")
            and data >= 1 then
        return math.ceil(data * 1.5)
    end
	
end


-- You can modify ArcCW weapon stats with specially named hooks.
-- Specifically: O_Hook_STAT for overrides, M_Hook_STAT for multipliers and A_Hook_STAT for addition.
-- Edit the value in data.current
PERK.Hooks.M_Hook_Mult_HeatCapacity = function(wpn, data)
    local ply = wpn:GetOwner()
    if IsValid(ply) and ply:IsPlayer() and ply:Horde_GetPerk("juggernaut_magazine") then
        data.mult = (data.mult or 1) + 1000
    end
end

PERK.Hooks.M_Hook_Mult_HeatDissipation = function(wpn, data)
    local ply = wpn:GetOwner()
    if IsValid(ply) and ply:IsPlayer() and ply:Horde_GetPerk("juggernaut_magazine") then
        data.mult = (data.mult or 1) + 1000
    end
end