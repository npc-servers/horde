if not ArcCWInstalled then return end

SWEP.Base = "arccw_mw2_l86"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "L86 LSW"

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2/c_sa80_lmg_5.mdl"
SWEP.WorldModel = "models/weapons/w_rif_aug.mdl"

SWEP.Damage = 38
SWEP.DamageMin = 35

SWEP.Primary.ClipSize = 100

SWEP.Recoil = 0.3
SWEP.RecoilSide = 0.2

SWEP.ShootSound = "ArcCW_Horde.MW2.L86_Fire"
SWEP.ShootMechSound = "ArcCW_Horde.MW2.L86_Mech"
SWEP.ShootSoundSilenced = "ArcCW_Horde.MW2.L86_Fire_Sil"

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

SWEP.Attachments = {
    {},
    {
        Offset = {
            vpos = Vector(21.5, 0, 1),
            vang = Angle(0, 0, 0),
        },
    },
    {},
    {
        Offset = {
            vpos = Vector(-2, -0.9, 0.65),
            vang = Angle(0, 0, 90),
        },
    },
    {},
    {
        Slot = "go_ammo"
    },
    {
        Slot = "go_perk"
    },{},
    {
        Offset = {
            vpos = Vector(-5.2, -0.5, 1.4),
            vang = Angle(0, 0, 0),
        },
    },
}

sound.Add( {
    name = "ArcCW_Horde.MW2.L86_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/l86.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.MW2.L86_Mech",
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
    name = "ArcCW_Horde.MW2.L86_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/m240_sil.wav"
} )