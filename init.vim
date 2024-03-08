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
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
nnoremap <leader>f :Files <CR>
nnoremap <leader>s :Find <CR>

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
