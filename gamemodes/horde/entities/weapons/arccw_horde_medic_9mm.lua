if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("items/hl2/weapon_pistol.png")
    SWEP.WepSelectIconMat = Material("items/hl2/weapon_pistol.png")
    killicon.AddAlias("arccw_horde_9mm", "weapon_9mm")
end

SWEP.Base = "arccw_base"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false
SWEP.WeaponCamBone = tag_camera

SWEP.PrintName = "Medic 9mm"
SWEP.Trivia_Class = "Pistol"
SWEP.Trivia_Desc = "Standard issue pistol."
SWEP.Trivia_Manufacturer = "Combine"
SWEP.Trivia_Calibre = "9x19mm Parabellum"
SWEP.Trivia_Mechanism = "Semi-Auto"
SWEP.Trivia_Country = "Combine"
SWEP.Trivia_Year = 2007

SWEP.Slot = 1

SWEP.UseHands = true

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.MirrorVMWM = true
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ViewModelFOV = 65

SWEP.WorldModelOffset = {
    pos = Vector(-21.5, 7, -3.5),
    ang = Angle(-10, 0, 180)
}

SWEP.Damage = 20
SWEP.DamageMin = 15
SWEP.Range = 25
SWEP.Penetration = 2
SWEP.DamageType = DMG_BULLET
SWEP.ShootEntity = nil

SWEP.ChamberSize = 0
SWEP.Primary.ClipSize = 18

SWEP.Recoil = 0.2
SWEP.RecoilSide = 0.12
SWEP.RecoilPunch = 0

SWEP.Delay = 0.08
SWEP.Num = 1
SWEP.Firemodes = {
    {
        Mode = 1,
    }
}

SWEP.AccuracyMOA = 5
SWEP.HipDispersion = 150
SWEP.MoveDispersion = 200

SWEP.Primary.Ammo = "Pistol"

SWEP.ShootSound = "ArcCW_Horde.9mm_Fire"
SWEP.ShootSoundSilenced = "ArcCW_Horde.9mm_Fire_Sil"

SWEP.MuzzleEffect = "muzzleflash_pistol"
SWEP.ShellModel = "models/weapons/shell.mdl"
SWEP.ShellScale = 0.5

SWEP.MuzzleEffectAttachment = 1
SWEP.CaseEffectAttachment = 2

SWEP.SpeedMult = 1
SWEP.SightedSpeedMult = 0.8
SWEP.SightTime = 0.125

SWEP.IronSightStruct = {
    Pos = Vector(-1, 0, 2),
    Ang = Angle(0, 0, 0),
    Magnification = 1.25,
    SwitchToSound = "", -- sound that plays when switching to this sight
    ViewModelFOV = 40,
    CrosshairInSights = true
}

SWEP.HoldType = "pistol"
SWEP.HoldtypeHolstered = "normal"
SWEP.HoldtypeActive = "pistol"
SWEP.HoldtypeSights = "pistol"

SWEP.AnimShoot = ACT_HL2MP_GESTURE_RANGE_ATTACK_PISTOL

SWEP.ActivePos = Vector(0, -5, 1)
SWEP.ActiveAng = Angle(0, 0, 0)

SWEP.CustomizePos = Vector(7, -8, 1)
SWEP.CustomizeAng = Angle(5, 30, 10)

SWEP.HolsterPos = Vector(3, -5, 0)
SWEP.HolsterAng = Angle(-10, 25, -15)

SWEP.SprintPos = Vector(0, -5, 1)
SWEP.SprintAng = Angle(-10, 0, 0)

SWEP.BarrelOffsetSighted = Vector(0, 0, -1)
SWEP.BarrelOffsetHip = Vector(2, 0, -2)

SWEP.BarrelLength = 18

SWEP.ExtraSightDist = 5

SWEP.Attachments = {
    {
        PrintName = "Ammo Type",
        Slot = "go_ammo",
        DefaultAttName = "Standard Ammo"
    },
    {
        PrintName = "Muzzle",
        DefaultAttName = "Standard Muzzle",
        Slot = "muzzle",
        Bone = "ValveBiped.Bip01_R_Hand",
        Offset = {
            vpos = Vector(12, 1.525, -3.69),
            vang = Angle(0, 0, 180),
        },
        VMScale = Vector(1, 1, 1),
    },
    {
        PrintName = "Tactical",
        Slot = "tac",
        Bone = "ValveBiped.Bip01_R_Hand",
        Offset = {
            vpos = Vector(8.950, 1.45, -2.285),
            vang = Angle(0, 0, 180),
        },
    },
    {
        PrintName = "Perk",
        Slot = {"go_perk", "go_perk_pistol"}
    },
}

SWEP.Animations = {
    ["idle"] = {
        Source = "idle01",
    },
    ["draw"] = {
        Source = "draw",
    },
    ["fire"] = {
        Source = {"fire1", "fire2", "fire3"},
        ShellEjectAt = 0,
    },
    ["fire_iron"] = {
        Source = {"fire1", "fire2", "fire3"},
        ShellEjectAt = 0,
    },
    ["reload"] = {
        Source = "reload",
        TPAnim = ACT_HL2MP_GESTURE_RELOAD_PISTOL,
        SoundTable = {
            {s = "weapons/pistol/pistol_reload1.ogg", t = 0},
        },
        LHIK = true,
        LHIKIn = 0.25,
        LHIKOut = 0.25,
    },
}

function SWEP:ChangeFiremode(pred)
    if self:GetNextSecondaryFire() > CurTime() then return end
    if !self.CanBash and !self:GetBuff_Override("Override_CanBash") then return end
    if CLIENT then return end
    local ply = self:GetOwner()
    local filter = {self:GetOwner()}
    local tr = util.TraceHull({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 5000,
        filter = filter,
        mins = Vector(-16, -16, -8),
        maxs = Vector(16, 16, 8),
        mask = MASK_SHOT_HULL
    })
    if tr.Hit then
        local effectdata = EffectData()
        effectdata:SetOrigin(tr.HitPos)
        effectdata:SetRadius(25)
        util.Effect("horde_heal_mist", effectdata)

        for _, ent in pairs(ents.FindInSphere(tr.HitPos, 80)) do
            if ent:IsPlayer() then
                local healinfo = HealInfo:New({amount=8, healer=ply})
                HORDE:OnPlayerHeal(ent, healinfo)
            elseif ent:GetClass() == "npc_vj_horde_antlion" then
                local healinfo = HealInfo:New({amount=8, healer=ply})
                HORDE:OnAntlionHeal(ent, healinfo)
            elseif ent:IsNPC() then
                local dmg = DamageInfo()
                dmg:SetDamage(10)
                dmg:SetDamageType(DMG_NERVEGAS)
                dmg:SetAttacker(ply)
                dmg:SetInflictor(self)
                dmg:SetDamagePosition(tr.HitPos)
                ent:TakeDamageInfo(dmg)
            end
        end
    end

    ply:EmitSound("horde/weapons/mp7m/heal.ogg", 100, 100, 1, CHAN_AUTO)

    self:SetNextSecondaryFire(CurTime() + 0.5)
    return true
end

function SWEP:DrawWeaponSelection(x, y, w, h, a)
    surface.SetDrawColor(255, 255, 255, a)
    surface.SetMaterial(self.WepSelectIconMat)

    surface.DrawTexturedRect(x, y, w, w / 2)
end

function SWEP:Hook_Think()
    if SERVER then return end
    local tr = util.TraceHull({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 5000,
        filter = filter,
        mins = Vector(-20, -20, -8),
        maxs = Vector(20, 20, 8),
        mask = MASK_SHOT_HULL
    })

    if tr.Hit and tr.Entity and tr.Entity:IsPlayer()then
        self.Horde_HealTarget = tr.Entity
    else
        self.Horde_HealTarget = nil
    end
end

local function nv_center(ent)
	return ent:LocalToWorld(ent:OBBCenter())
end

function SWEP:Hook_DrawHUD()
    if self.Horde_HealTarget then
        local pos = nv_center(self.Horde_HealTarget):ToScreen()
		surface.SetDrawColor(Color(50, 200, 50))
        surface.DrawCircle(pos.x, pos.y, 30)
        --surface.DrawLine(pos.x, 0, pos.x, ScrH())
        --surface.DrawLine(0, pos.y, ScrW(), pos.y)
        draw.DrawText(self.Horde_HealTarget:Health(), "Trebuchet24",
        pos.x - 15, pos.y - 15, Color(50, 200, 50), TEXT_ALIGN_LEFT)
    end
end

sound.Add( {
    name = "ArcCW_Horde.Medic_9mm_Fire",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 90,
    pitch = {98, 102},
    sound = ")weapons/pistol/pistol_fire2.ogg"
} )
sound.Add( {
    name = "ArcCW_Horde.Medic_9mm_Fire_Sil",
    channel = CHAN_WEAPON,
    volume = 1.0,
    level = 75,
    pitch = 100,
    sound = ")weapons/usp/usp1.wav"
} )