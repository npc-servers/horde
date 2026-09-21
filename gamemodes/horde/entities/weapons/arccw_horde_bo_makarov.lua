if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "arccw/weaponicons/arccw_horde_bo_makarov" )
    killicon.Add( "arccw_horde_bo_makarov", "arccw/weaponicons/arccw_horde_bo_makarov", Color( 0, 0, 0, 255 ) )
end

SWEP.Base = "arccw_base"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.Slot = 1

SWEP.PrintName = "Makarov"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Standard pistol of Soviet design.\nThis one is loaded with healing darts."
SWEP.Trivia_Manufacturer = "Izhevsk Mechanical Plant"
SWEP.Trivia_Calibre = "9x18mm Makarov"
SWEP.Trivia_Mechanism = "Recoil-Operated"
SWEP.Trivia_Country = "Soviet Union"
SWEP.Trivia_Year = "1948"

SWEP.ViewModel = "models/horde/weapons/bo/makarov/viewmodel.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

SWEP.Damage = 20
SWEP.DamageMin = 13
SWEP.Range = 50

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 8
SWEP.ExtendedClipSize = 20

SWEP.Recoil = 0.12
SWEP.RecoilSide = 0.1
SWEP.RecoilRise = 0.1
SWEP.MaxRecoilBlowback = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilPunch = 0
SWEP.RecoilPunchBackMax = 0
SWEP.RecoilPunchBackMaxSights = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 60 / 900
SWEP.Firemodes = {
    {
        Mode = 1,
    }
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 5
SWEP.HipDispersion = 150
SWEP.MoveDispersion = 50

SWEP.ShootVol = 75

SWEP.ShootSound = {
    ")horde/weapons/bo/makarov/fire_01.wav",
    ")horde/weapons/bo/makarov/fire_02.wav",
    ")horde/weapons/bo/makarov/fire_03.wav",
    ")horde/weapons/bo/makarov/fire_04.wav",
    ")horde/weapons/bo/makarov/fire_05.wav"
}
SWEP.ShootSoundSilenced = {
    ")horde/weapons/bo/makarov/silenced_01.wav",
    ")horde/weapons/bo/makarov/silenced_02.wav",
    ")horde/weapons/bo/makarov/silenced_03.wav",
    ")horde/weapons/bo/makarov/silenced_04.wav",
    ")horde/weapons/bo/makarov/silenced_05.wav"
}
SWEP.DistantShootSound = "^horde/weapons/distant/pistol_distant.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol"

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.9

SWEP.IronSightStruct = {
    Pos = Vector( -1.9846, 0.582, 1.241 ),
    Ang = Angle( 0, 0, 0 ),
    Magnification = 1.1,
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.ActivePos = Vector( 0, 2, 1 )
SWEP.ActiveAng = Angle( 0, 0, 0 )

SWEP.SprintPos = Vector( 0, 0, 0 )
SWEP.SprintAng = Angle( 0, 0, 0 )

SWEP.AttachmentElements = {
    ["silencer"] = {
        VMElements = {
            {
                Model = "models/horde/weapons/bo/makarov/atts/attachment_silencer.mdl",
                Bone = "tag_weapon",
                Offset = {
                    pos = Vector( 0, 0, 0 ),
                    ang = Angle( 0, -90, 0 ),
                },
                Scale = Vector( 0.875, 0.875, 0.875 ),
            }
        },
    },
    ["ext_mag"] = {
        VMBodygroups = {
            { ind = 3, bg = 1 },
        },
    },
}

SWEP.Attachments = {
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "horde_bo_muzzle"
    },
    {
        PrintName = "Magazine",
        DefaultAttName = "Standard Magazine",
        Slot = "horde_bo_ammo"
    },
    {
        PrintName = "Ammo Type",
        DefaultAttName = "Standard Ammo",
        Slot = "go_ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector( 2.7, -0.1, -0.4 ),
            vang = Angle( 0, 0, 0 ),
        },
        NoWM = true,
    },
}

SWEP.Animations = {
    ["ready"] = {
        Source = "reg_draw_first",
        SoundTable = {
            { s = "ArcCW_Horde_BO_Makarov.Pickup", t = 1 / 35 },
            { s = "horde/weapons/bo/makarov/slide_pull.wav", t = 7 / 35 },
            { s = "horde/weapons/bo/makarov/slide_release.wav", t = 24 / 35 },
        }
    },
    ["draw"] = {
        Source = "reg_draw",
        SoundTable = {
            { s = "ArcCW_Horde_BO_Makarov.Rattle", t = 1 / 40 },
        }
    },
    ["draw_empty"] = {
        Source = "reg_draw_empty",
        SoundTable = {
            { s = "ArcCW_Horde_BO_Makarov.Rattle", t = 1 / 40 },
        }
    },
    ["holster"] = {
        Source = "reg_holster"
    },
    ["holster_empty"] = {
        Source = "reg_holster_empty"
    },
    ["reload"] = {
        Source = "reg_reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        SoundTable = {
            { s = "ArcCW_Horde_BO_Makarov.Reload", t = 1 / 25 },
            { s = "ArcCW_Horde_BO_Makarov.Reload", t = 15 / 25 },
            { s = "horde/weapons/bo/makarov/mag_out.wav", t = 5 / 25 },
            { s = "horde/weapons/bo/makarov/mag_futz.wav", t = 17 / 25 },
            { s = "horde/weapons/bo/makarov/mag_in.wav", t = 23 / 25 },
        }
    },
    ["reload_ext"] = {
        Source = "reg_reload_ext",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        SoundTable = {
            { s = "ArcCW_Horde_BO_Makarov.Reload", t = 1 / 25 },
            { s = "ArcCW_Horde_BO_Makarov.Reload", t = 15 / 25 },
            { s = "horde/weapons/bo/makarov/mag_out.wav", t = 5 / 25 },
            { s = "horde/weapons/bo/makarov/mag_futz.wav", t = 17 / 25 },
            { s = "horde/weapons/bo/makarov/mag_in.wav", t = 23 / 25 },
        }
    },
    ["reload_empty"] = {
        Source = "reg_reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        SoundTable = {
            { s = "ArcCW_Horde_BO_Makarov.Reload", t = 1 / 25 },
            { s = "ArcCW_Horde_BO_Makarov.Reload", t = 15 / 25 },
            { s = "horde/weapons/bo/makarov/mag_out.wav", t = 5 / 25 },
            { s = "horde/weapons/bo/makarov/mag_futz.wav", t = 19 / 25 },
            { s = "horde/weapons/bo/makarov/mag_in.wav", t = 23 / 25 },
            { s = "horde/weapons/bo/makarov/slide_release.wav", t = 32 / 25 },
        }
    },
    ["reload_ext_empty"] = {
        Source = "reg_reload_empty_ext",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        SoundTable = {
            { s = "ArcCW_Horde_BO_Makarov.Reload", t = 1 / 25 },
            { s = "ArcCW_Horde_BO_Makarov.Reload", t = 15 / 25 },
            { s = "horde/weapons/bo/makarov/mag_out.wav", t = 5 / 25 },
            { s = "horde/weapons/bo/makarov/mag_futz.wav", t = 19 / 25 },
            { s = "horde/weapons/bo/makarov/mag_in.wav", t = 23 / 25 },
            { s = "horde/weapons/bo/makarov/slide_release.wav", t = 32 / 25 },
        }
    },
    ["fire"] = {
        Source = "reg_fire"
    },
    ["fire_iron"] = {
        Source = "reg_ads_fire"
    },
    ["fire_empty"] = {
        Source = "reg_fire_last"
    },
    ["fire_iron_empty"] = {
        Source = "reg_ads_fire_last"
    },
    ["idle"] = {
        Source = "reg_idle"
    },
    ["idle_empty"] = {
        Source = "reg_idle_empty"
    },
    ["idle_sprint"] = {
        Source = "reg_sprint"
    },
    ["idle_sprint_empty"] = {
        Source = "reg_sprint_empty"
    },
    ["enter_sprint"] = {
        Source = "reg_sprint_in"
    },
    ["exit_sprint"] = {
        Source = "reg_sprint_out"
    }
}

sound.Add( {
    name = "ArcCW_Horde_BO_Makarov.Reload",
    volume = 1.0,
    sound = {
        "horde/weapons/bo/reload_01.wav",
        "horde/weapons/bo/reload_02.wav",
        "horde/weapons/bo/reload_03.wav",
        "horde/weapons/bo/reload_04.wav"
    }
} )

sound.Add( {
    name = "ArcCW_Horde_BO_Makarov.Pickup",
    volume = 1.0,
    sound = {
        ")horde/weapons/bo/pickup_01.wav",
        ")horde/weapons/bo/pickup_02.wav",
        ")horde/weapons/bo/pickup_03.wav"
    }
} )

sound.Add( {
    name = "ArcCW_Horde_BO_Makarov.Rattle",
    volume = 1.0,
    sound = {
        ")horde/weapons/bo/pullout_01.wav",
        ")horde/weapons/bo/pullout_02.wav",
        ")horde/weapons/bo/pullout_03.wav",
        ")horde/weapons/bo/pullout_04.wav",
        ")horde/weapons/bo/pullout_05.wav"
    }
} )

hook.Add( "Horde_ShouldCollide", "Horde_Medic_Makarov", function( ent1, ent2 )
    local entClass = "arccw_horde_bo_makarov"

    if ent1 == entClass or ent2 == entClass then
        return true
    end
end )

function SWEP:DoPrimaryFire( isent, data )
    local clip = self:Clip1()

    if self:HasBottomlessClip() then
        clip = self:Ammo1()
    end

    local owner = self:GetOwner()

    local shouldphysical = GetConVar( "arccw_bullet_enable" ):GetBool()

    if self.AlwaysPhysBullet or self:GetBuff_Override( "Override_AlwaysPhysBullet" ) then
        shouldphysical = true
    end

    if self.NeverPhysBullet or self:GetBuff_Override( "Override_NeverPhysBullet" ) then
        shouldphysical = false
    end

    if isent then
        self:FireRocket( data.ent, data.vel, data.ang, self.PhysBulletDontInheritPlayerVelocity )
    else
        if not IsFirstTimePredicted() then return end

        if shouldphysical then
            local vel = self:GetBuff_Override( "Override_PhysBulletMuzzleVelocity" ) or self.PhysBulletMuzzleVelocity

            local tracernum = data.TracerNum or 1
            local prof

            if tracernum == 0 or clip % tracernum ~= 0 then
                prof = 7
            end

            if not vel then
                vel = math.Clamp( self:GetBuff( "Range" ), 30, 300 ) * 8

                if self.DamageMin > self.Damage then
                    vel = vel * 3
                end
            end

            vel = vel / ArcCW.HUToM

            vel = vel * self:GetBuff_Mult( "Mult_PhysBulletMuzzleVelocity" ) * self:GetBuff_Mult( "Mult_Range" )

            vel = vel * GetConVar( "arccw_bullet_velocity" ):GetFloat()

            vel = vel * data.Dir:GetNormalized()

            ArcCW:ShootPhysBullet( self, data.Src, vel, prof )
        else
            if owner:IsPlayer() then
                owner:LagCompensation( true )
            end

            self:FireBullets( data )

            if owner:IsPlayer() then
                owner:LagCompensation( false )
            end
        end
    end
end

hook.Add( "Hook_BulletHit", "Horde_Makarov_Heal", function( wpn, data )
    if wpn:GetClass() == "arccw_horde_bo_makarov" then
        if SERVER and ( data.tr.Entity:IsPlayer() ) then
            local healinfo = HealInfo:New( { amount = 5, healer = wpn:GetOwner() } )
            HORDE:OnPlayerHeal( data.tr.Entity, healinfo )

            data.Damage = 0
        end
        if CLIENT then
            local emitter = ParticleEmitter( data.tr.HitPos )
            local smoke = emitter:Add( "particles/smokey", data.tr.HitPos )

            smoke:SetGravity( Vector( 0, 0, 1500 ) )
            smoke:SetDieTime( math.Rand( 0.5, 1 ) )
            smoke:SetStartAlpha( 100 )
            smoke:SetEndAlpha( 0 )
            smoke:SetStartSize( 10 )
            smoke:SetEndSize( 50 )
            smoke:SetRoll( math.Rand( -180, 180 ) )
            smoke:SetRollDelta( math.Rand( -0.2, 0.2 ) )
            smoke:SetColor( 50, 200, 50 )
            smoke:SetAirResistance( 1000 )
            smoke:SetLighting( false )
            smoke:SetCollide( false )
            smoke:SetBounce( 0 )

            emitter:Finish()
        end
    end
end )

function SWEP:ChangeFiremode()
    if CLIENT then return end
    if self:GetNextSecondaryFire() > CurTime() then return end
    if not self.CanBash and not self:GetBuff_Override( "Override_CanBash" ) then return end

    local ply = self:GetOwner()
    local filter = { self:GetOwner() }

    local tr = util.TraceHull( {
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 5000,
        filter = filter,
        mins = Vector( -16, -16, -8 ),
        maxs = Vector( 16, 16, 8 ),
        mask = MASK_SHOT_HULL
    } )

    if tr.Hit then
        local effectdata = EffectData()
        effectdata:SetOrigin( tr.HitPos )
        effectdata:SetRadius( 25 )
        util.Effect( "horde_heal_mist", effectdata )

        for _, ent in pairs( ents.FindInSphere( tr.HitPos, 80 ) ) do
            if ent:IsPlayer() then
                local healinfo = HealInfo:New( { amount = 8, healer = ply } )
                HORDE:OnPlayerHeal( ent, healinfo )
            elseif ent:GetClass() == "npc_vj_horde_antlion" then
                local healinfo = HealInfo:New( { amount = 8, healer = ply } )
                HORDE:OnAntlionHeal( ent, healinfo )
            elseif ent:IsNPC() then
                local dmg = DamageInfo()
                dmg:SetDamage( 10 )
                dmg:SetDamageType( DMG_NERVEGAS )
                dmg:SetAttacker( ply )
                dmg:SetInflictor( self )
                dmg:SetDamagePosition( tr.HitPos )
                ent:TakeDamageInfo( dmg )
            end
        end
    end

    ply:EmitSound( ")horde/weapons/heal.wav", 75, 100, 1, CHAN_STATIC )

    self:SetNextSecondaryFire( CurTime() + 0.5 )

    return true
end

function SWEP:Hook_Think()
    if SERVER then return end

    local tr = util.TraceHull( {
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 5000,
        filter = filter,
        mins = Vector( -20, -20, -8 ),
        maxs = Vector( 20, 20, 8 ),
        mask = MASK_SHOT_HULL
    } )

    if tr.Hit and tr.Entity and tr.Entity:IsPlayer() then
        self.Horde_HealTarget = tr.Entity
    else
        self.Horde_HealTarget = nil
    end
end

local function nv_center( ent )
    return ent:LocalToWorld( ent:OBBCenter() )
end

function SWEP:Hook_DrawHUD()
    if self.Horde_HealTarget then
        local pos = nv_center( self.Horde_HealTarget ):ToScreen()

        surface.SetDrawColor( Color( 50, 200, 50 ) )
        surface.DrawCircle( pos.x, pos.y, 30 )

        draw.DrawText( self.Horde_HealTarget:Health(), "Trebuchet24", pos.x - 15, pos.y - 15, Color( 50, 200, 50 ), TEXT_ALIGN_LEFT )
    end
end