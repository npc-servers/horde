if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_mw2_tavor")
    killicon.Add("arccw_horde_tavor", "arccw/weaponicons/arccw_mw2_tavor", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_mw2_tavor"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "TAR-21"

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2_2/c_tavor_1.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"

SWEP.Damage = 69
SWEP.DamageMin = 59
SWEP.DamageType = DMG_SHOCK

SWEP.Firemodes = {
    {
        Mode = 3,
        PrintName = "Shock"
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

SWEP.ShootSound = "ArcCW_Horde.MW2.Tavor_Fire"
SWEP.ShootMechSound = "ArcCW_Horde.MW2.Tavor_Mech"
SWEP.ShootSoundSilenced = "ArcCW_Horde.MW2.Tavor_Fire_Sil"

SWEP.RejectAttachments = {["mw2_ubgl_masterkey"] = true, ["mw2_ubgl_m203"] = true}

SWEP.Attachments = {
    {},
    {
        Offset = {
            vpos = Vector(9.5, 0, 0.8),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1, 1, 1),
    },{},
    {
        Offset = {
            vpos = Vector(3.5, 0.6, 0.8),
            vang = Angle(0, 0, -90),
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
            vpos = Vector(-5, -0.45, 1.2),
            vang = Angle(0, 0, 0),
        },
    },
}

function SWEP:Hook_ShouldNotFire()
    if self:GetCurrentFiremode().Mode ~= 3 then
        self.DamageType = DMG_BULLET
    else
        self.DamageType = DMG_SHOCK
    end
end

if SERVER then
    SWEP.Hook_BulletHit = function(wep, data)
        local att = data.att

        local tr = data.tr
        local entHit = tr.Entity

        local bulletDmg = data.damage

        if wep:GetCurrentFiremode().Mode == 3 then
            if HORDE:IsEnemy(entHit) then
                entHit:Horde_AddDebuffBuildup(HORDE.Status_Shock, bulletDmg * 0.5, att)
            end
        end
    end
end
sound.Add( {
    name = "ArcCW_Horde.MW2.Tavor_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/tar21.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.MW2.Tavor_Mech",
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
    name = "ArcCW_Horde.MW2.Tavor_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/m4_sil.wav"
} )