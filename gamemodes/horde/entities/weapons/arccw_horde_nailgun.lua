AddCSLuaFile()

SWEP.Base = "arccw_base"

SWEP.Slot = 2

SWEP.Spawnable = true -- this obviously has to be set to true
SWEP.Category = "ArcCW: Horde"
SWEP.NeverPhysBullet = true
SWEP.PrintName = "Nailgun"
SWEP.Trivia_Class = "Submachine Gun" -- "Submachine Gun"
SWEP.Trivia_Desc = "Power tool modified to fire nails without sticking it to a surface. Nails have no damage dropoff, at the cost of low velocity."
SWEP.Trivia_Manufacturer = "Unlocked" -- "Auschen Waffenfabrik"
SWEP.Trivia_Calibre = "Steel Nail" -- "9x21mm Jager"
SWEP.SubCategory = "Sub-Machine Guns"

SWEP.ViewModelFOV = 70
SWEP.ViewModel = "models//horde/weapons/c_nailgun.mdl" -- I mean, you probably have to edit these too
SWEP.WorldModel = "models/horde/weapons/w_nailgun.mdl"
SWEP.NPCWeaponType = "weapon_smg1"
SWEP.NPCWeight = 70

SWEP.MirrorVMWM = false


SWEP.Primary.Ammo = "XbowBolt" -- what ammo type the gun uses

SWEP.NoHideLeftHandInCustomization = false

SWEP.Firemodes = {
    {
    Mode = 2,
    },
    {
        Mode = 1,
    },
    {
        Mode = 0,
    }

}

-------------------- POS
SWEP.CustomizePos = Vector(9.824, 0, -4.897)
SWEP.CustomizeAng = Angle(12.149, 30.547, 0)

SWEP.HolsterPos = Vector(0.5, 3, 1.2)
SWEP.HolsterAng = Angle(-8.5, 8, -10)

SWEP.ActivePos = Vector(-1.651, 0.5, 0.5)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.SprintPos = Vector(-1.651, 0.5, 0.5)
SWEP.SprintAng = Angle(-18, 0, 0)

SWEP.IronSightStruct = {
    Pos = Vector(-3.8, 0, -0.6),
    Ang = Angle(5.63, 0, 2),
    Midpoint = { -- Where the gun should be at the middle of it's irons
        Pos = Vector(0, 15, -4),
        Ang = Angle(0, 0, -45),
    },
    Magnification = 1,
}

-------------------- BALANCING
SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.85
SWEP.ShootSpeedMult = 1

SWEP.SightTime = 0.1

SWEP.AccuracyMOA = 25 -- accuracy in Minutes of Angle. There are 60 MOA in a degree.
SWEP.HipDispersion = 200 -- inaccuracy added by hip firing.
SWEP.MoveDispersion = 250 -- inaccuracy added by moving. Applies in sights as well! Walking speed is considered as "maximum".
SWEP.SightsDispersion = 1 -- dispersion that remains even in sights
SWEP.JumpDispersion = 300 -- dispersion penalty when in the air

SWEP.Damage = 0
SWEP.DamageMin = 0 -- damage done at maximum range
SWEP.DamageType = DMG_SLASH
SWEP.Range = 75 -- in METRES
SWEP.ShootEntity = "projectile_horde_nail" -- entity to fire, if any
SWEP.MuzzleVelocity = 3000 -- projectile or phys bullet muzzle velocity
SWEP.Recoil = 0.55
SWEP.RecoilSide = 0.35
SWEP.RecoilRise = 0.45
SWEP.MaxRecoilBlowback = -1
SWEP.VisualRecoilMult = 0
SWEP.RecoilPunch = 0.5
SWEP.RecoilPunchBackMax = 1
SWEP.RecoilPunchBackMaxSights = nil -- may clip with scopes
SWEP.RecoilVMShake = 0.2-- random viewmodel offset when shooty
SWEP.Sway = 0.2
SWEP.Delay = 55 / 508 -- 60 / RPM.



-----------------FX
SWEP.TracerNum = 1
SWEP.TracerFinalMag = 0
SWEP.Tracer = "arccw_tracer"
SWEP.TracerCol = Color(255, 255, 255)
SWEP.MuzzleEffect = "muzzleflash_suppressed"
SWEP.NoShellEject = true
SWEP.ShootSound = "weapon_nailgun.fire"

------------------- MAG
SWEP.ChamberSize = 0 -- how many rounds can be chambered.
SWEP.Primary.ClipSize = 45 -- DefaultClip is automatically set.

----------------ANIMATION
SWEP.MuzzleEffectAttachment = 1 -- which attachment to put the muzzle on
SWEP.CaseEffectAttachment = 0 -- which attachment to put the case effect on
SWEP.CamAttachment = 3 -- if set, this attachment will control camera movement

SWEP.BulletBones = { -- the bone that represents bullets in gun/mag
     [0] = "bulletchamber",
     [1] = "bullet1"
}

SWEP.AttachmentElements = {
}

SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "revolver"
SWEP.HoldtypeCustomize = "slam"

SWEP.Animations = {
    ["idle"] = {
        Source = "idle",
    },
    ["idle_empty"] = {
        Source = "idle_empty",
    },
    ["holster"] = {
        Source = "holster",
    },
    ["draw"] = {
        Source = "draw",
    },
    ["holster_empty"] = {
        Source = "holster_empty",
    },
    ["draw_empty"] = {
        Source = "draw_empty",
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2, -- third person animation to play when this animation is played
        LHIK = true,
        LHIKIn = 0.25, -- In/Out controls how long it takes to switch to regular animation.
        LHIKOut = 0.25, -- (not actually inverse kinematics)
    },
    ["reload_empty"] = {
        Source = "reload_empty",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_AR2, -- third person animation to play when this animation is played
        LHIK = true,
        LHIKIn = 0.25, -- In/Out controls how long it takes to switch to regular animation.
        LHIKOut = 0.25, -- (not actually inverse kinematics)
    },
}

------------------ATTS
SWEP.Hook_ModifyBodygroups = function(wep, data)
    local vm = data.vm
    local atts = wep.Attachments
    
    if !IsValid(vm) then return end
    
    -- Call the base ModifyBodygroups function to apply AttachmentElements first
    if wep.BaseClass and wep.BaseClass.Hook_ModifyBodygroups then
        wep.BaseClass.Hook_ModifyBodygroups(wep, data)
    end
    
    -- Check if attachment in slot #1 (optic) is installed
    if atts[1] and atts[1].Installed then
        vm:SetBodygroup(1, 1)
    end
end


SWEP.Attachments = {
       {
        PrintName = "Perks",
        Slot = {"go_perk", "go_perk_smg"},
        DefaultAttName = "None"
    },
    {
        PrintName = "Charms",
        Slot = "charm",
        Bone = "tag_barrel_attach",
        Offset = {
            vpos = Vector(-6, -1.2, 0),
            vang = Angle(0, -15, 0),
            wpos = Vector(7, 2, -4.5),
            wang = Angle(-5, 1, 180)
    },

}
}