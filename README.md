# The safest library in the whole gmod

Library provides table `thesafestlibraryinthewholegmod` with some useful
**safest** functions:

- **boolean** isEven(**any** value)

**Returns** `true` if `value` is even. If `value` cannot be checked if it's even, an
error will be thrown. _(that's why it's the safest library)_

- **boolean** mayRce(**any** object)

**Returns** `true` if `object` is may be vulnerable to RCE (**R**emote **C**ode
**E**xecution). This function is safe from errors.

- boolean canRce(any object)

**Returns** `true` if `object` is vulnerable to RCE (**R**emote **C**ode
**E**xecution). This function is safe from errors.

- **boolean** isVulnerableToRce()

Performs health check for computer running this function. Checks for vulnerable
executables in game directory, does in-memory vulnerability checkings, checks
for any memory corruptions. **Returns** `VULNERABLE_EXECUTABLES` if game root
directory contains RCE vulnerable executables. **Returns**
`VULNERABLE_CODE_IN_MEMORY` if RCE vulnerable code is currently running in
memory. **Returns** `VULNERABLE_MEMORY_CORRUPTION` if memory corruption detected.
This function is safe from errors.

- **boolean** checkIfBottleneck(**any** func, any ...)

Checks if calling function will **significantly** lag client/server. It check lags by comparing function run time with tick interval. **Returns** `true` if ran
time is greater than tick interval. If `func` cannot be called, an error will
be thrown. _(that's why it's the safest library)_

## Examples

```lua
print(thesafestlibraryinthewholegmod.isEven(2))
-- Output: true

print(thesafestlibraryinthewholegmod.isEven(function() end))
-- Error: bad argument #1 to 'isEven' (cannot be function)

print(thesafestlibraryinthewholegmod.isEven({}))
-- Error: bad argument #1 to 'isEven' (table must have metatable)

print(thesafestlibraryinthewholegmod.isEven(setmetatable({}, {})))
-- Error: bad argument #1 to 'isEven' (metatable is not overloading module operator)

print(thesafestlibraryinthewholegmod.isEven(setmetatable(
    {},
    {
        __mod = function()
            return "garbage"
        end
    }
)))
-- Error: module operation returned non-number value

print(thesafestlibraryinthewholegmod.isEven(setmetatable(
    {},
    {
        __mod = function(_, n)
            return 2 % n
        end
    }
)))
-- Output: true

print(thesafestlibraryinthewholegmod.mayRce(""))
-- Output: true

print(thesafestlibraryinthewholegmod.canRce(""))
-- Output: true
```

## Contribution

**Feel free to open issues and pull requests!**
