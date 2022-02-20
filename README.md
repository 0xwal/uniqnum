# uniqnum

A simple way to get a random number/element in array that cannot be duplicated.

# Use cases

* Generating bucket numbers for FiveM
* Generating numeric ids that can be removed without effecting other numbers.

# Examples

## Random number

```lua
require('uniqnum.uniqnum')
local min     = 0
local max     = 3
local uniqnum = UniqNum.new(min, max) -- random numbers will be within (0, 1, 2, 3)
print(uniqnum:next()) -- maybe 0
print(uniqnum:next()) -- maybe 1
print(uniqnum:next()) -- maybe 2
print(uniqnum:next()) -- maybe 3
print(uniqnum:next()) -- throws error no more numbers

uniqnum:remove(2) -- free one number
print(uniqnum:next()) -- maybe 2
uniqnum:clear() -- free all numbers
```

## Random element in array

```lua
require('uniqnum.uniqnum')
local uniq = UniqNum.new({ 'a', 'b' })

print(uniq:next()) -- maybe a
print(uniq:next()) -- maybe b
print(uniq:next()) -- throws error no more free element
uniq:remove('a') -- free 'a'
print(uniq:next()) -- should be a
uniq:clear() -- free all reserved elements in array
```

# Install

The best way to use it as git submodule  
`git submodule add https://github.com/0xWaleed/uniqnum.git`
