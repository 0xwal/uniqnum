# uniqnum

A simple way to get a random number that cannot be duplicated.

# Use cases

* Generating bucket numbers for FiveM
* Generating numeric ids that can be removed without effecting other numbers.

# Examples

```lua
require('uniqnum.uniqnum')
local min = 0
local max = 3
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

# Install

The best way to use it as git submodule  
`git submodule add https://github.com/0xWaleed/uniqnum.git`
