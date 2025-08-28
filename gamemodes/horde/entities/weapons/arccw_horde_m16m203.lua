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
SWEP.DamageMin = 36

SWEP.ShootSound = "ArcCW_Horde.M16_Fire"
SWEP.ShootMechSound = "ArcCW_Horde.M16_Fire_Mech"
SWEP.ShootSoundSilenced = "ArcCW_Horde.M16_Fire_Sil"

SWEP.AttachmentElements = {
    ["nors"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {},
    },
    ["grip"] = {
        VMBodygroups = {{ind = 2, bg = 3}},
    },
    ["wepcamo-desert"] = { VMSkin = 1 },
    ["wepcamo-arctic"] = { VMSkin = 2 },
    ["wepcamo-woodland"] = { VMSkin = 3 },
    ["wepcamo-digital"] = { VMSkin = 4 },
    ["wepcamo-urban"] = { VMSkin = 5 },
    ["wepcamo-bluetiger"] = { VMSkin = 6 },
    ["wepcamo-redtiger"] = { VMSkin = 7 },
    ["wepcamo-fall"] = { VMSkin = 8 },
    ["wepcamo-whiteout"] = { VMSkin = 9 },
    ["wepcamo-blackout"] = { VMSkin = 10 },
    ["wepcamo-bushdweller"] = { VMSkin = 11 },
    ["wepcamo-thunderstorm"] = { VMSkin = 12 },
    ["horde_ubgl_m203"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
}

SWEP.RejectAttachments = {["mw2_ubgl_m203"] = true, ["mw2_ubgl_masterkey"] = true}

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = "optic",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(6.972, 0, 4.018),
            vang = Angle(0, 0, 0),
        },
        SlideAmount = {
            vmin = Vector(0.5, 0, 2.95),
            vmax = Vector(4, 0, 2.95),
        },
        InstalledEles = {"nors"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(22.5, 0, 2),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1.2, 1.2, 1.2),
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "horde_ubgl_m203"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(12.2, 0, 0.8),
            vang = Angle(0, 0, 0),
        },
        SlideAmount = {
            vmin = Vector(8, 0, 0.8),
            vmax = Vector(12.2, 0, 0.8),
        },
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(12.5, -1.2, 1.95),
            vang = Angle(0, 0, 90),
        },
    },
    {
        PrintName = "Fire Group",
        Slot = "fcg",
        DefaultAttName = "Standard FCG"
    },
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo"
    },
    {
        PrintName = "Perk",
        Slot = "go_perk"
    },
    {
        PrintName = "Camouflage",
        DefaultAttName = "None",
        Slot = "mw2_wepcamo",
        FreeSlot = true,
    },
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
        if attached == "horde_ubgl_m203" then attthing = 1
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

sound.Add({
    name = "ArcCW_Horde.M16_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {95, 110},
    sound = ")weapons/fesiugmw2/fire/m4.wav"
})

sound.Add({
    name = "ArcCW_Horde.M16_Fire_Mech",
    channel = CHAN_AUTO,
    volume = 1.0,
    level = 45,
    pitch = {95, 110},
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
})

sound.Add({
    name = "ArcCW_Horde.M16_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {95, 110},
    sound = ")weapons/fesiugmw2/fire/m4_sil.wav"
})