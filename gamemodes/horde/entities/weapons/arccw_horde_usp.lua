if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_usp")
    killicon.Add("arccw_horde_usp", "arccw/weaponicons/arccw_go_usp", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_usp"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "USP-45"

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_usp.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_usp.mdl"

SWEP.RecoilPunch = 0

SWEP.FirstShootSound = "ArcCW_Horde.GSO.USP_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.USP_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.USP_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

sound.Add( {
    name = "ArcCW_Horde.GSO.USP_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/usp/usp_unsilenced_01.wav",")arccw_go/usp/usp_unsilenced_02.wav",")arccw_go/usp/usp_unsilenced_03.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.USP_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = {")arccw_go/usp/usp_01.wav",")arccw_go/usp/usp_02.wav",")arccw_go/usp/usp_03.wav"}
} )