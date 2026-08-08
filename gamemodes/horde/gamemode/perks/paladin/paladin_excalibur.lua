PERK.PrintName = "Excalibur"
PERK.Icon = "materials/perks/paladin/excalibur.png"
PERK.Description = [[
Increase Lightning damage by 25%.
Melee hits unleashes waves of holy fire, which passes through enemies.
Holy waves deal Lightning damage to enemies in range.]]
PERK.Hooks = {}

if not SERVER then return end

-- Must also change these in the Paladin Holy Wave effects file!
local waveLifetime = 0.6
local waveCount = 3
local waveSpacing = 0.12
local waveSpeed = 900
local waveStartWidth = 30
local waveExpandRate = 400
local waveThickness = 40

local waveDamage = 15
local waveDetectionTickrate = 0.03
local waveDetectionThickness = waveThickness * 0.52

function doWaveDmg( ply, startPos, ang )
    local forward = ang:Forward()
    forward.z = 0
    forward:Normalize()

    local flatAng = Angle( 90, ang.y - 90, 0 )
    local right = flatAng:Right()
    local up = flatAng:Up()

    for wave = 0, waveCount - 1 do
        local delay = wave * waveSpacing
        local hitEnts = {}

        local ticks = math.floor( waveLifetime / waveDetectionTickrate )
        for tick = 0, ticks do
            local waveTime = tick * waveDetectionTickrate

            timer.Simple( delay + waveTime, function()
                if not IsValid( ply ) then return end

                local dist = waveTime * waveSpeed
                local center = startPos + forward * dist
                local arcWidth = waveStartWidth + waveTime * waveExpandRate

                for _, ent in ipairs( ents.FindInSphere( center, arcWidth + waveDetectionThickness ) ) do
                    if hitEnts[ent] then goto cont end
                    if ent == ply then goto cont end
                    if not HORDE:IsEnemy( ent ) then goto cont end

                    local toCenter = ent:WorldSpaceCenter() - center

                    local offsetRight = toCenter:Dot( right )
                    local offsetUp = toCenter:Dot( up )

                    local planeDist = math.sqrt( offsetRight * offsetRight + offsetUp * offsetUp )

                    local inWave = offsetRight <= 0
                    if not inWave then goto cont end
                    if math.abs( planeDist - arcWidth ) > waveDetectionThickness then goto cont end

                    hitEnts[ent] = true

                    local dmginfo = DamageInfo()
                    dmginfo:SetDamage( waveDamage )
                    dmginfo:SetAttacker( ply )
                    dmginfo:SetInflictor( ply )
                    dmginfo:SetDamageType( DMG_SHOCK )
                    dmginfo:SetDamagePosition( ent:WorldSpaceCenter() )

                    ent:TakeDamageInfo( dmginfo )

                    ::cont::
                end
            end )
        end
    end
end

PERK.Hooks.Horde_OnPlayerDamage = function( ply, npc, bonus, _, dmginfo )
    if not ply:Horde_GetPerk( "paladin_excalibur" ) then return end

    if HORDE:IsLightningDamage( dmginfo ) then
        bonus.increase = bonus.increase + 0.25
    end

    if not HORDE:IsMeleeDamage( dmginfo ) then return end

    local plyAng = ply:GetAngles()

    local origin = npc:WorldSpaceCenter()
    local dirToPlayer = ( ply:GetPos() - origin ):GetNormalized()
    origin = origin + dirToPlayer * 35

    local effectdata = EffectData()
    effectdata:SetOrigin( origin )
    effectdata:SetAngles( plyAng )
    util.Effect( "holy_wave", effectdata, true, true )

    doWaveDmg( ply, origin, plyAng )

    ply:EmitSound( ")weapons/stunstick/stunstick_impact1.wav", 125, 100, 1, CHAN_AUTO )
    ply:EmitSound( ")npc/roller/mine/rmine_explode_shock1.wav", 125, 100, 1, CHAN_AUTO )
end


-- Aura lightning damage is handled in horde_paladin_aura/init