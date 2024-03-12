""""""""""""""""""""""""""""""""""""""
" Mappings
"
let mapleader="m"

nnoremap <leader>/ :nohlsearch<cr>
nnoremap Q <nop>
nnoremap q <nop>

nnoremap <expr> j v:count == 1 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'

nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>wq :wq<CR>
"nnoremap <leader>b :Ex<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

""""""""""""""""""""""""""""""""""""""
" Generic
"
set t_Co=256
set background=dark

set encoding=utf-8
"set colorcolumn=100

syntax enable

set nu rnu
set relativenumber
set clipboard=unnamedplus
set scrolloff=0

set splitright

set hlsearch
set incsearch

set expandtab
set tabstop=4
set list listchars=tab:»·,trail:·

filetype plugin on
set laststatus=0

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3

"""""""""""""""""""""""""""""""""""""
" Plugins
"

call plug#begin('~/.config/nvim/plugged')

"""""""""""""""""""""""""""""""""""""
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <Space> <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1

"""""""""""""""""""""""""""""""""""""
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', {'tag': '0.1.5'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', {'do': 'make'}
Plug 'nvim-telescope/telescope-file-browser.nvim'

nnoremap <leader>f <cmd>Telescope find_files<CR>
nnoremap <leader>s <cmd>Telescope live_grep<CR>
nnoremap <leader>d <cmd>Telescope file_browser<CR>

"""""""""""""""""""""""""""""""""""""
Plug 'tpope/vim-fugitive'

nnoremap <leader>gs <cmd>Git status<CR>
nnoremap <leader>gd <cmd>Git diff<CR>
nnoremap <leader>gc <cmd>Git commit<CR>
nnoremap <leader>gaa <cmd>Git add --all<CR>
nnoremap <leader>gr <cmd>Git reset<CR>
nnoremap <leader>gp <cmd>Git pull --rebase<CR>

"""""""""""""""""""""""""""""""""""""
Plug 'ThePrimeagen/harpoon', {'branch': 'harpoon2'}

"""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdcommenter'

"""""""""""""""""""""""""""""""""""""
Plug 'karoliskoncevicius/distilled-vim'
Plug 'p00f/alabaster.nvim'

"""""""""""""""""""""""""""""""""""""
Plug 'majutsushi/tagbar'
map <leader>m :TagbarToggle<CR>
let g:tagbar_map_showproto = ''

"""""""""""""""""""""""""""""""""""""
Plug 'christoomey/vim-tmux-navigator'

"""""""""""""""""""""""""""""""""""""
Plug 'neovim/nvim-lspconfig'

call plug#end()

set termguicolors
colorscheme alabaster
"colorscheme distilled
:hi NonText guifg=bg

lua << EOF
local harpoon = require('harpoon')
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>a", function() toggle_telescope(harpoon: list()) end,
    { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>A", function() harpoon:list():append() end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "H", function() harpoon:list():prev() end)
vim.keymap.set("n", "L", function() harpoon:list():next() end)

local actions = require("telescope.actions")
require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous
            },
        },
    },
})

-- LSP CONFIG --
----------------
-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.rust_analyzer.setup {
  -- Server-specific settings. See `:help lspconfig-setup`
  settings = {
    ['rust-analyzer'] = {},
  },
}


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)

    -- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wl', function()
      -- print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    -- vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    -- vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    -- vim.keymap.set('n', '<space>f', function()
    --   vim.lsp.buf.format { async = true }
    -- end, opts)
  end,
})

EOF
