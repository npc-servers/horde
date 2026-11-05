SPELL.PrintName      = "Ice Coffin"
SPELL.Weapon         = {"horde_void_projector"}
SPELL.Mind           = {10}
SPELL.Price          = 750
SPELL.ChargeTime     = {0}
SPELL.ChargeRelease  = true
SPELL.Cooldown       = 20
SPELL.Slot           = HORDE.Spell_Slot_Utility
SPELL.DamageType     = { HORDE.DMG_COLD }
SPELL.Icon           = "spells/ice_coffin.png"
SPELL.Type           = {HORDE.Spell_Type_Displacement,HORDE.Spell_Type_Guard}
SPELL.Description    = [[Wraps the user in ice that provides damage/debuff immunity and health/mind regen while repelling them away, however the user becomes immobile.
Lasts for 6 seconds minus 1 second per active minion down to 3 seconds.]]
SPELL.Fire           = function (ply, wpn, charge_stage)
    --///Variables///--
    local plyVel = ply:GetVelocity() -- store player velocity so the caster is not immune to fall damage
    local plyPos = ply:GetPos()
    local bones = ply:GetBoneCount()
    local id = ply:GetCreationID()
    --///Functions///--
    local function spawnPlayer( pply, _, _, plyVel )
        if not IsValid( ply ) then return end
        ply.Horde_In_Coffin = nil
        ply.Horde_Invincible = nil
        timer.Remove("FrostbiteEffect" .. id)
        ply:SetMoveType(MOVETYPE_WALK)
        ply:SetNoDraw( false )
        ply:DrawViewModel( true )
        --ply:SetVelocity( plyVel )
        ply:SetRenderMode(RENDERMODE_NORMAL)
    end
    --///Player Disappear/Reappear Effect///--
    local function frostParticleA()
        for bone = 1, bones-1 do
            local pos, angle = ply:GetBonePosition(bone)
            local effectdata = EffectData()
            effectdata:SetOrigin(pos)
            effectdata:SetScale( 1 )
            effectdata:SetMagnitude( 1 )
            effectdata:SetRadius( 18 )
            util.Effect( "GlassImpact", effectdata, true, true )
            util.Effect("horde_status_frostbite", effectdata, true, true)
        end
    end
    --///Shockwave Effect///--
    local function frostParticleB()
        local e = EffectData()
        e:SetOrigin(plyPos)
        e:SetNormal(Vector(0,0,1))
        e:SetScale(0.8)
        util.Effect("cold_explosion", e, true, true)
    end
    --///Shockwave Core Effect///--
    local function frostParticleC()
       local pos = ply:GetPos()
       pos.z = pos.z + 50
       ParticleEffect("ice_coffin_core", pos, Angle(0,0,0), ply)
    end 
    --///Knockback & Damage Setup///--
    local function Shockwave()
	    if not ply.Horde_In_Coffin then return end
		if not ply:IsValid() then return end
		local dmg = DamageInfo()
		dmg:SetAttacker(ply)
		dmg:SetInflictor(ply)
		dmg:SetDamageType(DMG_REMOVENORAGDOLL)
		dmg:SetDamage(10)
        dmg:SetDamagePosition(plyPos)
        util.BlastDamageInfo(dmg, plyPos, 225)
		for _, ent in pairs(ents.FindInSphere(plyPos, 225)) do
            local bashKnockback = 800 /1.5
            local targetPos, bashKnockUp = ent:GetPos(), Vector( 0, 0, 125 )
            local toTarget = ( targetPos - plyPos ):GetNormalized() * Vector( 1, 1, 0 )
            local dist = ( 225 - plyPos:Distance( targetPos ) ) * 0.01
            local knockbackForce = ( ( toTarget * bashKnockback ) * dist ) + bashKnockUp
			if HORDE:IsEnemy(ent) then
				ent:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, dmg:GetDamage()/2, ply)
                if not ent:Horde_GetBossProperties() then
                    ent:SetVelocity( knockbackForce )
                end
			end
		end
        frostParticleB()
    end
    --///Freeze & heal caster///--
    ply.Horde_In_Coffin = true
    ply.Horde_Invincible = true
    ply:Horde_RemoveDebuff(debuff)
    ply:EmitSound("horde/weapons/void_projector/ice_cocoon.ogg")
    ply:SetMoveType(MOVETYPE_NONE)
    ply:DrawViewModel(false)
    frostParticleA()
    frostParticleB()
    frostParticleC()
    ply:SetRenderMode(RENDERMODE_NONE)
    timer.Create("FrostbiteEffect" .. id, 0.5, 0, function ()
        Shockwave()
        ply:Horde_ReduceDebuffBuildup(debuff, 100)
        HORDE:SelfHeal(ply, 10)
        ply:Horde_SetMind( math.min( ply:Horde_GetMaxMind(), 5 + ply:Horde_GetMind() ))
        sound.Play("horde/weapons/void_projector/void_spear_blast.ogg", plyPos, 100, math.random(70, 90))
    end)
   
    --///Unfreeze caster///--
    timer.Simple( math.max( 3, 6 - ply:Horde_GetSpectreCount(isUlt) ), function ()
        frostParticleA()
        timer.Simple(0, function ()
            spawnPlayer( ply, _, _, plyVel )
        end)
    end)
end
SPELL.Hooks = {}
SPELL.Hooks.Horde_OnPlayerDebuffApply = function( ply, _, bonus )
    if not ply.Horde_In_Coffin then return end
    bonus.apply = 0
end