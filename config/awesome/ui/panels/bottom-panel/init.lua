local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local widgets = require("ui.widgets")
local wbutton = require("ui.widgets.button")
local animation = require("modules.animation")
return function(s)

    --- Widgets
    --- ~~~~~~~
    s.start_menu = require "ui.panels.bottom-panel.start_menu"()

    --- Systray
	--- ~~~~~~~
	local function system_tray()
		local mysystray = wibox.widget.systray()
		mysystray.base_size = beautiful.systray_icon_size

		local widget = wibox.widget({
			widget = wibox.container.constraint,
			strategy = "max",
			width = dpi(0),
			{
				widget = wibox.container.margin,
				margins = dpi(10),
				mysystray,
			},
		})

		local system_tray_animation = animation:new({
			easing = animation.easing.linear,
			duration = 0.125,
			update = function(self, pos)
				widget.width = pos
			end,
		})

		local arrow = wbutton.text.state({
			text_normal_bg = beautiful.accent,
			normal_bg = beautiful.wibar_bg,
			font = beautiful.icon_font .. "Round ",
			size = 18,
			text = "",
			on_turn_on = function(self)
				system_tray_animation:set(400)
				self:set_text("")
			end,
			on_turn_off = function(self)
				system_tray_animation:set(0)
				self:set_text("")
			end,
		})

		return wibox.widget({
			layout = wibox.layout.fixed.horizontal,
			arrow,
			widget,
		})
	end

    s.bottom_panel = awful.popup({
        screen = s,
        type = "dock",
        maximum_height = beautiful.wibar_height,
        minimum_width = s.geometry.width,
        maximum_width = s.geometry.width,
        placement = function(c)
            awful.placement.bottom(c)
        end,
        bg = beautiful.transparent,
        widget = {
            {
				{
					s.start_menu,
					layout = wibox.layout.fixed.horizontal
				},
                left = dpi(10),
                right = dpi(10),
                widget = wibox.container.margin
            },
            bg = beautiful.wibar_bg,
            widget = wibox.container.background
        }
    })

    s.bottom_panel:struts({
        bottom = s.bottom_panel.maximum_height
    })

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
	awesome.connect_signal("widgets::splash::visibility", function(vis)
		screen.primary.bottom_panel.visible = not vis
	end)

	client.connect_signal("property::fullscreen", remove_bottom_panel)
	client.connect_signal("request::unmanage", add_bottom_panel)
end