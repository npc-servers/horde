if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_tec9")
    killicon.Add("arccw_horde_tec9", "arccw/weaponicons/arccw_go_tec9", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_tec9"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "TEC-9"

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_tec9.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_tec9.mdl"

SWEP.Damage = 42
SWEP.DamageMin = 12

SWEP.RecoilPunch = 0

SWEP.ShootSound = "ArcCW_Horde.GSO.Tec9_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.GSO.Tec9_Fire_Sil"
SWEP.DistantShootSound = ""

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.IronSightStruct = {
    Pos = Vector(-5.1, 1, 2.55)
}

SWEP.RejectAttachments = {["go_fore_bipod"] = true, ["go_foregrip_angled"] = true}

SWEP.Attachments = {
    {},{},{},{},{},{},
    {
        Offset = {
            vpos = Vector(0, -2.15, -1),
            vang = Angle(90, 0, -90),
        }
    }
}

function SWEP:Hook_TranslateAnimation(anim)
    if anim == "fire_iron" then
        if not self.Attachments[7].Installed then return "fire" end
    end
end

sound.Add( {
    name = "ArcCW_Horde.GSO.Tec9_Fire",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 90,
    pitch = {99, 101},
    sound = ")arccw_go/tec9/tec9_02.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.Tec9_Fire_Sil",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = {")arccw_go/usp/usp_01.wav",")arccw_go/usp/usp_02.wav",")arccw_go/usp/usp_03.wav"}
} )