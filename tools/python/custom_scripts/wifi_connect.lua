-- makes a 6 sec timer
local function timer_6s()
  for i = 1, 1000000 do
    print("hello")
  end
end

local function main()
    station_cfg={}
    station_cfg.ssid="ssid"
    station_cfg.pwd="pwd"
    wifi.sta.config(station_cfg)    
    
    -- starting 6s timer to detect if code reach this level
    timer_6s()
end

main()