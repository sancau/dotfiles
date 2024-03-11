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
nnoremap <leader>b :Ex<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap H gT
nnoremap L gt

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

"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
 "--line-number: Show line number
 "--no-heading: Do not show file headings in results
 "--fixed-strings: Search term as a literal string
 "--ignore-case: Case insensitive search
 "--no-ignore: Do not respect .gitignore, etc...
 "--hidden: Search hidden files and folders
 "--follow: Follow symlinks
 "--glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
 "--color: Search color options
"command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

nnoremap <leader>f <cmd>Telescope find_files<CR>
nnoremap <leader>s <cmd>Telescope live_grep<CR>
nnoremap <leader>b <cmd>Telescope file_browser<CR>

"""""""""""""""""""""""""""""""""""""
Plug 'ThePrimeagen/harpoon', {'branch': 'harpoon2'}

"""""""""""""""""""""""""""""""""""""
Plug 'scrooloose/nerdcommenter'

"""""""""""""""""""""""""""""""""""""
Plug 'karoliskoncevicius/distilled-vim'

"""""""""""""""""""""""""""""""""""""
Plug 'majutsushi/tagbar'
map <leader>m :TagbarToggle<CR>
let g:tagbar_map_showproto = ''

call plug#end()

colorscheme distilled
set termguicolors
:hi NonText guifg=bg

lua << EOF
local harpoon = require('harpoon')
harpoon:setup({})

vim.keymap.set("n", "<leader>d", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { desc = "Open harpoon window" })
vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)

vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
--vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
--vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
EOF
