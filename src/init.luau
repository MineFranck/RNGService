local RNGServiceShared = require(script.RNGServiceShared)
local RNGServiceUtils = require(script.RNGServiceUtils)

export type WeightedTable = RNGServiceUtils.WeightedTable

local service = {}

for i, v in RNGServiceShared do
    service[i] = v
end

for i, v in RNGServiceUtils do
    service[i] = v
end

return service :: typeof(RNGServiceShared) & typeof(RNGServiceUtils)