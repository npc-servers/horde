if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_glock")
    killicon.Add("arccw_horde_glock", "arccw/weaponicons/arccw_go_glock", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_glock"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "Glock 17"

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_glock.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_glock.mdl"

SWEP.RecoilPunch = 0

SWEP.FirstShootSound = {
    ")arccw_go/glock18/glock_01.wav",
    ")arccw_go/glock18/glock_02.wav"
}
SWEP.ShootSound = {
    ")arccw_go/glock18/glock_01.wav",
    ")arccw_go/glock18/glock_02.wav"
}
SWEP.ShootSoundSilenced = {
    ")arccw_go/usp/usp_01.wav",
    ")arccw_go/usp/usp_02.wav",
    ")arccw_go/usp/usp_03.wav"
}
SWEP.DistantShootSound = "^horde/weapons/distshot.wav"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

SWEP.Attachments = {
    {},{},{},{},{},
    {
        Offset = {
            vpos = Vector(0, -1.45, -1),
            vang = Angle(90, 0, -90),
        },
    }
}