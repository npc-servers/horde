PERK.PrintName = "Burning Passion"
PERK.Icon = "materials/perks/paladin/burning_passion.png"
PERK.Description = [[
Healing players gives "Burning Passion" buff for 10 seconds.
Buffed players set enemies on fire by dealing damage.
Base Fire damage over time is 10.]]
PERK.Hooks = {}

if not SERVER then return end

PERK.Hooks.Horde_OnPlayerHeal = function( ply, healinfo )
    local healer = healinfo:GetHealer()
    if healer:IsPlayer() and healer:Horde_GetPerk( "paladin_burning_passion" ) then
        ply:Horde_AddPassion( 10 )
    end
end