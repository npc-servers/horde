GADGET.PrintName = "Omnislash"
GADGET.Description = [[Phasing out of reality and repeatedly slashes the target enemy.
Each slash deals 200 damage.
Bounces to a nearby target if the main target is dead.
You are invulnerable during Omnislash.]]
GADGET.Icon = "items/gadgets/omnislash.png"
GADGET.Duration = 4
GADGET.Cooldown = 15
GADGET.Active = true
GADGET.Params = {}
GADGET.Hooks = {}

local function spawnPlayer( ply, plyPos, plyAng, plyVel, delay )
    timer.Simple( delay, function()
        if not IsValid( ply ) then return end
        if ply:GetNoDraw() == false then return end

        local health = ply:Health()
        local armor = ply:Armor()
        local flashlightOn = ply:FlashlightIsOn()

        ply.Horde_In_Omni = nil
        ply:UnSpectate()
        ply:Spawn()
        ply:UnLock()

        ply:SetNoDraw( false )
        ply:DrawViewModel( true )
        ply:SetNoTarget( false )

        ply:SetPos( plyPos )
        ply:SetEyeAngles( plyAng )
        ply:SetVelocity( plyVel )

        if flashlightOn then -- Prevents the flashlight noise from happening if you had your flashlight off
            ply:Flashlight( flashlightOn )
        end

        timer.Simple( 0, function()
            ply.Horde_Fake_Respawn = nil
            ply:SetHealth( health )
            ply:SetArmor( armor )
        end )
    end )
end

GADGET.Hooks.Horde_UseActiveGadget = function( ply )
    if CLIENT then return end
    if ply:Horde_GetGadget() ~= "gadget_omnislash" then return end

    local tr = util.TraceHull( {
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + ply:GetAimVector() * 5000,
        filter = { "player" },
        mins = Vector( -16, -16, -8 ),
        maxs = Vector( 16, 16, 8 ),
        mask = MASK_SHOT_HULL
    } )

    local ent = tr.Entity
    if not ent:IsValid() or not HORDE:IsEnemy( ent ) then
        ply:EmitSound( "items/suitchargeno1.wav" )
        ply:Horde_SetGadgetCooldown( 1 )

        return
    end

    ply:Horde_SetGadgetCooldown( 15 )
    local plyPos = ply:GetPos()
    local plyAng = ply:GetAngles()
    local plyVel = ply:GetVelocity()

    ply.Horde_In_Omni = true
    ply.Horde_Fake_Respawn = true
    ply:Spectate( OBS_MODE_CHASE )
    ply:SpectateEntity( ent )
    ply:SetNoDraw( true )
    ply:DrawViewModel( false )
    ply:SetNoTarget( true )
    ply:Lock()

    local entPos = ent:GetPos()
    for i = 1, 15 do
        timer.Simple( i * 0.1, function ()
            if not ply.Horde_In_Omni then return end
            if not IsValid( ent ) then
                for _, nearbyEnt in pairs( ents.FindInSphere( entPos, 200 ) ) do
                    if HORDE:IsEnemy( nearbyEnt ) then
                        ent = nearbyEnt
                        entPos = ent:GetPos()
                        ply:SpectateEntity( ent )
                        break
                    end
                end

                if not IsValid( ent ) then
                    spawnPlayer( ply, plyPos, plyAng, plyVel, 0.5 )
                    return
                end
            end

            local dmg = DamageInfo()
            dmg:SetAttacker( ply )
            dmg:SetInflictor( ply )
            dmg:SetDamageType( DMG_SLASH )
            dmg:SetDamage( 200 )

            if IsValid( ent ) then
                dmg:SetDamagePosition( ent:GetPos() )
                ent:TakeDamageInfo( dmg )
                sound.Play( "weapons/physcannon/energy_sing_explosion2.wav", ply:GetPos(), 100, 150 )
                local ed = EffectData()
                ed:SetOrigin( ent:GetPos() + ent:OBBCenter() )
                util.Effect( "horde_omnislash_effect", ed, true, true )
                p = ent:GetPos()
            else
                spawnPlayer( ply, plyPos, plyAng, plyVel, 0.5 )
                return
            end

            if i == 15 then
                spawnPlayer( ply, plyPos, plyAng, plyVel, 0.5 )
            end
        end )
    end
end

GADGET.Hooks.Horde_OnPlayerDebuffApply = function( ply, _, bonus )
    if ply.Horde_In_Omni then
        bonus.apply = 0
    end
end