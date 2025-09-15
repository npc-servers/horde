if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_mw2_f2000")
    killicon.Add("arccw_horde_f2000", "arccw/weaponicons/arccw_mw2_f2000", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_mw2_f2000"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "F2000"

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2/c_f2000_2a.mdl"
SWEP.WorldModel = "models/weapons/w_rif_famas.mdl"

SWEP.Damage = 67
SWEP.DamageMin = 57
SWEP.DamageType = DMG_BURN

SWEP.Recoil = 0.42
SWEP.RecoilSide = 0.35

SWEP.Firemodes = {
    {
        Mode = 3,
        PrintName = "Incendiary"
    },
    {
        Mode = 2,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}

SWEP.ShootSound = "ArcCW_Horde.MW2.F2000_Fire"
SWEP.ShootMechSound = "ArcCW_Horde.MW2.F2000_Mech"
SWEP.ShootSoundSilenced = "ArcCW_Horde.MW2.F2000_Fire_Sil"

SWEP.RejectAttachments = {["mw2_ubgl_masterkey"] = true, ["mw2_ubgl_m203"] = true}

SWEP.Attachments = {
    {
        Offset = {
            vpos = Vector(5.8, -0.025, 3.2),
            vang = Angle(0, 0, 0),
        },
    },
    {
        Offset = {
            vpos = Vector(15, 0, 1.55),
            vang = Angle(0, 0, 0),
        },
    },{},
    {
        Offset = {
            vpos = Vector(5, -1.235, 1.25),
            vang = Angle(0, 0, 90),
        },
        SlideAmount = {
            vmin = Vector(6.5, -1.235, 1.25),
            vmax = Vector(4, -1.235, 1.25),
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
            vpos = Vector(-1.5, -0.85, 0.8),
            vang = Angle(0, 0, 0),
        },
    },
}

function SWEP:Hook_ShouldNotFire()
    if self:GetCurrentFiremode().Mode ~= 3 then
        self.DamageType = DMG_BULLET
    else
        self.DamageType = DMG_BURN
    end
end

sound.Add( {
    name = "ArcCW_Horde.MW2.F2000_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/f2000.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.MW2.F2000_Mech",
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
    name = "ArcCW_Horde.MW2.F2000_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/m4_sil.wav"
} )