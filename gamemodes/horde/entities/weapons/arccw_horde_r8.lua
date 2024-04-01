SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Model 327 R8"
SWEP.Trivia_Class = "Revolver"
SWEP.Trivia_Desc = "Modern revolver made for the modern world. Mitigates some disadvantages of traditional revolvers with an 8-round cylinder and built in rails for sights and LAMs."
SWEP.Trivia_Manufacturer = "Smith and Wesson"
SWEP.Trivia_Calibre = ".357 Magnum"
SWEP.Trivia_Mechanism = "Double-Action"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 2006

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_r8.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_r8.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 75
SWEP.DamageMin = 35 -- damage done at maximum range
SWEP.Range = 45 -- in METRES
SWEP.Penetration = 10
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
-- IN M/S
SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 8 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 600

SWEP.Recoil = 1.75
SWEP.RecoilSide = 1.75
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 300 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "DACT"
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_357"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 250 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

SWEP.Primary.Ammo = "357" -- what ammo type the gun uses

SWEP.ShootVol = 120 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "arccw_go/revolver/revolver-1_01.wav"
SWEP.ShootSoundSilenced = "arccw_go/usp/usp_01.wav"
SWEP.DistantShootSound = "arccw_go/revolver/revolver-1_distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol_deagle"

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on

SWEP.SpeedMult = 0.96
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.350

SWEP.IronSightStruct = {
    Pos = Vector(-3.85, 0, 0.8),
    Ang = Angle(0.1, -0.635, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_REVOLVER

SWEP.ActivePos = Vector(-1, 2, -1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-4, 0, -1)
SWEP.CrouchAng = Angle(0, 0, -10)

SWEP.HolsterPos = Vector(3, 3, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)
SWEP.BarrelOffsetCrouch = Vector(0, 0, -2)

SWEP.CustomizePos = Vector(8, 0, 1)
SWEP.CustomizeAng = Angle(5, 30, 30)

SWEP.BarrelLength = 24

SWEP.BulletBones = false

SWEP.RevolverReload = true

SWEP.CaseBones = {
    [6] = "v_weapon.cylbullet1",
    [7] = "v_weapon.cylbullet2",
    [8] = "v_weapon.cylbullet3",
    [1] = "v_weapon.cylbullet4",
    [2] = "v_weapon.cylbullet5",
    [3] = "v_weapon.cylbullet6",
    [4] = "v_weapon.cylbullet7",
    [5] = "v_weapon.cylbullet8",
}

SWEP.AttachmentElements = {
    ["go_r8_barrel_short"] = {
        VMBodygroups = {
            {ind = 4, bg = 1},
        },
        AttPosMods = {
            [4] = {
                vpos = Vector(0, -3.4, 8.25)
            }
        }
    },
    ["go_r8_barrel_long"] = {
        VMBodygroups = {
            {ind = 4, bg = 2},
        },
        AttPosMods = {
            [4] = {
                vpos = Vector(0, -3.4, 11)
            }
        }
    },
    ["tacms"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-12.5, 5, -3),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic", "optic_lp"},
        Bone = "v_weapon.deagle_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(-0.05, -4.2, 5.5),
            vang = Angle(90, 0, -90),
        },
        CorrectiveAng = Angle(0, 0, 0),
    },
    {
        PrintName = "Tactical",
        Slot = {"tac", "foregrip"},
        Bone = "v_weapon.deagle_parent",
        Offset = {
            vpos = Vector(0, -2.3, 9),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"tacms"},
        ExcludeFlags = {"go_r8_barrel_short"}
    },
    {
        PrintName = "Barrel",
        Slot = "go_r8_barrel",
        DefaultAttName = "140mm S&W PC Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.deagle_parent",
        Offset = {
            vpos = Vector(0, -3.4, 10.25),
            vang = Angle(90, 0, -90),
        },
    },
    {
        PrintName = "Stock",
        Slot = "go_stock_pistol_bt",
        DefaultAttName = "No Stock",
        Bone = "v_weapon.deagle_parent",
        Offset = {
            vpos = Vector(0, -2, 1),
            vang = Angle(90, 0, -90),
        },
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Perk",
        Slot = {"go_perk", "go_perk_pistol"}
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.deagle_parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.35, -3.4, 6.5), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
        },
        VMScale = Vector(0.5, 0.5, 0.5)
    },
}

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "draw_alt",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["ready"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fire"] = {
        Source = {"alt1", "alt2", "alt3"},
        Time = 0.5,
        LHIK = true,
        LHIKIn = 0.1,
        LHIKOut = 0.1,
    },
    ["fire_iron"] = {
        Source = "fire",
        Time = 0.5,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        LastClip1OutTime = 31 / 30,
        SoundTable = {
            {
                t = 0 / 30,
                ind = 1,
                bg = 2
            },
            {
                t = 31 / 30,
                ind = 2,
                bg = 1
            },
            {
                t = 31 / 30,
                ind = 1,
                bg = 1
            },
            {
                t = 47 / 30,
                ind = 1,
                bg = 0
            },
            {
                t = 48 / 30,
                ind = 2,
                bg = 2
            },
            {
                t = 53 / 30,
                ind = 2,
                bg = 0
            },
        }
    },
}

sound.Add({
    name = "ARCCW_GO_R8.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/revolver/revolver_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_R8.sideback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/revolver/revolver_sideback.wav"
})

sound.Add({
    name = "ARCCW_GO_R8.sideforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/revolver/revolver_sideforward.wav"
})

sound.Add({
    name = "ARCCW_GO_R8.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/revolver/revolver_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_R8.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/revolver/revolver_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_R8.Prepare",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/revolver/revolver_prepare.wav"
})