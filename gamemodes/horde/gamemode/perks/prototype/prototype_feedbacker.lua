PERK.PrintName = "Feedbacker"
PERK.Icon = "materials/perks/feedbacker.png"
PERK.Description = [[
Parries killing blows dealt as Physical damage.
Feedbacker applies Stun and Shock in an area.
Recharges after 12 seconds.]]

PERK.Hooks = {}

if not SERVER then return end

-- Optimizations
local plyMeta = FindMetaTable( "Player" )
local ply_Horde_GetPerk = plyMeta.Horde_GetPerk

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if perk ~= "prototype_feedbacker" then return end

    ply.Horde_PrototypeNextParry = CurTime()
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if perk ~= "prototype_feedbacker" then return end

    ply.Horde_PrototypeNextParry = CurTime()
end

PERK.Hooks.Horde_OnPlayerDamageTakenPost = function( ply, dmginfo )
    if not ply_Horde_GetPerk( ply, "prototype_feedbacker" ) then return end

    local attacker = dmginfo:GetAttacker()
    if IsValid( attacker ) and attacker:IsPlayer() then return end

    local dmg = dmginfo:GetDamage()
    if dmg <= 0 then return end
    if not HORDE:IsPhysicalDamage( dmginfo ) then return end
    if dmg < ply:Health() then return end

    local curTime = CurTime()
    if ply.Horde_PrototypeNextParry > curTime then return end
    ply.Horde_PrototypeNextParry = curTime + 12

    local plyPos = ply:GetPos()

    local effect = EffectData()
    effect:SetOrigin( plyPos + Vector( 0, 0, 30 ) )
    util.Effect( "horde_aerial_parry", effect, true, true )

    local randId = tostring( math.random( 1, 2 ) )
    ply:EmitSound( "horde/player/prototype/punch_projectile.ogg", 90, math.random( 95, 105 ), 1, CHAN_AUTO )

    local nearbyEnts = ents.FindInSphere( plyPos, 225 )
    for _, ent in ipairs( nearbyEnts ) do
        if HORDE:IsEnemy( ent ) then
            ent:Horde_AddDebuffBuildup( HORDE.Status_Shock, 99999, ply, ent:GetPos() )
            ent:Horde_AddDebuffBuildup( HORDE.Status_Stun, 99999, ply, ent:GetPos() )
        end
    end

    dmginfo:SetDamage( 0 )

    return true
end
