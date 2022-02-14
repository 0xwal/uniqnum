---
--- Created By 0xWaleed <https://github.com/0xWaleed>
--- DateTime: 14/02/2022 8:45 AM
---

local function hard_require(module)
    local r                = require(module)
    package.loaded[module] = nil
    return r
end

describe('uniqnum', function()
    before_each(function()
        hard_require('uniqnum')
    end)

    describe('uniqnum_random', function()
        it('exist', function()
            assert.is_function(uniqnum_random)
        end)

        it('returns a number', function()
            local n = uniqnum_random()
            assert.is_number(n)
        end)

        it('should not return the same number', function()
            local n1 = uniqnum_random()
            local n2 = uniqnum_random()
            assert.is_not_same(n1, n2)
        end)

        it('should able to set the minimum number', function()
            local min  = 1
            local max  = 5
            local uniq = UniqNum.new(min, max)
            for _ = 1, max do
                assert.is_true(uniq:next() >= min)
            end
        end)

        it('should able to set the maximum number', function()
            local min  = 1
            local max  = 5
            local uniq = UniqNum.new(min, max)
            for _ = 1, max do
                assert.is_true(uniq:next() <= max)
            end
        end)

        it('should able to remove an item', function()
            local min  = 1
            local max  = 2
            local uniq = UniqNum.new(min, max)
            uniq:next()
            local i = uniq:next()
            uniq:remove(i)
            assert.was_no_error(function()
                uniq:next()
            end)
            assert.is_equal(2, uniq:itemsCount())
        end)

        it('should able to clear all items', function()
            local min  = 1
            local max  = 2
            local uniq = UniqNum.new(min, max)
            uniq:next()
            uniq:next()
            uniq:clear()
            assert.was_no_error(function()
                uniq:next()
                uniq:next()
            end)
            assert.is_equal(2, uniq:itemsCount())
        end)
    end)
end)
