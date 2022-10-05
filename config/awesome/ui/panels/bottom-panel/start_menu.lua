local gears = require "gears"
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wbutton = require("ui.widgets.button")
local icons = require "icons"

return function(s)

    local widget = wbutton.image.state({
		forced_width = dpi(43),
		normal_bg = beautiful.wibar_bg,
        hover_bg = beautiful.one_bg2,
		normal_shape = gears.shape.square,
		paddings = dpi(6),
		margins = dpi(6),
		stylesheet = "path { fill: #edeff0; }",
		image = icons.start_menu,
		on_release = function()
			awesome.emit_signal("central_panel::toggle", s)
		end
	})

    return widget
end