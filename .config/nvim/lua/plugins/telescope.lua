return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local telescope = require('telescope')
            -- local actions = require('telescope.actions')
            telescope.setup({
                defaults = {
                    -- mappings = {
                    --     i = {
                    --         ["<esc>"] = actions.close,
                    --         ["<C-j>"] = actions.move_selection_next,
                    --         ["<C-k>"] = actions.move_selection_previous
                    --     },
                    -- },
                    file_ignore_patterns = {
                        -- 'node_modules/',
                        -- 'venv/',
                        -- '.venv/',
                        '__pycache__/',
                        '.ipynb_checkpoints/',
                        '.git/'
                    }
                },
                pickers = {
                    live_grep = {
                        additional_args = function(opts)
                            return {"--hidden"}
                        end
                    },
                },
            })
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>f', function() builtin.find_files({hidden = true}) end, {})
            vim.keymap.set('n', '<leader>s', builtin.live_grep, {})
        end,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'make',
    }
}
