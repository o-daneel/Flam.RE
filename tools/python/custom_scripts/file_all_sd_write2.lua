-- makes a 6 sec timer
local function timer_6s()
    for i = 1, 1000000 do
        print("hello")
    end
end

local function test01()
    file.open("/sd0/test01.txt", "w")
    file.write("hello")
    file.close()
end

local function test02()
    file.open("/SD0/test02.txt", "w")
    file.write("hello")
    file.close()
end

local function test11()
    file.open("/sd1/test11.txt", "w")
    file.write("hello")
    file.close()
end

local function test12()
    file.open("/SD1/test12.txt", "w")
    file.write("hello")
    file.close()
end

local function test21()
    file.open("/sd2/test21.txt", "w")
    file.write("hello")
    file.close()
end

local function test22()
    file.open("/SD2/test22.txt", "w")
    file.write("hello")
    file.close()
end

local function test31()
    file.open("/sd3/test31.txt", "w")
    file.write("hello")
    file.close()
end

local function test32()
    file.open("/SD3/test32.txt", "w")
    file.write("hello")
    file.close()
end

local function test3()
    file.open("/sd/test3.txt", "w")
    file.write("hello")
    file.close()
end

local function test4()
    file.open("/sdcard/test4.txt", "w")
    file.write("hello")
    file.close()
end

local function main()
    pcall(test01)
    pcall(test02)
    pcall(test11)
    pcall(test12)
    pcall(test21)
    pcall(test22)
    pcall(test31)
    pcall(test32)
    pcall(test3)
    pcall(test4)
    -- starting 6s timer to detect if code reach this level
    timer_6s()
end

main()
