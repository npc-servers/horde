if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/weapon_stunstick")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_hf_stick", "vgui/hud/weapon_stunstick", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_horde_base_melee"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false
SWEP.PrintName = "HF Stick"
SWEP.Trivia_Class = "Melee Weapon"
SWEP.Trivia_Desc = "Non-lethal High-Frequency Stick."
SWEP.Trivia_Manufacturer = "Unknown."
SWEP.Trivia_Calibre = "N/A"
SWEP.Trivia_Mechanism = "Blunt Weapon"
SWEP.Trivia_Country = "Japan"
SWEP.Trivia_Year = 2013

SWEP.Slot = 0

SWEP.NotForNPCs = true

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_stunstick.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"
SWEP.ViewModelFOV = 55

SWEP.DefaultSkin = 0
SWEP.DefaultWMSkin = 0

SWEP.MeleeDamage = 35
SWEP.Melee2Damage = 55

SWEP.PrimaryBash = true
SWEP.CanBash = true
SWEP.MeleeDamageType = DMG_CLUB
SWEP.MeleeRange = 32
SWEP.MeleeAttackTime = 0.2
SWEP.MeleeTime = 0.5
SWEP.MeleeGesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE

SWEP.Melee2 = true
SWEP.Melee2Range = 32
SWEP.Melee2AttackTime = 0.1
SWEP.Melee2Time = 1
SWEP.Melee2Gesture = ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2

SWEP.MeleeSwingSound = {
    "weapons/stunstick/stunstick_swing1.wav",
    "weapons/stunstick/stunstick_swing2.wav"
}
SWEP.MeleeMissSound = {
    "weapons/stunstick/stunstick_swing1.wav",
    "weapons/stunstick/stunstick_swing2.wav"
}
SWEP.MeleeHitSound = {
    "weapons/stunstick/stunstick_impact1.wav",
    "weapons/stunstick/stunstick_impact2.wav"
}
SWEP.MeleeHitNPCSound = {
    "weapons/stunstick/stunstick_fleshhit1.wav",
    "weapons/stunstick/stunstick_fleshhit2.wav"
}

SWEP.NotForNPCs = true

SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "MELEE"
    },
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "melee2"

SWEP.Primary.ClipSize = -1

SWEP.AttachmentElements = {
}

SWEP.Attachments = {
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle01",
    },
    ["draw"] = {
        Source = "draw",
        Time = 0.8,
    },
    ["bash"] = {
        Source = {"hitcenter1", "hitcenter2", "hitcenter3"},
        Time = 0.75,
    },
    ["bash2"] = {
        Source = {"misscenter2", "misscenter1"},
        Time = 0.75,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
}

SWEP.IronSightStruct = false

SWEP.ActivePos = Vector(-3, -10, 5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.BashPreparePos = Vector(0, 0, 0)
SWEP.BashPrepareAng = Angle(0, 20, 0)

SWEP.BashPos = Vector(0, 0, 0)
SWEP.BashAng = Angle(35, -30, 0)

SWEP.HolsterPos = Vector(0, -3, -2)
SWEP.HolsterAng = Angle(-10, 0, 0)