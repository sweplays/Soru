local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local config = {}

config.taskbar_height             = dpi(55)
config.taskbar_placement          = "bottom"
config.central_panel_placement    = "bottom"


return config