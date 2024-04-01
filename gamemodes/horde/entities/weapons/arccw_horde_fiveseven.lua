SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Five-seveN"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Handgun designed to share rounds with the P90 PDW. Excellent range compared to most handguns but not very hard hitting."
SWEP.Trivia_Manufacturer = "Fabrique National Herstale"
SWEP.Trivia_Calibre = "5.7x28mm"
SWEP.Trivia_Mechanism = "Delayed Blowback"
SWEP.Trivia_Country = "Belgium"
SWEP.Trivia_Year = 1998

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_fiveseven.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 34
SWEP.DamageMin = 25 -- damage done at maximum range
SWEP.Range = 80 -- in METRES
SWEP.Penetration = 10
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 20 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 500

SWEP.Recoil = 0.225
SWEP.RecoilSide = 0.075
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 700 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.NPCWeaponType = "weapon_pistol"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 6 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 125 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 25

SWEP.Primary.Ammo = "smg1" -- what ammo type the gun uses
SWEP.MagID = "fiveseven" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "arccw_go/fiveseven/fiveseven-1.wav"
SWEP.ShootSoundSilenced = "arccw_go/usp/usp_02.wav"
SWEP.DistantShootSound = "arccw_go/fiveseven/fiveseven-1-distant.wav"

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

SWEP.SpeedMult = 0.99
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.200

SWEP.IronSightStruct = {
    Pos = Vector(-2.71, 0, 0.7),
    Ang = Angle(0.7, 0.3, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

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

SWEP.AttachmentElements = {
    ["rail"] = {
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/pistol_rail.mdl",
                Bone = "v_weapon.fiveSeven_parent",
                Offset = {
                    pos = Vector(0, -1.2, 5),
                    ang = Angle(90, 0, -90),
                },
                Scale = Vector(0.95, 0.95, 0.95)
            }
        },
        AttPosMods = {
            [2] = {
                vpos = Vector(0, -0.75, 5),
            }
        }
    },
    ["go_fiveseven_mag_30"] = {
        VMBodygroups = {
            {ind = 2, bg = 1},
        },
    },
    ["go_fiveseven_slide_short"] = {
        VMBodygroups = {
            {ind = 0, bg = 1},
            {ind = 1, bg = 1}
        },
        AttPosMods = {
            [4] = {
                vpos = Vector(0, -2.2, 6),
            }
        }
    },
    ["go_fiveseven_slide_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 2}
        },
        AttPosMods = {
            [4] = {
                vpos = Vector(0, -2.2, 7.5),
            }
        }
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-12.5, 4, -2.5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = "optic_lp",
        Bone = "v_weapon.fiveSeven_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0, -3.4, 2.5),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"rail"},
        CorrectiveAng = Angle(-1.25, 0, 0)
    },
    {
        PrintName = "Tactical",
        Slot = {"tac", "foregrip"},
        Bone = "v_weapon.fiveSeven_parent",
        Offset = {
            vpos = Vector(0, -1.25, 4.5),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Slide",
        Slot = "go_fiveseven_slide",
        DefaultAttName = "120mm FN Slide"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.fiveSeven_parent",
        Offset = {
            vpos = Vector(0, -2.2, 6.1),
            vang = Angle(90, 0, -90),
        },
        VMScale = Vector(1, 1, 1)
    },
    {
        PrintName = "Magazine",
        Slot = "go_fiveseven_mag",
        DefaultAttName = "20-Round 5.7mm FN"
    },
    {
        PrintName = "Stock",
        Slot = "go_stock_pistol_bt",
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.fiveSeven_parent",
        Offset = {
            vpos = Vector(-0.05, -1.5, -1),
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
        Bone = "v_weapon.fiveSeven_slide", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.5, 0, 5), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
        },
        VMScale = Vector(0.5, 0.5, 0.5)
    },
}

function SWEP:Hook_TranslateAnimation(anim)
    if anim == "fire_iron" then
        if !self.Attachments[6].Installed then return "fire" end
    elseif anim == "fire_iron_empty" then
        if !self.Attachments[6].Installed then return "fire_empty" end
    end
end

SWEP.Animations = {
    ["idle"] = {
        Source = "idle"
    },
    ["idle_empty"] = {
        Source = "idle_empty"
    },
    ["draw"] = {
        Source = "draw",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.5,
    },
    ["draw_empty"] = {
        Source = "draw_empty",
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
        Time = 0.4,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shoot_iron",
        Time = 0.4,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "shoot_empty",
        Time = 0.4,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "shoot_iron_empty",
        Time = 0.4,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
    },
    ["reload_long"] = {
        Source = "reload_long",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
    },
    ["reload_long_empty"] = {
        Source = "reload_long_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
    },
}

sound.Add({
    name = "ARCCW_GO_FIVESEVEN.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/fiveseven/fiveseven_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_FIVESEVEN.Slideback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/fiveseven/fiveseven_slideback.wav"
})

sound.Add({
    name = "ARCCW_GO_FIVESEVEN.Sliderelease",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/fiveseven/fiveseven_sliderelease.wav"
})

sound.Add({
    name = "ARCCW_GO_FIVESEVEN.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/fiveseven/fiveseven_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_FIVESEVEN.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/fiveseven/fiveseven_clipin.wav"
})