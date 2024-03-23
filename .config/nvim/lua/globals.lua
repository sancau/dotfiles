local vim = vim

vim.cmd("let mapleader='m'")

vim.cmd("nnoremap <leader>/ :nohlsearch<cr>")
vim.cmd("nnoremap <F4> :%s/<c-r><c-w>/<c-r><c-w>/gc<c-f>$F/i")
vim.cmd("nnoremap <expr> j v:count == 1 ? 'gj' : 'j'")
vim.cmd("nnoremap <expr> k v:count == 0 ? 'gk' : 'k'")
vim.cmd("nnoremap <leader>q :q<CR>")
vim.cmd("nnoremap <leader>Q :q!<CR>")
vim.cmd("nnoremap <leader>w :w<CR>")
vim.cmd("nnoremap U :redo<CR>")
vim.cmd("nnoremap <C-J> <C-W><C-J>")
vim.cmd("nnoremap <C-K> <C-W><C-K>")
vim.cmd("nnoremap <C-L> <C-W><C-L>")
vim.cmd("nnoremap <C-H> <C-W><C-H>")
vim.cmd("tnoremap <leader><esc> <C-\\><C-n>")

vim.cmd("set t_Co=256")
vim.cmd("set background=dark")
vim.cmd("set encoding=utf-8")
vim.cmd("syntax enable")
vim.cmd("set nu rnu")
vim.cmd("set relativenumber")
vim.cmd("set clipboard=unnamedplus")
vim.cmd("set scrolloff=0")
vim.cmd("set noswapfile")
vim.cmd("set splitright")
vim.cmd("set hlsearch")
vim.cmd("set incsearch")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set list listchars=tab:»·,trail:·")

vim.cmd("filetype plugin on")
vim.cmd("set laststatus=0")
vim.cmd("set signcolumn=yes:1")

vim.cmd("let g:netrw_banner = 0")
vim.cmd("let g:netrw_liststyle = 3")
vim.cmd("let g:netrw_browse_split = 3")

vim.cmd("set termguicolors")

vim.keymap.set(
    "n",
    "<leader>g",
    ":!tmux new-window -n Git -c " .. vim.fn.getcwd() ..
    " -- lazygit --use-config-file=/home/sancau/.config/lazygit/config.yml," ..
    "/home/$USER/.config/lazygit/catppuccin/mocha/blue.yml <CR><CR>",
    {silent = true}
)

vim.keymap.set(
    "n",
    "<leader>d",
    ":!tmux new-window -n Docker -c " .. vim.fn.getcwd() ..
    " -- lazydocker" ..
    "<CR><CR>",
    {silent = true}
)

-- toggle diagnostics signs and inlines
vim.keymap.set(
    "n",
    "<leader>T",
    function()
         -- if this Neovim version supports checking if diagnostics are enabled
         -- then use that for the current state
         if vim.diagnostic.is_disabled then
             enabled = not vim.diagnostic.is_disabled()
         end

         enabled = not enabled

         if enabled then
             vim.diagnostic.enable()
         else
             vim.diagnostic.disable()
         end
    end
)
