local monsters = {
	{monster = 'dwarf henchman', monsterPos = Position(32570, 31858, 14)},
	{monster = 'dwarf henchman', monsterPos = Position(32573, 31861, 14)},
	{monster = 'dwarf henchman', monsterPos = Position(32562, 31860, 14)},
	{monster = 'dwarf henchman', monsterPos = Position(32564, 31856, 14)},
	{monster = 'dwarf henchman', monsterPos = Position(32580, 31860, 14)},
	{monster = 'dwarf henchman', monsterPos = Position(32574, 31850, 14)},
	{monster = 'dwarf henchman', monsterPos = Position(32574, 31870, 14)},
	{monster = 'dwarf henchman', monsterPos = Position(32576, 31856, 14)},
	{monster = 'dwarf henchman', monsterPos = Position(32562, 31858, 14)},
	{monster = 'dwarf henchman', monsterPos = Position(32584, 31868, 14)},
	{monster = 'stone golem', monsterPos = Position(32570, 31861, 14)},
	{monster = 'stone golem', monsterPos = Position(32579, 31868, 14)},
	{monster = 'stone golem', monsterPos = Position(32569, 31852, 14)},
	{monster = 'stone golem', monsterPos = Position(32584, 31866, 14)},
	{monster = 'stone golem', monsterPos = Position(32572, 31851, 14)},
	{monster = 'mechanical fighter', monsterPos = Position(32573, 31858, 14)},
	{monster = 'mechanical fighter', monsterPos = Position(32570, 31868, 14)},
	{monster = 'mechanical fighter', monsterPos = Position(32579, 31852, 14)},
	{monster = 'mad technomancer', monsterPos = Position(32571, 31859, 14)}
}

function onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 1945 then
		if player:getStorageValue(71628) < os.time() then
			for i = 1, #monsters do
				Game.createMonster(monsters[i].monster, monsters[i].monsterPos)
			end
			player:setStorageValue(71628, os.time() + 15*60)
		else 
			player:sendCancelMessage("You must wait for 15 minutes before pull this lever again.")
			return true
		end
	end

	item:transform(item.itemid == 1945 and 1946 or 1945)
 	return true
end
