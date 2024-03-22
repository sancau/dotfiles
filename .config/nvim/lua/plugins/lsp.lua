local vim = vim
local servers = { "lua_ls", "pyright" }

return {
    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = servers
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            for _, lsp in ipairs(servers) do
              lspconfig[lsp].setup {
               on_attach = function(_, bufnr)
               require "lsp_signature".on_attach({
                 bind = true, -- This is mandatory, otherwise border config won't get registered.
                 hint_enable = false,
                 floating_window = false,
                 toggle_key_flip_floatwin_setting = false,  -- persistent floating window toggle
                 doc_lines = 25,
               }, bufnr)
               end,
                capabilities = capabilities,
              }
            end

            local opts = {}
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
            vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        end
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
        end
    },
    {
        "hrsh7th/cmp-nvim-lsp",
        config = function()
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            vim.keymap.set('i', '<C-k>', require('lsp_signature').toggle_float_win, { silent = true, noremap = true, desc = 'Toggle signature' })
        end
    },
    -- {
    --     "saadparwaiz1/cmp_luasnip",
    --     config = function()
    --     end
    -- },
    -- {
    --     "saadparwaiz1/cmp_luasnip",
    --     config = function()
    --     end
    -- },
}

