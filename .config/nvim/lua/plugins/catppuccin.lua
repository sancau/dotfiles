local vim = vim

return {
    'catppuccin/nvim',
    lazy = false,
    name = 'catppuccin',
    priority = 1000,
    config = function()
        local catppuccin = require("catppuccin")
        catppuccin.setup({
            custom_highlights = function(c)
                return {
                    TroubleText = { fg = c.text },
                    TroubleCount = { fg = c.yellow },
                    -- TroubleNormal = { fg = c.fg, bg = c.bg_sidebar },
                }
            end
        })
        vim.cmd.colorscheme "catppuccin"
    end
}
