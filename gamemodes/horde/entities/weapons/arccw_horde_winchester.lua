 SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - CS+" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Randall Repeater"
SWEP.TrueName = "Model 1873"
SWEP.Trivia_Class = "Rifle"
SWEP.Trivia_Desc = "Old world lever action extremely popular in 19th Century America. Its ubiquitousness and fame earned it the title \"The Gun that Won the West\". While long outdated, it's still no less useful than the old days."
SWEP.Trivia_Manufacturer = "Hubert Repeating Arms Company"
SWEP.Trivia_Calibre = ".44-40"
SWEP.Trivia_Mechanism = "Lever-Action"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 1873

SWEP.Slot = 2

if GetConVar("arccw_truenames"):GetBool() then
    SWEP.PrintName = SWEP.TrueName
    SWEP.Trivia_Manufacturer = "Winchester Repeating Arms Company"
end

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw/c_winchester1873.mdl"
SWEP.WorldModel = "models/weapons/arccw/w_winchester1873.mdl"
SWEP.ViewModelFOV = 60

SWEP.Damage = 175
SWEP.DamageMin = 125 -- damage done at maximum range
SWEP.Range = 1500 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 24
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 500 -- projectile or phys bullet muzzle velocity
-- IN M/S

SWEP.TracerNum = 1 -- tracer every X
SWEP.TracerCol = Color(255, 25, 25)
SWEP.TracerWidth = 3

SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 8 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 10
SWEP.ReducedClipSize = 6

SWEP.Recoil = 1.5
SWEP.RecoilSide = 1

SWEP.ShotgunReload = true
SWEP.ManualAction = true

SWEP.Delay = 60 / 600 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.RunawayBurst = false
SWEP.Firemodes = {
    {
        PrintName = "LEVR",
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.AccuracyMOA = 1 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "ar2" -- what ammo type the gun uses

SWEP.ShootVol = 115 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.ShootSound = "weapons/arccw/winchester1873/w73-1.ogg"
SWEP.ShootSoundSilenced = "arccw_go/mosin_suppressed_fp.wav"
SWEP.DistantShootSound = "arccw_go/ssg08/ssg08-1-distant.wav"

SWEP.MuzzleEffect = "muzzleflash_1"
SWEP.ShellModel = "models/shells/shell_338mag.mdl"
SWEP.ShellPitch = 90
SWEP.ShellScale = 1

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 0.3

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
    -- [0] = "bulletchamber",
    -- [1] = "bullet1"
}

SWEP.ProceduralRegularFire = false
SWEP.ProceduralIronFire = false

SWEP.CaseBones = {}

SWEP.IronSightStruct = {
    Pos = Vector(-4.361, -2, 2.45),
    Ang = Angle(0.1, 0, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
}

SWEP.NPCWeaponType = {"weapon_ar2", "weapon_crossbow"}
SWEP.NPCWeight = 35


SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(0, 2, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(6, 2, -2.5)

SWEP.HolsterPos = Vector(0.532, -6, 0)
SWEP.HolsterAng = Angle(-7.036, 30.016, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.AttachmentElements = {
    ["extendedmag"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {{ind = 1,bg = 1}}
    },
    ["reducedmag"] = {
        VMBodygroups = {{ind = 1, bg = 2}},
        WMBodygroups = {{ind = 1,bg = 2}}
    },
    ["mount"] = {
        VMElements = {
            {
                Model = "models/weapons/arccw/atts/mount_rail.mdl",
                Bone = "gun",
                Scale = Vector(-1, -1, 1),
                Offset = {
                    pos = Vector(6.5, -1, 0),
                    ang = Angle(0, 0, -90)
                }
            }
        },
        WMElements = {
            {
                Model = "models/weapons/arccw/atts/mount_rail.mdl",
                Scale = Vector(-1, -1, 1),
                Offset = {
                    pos = Vector(17, 1.37, -6.9),
                    ang = Angle(-5, 0, 180)
                }
            }
        },
    }
}

SWEP.ExtraSightDist = 10
SWEP.BarrelLength = 40

SWEP.Attachments = {
    {
        PrintName = "Optic", -- print name
        DefaultAttName = "Iron Sights",
        Slot = {"optic", "optic_sniper"}, -- what kind of attachments can fit here, can be string or table
        Bone = "gun", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(6.5, -1, 0), -- offset that the attachment will be relative to the bone
            vang = Angle(0, 0, -90),
            wpos = Vector(17, 1.37, -7),
            wang = Angle(-5, 0, 180)
        },
        InstalledEles = {"mount"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "gun",
        Offset = {
            vpos = Vector(21, -0.6, 0),
            vang = Angle(0, 0, -90),
            wpos = Vector(37, 1.4, -8.2),
            wang = Angle(-5, 0, 180)
        },
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "ubgl", "bipod"},
        Bone = "gun",
        Offset = {
            vpos = Vector(5.5, 0.5, 0),
            vang = Angle(0, 0, -90),
            wpos = Vector(17, 1.5, -7.5),
            wang = Angle(-5, 0, 180)
        },
        SlideAmount = {
            vmin = Vector(4, 0.5, 0),
            vmax = Vector(10.5, 0.5, 0),
            wmin = Vector(15, 1.5, -5),
            wmax = Vector(22, 1.5, -5.8),
        }
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "gun",
        Offset = {
            vpos = Vector(12, -0.5, 0.2),
            vang = Angle(0, 0, 180),
            wpos = Vector(22, 0.8, -6.5),
            wang = Angle(-5, 0, 90)
        },
    },
    {
        PrintName = "Ammo Type",
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
        Bone = "gun", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(-1, 0, -0.5), -- offset that the attachment will be relative to the bone
            vang = Angle(0, 0, -90),
            wpos = Vector(10, 1.4, -3.5),
            wang = Angle(-5, 0, 180)
        },
    },
}

-- draw
-- holster
-- reload
-- fire
-- cycle (for bolt actions)
-- append _empty for empty variation

SWEP.Animations = {
    ["idle"] = false,
    ["draw"] = {
        Source = "draw",
        Time = 0.6,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 1,
        SoundTable = {{s = "weapons/arccw/sawedoff/sawedoff_draw.wav", t = 0}},
    },
    ["ready"] = {
        Source = "ready",
        Time = 1.5,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 1,
        SoundTable = {{s = "weapons/arccw/sawedoff/sawedoff_draw.wav", t = 0}},
        --[[]
        ViewPunchTable = {
            {p = Angle(3, 2, 3), t = 0.35},
            {p = Angle(-2, -2, -3), t = 0.65},
        },
        ]]
    },
    ["fire"] = {
        Source = "shoot",
        Time = 0.5,
    },
    ["cycle"] = {
        Source = "cycle",
        Time = 0.7,
        ShellEjectAt = 0.3,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.6,
    },
    ["cycle_iron"] = {
        Source = "cycle_iron",
        Time = 0.7,
        ShellEjectAt = 0.4,
    },
    ["sgreload_start"] = {
        Source = "reload_start",
        Time = 0.3,
    },
    ["sgreload_insert"] = {
        Source = "reload_insert",
        Time = 0.5,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        TPAnimStartTime = 0.5,
    },
    ["sgreload_finish"] = {
        Source = "reload_finish",
        Time = 0.3,
    },
    ["sgreload_finish_empty"] = {
        Source = "reload_finish_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.6,
        Time = 1,
    },
    ["bash"] = {
        Source = "bash",
        Time = 0.5,
    },
}

sound.Add({
    name = "Weapon_73.Pump",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arccw/winchester1873/w73pump.ogg"
})

sound.Add({
    name = "Weapon_73.Insertshell",
    channel = CHAN_ITEM,
    volume = 1.0,
    sound = "weapons/arccw/winchester1873/w73insertshell.ogg"
})
if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_winchester")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_winchester", "vgui/hud/arccw_horde_winchester", Color(0, 0, 0, 255))
end
