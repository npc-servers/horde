if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_aug")
    killicon.Add("arccw_horde_aug", "arccw/weaponicons/arccw_go_aug", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_aug"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "AUG A3"

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_aug.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_aug.mdl"

SWEP.Damage = 62
SWEP.DamageMin = 46

SWEP.Primary.ClipSize = 42

SWEP.Recoil = 0.4
SWEP.RecoilSide = 0.3
SWEP.RecoilPunch = 0

SWEP.FirstShootSound = "ArcCW_Horde.GSO.AUG_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.AUG_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.AUG_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.Attachments = {
    {},{},{},{},{},
    {
        DefaultAttName = "42-Round 5.56mm Poly"
    },
}

sound.Add( {
    name = "ArcCW_Horde.GSO.AUG_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/aug/aug_01.wav",")arccw_go/aug/aug_02.wav",")arccw_go/aug/aug_03.wav",")arccw_go/aug/aug_04.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.AUG_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/m4a1/m4a1_silencer_01.wav"
} )