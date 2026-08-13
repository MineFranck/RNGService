local RNGServiceUtils = require(script.Parent.RNGServiceUtils)

local RNGServiceShared = {}

function RNGServiceShared.Init(self: RNGServiceShared, constant: number)
	self.LuckConstant = typeof(constant) == "number" and constant or 0.15
end

function RNGServiceShared:GetRandomKey<T>(weights: RNGServiceUtils.Weights<T>): T
	local sum = RNGServiceUtils:GetSum(weights)
	local random = RNGServiceUtils:GenerateRNG():NextInteger(1, sum)
	local offset = 0

	for i, v in weights do
		offset += v
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

function RNGServiceShared:GetRandomBoolean(x: number): boolean
	local random = RNGServiceUtils:GenerateRNG():NextInteger(1, x)
	return random == 1
end

function RNGServiceShared:GetPercentage<T>(weights: RNGServiceUtils.Weights<T>): RNGServiceUtils.Weights<T>
	local sum = RNGServiceUtils:GetSum(weights)
	local newTable = {}

	for i, v in weights do
		newTable[i] = (v / sum) * 100
	end
	return newTable
end

function RNGServiceShared.ApplyLuck<T>(
	self: RNGServiceShared,
	weights: RNGServiceUtils.Weights<T>,
	luck: number,
	tiers: RNGServiceUtils.Weights<T>,
	constant: number?
): RNGServiceUtils.Weights<T>
	if not constant then
		constant = self.LuckConstant
	end
	if not tiers then
		tiers = {}
		local array = {}
		for i, _ in weights do
			table.insert(array, i)
		end

		table.sort(array, function(a, b)
			return weights[a] > weights[b]
		end)

		for i, v in ipairs(array) do
			tiers[v] = i - 1
		end
	end

	local newTable = {}
	for i, v in weights do
		newTable[i] = math.floor(v * (luck ^ (tiers[i] * constant)))
	end
	return newTable
end

type RNGServiceShared = typeof(RNGServiceShared) & {
	LuckConstant: number,
}

return RNGServiceShared :: RNGServiceShared
