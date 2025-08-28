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

SWEP.ShootSound = "ArcCW_Horde.ScarLOS_Fire"
SWEP.ShootMechSound = "ArcCW_Horde.ScarLOS_Fire_Mech"
SWEP.ShootDrySound = "weapons/arccw/dryfire.wav"
SWEP.ShootSoundSilenced = "ArcCW_Horde.ScarLOS_Fire_Sil"

SWEP.AttachmentElements = {
    ["grip"] = {
        VMBodygroups = {{ind = 1, bg = 1}},
    },
    ["nors"] = {
        VMBodygroups = {{ind = 2, bg = 1}},
    },
    ["nomuzzle"] = {
        VMBodygroups = {{ind = 4, bg = 1}},
    },
    ["horde_ubgl_cryo"] = {
        VMBodygroups = {{ind = 3, bg = 1}},
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
}

SWEP.Attachments = {
    {
        PrintName = "Optic",
        DefaultAttName = "Iron Sights",
        Slot = "optic",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(6.972, 0, 2.9),
            vang = Angle(0, 0, 0),
        },
        SlideAmount = {
            vmin = Vector(2, 0, 2.9),
            vmax = Vector(6, 0, 2.9),
        },
        InstalledEles = {"nors"},
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(15, 0, 1.25),
            vang = Angle(0, 0, 0),
        },
        InstalledEles = {"nomuzzle"},
    },
    {
        PrintName = "Underbarrel",
        Slot = {"foregrip", "horde_ubgl_cryo", "bipod"},
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(18.427, 0, -1.04),
            vang = Angle(0, 0, 0),
        },
        SlideAmount = {
            vmin = Vector(8, 0, 0.4),
            vmax = Vector(11, 0, 0.4),
        },
        Installed = "horde_ubgl_cryo",
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "tag_weapon",
        Offset = {
            vpos = Vector(11.5, 0.75, 1.45),
            vang = Angle(0, 0, -90),
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
            vpos = Vector(4, -0.6, 0.75),
            vang = Angle(0, 0, 0),
        },
    },
}

SWEP.Hook_TranslateAnimation = function(wep, anim)
    local attached = wep.Attachments[3].Installed
    local attthing
        if attached == "horde_ubgl_cryo" then attthing = 1
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
    end
end

sound.Add({
    name = "ArcCW_Horde.ScarLOS_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {95, 110},
    sound = ")weapons/fesiugmw2/fire/scar.wav"
})

sound.Add({
    name = "ArcCW_Horde.ScarLOS_Fire_Mech",
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
    name = "ArcCW_Horde.ScarLOS_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = {95, 110},
    sound = ")weapons/fesiugmw2/fire/scarl_sil.wav"
})