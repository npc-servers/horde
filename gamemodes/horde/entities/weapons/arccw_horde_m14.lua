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
SWEP.Penetration = 5
SWEP.DamageType = DMG_BULLET

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 10
SWEP.ExtendedClipSize = 10
SWEP.ReducedClipSize = 10

SWEP.Recoil = 0.5
SWEP.RecoilSide = 0.05

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

SWEP.ShootSound = {")weapons/bo1_m14/m14_fire_close_1.wav",")weapons/bo1_m14/m14_fire_close_2.wav",")weapons/bo1_m14/m14_fire_close_3.wav",")weapons/bo1_m14/m14_fire_close_4.wav",")weapons/bo1_m14/m14_fire_close_5.wav"}
SWEP.DistantShootSound = {")weapons/bo1_m14/m14_fire_dist_1.wav",")weapons/bo1_m14/m14_fire_dist_2.wav",")weapons/bo1_m14/m14_fire_dist_3.wav",")weapons/bo1_m14/m14_fire_dist_4.wav",")weapons/bo1_m14/m14_fire_dist_5.wav"}
SWEP.ShootSoundSilenced = {")weapons/bo1_m14/m14_fire_silenced_1.wav",")weapons/bo1_m14/m14_fire_silenced_2.wav",")weapons/bo1_m14/m14_fire_silenced_3.wav",")weapons/bo1_m14/m14_fire_silenced_4.wav",")weapons/bo1_m14/m14_fire_silenced_5.wav"}

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
            {s = "ArcCw_Horde_M14.Foley",  t = 0},
        },
    },
    ["draw"] = {
        Source = "reg_draw",
        SoundTable = {
            {s = "ArcCw_Horde_M14.Foley",  t = 0},
        },
    },
    ["holster"] = {
        Source = "reg_holster",
        SoundTable = {
            {s = "ArcCw_Horde_M14.Foley",  t = 0},
        },
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
    sound = "weapons/bo1_m14/m14_reload_bolt_back.wav"
})
sound.Add({
    name = "ArcCw_Horde_M14.BoltRelease",
    volume = 1.0,
    sound = "weapons/bo1_m14/m14_reload_bolt_release.wav"
})
sound.Add({
    name = "ArcCw_Horde_M14.Foley",
    channel = CHAN_ITEM,
    volume = 0.5,
    sound = {"weapons/bo1_m14/m14_foley_1.wav","weapons/bo1_m14/m14_foley_2.wav","weapons/bo1_m14/m14_foley_3.wav","weapons/bo1_m14/m14_foley_4.wav"}
})
sound.Add({
    name = "ArcCw_Horde_M14.MagIn1",
    volume = 1.0,
    sound = "weapons/bo1_m14/m14_reload_mag_in_1.wav"
})
sound.Add({
    name = "ArcCw_Horde_M14.MagIn2",
    volume = 1.0,
    sound = "weapons/bo1_m14/m14_reload_mag_in_2.wav"
})
sound.Add({
    name = "ArcCw_Horde_M14.MagOut",
    volume = 1.0,
    sound = "weapons/bo1_m14/m14_reload_mag_out.wav"
})
sound.Add({
    name = "ArcCw_Horde_M14.MagRattle",
    volume = 1.0,
    sound = "weapons/bo1_m14/m14_reload_mag_rattle.wav"
})
