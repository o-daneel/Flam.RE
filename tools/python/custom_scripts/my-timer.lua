---@class global
local global = {}
global.__index = global

-- makes a 6 sec timer
function global.timer()
    print("Timer function called")

    for i = 1, 1000000 do
        print("hello")
    end
end

return global