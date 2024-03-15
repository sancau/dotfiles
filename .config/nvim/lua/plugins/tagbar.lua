return {
    'majutsushi/tagbar',
    config = function() 
        vim.cmd("map <leader>t :TagbarToggle<CR>")
        vim.cmd("let g:tagbar_map_showproto = ''")
    end
}
