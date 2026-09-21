if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID( "arccw/weaponicons/arccw_go_taser" )
    killicon.Add( "arccw_horde_taser", "arccw/weaponicons/arccw_go_taser", Color( 0, 0, 0, 255 ) )
end

SWEP.Base = "arccw_go_taser"
SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "M26 Stunner"
SWEP.Trivia_Class = "Stun Gun"
SWEP.Trivia_Desc = "Less-lethal weapon designed to incapacitate attackers with a high voltage electric shock. Pissed off bank robbers and cool helmet not included.\nRecharges after each shot, if the battery is completely discharged, it'll be unable to fire until it fully charges."
SWEP.Trivia_Manufacturer = "klAxon"
SWEP.Trivia_Calibre = "Taser Cartridge M26"
SWEP.Trivia_Mechanism = "Compressed CO2"
SWEP.Trivia_Country = "USA"
SWEP.Trivia_Year = 1999

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/arccw_go/v_eq_taser.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_eq_taser.mdl"
SWEP.ViewModelFOV = 60

SWEP.DefaultBodygroups = "000000000000"

SWEP.Damage = 10
SWEP.DamageMin = 10 -- damage done at maximum range
SWEP.RangeMin = 6
SWEP.Range = 6 -- in METRES
SWEP.Distance = 200 -- max distance the bullet travels, measured in hammer units because consistency be damned
SWEP.Penetration = 0
SWEP.DamageType = DMG_SHOCK

SWEP.Primary.ClipSize = 100 -- DefaultClip is automatically set.
SWEP.Primary.MaxAmmo = -1
SWEP.ForceDefaultAmmo = -1
SWEP.RegenerationTimer = CurTime()
SWEP.AmmoRegenAmount = 1
SWEP.AmmoPerShot = 50
SWEP.AlwaysPhysBullet = false
SWEP.TracerNum = 0

SWEP.Recoil = 1.5
SWEP.RecoilSide = 0.1
SWEP.RecoilRise = 0.1
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 80 -- 60 / RPM.
SWEP.Num = 1 -- number of shots per trigger pull.
SWEP.Firemodes = {
    {
        Mode = 1,
        PrintName = "SNGL"
    },
    {
        Mode = 0
    }
}

SWEP.AccuracyMOA = 1 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 1 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 1

SWEP.Primary.Ammo = "XBowBoltHL1"

SWEP.Disposable = false -- when all ammo is expended, the gun will remove itself when holstered
SWEP.DoNotEquipmentAmmo = true
SWEP.AutoReload = true

SWEP.ShootSound = ")arccw_go/taser/taser_shoot.wav"

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.75
SWEP.SightTime = 0.2
SWEP.ShootWhileSprint = true
SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(-1, 2, -1)
SWEP.ActiveAng = Angle(0, 0, 0)
SWEP.RejectAttachments = {["go_perk_fastreload"] = true, ["go_perk_cowboy"] = true}
SWEP.Discharged = false

if SERVER then
    SWEP.Hook_BulletHit = function( wep, data )
        local att = data.att
        local tr = data.tr
        local entHit = tr.Entity
        local bulletDmg = data.damage

        if HORDE:IsEnemy( entHit ) and bulletDmg >= 1 then
            entHit:EmitSound("ArcCW_Horde.GSO.TASER.Hit")
            entHit:Horde_AddDebuffBuildup( HORDE.Status_Stun, 5000, att )
        end
    end


    SWEP.Hook_OnDeploy = function( wep )

        if not wep.Discharged then
            wep.RegenerationTimer = CurTime() + 0.1
        end

        if wep.HolsterTime then
            local ammoCount = math.floor( ( CurTime() - wep.HolsterTime ) * wep.AmmoRegenAmount )
            wep:SetClip1( math.min( wep:Clip1() + ammoCount, wep.Primary.ClipSize ) )
        end
    end

    SWEP.Hook_OnHolster = function( wep )
        if not wep.Discharged then
            wep.RegenerationTimer = CurTime()
        end
            wep.HolsterTime = CurTime()
    end
end

SWEP.Hook_Think = function( wep )
    if SERVER then
        if wep.RegenerationTimer <= CurTime() and wep:Clip1() < wep.Primary.ClipSize then
            wep:SetClip1( wep:Clip1() + wep.AmmoRegenAmount )
            wep.RegenerationTimer = CurTime() + 0.1
        end

        if wep:Clip1() > wep.Primary.ClipSize then
            wep:SetClip1( wep.Primary.ClipSize )
        end
    end
    if wep:Clip1() <= 15 and not wep.Discharged then
        wep.Discharged = true
        wep:EmitSound( "ArcCW_Horde.GSO.TASER.Discharged" )
        if SERVER then
            wep.RegenerationTimer = CurTime() + 3
        end
    end
    if wep:Clip1() >= 100 and wep.Discharged then
        wep:EmitSound( "ArcCW_Horde.GSO.TASER.Recharged" )
        wep.Discharged = false
    end
end


SWEP.Hook_PostFireBullets = function( wep )
    wep.RegenerationTimer = CurTime() + 0.1
end

SWEP.Hook_ShouldNotSight = function( wep )
    local notSprinting

    if  wep:GetState() == ArcCW.STATE_SPRINT then
        notSprinting = true
    elseif wep:GetState() ~= ArcCW.STATE_SPRINT then
        notSprinting = false
    end
    return notSprinting
end

SWEP.Hook_ShouldNotFire = function( wep )
    local canFire

    if wep.Discharged then
        canFire = true
    elseif not wep.Discharged then
        canFire = false
    end
    return canFire
end



sound.Add({
    name = "ARCCW_GO_TASER.Draw",
    channel = 16,
    volume = 1.0,
    sound = "arccw_go/glock18/glock_draw.wav"
})
sound.Add( {
    name = "ArcCW_Horde.GSO.TASER.Discharged",
    channel = CHAN_STATIC,
    volume = 1.5,
    level = 70,
    pitch = {100, 100},
    sound = ")arccw_go/sensorgrenade/sensor_arm.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.TASER.Recharged",
    channel = CHAN_STATIC,
    volume = 1.5,
    level = 70,
    pitch = {98, 101},
    sound = ")arccw_go/sensorgrenade/sensor_detect.wav"
} )
sound.Add( {
    name = "ArcCW_Horde.GSO.TASER.Hit",
    channel = CHAN_STATIC,
    volume = 1.2,
    level = 80,
    pitch = {74, 76},
    sound = ")arccw_go/taser/taser_hit.wav"
} )