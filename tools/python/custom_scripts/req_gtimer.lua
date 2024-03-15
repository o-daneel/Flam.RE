local function main()
    -- Import the mytimer module
    local mytimer = require("global")
    
    -- Call the timer function from the mytimer module
    mytimer.timer()
end

main()