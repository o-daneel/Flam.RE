local function ma_boucle()
  for i = 1, 1000000 do
    print("hello")
  end
end

local function main()
  pcall(ma_boucle)
end

main()