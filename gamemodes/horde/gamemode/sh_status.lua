-- Status Mapping
-- Please use the variable names instead of the values!

if SERVER then
util.AddNetworkString("Horde_SyncActivePerk")
end

HORDE.Status_Icon = {}
HORDE.Status_Id = 0
HORDE.Is_Status_Stackable = {}
HORDE.Is_Status_Debuff = {}
HORDE.Is_Status_Skill = {}
HORDE.Status_String = {}

function HORDE:RegisterStatus(name, icon, stackable, is_debuff, is_skill)
    if HORDE.Status_Id >= 256 then
        Error("[HORDE] Ran out of status ids!")
        return
    end
    local s = "Status_" .. name
    HORDE[s] = HORDE.Status_Id
    HORDE.Status_Icon[HORDE.Status_Id] = icon
    if stackable and stackable == true then
        HORDE.Is_Status_Stackable[HORDE.Status_Id] = true
    end
    if is_debuff and is_debuff == true then
        HORDE.Is_Status_Debuff[HORDE.Status_Id] = true
    end
    if is_skill and is_skill == true then
        HORDE.Is_Status_Skill[HORDE.Status_Id] = true
    end
    HORDE.Status_String[HORDE.Status_Id] = name
    HORDE.Status_Id = HORDE.Status_Id + 1
end

HORDE:RegisterStatus("CanBuy", "materials/status/canbuy.png")
HORDE:RegisterStatus("CanEscape", "materials/status/escape.png")
HORDE:RegisterStatus("CanHold", "materials/status/hold.png")
HORDE:RegisterStatus("HasPayload", "materials/status/objective.png")
HORDE:RegisterStatus("AntimatterShield", "materials/perks/antimatter_shield.png", nil, nil, true)
HORDE:RegisterStatus("Displacer", "materials/perks/displacer.png", nil, nil, true)
HORDE:RegisterStatus("Quickstep", "materials/abilities/quickstep.png", nil, nil, true)
HORDE:RegisterStatus("Hunter_Mark", "materials/status/hunter_mark.png", nil, nil, true)
HORDE:RegisterStatus("Smokescreen", "materials/perks/specops/smokescreen.png", nil, nil, true)
HORDE:RegisterStatus("Flare", "materials/perks/specops/flare.png", nil, nil, true)
HORDE:RegisterStatus("AAS_Perfume", "materials/perks/carcass/AAS_Perfume.png", nil, nil, true)
HORDE:RegisterStatus("DarkEnergyBlast", "materials/perks/overlord/dark_energy_blast.png", nil, nil, true)
HORDE:RegisterStatus("Juxtapose", "materials/perks/overlord/juxtapose.png", nil, nil, true)
HORDE:RegisterStatus("DarkEnergyBlast", "materials/perks/overlord/dark_energy_blast.png", nil, nil, true)

HORDE:RegisterStatus("Tactical_Mode", "materials/status/tactical_mode.png")
HORDE:RegisterStatus("Camoflague", "materials/status/camoflague.png")
HORDE:RegisterStatus("Frenzy_Mode", "materials/subclasses/psycho.png")

HORDE:RegisterStatus("Minion", "materials/status/minion.png", true)
HORDE:RegisterStatus("Adrenaline", "materials/status/adrenaline.png", true)
HORDE:RegisterStatus("Headhunter", "materials/perks/headhunter.png", true)
HORDE:RegisterStatus("Deadeye", "materials/perks/gunslinger/deadeye.png", true)
--HORDE:RegisterStatus("Barrier", "materials/status/barrier.png", true)
HORDE:RegisterStatus("Intensity", "materials/perks/artificer/intensity.png", true)
HORDE:RegisterStatus("Neuron_Stabilizer", "materials/perks/specops/neuron_stabilizer.png", true)
HORDE:RegisterStatus("Phalanx", "materials/perks/phalanx.png", true)
HORDE:RegisterStatus("Brutality", "materials/perks/psycho/brutality.png", true)
HORDE:RegisterStatus("Hypertrophy", "materials/status/hypertrophy.png", true)
HORDE:RegisterStatus("SolarFlux", "materials/perks/artificer/solar_flux.png", true)
HORDE:RegisterStatus("Bio_Thruster", "materials/perks/carcass/bio_thruster.png", true)
HORDE:RegisterStatus("Twin_Heart", "materials/perks/carcass/twin_heart.png", true)
HORDE:RegisterStatus("Hysteria", "materials/perks/overlord/despair.png", true)

HORDE:RegisterStatus("Fortify", "materials/perks/fortify.png")
HORDE:RegisterStatus("Berserk", "materials/perks/berserk.png")
HORDE:RegisterStatus("Haste", "materials/perks/haste.png")
HORDE:RegisterStatus("Sandcloak", "materials/perks/hatcher/sand_cloak.png")
HORDE:RegisterStatus("VileBlood", "materials/perks/hatcher/vile_blood.png")
HORDE:RegisterStatus("FleshEater", "materials/perks/hatcher/flesh_eater.png")
HORDE:RegisterStatus("SigilArcana", "materials/spells/sigil_of_arcana.png")
HORDE:RegisterStatus("SigilAlacrity", "materials/spells/sigil_of_alacrity.png")
HORDE:RegisterStatus("Enlighten", "materials/spells/enlighten.png")
HORDE:RegisterStatus("ArmorRegen", "materials/status/armorregen.png")
HORDE:RegisterStatus("HealthRegen", "materials/status/healthregen.png")
HORDE:RegisterStatus("Quickdraw", "materials/perks/gunslinger/quickdraw.png")
HORDE:RegisterStatus("WardenAura", "materials/warden.png")
HORDE:RegisterStatus("ReactiveArmor", "materials/perks/reactive_armor.png")
HORDE:RegisterStatus("EntropyShield", "materials/perks/entropy_shield.png")
HORDE:RegisterStatus("EldritchShield", "materials/perks/eldritch_shield.png")
HORDE:RegisterStatus("Tactical_Spleen", "materials/perks/carcass/tactical_spleen.png")
HORDE:RegisterStatus("Foresight", "materials/perks/samurai/foresight.png")
HORDE:RegisterStatus("Smuggle", "materials/perks/gunslinger/smuggle_shop.png")
HORDE:RegisterStatus("Phantom_Reload", "materials/perks/gunslinger/phantom_reload.png")
HORDE:RegisterStatus("Smokescreen_Effect", "materials/perks/specops/smokescreen.png")
HORDE:RegisterStatus("Unwavering_Guard", "materials/perks/unwavering_guard.png")
HORDE:RegisterStatus("Damage_Shard", "materials/status/damage.png")
HORDE:RegisterStatus("Agility_Shard", "materials/status/speed.png")
HORDE:RegisterStatus("Assassin_Optics", "materials/status/gadget/assassin_optics.png")
HORDE:RegisterStatus("Aegis", "materials/status/gadget/aegis.png")
-- Paladin
HORDE:RegisterStatus("PaladinAura", "materials/subclasses/paladin.png")
HORDE:RegisterStatus("PaladinFaith", "materials/subclasses/paladin.png", true)
HORDE:RegisterStatus("PaladinShieldBash", "materials/perks/paladin/shield_bash.png", nil, nil, true)
HORDE:RegisterStatus("PaladinSmite", "materials/perks/paladin/smite.png", nil, nil, true)
HORDE:RegisterStatus("PaladinEmpowered", "materials/status/paladin/empowered.png")

HORDE:RegisterStatus("Armor_Survivor", "items/armor_survivor.png")
HORDE:RegisterStatus("Armor_Assault", "items/armor_assault.png")
HORDE:RegisterStatus("Armor_Heavy", "items/armor_heavy.png")
HORDE:RegisterStatus("Armor_Demolition", "items/armor_demolition.png")
HORDE:RegisterStatus("Armor_Ghost", "items/armor_ghost.png")
HORDE:RegisterStatus("Armor_Medic", "items/armor_medic.png")
HORDE:RegisterStatus("Armor_Engineer", "items/armor_engineer.png")
HORDE:RegisterStatus("Armor_Warden", "items/armor_warden.png")
HORDE:RegisterStatus("Armor_Cremator", "items/armor_cremator.png")
HORDE:RegisterStatus("Armor_Berserker", "items/armor_berserker.png")

HORDE:RegisterStatus("ExpDisabled", "materials/status/exp_disabled.png")
HORDE:RegisterStatus("Bleeding", "materials/status/bleeding.png", nil, true)
HORDE:RegisterStatus("Ignite", "materials/status/ignite.png", nil, true)
HORDE:RegisterStatus("Frostbite", "materials/status/frostbite.png", nil, true)
HORDE:RegisterStatus("Shock", "materials/status/shock.png", nil, true)
HORDE:RegisterStatus("Break", "materials/status/break.png", nil, true)
HORDE:RegisterStatus("Decay", "materials/status/decay.png", nil, true)
HORDE:RegisterStatus("Necrosis", "materials/status/necrosis.png", nil, true)
HORDE:RegisterStatus("Psychosis", "materials/status/psychosis.png", nil, true)
HORDE:RegisterStatus("Stun", "materials/perks/knockout.png", nil, true)
HORDE:RegisterStatus("Freeze", "materials/status/frostbite.png", nil, true)
HORDE:RegisterStatus("Weaken", "materials/perks/crude_casing.png", nil, true)
HORDE:RegisterStatus("Hinder", "materials/perks/sticky_compound.png", nil, true)
HORDE:RegisterStatus("Hemorrhage", "materials/status/hemorrhage.png", nil, true)
HORDE:RegisterStatus("Fear", "materials/status/fear.png", nil, true)

HORDE.Status_Buildup_Sounds = {}
HORDE.Status_Buildup_Sounds[HORDE.Status_Bleeding] = "horde/status/bleeding_buildup.ogg"
--HORDE.Status_Buildup_Sounds[HORDE.Status_Ignite] = "player/general/flesh_burn.wav"
HORDE.Status_Buildup_Sounds[HORDE.Status_Frostbite] = "horde/status/frostbite_buildup.ogg"
HORDE.Status_Buildup_Sounds[HORDE.Status_Shock] = "weapons/stunstick/stunstick_fleshhit2.wav"
HORDE.Status_Buildup_Sounds[HORDE.Status_Break] = "ambient/levels/canals/toxic_slime_sizzle1.wav"
HORDE.Status_Buildup_Sounds[HORDE.Status_Necrosis] = "horde/status/necrosis_buildup.ogg"

HORDE.Status_Trigger_Sounds = {}
HORDE.Status_Trigger_Sounds[HORDE.Status_Bleeding] = "horde/status/bleeding_trigger.ogg"
--HORDE.Status_Trigger_Sounds[HORDE.Status_Ignite] = "ambient/fire/fire_small1.wav"
HORDE.Status_Trigger_Sounds[HORDE.Status_Frostbite] = "horde/status/frostbite_trigger.ogg"
HORDE.Status_Trigger_Sounds[HORDE.Status_Shock] = "horde/status/shock_trigger.ogg"
HORDE.Status_Trigger_Sounds[HORDE.Status_Break] = "horde/status/break_trigger.ogg"
HORDE.Status_Trigger_Sounds[HORDE.Status_Necrosis] = "horde/status/necrosis_trigger.ogg"

HORDE.Debuff_Notifications = {
    [HORDE.Status_Bleeding] = "You are Bleeding.\nYour health will slowly drain.",
    [HORDE.Status_Ignite] = "You are on fire!",
    [HORDE.Status_Frostbite] = "You've been afflicted with Frostbite.\nYour movement speed is greatly reduced.",
    [HORDE.Status_Shock] = "You've been afflicted with Shock.\nYou'll take increased damage from all sources.",
    [HORDE.Status_Break] = "You've been afflicted with Break.\nYour health is temporarily critical.",
    [HORDE.Status_Decay] = "You've been afflicted with Decay.\nYou cannot heal.",
    [HORDE.Status_Psychosis] = "Y'ai 'ng'ngah, Yog-Sothoth h'ee - l'geb f'ai throdog uaaah.",
    [HORDE.Status_Necrosis] = "You are dying from Necrosis."
}

local plymeta = FindMetaTable("Player")
function plymeta:Horde_SyncStatus(status, stack)
    net.Start("Horde_SyncStatus")
        net.WriteUInt(status, 8)
        net.WriteUInt(stack, 8)
    net.Send(self)
end

function HORDE:IsStatusStackable(status)
    return HORDE.Is_Status_Stackable[status]
end

function HORDE:IsDebuff(status)
    return HORDE.Is_Status_Debuff[status]
end

function HORDE:IsSkillStatus(status)
    return HORDE.Is_Status_Skill[status]
end

function HORDE:IsStackableSkillStatus(status)
    if status == HORDE.Status_Quickstep then return true end
end
