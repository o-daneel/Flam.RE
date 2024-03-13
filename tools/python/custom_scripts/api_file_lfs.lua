-- makes a 6 sec timer
local function timer_6s()
  for i = 1, 1000000 do
    print("hello")
  end
end

file = require("file_lfs")

local function main()
    local dst = file.open(".mdf")
    if dst then
        timer_6s()
    end
    -- starting 6s timer to detect if code reach this level
    timer_6s()
end

main()