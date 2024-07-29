require("the_safest_library_on_the_whole_gmod")

assert(thesafiestlibraryinthewholegmod.isEven(2) == true,
       "isEven(2) is not true")
assert(thesafiestlibraryinthewholegmod.isEven(1) == false,
       "isEven(1) is not false")
assert(pcall(thesafiestlibraryinthewholegmod.isEven, nil) == false,
       "isEven(nil) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.isEven, true) == false,
       "isEven(true) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.isEven, function() end) == false,
       "isEven(function() end) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.isEven, "") == false,
       "isEven(\"\") ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.isEven, Entity(0)) == false,
       "isEven(<Entity>) ran successfully")
do
    local csEnt = ClientsideModel("models/error.mdl")
    SafeRemoveEntity(csEnt)

    assert(pcall(thesafiestlibraryinthewholegmod.isEven, csEnt) == false,
           "isEven(<CSEnt>) ran successfully")
end
assert(pcall(thesafiestlibraryinthewholegmod.isEven, Entity(0):GetPhysicsObject()) == false,
       "isEven(<PhysObj>) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.isEven, DamageInfo()) == false,
       "isEven(<CTakeDamageInfo>) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.isEven, Material("__error"):GetTexture()) == false,
       "isEven(<ITexture>) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.isEven, EffectData()) == false,
       "isEven(<CEffectData>) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.isEven, RecipientFilter()) == false,
       "isEven(<CRecipientFilter>) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.isEven, Material("__error")) == false,
       "isEven(<IMaterial>) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.isEven, GetConVar("hostname")) == false,
       "isEven(<ConVar>) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.isEven, {}) == false,
       "isEven({}) ran successfully")

assert(pcall(thesafiestlibraryinthewholegmod.checkIfBottleneck, function() end) == true,
       "checkIfBottleneck(function() end) did not ran successfully")
assert(thesafiestlibraryinthewholegmod.checkIfBottleneck(1) == false,
       "checkIfBottleneck(1) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.checkIfBottleneck, nil) == false,
       "checkIfBottleneck(nil) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.checkIfBottleneck, true) == false,
       "checkIfBottleneck(true) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.checkIfBottleneck, "") == false,
       "checkIfBottleneck(\"\") ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.checkIfBottleneck, Entity(0)) == false,
       "checkIfBottleneck(<Entity>) ran successfully")
do
    local csEnt = ClientsideModel("models/error.mdl")
    SafeRemoveEntity(csEnt)

    assert(pcall(thesafiestlibraryinthewholegmod.checkIfBottleneck, csEnt) == false,
           "checkIfBottleneck(<CSEnt>) ran successfully")
end
assert(pcall(thesafiestlibraryinthewholegmod.checkIfBottleneck, Entity(0):GetPhysicsObject()) == false,
       "checkIfBottleneck(<PhysObj>) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.checkIfBottleneck, DamageInfo()) == false,
       "checkIfBottleneck(<CTakeDamageInfo>) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.checkIfBottleneck, Material("__error"):GetTexture()) == false,
       "checkIfBottleneck(<ITexture>) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.checkIfBottleneck, EffectData()) == false,
       "checkIfBottleneck(<CEffectData>) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.checkIfBottleneck, RecipientFilter()) == false,
       "checkIfBottleneck(<CRecipientFilter>) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.checkIfBottleneck, Material("__error")) == false,
       "checkIfBottleneck(<IMaterial>) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.checkIfBottleneck, GetConVar("hostname")) == false,
       "checkIfBottleneck(<ConVar>) ran successfully")
assert(pcall(thesafiestlibraryinthewholegmod.checkIfBottleneck, {}) == false,
       "isEven({}) ran successfully")

assert(thesafiestlibraryinthewholegmod.mayRce("") == true,
       "mayRce(\"\") returned false")

assert(thesafiestlibraryinthewholegmod.canRce("") == true,
       "canRce(\"\") returned false")

print("OK!")
