local wibox = require("wibox")
local gears = require "gears"
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local wbutton = require("ui.widgets.button")
local animation = require "modules.animation"

return function()
    local start_menu_icon = wibox.widget({
        markup = helpers.ui.colorize_text("S", beautiful.white),
        font = beautiful.icon_font .. "Round 14",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox
    })

    local battery = wibox.widget({
		start_menu_icon,
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(1),
	})

    local start_menu_widget = wibox.widget({
        layout = wibox.layout.horizontal,
        spacing = dpi(5),
    })

    local widget = wbutton.text.state({
		child = battery_widget,
		forced_width = dpi(60),
		forced_height = dpi(60),
		normal_bg = beautiful.one_bg3,
        hover_bg = beautiful.white,
		normal_shape = gears.shape.circle,
		font = beautiful.icon_font .. "Round ",
		size = 17,
		text = icon,
	})

    return widget
end