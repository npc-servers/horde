PERK.PrintName = "Knuckleblaster"
PERK.Icon = "materials/perks/knuckleblaster.png"
PERK.Description = [[
Doubles the Physical attack taken as explosive damage in an area.
Knuckleblaster reduces damage taken by 15%.
Recharges after 3 seconds.]]

PERK.Hooks = {}

if not SERVER then return end

-- Optimizations
local plyMeta = FindMetaTable( "Player" )
local ply_Horde_GetPerk = plyMeta.Horde_GetPerk

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if perk ~= "prototype_knuckleblaster" then return end

    ply.Horde_PrototypeNextParry = CurTime()
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if perk ~= "prototype_knuckleblaster" then return end

    ply.Horde_PrototypeNextParry = nil
end

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    if not ply_Horde_GetPerk( ply, "prototype_knuckleblaster" ) then return end
    if dmginfo:GetAttacker():IsPlayer() then return end
    
    if dmginfo:GetDamage() <= 0 then return end
    if not HORDE:IsPhysicalDamage( dmginfo ) then return end

    local curTime = CurTime()
    if ply.Horde_PrototypeNextParry > curTime then return end
    ply.Horde_PrototypeNextParry = curTime + 8

    local plyPos = ply:GetPos()

    local effect = EffectData()
    effect:SetOrigin( plyPos )
    util.Effect( "HelicopterMegaBomb", effect )

    ply:EmitSound( "horde/player/prototype/Explosion Wave.wav", 140, math.random(95, 105), 1, CHAN_STATIC )

    local dmgTaken = dmginfo:GetDamage()
    local dmg = DamageInfo()
    dmg:SetAttacker( ply )
    dmg:SetInflictor( ply )
    dmg:SetDamageType( DMG_BLAST )
    dmg:SetDamage( dmgTaken * 2 )
    dmg:SetDamageCustom( HORDE.DMG_PLAYER_FRIENDLY )
    util.BlastDamageInfo( dmg, plyPos + Vector( 0, 0, 36 ), 550 )

    bonus.resistance = bonus.resistance + 0.15
end