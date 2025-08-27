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

SWEP.ShootVol = 75

SWEP.ShootSound = ")weapons/fesiugmw2/fire/scarl.wav"
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
SWEP.ShootDrySound = "weapons/arccw/dryfire.wav"
SWEP.ShootSoundSilenced = ")weapons/fesiugmw2/fire/scarl_sil.wav"

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

SWEP.Animations = {
    ["draw"] = {
        Source = "pullout",
        Time = 29/30,
        SoundTable = {{s = "weapons/fesiugmw2/wpnarm_2.wav", c = CHAN_ITEM, t = 0}},
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0,
    },
    ["ready"] = {
        Source = "pullout_first",
        Time = 38/30,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_scar_reload_chamber_v1.wav", c = CHAN_ITEM, t = 13/30},
        },
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_scar_reload_lift_v1.wav", c = CHAN_ITEM, t = 0},
            {s = "weapons/fesiugmw2/unofficial/scarl/magout.wav", c = CHAN_ITEM, t = 10/30},
            {s = "weapons/fesiugmw2/unofficial/scarl/magin.wav", c = CHAN_ITEM, t = 40/30},
        },
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.6,
        LHIKEaseOut = 0.3,
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_scar_reload_lift_v1.wav", c = CHAN_ITEM, t = 0},
            {s = "weapons/fesiugmw2/unofficial/scarl/magout.wav", c = CHAN_ITEM, t = 10/30},
            {s = "weapons/fesiugmw2/unofficial/scarl/magin.wav", c = CHAN_ITEM, t = 40/30},
            {s = "weapons/fesiugmw2/unofficial/scarl/chamber.wav", c = CHAN_ITEM, t = 54/30},
            {s = "weapons/fesiugmw2/unofficial/scarl/chamberforward.wav", c = CHAN_ITEM, t = 62/30},                     
        },
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 0.5,
        LHIKEaseOut = 0.3,
    },
    ["draw_m203"] = {
        Source = "pullout_m203",
        Time = 29/30,
        SoundTable = {{s = "weapons/fesiugmw2/wpnarm_2.wav", c = CHAN_ITEM, t = 0}},
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0,
    },
    ["ready_m203"] = {
        Source = "pullout_first_m203",
        Time = 38/30,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_scar_reload_chamber_v1.wav", c = CHAN_ITEM, t = 13/30},
        },
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.25,
    },
    ["reload_m203"] = {
        Source = "reload_m203",
        Time = 76/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_scar_reload_lift_v1.wav", c = CHAN_ITEM, t = 0},
            {s = "weapons/fesiugmw2/foley/wpfoly_scar_reload_clipout_v1.wav", c = CHAN_ITEM, t = 18/30},
            {s = "weapons/fesiugmw2/foley/wpfoly_scar_reload_clipin_v1.wav", c = CHAN_ITEM, t = 48/30},
        },
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0.7,
    },
    ["reload_empty_m203"] = {
        Source = "reload_empty_m203",
        Time = 102/30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        SoundTable = {
            {s = "weapons/fesiugmw2/foley/wpfoly_scar_reload_lift_v1.wav", c = CHAN_ITEM, t = 0},
            {s = "weapons/fesiugmw2/foley/wpfoly_scar_reload_clipout_v1.wav", c = CHAN_ITEM, t = 18/30},
            {s = "weapons/fesiugmw2/foley/wpfoly_scar_reload_clipin_v1.wav", c = CHAN_ITEM, t = 48/30},
            {s = "weapons/fesiugmw2/foley/wpfoly_scar_reload_hit_v1.wav", c = CHAN_ITEM, t = 69/30},
        },
        LHIK = true,
        LHIKIn = 0.3,
        LHIKOut = 0.7,
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