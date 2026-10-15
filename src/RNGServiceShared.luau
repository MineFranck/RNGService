local RNGServiceUtils = require(script.Parent.RNGServiceUtils)

local k = 0.15

local RNGServiceShared = {}

function RNGServiceShared.getRandomKey(
	_table: { [string]: RNGServiceUtils.WeightedTable },
	luck: number?,
	constant: number?
): string
	local newTable = RNGServiceShared.applyLuck(_table, luck, constant)
	local sum = RNGServiceUtils.getSum(newTable)
	local random = RNGServiceUtils.generateRNG():NextInteger(1, sum)
	local offset = 0

	for i, v in newTable do
		offset += v.Weight

		if offset >= random then
			return i
		end
	end
	return
end

function RNGServiceShared.getRandomsFromArray(array: { any }, amount: number?): { any }
	local newArray = table.clone(array)
	local arrayToReturn = {}
	amount = math.floor(math.clamp(amount or 1, 1, #array))
	for _ = 1, amount do
		local random = RNGServiceUtils.generateRNG():NextInteger(1, #newArray)
		table.insert(arrayToReturn, newArray[random])
		table.remove(newArray, random)
	end
	return arrayToReturn
end

function RNGServiceShared.callbackOnChance(x: number, luck: number?, callback: () -> ...any): ...any
	x = math.floor(math.max(x, 1))
	luck = math.clamp(luck or 1, 1, x)
	local random = RNGServiceUtils.generateRNG():NextInteger(1, x / luck)
	if random == 1 then
		return callback()
	end
	return nil
end

function RNGServiceShared.getPercentagesTable(
	_table: { [string]: RNGServiceUtils.WeightedTable },
	luck: number?,
	constant: number?
): { [string]: number }
	local luckTable = RNGServiceShared.applyLuck(_table, luck, constant)
	local sum = RNGServiceUtils.getSum(luckTable)
	local newTable = {}

	for i, v in luckTable do
		newTable[i] = (v.Weight / sum) * 100
	end
	return newTable
end

function RNGServiceShared.applyLuck(
	_table: { [string]: RNGServiceUtils.WeightedTable },
	luck: number?,
	constant: number?
): { [string]: RNGServiceUtils.WeightedTable }
	luck = math.max(luck or 1, 1)
	if luck == 1 then
		return _table
	end
	constant = constant or k

	local newTable = table.clone(_table)
	for i, v in _table do
		local tier = v.Tier or 1
		newTable[i].Weight = math.floor(v.Weight * (luck ^ (tier * constant)))
	end
	return newTable :: { [string]: RNGServiceUtils.WeightedTable }
end

type RNGServiceShared = typeof(RNGServiceShared)

return RNGServiceShared :: RNGServiceShared
