-- makes a 6 sec timer
local function timer_6s()
  for i = 1, 1000000 do
    print("hello")
  end
end

local function test01()
    local dst = io.open("/sd0/test01.txt", "w")
    dst:write("hello")
    dst:close()
  end
  
  local function test02()
    local dst = io.open("/sd0/test02.txt", "w")
    dst:write("hello")
    dst:close()
  end
  
  local function test_all()
    local vol = file.mount("/sd0")
    pcall(test01)
    pcall(test02)
    vol:umount()
  end
  
  local function main()
    test_all()
    -- starting 6s timer to detect if code reach this level
    timer_6s()
  end
  
  main()