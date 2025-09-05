if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_r8")
    killicon.Add("arccw_horde_r8", "arccw/weaponicons/arccw_go_r8", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_r8"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "Model 327 R8"

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_r8.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_r8.mdl"

SWEP.Damage = 92
SWEP.DamageMin = 67

SWEP.RecoilPunch = 0

SWEP.ShootSound = "ArcCW_Horde.GSO.R8_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.R8_Fire_Sil"
SWEP.DistantShootSound = "ArcCW_Horde.GSO.R8_Fire_Dist"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

function SWEP:Hook_TranslateAnimation(anim)
    if anim == "fire_iron" then
        if self.Attachments[5].Installed then return "idle" end
    end
end

SWEP.Hook_ModifyRPM = function(wep, delay)
    if wep:GetState() == ArcCW.STATE_SIGHTS then
        return delay * 2
    end
end

SWEP.Animations = {
    ["idle"] = {
        Source = ""
    },
}

sound.Add( {
    name = "ArcCW_Horde.GSO.R8_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = ")arccw_go/revolver/revolver-1_01.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.R8_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/mosin_suppressed_fp.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.R8_Fire_Dist",
    channel = CHAN_WEAPON,
    volume = 0.25,
    level = 140,
    pitch = 100,
    sound = "arccw_go/revolver/revolver-1_distant.wav"
} )