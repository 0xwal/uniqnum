---
--- Created By 0xWaleed <https://github.com/0xWaleed>
--- DateTime: 14/02/2022 8:46 AM
---

math.randomseed(os.time())

local function internal_uniqnum_random(store, min, max, itemsCount)
    local n = math.random(min, max)

    if itemsCount > max then
        error('Could not get a unique number')
    end

    if store[n] then
        return internal_uniqnum_random(store, min, max, itemsCount)
    end

    store[n] = true

    return n
end

UniqNum         = {}
UniqNum.__index = UniqNum

function UniqNum:numbers()
    return self._numbers
end

function UniqNum:max()
    return self._max
end

function UniqNum:min()
    return self._min
end

function UniqNum:itemsCount()
    return self._itemsCount
end

function UniqNum:next()
    self._itemsCount = self._itemsCount + 1
    return internal_uniqnum_random(self:numbers(), self:min(), self:max(), self:itemsCount())
end

function UniqNum:remove(number)
    self._itemsCount      = self._itemsCount - 1
    self._numbers[number] = nil
end

function UniqNum:clear()
    self._itemsCount = 0
    self._numbers    = {}
end

function UniqNum.new(min, max)
    local this       = setmetatable({}, UniqNum)
    this._min        = min or 0
    this._max        = max or (2 ^ 31)
    this._numbers    = {}
    this._itemsCount = 0
    return this
end

function uniqnum_random(min, max)
    local o = UniqNum.new(min, max)
    return o:next()
end

