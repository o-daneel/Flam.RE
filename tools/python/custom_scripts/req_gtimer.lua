local function timer6s()
    for i = 1, 1000000 do
        print("hello")
    end
end

function setup()
    require("global")
end

local function main()
    -- Import the mytimer module
    
    timer6s()

    -- -- Call the timer function from the Global module
    -- Global.timer()
end

setup()
main()
