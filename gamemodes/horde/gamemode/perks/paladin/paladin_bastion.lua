PERK.PrintName = "Bastion"
PERK.Icon = "materials/perks/paladin/bastion.png"
PERK.Description = "100% of your healing provides extra Armor to you or other players."
PERK.Hooks = {}

if not SERVER then return end

PERK.Hooks.Horde_PostOnPlayerHeal = function( ply, healinfo )
    local healer = healinfo.healer
    if not IsValid( healer ) then return end
    if not healer:Horde_GetPerk( "paladin_bastion" ) then return end

    if ply ~= healer then
        local aura = healer.Horde_PaladinAura
        if not IsValid( aura ) then return end

        local entities = aura.Entities
        if not entities or not entities[ent] then return end
    end

    local armor = ply:Armor()
    local maxArmor = ply:GetMaxArmor()

    if armor == maxArmor then return end
    ply:SetArmor( math.Min( maxArmor, armor + healinfo.amount ) )
end