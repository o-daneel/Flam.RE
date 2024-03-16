----------------------------------------
-- makes a 12 sec timer

local function timer12s()
    for i = 1, 2000000 do
        print("hello")
    end
end


local function main()
    -- starting 12s timer to detect if code reach this level
    timer12s()
end

main()

----------------------------------------