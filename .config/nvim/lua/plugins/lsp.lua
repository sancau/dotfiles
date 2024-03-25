local vim = vim

local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and (
        vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        or
        vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col - 1, col - 1):match("%s") == nil
    )
end

local servers = { "lua_ls", "pyright" }

return {
    {
        "williamboman/mason.nvim",
        config = function()
            require('mason').setup({
                ensure_installed = {
                    'debugpy',
                    'mypy',
                    'ruff',
                }
            })
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
        'astral-sh/ruff-lsp',
    },
    {
        'microsoft/python-type-stubs',
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.ruff_lsp.setup({
                init_options = {
                    settings = {
                        -- Any extra CLI arguments for `ruff` go here.
                        args = {},
                    }
                }
            })

            local on_attach = function(client, bufnr)
                if client.name == 'ruff_lsp' then
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end

                local opts = {}
                vim.keymap.set({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', '<leader>lf', function()
                    vim.lsp.buf.format { async = true }
                end, opts)

                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format()
                            vim.lsp.buf.code_action({
                                context = { only = { "source.organizeImports" } },
                                apply = true,
                            })
                            vim.wait(100)
                        end,
                    })
                end
            end

            require('lspconfig').ruff_lsp.setup {
                on_attach = on_attach,
            }


            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup {
                    -- use Pyright only for GOTO stuff, use Ruff for formatting / linting, use mypy for type checking
                    settings = {
                        pyright = {
                            -- Using Ruff's import organizer
                            disableOrganizeImports = true,
                        },
                        python = {
                            analysis = {
                                -- autoSearchPaths = true,
                                -- diagnosticMode = 'openFilesOnly',
                                -- useLibraryCodeForTypes = true,
                                -- typeCheckingMode = 'on',
                                -- stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
                                -- Ignore all files for analysis to exclusively use Ruff for linting
                                ignore = { '*' },
                            },
                        },
                    },
                    on_attach = function(_, bufnr)
                        require "lsp_signature".on_attach({
                            bind = true, -- This is mandatory, otherwise border config won't get registered.
                            hint_enable = false,
                            floating_window = false,
                            toggle_key_flip_floatwin_setting = false, -- persistent floating window toggle
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
            vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, opts)
        end
    },
    {
        'nvimtools/none-ls.nvim',
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.mypy,
                }
            })
        end
    },
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            cmp.setup {
                completion = {
                    autocomplete = false
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    -- ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
                    -- ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
                    -- C-b (back) C-f (forward) for snippet placeholder navigation.
                    -- ['<C-Space>'] = cmp.mapping.complete(),
                    -- Make the TAB to work for "from a import " cases
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                },
            }
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
            vim.keymap.set({ 'i', 'n' }, '<C-w>', require('lsp_signature').toggle_float_win,
                { silent = true, noremap = true, desc = 'Toggle signature' })
        end
    },
    {
        "L3MON4D3/LuaSnip",
                    -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    {
        "saadparwaiz1/cmp_luasnip",
        config = function()
        end
    }
}
