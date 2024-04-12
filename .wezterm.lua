local wezterm = require 'wezterm'

local config = {}

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.audible_bell = "Disabled"
config.color_scheme = "Catppuccin Mocha"

config.default_prog = { 'wsl', '~', '-d', 'WS', '-u', 'sancau' }

return config