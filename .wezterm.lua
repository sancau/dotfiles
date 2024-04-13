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

config.window_close_confirmation = 'NeverPrompt'

-- icons are a bit smaller if using JetBrainsMono Nerd Font
-- but Toml icon rendering as expected
-- comment this block to compare and decide
local weight = 'Regular';
config.font = wezterm.font {
  family = 'JetBrainsMono Nerd Font',
  weight = weight,
  harfbuzz_features = { 'calt=1', 'clig=0', 'liga=0' },
}

config.default_prog = { 'wsl', '~', '-d', 'WS', '-u', 'sancau' }

return config