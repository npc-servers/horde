ENT.Base = "npc_vj_creature_base"
ENT.Type = "ai"
ENT.PrintName = "SMG Turret"
ENT.Author = "Alex9914"
ENT.Contact = "https://discord.gg/npc"
ENT.Purpose = "Defends a area"
ENT.Instructions = "Spawn it and let it defend"
ENT.Category = "Horde"

if ( CLIENT ) then
    local Name = "SMG Turret"
    local LangName = "npc_vj_horde_smg_turret"
    language.Add( LangName, Name )
    killicon.Add( LangName, "vgui/hud/npc_turret_floor", Color( 255, 80, 0 ) )
    language.Add( "#" .. LangName, Name )
    killicon.Add( "#" .. LangName, "vgui/hud/npc_turret_floor", Color( 255, 80, 0 ) )
end