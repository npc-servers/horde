if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("vgui/hud/arccw_horde_scarl")
    SWEP.DrawWeaponInfoBox	= false
    SWEP.BounceWeaponIcon = false
    killicon.Add("arccw_horde_scarl", "vgui/hud/arccw_horde_scarl", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_mw2_scarl"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "SCAR-LOS"

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2/c_slog_scarlol.mdl"
SWEP.WorldModel = "models/weapons/w_rif_galil.mdl"

SWEP.Damage = 73
SWEP.DamageMin = 62
SWEP.DamageType = DMG_REMOVENORAGDOLL

SWEP.Firemodes = {
    {
        Mode = 3,
        PrintName = "Frostbite"
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


SWEP.ShootSound = "ArcCW_Horde.MW2.SCARLOS_Fire"
SWEP.ShootMechSound = "ArcCW_Horde.MW2.SCARLOS_Mech"
SWEP.ShootSoundSilenced = "ArcCW_Horde.MW2.SCARLOS_Fire_Sil"

SWEP.Attachments = {
    {
        Offset = {
            vpos = Vector(6.972, 0, 2.9),
            vang = Angle(0, 0, 0),
        },
        SlideAmount = {
            vmin = Vector(2, 0, 2.9),
            vmax = Vector(6, 0, 2.9),
        },
    },{},
    {
        Offset = {
            vpos = Vector(18.427, 0, -1.04),
            vang = Angle(0, 0, 0),
        },
        SlideAmount = {
            vmin = Vector(8, 0, 0.4),
            vmax = Vector(11, 0, 0.4),
        },
    },
    {
        Offset = {
            vpos = Vector(11.5, 0.75, 1.45),
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
            vpos = Vector(4, -0.6, 0.75),
            vang = Angle(0, 0, 0),
        },
    },
}

function SWEP:Hook_ShouldNotFire()
    if self:GetCurrentFiremode().Mode ~= 3 then
        self.DamageType = DMG_BULLET
    else
        self.DamageType = DMG_REMOVENORAGDOLL
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
                entHit:Horde_AddDebuffBuildup(HORDE.Status_Frostbite, bulletDmg * 0.5, att)
            end
        end
    end
end

sound.Add( {
    name = "ArcCW_Horde.MW2.SCARLOS_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/scarl.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.MW2.SCARLOS_Mech",
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
    name = "ArcCW_Horde.MW2.SCARLOS_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/scarl_sil.wav"
} )