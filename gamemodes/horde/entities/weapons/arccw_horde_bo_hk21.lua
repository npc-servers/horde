if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "arccw/weaponicons/arccw_horde_bo_hk21" )
    killicon.Add( "arccw_horde_bo_hk21", "arccw/weaponicons/arccw_horde_bo_hk21", Color( 0, 0, 0, 255 ) )
end

SWEP.Base = "arccw_base"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.Slot = 2

SWEP.PrintName = "HK21"
SWEP.Trivia_Class = "Light Machine Gun"
SWEP.Trivia_Desc = "Low-capacity light machine gun."
SWEP.Trivia_Manufacturer = "Hekler & Koch"
SWEP.Trivia_Calibre = "7.62x51mm NATO"
SWEP.Trivia_Mechanism = "Roller-Delayed"
SWEP.Trivia_Country = "Germany"
SWEP.Trivia_Year = "1961"

SWEP.ViewModel = "models/horde/weapons/bo/hk21/viewmodel.mdl"
SWEP.WorldModel = "models/weapons/w_snip_g3sg1.mdl"

SWEP.Damage = 40
SWEP.DamageMin = 32
SWEP.Range = 100

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 50

SWEP.Recoil = 0.6
SWEP.RecoilSide = 0.25
SWEP.RecoilRise = 0.1
SWEP.MaxRecoilBlowback = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilPunch = 0
SWEP.RecoilPunchBackMax = 0
SWEP.RecoilPunchBackMaxSights = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 60 / 700
SWEP.Firemodes = {
    {
        Mode = 2,
    }
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 10
SWEP.HipDispersion = 400
SWEP.MoveDispersion = 200

SWEP.Bipod_Integral = true
SWEP.BipodDispersion = 0.5
SWEP.BipodRecoil = 0.45

SWEP.ShootVol = 75

SWEP.ShootSound = {
    ")horde/weapons/bo/hk21/fire_01.wav",
    ")horde/weapons/bo/hk21/fire_02.wav",
    ")horde/weapons/bo/hk21/fire_03.wav",
    ")horde/weapons/bo/hk21/fire_04.wav"
}
SWEP.ShootSoundSilenced = {
    ")horde/weapons/bo/hk21/silenced_01.wav",
    ")horde/weapons/bo/hk21/silenced_02.wav",
    ")horde/weapons/bo/hk21/silenced_03.wav",
    ")horde/weapons/bo/hk21/silenced_04.wav",
    ")horde/weapons/bo/hk21/silenced_05.wav"
}
SWEP.DistantShootSound = "^horde/weapons/distant/lmg_distant.wav"

SWEP.MuzzleEffect = "muzzleflash_minimi"

SWEP.IronSightStruct = {
    Pos = Vector( -1.7731, 0, 0.5836 ),
    Ang = Angle( 0, 0.0342, 0 ),
    Magnification = 1.1,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.ActivePos = Vector( 0, 1, 1 )
SWEP.ActiveAng = Angle( 0, 0, 0 )

SWEP.SprintPos = Vector( 0, 1, 1 )
SWEP.SprintAng = Angle( 0, 0, 0 )

SWEP.RejectAttachments = {

    -- GSO
    ["go_optic_acog"] = true,
    ["go_optic_acog2"] = true,
    ["go_optic_awp"] = true,
    ["go_optic_barska"] = true,
    ["go_optic_cmore"] = true,
    ["go_optic_compm4"] = true,
    ["go_optic_elcan"] = true,
    ["go_optic_eotech"] = true,
    ["go_optic_hamr"] = true,
    ["go_optic_hunter"] = true,
    ["go_optic_kobra"] = true,
    ["go_optic_lp_rmr"] = true,
    ["go_optic_lp_t1"] = true,
    ["go_optic_pvs4"] = true,
    ["go_optic_schmidt"] = true,
    ["go_optic_sg1"] = true,
    ["go_optic_ssr"] = true,
    ["go_optic_t1"] = true,

    -- MW2
    ["optic_cheytacscope"] = true,
    ["optic_m82scope"] = true,
    ["optic_mw2_augscope"] = true,
    ["optic_mw2_mars"] = true,
    ["optic_mw2_susat"] = true,
    ["optic_mw2_tuna"] = true

}

SWEP.AttachmentElements = {
    ["mount"] = {
        VMBodygroups = {
            { ind = 1, bg = 1 },
        },
    },
    ["silencer"] = {
        VMElements = {
            {
                Model = "models/weapons/arccw/fesiugmw2/atts/supp_mw2.mdl",
                Bone = "tag_weapon",
                Offset = {
                    pos = Vector( 25, 0, 2.3 ),
                    ang = Angle( 0, 0, 0 ),
                },
                Scale = Vector( 0.6, 0.45, 0.45 ),
            }
        },
    },
}

SWEP.Attachments = {
    {
        PrintName = "Sights",
        DefaultAttName = "Iron Sights",
        Slot = "optic",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector( 0.5, 0, 4.4 ),
            vang = Angle( 0, 0, 0 ),
        },
        InstalledEles = { "mount" }
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "horde_bo_muzzle",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector( 0.5, 0, 4.4 ),
            vang = Angle( 0, 0, 0 ),
        },
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
            vpos = Vector( 18.5, -0.725, 2.3 ),
            vang = Angle( 0, 0, 0 ),
        },
        NoWM = true,
    },
}

SWEP.ExtraSightDist = 5

SWEP.Animations = {
    ["ready"] = {
        Source = "reg_draw_first",
        SoundTable = {
            { s = "ArcCW_Horde_BO_HK21.Pickup", t = 1 / 40 },
            { s = "horde/weapons/bo/hk21/bolt_grab.wav", t = 25 / 40 },
            { s = "horde/weapons/bo/hk21/bolt_pull.wav", t = 35 / 40 },
            { s = "horde/weapons/bo/hk21/bolt_release.wav", t = 44 / 40 },
        }
    },
    ["draw"] = {
        Source = "reg_draw",
        SoundTable = {
            { s = "ArcCW_Horde_BO_HK21.Rattle", t = 1 / 30 },
        }
    },
    ["holster"] = {
        Source = "reg_holster"
    },
    ["reload"] = {
        Source = "reg_reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            { s = "ArcCW_Horde_BO_HK21.Reload", t = 1 / 35 },
            { s = "ArcCW_Horde_BO_HK21.Reload", t = 80 / 35 },
            { s = "horde/weapons/bo/hk21/mag_out.wav", t = 15 / 35 },
            { s = "horde/weapons/bo/hk21/mag_futz.wav", t = 90 / 35 },
            { s = "horde/weapons/bo/hk21/mag_in.wav", t = 95 / 35 },
        }
    },
    ["reload_empty"] = {
        Source = "reg_reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            { s = "ArcCW_Horde_BO_HK21.Reload", t = 1 / 35 },
            { s = "ArcCW_Horde_BO_HK21.Reload", t = 80 / 35 },
            { s = "ArcCW_Horde_BO_HK21.Reload", t = 120 / 35 },
            { s = "horde/weapons/bo/hk21/mag_out.wav", t = 15 / 35 },
            { s = "horde/weapons/bo/hk21/mag_futz.wav", t = 90 / 35 },
            { s = "horde/weapons/bo/hk21/mag_in.wav", t = 95 / 35 },
            { s = "horde/weapons/bo/hk21/bolt_grab.wav", t = 124 / 35 },
            { s = "horde/weapons/bo/hk21/bolt_pull.wav", t = 138 / 35 },
            { s = "horde/weapons/bo/hk21/bolt_release.wav", t = 145 / 35 },
        }
    },
    ["fire"] = {
        Source = "reg_fire"
    },
    ["fire_iron"] = {
        Source = "reg_ads_fire"
    },
    ["idle"] = {
        Source = "reg_idle"
    },
    ["idle_sprint"] = {
        Source = "reg_sprint"
    },
    ["enter_sprint"] = {
        Source = "reg_sprint_in"
    },
    ["exit_sprint"] = {
        Source = "reg_sprint_out"
    }
}

sound.Add( {
    name = "ArcCW_Horde_BO_HK21.Reload",
    volume = 1.0,
    sound = {
        "horde/weapons/bo/reload_01.wav",
        "horde/weapons/bo/reload_02.wav",
        "horde/weapons/bo/reload_03.wav",
        "horde/weapons/bo/reload_04.wav"
    }
} )

sound.Add( {
    name = "ArcCW_Horde_BO_HK21.Pickup",
    volume = 1.0,
    sound = {
        ")horde/weapons/bo/pickup_01.wav",
        ")horde/weapons/bo/pickup_02.wav",
        ")horde/weapons/bo/pickup_03.wav"
    }
} )

sound.Add( {
    name = "ArcCW_Horde_BO_HK21.Rattle",
    volume = 1.0,
    sound = {
        ")horde/weapons/bo/pullout_01.wav",
        ")horde/weapons/bo/pullout_02.wav",
        ")horde/weapons/bo/pullout_03.wav",
        ")horde/weapons/bo/pullout_04.wav",
        ")horde/weapons/bo/pullout_05.wav"
    }
} )

function SWEP:DoShootSound( sndoverride, _, voloverride, pitchoverride )
    local fsound = self.ShootSound
    local lsound = self.LowShootSound
    local dsound = self.DistantShootSound

    local suppressed = self:GetBuff_Override( "Silencer" )

    if suppressed then
        fsound = self.ShootSoundSilenced
        lsound = self.LowShootSoundSilenced
        dsound = self.DistantShootSoundSilenced
    end

    fsound = self:GetBuff_Hook( "Hook_GetShootSound", fsound )

    local volume = self.ShootVol
    local spv = self.ShootPitchVariation
    local pitch  = self.ShootPitch * math.Rand( 1 - spv, 1 + spv ) * self:GetBuff_Mult( "Mult_ShootPitch" )

    local v = GetConVar( "arccw_weakensounds" ):GetFloat()

    volume = volume - v
    volume = volume * self:GetBuff_Mult( "Mult_ShootVol" )

    volume = math.Clamp( volume, 60, 140 )
    pitch = math.Clamp( pitch, 0, 255 )

    if sndoverride then fsound = sndoverride end
    if voloverride then volume = voloverride end
    if pitchoverride then pitch = pitchoverride end

    if fsound then self:MyEmitSound( fsound, volume, pitch, 1, CHAN_STATIC ) end
    if lsound then self:MyEmitSound( lsound, 75, 100, 0.5, CHAN_BODY ) end
    if dsound then self:MyEmitSound( dsound, volume, pitch, 1, CHAN_WEAPON ) end

    local data = {
        sound = fsound,
        volume = volume,
        pitch = pitch,
    }

    self:GetBuff_Hook( "Hook_AddShootSound", data )
end