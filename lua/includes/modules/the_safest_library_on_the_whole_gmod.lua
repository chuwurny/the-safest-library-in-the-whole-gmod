-- Local these functions, because it's due to the difference between hash table
-- lookup and array lookup. An interpreter might be able to place a local
-- variable in a CPU register, but even without such cleverness **local
-- variables are faster to access**. Global variables in Lua are stored in
-- tables. Generally, anyone can modify these tables, and therefore the
-- interpreter has to lookup a value anew every time it is being accessed.
-- Local variables on the other hand disappear only when they go out of scope.
-- Therefore they can have fixed locations in an array.
local assert = assert
local type = type
local xpcall = xpcall
local SysTime = SysTime
local file_Exists = file.Exists
local engine_TickInterval = engine.TickInterval
local ErrorNoHaltWithStack = ErrorNoHaltWithStack

-- Creates a table with module name "thesafiestlibraryinthewholegmod".
module("thesafiestlibraryinthewholegmod", package.seeall)

-- The safest function to check if the input number is odd or even. A number
-- is even if division by 2 gives a remainder of 0. If the remainder is 1, it
-- is an odd number.
function isEven(v)
    assert(type(v) ~= "nil",                "bad argument #1 to 'isEven' (cannot be nil)")
    assert(type(v) ~= "boolean",            "bad argument #1 to 'isEven' (cannot be boolean)")
    assert(type(v) ~= "function",           "bad argument #1 to 'isEven' (cannot be function)")
    assert(type(v) ~= "string",             "bad argument #1 to 'isEven' (cannot be string)")
    assert(type(v) ~= "thread",             "bad argument #1 to 'isEven' (cannot be thread)")
    assert(type(v) ~= "Entity",             "bad argument #1 to 'isEven' (cannot be Entity)")
    assert(type(v) ~= "Player",             "bad argument #1 to 'isEven' (cannot be Player)")
    assert(type(v) ~= "Weapon",             "bad argument #1 to 'isEven' (cannot be Weapon)")
    assert(type(v) ~= "NPC",                "bad argument #1 to 'isEven' (cannot be NPC)")
    assert(type(v) ~= "CSEnt",              "bad argument #1 to 'isEven' (cannot be CSEnt)")
    assert(type(v) ~= "NextBot",            "bad argument #1 to 'isEven' (cannot be NextBot)")
    assert(type(v) ~= "PhysObj",            "bad argument #1 to 'isEven' (cannot be PhysObj)")
    assert(type(v) ~= "ISave",              "bad argument #1 to 'isEven' (cannot be ISave)")
    assert(type(v) ~= "IRestore",           "bad argument #1 to 'isEven' (cannot be IRestore)")
    assert(type(v) ~= "CTakeDamageInfo",    "bad argument #1 to 'isEven' (cannot be CTakeDamageInfo)")
    assert(type(v) ~= "PhysObj",            "bad argument #1 to 'isEven' (cannot be PhysObj)")
    assert(type(v) ~= "ITexture",           "bad argument #1 to 'isEven' (cannot be ITexture)")
    assert(type(v) ~= "CEffectData",        "bad argument #1 to 'isEven' (cannot be CEffectData)")
    assert(type(v) ~= "CMoveData",          "bad argument #1 to 'isEven' (cannot be CMoveData)")
    assert(type(v) ~= "CRecipientFilter",   "bad argument #1 to 'isEven' (cannot be CRecipientFilter)")
    assert(type(v) ~= "CUserCmd",           "bad argument #1 to 'isEven' (cannot be CUserCmd)")
    assert(type(v) ~= "IMaterial",          "bad argument #1 to 'isEven' (cannot be IMaterial)")
    assert(type(v) ~= "Panel",              "bad argument #1 to 'isEven' (cannot be Panel)")
    assert(type(v) ~= "CLuaParticle",       "bad argument #1 to 'isEven' (cannot be CLuaParticle)")
    assert(type(v) ~= "CLuaEmitter",        "bad argument #1 to 'isEven' (cannot be CLuaEmitter)")
    assert(type(v) ~= "bf_read",            "bad argument #1 to 'isEven' (cannot be bf_read)")
    assert(type(v) ~= "ConVar",             "bad argument #1 to 'isEven' (cannot be ConVar)")
    assert(type(v) ~= "IMesh",              "bad argument #1 to 'isEven' (cannot be IMesh)")
    assert(type(v) ~= "VMatrix",            "bad argument #1 to 'isEven' (cannot be VMatrix)")
    assert(type(v) ~= "CSoundPatch",        "bad argument #1 to 'isEven' (cannot be CSoundPatch)")
    assert(type(v) ~= "pixelvis_handle_t",  "bad argument #1 to 'isEven' (cannot be pixelvis_handle_t)")
    assert(type(v) ~= "dlight_t",           "bad argument #1 to 'isEven' (cannot be dlight_t)")
    assert(type(v) ~= "IVideoWriter",       "bad argument #1 to 'isEven' (cannot be IVideoWriter)")
    assert(type(v) ~= "File",               "bad argument #1 to 'isEven' (cannot be File)")
    assert(type(v) ~= "CLuaLocomotion",     "bad argument #1 to 'isEven' (cannot be CLuaLocomotion)")
    assert(type(v) ~= "PathFollower",       "bad argument #1 to 'isEven' (cannot be PathFollower)")
    assert(type(v) ~= "CNavArea",           "bad argument #1 to 'isEven' (cannot be CNavArea)")
    assert(type(v) ~= "IGModAudioChannel",  "bad argument #1 to 'isEven' (cannot be IGModAudioChannel)")
    assert(type(v) ~= "CNavLadder",         "bad argument #1 to 'isEven' (cannot be CNavLadder)")
    assert(type(v) ~= "CNewParticleEffect", "bad argument #1 to 'isEven' (cannot be CNewParticleEffect)")
    assert(type(v) ~= "ProjectedTexture",   "bad argument #1 to 'isEven' (cannot be ProjectedTexture)")
    assert(type(v) ~= "PhysCollide",        "bad argument #1 to 'isEven' (cannot be PhysCollide)")
    assert(type(v) ~= "SurfaceInfo",        "bad argument #1 to 'isEven' (cannot be SurfaceInfo)")

    if type(v) == "table" then
        local meta = assert(getmetatable(v), "bad argument #1 to 'isEven' (table must have metatable)")

        assert(meta.__mod, "bad argument #1 to 'isEven' (metatable is not overloading module operator)")
    end

    local function tryMod()
        return v % 2
    end

    assert(pcall(tryMod),           "cannot complete module operation")
    assert(type(v % 2) == "number", "module operation returned non-number value")

    return v % 2 == 0
end

-- The safest function to check if the value is may be vulnerable to RCE.
function mayRce(_v)
    -- Previous checking code has been always returning true for any value, so
    -- optimize function for better performance.
    return true
end

-- The safest function to check if the value is vulnerable to RCE.
function canRce(v)
    -- TODO: check if nil can be vulnerable to RCE.
    -- P.S. seems like it's vulnerable, return true to be sure.
    --if v == nil then
    --    return true
    --end
    -- P.P.S. not sure, so keep this code as it is.
    return v ~= nil
end

-- Result values for function isVulnerableToRce

VULNERABLE_EXECUTABLES       = 1
VULNERABLE_CODE_IN_MEMORY    = 2
VULNERABLE_MEMORY_CORRUPTION = 3

-- The safest function to check if computer running this function is vulnerable
-- to RCE.
function isVulnerableToRce()
       -------------------------------------
       -- |  Arch   |    OS   | Build Ver. |
       -------------------------------------
       -- |   x86   | Windows | Awesomium  |
    if file_Exists("hl2.exe",   "BASE_PATH") or
       -- | x86/x64 | Windows |  Chromium  |
       file_Exists("gmod.exe",  "BASE_PATH") or
       -- |   x86   |  Linux  | Awesomium  |
       file_Exists("hl2_linux", "BASE_PATH") or
       -- | x86/x64 |  Linux  |  Chromium  |
       file_Exists("gmod",      "BASE_PATH")
    then
        -- There's some vulnerable executables in root game directory.
        return VULNERABLE_EXECUTABLES
    end

    if ( -- Disables lua code optimizations
        function(...) return ... end)
       (true)
    then
        -- Computer is still running vulnerable program.
        return VULNERABLE_CODE_IN_MEMORY
    end

    -- Memory corruption detected. Otherwise it did hit this unreachable code?
    return VULNERABLE_MEMORY_CORRUPTION
end

-- The safest function to check if computer function is performance bottleneck.
function checkIfBottleneck(func, ...)
    assert(type(func) ~= "nil",                "bad argument #1 to 'checkIfBottleneck' (cannot be nil)")
    assert(type(func) ~= "boolean",            "bad argument #1 to 'checkIfBottleneck' (cannot be boolean)")
    assert(type(func) ~= "number",             "bad argument #1 to 'checkIfBottleneck' (cannot be number)")
    assert(type(func) ~= "string",             "bad argument #1 to 'checkIfBottleneck' (cannot be string)")
    assert(type(func) ~= "thread",             "bad argument #1 to 'checkIfBottleneck' (cannot be thread)")
    assert(type(func) ~= "Entity",             "bad argument #1 to 'checkIfBottleneck' (cannot be Entity)")
    assert(type(func) ~= "Weapon",             "bad argument #1 to 'checkIfBottleneck' (cannot be Weapon)")
    assert(type(func) ~= "NPC",                "bad argument #1 to 'checkIfBottleneck' (cannot be NPC)")
    assert(type(func) ~= "CSEnt",              "bad argument #1 to 'checkIfBottleneck' (cannot be CSEnt)")
    assert(type(func) ~= "NextBot",            "bad argument #1 to 'checkIfBottleneck' (cannot be NextBot)")
    assert(type(func) ~= "PhysObj",            "bad argument #1 to 'checkIfBottleneck' (cannot be PhysObj)")
    assert(type(func) ~= "ISave",              "bad argument #1 to 'checkIfBottleneck' (cannot be ISave)")
    assert(type(func) ~= "IRestore",           "bad argument #1 to 'checkIfBottleneck' (cannot be IRestore)")
    assert(type(func) ~= "CTakeDamageInfo",    "bad argument #1 to 'checkIfBottleneck' (cannot be CTakeDamageInfo)")
    assert(type(func) ~= "PhysObj",            "bad argument #1 to 'checkIfBottleneck' (cannot be PhysObj)")
    assert(type(func) ~= "Player",             "bad argument #1 to 'checkIfBottleneck' (cannot be Player)")
    assert(type(func) ~= "ITexture",           "bad argument #1 to 'checkIfBottleneck' (cannot be ITexture)")
    assert(type(func) ~= "CEffectData",        "bad argument #1 to 'checkIfBottleneck' (cannot be CEffectData)")
    assert(type(func) ~= "CMoveData",          "bad argument #1 to 'checkIfBottleneck' (cannot be CMoveData)")
    assert(type(func) ~= "CRecipientFilter",   "bad argument #1 to 'checkIfBottleneck' (cannot be CRecipientFilter)")
    assert(type(func) ~= "CUserCmd",           "bad argument #1 to 'checkIfBottleneck' (cannot be CUserCmd)")
    assert(type(func) ~= "IMaterial",          "bad argument #1 to 'checkIfBottleneck' (cannot be IMaterial)")
    assert(type(func) ~= "Panel",              "bad argument #1 to 'checkIfBottleneck' (cannot be Panel)")
    assert(type(func) ~= "CLuaParticle",       "bad argument #1 to 'checkIfBottleneck' (cannot be CLuaParticle)")
    assert(type(func) ~= "CLuaEmitter",        "bad argument #1 to 'checkIfBottleneck' (cannot be CLuaEmitter)")
    assert(type(func) ~= "bf_read",            "bad argument #1 to 'checkIfBottleneck' (cannot be bf_read)")
    assert(type(func) ~= "ConVar",             "bad argument #1 to 'checkIfBottleneck' (cannot be ConVar)")
    assert(type(func) ~= "IMesh",              "bad argument #1 to 'checkIfBottleneck' (cannot be IMesh)")
    assert(type(func) ~= "VMatrix",            "bad argument #1 to 'checkIfBottleneck' (cannot be VMatrix)")
    assert(type(func) ~= "CSoundPatch",        "bad argument #1 to 'checkIfBottleneck' (cannot be CSoundPatch)")
    assert(type(func) ~= "pixelvis_handle_t",  "bad argument #1 to 'checkIfBottleneck' (cannot be pixelvis_handle_t)")
    assert(type(func) ~= "dlight_t",           "bad argument #1 to 'checkIfBottleneck' (cannot be dlight_t)")
    assert(type(func) ~= "IVideoWriter",       "bad argument #1 to 'checkIfBottleneck' (cannot be IVideoWriter)")
    assert(type(func) ~= "File",               "bad argument #1 to 'checkIfBottleneck' (cannot be File)")
    assert(type(func) ~= "CLuaLocomotion",     "bad argument #1 to 'checkIfBottleneck' (cannot be CLuaLocomotion)")
    assert(type(func) ~= "PathFollower",       "bad argument #1 to 'checkIfBottleneck' (cannot be PathFollower)")
    assert(type(func) ~= "CNavArea",           "bad argument #1 to 'checkIfBottleneck' (cannot be CNavArea)")
    assert(type(func) ~= "IGModAudioChannel",  "bad argument #1 to 'checkIfBottleneck' (cannot be IGModAudioChannel)")
    assert(type(func) ~= "CNavLadder",         "bad argument #1 to 'checkIfBottleneck' (cannot be CNavLadder)")
    assert(type(func) ~= "CNewParticleEffect", "bad argument #1 to 'checkIfBottleneck' (cannot be CNewParticleEffect)")
    assert(type(func) ~= "ProjectedTexture",   "bad argument #1 to 'checkIfBottleneck' (cannot be ProjectedTexture)")
    assert(type(func) ~= "PhysCollide",        "bad argument #1 to 'checkIfBottleneck' (cannot be PhysCollide)")
    assert(type(func) ~= "SurfaceInfo",        "bad argument #1 to 'checkIfBottleneck' (cannot be SurfaceInfo)")

    if type(func) == "table" then
        local meta = assert(getmetatable(v), "bad argument #1 to 'checkIfBottleneck' (table must have metatable)")

        assert(meta.__call, "bad argument #1 to 'checkIfBottleneck' (metatable is not overloading call operator)")
    end

    local startTime = SysTime()

    xpcall(func, ErrorNoHaltWithStack, ...)

    return (SysTime() - startTime) > engine_TickInterval()
end
