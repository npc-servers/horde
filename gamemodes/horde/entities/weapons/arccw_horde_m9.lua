if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_m9")
    killicon.Add("arccw_horde_m9", "arccw/weaponicons/arccw_go_m9", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_m9"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "M92FS"

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_m9.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_m9.mdl"

SWEP.RecoilPunch = 0

SWEP.FirstShootSound = "ArcCW_Horde.GSO.Elite_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.Elite_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.Elite_Fire_Sil"
SWEP.DistantShootSound = "ArcCW_Horde.GSO.Elite_Fire_Dist"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

SWEP.Attachments = {
    {},{},{},{},{},
    {
        Offset = {
            vpos = Vector(0, -1.5, 0),
            vang = Angle(90, 0, -90),
        },
    }
}

sound.Add( {
    name = "ArcCW_Horde.GSO.Elite_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 110,
    sound = {")arccw_go/elite/elites_01.wav",")arccw_go/elite/elites_02.wav",")arccw_go/elite/elites_03.wav",")arccw_go/elite/elites_04.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.Elite_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = {")arccw_go/usp/usp_01.wav",")arccw_go/usp/usp_02.wav",")arccw_go/usp/usp_03.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.Elite_Fire_Dist",
    channel = CHAN_WEAPON,
    volume = 0.25,
    level = 140,
    pitch = 100,
    sound = "arccw_go/elite/elite-1-distant.wav"
} )