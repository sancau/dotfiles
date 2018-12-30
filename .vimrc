""""""""""""""""""""""""""""""""""""""
" Mappings
"
let mapleader="m"

nnoremap ` :/
nnoremap <leader>` :nohlsearch<cr>
noremap j gj
nnoremap k gk

nnoremap <leader>q :q<CR>
nnoremap <leader>fq :q!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>wq :wq<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

""""""""""""""""""""""""""""""""""""""
" PLUGINS (via Vim Plug)
"
call plug#begin('~/.vim/plugged')

"""""""""""""""""""""""""""""""""""""
" Color Schemes
"
Plug 'morhetz/gruvbox'
set background=dark

""""""""""""""""""""""""""""""""""""""
" Easy Motion
"
Plug 'easymotion/vim-easymotion'

let g:EasyMotion_do_mapping = 0 " Disable default mappings
map <Space> <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1

""""""""""""""""""""""""""""""""""""""
" NERD Tree
"
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

let g:NERDTreeMapMenu = 'e'
let g:NERDTreeWinSize=25
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeNodeDelimiter = "\u00a0"

map <C-n> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
"
Plug 'Valloric/YouCompleteMe'

nnoremap <leader>d :YcmCompleter GoTo<CR>

""""""""""""""""""""""""""""""""""""""
" Auto-Pairs
"
Plug 'jiangmiao/auto-pairs'

"""""""""""""""""""""""""""""""""""""""
" Tagbar
"
Plug 'majutsushi/tagbar'

map <C-b> :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""
" END OF PLUGINS
"
call plug#end()

""""""""""""""""""""""""""""""""""""""
" Generic
"
set encoding=utf-8

syntax on
set number

set hlsearch
set incsearch

set expandtab
set tabstop=4
set list listchars=tab:»·,trail:·

colorscheme gruvbox
