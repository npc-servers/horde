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

SWEP.ShootVol = 75

SWEP.ShootSound = ")weapons/fesiugmw2/fire/f2000.wav"
SWEP.ShootMechSound = {
    ")weapons/fesiugmw2/mechanism/weap_mech_layer_c1.wav",
    ")weapons/fesiugmw2/mechanism/weap_mech_layer_c2.wav",
    ")weapons/fesiugmw2/mechanism/weap_mech_layer_c3.wav",
    ")weapons/fesiugmw2/mechanism/weap_mech_layer_c4.wav",
    ")weapons/fesiugmw2/mechanism/weap_mech_layer_c5.wav",
    ")weapons/fesiugmw2/mechanism/weap_mech_layer_c6.wav",
    ")weapons/fesiugmw2/mechanism/weap_mech_layer_c7.wav",
    ")weapons/fesiugmw2/mechanism/weap_mech_layer_c8.wav"
}
SWEP.ShootSoundSilenced = ")weapons/fesiugmw2/fire/m4_sil.wav"

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
        Slot = {"foregrip", "horde_ubgl_incendiary", "", ""},
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

SWEP.Animations = {
    ["draw"] = {
        Source = "pullout",
        Time = 33/30,
        SoundTable = {{s = "weapons/fesiugmw2/wpnarm_2.wav", c = CHAN_ITEM, t = 0}},
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0,
    },
    ["ready"] = {
        Source = "pullout_first",
        Time = 35/30,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_fn2000_reload_first_lift_v1.wav", c = CHAN_ITEM, t = 0/30},
            {s = "weapons/fesiugmw2/foley/wpfoly_fn2000_reload_first_chamber_v1.wav", c = CHAN_ITEM, t = 13/30},
        },
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["reload"] = {
        Source = "reload",
        Time = 90/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_fn2000_reload_lift_v1.wav", c = CHAN_ITEM, t = 0},
            {s = "weapons/fesiugmw2/foley/wpfoly_fn2000_reload_clipout_v1.wav", c = CHAN_ITEM, t = 16/30},
            {s = "weapons/fesiugmw2/foley/wpfoly_fn2000_reload_clipin_v1.wav", c = CHAN_ITEM, t = 60/30},
        },
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        Time = 103/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_fn2000_reload_lift_v1.wav", c = CHAN_ITEM, t = 0},
            {s = "weapons/fesiugmw2/foley/wpfoly_fn2000_reload_clipout_v1.wav", c = CHAN_ITEM, t = 15/30},
            {s = "weapons/fesiugmw2/foley/wpfoly_fn2000_reload_clipin_v1.wav", c = CHAN_ITEM, t = 61/30},
            {s = "weapons/fesiugmw2/foley/wpfoly_fn2000_reload_chamber_v1.wav", c = CHAN_ITEM, t = 76/30},
        },
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.6,
    },
    ["alt_draw_m203"] = {
        Source = "alt_pullout_m203",
        Time = 33/30,
        SoundTable = {{s = "weapons/fesiugmw2/pu_weapon01.wav", c = CHAN_ITEM, t = 0}},
    },
    ["alt_reload_m203"] = {
        Source = "alt_reload_m203",
        Time = 79/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_m203_chamber_open_v12.wav", c = CHAN_ITEM, t = 12/30},
            {s = "weapons/fesiugmw2/foley/wpfoly_m203_load_v12.wav", c = CHAN_ITEM, t = 39/30},
            {s = "weapons/fesiugmw2/foley/wpfoly_m203_chamber_close_v12.wav", c = CHAN_ITEM, t = 60/30},
        },
    },
    ["switch2_gun_m203"] = {
        Source = "switch2_gun_m203",
        SoundTable = {{s = "weapons/fesiugmw2/pu_weapon01.wav", c = CHAN_ITEM, t = 0}},
        Time = 25/30
    },
    ["switch2_alt_m203"] = {
        Source = "switch2_alt_m203",
        SoundTable = {{s = "weapons/fesiugmw2/pu_weapon01.wav", c = CHAN_ITEM, t = 0}},
        Time = 25/30
    },
}
function SWEP:DoShootSound(sndoverride, dsndoverride, voloverride, pitchoverride)
    local fsound = self.ShootSound
    local msound = self.ShootMechSound
    local suppressed = self:GetBuff_Override("Silencer")

    fsound = self:GetBuff_Hook("Hook_GetShootSound", fsound)

    local spv    = self.ShootPitchVariation
    local volume = self.ShootVol
    local pitch  = self.ShootPitch * math.Rand(1 - spv, 1 + spv) * self:GetBuff_Mult("Mult_ShootPitch")

    local v = GetConVar("arccw_weakensounds"):GetFloat()
    volume = volume - v

    volume = volume * self:GetBuff_Mult("Mult_ShootVol")

    volume = math.Clamp(volume, 50, 140)
    pitch  = math.Clamp(pitch, 0, 255)

    if sndoverride then fsound = sndoverride end
    if voloverride then volume = voloverride end
    if pitchoverride then pitch = pitchoverride end

    if suppressed then
        fsound = self.ShootSoundSilenced
        pitch = 100
        msound = nil
    end

    if fsound then self:MyEmitSound(fsound, volume, pitch, 1, CHAN_WEAPON) end
    if msound then self:MyEmitSound(msound, 45, math.Rand(95, 105), .45, CHAN_AUTO) end

    local data = {
        sound   = fsound,
        volume  = volume,
        pitch   = pitch,
    }

    self:GetBuff_Hook("Hook_AddShootSound", data)
end