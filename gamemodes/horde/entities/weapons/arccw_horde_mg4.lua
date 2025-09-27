if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_mw2_mg4")
    killicon.Add("arccw_horde_mg4", "arccw/weaponicons/arccw_mw2_mg4", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_mw2_mg4"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "MG4"

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2_2/c_mg4_1.mdl"
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"

SWEP.Damage = 40
SWEP.DamageMin = 32

SWEP.Primary.ClipSize = 200

SWEP.Recoil = 0.3
SWEP.RecoilSide = 0.35

SWEP.Delay = 60 / 900

SWEP.ShootSound = "ArcCW_Horde.MW2.MG4_Fire"
SWEP.ShootMechSound = "ArcCW_Horde.MW2.MG4_Mech"
SWEP.ShootSoundSilenced = "ArcCW_Horde.MW2.MG4_Fire_Sil"

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

SWEP.Attachments = {
    {},
    {
        Offset = {
            vpos = Vector(27, 0, 3.25),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1.25, 1.25, 1.25),
    },{},
    {
        Offset = {
            vpos = Vector(16, -1, 2.9),
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
            vpos = Vector(2.5, -0.7, 1.9),
            vang = Angle(0, 0, 0),
        },
    },
}

sound.Add( {
    name = "ArcCW_Horde.MW2.MG4_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/mg4.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.MW2.MG4_Mech",
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
    name = "ArcCW_Horde.MW2.MG4_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/m240_sil.wav"
} )