PERK.PrintName = "Carnivorous"
PERK.Description = [[
{1} of Ballistic damage builds up Bleeding.
Leech {3} health when dealing Ballistic damage against bleeding targets.]]
PERK.Icon = "materials/perks/bloodlust.png"
PERK.Params = {
    [1] = { value = 0.3, percent = true },
    [2] = { value = 0.05, percent = true },
    [3] = { value = 1 },
}
PERK.Hooks = {}

PERK.Hooks.Horde_OnPlayerDamage = function( ply, npc, _, _, dmginfo )
    if not ply:Horde_GetPerk( "juggernaut_carnivorous" ) then return end
    if not HORDE:IsBallisticDamage( dmginfo ) then return end

    npc:Horde_AddDebuffBuildup( HORDE.Status_Bleeding, dmginfo:GetDamage() * 0.3, ply, dmginfo:GetDamagePosition() )

    if npc:Horde_HasDebuff( HORDE.Status_Bleeding ) then
        HORDE:SelfHeal( ply, 1 )
    end
end