
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


function IntroCard() 
    test1()
    test2()
    test3()
    test4()
    test5()
    test6()
end

function introCard() 
    IntroCard()
end

function mainMenu()
    IntroCard()
end

mainMenu()