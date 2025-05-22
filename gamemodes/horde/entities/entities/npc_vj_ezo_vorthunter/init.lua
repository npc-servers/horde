AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Model = {"models/huntervort.mdl"}

ENT.StartHealth = 400
ENT.HullType = HULL_MEDIUM_TALL

ENT.VJ_NPC_Class = {"CLASS_ZOMBIE", "CLASS_XEN"}
ENT.FriendsWithAllPlayerAllies = false
ENT.HasBloodPool = true
ENT.BloodColor = "white"
ENT.InvestigateSoundDistance = 240

ENT.AnimTbl_IdleStand = {ACT_IDLE}
ENT.AnimTbl_Walk = {ACT_WALK}
ENT.AnimTbl_Run = {ACT_RUN}

ENT.SightDistance = 10000
ENT.SightAngle = 80
ENT.TurningSpeed = 10
ENT.HasDeathRagdoll = true

ENT.HasMeleeAttack = true
-- Melee Attack Animations
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1, "meleert"}
ENT.MeleeAttackDistance = 70 -- How close does it have to be until it attacks?
ENT.MeleeAttackDamageDistance = 75 -- How far does the damage go?
ENT.TimeUntilMeleeAttackDamage = 0.5
ENT.MeleeAttackDamage = 10
ENT.MeleeAttackDamageType = DMG_SLASH
ENT.NextAnyAttackTime_Melee = 0.5 -- How much time until it can use any attack again? | Counted in Seconds
ENT.NextMeleeAttackTime = 0.5 -- How much time until it can use a melee attack?
ENT.PushProps = true
ENT.AttackProps = true -- Should it attack props when trying to move?
ENT.CanOpenDoors = true
ENT.MaxJumpLegalDistance = VJ_Set(300, 1000)
ENT.HasMeleeAttackKnockBack = true
ENT.MeleeAttackKnockBack_Forward1 = 200
ENT.MeleeAttackKnockBack_Forward2 = 300

ENT.AlertFriendsOnDeath = true
ENT.AlertFriendsOnDeathDistance = 1000
ENT.AlertFriendsOnDeathLimit = 1
ENT.CallForHelp = true
ENT.CallForHelpDistance = 2500
ENT.CallForBackUpOnDamageUseCertainAmount = false
ENT.HasCallForHelpAnimation = true
-- Call For Help Animations
ENT.AnimTbl_CallForHelp = {"hunter_call_1", "hunter_respond_1", "hunter_respond_3"}

ENT.HasRangeAttack = false
ENT.NextRangeAttackTime = 6
ENT.RangeUseAttachmentForPos = true
ENT.RangeUseAttachmentForPosID = "minigunbase"
ENT.RangeAttackEntityToSpawn = "obj_vj_ez2_flechette"
ENT.TimeUntilRangeAttackProjectileRelease = 1.5
ENT.RangeDistance = 5000 -- This is how far away it can shoot
ENT.RangeAttackAngleRadius = 60
ENT.RangeToMeleeDistance = 70 -- How close does it have to be until it uses melee?
ENT.RangeAttackExtraTimers = {1.5, 1.65, 1.8, 1.95}

ENT.FootStepTimeRun = 0.3 -- Next foot step sound when it is running
ENT.FootStepTimeWalk = 0.5 -- Next foot step sound when it is walking
ENT.HasExtraMeleeAttackSounds = true

ENT.CanFlinch = 1 -- 0 = Don't flinch | 1 = Flinch at any damage | 2 = Flinch only from certain damages
ENT.FlinchChance = 3 -- Chance of it flinching from 1 to x | 1 will make it always flinch
ENT.NextMoveAfterFlinchTime = false
ENT.NextFlinchTime = 2
ENT.HitGroupFlinching_DefaultWhenNotHit = true
ENT.AnimTbl_Flinch = {"vjges_flinch_e", "vjges_flinch_s", "vjges_flinch_n", "vjges_flinch_w"}
ENT.HasSoundTrack = false
ENT.SoundTrackVolume = 1
ENT.SoundTrackChance = 1
ENT.CombatFaceEnemy = false
ENT.RangeAttackAnimationFaceEnemy = true

ENT.CanShake = true
ENT.Charging = false
ENT.hit = false
ENT.NextCharge = 0
ENT.NextDodging = 0
ENT.Dodging = false

ENT.SoundTbl_FootStep = {"snpc/hunterarc/ministrider_footstep1.wav", "snpc/hunterarc/ministrider_footstep2.wav", "snpc/hunterarc/ministrider_footstep3.wav", "snpc/hunterarc/ministrider_footstep4.wav", "snpc/hunterarc/ministrider_footstep5.wav"}
ENT.SoundTbl_Idle = {"snpc/hunterarc/hunter_angry1.wav", "snpc/hunterarc/hunter_angry2.wav", "snpc/hunterarc/hunter_angry3.wav", "snpc/hunterarc/hunter_idle1.wav", "snpc/hunterarc/hunter_idle2.wav", "snpc/hunterarc/hunter_idle3.wav"}
ENT.SoundTbl_Alert = {"snpc/hunterarc/hunter_foundenemy1.wav", "snpc/hunterarc/hunter_foundenemy2.wav", "snpc/hunterarc/hunter_foundenemy3.wav", "snpc/hunterarc/hunter_foundenemy_ack1.wav", "snpc/hunterarc/hunter_foundenemy_ack2.wav", "snpc/hunterarc/hunter_foundenemy_ack3.wav", "snpc/hunterarc/hunter_alert1.wav", "snpc/hunterarc/hunter_alert2.wav", "snpc/hunterarc/hunter_alert3.wav",}
ENT.SoundTbl_BeforeRangeAttack = {"snpc/hunterarc/hunter_prestrike1.wav"}
ENT.SoundTbl_Investigate = {"snpc/hunterarc/hunter_scan1.wav", "snpc/hunterarc/hunter_scan2.wav", "snpc/hunterarc/hunter_scan3.wav", "snpc/hunterarc/hunter_scan4.wav",}
ENT.SoundTbl_LostEnemy = {"snpc/hunterarc/hunter_scan1.wav", "snpc/hunterarc/hunter_scan2.wav", "snpc/hunterarc/hunter_scan3.wav", "snpc/hunterarc/hunter_scan4.wav",}
ENT.SoundTbl_CombatIdle = {"snpc/hunterarc/hunter_defendstrider1.wav", "snpc/hunterarc/hunter_defendstrider2.wav", "snpc/hunterarc/hunter_defendstrider3.wav", "snpc/hunterarc/hunter_foundenemy1.wav", "snpc/hunterarc/hunter_foundenemy2.wav", "snpc/hunterarc/hunter_foundenemy3.wav",}
ENT.SoundTbl_Pain = {"snpc/hunterarc/hunter_pain2.wav", "snpc/hunterarc/hunter_pain4.wav"}
ENT.ChargeSd = {"snpc/hunterarc/hunter_charge3.wav", "snpc/hunterarc/hunter_charge4.wav"}
ENT.BodySd = {"snpc/hunterarc/body_medium_impact_hard1.wav", "snpc/hunterarc/body_medium_impact_hard2.wav", "snpc/hunterarc/body_medium_impact_hard3.wav", "snpc/hunterarc/body_medium_impact_hard4.wav", "snpc/hunterarc/body_medium_impact_hard5.wav"}
ENT.SoundTbl_Death = {"snpc/hunterarc/hunter_die2.wav", "snpc/hunterarc/hunter_die3.wav",}
ENT.SoundTbl_BeforeMeleeAttack = {"snpc/hunterarc/hunter_prestrike1.wav"}
ENT.SoundTbl_MeleeAttack = {"snpc/hunterarc/flechette_flesh_impact1.wav", "snpc/hunterarc/flechette_flesh_impact2.wav", "snpc/hunterarc/flechette_flesh_impact3.wav", "snpc/hunterarc/flechette_flesh_impact4.wav"}
ENT.SoundTbl_MeleeAttackMiss = {"npc/zombie/claw_miss1.wav", "npc/zombie/claw_miss2.wav"}
ENT.UseTheSameGeneralSoundPitch = true
ENT.GeneralSoundPitch1 = 90
ENT.GeneralSoundPitch2 = 95
-- This two variables control any sound pitch variable that is set to "UseGeneralPitch"
-- To not use these variables for a certain sound pitch, just put the desired number in the specific sound pitch

function ENT:CustomOnInitialize()
	self:AddRelationship("npc_headcrab_poison D_LI 99")
	self:AddRelationship("npc_headcrab_fast D_LI 99")
	self.NextCharge = CurTime() + 5
	self:SetColor(Color(200, 50, 0))
		local eye = ents.Create("env_sprite")
		eye:SetKeyValue("model", "vj_base/sprites/vj_glow1.vmt")
		eye:SetKeyValue("scale", "0.2")
		eye:SetKeyValue("rendermode", "5")
		eye:SetKeyValue("rendercolor", "250 5 0")
		eye:SetKeyValue("spawnflags", "1")
		eye:SetParent(self)
		eye:Fire("SetParentAttachment", "top_eye", 0)
		eye:Spawn()
		eye:Activate()
		self:DeleteOnRemove(eye)
		local eye2 = ents.Create("env_sprite")
		eye2:SetKeyValue("model", "vj_base/sprites/vj_glow1.vmt")
		eye2:SetKeyValue("scale", "0.2")
		eye2:SetKeyValue("rendermode", "5")
		eye2:SetKeyValue("rendercolor", "250 5 0")
		eye2:SetKeyValue("spawnflags", "1")
		eye2:SetParent(self)
		eye2:Fire("SetParentAttachment", "bottom_eye", 0)
		eye2:Spawn()
		eye2:Activate()
		self:DeleteOnRemove(eye2)
		local glow1 = ents.Create("light_dynamic")
		glow1:SetKeyValue("brightness", "5")
		glow1:SetKeyValue("distance", "40")
		glow1:SetPos(self:GetAttachment(self:LookupAttachment("top_eye")).Pos)
		glow1:SetKeyValue("rendercolor", "250 5 0")
		glow1:SetParent(self)
		glow1:Spawn()
		glow1:Activate()
		self:DeleteOnRemove(glow1)
		local glow2 = ents.Create("light_dynamic")
		glow2:SetKeyValue("brightness", "5")
		glow2:SetKeyValue("distance", "40")
		glow2:SetPos(self:GetAttachment(self:LookupAttachment("bottom_eye")).Pos)
		glow2:SetKeyValue("rendercolor", "250 5 0")
		glow2:SetParent(self)
		glow2:Spawn()
		glow2:Activate()
		self:DeleteOnRemove(glow2)
end

function ENT:CustomOnFlinch_BeforeFlinch(dmginfo, hitgroup)
	if dmginfo:GetDamage() < 80 then
		local dpos = dmginfo:GetAttacker():GetPos()

			local directions = {
				{"vjges_flinch_s", dpos:Distance(self:GetPos() + self:GetForward() * 25)}, --North; move back
				{"vjges_flinch_w", dpos:Distance(self:GetPos() + self:GetRight() * 25)}, --East; move left
				{"vjges_flinch_n", dpos:Distance(self:GetPos() - self:GetForward() * 25)}, --South; move forward
				{"vjges_flinch_e", dpos:Distance(self:GetPos() - self:GetRight() * 25)} --West; move right	
			}

			table.sort(directions, function(a, b)
				return a[2] < b[2]
			end)

		self.AnimTbl_Flinch = {directions[1][1]}
	else
		local dpos = dmginfo:GetAttacker():GetPos()

			local directions1 = {
				{"staggers", dpos:Distance(self:GetPos() + self:GetForward() * 25)}, --North; move back
				{"staggerw", dpos:Distance(self:GetPos() + self:GetRight() * 25)}, --East; move left
				{"staggern", dpos:Distance(self:GetPos() - self:GetForward() * 25)}, --South; move forward
				{"staggere", dpos:Distance(self:GetPos() - self:GetRight() * 25)} --West; move right
			}

			table.sort(directions1, function(a, b)
				return a[2] < b[2]
			end)



		self.AnimTbl_Flinch = {directions1[1][1]}
	end

	-- Code to make hunter stop charging on take big damage
	if IsValid(self) and self.Charging and not self.Dead then
		self.MovementType = VJ_MOVETYPE_GROUND
		self.Charging = false
		self.hit = true

		self.AnimTbl_Run = {ACT_RUN}

		self.NextCharge = CurTime() + math.Rand(10, 15)
		VJ_EmitSound(self, self.SoundTbl_BeforeMeleeAttack, 100, math.random(80, 100))

		timer.Simple(1, function()
			if IsValid(self) then
				self.hit = false
			end
		end)
		timer.Simple(2, function()
			if IsValid(self) then
				self.HasMeleeAttack = true
				self.HasRangeAttack = true
			end
		end)
	end
end

function ENT:MultipleMeleeAttacks()

	if self:Visible(self:GetEnemy()) and not self.RangeAttacking and not self.MeleeAttacking and not self.Alerting and not self.Dodging and self.NearestPointToEnemyDistance > 400 and self.NearestPointToEnemyDistance < 2000 and CurTime() > self.NextCharge then
		VJ_EmitSound(self, self.ChargeSd, 100, math.random(80, 100))
		self:VJ_ACT_PLAYACTIVITY("charge_start", true, false, true)

		timer.Simple(1.5, function()
			if IsValid(self) then
				self:Charge()
			end
		end)
	end

	local randAttack = math.random(1, 3)

	if randAttack == 1 and self.NearestPointToEnemyDistance < 400 then
		self.AnimTbl_MeleeAttack = {"melee_02"}

		self.TimeUntilMeleeAttackDamage = 0.5
		self.MeleeAttackDamage = math.random(15, 25)
	end

	if randAttack == 2 and self.NearestPointToEnemyDistance < 400 then
		self.AnimTbl_MeleeAttack = {"meleert"}

		self.TimeUntilMeleeAttackDamage = 0.5
		self.MeleeAttackDamage = math.random(15, 25)
	end

	if randAttack == 3 and self.NearestPointToEnemyDistance < 400 then
		self.AnimTbl_MeleeAttack = {"meleeleft"}

		self.TimeUntilMeleeAttackDamage = 0.5
		self.MeleeAttackDamage = math.random(15, 25)
	end
end

function ENT:Charge()
	if not self.Dead then
		self.HasMeleeAttack = false
		self.Charging = true
		self:CapabilitiesRemove(CAP_MOVE_JUMP)
		self.HasRangeAttack = false
		self.FlinchChance = 2
		self.NextFlinchTime = 2
		self.AnimTbl_Run = {VJ_SequenceToActivity(self, "charge_loop")}

		local trMove = util.TraceLine({
			start = self:GetPos() + self:OBBCenter(),
			endpos = self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(),
			filter = self
		})

		self:SetLastPosition(trMove.HitPos + trMove.HitNormal * self:OBBMaxs().y)
		self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
	end
end

function ENT:ChargeHit()
	if IsValid(self) and self.Charging and not self.Dead then
		self:VJ_ACT_PLAYACTIVITY("charge_miss_slide", true, false, true)
		self.FlinchChance = 3
		self.NextFlinchTime = 2
		self.MovementType = VJ_MOVETYPE_GROUND
		self.Charging = false
		self.hit = true
		self.NextCharge = CurTime() + math.Rand(15, 30)
		VJ_EmitSound(self, self.SoundTbl_MeleeAttack, 100, math.random(80, 100))

		self.AnimTbl_Run = {ACT_RUN}

		timer.Simple(1, function()
			if IsValid(self) then
				self.hit = false
			end
		end)
		timer.Simple(2, function()
			if IsValid(self) then
				self.HasMeleeAttack = true
				self.HasRangeAttack = true
			end
		end)
	end
end

function ENT:StopCharge()
	if IsValid(self) and self.Charging and not self.Dead then
		self:VJ_ACT_PLAYACTIVITY("charge_miss_slide", true, false, true)
		self.FlinchChance = 3
		self.NextFlinchTime = 2
		self.MovementType = VJ_MOVETYPE_GROUND
		self.Charging = false
		self.hit = true

		self.AnimTbl_Run = {ACT_RUN}
		self.NextCharge = CurTime() + math.Rand(5, 10)
		VJ_EmitSound(self, self.SoundTbl_BeforeMeleeAttack, 100, math.random(80, 100))

		timer.Simple(1, function()
			if IsValid(self) then
				self.hit = false
			end
		end)
		timer.Simple(2, function()
			if IsValid(self) then
				self.HasMeleeAttack = true
				self.HasRangeAttack = true
			end
		end)
	end
end

function ENT:ChargeCrash()
	if IsValid(self) and self.Charging and not self.Dead then
		self:VJ_ACT_PLAYACTIVITY("charge_crash", true, false, true)
		self.FlinchChance = 3
		self.NextFlinchTime = 2
		self.MovementType = VJ_MOVETYPE_GROUND
		self.Charging = false
		self.hit = true

		self.AnimTbl_Run = {ACT_RUN}

		self.NextCharge = CurTime() + math.Rand(15, 20)
		self:SetPos(self:GetPos() + self:GetForward() * -1 + self:GetUp() * 0)
		util.ScreenShake(self:GetPos(), 44, 300, 1, 2000)
		VJ_EmitSound(self, self.BodySd, 100, math.random(80, 100))
		timer.Simple(1, function()
			if IsValid(self) then
				self.hit = false
			end
		end)
		timer.Simple(1, function()
			if IsValid(self) then
				self.HasMeleeAttack = true
				self.HasRangeAttack = true
			end
		end)
	end
end

function ENT:CustomRangeAttackCode_BeforeProjectileSpawn(projectile)
	local attid = self:LookupAttachment("minigunbase")
	ParticleEffectAttach("hunter_muzzle_flash", 4, self, attid) --PATTACH_POINT_FOLLOW
	self:EmitSound("snpc/hunterarc/ministrider_fire1.wav", 110, math.random(90, 110), 0.66, CHAN_WEAPON)
end

function ENT:RangeAttackCode_GetShootPos(projectile)
	local startPos = projectile:GetPos()
	return self:CalculateProjectile("Line", startPos, self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter(), 2000)
end

function ENT:CustomOnThink()

	if not IsValid(self:GetEnemy()) then
		return
	end
	local enemy = self:GetEnemy()

	if IsValid(enemy) then
		local dist = (self:GetEnemy():GetPos() - self:GetPos())
		if dist:Length2D() < 400 and math.abs(dist.z) <= 60 and not self.Charging then
			self.HasRangeAttack = false
		elseif not self.Charging and dist:Length2D() > 400 or math.abs(dist.z) >= 60 and not self.Charging then
			self.HasRangeAttack = true
		end
	end
	-- Charge Code
	if self.Charging then
		if not IsValid(self:GetEnemy()) then
			self:StopCharge()
			return
		end

		local boxmax = self:OBBMaxs() * Vector(1, 1, 0.6)
		local tr = util.TraceHull({
			start = self:GetPos() + self:OBBCenter(),
			endpos = self:GetPos() + self:OBBCenter() + self:GetForward() * 100,
			filter = self,
			mins = self:OBBMins(),
			maxs = boxmax,
		})

		if self:GetPos():Distance(self:GetLastPosition()) <= 90 and self.Charging and not tr.Hit and not tr.HitWorld then
			self:StopCharge()
		end
		if tr.Hit and tr.HitWorld then
			self:ChargeCrash()
		end

		for k, v in pairs(ents.FindInSphere(self:GetPos() + self:OBBCenter() + self:GetForward() * 40, 60)) do
			-- Crash If Hit Map
			if tr.Hit and not self:Visible(v) and v:GetClass() ~= "horde_warden_aura" then
				self:ChargeCrash()
			end

			timer.Simple(6, function()
				if not tr.Hit and not self.hit and self.Charging and IsValid(self) and v:GetClass() ~= "horde_warden_aura" then
					-- Crash If Hit Wall
					self:StopCharge()
				end
			end)
		end

			for k, v in pairs(ents.FindInSphere(self:GetPos() + self:OBBCenter() + self:GetForward() * 40, 60)) do
				if self:DoRelationshipCheck(v) and self:Visible(v) and not self.Dead then
					VJ_EmitSound(self, self.SoundTbl_MeleeAttack, 100, math.random(80, 100))
					local d = DamageInfo()
					d:SetDamage( math.random(40, 50) )
					d:SetAttacker( self )
					d:SetInflictor(self)
					d:SetDamageType( DMG_CLUB )
					if IsValid(v) then
					v:TakeDamageInfo( d )
					v:SetVelocity(self:GetForward() * 500 + self:GetUp() * 400)
					self:ChargeHit()
				end
			end
		end
	end

	-- Dodge
		if not self.Alerting and IsValid(self:GetEnemy()) and not self.Dead and CurTime() > self.NextDodging and self:GetPos():Distance(self:GetEnemy():GetPos()) < 4500 and not self.RangeAttacking and not self.Charging and not self.MeleeAttacking then
			local dodge_dirs = {}
			local dir2 = nil

			for dir, path_clear in pairs(self:VJ_CheckAllFourSides()) do
				if path_clear then
					if dir == "Forward" then
						dir2 = "n"
					elseif dir == "Back" then
						dir2 = "s"
					elseif dir == "Left" then
						dir2 = "w"
					elseif dir == "Right" then
						dir2 = "e"
					end

					table.insert(dodge_dirs, dir2)
				end
			end

			if not table.IsEmpty(dodge_dirs) then
				local dodge_dir = string.lower(table.Random(dodge_dirs))
				self:VJ_ACT_PLAYACTIVITY("dodge_" .. dodge_dir, true, 0.75, false)
				self.NextDodging = CurTime() + math.Rand(7, 12)
			end
		end


	if (self:GetMaxHealth() * 0.5) > self:Health() then
		self.AnimTbl_Walk = {VJ_SequenceToActivity(self, "prowl_all")}
		self.Wounded = true
	end

	if (self:GetMaxHealth() * 0.5) > self:Health() and self.CanShake and not self.Dead then
		self:VJ_ACT_PLAYACTIVITY("shakeoff", true, false, true)
		self.CanShake = false
	end

	if (self:GetMaxHealth() * 0.5) < self:Health() then
		self.AnimTbl_Walk = {ACT_WALK}
		self.Wounded = false
	end
end

function ENT:CustomOnAlert(ent)
	self.Alerting = true

	self:VJ_ACT_PLAYACTIVITY({"hunter_angry", "hunter_angry2"}, true, 2, true)

	timer.Simple(3, function()
		if IsValid(self) then
			self.Alerting = false
		end
	end)
end

function ENT:CustomAttackCheck_RangeAttack()
	self:SetState(VJ_STATE_ONLY_ANIMATION)
	-- For some reason hunter shoot only 1 projectile if he has range attack animation, so this is code to add this animation without problems
	self.AnimTbl_IdleStand = {"shoot_minigun"}

	timer.Simple(3, function()
		if IsValid(self) then
			self.AnimTbl_IdleStand = {ACT_IDLE}
			self:SetState()
		end
	end)
	return true
end

function ENT:CustomRangeAttackCode_AfterProjectileSpawn(projectile)
	local attid = self:LookupAttachment("minigunbase")
	ParticleEffectAttach("hunter_muzzle_flash", 4, self, attid)
end

function ENT:RangeAttackCode_GetShootPos(projectile)
	local startPos = projectile:GetPos()
	return self:CalculateProjectile("Line", startPos, self:GetEnemy():GetPos() + self:GetEnemy():OBBCenter() + self:GetEnemy():GetUp() * math.random(-40, 40) + self:GetEnemy():GetRight() * math.random(-25, 25), 2000)
end

function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo, hitgroup, corpseEnt)
	corpseEnt:Dissolve( 3, 10, nil )
end
