--Horde's healing framework
-- Healing is affected by skill bonuses and is logged.
util.AddNetworkString( "Horde_RenderHealer" )

HealInfo = {}
HealInfo.__index = HealInfo

function HealInfo:New( o )
    o = o or {}
    setmetatable( o, self )
    self.__index = self

    return o
end

function HealInfo:SetHealAmount( amount )
    self.amount = amount
end

function HealInfo:GetHealAmount()
    return self.amount or 0
end

function HealInfo:SetHealer( healer )
    self.healer = healer
end

function HealInfo:GetHealer()
    return self.healer
end

function HealInfo:SetOverHealPercentage( percentage )
    self.over_heal_percentage = percentage
end

function HealInfo:GetOverHealPercentage()
    return self.over_heal_percentage or 0
end

local plymeta = FindMetaTable( "Player" )

local expMultiConvar = GetConVar( "horde_experience_multiplier" )
local startXpMult = HORDE.Difficulty[HORDE.CurrentDifficulty].xpMultiStart
local endXpMult = HORDE.Difficulty[HORDE.CurrentDifficulty].xpMultiEnd
local endMinusStartXp = endXpMult - startXpMult
local maxLevel = HORDE.max_level
local healXpPercentage = 0.25
local armorXpPercentage = 0.25

function plymeta:Horde_AddHealAmount( amount )
    if HORDE.current_wave <= 0 then return end
    if amount < 0 then return end

    local subclass = self:Horde_GetCurrentSubclass()
    if self:Horde_GetLevel( subclass ) >= maxLevel then return end

    local wavePercent = HORDE.current_wave / HORDE.max_waves
    local roundXpMult = startXpMult + ( wavePercent * endMinusStartXp ) -- This gets the xp multi number between min and max multi based on round
    local expMult = roundXpMult * expMultiConvar:GetInt()

    self:Horde_GiveExp( subclass, healXpPercentage * amount * expMult, "Healed Player" )
end

-- Call this if you want Horde to recognize your healing
function HORDE:OnPlayerHeal( ply, healinfo, silent )
    if ply.Horde_Debuff_Active and ply.Horde_Debuff_Active[HORDE.Status_Decay] then return end
    if not ply:IsPlayer() then return end
    if not ply:Alive() then return end

    hook.Run( "Horde_OnPlayerHeal", ply, healinfo )
    hook.Run( "Horde_PostOnPlayerHeal", ply, healinfo )

    local health = ply:Health()
    local maxHealth = ply:GetMaxHealth() * ( 1 + healinfo:GetOverHealPercentage() )

    if health >= maxHealth then return end

    local healer = healinfo:GetHealer()
    local healAmount = healinfo:GetHealAmount()

    if healer:IsPlayer() and healer:IsValid() then
        local healMult = 1
        local healingApplied = 0
        local currWeapon = HORDE:GetCurrentWeapon( healer )

        if IsValid( currWeapon ) and ply.Horde_Infusions then
            local infusion = ply.Horde_Infusions[currWeapon:GetClass()]

            if infusion and infusion == HORDE.Infusion_Rejuvenating then
                healMult = 1.25
            end
        end

        healingApplied = math.min( maxHealth, health + healMult * healAmount ) - health

        if healer ~= ply and not HORDE:InBreak() then
            if not ply:Horde_GetPerk( "psycho_base" ) then
                healer:Horde_AddMoney( math.min( healingApplied * 0.75 ) )
                healer:Horde_SyncEconomy()
            end

            net.Start( "Horde_RenderHealer" )
                net.WriteString( healer:GetName() )
            net.Send( ply )

            HORDE.player_heal[healer:SteamID()] = ( HORDE.player_heal[healer:SteamID()] or 0 ) + healingApplied
            healer:Horde_AddHealAmount( healingApplied )
        end

        ply:SetHealth( math.min( maxHealth, health + healMult * healAmount ) )
    else
        ply:SetHealth( math.min( maxHealth, health + healAmount ) )

        return
    end

    if not silent and ply:GetInfoNum( "horde_heal_flash", 1 ) == 1 then
        ply:ScreenFade( SCREENFADE.IN, Color( 50, 200, 50, 5 ), 0.15, 0 )
    end
end

function HORDE:OnAntlionHeal( npc, healinfo )
    hook.Run( "Horde_OnAntlionHeal", npc, healinfo )

    npc:Horde_Evolve( healinfo:GetHealAmount() * 1.5 )
    npc:SetHealth( math.min( npc:GetMaxHealth() * ( 1 + healinfo:GetOverHealPercentage() ), npc:Health() + healinfo:GetHealAmount() ) )
end

function HORDE:SelfHeal( ply, amount )
    if amount <= 0 then return end

    local healinfo = HealInfo:New( { amount = amount, healer = ply } )
    HORDE:OnPlayerHeal( ply, healinfo )
end

local function armorerDoGiveXp( armorer, armorGiven )
    if armorGiven < 0 then return end

    if not IsValid( armorer ) then return end
    if not armorer:IsPlayer() then return end

    if HORDE.current_wave <= 0 then return end
    if HORDE:InBreak() then return end

    local subclass = armorer:Horde_GetCurrentSubclass()
    if armorer:Horde_GetLevel( subclass ) >= maxLevel then return end

    local wavePercent = HORDE.current_wave / HORDE.max_waves
    local roundXpMult = startXpMult + wavePercent * endMinusStartXp
    local expMult = roundXpMult * expMultiConvar:GetInt()

    armorer:Horde_GiveExp( subclass, armorXpPercentage * armorGiven * expMult, "Provided Armor" )
end

function plymeta:Horde_GiveArmor( armorAmount, armorer )
    if not self:Alive() then return end

    local armor = self:Armor()
    local maxArmor = self:GetMaxArmor()

    if armor >= maxArmor then return end

    local armorGiven = math.min( maxArmor, armor + armorAmount )
    local armorDiff = armorGiven - armorAmount

    if armorer ~= self then
        armorerDoGiveXp( armorer, armorDiff )
    end

    self:SetArmor( armorGiven )
end