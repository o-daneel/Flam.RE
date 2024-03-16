--------------------------------------------------------------------------------
-- makes a 6 sec timer

local function timer6s()
    for i = 1, 1000000 do
        print("hello")
    end
end

-- makes a 12 sec timer
local function timer12s()
    for i = 1, 2000000 do
        print("hello")
    end
end

-- require("wifi")

local function main()
    -- starting 6s timer to detect if code reach this level
    timer6s()
    timer12s()
end

main()

----------------------------------------