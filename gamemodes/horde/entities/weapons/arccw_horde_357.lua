if not ArcCWInstalled then return end

if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("items/hl2/weapon_357.png")
    SWEP.WepSelectIconMat = Material("items/hl2/weapon_357.png")
    killicon.AddAlias("arccw_horde_357", "weapon_357")
end

SWEP.Base = "arccw_base"
SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"

SWEP.PrintName = "Magnum"
SWEP.Trivia_Class = "Revolver"
SWEP.Trivia_Desc = "Standard revolver."

SWEP.Trivia_Manufacturer = "Colt"
SWEP.Trivia_Calibre = ".357 Magnum"
SWEP.Trivia_Mechanism = "Double-Action"
SWEP.Trivia_Country = "United States"
SWEP.Trivia_Year = 1955

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_357.mdl"
SWEP.MirrorVMWM = false
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.ViewModelFOV = 65

SWEP.Damage = 75
SWEP.DamageMin = 50
SWEP.Range = 100  -- GAME UNITS * 0.025 = METRES
SWEP.Penetration = 4
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil -- entity to fire, if any


SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 6 -- DefaultClip is automatically set.

SWEP.Recoil = 3
SWEP.RecoilSide = 1
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 150 -- 30 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
    },
    {
        Mode = 0,
    }
}

SWEP.AccuracyMOA = 5 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 150 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "357" -- what ammo type the gun uses

SWEP.ShootVol = 80 -- volume of shoot sound
SWEP.ShootPitch = 95 -- pitch of shoot sound

SWEP.ShootSound =   { ")weapons/357/357_fire2.wav", ")weapons/357/357_fire3.wav" }
SWEP.DistantShootSound = "^horde/weapons/distshot.wav"

SWEP.MuzzleEffect = "muzzleflash_pistol_deagle"

SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 2 -- which attachment to put the case effect on

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 0.05

SWEP.IronSightStruct = {
    Pos = Vector( 0, 0, 0 ),
    Ang = Angle( 0, 0, 0 ),
    ViewModelFOV = 40,
    Magnification = 1.25,
    CrosshairInSights = true
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(0, -5, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(13.92, -5, -1.08)
SWEP.CustomizeAng = Angle(6.8, 37.7, 10.3)

SWEP.HolsterPos = Vector(3, -3, 0)
SWEP.HolsterAng = Angle(-10, 25, 0)

SWEP.BarrelLength = 18

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
        Time = 5,
    },
    ["draw"] = {
        Source = "draw"
    },
    ["holster"] = {
        Source = "putaway"
    },
    ["fire"] = {
        Source = "fire"
    },
    ["fire_iron"] = {
        Source = "fire"
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_REVOLVER,
        SoundTable = {
            { s = "weapons/357/357_reload1.wav", t = 0.4 },
            { s = "weapons/357/357_reload4.wav", t = 0.8 },
            { s = "weapons/357/357_reload3.wav", t = 1.9 },
            { s = "weapons/357/357_spin1.wav", t = 2.7 }
        },
    },
}

function SWEP:DrawWeaponSelection( x, y, w, h, a )
    surface.SetDrawColor( 255, 255, 255, a )
    surface.SetMaterial( self.WepSelectIconMat )

    surface.DrawTexturedRect( x, y, w, w / 2 )
end
