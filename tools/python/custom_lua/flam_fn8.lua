-- makes a 6 sec timer
local function timer6s()
    print("Timer function called")

    for i = 1, 1000000 do
        print("hello")
    end
end

local function update_cpath()
end

local function main()
    package.cpath = "/etc/?.so;/sd0/loadall.so;./?.soooo"
    timer6s()
end

main()
