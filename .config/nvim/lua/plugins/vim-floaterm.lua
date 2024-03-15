return {
    'voldikss/vim-floaterm',
    config = function()
        vim.keymap.set(
            "n", "<leader>g",
            function()
                vim.cmd("FloatermNew --width=1.0 --height=1.0 lazygit --use-config-file=/home/sancau/.config/lazygit/config.yml,/home/$USER/.config/lazygit/catppuccin/mocha/blue.yml")
            end
        )
    end
}
