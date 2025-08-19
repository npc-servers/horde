PERK.PrintName = "Carnivorous"
PERK.Description = "{2} chance to leech {1} armor per target hit upon dealing Ballistic damage."
PERK.Icon = "materials/perks/bloodlust.png"
PERK.Params = {
    [1] = {value = 1},
	[2] = {value = 0.5, percent = true},
}

PERK.Hooks = {}
PERK.Hooks.Horde_OnPlayerDamagePost = function (ply, npc, bonus, hitgroup, dmginfo)
if not ply:Horde_GetPerk("juggernaut_armor") then return end
local p = math.random()
    if p <= 0.5 then
    if ply:Horde_GetPerk("juggernaut_armor") and HORDE:IsBallisticDamage(dmginfo) and ply:Armor() <= (ply:GetMaxArmor() - 1) then
	ply:SetArmor(ply:Armor() + 1)
    end
	end
end
