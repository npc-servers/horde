PERK.PrintName = "Spellsword Base"
PERK.Description = [[
The Spellsword Subclass 
COMPLEXITY: HIGH

{1} increased regen Mind. ({2} per level, up to {3}).
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
    -- cache for perf
    local ScrW = ScrW
    local ScrH = ScrH

    local magic = {}

    net.Receive( "Horde_SpellSword_SyncCombo", function()
        magic = net.ReadTable() or {}
    end )

    local bgW = 60
    local bgH = 28
    local bgCol = Color( 50, 50, 50, 150 )

    hook.Add( "HUDPaint", "Horde_Spellsword_HUD", function()
        if not MySelf:Horde_GetPerk( "spellsword_base" ) then
            return
        end

        local keyPosX = ScrW() / 2
        local keyPosY = ScrH() / 1.85

        local key1 = magic[1] or 0
        local key2 = magic[2] or 0
        local key3 = magic[3] or 0
        local key4 = magic[4] or 0

        draw.RoundedBox( 0, keyPosX - bgW / 2, keyPosY + bgH / 2 - 24 / 2 - 2, bgW, bgH, bgCol )
        draw.DrawText( key1 .. key2 .. key3 .. key4, "Trebuchet24", keyPosX, keyPosY, color_white, TEXT_ALIGN_CENTER )
    end )
end

if not SERVER then return end

util.AddNetworkString( "Horde_SpellSword_SyncCombo" )

PERK.Hooks.Horde_PrecomputePerkLevelBonus = function( ply )
    ply:Horde_SetPerkLevelBonus( "spellsword_mindregenbonus", math.min( 8, 0.32 * ply:Horde_GetLevel( "Spellsword" ) ) )
    ply:Horde_SetPerkLevelBonus( "spellsword_maxmindbonus", math.min( 1, 0.04 * ply:Horde_GetLevel( "Spellsword" ) ) )
end

PERK.Hooks.Horde_OnSetMaxMind = function( ply, bonus )
    if not ply:Horde_GetPerk( "spellsword_base" ) then return end

    bonus.more = bonus.more + ply:Horde_GetPerkLevelBonus( "spellsword_maxmindbonus" )
end

PERK.Hooks.Horde_OnSetPerk = function( ply, perk )
    if perk ~= "spellsword_base" then return end

    ply:Horde_SetPerkCooldown( 1 )

    ply:Horde_SetMindRegenTick( 8 / ply:Horde_GetPerkLevelBonus( "spellsword_mindregenbonus" ) )
    ply:SetMaxArmor( 0 )

    -- TODO: Change these variables later
    ply.Horde_magic = ply.Horde_magic or {}
    ply.Horde_magicCooldowns = ply.Horde_magicCooldowns or {}

    timer.Simple( 0, function()
        if not IsValid( ply ) or not ply:Alive() then return end

        local bonus = { increase = 0, more = 1, add = 0 }
        hook.Run( "Horde_OnSetMaxMind", ply, bonus )
        ply:Horde_SetMaxMind( 100 * bonus.more * ( 1 + bonus.increase ) + bonus.add )

        net.Start( "Horde_SpellSword_SyncCombo" )
            net.WriteTable( ply.Horde_magic )
        net.Send( ply )
    end )
end

PERK.Hooks.Horde_OnUnSetPerk = function( ply, perk )
    if perk ~= "spellsword_base" then return end

    ply:Horde_SetMaxMind( 0 )
    ply:Horde_SetMind( 0 )
    ply:Horde_SetMindRegenTick( 0 )
    ply:SetMaxArmor( 100 )

    -- TODO: Change these variables later
    ply.Horde_magic = nil
    ply.Horde_magicCooldowns = nil
end

local function insertkey( ply, value )
    if #ply.Horde_magic >= 4 then
        table.remove( ply.Horde_magic, 1 )
    end

    table.insert( ply.Horde_magic, value )

    net.Start( "Horde_SpellSword_SyncCombo" )
        net.WriteTable( ply.Horde_magic )
    net.Send( ply )
end

PERK.Hooks.PlayerSwitchFlashlight = function ( ply, switchOn )
    if not ply:Horde_GetPerk( "spellsword_base" ) then return end
    if not switchOn then return true end

    insertkey( ply, 4 )

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

--[[
1 is combat incantations, 2 is buff/debuff incantations, 3 is utility incantations, 4 is movement incantations.

["0,0,0,0"] = {
    name = string,
    cost = int,
    cooldown = int,
    func = function
}
]]

local incantations = {
    ["1,1,1,1"] = {
        name = "Explosion",
        cost = 15,
        cooldown = 0,
        func = function( ply )
            util.BlastDamage( ply, ply, ply:EyePos(), 150, 150 )
            local explosion = ents.Create( "env_explosion" )
            explosion:SetPos( ply:GetPos() )
            explosion:SetOwner( ply )
            explosion:Spawn()
            explosion:SetKeyValue( "iMagnitude", "50" )
            explosion:Fire( "Explode", 0, 0 )
            ply:Horde_AddDebuffBuildup( HORDE.Status_Ignite, 50, ply )
        end
    },
    ["1,1,2,3"] = {
        name = "Shocking Grasp",
        cost = 45,
        cooldown = 5,
        func = function( ply )
            local tr = util.TraceLine( {
                start = ply:GetShootPos(),
                endpos = ply:GetShootPos() + ply:GetAimVector() * 250,
                filter = ply,
                mask = MASK_SOLID
            } )

            if not tr.Hit then return end
            if not IsValid( tr.Entity ) then return end
            if not HORDE:IsEnemy( tr.Entity ) then return end

            local dmg = DamageInfo()
            dmg:SetAttacker( ply )
            dmg:SetInflictor( ply )
            dmg:SetDamageType( DMG_SHOCK )
            dmg:SetDamage( 200 )

            tr.Entity:EmitSound( "ArcCW_Horde.GSO.TASER.Hit" )
            tr.Entity:Horde_AddDebuffBuildup( HORDE.Status_Stun, 5000, ply )
            tr.Entity:TakeDamageInfo( dmg )
        end
    },
    ["1,4,1,2"] = {
        name = "Witch Bolt",
        cost = 15,
        cooldown = 3,
        func = function( ply )
            local ar = ply:EyeAngles()

            local witchbolt = ents.Create( "projectile_horde_witch_bolt" )
            witchbolt:SetAngles( Angle( 0, ar.y, 0 ) )
            witchbolt:SetPos( ply:EyePos() + ar:Forward() * 10 )

            witchbolt:SetOwner( ply )
            witchbolt:Spawn()

            local phys = witchbolt:GetPhysicsObject()
            if phys then
                phys:SetVelocity( ar:Forward() * 8000 )
            end
        end
    },
    ["1,4,1,3"] = {
        name = "Magic Missile",
        cost = 35,
        cooldown = 15,
        func = function( ply )
            for i = 1, 3 do
                timer.Simple( i * 0.2, function()
                    local ar = ply:EyeAngles()

                    local magicmissile = ents.Create( "obj_horde_mini_rocket" )
                    magicmissile:SetPos( ply:EyePos() + ar:Forward() * 10 )
                    magicmissile:SetAngles( Angle( 0, ar.y, 0 ) )
                    magicmissile:SetOwner( ply )
                    magicmissile:Spawn()

                    local phys = magicmissile:GetPhysicsObject()
                    if phys then
                        phys:SetVelocity( ar:Forward() * 8000 )
                    end
                end )
            end
        end
    },
    ["1,4,4,3"] = {
        name = "Mini Black Hole",
        cost = 80,
        cooldown = 35,
        func = function( ply )
            local pos = ply:EyePos()

            sound.Play( "horde/spells/black_hole.ogg", pos, 100, 50, 1, CHAN_AUTO )
            local trail = ents.Create( "info_particle_system" )
            trail:SetKeyValue( "effect_name", "tiny_black_hole_core" )
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
        cost = 20,
        cooldown = 3,
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
        cost = 30,
        cooldown = 10,
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
    -- 
    ["2,2,2,3"] = {
        name = "Absorb Elements",
        cost = 35,
         cooldown = 5,
        func = function( ply )
            ply:Horde_ReduceDebuffBuildup( HORDE.Status_Frostbite, 35 )
            ply:Horde_ReduceDebuffBuildup( HORDE.Status_Ignite, 35 )
            ply:Horde_ReduceDebuffBuildup( HORDE.Status_Shock, 35 )
        end
    },
    ["2,2,3,1"] = {
        name = "Gentle Repose",
        cost = 40,
         cooldown = 10,
        func = function( ply )
            ply:Horde_ReduceDebuffBuildup( HORDE.Status_Decay, 50 )
            ply:Horde_ReduceDebuffBuildup( HORDE.Status_Necrosis, 50 )
            ply:Horde_AddDebuffBuildup( HORDE.Status_Break, 25, ply )
        end
    },
    ["2,2,2,2"] = {
        name = "",
        cost = 25,
        cooldown = 3,
        func = function( ply )
            ply:Horde_AddBarrierStack( 15 )
        end
    },
    ["2,2,3,3"] = {
        name = "",
        cost = 15,
        cooldown = 5,
        func = function( ply )
            local rf = RecipientFilter()
            rf:AddPlayer( ply )
            local ranmusic = {
                "horde/music/alpha_gonome.mp3",
                "horde/music/gamma_gonome.mp3",
                "horde/music/hell_knight.mp3",
                "horde/music/mutated_hulk.mp3",
                "horde/music/plague_berserker.mp3",
                "horde/music/plague_demolitionist.mp3",
                "horde/music/plague_heavy.mp3",
                "horde/music/plague_platoon.mp3",
                "horde/music/wallace_breen.mp3",
                "horde/music/xen_destroyer_unit.mp3",
                "horde/music/xen_host_unit.mp3",
                "horde/music/xen_psychic_unit.mp3",
                "horde/music/xen_reanimator_unit.mp3"
            }
            ply:EmitSound( ranmusic[math.random( 1, #ranmusic )], 50, 100, 1, CHAN_AUTO, SND_NOFLAGS, 1, rf )
        end
    },
    ["2,2,3,1"] = {
        name = "Find Familiar",
        cost = 40,
        cooldown = 10,
        func = function( ply )
            local headcrab = ents.Create( "npc_vj_horde_headcrab" )
            headcrab:SetPos( ply:GetPos() + ply:GetForward() * 50 + Vector( 0, 0, 1 ) * 10 )
            headcrab:Spawn()
            headcrab:SetNWEntity( "HordeOwner", ply )
            headcrab:CallOnRemove( "explodecrab", function( ent )
                local explosion = ents.Create( "env_explosion" )
                explosion:SetPos( ent:GetPos() )
                explosion:Spawn()
                explosion:SetKeyValue( "iMagnitude", "0" )
                explosion:Fire( "Explode", 0, 0 )
                util.BlastDamage( ent, ent, headcrab:EyePos(), 50, 250 )
            end )
        end
    },
    ["2,2,3,2"] = {
        name = "Goodberry",
        cost = 30,
        cooldown = 15,
        func = function( ply )
            for _ = 1, 3 do
                local Goodberry = ents.Create( "horde_healthvial" )
                Goodberry:SetPos( ply:GetPos() + Vector( math.random( 100 ), math.random( 100 ), 5 ) )
                Goodberry:SetOwner( ply )
                Goodberry:Spawn()
            end
        end
    },

    -- flight
    ["4,4,3,3"] = {
        name = "Longstrider",
        cost = 10,
        func = function( ply )
            local forward = ply:GetForward()
            local forwardForce = forward * ( ply:IsOnGround() and 1500 or 1000 )
            ply:SetLocalVelocity( forwardForce )
        end
    },
    ["3,3,4,4"] = {
        name = "Expeditious Retreat",
        cost = 10,
        func = function( ply )
            local forward = ply:GetForward()
            local forwardForce = forward * ( ply:IsOnGround() and -1500 or -1000 )
            ply:SetLocalVelocity( forwardForce )
        end
    },
    ["4,4,4,4"] = {
        name = "Catapult",
        cost = 150,
        func = function( ply )
            ply:SetLocalVelocity( Vector( 0, 0, 2500 ) )
        end
    },

    -- swap
    ["3,4,4,3"] = {
        name = "",
        cost = 180,
        cooldown = 100,
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
        cost = 180,
        cooldown = 100,
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
    ["4,4,3,1"] = {
        name = "",
        cost = 60,
        cooldown = 25,
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
        cost = 60,
        cooldown = 25,
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

local function failCast( ply, msg )
    HORDE:SendNotification( msg, 1, ply )
    ply:EmitSound( "items/suitchargeno1.wav" )
end

local function castSpell( ply, incantation, curMind, curHP, healthCost )
    incantation.func( ply )

    ply:ChatPrint( "Casted " .. incantation.name )

    if healthCost and healthCost > 0 then
        ply:SetHealth( curHP - healthCost )
        ply:Horde_SetMind( 0 )

        return
    end

    ply:Horde_SetMind( curMind - incantation.cost )
end --this making errors with mind cost

PERK.Hooks.Horde_UseActivePerk = function( ply )
    if not ply:Horde_GetPerk( "spellsword_base" ) then return end

    local casting = ply.Horde_magic
    if not casting or #casting < 4 then return end

    local key = table.concat( casting, "," )

    local incantation = incantations[key]
    if not incantation then
        local explosion = ents.Create( "env_explosion" )
        explosion:SetPos( ply:GetPos() )
        explosion:SetOwner( ply )
        explosion:Spawn()
        explosion:SetKeyValue( "iMagnitude", "150" )
        explosion:Fire( "Explode", 0, 0 )

        ply:ChatPrint( "fool" )
        ply:Kill()

        return
    end

    if incantation.cooldown then
        local curTime = CurTime()

        if ply.Horde_magicCooldowns[key] and ply.Horde_magicCooldowns[key] >= curTime then
            failCast( ply, string.format( "%s is on cooldown for %i more seconds", incantation.name, ply.Horde_magicCooldowns[key] - curTime ) )

            return
        end

        ply.Horde_magicCooldowns[key] = curTime + incantation.cooldown
    end

    local curMind = ply:Horde_GetMind()

    if incantation.cost > curMind then
        if ply:Horde_GetGadget() ~= "gadget_blood_sacrifice" then
            failCast( ply, "You do not have enough mind to cast this spell!" )

            return
        end

        local remaining = incantation.cost - curMind
        local hp = ply:Health()

        if remaining >= hp then
            failCast( ply, "You do not have enough mind and hp to cast this spell!" )

            return
        end

        incantation.func( ply )
        ply:ChatPrint( "Casted " .. incantation.name )
        ply:SetHealth( hp - remaining )
        ply:Horde_SetMind( 0 )

        return
    end

    castSpell( ply, incantation )
end