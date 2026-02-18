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

function plymeta:Horde_AddHealAmount( amount )
    if HORDE.current_wave <= 0 then return end
    if amount < 0 then return end

    local class_name = self:Horde_GetCurrentSubclass()
    if self:Horde_GetLevel( class_name ) >= HORDE.max_level then return end

    local percentage = 0.25

    self:Horde_GiveExp( class_name, percentage * amount, "Healed Player" )
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
        local heal_mult = 1
        local curr_weapon = HORDE:GetCurrentWeapon( healer )

        if curr_weapon and curr_weapon:IsValid() and ply.Horde_Infusions then
            local infusion = ply.Horde_Infusions[curr_weapon:GetClass()]

            if infusion and infusion == HORDE.Infusion_Rejuvenating then
                heal_mult = 1.25
            end
        end

        if healer ~= ply and not HORDE:InBreak() then
            if not ply:Horde_GetPerk( "psycho_base" ) then
                healer:Horde_AddMoney( math.min( healAmount * 0.75 ) )
                healer:Horde_SyncEconomy()
            end

            net.Start( "Horde_RenderHealer" )
                net.WriteString( healer:GetName() )
            net.Send( ply )

            healer:Horde_AddHealAmount( healAmount )
        end

        ply:SetHealth( math.min( maxHealth, health + heal_mult * healAmount ) )
    else
        ply:SetHealth( math.min( maxHealth, health + healAmount ) )

        return
    end

    if not HORDE.player_heal[healer:SteamID()] then HORDE.player_heal[healer:SteamID()] = 0 end

    if healer:SteamID() ~= ply:SteamID() then
        HORDE.player_heal[healer:SteamID()] = HORDE.player_heal[healer:SteamID()] + healAmount
    end

    if silent then
        healer:Horde_AddHealAmount( healAmount )

        return
    end

    if ply:GetInfoNum( "horde_heal_flash", 1 ) == 1 then
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
