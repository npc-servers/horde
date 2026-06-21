if not ArcCWInstalled then return end

AddCSLuaFile()

local att = {}

att.PrintName = "Extended Magazine"
att.Icon = Material( "entities/acwatt_go_ak_mag_40.png", "mips smooth" )
att.Description = "Magazine with high ammo capacity."
att.Desc_Pros = {}
att.Desc_Cons = {}
att.Slot = "horde_bo_ammo"
att.AutoStats = true

att.MagExtender = true

att.Mult_MoveSpeed = 0.95
att.Mult_SightTime = 1.1

att.ActivateElements = { "ext_mag" }

att.Hook_SelectReloadAnimation = function( _, anim )
    if anim == "reload" then return "reload_ext"
    elseif anim == "reload_empty" then return "reload_ext_empty" end
end

ArcCW.LoadAttachmentType( att, "horde_bo_extended_mag" )