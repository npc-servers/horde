if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_mp5")
    killicon.Add("arccw_horde_mp5", "arccw/weaponicons/arccw_go_mp5", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_mp5"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "MP5A3"

SWEP.ViewModel = "models/weapons/arccw_go/v_smg_mp5.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_smg_mp5.mdl"

SWEP.Damage = 35
SWEP.DamageMin = 25

SWEP.RecoilPunch = 0

SWEP.ShootVol = 75

SWEP.FirstShootSound = ")arccw_go/mp5/mp5_unsil.wav"
SWEP.ShootSound = ")arccw_go/mp5/mp5_unsil.wav"
SWEP.ShootSoundSilenced = ")arccw_go/mp5/mp5_01.wav"
SWEP.DistantShootSound = "^horde/weapons/distant/smg_distant.wav"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)