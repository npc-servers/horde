AddCSLuaFile("shared.lua")
include('shared.lua')
ENT.Model = {"models/zombie/zombiecop.mdl"} -- The game will pick a random model from the table when the SNPC is spawned | Add as many as you want
ENT.StartHealth = 85
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.BloodColor = "Red" -- The blood type, this will determine what it should use (decal, particle, etc.)
ENT.HasMeleeAttack = true -- Should the SNPC have a melee attack?
ENT.AnimTbl_MeleeAttack = {"vjseq_fastattack"} -- Melee Attack Animations
ENT.MeleeAttackDistance = 40 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 60 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.3 -- This counted in seconds | This calculates the time until it hits something
ENT.MeleeAttackDamage = 15
ENT.FootStepTimeRun = 0.5 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 1 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true -- Set to true to use the extra melee attack sounds
ENT.HasEntitiesToNoCollide = true -- If set to false, it won't run the EntitiesToNoCollide code
ENT.MeleeAttackDamageType = DMG_SLASH -- Type of Damage
ENT.EntitiesToNoCollide = {"npc_manhack"}
	-- ====== Flinching Code ====== --
ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 1
ENT.AnimTbl_Flinch = {"vjges_flinch1","vjges_flinch2","vjges_flinch3"}
	-- ====== Sound File Paths ====== --
-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FootStep = {"npc/xzombie/foot1.wav","npc/xzombie/foot2.wav","npc/xzombie/foot3.wav"}
ENT.SoundTbl_Idle = {"npc/xzombie/zombie_voice_idle1.wav","npc/xzombie/zombie_voice_idle2.wav","npc/xzombie/zombie_voice_idle3.wav","npc/xzombie/zombie_voice_idle4.wav","npc/xzombie/zombie_voice_idle5.wav","npc/xzombie/zombie_voice_idle6.wav","npc/xzombie/zombie_voice_idle7.wav","npc/xzombie/zombie_voice_idle8.wav","npc/xzombie/zombie_voice_idle10.wav"}
ENT.SoundTbl_Alert = {"npc/xzombie/zombie_alert1.wav","npc/xzombie/zombie_alert2.wav","npc/xzombie/zombie_alert3.wav"}
ENT.SoundTbl_BeforeMeleeAttack = {"npc/xzombie/zo_attack1.wav","npc/xzombie/zo_attack2.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"zsszombie/miss1.wav","zsszombie/miss2.wav","zsszombie/miss3.wav","zsszombie/miss4.wav"}
ENT.SoundTbl_Pain = {"npc/xzombie/zombie_pain1.wav","npc/xzombie/zombie_pain2.wav","npc/xzombie/zombie_pain3.wav","npc/xzombie/zombie_pain4.wav"}
ENT.SoundTbl_Death = {"npc/xzombie/zombie_die1.wav","npc/xzombie/zombie_die2.wav","npc/xzombie/zombie_die3.wav"}
ENT.Manhack = NULL
ENT.ManhackPullT = 0
ENT.hasmanhack = false
ENT.canhavemanhack = true
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self:SetBodygroup(1,1)
	self.ManhackPullT = 1
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnFlinch_BeforeFlinch(dmginfo, hitgroup)
	if hitgroup == HITGROUP_LEFTARM && not IsValid(self.Manhack) then
		self.AnimTbl_Flinch = {"vjseq_flinch_leftarm"}
	elseif hitgroup == HITGROUP_RIGHTARM && not IsValid(self.Manhack) then
		self.AnimTbl_Flinch = {"vjseq_flinch_rightarm"}
	elseif hitgroup == HITGROUP_LEFTLEG then
		self.AnimTbl_Flinch = {"vjseq_flinch_leftleg"}
	elseif hitgroup == HITGROUP_RIGHTLEG then
		self.AnimTbl_Flinch = {"vjseq_flinch_rightleg"}
	elseif hitgroup == HITGROUP_HEAD && not IsValid(self.Manhack)  then
		self.AnimTbl_Flinch = {"vjseq_flinch_head"}
	elseif IsValid(self.Manhack) && hitgroup ~= HITGROUP_LEFTLEG and hitgroup ~= HITGROUP_RIGHTLEG then
		self.AnimTbl_Flinch = {"vjges_flinch_grenade_east","vjges_flinch_grenade_west","vjges_flinch_grenade_back","vjges_flinch_grenade_front"}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self.canhavemanhack && CurTime() > self.ManhackPullT && IsValid(self) && IsValid(self:GetEnemy()) && not IsValid(self.Manhack) && self.NearestPointToEnemyDistance < 200 && self.hasmanhack == false then
		self:VJ_ACT_PLAYACTIVITY("pullgrenade",true,1,true)
		self.Manhack = ents.Create("npc_manhack")
		self.Manhack:SetPos(self:GetAttachment(self:LookupAttachment("lhand")).Pos)
		self.Manhack:SetAngles(self:GetAttachment(self:LookupAttachment("lhand")).Ang +Angle(0,0,0))
		self:AddEntityRelationship(self.Manhack, D_LI, 0)
		self.Manhack:SetOwner(self)
		self.Manhack:SetParent(self)
		self.Manhack:Fire("SetParentAttachment","lhand")
		self.Manhack:Spawn()
		self.Manhack.Owner = self
		self.Manhack:Activate()
		self.Manhack:SetMoveType(MOVETYPE_NONE)
		self.Manhack:SetSolid(SOLID_BBOX)
		self.Manhack.Behavior = VJ_BEHAVIOR_PASSIVE_NATURE
		self.Manhack.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
		self.Manhack:AddRelationship("npc_headcrab_poison D_LI 99")
		self.Manhack:AddRelationship("npc_headcrab_fast D_LI 99")
		self.hasmanhack = true
	end
	if IsValid(self.Manhack) then
		self.AnimTbl_Run = {VJ_SequenceToActivity(self,"run_all_grenade")}
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self,"walk_all_grenade")}
		self.AnimTbl_IdleStand = {VJ_SequenceToActivity(self,"idle_grenade")}
	else
		self.AnimTbl_Run = {ACT_RUN}
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_IdleStand = {ACT_IDLE}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnKilled(dmginfo,hitgroup)
	if IsValid(self.Manhack) then
		self.lion = ents.Create("npc_manhack")
		self.lion:SetPos(self:GetAttachment(self:LookupAttachment("lhand")).Pos)
		self.lion:SetAngles(self:GetAngles())
		self.lion:Spawn()
		self.lion:Activate()
		self.lion:SetOwner(self)
		self.lion:SetHealth(self.Manhack:Health())
	end
end

ENT.EntitiesToNoCollide = {
	"npc_vj_alpha_gonome", 
	"npc_vj_ezt_manhackbie", 
	"npc_vj_ezt_shotbie", 
	"npc_vj_ezt_weapbie", 
	"npc_vj_horde_blight", 
	"npc_vj_horde_breen", 
	"npc_vj_horde_charred_zombine", 
	"npc_vj_horde_crawler", 
	"npc_vj_horde_exploder", 
	"npc_vj_horde_fast_zombie",
	"npc_vj_horde_gamma_gonome",
	"npc_vj_horde_headcrab_baby",
	"npc_vj_horde_hellknight",
	"npc_vj_horde_hulk",
	"npc_vj_horde_lesion",
	"npc_vj_horde_plague_elite",
	"npc_vj_horde_plague_platoon",
	"npc_vj_horde_plague_soldier",
	"npc_vj_horde_platoon_berserker",
	"npc_vj_horde_platoon_demolitionist",
	"npc_vj_horde_platoon_heavy",
	"npc_vj_horde_poison_zombie",
	"npc_vj_horde_scorcher",
	"npc_vj_horde_screecher",
	"npc_vj_horde_sprinter",
	"npc_vj_horde_vomitter",
	"npc_vj_horde_walker",
	"npc_vj_horde_weeper",
	"npc_vj_horde_xen_destroyer_unit",
	"npc_vj_horde_xen_host_unit",
	"npc_vj_horde_xen_necromancer_unit",
	"npc_vj_horde_xen_psychic_unit",
	"npc_vj_horde_yeti",
	"npc_vj_horde_zombie_torso",
	"npc_vj_horde_zombine",
	"npc_vj_mutated_hulk"
}