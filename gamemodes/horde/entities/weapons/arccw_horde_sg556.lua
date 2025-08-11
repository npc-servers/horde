if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_sg556")
    killicon.Add("arccw_horde_sg556", "arccw/weaponicons/arccw_go_sg556", Color(0, 0, 0, 255))
end
SWEP.Base = "arccw_go_sg556"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde" -- edit this if you like
SWEP.AdminOnly = false

SWEP.PrintName = "SIG SG556"
SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/arccw_go/v_rif_sg556.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_rif_sg556.mdl"

SWEP.Damage = 64
SWEP.DamageMin = 48  -- damage done at maximum range
SWEP.RecoilPunch = 0.4

SWEP.FirstShootSound = {")arccw_go/sg556/sg556_02.wav",")arccw_go/sg556/sg556_03.wav"}
SWEP.ShootSound =  {")arccw_go/sg556/sg556_01.wav",")arccw_go/sg556/sg556_04.wav"}
SWEP.ShootSoundSilenced = ")arccw_go/m4a1/m4a1_silencer_01.wav"
SWEP.DistantShootSound = ")arccw_go/sg556/sg556_distant.wav"

SWEP.Firemodes = {
    {
        Mode = 2,
    },
    {
        Mode = 1,
    }
}

SWEP.RecoilSide = 0.1