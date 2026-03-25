att.PrintName = "Extended Magazine"
att.Icon = Material( "arccw/hud/atts/default.png", "mips smooth" )
att.Description = "Extra bullets for your magazine!"
att.Desc_Pros = {}
att.Desc_Cons = {}
att.Slot = "horde_bo_ammo"
att.AutoStats = true

att.MagExtender = true

att.Mult_MoveSpeed = 0.95
att.Mult_SightTime = 1.1

att.ActivateElements = { "ext_mag" }

att.Hook_SelectReloadAnimation = function( wep, anim )
    if anim == "reload" then return "reload_ext"
    elseif anim == "reload_empty" then return "reload_ext_empty" end
end

ArcCW.LoadAttachmentType( att, "horde_bo_extended_mag" )