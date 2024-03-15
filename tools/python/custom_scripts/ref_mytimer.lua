local mytimer = {}

-- makes a 6 sec timer
function mytimer.timer()
    print("Timer function called")

    for i = 1, 1000000 do
        print("hello")
    end
end

mytimer.timer()
