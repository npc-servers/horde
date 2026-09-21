if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_m14")
    killicon.Add("arccw_horde_m14", "arccw/weaponicons/arccw_m14", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_base"
SWEP.Slot = 2
SWEP.ViewModelFOV = 75

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "M14"
SWEP.Trivia_Class = "Rifle"
SWEP.Trivia_Desc = "United States military rifle chambered for the 7.62x51mm NATO cartridge."
SWEP.Trivia_Calibre = "7.62x51mm NATO"

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/v_bo1_m14.mdl"
SWEP.WorldModel = "models/weapons/w_annabelle.mdl"

SWEP.MirrorVMWM = true

SWEP.WorldModelOffset = {
    pos = Vector(-5, 5, -3.5),
    ang = Angle(-10, 0, 180)
}

SWEP.Damage = 100
SWEP.DamageMin = 70
SWEP.Range = 1250 * 0.025
SWEP.Penetration = 20
SWEP.DamageType = DMG_BULLET

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 10
SWEP.ExtendedClipSize = 10
SWEP.ReducedClipSize = 10

SWEP.Recoil = 0.6
SWEP.RecoilSide = 0.14
SWEP.RecoilRise = 0.1
SWEP.MaxRecoilBlowback = 0
SWEP.VisualRecoilMult = 0
SWEP.RecoilPunch = 0
SWEP.RecoilPunchBackMax = 0
SWEP.RecoilPunchBackMaxSights = 0
SWEP.RecoilVMShake = 0

SWEP.Delay = 60/625
SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 1,
    }
}

SWEP.AccuracyMOA = 0
SWEP.HipDispersion = 150
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "ar2"

SWEP.ShootVol = 75

SWEP.ShootSound = {
    ")horde/weapons/bo/m14/fire_01.wav",
    ")horde/weapons/bo/m14/fire_02.wav",
    ")horde/weapons/bo/m14/fire_03.wav",
    ")horde/weapons/bo/m14/fire_04.wav",
    ")horde/weapons/bo/m14/fire_05.wav"
}
SWEP.ShootSoundSilenced = {
    ")horde/weapons/bo/m14/silenced_01.wav",
    ")horde/weapons/bo/m14/silenced_02.wav",
    ")horde/weapons/bo/m14/silenced_03.wav",
    ")horde/weapons/bo/m14/silenced_04.wav",
    ")horde/weapons/bo/m14/silenced_05.wav"
}
SWEP.DistantShootSound = "^horde/weapons/distant/dmr_distant.wav"

SWEP.MuzzleEffect = "muzzleflash_3"

SWEP.ShellModel = "models/shells/shell_556.mdl"
SWEP.ShellPitch = 95
SWEP.ShellScale = 1

SWEP.MuzzleEffectAttachment = 1
SWEP.CaseEffectAttachment = 2
SWEP.CamAttachment = 3

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.5

SWEP.IronSightStruct = {
    Pos = Vector(-3.40, -4.11, 1.067),
    Ang = Angle(-0.38, 0.018, 0),
    Magnification = 1.2,
    SwitchToSound = "",
    ViewModelFOV = 75,
    CrosshairInSights = false
}

SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.SprintPos = Vector(0, 0, 0)
SWEP.SprintAng = Angle(0, 0, 0)

SWEP.BarrelLength = 32

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = {"optic"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(10, 0, 1.4),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1, 1, 1),
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = {"muzzle"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(25.5, 0, 0.74),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1, 1, 1),
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(10, 0, -0.5),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1, 1, 1),
    },
    {
        PrintName = "Tactical",
        Slot = {"tac"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(15, 0, -0.25),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(0.8, 0.8, 0.8),
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Perk",
        Slot = {"go_perk"}
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(5.4, -0.85, 0.72),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(0.5, 0.5, 0.5),
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "reg_idle",
    },
    ["enter_sprint"] = {
        Source = "reg_sprint_in",
    },
    ["idle_sprint"] = {
        Source = "reg_sprint",
    },
    ["exit_sprint"] = {
        Source = "reg_sprint_out",
    },
    ["ready"] = {
        Source = "reg_draw_first",
        SoundTable = {
            {s = "ArcCW.Horde.M14_Pickup",  t = 0},
        },
    },
    ["draw"] = {
        Source = "reg_draw",
        SoundTable = {
            {s = "ArcCW.Horde.M14_Pullout",  t = 0},
        },
    },
    ["holster"] = {
        Source = "reg_holster",
    },
    ["fire"] = {
        Source = "reg_fire",
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "reg_ads_fire",
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reg_reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
    },
    ["reload_empty"] = {
        Source = "reg_reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1.8,
    },
}

sound.Add({
    name = "ArcCw_Horde_M14.BoltBack",
    volume = 1.0,
    sound = "horde/weapons/bo/m14/bolt_pull.wav"
})
sound.Add({
    name = "ArcCw_Horde_M14.BoltRelease",
    volume = 1.0,
    sound = "horde/weapons/bo/m14/bolt_release.wav"
})
sound.Add( {
    name = "ArcCW.Horde.M14_Pickup",
    volume = 1.0,
    sound = {
        ")horde/weapons/bo/pickup_01.wav",
        ")horde/weapons/bo/pickup_02.wav",
        ")horde/weapons/bo/pickup_03.wav"
    }
} )
sound.Add( {
    name = "ArcCW.Horde.M14_Pullout",
    volume = 1.0,
    sound = {
        ")horde/weapons/bo/pullout_01.wav",
        ")horde/weapons/bo/pullout_02.wav",
        ")horde/weapons/bo/pullout_03.wav",
        ")horde/weapons/bo/pullout_04.wav",
        ")horde/weapons/bo/pullout_05.wav"
    }
} )
sound.Add({
    name = "ArcCw_Horde_M14.Foley",
    channel = CHAN_ITEM,
    volume = 0.5,
    sound = {
        "horde/weapons/bo/reload_01.wav",
        "horde/weapons/bo/reload_02.wav",
        "horde/weapons/bo/reload_03.wav",
        "horde/weapons/bo/reload_04.wav"
    }
})
sound.Add({
    name = "ArcCw_Horde_M14.MagIn1",
    volume = 1.0,
    sound = "horde/weapons/bo/m14/mag_in.wav"
})
sound.Add({
    name = "ArcCw_Horde_M14.MagIn2",
    volume = 1.0,
    sound = "horde/weapons/bo/m14/mag_in.wav"
})
sound.Add({
    name = "ArcCw_Horde_M14.MagOut",
    volume = 1.0,
    sound = "horde/weapons/bo/m14/mag_out.wav"
})
sound.Add({
    name = "ArcCw_Horde_M14.MagRattle",
    volume = 1.0,
    sound = "horde/weapons/bo/m14/mag_futz.wav"
})