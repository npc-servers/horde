SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "P90 TR"
SWEP.Trivia_Class = "PDW"
SWEP.Trivia_Desc = "Personal defense weapon with a high-capacity magazine, loading tiny pointed armor-piercing rounds. Good firepower in a compact package. The 'TRI RAIL' model has three picatinny rails for attachments."
SWEP.Trivia_Manufacturer = "Fabrique National Herstale"
SWEP.Trivia_Calibre = "5.7x28mm"
SWEP.Trivia_Mechanism = "Closed-Bolt Blowback"
SWEP.Trivia_Country = "Belgium"
SWEP.Trivia_Year = 2001

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_p90.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_p90.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 41
SWEP.DamageMin = 30 -- damage done at maximum range
SWEP.Range = 75 -- in METRES
SWEP.Penetration = 9
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 50 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 715

SWEP.Recoil = 0.155
SWEP.RecoilSide = 0.091
SWEP.RecoilRise = 0.1
--SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 900 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_smg1"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 3 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 500 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 75

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "p90" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "arccw_go/p90/p90_01.wav"
SWEP.ShootSound = "arccw_go/p90/p90_02.wav"
SWEP.ShootSoundSilenced = "arccw_go/mp5/mp5_01.wav"
SWEP.DistantShootSound = "arccw_go/p90/p90-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_smg"
SWEP.ShellModel = "models/shells/shell_57.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.97
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.25

SWEP.IronSightStruct = {
    Pos = Vector(-5.175, -7, -0.4),
    Ang = Angle(0.1, 0.17, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_AR2

SWEP.ActivePos = Vector(-1, 2, -1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CrouchPos = Vector(-4, 0, -1)
SWEP.CrouchAng = Angle(0, 0, -10)

SWEP.HolsterPos = Vector(3, 3, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.CustomizePos = Vector(8, 0, 1)
SWEP.CustomizeAng = Angle(5, 30, 30)

SWEP.BarrelLength = 24

SWEP.AttachmentElements = {
    ["nors"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
    },
    ["nofh"] = {
        VMBodygroups = {{ind = 2, bg = 4}},
    },
    ["ubrms"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
    },
    ["go_p90_mag_30"] = {
        VMBodygroups = {
            {ind = 5, bg = 1},
        },
    },
    ["go_p90_barrel_med"] = {
        VMBodygroups = {
            {ind = 1, bg = 1},
            {ind = 2, bg = 1},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0.025, -3.1, 9),
            }
        }
    },
    ["go_p90_barrel_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 2},
            {ind = 2, bg = 2},
            {ind = 3, bg = 1},
        },
        AttPosMods = {
            [2] = {
                vpos = Vector(0, -1.25, 12),
            },
            [3] = {
                vpos = Vector(0.4, -3.6, 16),
            },
            [5] = {
                vpos = Vector(0.025, -3.1, 18),
            }
        }
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-14, 6, -3),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Hook_ModifyBodygroups = function(wep, data)
    local vm = data.vm
    local eles = data.eles

    for i, k in pairs(eles or {}) do
        if k == "nors" then
            vm:SetBodygroup(2, 4)
            break
        end
    end
end

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic_lp", "optic"},
        Bone = "v_weapon.p90_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0.0225, -5.7, 3.5),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"nors"},
        CorrectiveAng = Angle(-0.25, 0, 0)
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.p90_parent",
        DefaultAttName = "Standard Foregrip",
        Offset = {
            vpos = Vector(0, -1.25, 9),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.p90_parent",
        Offset = {
            vpos = Vector(0.4, -5.3, 6),
            vang = Angle(90, 0, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
    },
    {
        PrintName = "Barrel",
        Slot = "go_p90_barrel",
        DefaultAttName = "260mm PDW Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.p90_parent",
        Offset = {
            vpos = Vector(0.025, -3.1, 7.5),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"nofh"},
    },
    {
        PrintName = "Magazine",
        Slot = "go_p90_mag",
        DefaultAttName = "50-Round 5.7mm P90"
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.p90_parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.75, -3, -1), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
        },
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["ready"] = {
        Source = "ready",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["fire"] = {
        Source = "shoot",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "idle",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 1,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
    },
    ["reload_smallmag"] = {
        Source = "reload_smallmag",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.7,
    },
    ["reload_smallmag_empty"] = {
        Source = "reload_smallmag_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.8,
    },
}

sound.Add({
    name = "ARCCW_GO_P90.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/p90/p90_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_P90.BoltBack",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/p90/p90_boltback.wav"
})

sound.Add({
    name = "ARCCW_GO_P90.BoltForward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/p90/p90_boltforward.wav"
})

sound.Add({
    name = "ARCCW_GO_P90.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/p90/p90_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_P90.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/p90/p90_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_P90.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/p90/p90_cliphit.wav"
})