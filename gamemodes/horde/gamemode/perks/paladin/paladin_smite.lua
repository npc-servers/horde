PERK.PrintName = "Smite"
PERK.Icon = "materials/perks/paladin/smite.png"
PERK.Description = [[
Press Shift + E to unleash a shockwave, with 8 seconds cooldown.
Enemies in your aura take 100 Lightning damage and Shock debuff. 
Allies in your aura are healed for 20% health, removing their debuffs.]]
PERK.Hooks = {}

if not SERVER then return end

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if perk ~= "paladin_smite" then return end

    if not ply:Horde_GetPerk( "paladin_dawnbrinder" ) then
        ply:Horde_SetPerkCooldown( 8 )
    end

    net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_PaladinSmite, 8 )
        net.WriteUInt( 1, 3 )
    net.Send( ply )
end

PERK.Hooks.Horde_OnUnsetPerk = function( ply, perk )
    if perk ~= "paladin_smite" then return end

    net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_PaladinSmite, 8 )
        net.WriteUInt( 0, 3 )
    net.Send( ply )
end

local healPercentage = 0.2
local dmgAmt = 100
local dmgType = DMG_SHOCK

PERK.Hooks.Horde_UseActivePerk = function( ply )
    if not ply:Horde_GetPerk( "paladin_smite" ) then return end

    local aura = ply.Horde_PaladinAura
    if not aura then return end

    local entsInside = aura.Entities
    if not entsInside then return end

    local effect = EffectData()
    effect:SetOrigin( ply:GetPos() )
    effect:SetRadius( 300 )

    util.Effect( "paladin_smite", effect, true, true )
    util.Effect( "stun_flash", effect, true, true )

    for ent, _ in pairs( entsInside ) do
        if HORDE:IsEnemy( ent ) then
            local smiteDmg = DamageInfo()
            smiteDmg:SetDamageType( dmgType )
            smiteDmg:SetAttacker( ply )
            smiteDmg:SetInflictor( ply )
            smiteDmg:SetDamage( dmgAmt )
            smiteDmg:SetDamagePosition( ent:GetPos() )

            ent:TakeDamageInfo( smiteDmg )
            ent:Horde_AddDebuffBuildup( HORDE.Status_Shock, 1000, ply, ent:GetPos() )
        elseif ent:IsPlayer() then
            local healinfo = HealInfo:New( { amount = ent:GetMaxHealth() * healPercentage, healer = ply } )
            HORDE:OnPlayerHeal( ent, healinfo )

            for debuff, _ in pairs( ent.Horde_Debuff_Buildup ) do
                ent:Horde_RemoveDebuff( debuff )
                ent:Horde_ReduceDebuffBuildup( debuff, 100000 )
            end
        end
    end
end