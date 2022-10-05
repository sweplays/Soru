local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")
local gears = require("gears")
local icons = require("icons")
local config = require "config.config"

return function(s)
    s.central_panel = wibox({
		type = "dock",
		screen = s,
		height = dpi(700),
		width = dpi(700),
		bg = beautiful.transparent,
		ontop = true,
		visible = true,
		position = config.central_panel_placement,
        widget = {
            bg = beautiful.wibar_bg,
            widget = wibox.container.background
        }
	})

    awesome.connect_signal("central_panel::toggle", function(scr)
		if scr == s then
			s.central_panel.visible = not s.central_panel.visible
		end
	end)
end