if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("items/hl2/weapon_shotgun.png")
    SWEP.WepSelectIconMat = Material("items/hl2/weapon_shotgun.png")
    killicon.AddAlias("arccw_horde_shotgun", "weapon_shotgun")
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "Arccw - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "Shotgun"
SWEP.Trivia_Class = "Shotgun"
SWEP.Trivia_Desc = "A standard 12-gauge shotgun."
SWEP.Trivia_Manufacturer = "Resistance"
SWEP.Trivia_Calibre = "12 Gauge"
SWEP.Trivia_Mechanism = "Pump-Action"
SWEP.Trivia_Country = "Resistance"
SWEP.Trivia_Year = 2007

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_shotgun.mdl"
SWEP.WorldModel = "models/weapons/w_shotgun.mdl"
SWEP.ViewModelFOV = 60
SWEP.WorldModelOffset = {
    pos = Vector(-20, 10, -10),
    ang = Angle(0, 0, 180),
    scale = 1
}

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 15
SWEP.DamageMin = 5 -- damage done at maximum range
SWEP.Num = 7
SWEP.Range = 500 * 0.025 -- in METRES
SWEP.Penetration = 1
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any
SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 6 -- DefaultClip is automatically set.

SWEP.Recoil = 1
SWEP.RecoilSide = 0.1
SWEP.RecoilPunch = 2

SWEP.NoLastCycle = true
SWEP.ManualAction = true
SWEP.ShotgunReload = true
SWEP.Delay = 1 -- 60 / RPM.
SWEP.Firemodes = {
    {
        Mode = 2,
        PrintName = "Slam-Fire"
    },
    {
        Mode = 0,
    }
}

SWEP.AccuracyMOA = 50 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 100 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 50

SWEP.Primary.Ammo = "buckshot" -- what ammo type the gun uses

SWEP.ShootSound = ")weapons/shotgun/shotgun_fire7.wav"
SWEP.ShootSoundSilenced = ")weapons/fesiugmw2/fire/shot_sil.wav"
SWEP.DistantShootSound = {")arccw_go/mag7/mag7_distant_01.wav",")arccw_go/mag7/mag7_distant_02.wav"}

SWEP.MuzzleEffect = "muzzleflash_shotgun"
SWEP.ShellModel = "models/shells/shell_12gauge.mdl"
SWEP.ShellPitch = 100
SWEP.ShellSounds = ArcCW.ShotgunShellSoundsTable
SWEP.ShellScale = 1.5
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.75

SWEP.IronSightStruct = {
    Pos = Vector(-1, -1, 2),
    Ang = Angle(0, 0, 0),
    Magnification = 1.5,
    SwitchToSound = "", -- sound that plays when switching to this sight
    CrosshairInSights = true
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "shotgun"
SWEP.HoldtypeSights = "ar2"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SHOTGUN

SWEP.ActivePos = Vector(0, 0, -1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.BarrelLength = 0

SWEP.MirrorVMWM = true

SWEP.Attachments = {
    {
        PrintName = "Ammo Type",
        DefaultAttName = "Buckshot Shells",
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
        Bone = "ValveBiped.Gun",
        Offset = {
            vpos = Vector(1.15, 0.65, -9.965),
            vang = Angle(90, 0, -90),
        },
        VMScale = Vector(0.8, 0.8, 0.8)
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "ValveBiped.Gun",
        Offset = {
            vpos = Vector(0.95, -0.8, 8.3),
            vang = Angle(90, 0, 0),
        },
        VMScale = Vector(1, 1, 1)
    },
    {
        PrintName = "Underbarrel",
        Slot = "foregrip",
        Bone = "ValveBiped.Pump",
        Offset = {
            vpos = Vector(0.05, 2.35, 2.5),
            vang = Angle(90, 0, -90),
        }
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle_shotgun",
        Bone = "ValveBiped.Gun",
        Offset = {
            vpos = Vector(0.05, -0.57, 20.7),
            vang = Angle(90, 0, 0),
        },
        VMScale = Vector(1.5, 1.5, 1.5)
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle01",
    },
    ["draw"] = {
        Source = "draw",
    },
    ["fire"] = {
        Source = "fire01",
    },
    ["cycle"] = {
        Source = "pump",
        ShellEjectAt = 0.25,
        SoundTable = {
            {s = "Weapon_Shotgun.Special1", t = 0},
        },
    },
    ["sgreload_start"] = {
        Source = "reload1",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        LHIK = true,
        LHIKIn = 0.2,
        LHIKOut = 0,
    },
    ["sgreload_insert"] = {
        Source = "reload2",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SHOTGUN,
        TPAnimStartTime = 0.3,
        SoundTable = {
            {s = {"Weapon_Shotgun.Reload"}, t = 0},
        },
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0,
    },
    ["sgreload_finish"] = {
        Source = "reload3",
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.2,
    },
    ["sgreload_finish_empty"] = {
        Source = "pump",
        ShellEjectAt = 0.25,
        SoundTable = {
            {s = "Weapon_Shotgun.Special1", t = 0},
        },
    },
}

function SWEP:DrawWeaponSelection(x, y, w, h, a)
    surface.SetDrawColor(255, 255, 255, a)
    surface.SetMaterial(self.WepSelectIconMat)

    surface.DrawTexturedRect(x, y, w, w / 2)
end
