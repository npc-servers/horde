PERK.PrintName = "Energy Siphon"
PERK.Description =
[[Leeches {1} Cold damage dealt as Mind, up to {2} per hit.
Cold Spells leech {3}x more Mind from enemies with frostbite.
Summons leech {4}x more Mind from enemies with frostbite.]]
PERK.Icon = "materials/perks/necromancer/energy_siphon.png"
PERK.Params = {
    [1] = { value = 0.1, percent = true },
    [2] = { value = 5 },
    [3] = { value = 2 },
    [4] = { value = 1.5 },
}

PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamagePost = function( ply, npc, bonus, hitgroup, dmginfo )
    if not ply:Horde_GetPerk( "necromancer_energy_siphon" )  then return end
    local inflictor = dmginfo:GetInflictor()
    -- Set Up Frostbite Based Leeching Increase
     local leechMul = 1
    if npc:Horde_HasDebuff(HORDE.Status_Frostbite) and not inflictor:IsNPC() then
        leechMul = 2
    elseif npc:Horde_HasDebuff(HORDE.Status_Frostbite) and inflictor:IsNPC() and inflictor:GetNWEntity("HordeOwner"):IsPlayer() then
       leechMul = 1.5
    end
     -- Leech Mind from Cold Damage
    local leechMax = 5 * leechMul
    local leechAmount = 0.1 * leechMul
    if HORDE:IsColdDamage( dmginfo ) then
        ply:Horde_SetMind( math.min( ply:Horde_GetMaxMind(), math.min( leechMax, dmginfo:GetDamage() * leechAmount ) + ply:Horde_GetMind() ) )
    end
end
