local default = {
	[1] = {itemPosition = Position(33618, 32546, 13), toPosition = Position(32723, 32270, 8), value = 2, blockedText = 'Connect all three gateways to restore the circle of energy sustaining this nexus.'},
	[2] = {itemPosition = Position(32720, 32270, 8), toPosition = Position(33618, 32544, 13), value = 2, blockedText = 'Connect all three gateways to restore the circle of energy sustaining this nexus.'},
	[3] = {itemPosition = Position(33619, 32526, 15), toPosition = Position(33619, 32528, 15), value = 2, msg = 'You traverse the rubble with ease but more of it falls down behind you, essentially blocking your path once again.'},
}

-- their names are only to know for wich boss is the storage
local dreamScar = {
	[1] = {day = "Monday", bossName = "Alptramun", storageTimer = Storage.DreamCourts.DreamScar.alptramunTimer},
	[2] = {day = "Tuesday", bossName = "Izcandar the Banished", storageTimer = Storage.DreamCourts.DreamScar.izcandarTimer},
	[3] = {day = "Wednesday", bossName = "Malofur Mangrinder", storageTimer = Storage.DreamCourts.DreamScar.malofurTimer},
	[4] = {day = "Thursday", bossName = "Maxxenius", storageTimer = Storage.DreamCourts.DreamScar.maxxeniusTimer},
	[5] = {day = "Friday", bossName = "Izcandar the Banished", storageTimer = Storage.DreamCourts.DreamScar.izcandarTimer},
	[6] = {day = "Saturday", bossName = "Plagueroot", storageTimer = Storage.DreamCourts.DreamScar.plaguerootTimer}, 
	[7] = {day = "Sunday", bossName = "Maxxenius", storageTimer = Storage.DreamCourts.DreamScar.maxxeniusTimer},
}


local permission = Storage.DreamCourts.DreamScar.Permission

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	local iPos = item:getPosition()
	local dreamScarTeleport = Position(32208, 32033, 13)
	local nightmareTeleport = Position(32211, 32081, 15)

	if item:getPosition() == nightmareTeleport then
		if player:getStorageValue(Storage.DreamCourts.DreamScar.bossCount) >= 5 then
			if player:getStorageValue(Storage.DreamCourts.DreamScar.nightmareTimer) > os.stime() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have to wait to challenge The Nightmare Beast again!')
				player:teleportTo(fromPosition)
			else
				player:teleportTo(Position(32211, 32075, 15))
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You can not use this teleport yet.')
			player:teleportTo(fromPosition)
		end
	end
	
	-- Portais comuns
	for _, k in pairs(default) do
		if k.itemPosition == iPos then
			player:teleportTo(k.toPosition)
			if k.msg then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, k.msg)
			end
		end
	end
	
	-- Portal da Dream Scar
	if iPos == dreamScarTeleport then
		for i = 1, #dreamScar do
			if os.sdate("%A") == dreamScar[i].day then
				if player:getStorageValue(dreamScar[i].storageTimer) > os.stime() then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You have to wait to challenge '..dreamScar[i].bossName..' again!')
					player:teleportTo(fromPosition)
				else
					player:teleportTo(Position(32208, 32026, 13))
				end
			end
		end
	end
	
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end