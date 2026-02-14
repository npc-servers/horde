PERK.PrintName = "Smite"
PERK.Icon = "materials/perks/paladin/smite.png"
PERK.Description = [[
Press Shift + E to make your next melee hit deal additional 200 AOE 
Lightning damage, healing nearby allies by 20% health and clearing 
all debuffs from them. Cooldown: 10 seconds.]]
PERK.Hooks = {}

if not SERVER then return end

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if perk ~= "paladin_smite" then return end

    if ply:Horde_GetPerk( "paladin_dawnbrinder" ) then
        ply:Horde_SetPerkCooldown( 5 )
    else
        ply:Horde_SetPerkCooldown( 10 )
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

    ply.Horde_PaladinEmpowered = nil
    net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_PaladinEmpowered, 8 )
        net.WriteUInt( 0, 3 )
    net.Send( ply )
end

local smiteDmg = DamageInfo()
local dmgAmt = 200
local dmgType = DMG_SHOCK

PERK.Hooks.Horde_OnPlayerDamagePost = function( ply, npc, _, _, dmginfo )
    if not ply:Horde_GetPerk( "paladin_smite" ) then return end
    if not ply.Horde_PaladinEmpowered then return end
    if not HORDE:IsMeleeDamage( dmginfo ) then return end

    ply.Horde_PaladinEmpowered = nil

    net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_PaladinEmpowered, 8 )
        net.WriteUInt( 0, 3 )
    net.Send( ply )

    if IsValid( npc ) then
        npc:Horde_AddDebuffBuildup( HORDE.Status_Shock, 1000, ply, npc:GetPos() )
    end

    local aura = ply.Horde_PaladinAura
    if not aura then return end

    local entsInside = aura.Entities
    if not entsInside then return end

    local healPercent = 0.2
    local damage = dmgAmt

    if ply:Horde_GetPerk( "paladin_dawnbrinder" ) then
        damage = damage * 2
    end

    smiteDmg:SetDamageType( dmgType )
    smiteDmg:SetAttacker( ply )
    smiteDmg:SetInflictor( ply )
    smiteDmg:SetDamage( damage )

    for ent, _ in pairs( entsInside ) do
        if HORDE:IsEnemy( ent ) then
            smiteDmg:SetDamagePosition( ent:GetPos() )
            ent:TakeDamageInfo( smiteDmg )
        elseif ent:IsPlayer() then
            local healinfo = HealInfo:New( { amount = ent:GetMaxHealth() * healPercent, healer = ply } )
            HORDE:OnPlayerHeal( ent, healinfo )

            for debuff, _ in pairs( ent.Horde_Debuff_Buildup ) do
                ent:Horde_RemoveDebuff( debuff )
                ent:Horde_ReduceDebuffBuildup( debuff, 100000 )
            end
        end
    end
end

PERK.Hooks.Horde_UseActivePerk = function( ply )
    if not ply:Horde_GetPerk( "paladin_smite" ) then return end

    ply.Horde_PaladinEmpowered = true

    net.Start( "Horde_SyncActivePerk" )
        net.WriteUInt( HORDE.Status_PaladinEmpowered, 8 )
        net.WriteUInt( 1, 3 )
    net.Send( ply )
end