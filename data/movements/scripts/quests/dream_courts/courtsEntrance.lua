-- [1] = Leaving, [2] = Entering
local config = {
	[1] = {hisPosition = Position(33675, 32147, 7), toPosition = Position(32354, 31249, 3), value = 1},
	[2] = {hisPosition = Position(32354, 31247, 3), toPosition = Position(33675, 32149, 7), value = 1},
	
	[3] = {hisPosition = Position(33672, 32227, 7), toPosition = Position(33584, 32209, 7), value = 1},
	[4] = {hisPosition = Position(33584, 32207, 7), toPosition = Position(33672, 32229, 7), value = 1},
	
	[5] = {hisPosition = Position(32014, 31946, 13), toPosition = Position(33695, 32189, 5), value = 1},
	[6] = {hisPosition = Position(33695, 32191, 5), toPosition = Position(32014, 31948, 13), value = 1},
	
	[7] = {hisPosition = Position(32066, 31949, 13), toPosition = Position(33688, 32113, 5), value = 1},
	[8] = {hisPosition = Position(33688, 32111, 5), toPosition = Position(32066, 31951, 13), value = 1},
	
	[9] = {hisPosition = Position(32016, 32037, 13), toPosition = Position(32057, 32001, 13), value = -1}, -- 2
	[10] = {hisPosition = Position(32055, 32001, 13), toPosition = Position(32016, 32035, 13), value = -1}, -- 2
	
	[11] = {hisPosition = Position(32041, 32022, 14), toPosition = Position(32042, 31924, 15), value = -1}, -- 2
	[12] = {hisPosition = Position(32042, 31922, 15), toPosition = Position(32041, 32024, 14),  value = -1}, -- 2
	
	[13] = {hisPosition = Position(32043, 31954, 15), toPosition = Position(32095, 32038, 13),  value = -1}, -- 2
	
	-- Into Dream Scar
	[14] = {hisPosition = Position(32042, 31938, 15), toPosition = Position(32208, 32093, 13), value = -1}, -- 2
	[15] = {hisPosition = Position(32042, 31939, 15), toPosition = Position(32208, 32093, 13), value = -1}, -- 2
	[16] = {hisPosition = Position(32043, 31938, 15), toPosition = Position(32208, 32093, 13), value = -1}, -- 2
	[17] = {hisPosition = Position(32043, 31939, 15), toPosition = Position(32208, 32093, 13), value = -1}, -- 2
	-- Out of Dream Scar
	[18] = {hisPosition = Position(32208, 32091, 13), toPosition = Position(32043, 31943, 15), value = -1}, -- 2
	
	-- Dream Scar > Courts
	[19] = {hisPosition = Position(32203, 32078, 14), toPosition = Position(33672, 32118, 7), value = -1}, -- 2
	[20] = {hisPosition = Position(32217, 32071, 14), toPosition = Position(33718, 32182, 7), value = -1}, -- 2
}

function onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end
	
	local posItem = item:getPosition()
		
	for _, k in pairs(config) do
		if k.hisPosition == posItem then
			player:teleportTo(k.toPosition)
		end
	end
		
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end