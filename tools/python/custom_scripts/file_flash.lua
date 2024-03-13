-- makes a 6 sec timer
local function timer_6s()
    for i = 1, 1000000 do
        print("hello")
    end
end

local function test_flash()
    if file.open("/FLASH/init.lua") then
        timer_6s()
        file.close()
    end
end

local function main()
    test_flash()
end

main()
