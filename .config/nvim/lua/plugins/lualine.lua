local theme = require('lualine.themes.catppuccin')
-- Change the background of lualine_c section for normal mode
theme.normal.c.bg = '#1e1e2d'

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('lualine').setup({
          options = {
            icons_enabled = true,
            theme = theme,
            component_separators = { left = ' ', right = ' '},
            section_separators = { left = ' ', right = ' '},
            disabled_filetypes = {
              statusline = {},
              winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = true,
            refresh = {
              statusline = 1000,
              tabline = 1000,
              winbar = 1000,
            }
          },
          sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {'branch', 'filename', 'encoding', 'fileformat'},
            lualine_y = {},
            lualine_z = {}
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
          },
          tabline = {},
          winbar = {},
          inactive_winbar = {},
          extensions = {}
        })
    end
}
