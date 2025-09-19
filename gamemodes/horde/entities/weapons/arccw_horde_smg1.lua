if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("items/hl2/weapon_smg1.png")
    SWEP.WepSelectIconMat = Material("items/hl2/weapon_smg1.png")
    killicon.AddAlias("arccw_horde_smg1", "weapon_smg1")
end

SWEP.Base = "arccw_base"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false
SWEP.WeaponCamBone = tag_camera

SWEP.PrintName = "SMG-1"
SWEP.Trivia_Class = "Submachine Gun"
SWEP.Trivia_Desc = "A compact, fully automatic firearm."
SWEP.Trivia_Manufacturer = "Resistance"
SWEP.Trivia_Calibre = "9x19mm Parabellum"
SWEP.Trivia_Mechanism = "Roller-Delayed Blowback"
SWEP.Trivia_Country = "Earth"
SWEP.Trivia_Year = 2007

SWEP.Slot = 2

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ViewModelFOV = 65
SWEP.MirrorVMWM = true

SWEP.WorldModelOffset = {
    pos = Vector(-14, 8, -5),
    ang = Angle(-10, 0, 180)
}

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 25
SWEP.DamageMin = 10
SWEP.Range = 50
SWEP.Penetration = 4
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 45

SWEP.PhysBulletMuzzleVelocity = 400

SWEP.Recoil = 0.15
SWEP.RecoilSide = 0.1
SWEP.RecoilPunch = 0

SWEP.Delay = 0.08
SWEP.Num = 1
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

SWEP.AccuracyMOA = 10
SWEP.HipDispersion = 300
SWEP.MoveDispersion = 250

SWEP.Primary.Ammo = "Pistol"

SWEP.ShootSound = "ArcCW_Horde.SMG1_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.SMG1_Fire_Sil"

SWEP.MuzzleEffect = "muzzleflash_smg"
SWEP.ShellModel = "models/weapons/rifleshell.mdl"
SWEP.ShellPitch = 100
SWEP.ShellScale = 0.5
SWEP.ShellRotateAngle = Angle(0, 180, 0)

SWEP.MuzzleEffectAttachment = 1
SWEP.CaseEffectAttachment = 2

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.275

SWEP.IronSightStruct = {
    Pos = Vector(-1, 0, 0.5),
    Ang = Angle(0, 0, 0),
    Magnification = 1.25,
    SwitchToSound = "", -- sound that plays when switching to this sight
    ViewModelFOV = 40,
    CrosshairInSights = true
}

SWEP.HoldtypeHolstered = "passive"
SWEP.HoldtypeActive = "smg"
SWEP.HoldtypeSights = "rpg"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_SMG1

SWEP.ActivePos = Vector(0, -2, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.HolsterPos = Vector(3, -3, -1)
SWEP.HolsterAng = Angle(-7, 30, -10)

SWEP.CustomizePos = Vector(8, -3, 1)
SWEP.CustomizeAng = Angle(5, 30, 30)

SWEP.BarrelLength = 24

SWEP.ExtraSightDist = 10
SWEP.GuaranteeLaser = true

SWEP.Attachments = {
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "ValveBiped.base",
        Offset = {
            vpos = Vector(0.425, 0.345, 6.935),
            vang = Angle(90, 0, 0),
        },
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "ValveBiped.base",
        Offset = {
            vpos = Vector(0.05, -0.78, 13.5),
            vang = Angle(90, 0, -90),
        },
        VMScale = Vector(0.8, 0.8, 0.8),
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
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle01",
    },
    ["fire"] = {
        Source = "fire01",
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire01",
        ShellEjectAt = 0,
    },
    ["draw"] = {
        Source = "draw",
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_SMG1,
        SoundTable = {
            {s = "weapons/smg1/smg1_reload.wav", t = 0},
        },
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
}

function SWEP:DrawWeaponSelection(x, y, w, h, a)
    surface.SetDrawColor(255, 255, 255, a)
    surface.SetMaterial(self.WepSelectIconMat)

    surface.DrawTexturedRect(x, y, w, w / 2)
end

sound.Add( {
    name = "ArcCW_Horde.SMG1_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {95, 105},
    sound = ")weapons/smg1/smg1_fire1.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.SMG1_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")weapons/tmp/tmp-1.wav"
} )