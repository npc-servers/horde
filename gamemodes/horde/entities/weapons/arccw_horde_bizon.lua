SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "PP-19 Bizon-2"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = "Russian SMG made for remote FSB special forces divisions. Based on the PP-19-01 Vityaz SMG, itself based on the AK-47, it is capable of carrying an unprecedented amount of ammunition in a single magazine."
SWEP.Trivia_Manufacturer = "Izhmash"
SWEP.Trivia_Calibre = "9x18mm Makarov"
SWEP.Trivia_Mechanism = "Closed-Bolt Blowback"
SWEP.Trivia_Country = "Russia"
SWEP.Trivia_Year = 1996

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_bizon.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_bizon.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 45
SWEP.DamageMin = 32 -- damage done at maximum range
SWEP.Range = 50 -- in METRES
SWEP.Penetration = 6
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.MuzzleVelocity = 1050 -- projectile or phys bullet muzzle velocity
-- IN M/S
SWEP.ChamberSize = 1 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 64 -- DefaultClip is automatically set.

SWEP.PhysBulletMuzzleVelocity = 320

SWEP.Recoil = 0.115
SWEP.RecoilSide = 0.115
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 2.5

SWEP.Delay = 60 / 750 -- 60 / RPM.
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
SWEP.HipDispersion = 400 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

SWEP.Primary.Ammo = "pistol" -- what ammo type the gun uses
SWEP.MagID = "bizon" -- the magazine pool this gun draws from

SWEP.ShootVol = 100 -- volume of shoot sound
SWEP.ShootPitch = 100 -- pitch of shoot sound

SWEP.FirstShootSound = "arccw_go/bizon/bizon_01.wav"
SWEP.ShootSound = "arccw_go/bizon/bizon_02.wav"
SWEP.ShootSoundSilenced = "arccw_go/mp5/mp5_01.wav"
SWEP.DistantShootSound = "arccw_go/bizon/bizon-1-distant.wav"

SWEP.MeleeSwingSound = "arccw_go/m249/m249_draw.wav"
SWEP.MeleeMissSound = "weapons/iceaxe/iceaxe_swing1.wav"
SWEP.MeleeHitSound = "arccw_go/knife/knife_hitwall1.wav"
SWEP.MeleeHitNPCSound = "physics/body/body_medium_break2.wav"

SWEP.MuzzleEffect = "muzzleflash_smg_bizon"
SWEP.ShellModel = "models/shells/shell_9mm.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 1.25
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 0.96
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.27

SWEP.IronSightStruct = {
    Pos = Vector(-5.09594, -8.573, 1.12272),
    Ang = Angle(-0.25, 0.05, 0),
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
    ["sidemount"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
        WMBodygroups = {{ind = 4, bg = 1}},
    },
    ["ubrms"] = {
        VMBodygroups = {{ind = 5, bg = 1}},
        WMBodygroups = {{ind = 5, bg = 1}},
    },
    ["no_fh"] = {
        VMBodygroups = {{ind = 2, bg = 3}},
        WMBodygroups = {{ind = 2, bg = 3}},
    },
    ["go_stock_none"] = {
        VMBodygroups = {
            {ind = 6, bg = 1},
        },
    },
    ["go_stock"] = {
        VMBodygroups = {
            {ind = 6, bg = 1}
        },
        VMElements = {
            {
                Model = "models/weapons/arccw_go/atts/stock_buftube_lp.mdl",
                Bone = "v_weapon.bizon_parent",
                Offset = {
                    pos = Vector(0, -2.75, -1.35),
                    ang = Angle(90, 0, -90),
                },
            }
        },
    },
    ["go_bizon_stock_basilisk"] = {
        VMBodygroups = {
            {ind = 6, bg = 2},
        },
        WMBodygroups = {
            {ind = 6, bg = 2},
        },
    },
    ["go_bizon_stock_contractor"] = {
        VMBodygroups = {
            {ind = 6, bg = 3},
        },
        WMBodygroups = {
            {ind = 6, bg = 3},
        },
    },
    ["go_bizon_barrel_med"] = {
        VMBodygroups = {
            {ind = 1, bg = 1},
            {ind = 2, bg = 1},
        },
        WMBodygroups = {
            {ind = 1, bg = 1},
            {ind = 2, bg = 1},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -3.2, 17.5),
            }
        }
    },
    ["go_bizon_barrel_long"] = {
        VMBodygroups = {
            {ind = 1, bg = 2},
            {ind = 2, bg = 2},
        },
        WMBodygroups = {
            {ind = 1, bg = 2},
            {ind = 2, bg = 2},
        },
        AttPosMods = {
            [5] = {
                vpos = Vector(0, -3.2, 18),
            }
        }
    },
    ["go_bizon_mag_47"] = {
        VMBodygroups = {
            {ind = 3, bg = 1},
        },
        WMBodygroups = {
            {ind = 3, bg = 1},
        },
    },
    ["go_bizon_mag_82"] = {
        VMBodygroups = {
            {ind = 3, bg = 2},
        },
        WMBodygroups = {
            {ind = 3, bg = 2},
        },
    },
}

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.WorldModelOffset = {
    pos = Vector(-12, 5.5, -5),
    ang = Angle(-10, 0, 180)
}

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Optic",
        Slot = {"optic", "optic_lp"},
        Bone = "v_weapon.bizon_parent",
        DefaultAttName = "Iron Sights",
        Offset = {
            vpos = Vector(0.125, -5.3, 2.5),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        VMScale = Vector(1.1, 1.1, 1.1),
        InstalledEles = {"sidemount"},
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "v_weapon.bizon_clip",
        Offset = {
            vpos = Vector(0, 1, 3),
            vang = Angle(90, 0, -90),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"ubrms"},
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "v_weapon.bizon_parent",
        Offset = {
            vpos = Vector(1.24, -4, 3),
            vang = Angle(90, 0, 0),
            wpos = Vector(22, 1, -7),
            wang = Angle(-9.79, 0, 180)
        },
        InstalledEles = {"sidemount"},
    },
    {
        PrintName = "Barrel",
        Slot = "go_bizon_barrel",
        DefaultAttName = "200mm SOBR Barrel"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "v_weapon.bizon_parent",
        Offset = {
            vpos = Vector(0, -3.2, 16),
            vang = Angle(90, 0, -90),
        },
        InstalledEles = {"no_fh"},
    },
    {
        PrintName = "Magazine",
        Slot = "go_bizon_mag",
        DefaultAttName = "64-Round 9mm Bizon"
    },
    {
        PrintName = "Stock",
        Slot = {"go_bizon_stock", "go_stock_none", "go_stock"},
        DefaultAttName = "Standard Stock",
        Bone = "v_weapon.bizon_parent",
        Offset = {
            vpos = Vector(0, -2.75, -1.35),
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
        Bone = "v_weapon.bizon_parent", -- relevant bone any attachments will be mostly referring to
        Offset = {
            vpos = Vector(0.6, -2.75, 6), -- offset that the attachment will be relative to the bone
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
        Source = "shoot_iron",
        Time = 0.5,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.4,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        Checkpoints = {16, 30, 55},
        FrameRate = 30,
        LHIK = true,
        LHIKIn = 0.7,
        LHIKOut = 0.4,
    },
    ["enter_inspect"] = false,
    ["idle_inspect"] = false,
    ["exit_inspect"] = false,
}

sound.Add({
    name = "ARCCW_GO_BIZON.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/bizon/bizon_draw.wav"
})

sound.Add({
    name = "ARCCW_GO_BIZON.Clipout",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/bizon/bizon_clipout.wav"
})

sound.Add({
    name = "ARCCW_GO_BIZON.Clipin",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/bizon/bizon_clipin.wav"
})

sound.Add({
    name = "ARCCW_GO_BIZON.Boltforward",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/bizon/bizon_boltforward.wav"
})

sound.Add({
    name = "ARCCW_GO_BIZON.Boltback",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/bizon/bizon_boltback.wav"
})