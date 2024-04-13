local wezterm = require 'wezterm'
local config = {}
local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window{}
  window:gui_window():toggle_fullscreen()
end)

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.audible_bell = "Disabled"
config.color_scheme = "Catppuccin Mocha"

config.default_prog = { 'wsl', '~', '-d', 'WS', '-u', 'sancau' }
config.window_close_confirmation = 'NeverPrompt'

return config