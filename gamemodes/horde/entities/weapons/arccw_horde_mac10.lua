SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "MAC-10"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = "A classic 'gangster' machine pistol popular for its ease of converting to full-auto, originally conceived as a low cost special forces weapon. Poor recoil, but a powerful .45 ACP round and fast rate of fire allow it to do heavy damage in a short time."
SWEP.Trivia_Manufacturer = "Military Armaments Corporation"
SWEP.Trivia_Calibre = ".45 ACP"
SWEP.Trivia_Mechanism = "Open-Bolt Straight Blowback"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 1964

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_mac10.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_mac10.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 35
SWEP.DamageMin = 20 -- damage done at maximum range
SWEP.Range = 45 -- in METRES
SWEP.Penetration = 5
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 32 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 300

SWEP.Recoil = 0.275
SWEP.RecoilSide = 0.275
SWEP.RecoilRise = 0.1
--SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 1300 -- 60 / RPM.
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

SWEP.AccuracyMOA = 12 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 500 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 75

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses
SWEP.MagID = "mac10" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "arccw_go/mac10/mac10_02.wav"
SWEP.ShootSound = "arccw_go/mac10/mac10_03.wav"
SWEP.ShootSoundSilenced = "arccw_go/mp5/mp5_01.wav"
SWEP.DistantShootSound = "arccw_go/mac10/mac10-1-distant.wav"

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

SWEP.SpeedMult = 0.97
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.27

SWEP.IronSightStruct = {
    Pos = Vector(-6.125, -7, 2.1),
    Ang = Angle(0, 0.1, 0),
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
    ["sidemount"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
        WMBodygroups = {{ind = 4, bg = 1}},
    },
    ["ubrms"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
        WMBodygroups = {{ind = 2, bg = 1}},
    },
    ["tacms"] = {
        VMBodygroups = {{ind = 6, bg = 1}},
        WMBodygroups = {{ind = 6, bg = 1}},
    },
    ["go_mac10_mag_16"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
        WMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
    ["go_mac10_mag_48"] = {
        VMBodygroups = {
            {ind = 3, bg = 2},
        },
        WMBodygroups = {
            {ind = 3, bg = 2},
        },
    },
    ["go_mac10_barrel_stub"] = {
        VMBodygroups = {
            {ind = 1, bg = 1},
        },
        WMBodygroups = {
            {ind = 1, bg = 1},
        },
    },
    ["go_mac10_barrel_med"] = {
        VMBodygroups = {
            {ind = 1, bg = 2},
        },
        WMBodygroups = {
            {ind = 1, bg = 2},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0.025, -3, 9.5),
            }
        }
    },
    ["go_mac10_barrel_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 3},
        },
        WMBodygroups = {
            {ind = 1, bg = 3},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0.025, -3, 15),
            }
        },
        VMElements = {
            {
                Model = "models/editor/axis_helper.mdl",
                Bone = "v_weapon.mac10_parent",
                Offset = {
                    pos = Vector(0.025, -2.9, 5),
                    ang = Angle(90, 0, -90),
                },
                Scale = Vector(0, 0, 0),
                IsMuzzleDevice = true
            }
        },
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 5, bg = 2},
        },
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube.mdl",
                Bone = "v_weapon.mac10_Parent",
                Offset = {
                    pos = Vector(0, -2.75, -3.75),
                    ang = Angle(90, 0, -90),
                },
            }
        },
    },
    ["go_mac10_stock_in"] = {
        VMBodygroups = {
            {ind = 5, bg = 1},
        },
    },
    ["go_mac10_stock_basilisk"] = {
        VMBodygroups = {
            {ind = 5, bg = 3},
        },
        WMBodygroups = {
            {ind = 5, bg = 3},
        },
    },
    ["go_mac10_stock_contractor"] = {
        VMBodygroups = {
            {ind = 5, bg = 4},
        },
    },
    ["go_mac10_stock_heavy"] = {
        VMBodygroups = {
            {ind = 5, bg = 5},
        },
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-18, 7, -3),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic_lp", "optic"},
        Bone = "v_weapon.mac10_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0.15, -5.25, -4),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"sidemount"},
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.mac10_parent",
        DefaultAttName = "Standard Foregrip",
        Offset = {
            vpos = Vector(0, -1.25, 8),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.mac10_parent",
        Offset = {
            vpos = Vector(1, -3.5, 3.5),
            vang = Angle(90, 0, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_mac10_barrel",
        DefaultAttName = "150mm MAC Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.mac10_parent",
        Offset = {
            vpos = Vector(0.025, -3, 7.5),
            vang = Angle(90, 0, -90),
        },
        ExcludeFlags = {"go_mac10_barrel_stub"}
    },
    {
        PrintName = "Magazine",
        Slot = "go_mac10_mag",
        DefaultAttName = "32-Round .45 Ingram"
    },
    {
        PrintName = "Stock",
        Slot = {"go_mac10_stock", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.mac10_parent",
        Offset = {
            vpos = Vector(0, -2.75, -3.75),
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
        Slot = "go_perk"
    },
    {
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "v_weapon.mac10_parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(1, -2.5, 2), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
            wpos = Vector(6.099, 1.1, -3.301),
            wang = Angle(171.817, 180-1.17, 0),
        },
    },
}

function SWEP:Hook_TranslateAnimation(anim)
    if anim == "fire_iron" then
        if self:GetBuff_Override("NoStock") then return "fire" end
    elseif anim == "fire_iron_empty" then
        if self:GetBuff_Override("NoStock") then return "fire_empty" end
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
        Source = {"shoot1", "shoot2", "shoot3"},
        Time = 0.45,
        ShellEjectAt = 0,
    },
    ["fire_empty"] = {
        Source = "shoot_empty",
        Time = 0.45,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "shoot_iron",
        Time = 0.45,
        ShellEjectAt = 0,
    },
    ["fire_iron_empty"] = {
        Source = "shoot_iron_empty",
        Time = 0.45,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
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
        LHIKIn = 0.4,
        LHIKOut = 0.3,
    },
    ["reload_smallmag_empty"] = {
        Source = "reload_smallmag_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.3,
    },
}

sound.Add({
    name = "ARCCW_GO_MAC10.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mac10/mac10_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_MAC10.Boltback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mac10/mac10_boltback.wav"
})

sound.Add({
    name = "ARCCW_GO_MAC10.Boltforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mac10/mac10_boltforward.wav"
})

sound.Add({
    name = "ARCCW_GO_MAC10.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mac10/mac10_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_MAC10.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/mac10/mac10_clipin.wav"
})