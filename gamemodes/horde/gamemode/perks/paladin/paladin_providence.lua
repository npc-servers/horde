PERK.PrintName = "Providence"
PERK.Icon = "materials/perks/paladin/providence.png"
PERK.Description = [[
Divine Shield also protects everyone inside your Sacred Aura. 
Enemies hitting protected allies take Blunt damage.]]
PERK.Hooks = {}

if not SERVER then return end

local horde = HORDE
local horde_IsFireDamage = horde.IsFireDamage
local horde_IsColdDamage = horde.IsColdDamage
local horde_IsLightningDamage = horde.IsLightningDamage
local horde_IsPoisonDamage = horde.IsPoisonDamage
local horde_IsBlastDamage = horde.IsBlastDamage

local function isElementalDamage( dmginfo )
    if horde_IsFireDamage( horde, dmginfo ) then return true end
    if horde_IsColdDamage( horde, dmginfo ) then return true end
    if horde_IsLightningDamage( horde, dmginfo ) then return true end
    if horde_IsPoisonDamage( horde, dmginfo ) then return true end
    if horde_IsBlastDamage( horde, dmginfo ) then return true end -- May remove later

    return false
end

local function insideAura( ply, insideAuraPly )
    if ply == insideAuraPly then return false end

    local aura = ply.Horde_PaladinAura
    if not aura then return false end

    local entsInside = aura.Entities
    if not entsInside or not entsInside[insideAuraPly] then return false end

    return true
end

local function getProtectingPaladins( ply )
    local protectors = {}
    local players = player.GetAll()

    for i = 1, #players do
        local auraPly = players[i]
        if auraPly:Horde_GetPerk( "paladin_providence" ) and insideAura( auraPly, ply ) and auraPly.Horde_PaladinShielding then
            table.insert( protectors, auraPly )
        end
    end

    return protectors
end

local bluntReflect = DamageInfo()
local dmgType = DMG_CLUB

local function reflectDmg( protector, attacker, dmg )
    bluntReflect:SetDamageType( dmgType )
    bluntReflect:SetDamage( dmg )
    bluntReflect:SetAttacker( protector )
    bluntReflect:SetInflictor( protector )
    bluntReflect:SetDamagePosition( attacker:GetPos() )

    attacker:TakeDamageInfo( bluntReflect )
end

local maxFaith = 10
local elementalResist = 0.03
local physicalResist = 0.05

PERK.Hooks.Horde_OnPlayerDamageTaken = function( ply, dmginfo, bonus )
    local physicalDmg = HORDE:IsPhysicalDamage( dmginfo )
    if not ( physicalDmg or isElementalDamage( dmginfo ) ) then return end

    local attacker = dmginfo:GetAttacker()

    -- Prevent friendly fire
    if attacker:IsPlayer() and attacker ~= ply then return end

    local protectors = getProtectingPaladins( ply )
    if table.IsEmpty( protectors ) then return end

    -- Prevent stacking of paladin aura
    if ply:Horde_GetCurrentSubclass() == "Paladin" then
        for _, protector in ipairs( protectors ) do
            -- Multiple shielding paladins will be able to reflect the damage back but this can be changed
            if IsValid( attacker ) then
                reflectDmg( protector, attacker, dmginfo:GetDamage() )
            end
        end

        return
    end

    local faith = 0

    for _, protector in ipairs( protectors ) do
        -- Multiple shielding paladins will be able to reflect the damage back but this can be changed
        if IsValid( attacker ) then reflectDmg( protector, attacker, dmginfo:GetDamage() ) end

        if faith <= 0 and faith < 10 then
            local protectorFaith = protector:Horde_GetPaladinFaithStack()
            faith = math.min( maxFaith, faith + protectorFaith )

            if dmginfo:GetDamage() > 0 and protectorFaith > 0 then
                protectorFaith:Horde_RemovePaladinFaithStack()
            end
        end
    end

    local res = physicalDmg and faith * physicalResist or faith * elementalResist

    bonus.resistance = bonus.resistance + res
end

PERK.Hooks.Horde_OnPlayerDamageTakenPost = function( ply, dmginfo )
    local physicalDmg = HORDE:IsPhysicalDamage( dmginfo )
    if not ( physicalDmg or isElementalDamage( dmginfo ) ) then return end
    if dmginfo:GetDamage() <= 0 then return end
    if not IsValid( ply.Horde_HighestFaithProtector ) then return end

    ply.Horde_HighestFaithProtector:Horde_RemovePaladinFaithStack()
    ply.Horde_HighestFaithProtector = nil
end

local shieldBashDebuffRes = 0.5

PERK.Hooks.Horde_OnPlayerDebuffApply = function( ply, _, bonus )
    if ply:Horde_GetCurrentSubclass() == "Paladin" then return end

    local protectors = getProtectingPaladins( ply )
    if table.IsEmpty( protectors ) then return end

    local debuffRes = false

    for _, protector in ipairs( protectors ) do
        if protector:Horde_GetPerk( "paladin_shield_bash" ) then
            debuffRes = true

            break
        end
    end

    if debuffRes then
        bonus.less = bonus.less * shieldBashDebuffRes
    end
end