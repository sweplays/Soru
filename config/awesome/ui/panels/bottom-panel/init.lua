local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local icons = require "icons"
local gears = require "gears"
local config = require "config.config"
local ibutton = require "ui.widgets.button.image"

return function(s)

    --- Widgets
    --- ~~~~~~~
    s.start_menu = require "ui.panels.bottom-panel.start_menu"(s)
	s.clock = require "ui.panels.bottom-panel.clock"(s)
	s.battery = require "ui.panels.bottom-panel.battery"()
	s.network = require "ui.panels.bottom-panel.network"()

	s.bottom_panel = awful.wibar({
		screen = s,
		bg = beautiful.wibar_bg,
		width = s.geometry.width,
		height = config.taskbar_height,
		position = config.taskbar_placement,
		widget = {
			{
				{
					layout = wibox.layout.align.horizontal,
					expand = "none",
					s.clock,
					{
						s.start_menu,
						layout = wibox.layout.fixed.horizontal
					},
					{
						s.battery,
						s.network,
						layout = wibox.layout.fixed.horizontal
					},
				},
                widget = wibox.container.margin
            },
            bg = beautiful.wibar_bg,
            widget = wibox.container.background
		}
	})



	if config.taskbar_placement == "bottom" then
		
		s.bottom_panel:struts({
			bottom = s.bottom_panel.maximum_height
		})

	elseif config.taskbar_placement == "top" then

		s.bottom_panel:struts({
			top = s.bottom_panel.maximum_height
		})

	end

    --- Remove bottom_panel on full screen
	local function remove_bottom_panel(c)
		if c.fullscreen or c.maximized then
			c.screen.bottom_panel.visible = false
		else
			c.screen.bottom_panel.visible = true
		end
	end

	--- Remove bottom_panel on full screen
	local function add_bottom_panel(c)
		if c.fullscreen or c.maximized then
			c.screen.bottom_panel.visible = true
		end
	end

	--- Hide bar when a splash widget is visible
	--[[
	awesome.connect_signal("widgets::splash::visibility", function(vis)
		screen.primary.bottom_panel.visible = not vis
	end)
	]]

	client.connect_signal("property::fullscreen", remove_bottom_panel)
	client.connect_signal("request::unmanage", add_bottom_panel)
end