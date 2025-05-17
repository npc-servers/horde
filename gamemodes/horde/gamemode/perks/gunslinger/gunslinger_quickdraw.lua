PERK.PrintName = "Quickdraw"
PERK.Description = [[
While holding a Pistol weapon:
  {1} increased Pistol damage.
  Adds {1} evasion.]]
PERK.Icon = "materials/perks/gunslinger/quickdraw.png"
PERK.Params = {
    [1] = {value = 0.25, percent = true},
    [2] = {value = 3},
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function (ply, npc, bonus, hitgroup, dmginfo)
    if not ply:Horde_GetPerk("gunslinger_quickdraw") then return end
    local wpn = HORDE:GetCurrentWeapon(ply)
    if not wpn:IsValid() then return end
    local wpn_class = wpn:GetClass()
    if HORDE:IsPistolItem(wpn_class) then
       bonus.increase = bonus.increase + 0.25
    end
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function (ply, dmginfo, bonus)
    if not ply:Horde_GetPerk("gunslinger_quickdraw") then return end
    local wpn = HORDE:GetCurrentWeapon(ply)
    if not wpn:IsValid() then return end
    local wpn_class = wpn:GetClass()
    if HORDE:IsPistolItem(wpn_class) then
       bonus.evasion = bonus.evasion + 0.25
    end
end