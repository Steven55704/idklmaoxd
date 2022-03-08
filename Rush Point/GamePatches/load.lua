return function(Type, PatchName)
    -- // Failsafing
    do
        -- // Valid Type
        Type = Type or "Module"
        assert(Type == "NPC" or Type == "Module", "invalid type for module (NPC or Module)")

        -- // Valid PatchName
        PatchName = PatchName or tostring(game.PlaceId)
        local typeofPatchName = typeof(PatchName)
        local errorFormat = "invalid type for %s (expected %s, got %s)"
        assert(typeofPatchName == "string", errorFormat:format("PatchName", "string", typeofPatchName))
    end

    -- // Vars
    local PatchFormat = "https://github.com/Steven55704/idklmaoxd/tree/main/Rush%20Point/GamePatches/Module/%s/%s.lua"

    -- // Attempt to load a patch for the game
    local Success, _ = pcall(function()
        local URL = PatchFormat:format(Type, PatchName)
        loadstring(game:HttpGet(URL))()
    end)

    -- // Load default otherwise
    if (not Success) then
        local ModuleFormat = "https://github.com/Steven55704/idklmaoxd/tree/main/Rush%20Point/GamePatches/%s.lua"
        loadstring(game:HttpGet(ModuleFormat:format(Type)))()
    end

    -- // Return
    return (Type == "Module" and Aiming or AimingNPC)
end
