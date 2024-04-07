local vim = vim

return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-neotest/neotest-python",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter"
    },
    config = function()
    local neotest = require("neotest")
        neotest.setup({
            adapters = {
                require("neotest-python")
            }
        })
        vim.keymap.set("n", "<leader>ts", function() neotest.summary.toggle() end)
        vim.keymap.set("n", "<leader>to", function() neotest.output_panel.toggle() end)
        vim.keymap.set("n", "<leader>tr", function() neotest.run.run(vim.fn.expand("%")) end)
        vim.keymap.set("n", "<leader>tw", function() neotest.watch.toggle(vim.fn.expand("%")) end)
    end
}
