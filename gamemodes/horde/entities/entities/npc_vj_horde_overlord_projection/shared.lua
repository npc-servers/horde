ENT.Base         = "npc_vj_human_base"
ENT.Type         = "ai"
ENT.PrintName    = "Projection"
ENT.Author       = "DrVrej"
ENT.Contact      = "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose      = "Spawn it and fight with it!"
ENT.Instructions = "Click on the spawnicon to spawn it."
ENT.Category     = "Zombies"

if CLIENT then
    local name = "Projection"
    local langName = "npc_vj_horde_overlord_projection"

    language.Add( langName, name )
    killicon.Add( langName, "materials/perks/overlord/juxtapose.png", color_white )
end