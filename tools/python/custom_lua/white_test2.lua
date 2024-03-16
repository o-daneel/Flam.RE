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

local function fileExists(name)
    local f = io.open(name,"r")
    if f ~= nil then io.close(f) return true else return false end
end
 
local function main()
    print("test")
    timer6s()
end

main()