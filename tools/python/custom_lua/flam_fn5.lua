-- makes a 6 sec timer
local function timer6s()
    print("Timer function called")

    for i = 1, 1000000 do
        print("hello")
    end
end

-- makes a 12 sec timer
local function timer12s()
    print("Timer function called")

    for i = 1, 2000000 do
        print("hello")
    end
end

 local function main()
    local animaux = {
        chien = "Max",
        chat = "Misty",
        oiseau = "Tweetie",
        poisson = "Nemo"
    }
    progression.save("animaux", animaux)
    progression.save("entier", {test = 5})
    local mon_nb = 5
    progression.save("var", {test = mon_nb})
    timer6s()
end

main()
