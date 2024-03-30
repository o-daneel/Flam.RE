-- makes a 6 sec timer
local function timer_6s()
    local my_timer = lv.timer.create_basic()

    -- 6s timer
    lv.timer.set_period(my_timer, 6000)
    lv.timer.ready(my_timer)
    
    -- -- starting
    lv.timer.enable(true)

    -- -- waiting for the end
    -- while not lv.timer.ready(my_timer) do
    --     print("wait")
    -- end 
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

local function new_anim()
    local obj = lv.anim.new()
end

local function new_animimg()
    local obj = lv.animimg.new()
end

local function new_arc()
    local obj = lv.arc.new()
end

local function new_area()
    local obj = lv.area.new()
end

local function new_bar()
    local obj = lv.bar.new()
end

local function new_btn()
    local obj = lv.btn.new()
end

local function new_canvas()
    local obj = lv.canvas.new()
end

local function new_checkbox()
    local obj = lv.checkbox.new()
end

local function new_color_filter_dsc()
    local obj = lv.color_filter_dsc.new()
end

local function new_coord_array()
    local obj = lv.coord_array.new()
end

local function new_dropdown()
    local obj = lv.dropdown.new()
end

local function new_group()
    local obj = lv.group.new()
end

local function new_img()
    local obj = lv.img.new()
end

local function new_img_src()
    local obj = lv.img_src.new()
end

local function new_label()
    local obj = lv.label.new()
end

local function new_line()
    local obj = lv.line.new()
end

local function new_list()
    local obj = lv.list.new()
end

local function new_menu()
    local obj = lv.menu.new()
end

local function new_menu_cont()
    local obj = lv.menu_cont.new()
end

local function new_menu_page()
    local obj = lv.menu_page.new()
end

local function new_menu_section()
    local obj = lv.menu_section.new()
end

local function new_menu_separator()
    local obj = lv.menu_separator.new()
end

local function new_obj()
    local obj = lv.obj.new()
end

local function new_qrcode()
    local obj = lv.qrcode.new()
end

local function new_roller()
    local obj = lv.roller.new()
end

local function new_slider()
    local obj = lv.slider.new()
end

local function new_spangroup()
    local obj = lv.spangroup.new()
end

local function new_spinner()
    local obj = lv.spinner.new()
end

local function new_style()
    local obj = lv.style.new()
end

local function new_style_prop_array()
    local obj = lv.style_prop_array.new()
end

local function new_style_transition_dsc()
    local obj = lv.style_transition_dsc.new()
end

local function new_switch()
    local obj = lv.switch.new()
end

local function new_table()
    local obj = lv.table.new()
end

local function new_textarea()
    local obj = lv.textarea.new()
end

local function new_timer()
    local obj = lv.timer.new()
end

local function main()
    local results = {}

    -- OK
    table.insert(results, "new_anim - " .. result(pcall(new_anim)))
    table.insert(results, "new_area - " .. result(pcall(new_area)))
    table.insert(results, "new_color_filter_dsc - " .. result(pcall(new_color_filter_dsc)))
    table.insert(results, "new_coord_array - " .. result(pcall(new_coord_array)))
    table.insert(results, "new_group - " .. result(pcall(new_group)))
    table.insert(results, "new_style - " .. result(pcall(new_style)))
    table.insert(results, "new_style_prop_array - " .. result(pcall(new_style_prop_array)))
    table.insert(results, "new_style_transition_dsc - " .. result(pcall(new_style_transition_dsc)))
    table.insert(results, "new_timer - " .. result(pcall(new_timer)))

    -- NOK
    table.insert(results, "new_animimg - " .. result(pcall(new_animimg)))
    table.insert(results, "new_arc - " .. result(pcall(new_arc)))
    table.insert(results, "new_bar - " .. result(pcall(new_bar)))
    table.insert(results, "new_btn - " .. result(pcall(new_btn)))
    table.insert(results, "new_canvas - " .. result(pcall(new_canvas)))
    table.insert(results, "new_checkbox - " .. result(pcall(new_checkbox)))
    table.insert(results, "new_dropdown - " .. result(pcall(new_dropdown)))
    table.insert(results, "new_img - " .. result(pcall(new_img)))
    table.insert(results, "new_keyboard - " .. result(pcall(new_keyboard)))
    table.insert(results, "new_label - " .. result(pcall(new_label)))
    -- 10
    table.insert(results, "new_line - " .. result(pcall(new_line)))
    table.insert(results, "new_list - " .. result(pcall(new_list)))
    table.insert(results, "new_menu - " .. result(pcall(new_menu)))
    table.insert(results, "new_menu_cont - " .. result(pcall(new_menu_cont)))
    table.insert(results, "new_menu_page - " .. result(pcall(new_menu_page)))
    table.insert(results, "new_menu_section - " .. result(pcall(new_menu_section)))
    table.insert(results, "new_menu_separator - " .. result(pcall(new_menu_separator)))
    table.insert(results, "new_obj - " .. result(pcall(new_obj)))
    table.insert(results, "new_qrcode - " .. result(pcall(new_qrcode)))
    table.insert(results, "new_roller - " .. result(pcall(new_roller)))
    -- 20
    table.insert(results, "new_slider - " .. result(pcall(new_slider)))
    table.insert(results, "new_spangroup - " .. result(pcall(new_spangroup)))
    table.insert(results, "new_spinner - " .. result(pcall(new_spinner)))
    table.insert(results, "new_switch - " .. result(pcall(new_switch)))
    table.insert(results, "new_table - " .. result(pcall(new_table)))
    table.insert(results, "new_textarea - " .. result(pcall(new_textarea)))

    progression.save("new_results", results)

    local timer_result= {}
    table.insert(timer_result, result(pcall(timer_6s)))
    progression.save("timer_result", timer_result)
end

main()
