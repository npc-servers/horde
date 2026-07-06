if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "arccw/weaponicons/arccw_mw2_mp5k" )
    killicon.Add( "arccw_horde_bo_mp5k", "arccw/weaponicons/arccw_mw2_mp5k", Color( 0, 0, 0, 255 ) )
end

SWEP.Base = "arccw_base"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.Slot = 2

SWEP.PrintName = "MP5K-P"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = "Early prototype variant of the MP5K."
SWEP.Trivia_Manufacturer = "Hekler & Koch"
SWEP.Trivia_Calibre = "9x19mm Parabellum"
SWEP.Trivia_Mechanism = "Roller-Delayed"
SWEP.Trivia_Country = "Germany"
SWEP.Trivia_Year = "1976"

SWEP.ViewModel = "models/horde/weapons/bo/mp5k/viewmodel.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"

SWEP.Damage = 25
SWEP.DamageMin = 10
SWEP.Range = 50

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 30
SWEP.ExtendedClipSize = 45

SWEP.Recoil = 0.15
SWEP.RecoilSide = 0.1
SWEP.RecoilRise = 0.1
SWEP.MaxRecoilBlowback = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilPunch = 0
SWEP.RecoilPunchBackMax = 0
SWEP.RecoilPunchBackMaxSights = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 60 / 800
SWEP.Firemodes = {
    {
        Mode = 2,
    }
}

SWEP.NotForNPCS = true

SWEP.AccuracyMOA = 10
SWEP.HipDispersion = 300
SWEP.MoveDispersion = 200

SWEP.ShootVol = 75

SWEP.ShootSound = {
    ")horde/weapons/bo/mp5k/fire_01.wav",
    ")horde/weapons/bo/mp5k/fire_02.wav",
    ")horde/weapons/bo/mp5k/fire_03.wav",
    ")horde/weapons/bo/mp5k/fire_04.wav",
    ")horde/weapons/bo/mp5k/fire_05.wav"
}
SWEP.ShootSoundSilenced = {
    ")horde/weapons/bo/mp5k/silenced_01.wav",
    ")horde/weapons/bo/mp5k/silenced_02.wav",
    ")horde/weapons/bo/mp5k/silenced_03.wav",
    ")horde/weapons/bo/mp5k/silenced_04.wav"
}
SWEP.DistantShootSound = "^horde/weapons/distant/smg_distant.wav"

SWEP.MuzzleEffect = "muzzleflash_smg"

SWEP.IronSightStruct = {
    Pos = Vector( -2.83, -3.3215, 1.3812 ),
    Ang = Angle( 0.079, 0.0525, 0 ),
    Magnification = 1.1,
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "smg"
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
                Model = "models/horde/weapons/bo/mp5k/atts/attachment_silencer.mdl",
                Bone = "tag_weapon",
                Offset = {
                    pos = Vector( 0, 0, 0 ),
                    ang = Angle( 0, -90, 0 ),
                },
                Scale = Vector( .875, .875, .875 ),
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
        PrintName = "Sights",
        DefaultAttName = "Iron Sights",
        Slot = "optic",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector( -3, 0, 2.95 ),
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
            vpos = Vector( -1, -0.5, 0.8 ),
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
            { s = "ArcCW.Horde.MP5K_Pickup", t = 0 },
            { s = "horde/weapons/bo/mp5k/bolt_release.wav", t = 0.3 },
        }
    },
    ["draw"] = {
        Source = "reg_draw",
        SoundTable = {
            { s = "ArcCW.Horde.MP5K_Pullout", t = 0 },
        }
    },
    ["holster"] = {
        Source = "reg_holster"
    },
    ["reload"] = {
        Source = "reg_reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
            { s = "ArcCW.Horde.MP5K_Reload", t = 0 },
            { s = "ArcCW.Horde.MP5K_Reload", t = 1.4 },
            { s = "horde/weapons/bo/mp5k/mag_out.wav", t = 0.5 },
            { s = "horde/weapons/bo/mp5k/mag_futz.wav", t = 1.6 },
            { s = "horde/weapons/bo/mp5k/mag_in.wav", t = 1.75 },
        }
    },
    ["reload_ext"] = {
        Source = "reg_reload_ext",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
            { s = "ArcCW.Horde.MP5K_Reload", t = 0 },
            { s = "ArcCW.Horde.MP5K_Reload", t = 1.4 },
            { s = "horde/weapons/bo/mp5k/mag_out.wav", t = 0.5 },
            { s = "horde/weapons/bo/mp5k/mag_futz.wav", t = 1.6 },
            { s = "horde/weapons/bo/mp5k/mag_in.wav", t = 1.75 },
        }
    },
    ["reload_empty"] = {
        Source = "reg_reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
            { s = "ArcCW.Horde.MP5K_Reload", t = 0 },
            { s = "ArcCW.Horde.MP5K_Reload", t = 0.8 },
            { s = "ArcCW.Horde.MP5K_Reload", t = 1.7 },
            { s = "ArcCW.Horde.MP5K_Reload", t = 2.3 },
            { s = "horde/weapons/bo/mp5k/bolt_pull.wav", t = 0.2 },
            { s = "horde/weapons/bo/mp5k/mag_out.wav", t = 0.9 },
            { s = "horde/weapons/bo/mp5k/mag_futz.wav", t = 1.9 },
            { s = "horde/weapons/bo/mp5k/mag_in.wav", t = 2.1 },
            { s = "horde/weapons/bo/mp5k/bolt_release.wav", t = 2.5 },
        }
    },
    ["reload_ext_empty"] = {
        Source = "reg_reload_empty_ext",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
            { s = "ArcCW.Horde.MP5K_Reload", t = 0 },
            { s = "ArcCW.Horde.MP5K_Reload", t = 0.8 },
            { s = "ArcCW.Horde.MP5K_Reload", t = 1.7 },
            { s = "ArcCW.Horde.MP5K_Reload", t = 2.3 },
            { s = "horde/weapons/bo/mp5k/bolt_pull.wav", t = 0.2 },
            { s = "horde/weapons/bo/mp5k/mag_out.wav", t = 0.9 },
            { s = "horde/weapons/bo/mp5k/mag_futz.wav", t = 1.9 },
            { s = "horde/weapons/bo/mp5k/mag_in.wav", t = 2.1 },
            { s = "horde/weapons/bo/mp5k/bolt_release.wav", t = 2.5 },
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
    name = "ArcCW.Horde.MP5K_Pickup",
    volume = 1.0,
    sound = {
        ")horde/weapons/bo/pickup_01.wav",
        ")horde/weapons/bo/pickup_02.wav",
        ")horde/weapons/bo/pickup_03.wav"
    }
} )

sound.Add( {
    name = "ArcCW.Horde.MP5K_Pullout",
    volume = 1.0,
    sound = {
        ")horde/weapons/bo/pullout_01.wav",
        ")horde/weapons/bo/pullout_02.wav",
        ")horde/weapons/bo/pullout_03.wav",
        ")horde/weapons/bo/pullout_04.wav",
        ")horde/weapons/bo/pullout_05.wav"
    }
} )

sound.Add( {
    name = "ArcCW.Horde.MP5K_Reload",
    volume = 1.0,
    sound = {
        "horde/weapons/bo/reload_01.wav",
        "horde/weapons/bo/reload_02.wav",
        "horde/weapons/bo/reload_03.wav",
        "horde/weapons/bo/reload_04.wav"
    }
} )