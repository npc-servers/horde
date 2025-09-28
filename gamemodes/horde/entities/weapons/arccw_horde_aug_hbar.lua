if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_aug")
    killicon.Add("arccw_horde_aug_hbar", "arccw/weaponicons/arccw_go_aug", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_mw2_steyr_lmg"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "AUG HBAR"

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2/c_steyr.mdl"
SWEP.WorldModel = "models/weapons/w_rif_aug.mdl"

SWEP.Damage = 42
SWEP.DamageMin = 30

SWEP.Primary.ClipSize = 50

SWEP.Recoil = 0.2

SWEP.ShootSound = "ArcCW_Horde.MW2.HBAR_Fire"
SWEP.ShootMechSound = "ArcCW_Horde.MW2.HBAR_Mech"
SWEP.ShootSoundSilenced = "ArcCW_Horde.MW2.HBAR_Fire_Sil"

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

SWEP.Attachments = {
    {},{},{},{},
    {
        Offset = {
            vpos = Vector(3, 0.6, 1.5),
            vang = Angle(0, 0, -130),
        },
    },{},
    {
        Slot = "go_ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },{},
    {
        Offset = {
            vpos = Vector(-3, -0.8, 0.8),
            vang = Angle(0, 0, 0),
        },
    },
}

sound.Add( {
    name = "ArcCW_Horde.MW2.HBAR_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/aug.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.MW2.HBAR_Mech",
    channel = CHAN_AUTO,
    volume = 1.0,
    level = 45,
    pitch = {90, 105},
    sound = {
        ")weapons/fesiugmw2/mechanism/weap_mech_layer_c1.wav",
        ")weapons/fesiugmw2/mechanism/weap_mech_layer_c2.wav",
        ")weapons/fesiugmw2/mechanism/weap_mech_layer_c3.wav",
        ")weapons/fesiugmw2/mechanism/weap_mech_layer_c4.wav",
        ")weapons/fesiugmw2/mechanism/weap_mech_layer_c5.wav",
        ")weapons/fesiugmw2/mechanism/weap_mech_layer_c6.wav",
        ")weapons/fesiugmw2/mechanism/weap_mech_layer_c7.wav",
        ")weapons/fesiugmw2/mechanism/weap_mech_layer_c8.wav"
    }
} )
sound.Add( {
    name = "ArcCW_Horde.MW2.HBAR_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/m240_sil.wav"
} )