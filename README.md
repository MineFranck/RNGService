# RNGService
RNGService allows you to easily create your own RNG systems for Roblox luau

## Utils
#### GenerateRNG
```lua
local random = RNGServiceUtils:GenerateRNG()
print(random:NextInteger(1, 5))
-- prints a random number from 1 to 5
```
Same use as math.random(), but prevents predictable rng.
Not pratical if only being used for basic stuff. Use if it directly affects the players data/gameplay.

#### GetSum
```lua
local weights = {
  Common = 100,
  Rare = 50,
}
local sum = RNGServiceUtils:GetSum(weights)
print(sum)
-- prints 150
```
Returns the sum of all weights inside the weights table

## Service
### Initialization
```lua
RNGServiceShared:Init(0.5)
-- RNGServiceShared.LuckConstant will be set to 0.5 (default 0.15)
```
If the service is not initialized, it still works, but LuckConstant will be set to 0.15 (recommended value).
As the service is shared, u have to init on both server and client if you want to change LuckConstant.
### Methods
#### GetRandomKey
```lua
local weights = {
  Common = 75,
  Rare = 25
}

local random = RNGServiceShared:GetRandomKey(weights)
-- returns a random key in weights table
print(random)
-- 75% chance of printing "Common" and 25% of printing "Rare"
```
Returns a random key from the given table

#### GetRandomFromArray
```lua
local array = {"apple", "orange", "banana"}
local random = RNGServiceShared:GetRandomFromArray(array)
print(random)
-- prints a random item from the array. in this case, 33.3% chance of printing any
```
Returns a random item from the given array, with each item having the same chance of being picked

#### GetRandomBoolean
```lua
local dropped = RNGServiceShared:GetRandomBoolean(100)
print(dropped)
-- 1 in 100 chance to print true
```
Higher chance to return true the lower the number is

#### GetPercentage
```lua
local weights = {
  Common = 8,
  Rare = 2,
}

local percentages = RNGServiceShared:GetPercentage(weights)
print(percentages)
--[[
prints: {
  Common = 80,
  Rare = 20
}
]]
```
Returns a table containing all in percentage chance for the given weights table

#### ApplyLuck
```lua
local weights = {
  Common = 100,
  Rare = 50
}
local tiers = {
  Common = 0,
  Rare = 1
}
local luck = 10
local constant = 0.5

local newWeights = RNGServiceShared:ApplyLuck(weights, luck, tiers, constant)
print(newWeights)
--[[
prints: {
  Common = 100,
  Rare = 158
}
]]
```
Returns a new weights table with the actual weights updated according to the luck inputed
