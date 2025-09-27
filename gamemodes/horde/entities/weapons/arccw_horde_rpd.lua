if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_horde_rpd")
    killicon.Add("arccw_horde_rpd", "arccw/weaponicons/arccw_horde_rpd", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_mw2_rpd"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "RPD"

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2_2/c_rpd_1.mdl"
SWEP.WorldModel = "models/weapons/arccw/fesiugmw2_2/c_rpd_1.mdl"

SWEP.Damage = 45
SWEP.DamageMin = 33

SWEP.Primary.ClipSize = 150

SWEP.Recoil = 0.4
SWEP.RecoilSide = 0.2

SWEP.Delay = 60 / 700

SWEP.ShootSound = "ArcCW_Horde.MW2.RPD_Fire"
SWEP.ShootMechSound = "ArcCW_Horde.MW2.RPD_Mech"
SWEP.ShootSoundSilenced = "ArcCW_Horde.MW2.RPD_Fire_Sil"

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

SWEP.Attachments = {
    {},
    {
        Offset = {
            vpos = Vector(26, 0, 1.15),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1, 1, 1),
    },{},
    {
        Offset = {
            vpos = Vector(16.7, -0.3, 0.8),
            vang = Angle(0, 0, 90),
        },
    },{},
    {
        Slot = "go_ammo"
    },
    {
        Slot = "go_perk"
    },{},
    {
        Offset = {
            vpos = Vector(3.6, -0.4, 0.8),
            vang = Angle(0, 0, 0),
        },
    },
}

sound.Add( {
    name = "ArcCW_Horde.MW2.RPD_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/rpd.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.MW2.RPD_Mech",
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
    name = "ArcCW_Horde.MW2.RPD_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/m240_sil.wav"
} )