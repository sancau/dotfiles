local vim = vim

return {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, _)
                    return vim.startswith(name, '.mypy') or vim.startswith(name, '__pycache') or vim.startswith(name, '.pytest') or vim.startswith(name, '.git')
                end,
            },
        })
        vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
}
