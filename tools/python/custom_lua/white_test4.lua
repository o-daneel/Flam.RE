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
    local f = io.open(name, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

local function main()
    local scripts = {"/sd/usr/0/a6c67c68-2db7-4713-9cf9-0d0e33336bc8.prog",
                     "/sdcard/usr/0/a6c67c68-2db7-4713-9cf9-0d0e33336bc8.prog",
                     "/usr/0/a6c67c68-2db7-4713-9cf9-0d0e33336bc8.prog",
                     "/sd0/usr/0/a6c67c68-2db7-4713-9cf9-0d0e33336bc8.prog",
                     "/SD0/usr/0/a6c67c68-2db7-4713-9cf9-0d0e33336bc8.prog",
                     "/sd1/usr/0/a6c67c68-2db7-4713-9cf9-0d0e33336bc8.prog",
                     "/SD1/usr/0/a6c67c68-2db7-4713-9cf9-0d0e33336bc8.prog"}

    for index, script in pairs(scripts) do
        if fileExists(script) then
            timer6s()
        end
    end

    timer6s()
end

main()
