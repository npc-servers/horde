if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_waw_mp40")
    killicon.Add("arccw_horde_mp40", "arccw/weaponicons/arccw_waw_mp40", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_mw2_abase"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "MP40"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = "German submachine gun in 9mm. The weight and slower rate of fire allow for a weapon with very little recoil."
SWEP.Trivia_Manufacturer = "Erma Werke"
SWEP.Trivia_Calibre = "9x19mm Parabellum"
SWEP.Trivia_Mechanism = "Straight Blowback"
SWEP.Trivia_Country = "Nazi Germany"
SWEP.Trivia_Year = 1940

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/c_waw_mp40.mdl"
SWEP.WorldModel = "models/weapons/arccw/c_waw_mp40.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModelOffset = {
    scale = 1.1,
    pos = Vector(-9, 3, -4),
    ang = Angle(-7, 0, 180),
    bone = "ValveBiped.Bip01_R_Hand",
}
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000"

SWEP.Damage = 31
SWEP.DamageMin = 14 -- damage done at maximum range
SWEP.Range = 90 -- in METRES
SWEP.RangeMin = 25

SWEP.Penetration = 4
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 700 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 32 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 64

SWEP.Recoil = 0.2
SWEP.RecoilSide = 0.02
SWEP.RecoilRise = 0.15
SWEP.VisualRecoilMult = 1

SWEP.Delay = 60 / 525 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
}

SWEP.NPCWeaponType = "weapon_smg1"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 4 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 250 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 80

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = ")weapons/arccw/waw_mp40/mp40_st_f.ogg"
SWEP.ShootMechSound = ")weapons/arccw/waw_mp40/mp40_st_act.ogg"
SWEP.ShootSoundSilenced = ")weapons/fesiugmw2/fire/p90_sil.wav"

SWEP.MuzzleEffect = "muzzleflash_smg"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellScale = 1

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on
SWEP.ProceduralViewBobAttachment = 1
SWEP.CamAttachment = 3

SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.5
SWEP.SightTime = 0.2

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-1.75, -6, 0.1),
    Ang = Angle(1.75, -1.1, 0),
    Magnification = 1.1,
    CrosshairInSights = false,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "smg"
SWEP.HoldtypeSights = "smg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1

SWEP.ActivePos = Vector(2, -4, -2)
SWEP.ActiveAng = Angle(2, -1, 0)

SWEP.SprintPos = Vector(8, -4, -2)
SWEP.SprintAng = Angle(-7.036, 45.016, 0)

SWEP.CustomizePos = Vector(15, 0, -2)
SWEP.CustomizeAng = Angle(15, 40, 20)

SWEP.HolsterPos = Vector(3, 0, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 25

SWEP.ExtraSightDist = 5

SWEP.AttachmentElements = {
    ["mount"] = {
        VMBodygroups = {
            {ind = 2, bg = 1},
        },
        VMElements = {
            {
                Model = "models/weapons/arccw/fesiugmw2/atts/pistolrail_1.mdl",
                Bone = "tag_weapon",
                Scale = Vector(1, 1, 1),
                Offset = {
                    pos = Vector(1.3, -0.55, -0.2),
                    ang = Angle(0, 0, 0),
                }
            },
        },
    },
}

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = {"optic_lp"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(0.5, -0.55, 2.3),
            vang = Angle(0, 0, 0),
        },
        InstalledEles = {"mount"},
        CorrectivePos = Vector(0, 0, 0),
        CorrectiveAng = Angle(-3, 0, 0),
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        VMScale = Vector(0.9, 0.9, 0.9),
        WMScale = Vector(0.9, 0.9, 0.9),
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(14.5, -0.5, 0.9),
            vang = Angle(0, 0, 0),
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        VMScale = Vector(1, 1, 1),
        WMScale = Vector(1, 1, 1),
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(7, -0.5, 0.25),
            vang = Angle(0, 0, 0),
        },
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
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
            vpos = Vector(-2.5, -1.3, 0),
            vang = Angle(0, 0, 0),
        },
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 0,
    },
    ["idle_empty"] = {
        Source = "idle_empty",
        Time = 0,
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
    },
    ["draw_empty"] = {
        Source = "draw_empty",
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
    },
    ["holster"] = {
        Source = "holster",
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
    },
    ["holster_empty"] = {
        Source = "holster_empty",
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
    },
    ["ready"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.2,
    },
    ["fire"] = {
        Source = {"fire"},
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = {"fire"},
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = {"fire_empty"},
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = {"fire_empty"},
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        Checkpoints = {28, 38, 69},
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
        SoundTable = {
            {s = "weapons/arccw/waw_mp40/fly_mp40_mag_out.ogg", t = 18 / 30, c = CHAN_ITEM},
            {s = "weapons/arccw/waw_mp40/fly_colt45_futz.ogg", t = 51 / 30, c = CHAN_ITEM},
            {s = "weapons/arccw/waw_mp40/fly_mp40_mag_in.ogg", t = 61 / 30, c = CHAN_ITEM},
        },
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        Checkpoints = {28, 38, 69},
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0.2,
        SoundTable = {
            {s = "weapons/arccw/waw_mp40/fly_mp40_mag_out.ogg", t = 18 / 30, c = CHAN_ITEM},
            {s = "weapons/arccw/waw_mp40/fly_colt45_futz.ogg", t = 51 / 30, c = CHAN_ITEM},
            {s = "weapons/arccw/waw_mp40/fly_mp40_mag_in.ogg", t = 61 / 30, c = CHAN_ITEM},
            {s = "weapons/arccw/waw_mp40/fly_mp40_charge.ogg", t = 80 / 30, c = CHAN_ITEM},
        },
    },
}
