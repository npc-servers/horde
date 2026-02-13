PERK.PrintName = "Providence"
PERK.Icon = "materials/perks/paladin/providence.png"
PERK.Description = [[
Your Divine Shield also protects everyone inside your Sacred Aura in the same way as you.
Additionally if enemies hit allies protected by your Divine Shield, they take Blunt damage.]]
PERK.Hooks = {}

local function isElementalDamage( dmginfo )
    if HORDE:IsFireDamage( dmginfo ) then return true end
    if HORDE:IsColdDamage( dmginfo ) then return true end
    if HORDE:IsLightningDamage( dmginfo ) then return true end
    if HORDE:IsPoisonDamage( dmginfo ) then return true end
    if HORDE:IsBlastDamage( dmginfo ) then return true end -- May remove later

    return false
end

local function insideAura( ply, insideAuraPly )
    local aura = ply.Horde_PaladinAura
    if not aura then return false end

    local entsInside = aura.Entities
    if not ( entsInside or entsInside[insideAuraPly] ) then return false end

    return true
end

local function getProtectingPaladins( ply )
    local protectors = {}
    for _, auraPly in ipairs( player.GetAll() ) do
        if insideAura( auraPly, ply ) and auraPly:Horde_GetPerk( "horde_providence" ) and auraPly.Horde_PaladinShielding then
            table.insert( protectors, auraPly )
        end
    end

    return protectors
end

local bluntReflect = DamageInfo()
bluntReflect:SetDamageType( DMG_CLUB )

local function reflectDmg( protector, attacker, dmg )
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

    local protectors = getProtectingPaladins( ply )
    local faith = 0
    local highestFaithProtector = nil
    local highestFaith = -1

    for _, protector in ipairs( protectors ) do
        local attacker = dmginfo:GetAttacker()
        if attacker then -- Multiple shielding paladins will be able to reflect the damage back
            reflectDmg( protector, attacker, dmginfo:GetDamage() )
        end

        if faith <= 0 then
            local protectorFaith = protector:Horde_GetPaladinFaithStack()
            faith = math.min( maxFaith, faith + protectorFaith )

            if protectorFaith > highestFaith then
                highestFaith = protectorFaith
                highestFaithProtector = protector
            end
        end

        ply.Horde_HighestFaithProtector = highestFaithProtector

        if faith >= 10 then
            break
        end
    end

    local res = physicalDmg and faith * physicalResist or elementalResist

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
    local protectors = getProtectingPaladins( ply )

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