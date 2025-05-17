function EFFECT:Init(data)
	local Startpos = self:GetTracerShootPos(self.Position, data:GetEntity(), data:GetAttachment())
	local Hitpos = data:GetOrigin()
	local ent = data:GetEntity()
	if not IsValid(ent) then return end

	if data:GetEntity():IsValid() and Startpos and Hitpos then
		self.Emitter = ParticleEmitter(Startpos)


		for i = 1, 20 do
			local gflame = self.Emitter:Add("particles/flamelet1", Startpos)
			gflame:SetColor(0,100,255)
			gflame:SetDieTime(1)
			gflame:SetStartAlpha(100)
			gflame:SetEndAlpha(0)
			gflame:SetStartSize(math.Rand(0.8, 1.5))
			gflame:SetEndSize(math.random(50, 75))
			gflame:SetRoll(math.random(-10, 10))
			gflame:SetRollDelta(math.random(-10, 10))
			gflame:SetVelocity(((Hitpos - Startpos):GetNormal() * math.random(500, 800)) + VectorRand() * math.random(1, 20))
			gflame:SetCollide(true)
			gflame:SetCollideCallback(function()
			gflame:SetDieTime(0)
			end)
		end

		self.Emitter:Finish()
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end