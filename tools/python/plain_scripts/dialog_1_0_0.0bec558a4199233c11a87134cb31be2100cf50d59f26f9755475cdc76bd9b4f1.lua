--- This module il used to render a list with sound over, sound intro and image
--[[_AES_LOST_]]
--[[_AES_LOST_]]
--[[_AES_LOST_]] lvgl style rules
--[[_AES_LOST_]] xles
--[[_AES_LOST_]] = {}
--[[_AES_LOST_]]pointer on registered events for cleaning
--[[_AES_LOST_]]i.events = {}
--[[_AES_LOST_]]ylog.primaryButton = nil
--[[_AES_LOST_]]econdaryButton = nil
--[[_AES_LOST_]]ton = require("button")
--[[_AES_LOST_]]efault_btn_theme = require("button-theme-default")
--[[_AES_LOST_]] = nil
--[[_AES_LOST_]]ialog.initStyles()
--[[_AES_LOST_]]
--[[_AES_LOST_]]
--[[_AES_LOST_]]new()  
-- dialog.styles.parentContainer = lv.style.new()
--[[_AES_LOST_]] lv.style.set_bg_color(dialog.styles.parentContainer, lv.color.hex(0x000000))
--[[_AES_LOST_]] lv.style.set_bg_opa(dialog.styles.parentContainer, lv.OPA_COVER)
--[[_AES_LOST_]] lv.style.set_pad_top(dialog.styles.parentContainer, 7)
--[[_AES_LOST_]] lv.style.set_pad_right(dialog.styles.parentContainer, 35)
--[[_AES_LOST_]] lv.style.set_pad_bottom(dialog.styles.parentContainer, 37)
--[[_AES_LOST_]] lv.style.set_pad_left(dialog.styles.parentContainer, 35)
--[[_AES_LOST_]] dialog.styles.titleLabel = lv.style.new()
--[[_AES_LOST_]] lv.style.set_text_color(dialog.styles.titleLabel, lv.color.hex(0xFFFFFF))
--[[_AES_LOST_]]
--[[_AES_LOST_]] lv.style.set_text_font(dialog.styles.titleLabel, lv.font.nunito_bold_12)
--[[_AES_LOST_]] lv.style.set_text_align(dialog.styles.titleLabel, lv.text.TEXT_ALIGN_CENTER)
--[[_AES_LOST_]]ialog.styles.dialogMessage = lv.style.new()
-- dialog.styles.dialogMessage = lv.style.new()
--[[_AES_LOST_]] lv.style.set_text_color(dialog.styles.dialogMessage, lv.color.hex(0xFFFFFF))
--[[_AES_LOST_]] lv.style.set_text_font(dialog.styles.dialogMessage, lv.font.nunito_extrabold_16)
--[[_AES_LOST_]] lv.style.set_text_align(dialog.styles.dialogMessage, lv.text.TEXT_ALIGN_CENTER)
--[[_AES_LOST_]] ction dialog.clean(args)
-- function dialog.clean(args)
--[[_AES_LOST_]] container, event in pairs(dialog.events) do
-- for container, event in pairs(dialog.events) do
--[[_AES_LOST_]] lv.obj.remove_event_cb(container, event.clicked)
--[[_AES_LOST_]] if (dialog.primaryButton ~= nil) then
--[[_AES_LOST_]]  dialog.button.clean(dialog.primaryButton)
--[[_AES_LOST_]] end
--[[_AES_LOST_]] if (dialog.secondaryButton ~= nil) then
--[[_AES_LOST_]]  dialog.button.clean(dialog.secondaryButton)
--[[_AES_LOST_]] end
--[[_AES_LOST_]] lv.group.remove_all_objs(document)
--[[_AES_LOST_]]r.clean(window)
--[[_AES_LOST_]] dialog.events = {}
--[[_AES_LOST_]]img = nil
--[[_AES_LOST_]]unction dialog.create(args)
-- function dialog.create(args)
--[[_AES_LOST_]]
--[[_AES_LOST_]]ing(document, false)
--[[_AES_LOST_]]up.set_wrap(document, true)
--[[_AES_LOST_]]lv.group.remove_all_objs(document)
--[[_AES_LOST_]]lean(window)
--[[_AES_LOST_]] local parentContainer = require("v-container").create(window, 0, false)
--[[_AES_LOST_]] size(parentContainer, lv.obj.get_width(window), lv.obj.get_height(window))
--[[_AES_LOST_]] lv.obj.set_flex_align(parentContainer, lv.FLEX_ALIGN_CENTER, lv.FLEX_ALIGN_CENTER, lv.FLEX_ALIGN_CENTER)
--[[_AES_LOST_]] lv.obj.add_style(parentContainer, dialog.styles.parentContainer, lv.STATE_DEFAULT)
--[[_AES_LOST_]] img ~= nil) then
--[[_AES_LOST_]] mg ) lv.img.new(parentContainer)
--[[_AES_LOST_]] remove_style_all(img)
--[[_AES_LOST_]]
--[[_AES_LOST_]]
--[[_AES_LOST_]] lv.img.set_src(img, dialog.img)
--[[_AES_LOST_]]set_size(img, 58, 60)

--[[_AES_LOST_]] titleLabel = lv.label.new(parentContainer)
--[[_AES_LOST_]] lv.obj.remove_style_all(titleLabel)
--[[_AES_LOST_]] lv.label.set_text(titleLabel, args.title)
--[[_AES_LOST_]] lv.label.set_long_mode(titleLabel, lv.LABEL_LONG_WRAP)
--[[_AES_LOST_]] lv.obj.set_width(titleLabel, 205)
--[[_AES_LOST_]] lv.obj.add_style(titleLabel, dialog.styles.titleLabel, lv.STATE_DEFAULT)

--[[_AES_LOST_]] dialogMessage = lv.label.new(parentContainer)
--[[_AES_LOST_]] lv.obj.remove_style_all(dialogMessage)
--[[_AES_LOST_]] lv.label.set_text(dialogMessage, args.message)
--[[_AES_LOST_]] lv.label.set_long_mode(dialogMessage, lv.LABEL_LONG_WRAP)
--[[_AES_LOST_]] lv.obj.set_width(dialogMessage, 250)
--[[_AES_LOST_]] lv.obj.add_style(dialogMessage, dialog.styles.dialogMessage, lv.STATE_DEFAULT)
--[[_AES_LOST_]]
--[[_AES_LOST_]] local buttons_container = require("h-container").create(parentContainer, 12, false)
--[[_AES_LOST_]]???(buttons_container, lv.obj.get_width(window))
--[[_AES_LOST_]].set_height(buttons_container, 34)
--[[_AES_LOST_]] lv.obj.set_style_translate_y(buttons_container, 12, lv.STATE_DEFAULT)
--[[_AES_LOST_]] lv.obj.set_flex_align(buttons_container, lv.FLEX_ALIGN_CENTER, lv.FLEX_ALIGN_CENTER, lv.FLEX_ALIGN_CENTER)
--[[_AES_LOST_]] if (args.primary_button_text ~= nil) then
--[[_AES_LOST_]]   dialog.primaryButton = dialog.button.create(buttons_container, {text=args.primary_button_text, size="large", theme = dialog.default_btn_theme})
--[[_AES_LOST_]] if (args.primary_button_cb ~= nil) then
--[[_AES_LOST_]]dialog.events[dialog.primaryButton.button] = {}
--[[_AES_LOST_]]dialog.events[dialog.primaryButton.button].clicked = lv.obj.add_event_cb(dialog.primaryButton.button, function()
                                                                                         QxBn.button, function()   )
--[[_AES_LOST_]] args.primary_button_cb()
--[[_AES_LOST_]] end, lv.EVENT_CLICKED)
--[[_AES_LOST_]]end
--[[_AES_LOST_]] if (args.secondary_button_text ~= nil) then
--[[_AES_LOST_]] dialog.secondaryButton = dialog.button.create(buttons_container, {text=args.secondary_button_text, size="large", theme = dialog.default_btn_theme})
--[[_AES_LOST_]] if (args.secondary_button_cb ~= nil) then
--[[_AES_LOST_]]dialog.events[dialog.secondaryButton.button] = {}
--[[_AES_LOST_]]dialog.events[dialog.secondaryButton.button].clicked = lv.obj.add_event_cb(dialog.secondaryButton.button, function()
    QxBn.button, function()   )
--[[_AES_LOST_]] args.secondary_button_cb()
--[[_AES_LOST_]] end, lv.EVENT_CLICKED)
--[[_AES_LOST_]]end
--[[_AES_LOST_]]
--[[_AES_LOST_]]