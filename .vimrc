""""""""""""""""""""""""""""""""""""""
" Mappings
"
let mapleader="m"

nnoremap <leader>/ :nohlsearch<cr>

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
" PLUGINS (via Vim Plug)
"
call plug#begin('~/.vim/plugged')

""""""""""""""""""""""""""""""""""""""
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

let g:NERDTreeMapOpenExpl = ''
let g:NERDTreeMapMenu = 'e'
let g:NERDTreeWinSizew = 25
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
let g:tagbar_map_showproto = ''

""""""""""""""""""""""""""""""""""""""
" Vim Tmux Navigator
"
Plug 'christoomey/vim-tmux-navigator'

""""""""""""""""""""""""""""""""""""""
" fzf & ripgrep
"
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" --column: Show column number
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

""""""""""""""""""""""""""""""""""""""
" NERDCommenter
"
Plug 'scrooloose/nerdcommenter'

""""""""""""""""""""""""""""""""""""""
" END OF PLUGINS
"
call plug#end()

""""""""""""""""""""""""""""""""""""""
" Generic
"
set encoding=utf-8
set cursorline
set colorcolumn=81

syntax on
set relativenumber

set hlsearch
set incsearch

set expandtab
set tabstop=4
set list listchars=tab:»·,trail:·

filetype plugin on

colorscheme gruvbox
