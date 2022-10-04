local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local wbutton = require("ui.widgets.button")

return function(s)
    local start_menu_icon = wibox.widget({
        markup = helpers.ui.colorize_text("S", beautiful.white),
        font = beautiful.icon_font .. "Round 14",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
    })
end