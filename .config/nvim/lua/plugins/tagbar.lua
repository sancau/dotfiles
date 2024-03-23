local vim = vim

return {
    'majutsushi/tagbar',
    config = function()
        vim.cmd("map <leader>` :TagbarToggle<CR>")
        vim.cmd("let g:tagbar_map_showproto = ''")
    end
}
