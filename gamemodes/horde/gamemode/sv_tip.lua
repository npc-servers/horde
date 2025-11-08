util.AddNetworkString("Horde_SyncTip")

HORDE.tips = {}
local order = nil

local function shuffle(tbl)
    for i = #tbl, 2, -1 do
      local j = math.random(i)
      tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
  end

function HORDE:GetTip()
    if table.IsEmpty(HORDE.tips) then return nil end
    if not order then
        order = math.random(1, table.Count(HORDE.tips))
    else
        order = (order + 1) % table.Count(HORDE.tips) + 1
    end

    return HORDE.tips[order]
end

local function AddTip(tip)
    table.insert(HORDE.tips, tip)
end

local function GetTipsData()
    if not file.IsDir("horde", "DATA") then
        file.CreateDir("horde")
    end

    if file.Read("horde/tips.txt", "DATA") then
        local f = file.Open("horde/tips.txt", "r", "DATA")
        while (not f:EndOfFile()) do
            table.insert(HORDE.tips, f:ReadLine())
        end
    end

    if table.IsEmpty(HORDE.tips) then
        AddTip("An elite enemy's health scales with player counts.")
        AddTip("Share money with your teammates by pressing V.")
        AddTip("Perks are unlocked as waves progress.")
        AddTip("You can revive downed players with your medkit.")
        AddTip("You can only change class once per wave.")
        AddTip("Remember to refill ammo.")
        AddTip("Remember to heal yourself.")
        AddTip("Mutated enemies have special particle effects.")
        AddTip("Headshots deal 2x base damage.")


        if GetConVar("horde_default_item_config"):GetInt() == 1 and GetConVar("horde_external_lua_config"):GetString() == "" then
            AddTip("Buy a Medkit to heal yourself.")
            AddTip("Buy Armor for extra protection.")
            AddTip("Medic Grenade damages enemies and heals players.")
            AddTip("The Barrett M99 has the highest single-shot damage.")
            AddTip("The M-134D has a short delay before firing.")
            AddTip("The RPG-7 has the largest blast radius.")
            AddTip("LAW deals higher damage than the RPG, but has a smaller blast radius.")
            AddTip("Turrets can be used to distract enemies.")
            AddTip("The SSG08 Medic Rifle can heal temmates from afar.")
            AddTip("Stun Grenade can paralyze enemies for a short time.")
        end

        if GetConVar("horde_default_enemy_config"):GetInt() == 1 and GetConVar("horde_external_lua_config"):GetString() == "" then
            AddTip("Exploder's head has little health.")
            AddTip("Exploders do not explode when killed on headshots.")
            AddTip("Bosses have increased headshot resistance.")
            AddTip("Some enemies have additional mutations.")
            AddTip("Screecher's shockwave deals Lightning damage.")
            AddTip("Screecher's shockwave increases Shock buildup.")
            AddTip("Weeper's shockwave deals Cold damage.")
            AddTip("Weeper's shockwave increases Frostbite buildup.")
            AddTip("Yeti's frost cloud deals Cold damage.")
            AddTip("Yetis release frost clouds when on half health.")
            AddTip("Hulks will increase movement speed at half health.")
            AddTip("Hulks and Yetis are slowed when set on fire.")
            AddTip("Zombines will self-destruct on low health.")
            AddTip("Vomitter's spit deals Slashing damage.")
            AddTip("Vomitter's spit increases Bleeding buildup.")
            AddTip("Burning enemies can increase Ignite buildup when they hit you.")
            AddTip("Lesions will calm down after damaging a player.")
            AddTip("Lesions will enrage after taking enough damage.")
            AddTip("Lesions will enrage when left alone for too long.")
            AddTip("Poison Zombies can throw goo that inflcts Break..")
            AddTip("Plague Elite can resummon his minions.")
            AddTip("Plague Elite can fire particle projectiles that deal lethal damage.")
            AddTip("Scorchers can use a flame attack at close range.")
        end

        if GetConVar("horde_default_class_config"):GetInt() == 1 then
            AddTip("ASSAULT specializes in automatic weapons.")
            AddTip("ADRENALINE increases speed and damage per stack.")
            AddTip("HEAVY specializes in heavy machine guns.")
            AddTip("HEAVY regenerates armor automatically.")
            AddTip("GHOST specializes in snipers and magnums.")
            AddTip("GHOST can deal huge amounts of headshot damage.")
            AddTip("CAMOUFLAGE grants various benefits while active.")
            AddTip("DEMOLITION specializes in explosive damage.")
            AddTip("DEMOLITION has innate Blast damage resistance.")
            AddTip("BERSERKER specializes in melee combat.")
            AddTip("BERSERKER has increased damage resistance.")
            AddTip("ENGINEER specializes in buildings and minions.")
            AddTip("MEDIC specializes in healing and buffing players.")
            AddTip("MEDIC regenerates health automatically.")
            AddTip("CREMATOR specializes in fire damage.")
            AddTip("CREMATOR has innate Fire damage resistance.")
            AddTip("WARDEN specializes in buff auras and watchtowers.")
            AddTip("WARDEN's aura affects nearby players.")
            AddTip("SURVIVOR perks are a combination of other classes.")
            AddTip("SURVIVOR has the largest weapon pool.")
            AddTip("Choose your Perks depending on your playstyle.")
        end

        AddTip("Fire damage increases Ignite buildup.")
        AddTip("Ignite debuff obscures your vision and drains your health")
        AddTip("Cold damage increases Frosbite buildup.")
        AddTip("Frostbite debuff reduces your movement speed.")
        AddTip("Lightning damage increases Shock buildup.")
        AddTip("Shock debuff increases damage taken by all sources.")
        AddTip("Poison damage increases Break buildup.")
        AddTip("Break edebuff temporarily drops your health to critical.")
        AddTip("Certain enemies and mutations can increase your Bleeding buildup.")
        AddTip("Bleeding debuff drains your health over time.")
        AddTip("Certain enemies and mutations can increase your Decay buildup.")
        AddTip("Decay effect blocks all health recovery.")
        AddTip("Necrosis will instantly down you.")
    end

    HORDE.tips = shuffle(HORDE.tips)
end

GetTipsData()
