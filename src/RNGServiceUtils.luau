local HttpService = game:GetService("HttpService")

local RNGServiceUtils = {}

function RNGServiceUtils:GenerateRNG(): Random
	local Time = os.time()
	local Clock = os.clock()
	local GUID = HttpService:GenerateGUID(false)
	local Number = math.random()

	local Combined = tostring(Time) .. tostring(Clock) .. GUID .. tostring(Number)

	local Hash = 2166136261
	for i = 1, #Combined do
		Hash = bit32.bxor(Hash, string.byte(Combined, i))
		Hash = bit32.band(Hash * 16777619, 0xFFFFFFFF)
	end

	return Random.new(Hash)
end

function RNGServiceUtils:GetSum<T>(weights: Weights<T>): number
	local sum = 0

	for _, v: number in weights do
		sum += v
	end

	if sum == 0 then
		warn(`error: table doesn't contain any number: {debug.traceback()}`)
	end
	return sum
end

export type Weights<T> = { [T]: number }

type RNGServiceUtils = typeof(RNGServiceUtils)

return RNGServiceUtils :: RNGServiceUtils
