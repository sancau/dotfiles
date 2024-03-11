local wezterm = require 'wezterm'
local config = {}

config.colors = {
    foreground = "#cecece",
    background = "#0e1415",
    cursor_bg = "#cd974b",
    cursor_border = "#cd974b",
    cursor_fg = "#0e1415",
    selection_bg = "#293334",
    selection_fg = "#cecece",

    ansi = {
        "#000000",
        "#d2322d",
        "#6abf40",
        "#cd974b",
        "#217EBC",
        "#9B3596",
        "#178F79",
        "#cecece"
    },

    brights = {
        "#333333",
        "#c33c33",
        "#95cb82",
        "#dfdf8e",
        "#71aed7",
        "#cc8bc9",
        "#47BEA9",
        "#ffffff"
    }
}

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.audible_bell = "Disabled"

return config
