if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_mw2_m240")
    killicon.Add("arccw_horde_m240", "arccw/weaponicons/arccw_mw2_m240", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_mw2_m240"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "M240"

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2_2/c_m240_1.mdl"
SWEP.WorldModel = "models/weapons/arccw/fesiugmw2_2/c_m240_1.mdl"

SWEP.Damage = 50
SWEP.DamageMin = 36

SWEP.Recoil = 0.5
SWEP.RecoilSide = 0.35

SWEP.ShootSound = "ArcCW_Horde.MW2.M240_Fire"
SWEP.ShootMechSound = "ArcCW_Horde.MW2.M240_Mech"
SWEP.ShootSoundSilenced = "ArcCW_Horde.MW2.M240_Fire_Sil"

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

SWEP.Attachments = {
    {},
    {
        Offset = {
            vpos = Vector(31, 0, 2.0),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1, 1, 1),
    },{},
    {
        Offset = {
            vpos = Vector(20, -1.2, 1.1),
            vang = Angle(0, 0, 90),
        },
    },{},
    {
        Slot = "go_ammo"
    },
    {
        Slot = "go_perk"
    },{},{},
}

sound.Add( {
    name = "ArcCW_Horde.MW2.M240_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {60, 75},
    sound = ")weapons/fesiugmw2/fire/m240.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.MW2.M240_Mech",
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
    name = "ArcCW_Horde.MW2.M240_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/m240_sil.wav"
} )