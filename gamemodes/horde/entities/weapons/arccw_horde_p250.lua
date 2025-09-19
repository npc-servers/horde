if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_p250")
    killicon.Add("arccw_horde_p250", "arccw/weaponicons/arccw_go_p250", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_p250"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "P250"

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_p250.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_p250.mdl"

SWEP.RecoilPunch = 0

SWEP.ShootSound = "ArcCW_Horde.GSO.P250_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.P250_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

sound.Add( {
    name = "ArcCW_Horde.GSO.P250_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = {98, 101},
    sound = ")arccw_go/p250/p250_01.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.P250_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = {")arccw_go/usp/usp_01.wav",")arccw_go/usp/usp_02.wav",")arccw_go/usp/usp_03.wav"}
} )