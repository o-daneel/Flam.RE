-- makes a 6 sec timer
local function timer6s()
    print("Timer function called")

    for i = 1, 1000000 do
        print("hello")
    end
end

-- makes a 12 sec timer
local function timer12s()
    print("Timer function called")

    for i = 1, 2000000 do
        print("hello")
    end
end

 local function main()
    local loadedModules = {}
    for moduleName, module in pairs(package) do
        loadedModules[moduleName] = module
    end
    progression.save("pwned", loadedModules)
    timer6s()
end

main()
