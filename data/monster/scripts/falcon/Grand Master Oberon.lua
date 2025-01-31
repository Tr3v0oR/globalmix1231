local mensagens = {
	[1] = {say = "You appear like a worm among men!", storage = 1},
	[2] = {say = "The world will suffer for its iddle laziness!", storage = 2},
	[3] = {say = "People fall at my feet when they see me coming!", storage = 3},
	[4] = {say = "This will be the end of mortal man!", storage = 4},
	[5] = {say = "I will remove you from this plane of existence!", storage = 5},
	[6] = {say = "Dragons will soon rule this world, I am their herald!", storage = 6},
	[7] = {say = "The true virtue of chivalry are my belief!", storage = 7},
	[8] = {say = "I lead the most honourable and formidable following of knights!", storage = 8},
	[9] = {say = "ULTAH SALID'AR, ESDO LO!", storage = 9},
}

local respostas = {
	[1] = {msg = "How appropriate, you look like something worms already got the better of!", storage = 1},
	[2] = {msg = "Are you ever going to fight or do you prefer talking!", storage = 2},
	[3] = {msg = "Even before they smell your breath?", storage = 3},
	[4] = {msg = "Then let me show you the concept of mortality before it!", storage = 4},
	[5] = {msg = "Too bad you barely exist at all!", storage = 5},
	[6] = {msg = "Excuse me but I still do not get the message!", storage = 6},
	[7] = {msg = "Dare strike up a Minnesang and you will receive your last accolade!", storage = 7},
	[8] = {msg = "Then why are we fighting alone right now?", storage = 8},
	[9] = {msg = "SEHWO ASIMO, TOLIDO ESD!", storage = 9},
}

function  onCreatureDisappear(self, creature)
	if self == creature and self:getType():isRewardBoss() then
		self:setReward(true)
	end
	return true
end

function onCreatureSay(self, creature, type, message)
	if self:getId() == creature:getId() then
		-- aqui � quando o monstro fala
		-- if msg == da condicao bla bla bla
	else
		if type == TALKTYPE_SAY then
			for _, mensagem in pairs(respostas) do
				local msg = mensagem.msg
				local value = mensagem.storage
				local stg = Game.getStorageValue(GlobalStorage.secretLibrary.FalconBastion.oberonSay)
				if stg == value then
					if message == msg then
						self:unregisterEvent("oberonImmune")
						self:addHealth(self:getMaxHealth())
						self:setStorageValue(Storage.secretLibrary.FalconBastion.lastBossMsgInterval, - 1)
						self:setStorageValue(Storage.secretLibrary.FalconBastion.oberonHeal, self:getStorageValue(Storage.secretLibrary.FalconBastion.oberonHeal) + 1)
						Game.setStorageValue(GlobalStorage.secretLibrary.FalconBastion.oberonSay, - 1)
						creature:sendCancelMessage('Resposta correta! Charges: ' .. self:getStorageValue(Storage.secretLibrary.FalconBastion.oberonHeal))
					else
						self:setStorageValue(Storage.secretLibrary.FalconBastion.oberonHeal, self:getStorageValue(Storage.secretLibrary.FalconBastion.oberonHeal) - 1)
						creature:sendCancelMessage('"'..message .. '" n�o era a resposta correta. Charges: ' .. self:getStorageValue(Storage.secretLibrary.FalconBastion.oberonHeal))
					end
				end
			end
		end
	end
	return true
end


local function sendMessage(creatureid)
	local creature = Creature(creatureid)
	if not creature then return end
	
	local r = math.random(1, 9)
	local msgTable = mensagens
	msgTable = msgTable[r]
	local msg = msgTable.say
	local value = msgTable.storage
	
	creature:say(msg, TALKTYPE_MONSTER_SAY)
	creature:registerEvent('oberonImmune')
	Game.setStorageValue(GlobalStorage.secretLibrary.FalconBastion.oberonSay, value)	
end

function onThink(self, interval)
	if self:getStorageValue(Storage.secretLibrary.FalconBastion.oberonHeal) < 4 then
		local checarFala = self:getStorageValue(Storage.secretLibrary.FalconBastion.lastBossMsgInterval)
		local segundos = math.random(15, 20)*1000
		if checarFala == 1 then
			return true
		end	
		self:setStorageValue(Storage.secretLibrary.FalconBastion.lastBossMsgInterval, 1)
		addEvent(sendMessage, segundos, self:getId())
	end
end
