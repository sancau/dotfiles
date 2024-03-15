return {
    'voldikss/vim-floaterm',
    config = function()
        vim.keymap.set(
            "n", "<leader>g",
            function()
                vim.cmd(
                    "FloatermNew --width=1.0 --height=1.0 --name=lazygit --title=─ --wintype=float " ..
                    "lazygit --use-config-file=/home/sancau/.config/lazygit/config.yml," ..
                    "/home/$USER/.config/lazygit/catppuccin/mocha/blue.yml"
                )
            end
        )
        vim.keymap.set(
            "n", "<leader>d",
            function()
                vim.cmd(
                    "FloatermNew --width=1.0 --height=1.0 --name=lazydocker --title=─ --wintype=float " ..
                    "lazydocker"
                )
            end
        )
    end
}
