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

PERK.Hooks.Horde_OnPlayerDamagePost = function ( ply, npc, bonus, hitgroup, dmginfo )
    if not ply:Horde_GetPerk( "necromancer_energy_siphon" )  then return end
    local inflictor = dmginfo:GetInflictor()
    local leechmul = 1
    local leechmax = 5 * leechmul
    local leechamount = 0.1 * leechmul
     -- Leech Mind from Cold Damage
    if HORDE:IsColdDamage( dmginfo ) and not inflictor:IsNPC() then
        ply:Horde_SetMind( math.min( ply:Horde_GetMaxMind(), math.min( leechmax, dmginfo:GetDamage() * leechamount ) + ply:Horde_GetMind() ) )
    elseif HORDE:IsColdDamage( dmginfo ) and inflictor:IsNPC() and inflictor:GetNWEntity("HordeOwner"):IsPlayer() then
        ply:Horde_SetMind( math.min( ply:Horde_GetMaxMind(), math.min( leechmax, dmginfo:GetDamage() * leechamount ) + ply:Horde_GetMind() ) )
    end
   -- Set Up Frostbite Based Leeching Increase
    if HORDE:IsColdDamage( dmginfo ) and not inflictor:IsNPC() then
        leechmul = 2
    elseif HORDE:IsColdDamage( dmginfo ) and inflictor:IsNPC() and inflictor:GetNWEntity("HordeOwner"):IsPlayer() then
       leechmul = 1.5
    end
end
