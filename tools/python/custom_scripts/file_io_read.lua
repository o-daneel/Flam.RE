-- makes a 6 sec timer
local function timer_6s()
  for i = 1, 1000000 do
    print("hello")
  end
end

local function test01()
  local dst = io.open("/sd0/.mdf", "rb")
  dst:close()
end
  

local function main()
    test01()
    -- starting 6s timer to detect if code reach this level
    timer_6s()
end

main()