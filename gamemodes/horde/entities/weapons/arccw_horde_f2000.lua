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

SWEP.Recoil = 0.42
SWEP.RecoilSide = 0.35

SWEP.ShootSound = "ArcCW_Horde.F2000_Fire"
SWEP.ShootMechSound = "ArcCW_Horde.F2000_Fire_Mech"
SWEP.ShootSoundSilenced = "ArcCW_Horde.F2000_Fire_Sil"

SWEP.AttachmentElements = {
    ["wepcamo-desert"]      = { VMSkin = 1 },
    ["wepcamo-arctic"]      = { VMSkin = 2 },
    ["wepcamo-woodland"]    = { VMSkin = 3 },
    ["wepcamo-digital"]     = { VMSkin = 4 },
    ["wepcamo-urban"]       = { VMSkin = 5 },
    ["wepcamo-bluetiger"]   = { VMSkin = 6 },
    ["wepcamo-redtiger"]    = { VMSkin = 7 },
    ["wepcamo-fall"]        = { VMSkin = 8 },
    ["wepcamo-whiteout"]    = { VMSkin = 9 },
    ["wepcamo-blackout"]        = { VMSkin = 10 },
    ["wepcamo-bushdweller"]     = { VMSkin = 11 },
    ["wepcamo-thunderstorm"]    = { VMSkin = 12 },
    ["nors"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
        WMBodygroups = {},
    },
    ["nocover"] = {
        VMBodygroups = {{ind = 2, bg = 3}},
        WMBodygroups = {},
    },
    ["horde_ubgl_incendiary"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
}

SWEP.RejectAttachments = {["mw2_ubgl_m203"] = true, ["mw2_ubgl_masterkey"] = true}

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = { "optic" },
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(5.8, -0.025, 3.2),
            vang = Angle(0, 0, 0),
        },
        InstalledEles = {"nors"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(16, 0, 1.55),
            vang = Angle(0, 0, 0),
        },
        VMScale = Vector(1.15, 1.15, 1.15),
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "horde_ubgl_incendiary"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(10, 0, -1.04),
            vang = Angle(0, 0, 0),
        },
        SlideAmount = {
            vmin = Vector(8, 0, 0),
            vmax = Vector(11, 0, 0.8),
        },
        InstalledEles = {"nocover"},
        Installed = "horde_ubgl_incendiary",
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(5, -1.235, 1.25),
            vang = Angle(0, 0, 90),
        },
        SlideAmount = {
            vmin = Vector(6.5, -1.235, 1.25),
            vmax = Vector(4, -1.235, 1.25),
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
            vpos = Vector(-1.5, -0.85, 0.8),
            vang = Angle(0, 0, 0),
        },
    },
}

SWEP.Hook_TranslateAnimation = function(wep, anim)
    local attached = wep.Attachments[3].Installed
    local attthing
        if attached == "horde_ubgl_incendiary" then attthing = 1
        elseif attached then attthing = 3
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
    elseif attthing == 3 then
        return anim .. "_fgrip"
    end
end

sound.Add({
    name = "ArcCW_Horde.F2000_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {95, 110},
    sound = ")weapons/fesiugmw2/fire/f2000.wav"
})

sound.Add({
    name = "ArcCW_Horde.F2000_Fire_Mech",
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
    name = "ArcCW_Horde.F2000_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {95, 110},
    sound = ")weapons/fesiugmw2/fire/m4_sil.wav"
})