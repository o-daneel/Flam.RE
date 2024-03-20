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

local function package_loaded()
    local loadedModules = {}
    for nomModule, valeur in pairs(package.loaded) do
        table.insert(loadedModules, nomModule)
    end

    progression.save("package_loaded", loadedModules)
end

local function all_globals()
    local foundGlobals = {}
    for nomModule, valeur in pairs(_G) do
        table.insert(foundGlobals, nomModule)
    end

    progression.save("all_globals", foundGlobals)
end


local function dump_string(f, var)
    local one_string = {}
    table.insert(one_string, var)

    progression.save(f, one_string)
end

local seen={}
local myTable={}

local function dump(t,i)
    seen[t]=true
    local s={}
    local n=0
    for k in pairs(t) do
        n=n+1 s[n]=k
    end
    table.sort(s)
    for k,v in ipairs(s) do
        table.insert(myTable, i..v)
        -- print(i,v)
        v=t[v]
        if type(v)=="table" and not seen[v] then
            dump(v,i.."\t")
        end
    end
end


local function globals_recurse()
    myTable={}
    dump(_G,"")
    progression.save("recurse_globals", myTable)
end

local function package_recurse()
    myTable={}
    dump(package,"")
    progression.save("recurse_package", myTable)
end

local function update_cpath()
    package.cpath = "/lib/lua/?.so;/lib/lua/loadall.so;./?.so"
    pcall(dump_string, "package_cpath2", package.cpath)
end

local function req_os()
    require("os")
    os.exit()
end

local function req_local()
    require("local")
end

local function test_io()
    local dst = io.open(".mdf")
end

local function test_file()
    local dst = file.open(".mdf")
end

local function lv_load(path)
    local src = lv.img_src.load(path)
    local image = lv.img.set_src(src)
end

local function path_exists(path)
    return lv.img_src.exists(path)
end

local function set_text()
    lv.label.set_text("TOTO", "test")
end

local function result(status, err)
    if status then
        return "success"
    else
        if err ~= nil then
            return err
        else
            return "failed"
        end
    end
end

local function main()
    local results = {}

    table.insert(results, result(pcall(package_loaded)))
    table.insert(results, result(pcall(all_globals)))
    
    table.insert(results, result(pcall(dump_string, "lua_version", _VERSION)))
    table.insert(results, result(pcall(dump_string, "package_path", package.path)))
    table.insert(results, result(pcall(dump_string, "package_config", package.config)))

    table.insert(results, result(pcall(dump_string, "package_cpath", package.cpath)))
    table.insert(results, result(pcall(update_cpath)))

    table.insert(results, result(pcall(globals_recurse)))
    table.insert(results, result(pcall(package_recurse)))
    
    table.insert(results, result(pcall(req_os)))
    table.insert(results, result(pcall(req_local)))
    
    
    table.insert(results, result(path_exists, "main.lua"))
    table.insert(results, result(path_exists, "main.lsf"))
    table.insert(results, result(path_exists, "local.lua"))
    table.insert(results, result(path_exists, "script/local.lua"))
    table.insert(results, result(path_exists, "./"))
    table.insert(results, result(path_exists, "/lib"))
    table.insert(results, result(path_exists, "/sd/.mdf"))
    table.insert(results, result(path_exists, "/sd0/.mdf"))

    table.insert(results, result(pcall(test_io)))
    table.insert(results, result(pcall(test_file)))
    
    table.insert(results, result(pcall(set_text)))
    table.insert(results, result(pcall(lv_load, "img/main.lif")))

    progression.save("all_results", results)
    timer6s()
end

main()
