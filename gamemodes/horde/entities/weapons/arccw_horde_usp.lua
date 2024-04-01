SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "USP-45"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Iconic pistol designed for police and special forces use. Threaded barrel allows for suppressor attachment."
SWEP.Trivia_Manufacturer = "Heckler und Koch"
SWEP.Trivia_Calibre = ".45 ACP"
SWEP.Trivia_Mechanism = "Short Recoil DA/SA"
SWEP.Trivia_Country = "Germany"
SWEP.Trivia_Year = 1993

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_usp.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_usp.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 35
SWEP.DamageMin = 21 -- damage done at maximum range
SWEP.Range = 40 -- in METRES
SWEP.Penetration = 5
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 12 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 200

SWEP.Recoil = 0.400
SWEP.RecoilSide = 0.125
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 450 -- 60 / RPM.
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

SWEP.AccuracyMOA = 12 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 25

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses
SWEP.MagID = "usp" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "arccw_go/usp/usp_unsilenced_01.wav"
SWEP.ShootSound = "arccw_go/usp/usp_unsilenced_02.wav"
SWEP.ShootSoundSilenced = "arccw_go/usp/usp_02.wav"
SWEP.DistantShootSound = "arccw_go/usp/usp_unsil-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.99
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.200

SWEP.IronSightStruct = {
    Pos = Vector(-2.83191, 0, 1.35),
    Ang = Angle(0.25, 0, 0),
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
                Bone = "v_weapon.223_Parent",
                Offset = {
                    pos = Vector(-0.05, -1.6, 6),
                    ang = Angle(90, 0, -90),
                },
                Scale = Vector(0.95, 0.95, 0.95)
            }
        },
        AttPosMods = {
            [2] = {
                vpos = Vector(-0.05, -1.2, 6),
            }
        }
    },
    ["go_usp_mag_20"] = {
        VMBodygroups = {
            {ind = 2, bg = 1},
        },
    },
    ["go_usp_mag_30"] = {
        VMBodygroups = {
            {ind = 2, bg = 2},
        },
    },
    ["go_usp_slide_short"] = {
        VMBodygroups = {
            {ind = 0, bg = 1},
            {ind = 1, bg = 1}
        },
        AttPosMods = {
            [4] = {
                vpos = Vector(-0.05, -2.99, 6.4),
            }
        }
    },
    ["go_usp_slide_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 2}
        },
        AttPosMods = {
            [4] = {
                vpos = Vector(-0.05, -2.99, 8.75),
            }
        }
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-12.5, 4, -3),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = "optic_lp",
        Bone = "v_weapon.223_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(-0.05, -3.8, 3),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"rail"},
        CorrectiveAng = Angle(-1.35, 0, 0)
    },
    {
        PrintName = "Tactical",
        Slot = {"tac", "foregrip"},
        Bone = "v_weapon.223_parent",
        Offset = {
            vpos = Vector(-0.05, -1.75, 6),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Slide",
        Slot = "go_usp_slide",
        DefaultAttName = "110mm USP Slide"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.223_parent",
        Offset = {
            vpos = Vector(-0.05, -2.99, 7.35),
            vang = Angle(90, 0, -90),
        },
    },
    {
        PrintName = "Magazine",
        Slot = "go_usp_mag",
        DefaultAttName = "12-Round .45 USP"
    },
    {
        PrintName = "Stock",
        Slot = "go_stock_pistol_bt",
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.223_parent",
        Offset = {
            vpos = Vector(-0.05, -1.9, -1),
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
        Bone = "v_weapon.slide", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.5, -0.4, 1.5), -- offset that the attachment will be relative to the bone
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
    ["reload_med"] = {
        Source = "reload_med",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
    },
    ["reload_med_empty"] = {
        Source = "reload_med_empty",
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
    name = "ARCCW_GO_USP.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/hkp2000/hkp2000_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_USP.Slideback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/hkp2000/hkp2000_slideback.wav"
})

sound.Add({
    name = "ARCCW_GO_USP.Sliderelease",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/hkp2000/hkp2000_sliderelease.wav"
})

sound.Add({
    name = "ARCCW_GO_USP.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/hkp2000/hkp2000_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_USP.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/hkp2000/hkp2000_clipin.wav"
})