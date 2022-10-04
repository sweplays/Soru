local bottom_panel = require(... .. ".panels.bottom-panel")

local awful = require "awful"
awful.screen.connect_for_each_screen(function(screen)
    bottom_panel(screen)
end)