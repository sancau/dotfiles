return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- local telescope = require('telescope')
            -- local actions = require('telescope.actions')
            -- telescope.setup({
            --     defaults = {
            --         mappings = {
            --             i = {
            --                 ["<esc>"] = actions.close,
            --                 ["<C-j>"] = actions.move_selection_next,
            --                 ["<C-k>"] = actions.move_selection_previous
            --             },
            --         },
            --     },
            -- })
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>f', builtin.find_files, {})
            vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'make',
    }
}
