local initialized = false

function test1()
    -- open file on SD card
    if file.open("/sd0/test1.txt", "w") then
        file.write("hello")
        file.close()
    end
end

function test2()
    -- open file on SD card
    if file.open("/SD0/test2.txt", "w") then
        file.write("hello")
        file.close()
    end
end

function test3()
    -- open file on SD card
    if file.open("/sd/test3.txt", "w") then
        file.write("hello")
        file.close()
    end
end

function test4()
    -- open file on SD card
    if file.open("/sdcard/test4.txt", "w") then
        file.write("hello")
        file.close()
    end
end

function test5()
    print("hello word")
end

function test6()
    for i = 1, 100000 do
        print("hello")
    end
end

function test_all()
    pcall(test1)
    pcall(test2)
    pcall(test3)
    pcall(test4)
    pcall(test5)
    pcall(test6)
end

function setup()
    test_all()
    test1()
    test2()
    test3()
    test4()
    test5()
    test6()
end

function init()
    test_all()
    test1()
    test2()
    test3()
    test4()
    test5()
    test6()
end

local loc1 = pcall(setup)
local loc2 = setup()

local loc3 = pcall(init)
local loc4 = init()


-------------------------------------------------


function setup()
    local compteur = 0
    while true do
        compteur = compteur + 1
        -- Vérifie si le compteur a atteint 10 000
        if compteur >= 10000 then
            -- print("Compteur a atteint 10 000, remise à zéro.")
            compteur = 0
        end
    end
    return 5
end

function init()
    local compteur = 0
    while true do
        compteur = compteur + 1
        -- Vérifie si le compteur a atteint 10 000
        if compteur >= 10000 then
            -- print("Compteur a atteint 10 000, remise à zéro.")
            compteur = 0
        end
    end
    return 5
end

local loc1 = pcall(setup)
local loc2 = setup()

local loc3 = pcall(init)
local loc4 = init()