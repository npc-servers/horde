PERK.PrintName = "Negative Burst"
PERK.Description =
[[Activating spells generate a shockwave near you.
Shockwave deals damage based on spell mind cost.]]
PERK.Icon = "materials/perks/warlock/negative_burst.png"
PERK.Params = {}
PERK.Hooks = {}
PERK.Hooks.Horde_OnSpellFire = function (ply, wpn, stage, spell)
    if ply:Horde_GetPerk("warlock_negative_burst") then
        local mind_cost = spell.Mind[stage]
        local damage_amount = math.max( mind_cost * 5, 100 )
        local r = 125 + mind_cost * 2
        local o = ply:GetPos() + Vector( 0, 0, 24 )

        for _, ent in pairs( ents.FindInSphere( o, r ) ) do
            if IsValid( ent ) and ent ~= ply and ( ent:IsNPC() or ent:IsPlayer() ) then
                local dmg = DamageInfo()
                dmg:SetAttacker( ply )
                dmg:SetInflictor( wpn )
                dmg:SetDamageType( DMG_DIRECT )
                dmg:SetDamage( damage_amount )
                dmg:SetDamageCustom( HORDE.DMG_PLAYER_FRIENDLY )
                ent:TakeDamageInfo( dmg )
            end
        end

        local e = EffectData()
            e:SetOrigin( o )
            e:SetRadius( r )
        util.Effect("horde_negative_burst", e, true, true)
    end
end