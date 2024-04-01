SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Glock 17"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Exceptionally popular automatic pistol with polymer frame. Good performance, reliability, and simple operation that does not include a safety switch make it very popular among cops and robbers alike."
SWEP.Trivia_Manufacturer = "GLOCK GmbH"
SWEP.Trivia_Calibre = "9x19mm Parabellum"
SWEP.Trivia_Mechanism = "Short Recoil"
SWEP.Trivia_Country = "Austria"
SWEP.Trivia_Year = 1982

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_glock.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_glock.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 26
SWEP.DamageMin = 19 -- damage done at maximum range
SWEP.Range = 45 -- in METRES
SWEP.Penetration = 6
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 17 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 250

SWEP.Recoil = 0.315
SWEP.RecoilSide = 0.175
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 700 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
}

SWEP.NPCWeaponType = "weapon_pistol"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 15 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 125 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 25

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses
SWEP.MagID = "glock" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "arccw_go/glock18/glock_01.wav"
SWEP.ShootSound = "arccw_go/glock18/glock_02.wav"
SWEP.ShootSoundSilenced = "arccw_go/usp/usp_01.wav"
SWEP.DistantShootSound = "arccw_go/glock18/glock18-1-distant.wav"

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
    Pos = Vector(-2.83191, 0, 1.15),
    Ang = Angle(1, 0, 0),
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
                Bone = "v_weapon.glock_parent",
                Offset = {
                    pos = Vector(0, -1.25, 4.5),
                    ang = Angle(90, 0, -90),
                },
                Scale = Vector(0.95, 0.95, 0.95)
            }
        },
        AttPosMods = {
            [2] = {
                vpos = Vector(0, -0.8, 4.5),
            }
        }
    },
    ["go_glock_mag_28"] = {
        VMBodygroups = {
            {ind = 2, bg = 2},
        },
    },
    ["go_glock_slide_short"] = {
        NameChange = "Glock 26",
        VMBodygroups = {
            {ind = 0, bg = 1},
            {ind = 1, bg = 1},
            {ind = 2, bg = 1},
        },
        AttPosMods = {
            [4] = {
                vpos = Vector(0, -2.35, 5.35),
            }
        }
    },
    ["go_glock_slide_auto"] = {
        NameChange = "Glock 18",
        VMBodygroups = {
            {ind = 1, bg = 2}
        },
        AttPosMods = {
            [4] = {
                vpos = Vector(0, -2.35, 6.2),
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
        Bone = "v_weapon.glock_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0, -3.4, 2),
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
        Bone = "v_weapon.glock_parent",
        Offset = {
            vpos = Vector(0, -1.4, 4.5),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Slide",
        Slot = "go_glock_slide",
        DefaultAttName = "110mm G17 Slide"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.glock_parent",
        Offset = {
            vpos = Vector(0, -2.35, 6.2),
            vang = Angle(90, 0, -90),
        },
    },
    {
        PrintName = "Magazine",
        Slot = "go_glock_mag",
        DefaultAttName = "17-Round 9mm G17"
    },
    {
        PrintName = "Stock",
        Slot = "go_stock_pistol_bt",
        DefaultAttName = "No Stock",
        Bone = "v_weapon.glock_parent",
        Offset = {
            vpos = Vector(0, -1.7, -1),
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
        Bone = "v_weapon.glock_slide", -- relevant bone any attachments will be mostly referring to
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
    name = "ARCCW_GO_GLOCK.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/glock18/glock_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_GLOCK.Slideback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/glock18/glock_slideback.wav"
})

sound.Add({
    name = "ARCCW_GO_GLOCK.Sliderelease",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/glock18/glock_sliderelease.wav"
})

sound.Add({
    name = "ARCCW_GO_GLOCK.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/glock18/glock_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_GLOCK.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/glock18/glock_clipin.wav"
})