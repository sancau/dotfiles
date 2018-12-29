""""""""""""""""""""""""""""""""""""""
" Mappings 
"
let mapleader="m"

nnoremap <leader>/ :nohlsearch<cr>
nnoremap j gj
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
" PLUGGINS (via Vim Plug)
"
call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""""""""""""""
" Easy Motion
"
Plug 'easymotion/vim-easymotion'

let g:EasyMotion_do_mapping = 0 " Disable default mappings
map , <Plug>(easymotion-overwin-f2)
let g:EasyMotion_smartcase = 1

""""""""""""""""""""""""""""""""""""""
" END OF PLUGGINS
"
call plug#end()

""""""""""""""""""""""""""""""""""""""
" Generic
"
syntax off
set encoding=utf-8
set number

