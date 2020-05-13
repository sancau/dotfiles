""""""""""""""""""""""""""""""""""""""
" Mappings
"
let mapleader="m"

nnoremap <leader>/ :nohlsearch<cr>
nnoremap Q <nop>

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
" Vim Plug Init
"
call plug#begin('~/.config/nvim/plugged')

""""""""""""""""""""""""""""""""""""""
" Appearence
"
Plug 'flazz/vim-colorschemes'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

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

let g:NERDTreeMapOpenExpl=''
let g:NERDTreeMapMenu='e'
let g:NERDTreeWinSize=35
let g:NERDTreeIgnore=['\.pyc$', '__pycache__']

nnoremap <silent> <expr> <leader>l g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

""""""""""""""""""""""""""""""""""""""
" Codi
"
let g:codi#width=100
let g:codi#rightsplit=1
let g:codi#rightalign=0
let g:codi#raw=1


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

map <C-s> :TagbarToggle<CR>
let g:tagbar_map_showproto = ''

""""""""""""""""""""""""""""""""""""""
" Vim Tmux Navigator
"
Plug 'christoomey/vim-tmux-navigator'

""""""""""""""""""""""""""""""""""""""
" PEP8 indentation for Python
"
Plug 'Vimjas/vim-python-pep8-indent'


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
" Jupyter Integration
"
"Plug 'jupyter-vim/jupyter-vim'

" Reset defaults
"let g:jupyter_mapkeys = 0

"nnoremap <leader>J :JupyterConnect <CR>
"nnoremap <leader>F :JupyterRunFile <CR>
"nnoremap <leader>e :JupyterSendCell <CR>
"vmap     <leader>e <Plug>JupyterRunVisual

"nnoremap <buffer> <silent> <leader>I :PythonImportThisFile<CR>
"nnoremap <buffer> <silent> <leader>E :JupyterSendRange<CR>
"" nmap     <buffer> <silent> <leader>e <Plug>JupyterRunTextObj


""""""""""""""""""""""""""""""""""""""
" Codi
"
Plug 'metakirby5/codi.vim'

""""""""""""""""""""""""""""""""""""""
" END OF PLUGINS
"
call plug#end()

""""""""""""""""""""""""""""""""""""""
" Generic

set t_Co=256
set background=dark

set encoding=utf-8
set colorcolumn=100

syntax enable
set nu rnu
set relativenumber
set clipboard=unnamedplus
set scrolloff=10

set hlsearch
set incsearch

set expandtab
set tabstop=4
set list listchars=tab:»·,trail:·

filetype plugin on
silent! colorscheme gruvbox
set laststatus=0
