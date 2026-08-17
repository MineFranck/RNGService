local RNGServiceUtils = require(script.Parent.RNGServiceUtils)

local k = 0.15

local RNGServiceShared = {}

function RNGServiceShared.Init(self: RNGServiceShared, constant: number)
	self.LuckConstant = typeof(constant) == "number" and constant or k
end

function RNGServiceShared.GetRandomKey(self: RNGServiceShared, _table: {[string]: RNGServiceUtils.WeightedTable}, luck: number?): string
	local newTable = self:ApplyLuck(_table, luck)
	local sum = RNGServiceUtils:GetSum(newTable)
	local random = RNGServiceUtils:GenerateRNG():NextInteger(1, sum)
	local offset = 0

	for i, v in newTable do
		offset += v.Weight

		if offset >= random then
			return i
		end
	end
	return
end

function RNGServiceShared:GetRandomFromArray(array: { any }): any
	local random = RNGServiceUtils:GenerateRNG():NextInteger(1, #array)
	return array[random]
end

function RNGServiceShared:CallbackOnChance(x: number, callback: () -> (...any)): ...any
	local random = RNGServiceUtils:GenerateRNG():NextInteger(1, x)
	if random == x then
		return callback()
	end
	return nil
end

function RNGServiceShared.GetPercentagesTable(self: RNGServiceShared, _table: {[string]: RNGServiceUtils.WeightedTable}, luck: number?): {[string]: number}
	local luckTable = self:ApplyLuck(_table, luck)
	local sum = RNGServiceUtils:GetSum(luckTable)
	local newTable = {}

	for i, v in luckTable do
		newTable[i] = (v.Weight / sum) * 100
	end
	return newTable
end

function RNGServiceShared.ApplyLuck(self: RNGServiceShared, _table: {[string]: RNGServiceUtils.WeightedTable}, luck: number?): {[string]: RNGServiceUtils.WeightedTable}
	luck = math.max(luck or 1, 1)
	if luck == 1 then
		return _table
	end
	local constant = self.LuckConstant or k
	
	local newTable = table.clone(_table)
	for i, v in _table do
		local tier = v.Tier or 1
		newTable[i].Weight = math.floor(v.Weight * (luck ^ (tier * constant)))
	end
	return newTable :: {[string]: RNGServiceUtils.WeightedTable}
end

type RNGServiceShared = typeof(RNGServiceShared) & {
	LuckConstant: number,
}

return RNGServiceShared :: RNGServiceShared
