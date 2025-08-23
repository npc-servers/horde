if not ArcCWInstalled then return end
if CLIENT then
    SWEP.WepSelectIcon = surface.GetTextureID("arccw/weaponicons/arccw_go_fiveseven")
    killicon.Add("arccw_horde_fiveseven", "arccw/weaponicons/arccw_go_fiveseven", Color(0, 0, 0, 255))
end

SWEP.Base = "arccw_go_fiveseven"

SWEP.Spawnable = true
SWEP.Category = "ArcCW - Horde"
SWEP.AdminOnly = false

SWEP.PrintName = "Five-seveN"

SWEP.Slot = 1

SWEP.ViewModel = "models/weapons/arccw_go/v_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/arccw_go/v_pist_fiveseven.mdl"

SWEP.Damage = 34
SWEP.DamageMin = 25
SWEP.Penetration = 10

SWEP.Recoil = 0.105
SWEP.RecoilSide = 0.075
SWEP.RecoilPunch = 0

SWEP.Delay = 60 / 700

SWEP.ShootVol = 75

SWEP.FirstShootSound = ")arccw_go/fiveseven/fiveseven_01.wav"
SWEP.ShootSound = ")arccw_go/fiveseven/fiveseven_01.wav"
SWEP.ShootSoundSilenced = {")arccw_go/usp/usp_01.wav",")arccw_go/usp/usp_02.wav",")arccw_go/usp/usp_03.wav"}
SWEP.DistantShootSound = ")arccw_go/fiveseven/fiveseven-1-distant.wav"

SWEP.MeleeSwingSound = "weapons/arccw/melee_lift.wav"
SWEP.MeleeMissSound = "weapons/arccw/melee_miss.wav"
SWEP.MeleeHitSound = "weapons/arccw/melee_hitworld.wav"
SWEP.MeleeHitNPCSound = "weapons/arccw/melee_hitbody.wav"

SWEP.ActivePos = Vector(0, 0, 0)
SWEP.ActiveAng = Angle(0, 0, 0)

function SWEP:Hook_TranslateAnimation(anim)
    if anim == "fire_iron" then
        if not self.Attachments[6].Installed then return "fire" end
    elseif anim == "fire_iron_empty" then
        if not self.Attachments[6].Installed then return "fire_empty" end
    elseif anim == "fire" then
        if self.Attachments[6].Installed then return "fire_iron" end
    elseif anim == "fire_empty" then
        if self.Attachments[6].Installed then return "fire_iron_empty" end
    end
end

function SWEP:DoShootSound(sndoverride, dsndoverride, voloverride, pitchoverride)
    local fsound = self.ShootSound
    local suppressed = self:GetBuff_Override("Silencer")

    if suppressed then
        fsound = self.ShootSoundSilenced
    end

    local firstsound = self.FirstShootSound

    if self:GetBurstCount() == 1 and firstsound then
        fsound = firstsound

        local firstsil = self.FirstShootSoundSilenced

        if suppressed then
            fsound = firstsil and firstsil or self.ShootSoundSilenced
        end
    end

    local lastsound = self.LastShootSound

    local clip = self:Clip1()

    if clip == 1 and lastsound then
        fsound = lastsound

        local lastsil = self.LastShootSoundSilenced

        if suppressed then
            fsound = lastsil and lastsil or self.ShootSoundSilenced
        end
    end

    fsound = self:GetBuff_Hook("Hook_GetShootSound", fsound)

    local distancesound = self.DistantShootSound

    if suppressed then
        distancesound = self.DistantShootSoundSilenced
    end

    distancesound = self:GetBuff_Hook("Hook_GetDistantShootSound", distancesound)

    local spv = self.ShootPitchVariation
    local volume = self.ShootVol
    local pitch  = self.ShootPitch * math.Rand(1 - spv, 1 + spv) * self:GetBuff_Mult("Mult_ShootPitch")

    local v = ArcCW.ConVars["weakensounds"]:GetFloat()

    volume = volume - v

    volume = volume * self:GetBuff_Mult("Mult_ShootVol")

    volume = math.Clamp(volume, 50, 140)
    pitch  = math.Clamp(pitch, 0, 255)

    if    sndoverride        then    fsound    = sndoverride end
    if    dsndoverride    then    distancesound = dsndoverride end
    if    voloverride        then    volume    = voloverride end
    if    pitchoverride    then    pitch    = pitchoverride end

    if distancesound then self:MyEmitSound(distancesound, 140, pitch, 0.25, CHAN_WEAPON) end

    if fsound then self:MyEmitSound(fsound, volume, pitch, 1, CHAN_STATIC) end

    local data = {
        sound   = fsound,
        volume  = volume,
        pitch   = pitch,
    }

    self:GetBuff_Hook("Hook_AddShootSound", data)
end
