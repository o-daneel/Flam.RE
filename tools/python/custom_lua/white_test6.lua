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
    uart.setup(uart.CONSOLE, 115200, 8, uart.PARNONE, uart.STOP1)
    uart.write(uart.CONSOLE, "hello\r\n")

    timer6s()
end

main()
