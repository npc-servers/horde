if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("items/hl2/weapon_357.png")
    SWEP.WepSelectIconMat = Material("items/hl2/weapon_357.png")
    killicon.AddAlias("arccw_horde_357", "weapon_357")
end
SWEP.Base = "arccw_base"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false
SWEP.WeaponCamBone = tag_camera

SWEP.PrintName = "Flare Revolver"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Colt Navy Revolver modified to fire flares. A perfect starter for a fledgling firebug."

SWEP.Trivia_Manufacturer = "Colt"
SWEP.Trivia_Calibre = ".410 Flare Shotshells"
SWEP.Trivia_Mechanism = "Double-Action"
SWEP.Trivia_Country = "United States of America"
SWEP.Trivia_Year = 1851

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/horde/weapons/kf/c_flaregun.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.ViewModelFOV = 70

SWEP.WorldModelOffset = {
    scale = 1.1,
    pos        =    Vector(-14, 2, 2.2),
    ang        =    Angle(-91, 0, 180),
    bone       =    "ValveBiped.Bip01_R_Hand",
}

SWEP.Damage = 0
SWEP.DamageMin = 0
SWEP.RangeMin = 500 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Range = 1250 * 0.025  -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 4
SWEP.DamageType = DMG_BURN
SWEP.ShootEntity = "projectile_horde_flaregun_flare" -- entity to fire, if any
SWEP.MuzzleVelocity = 3000

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 6 -- DefaultClip is automatically set.
SWEP.ExtendedClipSize = 6
SWEP.ReducedClipSize = 6

SWEP.Recoil = 1
SWEP.RecoilSide = 0.75
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 1

SWEP.Delay = 120 / 450 -- 30 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0,
    }
}

SWEP.NPCWeaponType = "weapon_357"
SWEP.NPCWeight = 150

SWEP.AccuracyMOA = 5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 120 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 100

SWEP.Primary.Ammo = "357" -- what ammo type the gun uses

SWEP.ShootVol = 75

SWEP.ShootSound = ")weapons/flaregun/fire.wav"
SWEP.DistantShootSound = "^horde/weapons/distant/generic_distant.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol_cleric"

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 0.05

SWEP.IronSightStruct = {
    Pos = Vector(0, 0, 0),
    Ang = Angle(0, 0, 0),
    ViewModelFOV = 65,
    Magnification = 1,
    CrosshairInSights = true
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(3, 3, -1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(13.92, -3, -1.08)
SWEP.CustomizeAng = Angle(6.8, 37.7, 10.3)

SWEP.HolsterPos = Vector(5, 2, 0)
SWEP.HolsterAng = Angle(-10, 25, 0)

SWEP.BarrelOffsetSighted = Vector(5, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 18

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Perk",
        Slot = {"go_perk", "go_perk_pistol"}
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["draw"] = {
        Source = "draw",
    },
    ["holster"] = {
        Source = "holster",
    },
    ["fire"] = {
        Source = "fire",
        Time = 3,
    },
    ["fire_iron"] = {
        Source = "fire_ads",
        Time = 3,
    },
    ["reload"] = {
        Source = "reload",
        Time = 2,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
        SoundTable = {
			{s = "weapons/357/357_reload1.wav", t = 0.2},
            {s = "weapons/357/357_reload3.wav", t = 1},
		}
    },
}

function SWEP:DrawWeaponSelection(x, y, w, h, a)
    surface.SetDrawColor(255, 255, 255, a)
    surface.SetMaterial(self.WepSelectIconMat)

    surface.DrawTexturedRect(x, y, w, w / 2)
end
