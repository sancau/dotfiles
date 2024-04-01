local vim = vim

return {
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = {},
        build = ":UpdateRemotePlugins",
        init = function()
            -- these are examples, not defaults. Please see the readme
            -- vim.g.molten_image_provider = "image.nvim"
            vim.g.molten_output_win_max_height = 20
        end,
        config = function()
            vim.keymap.set("n", "<leader>ri", ":MoltenInit python3<CR>", { silent = true, desc = "Initialize the plugin" })
            vim.keymap.set("n", "<leader>rq", ":MoltenDeinit<CR>", { silent = true, desc = "Deinit Molten" })

            vim.keymap.set("n", "<leader>e", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
            vim.keymap.set("v", "<leader>e", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true, desc = "evaluate visual selection" })
            vim.keymap.set("n", "<leader>E", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })

            -- vim.keymap.set("n", "<leader>ro", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
            -- vim.keymap.set("n", "<leader>rr", ":MoltenRestart!<CR>", { silent = true, desc = "evaluate visual selection" })
        end,
    }
}
