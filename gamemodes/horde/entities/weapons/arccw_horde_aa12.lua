if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_mw2_aa12")
    killicon.Add("arccw_horde_aa12", "arccw/weaponicons/arccw_mw2_aa12", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_mw2_aa12"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "AA-12"

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2_2/c_aa12_1.mdl"
SWEP.WorldModel = "models/weapons/w_shot_xm1014.mdl"

SWEP.Damage = 40
SWEP.DamageMin = 26
SWEP.Range = 40
SWEP.Penetration = 3

SWEP.Primary.ClipSize = 20

SWEP.AccuracyMOA = 100

SWEP.ShootSound = "ArcCW_Horde.MW2.AA12_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.MW2.AA12_Fire_Sil"

SWEP.GuaranteeLaser = true

SWEP.RejectAttachments = {["go_fore_bipod"] = true}

SWEP.Attachments = {
    {},
    {
        Offset = {
            vpos = Vector(22, 0, 1.7),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1.4, 1.4, 1.4),
    },
    {
        SlideAmount = {
            vmin = Vector(11, 0, 0.5),
            vmax = Vector(15, 0, 0.7),
        },
    },
    {
        Offset = {
            vpos = Vector(15, -0.85, 2.15),
            vang = Angle(0, 0, 90),
        },
    },
    {
        Slot = "go_ammo"
    },{},
    {
        Slot = "go_perk"
    },{},{},
}

sound.Add( {
    name = "ArcCW_Horde.MW2.AA12_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/shot_aa12.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.MW2.AA12_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")weapons/fesiugmw2/fire/shot_sil.wav"
} )
