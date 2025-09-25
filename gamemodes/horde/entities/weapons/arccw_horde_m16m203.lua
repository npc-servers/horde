if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_mw2_m4")
    killicon.Add("arccw_horde_m16m203", "arccw/weaponicons/arccw_mw2_m4", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_mw2_m16"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "M16A4"

SWEP.ViewModel = "models/weapons/arccw/fesiugmw2_2/c_m16.mdl"
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"

SWEP.Damage = 47
SWEP.DamageMin = 39

SWEP.Firemodes = {
    {
        Mode = 2,
        RunawayBurst = false, -- Override the base M16 settings.
    },
    {
        Mode = 1,
    },
    {
        Mode = 0
    }
}


SWEP.ShootSound = "ArcCW_Horde.MW2.M16_Fire"
SWEP.ShootMechSound = "ArcCW_Horde.MW2.M16_Mech"
SWEP.ShootSoundSilenced = "ArcCW_Horde.MW2.M16_Fire_Sil"

SWEP.AttachmentElements = {
    ["horde_ubgl_cryo"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
    ["horde_ubgl_incendiary"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
    ["horde_ubgl_m203"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
    ["horde_ubgl_shock"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
}

SWEP.RejectAttachments = {["mw2_ubgl_masterkey"] = true, ["mw2_ubgl_m203"] = true}

SWEP.Attachments = {
    {},{},
    {
        Slot = {"foregrip", "horde_ubgl_cryo", "horde_ubgl_incendiary", "horde_ubgl_m203", "horde_ubgl_shock"},
    },
    {
        Offset = {
            vpos = Vector(12.5, -1.15, 1.95),
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
        PrintName = "Charm",
        Slot = "charm",
        FreeSlot = true,
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(4, -0.4, 1.25),
            vang = Angle(0, 0, 0),
            wpos = Vector(9.625, 1.5, -4),
            wang = Angle(0, 0, 180)
        },
    },
}

SWEP.Hook_TranslateAnimation = function(wep, anim)
    local attached = wep.Attachments[3].Installed
    local attthing
        if attached == "horde_ubgl_cryo" or attached == "horde_ubgl_incendiary" or attached == "horde_ubgl_m203" or attached == "horde_ubgl_shock" then attthing = 1
        else attthing = 0
    end
    if anim == "enter_ubgl" then
        if attthing == 1 then
            return "switch2_alt_m203"
        end
    elseif anim == "exit_ubgl" then
        if attthing == 1 then
            return "switch2_gun_m203"
        end
    end
    if attthing == 1 and wep:GetInUBGL() then
    return "alt_" .. anim .. "_m203"
    elseif attthing == 1 then
        return anim .. "_m203"
    end
end

sound.Add( {
    name = "ArcCW_Horde.MW2.M16_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {80, 95},
    sound = ")weapons/fesiugmw2/fire/m4.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.MW2.M16_Mech",
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
    name = "ArcCW_Horde.MW2.M16_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {90, 105},
    sound = ")weapons/fesiugmw2/fire/m4_sil.wav"
} )
