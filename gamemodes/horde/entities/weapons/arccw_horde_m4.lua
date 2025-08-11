if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_m4")
    killicon.Add("arccw_horde_m4", "arccw/weaponicons/arccw_go_m4", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_m4"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "M4A1"


SWEP.Slot = 2


SWEP.ViewModel = "models/weapons/arccw_go/v_rif_m4a1.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_m4a1.mdl"

SWEP.Damage = 60
SWEP.DamageMin = 45 -- damage done at maximum range
SWEP.Range = 3000 * 0.025 -- in METRES
SWEP.RecoilPunch = 1

SWEP.Delay = 60 / 750

SWEP.FirstShootSound = {")arccw_go/m4a1/m4a1_01.wav",")arccw_go/m4a1/m4a1_04.wav"}
SWEP.ShootSound =  {")arccw_go/m4a1/m4a1_02.wav",")arccw_go/m4a1/m4a1_03.wav"}
SWEP.ShootSoundSilenced = ")arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound =  ")arccw_go/m4a1/m4a1_distant_01.wav"

SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    }
}

SWEP.RecoilSide = 0.1