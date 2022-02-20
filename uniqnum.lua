---
--- Created By 0xWaleed <https://github.com/0xWaleed>
--- DateTime: 14/02/2022 8:46 AM
---

function uniqnum_seed()
    return os.time()
end
math.randomseed(uniqnum_seed())

local function internal_uniqnum_random_numbers(store, min, max, itemsCount, threshold)
    local n = math.random(min, max)

    if threshold < itemsCount then
        error('Could not get a unique number')
    end

    if store[n] then
        return internal_uniqnum_random_numbers(store, min, max, itemsCount, threshold)
    end

    store[n] = true

    return n
end

local function internal_uniqnum_random_table(store, min, max, itemsCount, threshold, elements)
    local n = math.random(min, max)

    if threshold < itemsCount then
        error('No more elements.')
    end

    local element = elements[n]

    if store[element] then
        return internal_uniqnum_random_table(store, min, max, itemsCount, threshold, elements)
    end

    store[element] = true

    return element
end

UniqNum         = {}
UniqNum.__index = UniqNum

function UniqNum:numbers()
    return self._reservedItems
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
    local threshold  = self:max() - self:min()
    local n          = self._internal_random_func(self:numbers(), self:min(), self:max(), self:itemsCount(), threshold, self._elements)
    self._itemsCount = self._itemsCount + 1
    return n
end

function UniqNum:remove(number)
    self._itemsCount            = self._itemsCount - 1
    self._reservedItems[number] = nil
end

function UniqNum:clear()
    self._itemsCount    = 0
    self._reservedItems = {}
end

function UniqNum.new(min, max)
    local this = setmetatable({}, UniqNum)

    if type(min) == 'table' then
        this._min                  = 1
        this._max                  = #min
        this._internal_random_func = internal_uniqnum_random_table
        this._elements             = min
    else
        this._internal_random_func = internal_uniqnum_random_numbers
        this._min                  = min or 0
        this._max                  = max or (2 ^ 31)
    end

    this._reservedItems = {}
    this._itemsCount    = 0
    return this
end

function uniqnum_random(min, max)
    local o = UniqNum.new(min, max)
    return o:next()
end

