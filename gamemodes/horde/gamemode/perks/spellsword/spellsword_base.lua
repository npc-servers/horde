PERK.PrintName = "Spellsword Base"
PERK.Description = [[
The Spellsword Subclass 
COMPLEXITY: HIGH

{1} increased maximum Mind. ({2} per level, up to {3}).

Uses Mind instead of Armor.
Has access to spells for Astral Relic.]]
PERK.Icon = "materials/subclasses/warlock.png"
PERK.Params = {
    [1] = { percent = true, base = 0, level = 0.01, max = 0.25, classname = "Warlock" },
    [2] = { value = 0.01, percent = true },
    [3] = { value = 0.25, percent = true },
}
PERK.Hooks = {}

if CLIENT then
    PERK.Hooks.Horde_OnSetPerk = function( _, perk )
        if perk ~= "spellsword_base" then return end

        local magic = {}
        net.Receive( "Horde_SpellSword_SyncCombo", function()
            magic = net.ReadTable() or {}
        end )

        hook.Add( "HUDPaint", "Horde_Spellsword_HUD", function()
            local m1 = magic[1] or 0
            local m2 = magic[2] or 0
            local m3 = magic[3] or 0
            local m4 = magic[4] or 0
            draw.RoundedBox( 0, ScrW() - 410, ScrH() - 80, 150, 50, Color( 50, 50, 50, 150 ) )
            draw.DrawText( m1 .. m2 .. m3 .. m4, "Trebuchet24", ScrW() - 410 + 150 / 2, ScrH() - 62, color_white, TEXT_ALIGN_CENTER )
        end )
    end

    PERK.Hooks.Horde_OnUnSetPerk = function( _, perk )
        if perk ~= "spellsword_base" then return end
        hook.Remove( "HUDPaint", "Horde_Spellsword_HUD" )
    end
end

if not SERVER then return end

util.AddNetworkString( "Horde_SpellSword_SyncCombo" )

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if perk ~= "spellsword_base" then return end

    ply:Horde_SetPerkCooldown( 0 )

    ply:Horde_SetMindRegenTick( 0.25 )
    ply:SetMaxArmor( 0 )

    timer.Simple( 0, function()
        if not IsValid( ply ) or not ply:Alive() then return end

        local bonus = { increase = 0, more = 1, add = 0 }
        hook.Run( "Horde_OnSetMaxMind", ply, bonus )
        ply:Horde_SetMaxMind( 100 * bonus.more * ( 1 + bonus.increase ) + bonus.add )
        ply:Horde_SetMind( ply:Horde_GetMaxMind() )
    end )

    ply.Horde_magic = {}
    ply.Horde_cooldown = {
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 0,
    }
end

PERK.Hooks.Horde_OnUnSetPerk = function( ply, perk )
    if perk ~= "spellsword_base" then return end

    ply:Horde_SetMaxMind( 0 )
    ply:Horde_SetMind( 0 )
    ply:Horde_SetMindRegenTick( 0 )
    ply:SetMaxArmor( 100 )

    ply.Horde_magic = nil
end

local function insertkey( ply, value )
    if ply.Horde_cooldown[value] >= CurTime() then return end
    if #ply.Horde_magic >= 4 then
        table.remove( ply.Horde_magic, 1 )
    end

    ply.Horde_cooldown[value] = CurTime() + -1
    table.insert( ply.Horde_magic, value )

    net.Start( "Horde_SpellSword_SyncCombo" )
        net.WriteTable( ply.Horde_magic )
    net.Send( ply )
end

PERK.Hooks.PlayerSwitchFlashlight = function ( ply, switchOn )
    if not ply:Horde_GetPerk( "spellsword_base" ) then return end
    if switchOn then
        insertkey( ply, 4 )
    else
        return true
    end

    return false
end

PERK.Hooks.KeyPress = function( ply, key )
    if not ply:Horde_GetPerk( "spellsword_base" ) then return end
    if key == IN_ATTACK then
        insertkey( ply, 1 )
    elseif key == IN_ATTACK2 then
        insertkey( ply, 2 )
    elseif key == IN_RELOAD then
        insertkey( ply, 3 )
    end
end

--[[ 1 is damage incantations, 2 is buff incantations, 3 is special incantations, 4 is movement incantations. ]]

--[[
["0,0,0,0"] = {
    name = string,
    cost = int,
    func = function
}
]]

local incantations = {
    ["1,1,1,1"] = {
        name = "Explosion",
        cost = 0,
        func = function( ply )
            util.BlastDamage( ply, ply, ply:EyePos(), 150, 250 )
            local explosion = ents.Create( "env_explosion" )
            explosion:SetPos( ply:GetPos() )
            explosion:SetOwner( ply )
            explosion:Spawn()
            explosion:SetKeyValue( "iMagnitude", "50" )
            explosion:Fire( "Explode", 0, 0 )
            ply:Horde_AddDebuffBuildup( HORDE.Status_Ignite, 50, ply )
        end
    },
    ["1,4,4,3"] = {
        name = "Mini Black Hole",
        cost = 0,
        func = function( ply )
            local pos = ply:EyePos()

            sound.Play( "horde/spells/black_hole.ogg", pos, 100, 50, 1, CHAN_AUTO )
            local trail = ents.Create( "info_particle_system" )
            trail:SetKeyValue( "effect_name", "black_hole" )
            trail:SetOwner( ply )
            trail:SetPos( pos )
            trail:SetAngles( ply:GetAngles() )
            trail:Spawn()
            trail:Activate()
            trail:Fire( "start", "", 0 )
            trail:Fire( "Kill", "", 5 )

            for i = 1, 17 do
                timer.Simple( ( i - 1 ) * 0.2, function ()
                    for _, ent in pairs( ents.FindInSphere( pos, 750 ) ) do
                        if not IsValid( ent ) then goto cont end
                        if not HORDE:IsEnemy( ent ) then goto cont end

                        local dir = -( ent:GetPos() - pos )
                        local acc = math.max( 500 * 1.05 - dir:Length(), 0 ) * 0.03
                        acc = math.Round( acc )
                        acc = acc * acc

                        local phys = ent:GetPhysicsObject()
                        if ( IsValid( phys ) ) then
                            local velo = ( dir * acc )
                            phys:ApplyForceOffset( velo, ent:GetPos() )
                            ent:SetVelocity( dir * acc * 0.01 )
                        end

                        ::cont::
                    end
                end )
            end
        end
    },
    ["1,4,4,4"] = {
        name = "Launch",
        cost = 0,
        func = function( ply )
            local tr = util.TraceLine( {
                start = ply:GetShootPos(),
                endpos = ply:GetShootPos() + ply:GetAimVector() * 2000,
                filter = ply,
                mask = MASK_SOLID
            } )

            if not tr.Hit then return end
            if not IsValid( tr.Entity ) then return end
            if not HORDE:IsEnemy( tr.Entity ) or tr.Entity:Horde_IsElite() then return end

            tr.Entity:SetLocalVelocity( Vector( 0, 0, 2000 ) )
        end
    },
    ["1,1,3,4"] = {
        name = "Firework",
        cost = 0,
        func = function( ply )
            local tr = util.TraceLine( {
                start = ply:GetShootPos(),
                endpos = ply:GetShootPos() + ply:GetAimVector() * 1500,
                filter = ply,
                mask = MASK_SOLID
            } )

            if not tr.Hit then return end
            if not IsValid( tr.Entity ) then return end
            if not HORDE:IsEnemy( tr.Entity ) or tr.Entity:Horde_IsElite() then return end

            local dmg = DamageInfo()
            dmg:SetAttacker( ply )
            dmg:SetInflictor( ply )
            dmg:SetDamageType( DMG_BLAST )
            dmg:SetDamage( 150 )

            tr.Entity:SetLocalVelocity( Vector( 0, 0, 1000 ) )
            tr.Entity:TakeDamageInfo( dmg )
            local explosion = ents.Create( "env_explosion" )
            explosion:SetPos( tr.Entity:GetPos() )
            explosion:SetOwner( tr.Entity )
            explosion:Spawn()
            explosion:SetKeyValue( "iMagnitude", "0" )
            explosion:Fire( "Explode", 0, 0 )
        end
    },
    ["2,2,1,1"] = {
        name = "Absorb Elements",
        cost = 0,
        func = function( ply )
            ply:Horde_ReduceDebuffBuildup( HORDE.Status_Frostbite, 20 )
            ply:Horde_ReduceDebuffBuildup( HORDE.Status_Ignite, 20 )
            ply:Horde_ReduceDebuffBuildup( HORDE.Status_Shock, 20 )
        end -- jank with cost and bleed effect https://youtu.be/oiJt4glvwXY
    },
    ["2,2,3,1"] = {
        name = "Gentle Repose",
        cost = 0,
        func = function( ply )
            ply:Horde_ReduceDebuffBuildup( HORDE.Status_Decay, 40 )
            ply:Horde_ReduceDebuffBuildup( HORDE.Status_Necrosis, 40 )
            ply:Horde_AddDebuffBuildup( HORDE.Status_Break, 25, ply )
        end
    },
    ["2,2,2,2"] = {
        name = "",
        cost = 0,
        func = function( ply )
            ply:Horde_AddBarrierStack( 10 )
        end
    },

    -- flight
    ["4,4,3,3"] = {
        name = "Longstrider",
        cost = 0,
        func = function( ply )
            local forward = ply:GetForward()
            local forwardForce = forward * ( ply:IsOnGround() and 1500 or 1000 )
            ply:SetLocalVelocity( forwardForce )
        end
    },
    ["3,3,4,4"] = {
        name = "Expeditious Retreat",
        cost = 0,
        func = function( ply )
            local forward = ply:GetForward()
            local forwardForce = forward * ( ply:IsOnGround() and -1500 or -1000 )
            ply:SetLocalVelocity( forwardForce )
        end
    },
    ["4,4,4,4"] = {
        name = "Catapult",
        cost = 0,
        func = function( ply )
            ply:SetLocalVelocity( Vector( 0, 0, 2500 ) )
        end
    },

    -- swap
    ["3,4,4,3"] = {
        name = "",
        cost = 0,
        func = function( ply )
            local tr = util.TraceLine( {
                start = ply:GetShootPos(),
                endpos = ply:GetShootPos() + ply:GetAimVector() * 8000,
                filter = ply,
                mask = MASK_SOLID
            } )

            if not tr.Hit then return end
            if not IsValid( tr.Entity ) then return end
            if not HORDE:IsEnemy( tr.Entity ) or tr.Entity:Horde_IsElite() then return end

            local oldPos = tr.Entity:GetPos()
            tr.Entity:SetPos( ply:GetPos() )
            ply:SetPos( oldPos )
        end
    },
    ["4,3,3,4"] = {
        name = "",
        cost = 0,
        func = function( ply )
            local tr = util.TraceLine( {
                start = ply:GetShootPos(),
                endpos = ply:GetShootPos() + ply:GetAimVector() * 8000,
                filter = ply,
                mask = MASK_SOLID
            } )

            if not tr.Hit then return end
            if not IsValid( tr.Entity ) then return end
            if not tr.Entity:IsPlayer() then return end

            local oldPos = tr.Entity:GetPos()
            tr.Entity:SetPos( ply:GetPos() )
            ply:SetPos( oldPos )
        end
    },
    -- teleport to
    ["4,4,3,2"] = {
        name = "",
        cost = 0,
        func = function( ply )
            local tr = util.TraceLine( {
                start = ply:GetShootPos(),
                endpos = ply:GetShootPos() + ply:GetAimVector() * 8000,
                filter = ply,
                mask = MASK_SOLID
            } )

            if not tr.Hit then return end
            if not IsValid( tr.Entity ) then return end
            if not HORDE:IsEnemy( tr.Entity ) then return end

            ply:SetPos( tr.Entity:GetPos() )
        end
    },
    ["2,3,4,4"] = {
        name = "",
        cost = 0,
        func = function( ply )
            local tr = util.TraceLine( {
                start = ply:GetShootPos(),
                endpos = ply:GetShootPos() + ply:GetAimVector() * 8000,
                filter = ply,
                mask = MASK_SOLID
            } )

            if not tr.Hit then return end
            if not IsValid( tr.Entity ) then return end
            if not tr.Entity:IsPlayer() then return end

            ply:SetPos( tr.Entity:GetPos() )
        end
    },
}

local function castSpell( ply )
    local casting = ply.Horde_magic
    if not casting or #casting < 4 then return end

    local key = table.concat( casting, "," )

    local incantation = incantations[key]
    if incantation then
        incantation.func( ply )
        ply:ChatPrint( "Casted " .. incantation.name )
        ply:TakeDamage( incantation.cost, Entity( 0 ), Entity( 0 ) )
    else
        local explosion = ents.Create( "env_explosion" )
        explosion:SetPos( ply:GetPos() )
        explosion:SetOwner( ply )
        explosion:Spawn()
        explosion:SetKeyValue( "iMagnitude", "150" )
        explosion:Fire( "Explode", 0, 0 )

        ply:ChatPrint( "fool" )
        ply:Kill()
    end
end

PERK.Hooks.Horde_UseActivePerk = function( ply )
    if not ply:Horde_GetPerk( "spellsword_base" ) then return end

    castSpell( ply )
end