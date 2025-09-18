if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_bizon")
    killicon.Add("arccw_horde_bizon", "arccw/weaponicons/arccw_go_bizon", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_bizon"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "PP-19 Bizon-2"

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_bizon.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_bizon.mdl"

SWEP.Damage = 45
SWEP.DamageMin = 32

SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 750

SWEP.FirstShootSound = "ArcCW_Horde.GSO.Bizon_Fire"
SWEP.ShootSound = "ArcCW_Horde.GSO.Bizon_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.Bizon_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip"] = true, ["go_foregrip_angled"] = true, ["go_foregrip_ergo"] = true, ["go_foregrip_snatch"] = true, ["go_foregrip_stubby"] = true}

sound.Add( {
    name = "ArcCW_Horde.GSO.Bizon_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = 100,
    sound = {")arccw_go/bizon/bizon_01.wav",")arccw_go/bizon/bizon_02.wav"}
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.Bizon_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")arccw_go/mp5/mp5_01.wav"
} )