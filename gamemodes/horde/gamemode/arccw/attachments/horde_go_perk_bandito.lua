if not ArcCWInstalled then return end

AddCSLuaFile()

local att = {}

att.PrintName = "Bandito"
att.Icon = Material("entities/acwatt_go_perk_cowboy.png", "mips smooth")
att.Description = "show off your inner pistolero at the cost of extra recoil, but hey atleast you look cool, lets you shoot while sprinting"
att.Desc_Pros = {}
att.Desc_Cons = {}
att.AutoStats = true
att.Slot = "go_perk_smg"

att.Override_ShootWhileSprint = true
att.Mult_Recoil = 1.25
att.LHIK = true
att.LHIKHide = true

att.Hook_ShouldNotSight = function(wep)
    local notSprinting

    if  wep:GetState() == ArcCW.STATE_SPRINT then
        notSprinting = true
    elseif wep:GetState() ~= ArcCW.STATE_SPRINT then
        notSprinting = false
    end
    return notSprinting
end

ArcCW.LoadAttachmentType(att, "horde_go_perk_bandito")