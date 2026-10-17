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

SWEP.Damage = 63
SWEP.DamageMin = 53
SWEP.Penetration = 10
SWEP.Primary.ClipSize = 200

SWEP.Recoil = 0.3
SWEP.RecoilSide = 0.35

SWEP.Delay = 60 / 890

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

SWEP.Hook_SelectReloadAnimation = function(wep, anim)
    if wep.Attachments[1].Installed then
        return anim .. "_att"
    end
end

SWEP.Hook_TranslateAnimation = function(wep, anim)
    if wep.Attachments[3].Installed then
        return anim .. "_grip"
    end
end

local reloadMult = 0.8
SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
        Time = 100 / 30
    },
    ["enter_sprint"] = {
        Source = "sprint_in",
        Time = 10 / 30
    },
    ["idle_sprint"] = {
        Source = "sprint_loop",
        Time = 29 / 40
    },
    ["exit_sprint"] = {
        Source = "sprint_out",
        Time = 10 / 30
    },
    ["draw"] = {
        Source = "pullout",
        Time = 41 / 30,
        SoundTable = {
            {s = "MW2Common.Deploy", t = 0 }
        },
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["holster"] = {
        Source = "putaway",
        Time = 18 / 30,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["fire"] = {
        Source = "fire",
        Time = 9 / 30,
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = "fire_ads",
        Time = 13 / 30,
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        Time = 291 / 30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        MinProgress = 291 / 30,
        SoundTable = {
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_lift_v1.wav", t = 0 },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_chamber_v1.wav", t = ( 18 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_open_v1.wav", t = ( 80 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_clipout_v1.wav", t = ( 103 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_clipin_v1.wav", t = ( 152 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_hitclip_v1.wav", t = ( 175 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_lift_v1.wav", t = ( 192 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_close_v1.wav", t = ( 212 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_hit_v1.wav", t = ( 225 / 30 ) * reloadMult },
        },
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1,
        Mult = reloadMult
    },
    ["reload_att"] = {
        Source = "reload_att",
        Time = 291 / 30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        MinProgress = 291 / 30,
        SoundTable = {
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_lift_v1.wav", t = 0 },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_chamber_v1.wav", t = ( 18 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_open_v1.wav", t = ( 80 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_clipout_v1.wav", t = ( 103 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_clipin_v1.wav", t = ( 152 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_hitclip_v1.wav", t = ( 175 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_lift_v1.wav", t = ( 192 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_close_v1.wav", t = ( 212 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_hit_v1.wav", t = ( 225 / 30 ) * reloadMult },
        },
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1,
        Mult = reloadMult
    },
------------------
    ["idle_grip"] = {
        Source = "idle_grip",
        Time = 100 / 30
    },
    ["enter_sprint_grip"] = {
        Source = "sprint_in_grip",
        Time = 10 / 30
    },
    ["idle_sprint_grip"] = {
        Source = "sprint_loop_grip",
        Time = 29 / 40
    },
    ["exit_sprint_grip"] = {
        Source = "sprint_out_grip",
        Time = 10 / 30
    },
    ["draw_grip"] = {
        Source = "pullout_grip",
        Time = 41 / 30,
        SoundTable = {
            { s = "MW2Common.Deploy", t = 0}
        },
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["holster_grip"] = {
        Source = "putaway_grip",
        Time = 18 / 30,
        LHIK = true,
        LHIKIn = 0,
        LHIKOut = 0.35,
    },
    ["fire_grip"] = {
        Source = "fire_grip",
        Time = 9 / 30,
        ShellEjectAt = 0,
    },
    ["fire_iron_grip"] = {
        Source = "fire_ads_grip",
        Time = 13 / 30,
        ShellEjectAt = 0,
    },
    ["reload_grip"] = {
        Source = "reload_grip",
        Time = 291 / 30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        MinProgress = 291 / 30,
        SoundTable = {
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_lift_v1.wav", t = 0 },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_chamber_v1.wav", t = ( 18 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_open_v1.wav", t = ( 80 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_clipout_v1.wav", t = ( 103 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_clipin_v1.wav", t = ( 152 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_hitclip_v1.wav", t = ( 175 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_lift_v1.wav", t = ( 192 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_close_v1.wav", t = ( 212 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_hit_v1.wav", t = ( 225 / 30 ) * reloadMult },
        },
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1,
        Mult = reloadMult
    },
    ["reload_att_grip"] = {
        Source = "reload_att_grip",
        Time = 291 / 30,
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2,
        MinProgress = 291 / 30,
        SoundTable = {
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_lift_v1.wav", t = 0 },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_chamber_v1.wav", t = ( 18 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_open_v1.wav", t = ( 80 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_clipout_v1.wav", t = ( 103 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_clipin_v1.wav", t = ( 152 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_hitclip_v1.wav", t = ( 175 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_lift_v1.wav", t = ( 192 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_close_v1.wav", t = ( 212 / 30 ) * reloadMult },
            { s = "weapons/fesiugmw2/foley/wpfoly_mg4_reload_hit_v1.wav", t = ( 225 / 30 ) * reloadMult },
        },
        LHIK = true,
        LHIKIn = 0.5,
        LHIKOut = 1,
        Mult = reloadMult
    },
}
sound.Add( {
    name = "ArcCW_Horde.MW2.MG4_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = { 90, 105 },
    sound = ")weapons/fesiugmw2/fire/mg4.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.MW2.MG4_Mech",
    channel = CHAN_AUTO,
    volume = 1.0,
    level = 45,
    pitch = { 90, 105 },
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
    pitch = { 90, 105 },
    sound = ")weapons/fesiugmw2/fire/m240_sil.wav"
} )