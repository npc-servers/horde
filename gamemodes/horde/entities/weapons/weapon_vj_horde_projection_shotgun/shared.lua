if not file.Exists( "autorun/vj_base_autorun.lua", "LUA" ) then return end

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Overlord Projection Shotgun"
SWEP.MadeForNPCsOnly = true
SWEP.HoldType = "shotgun"

SWEP.WorldModel = "models/weapons/w_shot_xm1014.mdl"

SWEP.NPC_NextPrimaryFire = 0.2
SWEP.NPC_CustomSpread = 2.5
SWEP.NPC_CanBePickedUp = false

SWEP.NPC_FiringDistanceScale = 0.1

SWEP.NPC_ReloadSound = { "vj_weapons/reload_shotgun.wav" }
SWEP.NPC_ReloadSoundLevel = 75

SWEP.HasDryFireSound = false

SWEP.Primary.Damage = 20
SWEP.Primary.NumberOfShots = 10
SWEP.Primary.ClipSize = 100
SWEP.Primary.Ammo = "Buckshot"

SWEP.Primary.Sound = "weapons/fesiugmw2/fire_distant/shot_m1014.wav"
SWEP.Primary.SoundLevel = 80
SWEP.Primary.SoundPitch	= VJ_Set( 100, 105 )
SWEP.Primary.HasDistantSound = false

SWEP.PrimaryEffects_MuzzleParticles = { "muzzleflash_shotgun" }
SWEP.PrimaryEffects_SpawnShells = false

function SWEP:CustomOnInitialize()
    local owner = self:GetOwner():GetNWEntity( "HordeOwner" )

    if owner.Horde_Special_Upgrades and owner.Horde_Special_Upgrades["module_paranoia"] then
        self.NPC_FiringDistanceScale = 0.1 * 1.5
        self.NPC_CustomSpread = 2.5 / 2
    end
end