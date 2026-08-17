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
Credits: Stewiepfing on Youtube https://www.youtube.com/@stewiepfing

#### GetSum
```lua
local rarities = {
  Common = {
    Weight = 100,
    Tier = 0
  },
  Rare = {
    Weight = 50,
    Tier = 1
  }
}
```
Returns the sum of all weights inside the rarities table

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
local rarities = {
  Common = {
    Weight = 75,
    Tier = 0
  },
  Rare = {
    Weight = 25,
    Tier = 1
  }
}

local random = RNGServiceShared:GetRandomKey(rarities, luck)
-- returns a random key in weights table
print(random)
-- 75% chance of printing "Common" and 25% of printing "Rare" if luck is <=1 or nil
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

#### CallbackOnChance
```lua
RNGServiceShared:CallbackOnChance(5, function()
  print("Hi")
end)
-- 1 in 5 chance of executing print("Hi")

local bool = RNGServiceShared:CallbackOnChance(10, function()
  return true
end)
print(bool)
-- bool has a 1 in 10 chance of being true, else its just nil
```
Has a 1 in x chance of executing the given callback. If callback returns any value(s), CallbackOnChance returns them.

#### GetPercentage
```lua
local rarities = {
  Common = {
    Weight = 3,
    Tier = 0
  },
  Rare = {
    Weight = 1,
    Tier = 1
  }
}

local percentages = RNGServiceShared:GetPercentage(rarities, luck)
print(percentages)
--[[
prints if luck <= 1 or nil: {
  Common = 75,
  Rare = 25
}
]]
```
Returns a table containing all in percentage chance for the given weights table

#### ApplyLuck
```lua
local rarities = {
  Common = {
    Weight = 100,
    Tier = 0
  },
  Rare = {
    Weight = 50,
    Tier = 1
  }
}
local luck = 10

local newRarities = RNGServiceShared:ApplyLuck(rarities, luck)
print(newRarities)
--[[
prints: {
  Common = {
    Weight = 100,
    Tier = 0
  },
  Rare = {
    Weight = 158,
    Tier = 1
  }
}
]]
```
Returns a new weights table with the actual weights updated according to the luck inputed

## Info

### Weight
Weight is a number that indicates how common something should be. The higher the weight, the more common it will be.

### Tiers
Tier is a number that directly affects how much its chances are boosted for a certain luck value.
Example: If Weight = 50 and Tier = 0, at luck 2, Weight = 50 still (Tier 0 never changes the weight). If Weight = 50 and Tier = 1, at luck 2, Weight = 55 (if constant = 0.15)

## Credits
Stewiepfing for designing GenerateRNG(). https://www.youtube.com/@stewiepfing
