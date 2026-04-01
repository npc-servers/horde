ENT.Base 			= "npc_vj_human_base"
ENT.Type 			= "ai"
ENT.PrintName 		= "Barney Calhoun"
ENT.Author 			= "DrVrej"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Category		= "Zombies"

if ( CLIENT ) then
    local Name = "Barney Calhoun"
    local LangName = "npc_vj_april1_horde_barney"
    language.Add( LangName, Name )
    killicon.Add( LangName, "HUD/killicons/default", Color( 255, 80, 0, 255 ) )
    language.Add( "#" .. LangName, Name )
    killicon.Add( "#" .. LangName, "HUD/killicons/default", Color( 255, 80, 0, 255 ) )
end