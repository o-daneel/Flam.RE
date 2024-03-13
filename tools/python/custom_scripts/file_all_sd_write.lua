-- makes a 6 sec timer
local function timer_6s()
    for i = 1, 1000000 do
        print("hello")
    end
end

local function test01()
    local dst = file.open("/sd0/test01.txt", "w")
    dst:write("hello")
    dst:close()
end

local function test02()
    local dst = file.open("/SD0/test02.txt", "w")
    dst:write("hello")
    dst:close()
end

local function test11()
    local dst = file.open("/sd1/test11.txt", "w")
    dst:write("hello")
    dst:close()
end

local function test12()
    local dst = file.open("/SD1/test12.txt", "w")
    dst:write("hello")
    dst:close()
end

local function test21()
    local dst = file.open("/sd2/test21.txt", "w")
    dst:write("hello")
    dst:close()
end

local function test22()
    local dst = file.open("/SD2/test22.txt", "w")
    dst:write("hello")
    dst:close()
end

local function test31()
    local dst = file.open("/sd3/test31.txt", "w")
    dst:write("hello")
    dst:close()
end

local function test32()
    local dst = file.open("/SD3/test32.txt", "w")
    dst:write("hello")
    dst:close()
end

local function test3()
    local dst = file.open("/sd/test3.txt", "w")
    dst:write("hello")
    dst:close()
end

local function test4()
    local dst = file.open("/sdcard/test4.txt", "w")
    dst:write("hello")
    dst:close()
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
