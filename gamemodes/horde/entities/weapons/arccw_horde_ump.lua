SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "UMP-45"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = ".45 calibre submachine gun created to replace the MP5. Has a more controllable fire rate, and 2-round burst features."
SWEP.Trivia_Manufacturer = "Heckler und Koch"
SWEP.Trivia_Calibre = ".45 ACP"
SWEP.Trivia_Mechanism = "Roller-Delayed Blowback"
SWEP.Trivia_Country = "Germany"
SWEP.Trivia_Year = 1999

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_ump45.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_ump45.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 38
SWEP.DamageMin = 27 -- damage done at maximum range
SWEP.Range = 75 -- in METRES
SWEP.Penetration = 6
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 250 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 25 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 300

SWEP.Recoil = 0.200
SWEP.RecoilSide = 0.100
SWEP.RecoilRise = 0.1
--SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 650 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = -2
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.Hook_TranslateAnimation = function(wep, anim)
    if anim != "ready" then return end

    local dice = util.SharedRandom("ReadyOrNot", 0, 1, CurTime())

    if dice > 0.5 then
        return "ready_55"
    else
        return "ready_56"
    end
end

SWEP.NPCWeaponType = "weapon_smg1"
SWEP.NPCWeight = 100

SWEP.AccuracyMOA = 7 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 325 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 75

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses
SWEP.MagID = "ump" -- the magazine pool this gun draws from

SWEP.ShootVol = 110 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "arccw_go/ump45/ump45_02.wav"
SWEP.ShootSound = "arccw_go/ump45/ump45_04.wav"
SWEP.ShootSoundSilenced = "arccw_go/mp5/mp5_01.wav"
SWEP.DistantShootSound = "arccw_go/ump45/ump45-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_smg"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.95
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.300

SWEP.IronSightStruct = {
    Pos = Vector(-5.1, -7, 1.5),
    Ang = Angle(0, 0.05, 0),
    Magnification = 1.1,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = false
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "ar2"
SWEP.HoldtypeSights = "rpg"

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
    ["go_stock_none"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
    },
    ["go_ump_stock_in"] = {
        VMBodygroups = {{ind = 3, bg = 2}},
    },
    ["go_ump_mag_12"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
    ["go_ump_mag_30_9mm"] = {
        NameChange = "UMP-9",
        VMBodygroups = {{ind = 2, bg = 2}},
    },
    ["go_ump_barrel_med"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -3.95, 17.5),
            }
        }
    },
    ["go_ump_barrel_long"] = {
        VMBodygroups = {{ind = 1, bg = 2}},
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -3.95, 20),
            }
        }
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube.mdl",
                Bone = "v_weapon.ump45_Parent",
                Offset = {
                    pos = Vector(0, -4.5, -1.75),
                    ang = Angle(90, 0, -90),
                },
            }
        },
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-17, 6, -5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic_lp", "optic"},
        Bone = "v_weapon.ump45_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0, -6.2, 4),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"rail"},
        VMScale = Vector(1.25, 1.25, 1.25),
        CorrectiveAng = Angle(0.5, 0, 0),
        CorrectivePos = Vector(0, 0, 0)
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.ump45_parent",
        DefaultAttName = "Standard Foregrip",
        Offset = {
            vpos = Vector(0, -3, 12),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.ump45_parent",
        Offset = {
            vpos = Vector(0.75, -4, 11),
            vang = Angle(90, 0, 0),
        },
        InstalledEles = {"tacms"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_ump_barrel",
        DefaultAttName = "200mm HK Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.ump45_parent",
        Offset = {
            vpos = Vector(0, -3.95, 15),
            vang = Angle(90, 0, -90),
        },
    },
    {
        PrintName = "Magazine",
        Slot = "go_ump_mag",
        DefaultAttName = "25-Round .45 UMP"
    },
    {
        PrintName = "Stock",
        Slot = {"go_ump_stock", "go_stock_none", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.ump45_parent",
        Offset = {
            vpos = Vector(0, -4.5, -1.75),
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
        Bone = "v_weapon.ump45_parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.9, -4, 3), -- offset that the attachment will be relative to the bone
            vang = Angle(90, 0, -90),
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
        Time = 0.25,
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
        LHIKOut = 0.4,
        LHIKEaseOut = 0.3
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.4,
        LHIKOut = 0.4,
        LHIKEaseOut = 0.3
    },
}

sound.Add({
    name = "ARCCW_GO_UMP.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/ump45/ump45_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_UMP.BoltBack",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/ump45/ump45_boltback.wav"
})

sound.Add({
    name = "ARCCW_GO_UMP.BoltForward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/ump45/ump45_boltforward.wav"
})

sound.Add({
    name = "ARCCW_GO_UMP.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/ump45/ump45_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_UMP.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/ump45/ump45_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_UMP.Cliphit",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/ump45/ump45_cliphit.wav"
})