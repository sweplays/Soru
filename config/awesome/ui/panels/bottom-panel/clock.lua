local beautiful = require "beautiful"
local wibox = require "wibox"
local helpers = require "helpers"
local wbutton = require "ui.widgets.button"
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

return function(s)
    local accent_color = beautiful.white
    local clock = wibox.widget({
        screen = s,
        widget = wibox.widget.textclock,
        format = "%a%e %b |%l:%M %p",
        align = "center",
        valign = "center",
        font = beautiful.font_name .. "Medium 12"
    })

    clock.markup = helpers.ui.colorize_text(clock.text, accent_color)
    clock:connect_signal("widget::redraw_needed", function()
        clock.markup = helpers.ui.colorize_text(clock.text, accent_color)
    end)

    local widget = wbutton.elevated.state({
        child = clock,
        normal_bg = beautiful.wibar_bg,
        hover_bg = beautiful.one_bg2,
        margins = dpi(6),
        paddings = dpi(12)
    })

    return widget
end